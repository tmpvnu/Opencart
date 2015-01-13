/*
 * This code is explained in detail in 
 * 
 * 
 */
package assistimport;

import com.itextpdf.text.Anchor;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chapter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Section;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Color;
import java.awt.Desktop;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.showMessageDialog;

import javax.swing.JTextArea;
import javax.swing.SwingWorker;
import javax.swing.Timer;

/**
 * Runs through all Holder.tables and create / modify them . Builds the entire
 * database
 *
 * @author Christo Goosen
 */
public class DoAnalyse extends SwingWorker<Integer, String> {

    private Map<String, String> member_data = new HashMap<String, String>();
    private static String memberType = "Member";
    private static int CurRefID = 0, ChildCount = 0, spouseCount = 0, extendedCount = 0;
    FileWriter fWriterInsert = null, CSVfileWriter = null, FaultReport = null;
    BufferedWriter writerInsert = null, writerCSV = null, writerFaultReport = null;
    static int errorFlag = 0;
    String[] errorDescription = null;
    static String currentLineforCSVReport = null;
    static int isValidRecord = 0;

    static String[] strGroupData = new String[10000];
    static String[] strErrorReason = new String[10000];
     static String[] strErrorReasonMember = new String[10000];
      static String[] strErrorReasonSpouse = new String[10000];
       static String[] strErrorReasonChild = new String[10000];
        static String[] strErrorReasonExtended = new String[10000];
         static String[] strErrorReasonBank= new String[10000];
  
    static int groupDataCount = 0;
    static int memberCount = 0, recordId = 0;
    static String ImportSWI = "I";
    static String InsepDateSelected = "";
    static int SuccessFlag = 0;
    int validRecordStatus = 0;

    private static void failIfInterrupted() throws InterruptedException {
        if (Thread.currentThread().isInterrupted()) {
            System.out.println("Interrupted while processing files\n");
            Application.getMessagesTextArea().append("----Interrupted while processing files----\n");
            Application.getMessagesTextArea().append("----Your application might not work----\n");
            throw new InterruptedException("Interrupted while processing files");
        }
    }

    /*   
     * DoAnalyse method
     *  @param  messagesTextArea, which is final JTextArea object
     */
    public DoAnalyse(final JTextArea messagesTextArea) {
        Holder.messagesTextArea = messagesTextArea;
    }

    @Override
    protected Integer doInBackground() throws Exception {
        // Main code to run here...============================================
        int matches = 0;

        final Random r = new Random();
        Timer timer = new Timer(100, new ActionListener() {
            public void actionPerformed(ActionEvent ae) {
                Color c = new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256), r.nextInt(256));
                Application.getMessagesTextArea().setBackground(c);

                Application.getMessagesTextArea().setForeground(Color.WHITE);
                Application.getMessagesTextArea().setFont(new Font("Serif", Font.ITALIC, 15));
            }

        });
        timer.start();

        publish("Started Anlysing and Importing CSV data ...");
        DoAnalyse.failIfInterrupted();

        ImportCSVFile();
        DoAnalyse.failIfInterrupted();

        if (SuccessFlag == 0) {
            showMessageDialog(null, "Import Process Completed Sucessfully.", "Import Process Completed Sucessfully.", 1);
            publish("Data saved successfullly.");

        } else {
            publish("Sorry! \n Process Cannot be Completed Successfully. \n Please refer the PDF document for more information. \n Thank You.");

        }

        DoAnalyse.failIfInterrupted();
        setProgress(100);
        timer.stop();

        return matches;
    }

    /**
     * Analyze and import CSV file.
     * <p>
     * This method is to import CSV file
     */
    public void ImportCSVFile() {

        //generate random name for files 
        java.util.Date date = new java.util.Date();

        String newFileName = date.toString().replace(" ", "_");
        newFileName = newFileName.replace(":", "-");
        Holder.csvFILE += newFileName + ".csv";
        Holder.FILE += newFileName + ".pdf";
        Holder.FaultReportFile += newFileName + ".pdf";

        System.out.println(newFileName);
        System.out.println(Application.jXIDatePicker.getDate().toString());

        Object[] dateSelected = Application.jXIDatePicker.getDate().toString().split(" ");
        // Object[] dateValue=date[3].toString().split("/");
        InsepDateSelected = dateSelected[5].toString() + "/" + getMonthValue(dateSelected[1].toString()) + "/" + dateSelected[2].toString();
        //  System.out.println(getMonthValue(dateSelected[1].toString())+" : "+dateSelected[2].toString()+" : "++" : "+Application.jXIDatePicker.getDate().toString());

        try {
            fWriterInsert = new FileWriter("DataToBeInserted.txt");
            CSVfileWriter = new FileWriter(Holder.csvFILE);
            writerInsert = new BufferedWriter(fWriterInsert);
            writerCSV = new BufferedWriter(CSVfileWriter);
            writeToCSVFile(Holder.faultReportCSVheader);

        } catch (IOException ex) {
            showMessageDialog(null, ex, ex.toString(), 1);
            Logger.getLogger(DoAnalyse.class.getName()).log(Level.SEVERE, null, ex);
        }


        /*
         * Intiating Database connection
         */
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Holder.conn = DriverManager.getConnection("jdbc:mysql://localhost/riskfin", Holder.user, Holder.pass);
            Holder.conn.setAutoCommit(false);
            Holder.stmt = Holder.conn.createStatement();
        } catch (Exception e) {
            showMessageDialog(null, e, e.toString(), 1);
            e.printStackTrace();
        }

        String rowData = "";
        String CurrentLine;
        String header = "";
        Object[] LineOfDatatoBeAnalysed;

        int rowCount = 1, colCount = 1;
        BufferedReader br = null;
        int count = 10;

        if (Holder.path_of_CSVfile != null) {

            /*
             * Initialization for Holder.document generation
             */
            try {
                //Original Data in PDf form
                Holder.document = new Document(PageSize.LETTER.rotate());

                PdfWriter.getInstance(Holder.document, new FileOutputStream(Holder.FILE));
                Holder.document.open();
                Holder.Report.addMetaData(Holder.document);
                Holder.Report.addTitlePage(Holder.document);
                //   Holder.table.setWidths(new int[]{ 1, 1, 1, 1,1,1 });
                Holder.table.setWidthPercentage(100);
                //   Holder.Report.addContent(Holder.document);

                //Fault report Starts here
                //Original Data in PDf form
                Holder.FaultReportPDFDoc = new Document(PageSize.LETTER.rotate());

                PdfWriter.getInstance(Holder.FaultReportPDFDoc, new FileOutputStream(Holder.FaultReportFile));
                Holder.FaultReportPDFDoc.open();
                Holder.FaultReport.addMetaData(Holder.FaultReportPDFDoc);
                Holder.FaultReport.addTitlePage(Holder.FaultReportPDFDoc);
                //   Holder.table.setWidths(new int[]{ 1, 1, 1, 1,1,1 });
                Holder.faltReporttable.setWidthPercentage(100);

                //MemNo,Id,Surname,Init,Ref No,Fault Description
                //heading of fault report
                PdfPCell FRC1 = new PdfPCell(new Phrase("MemNo"));
                FRC1.setHorizontalAlignment(Element.ALIGN_CENTER);
                Holder.faltReporttable.addCell(FRC1);
                PdfPCell FRC2 = new PdfPCell(new Phrase("Id"));
                FRC2.setHorizontalAlignment(Element.ALIGN_CENTER);
                Holder.faltReporttable.addCell(FRC2);
                PdfPCell FRC3 = new PdfPCell(new Phrase("Surname"));
                FRC3.setHorizontalAlignment(Element.ALIGN_CENTER);
                Holder.faltReporttable.addCell(FRC3);
                PdfPCell FRC4 = new PdfPCell(new Phrase("Initials"));
                FRC4.setHorizontalAlignment(Element.ALIGN_CENTER);
                Holder.faltReporttable.addCell(FRC4);
                PdfPCell FRC5 = new PdfPCell(new Phrase("Ref No"));
                FRC5.setHorizontalAlignment(Element.ALIGN_CENTER);
                Holder.faltReporttable.addCell(FRC5);

                PdfPCell FRC6 = new PdfPCell(new Phrase("Fault Description"));
                FRC6.setHorizontalAlignment(Element.ALIGN_CENTER);
                Holder.faltReporttable.addCell(FRC6);

                /*      //heading of fault report
                 PdfPCell FRD1 = new PdfPCell(new Phrase("MemNo"));
                 FRD1.setHorizontalAlignment(Element.ALIGN_CENTER);
                 Holder.faltReporttable.addCell(FRD1);
                 PdfPCell FRD2= new PdfPCell(new Phrase("Id"));
                 FRD2.setHorizontalAlignment(Element.ALIGN_CENTER);
                 Holder.faltReporttable.addCell(FRD2);
                 PdfPCell FRD3= new PdfPCell(new Phrase("Surname"));
                 FRD3.setHorizontalAlignment(Element.ALIGN_CENTER);
                 Holder.faltReporttable.addCell(FRD3);
                 PdfPCell FRD4= new PdfPCell(new Phrase("Initials"));
                 FRD4.setHorizontalAlignment(Element.ALIGN_CENTER);
                 Holder.faltReporttable.addCell(FRD4);
                 PdfPCell FRD5= new PdfPCell(new Phrase("Ref No"));
                 FRD5.setHorizontalAlignment(Element.ALIGN_CENTER);
                 Holder.faltReporttable.addCell(FRD5);
                    
                 PdfPCell FRD6= new PdfPCell(new Phrase("Fault Description"));
                 FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                 Holder.faltReporttable.addCell(FRD6);
                 */
            } catch (Exception e) {
                showMessageDialog(null, e, e.toString(), 1);
                e.printStackTrace();
            }

            FileWriter fWriter = null;
            BufferedWriter writer = null;
            try {
                br = new BufferedReader(new FileReader(Holder.path_of_CSVfile));
            } catch (FileNotFoundException ex) {
                showMessageDialog(null, ex, ex.toString(), 1);
                Logger.getLogger(Application.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                //reading first line from header
                header = br.readLine();
                Holder.arrayOfHeaderFields = header.split(",");
                Holder.columnNamesDB = Holder.columnNames.split(",");
                Object CurrentHeaderField;
                for (int i = 0; i < 30; i++) {
                    CurrentHeaderField = Holder.arrayOfHeaderFields[i].toString();
                    CurrentHeaderField = CurrentHeaderField.toString().replace("\"", "");
                    //Holder.table cell creation
                    PdfPCell c1 = new PdfPCell(new Phrase(CurrentHeaderField.toString()));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    Holder.table.addCell(c1);
                }
                Holder.table.setHeaderRows(1);
                if (header.equals(Holder.RiskfinCashUnderwrter_Export)) {
                    System.out.println("Cash -------" + header);
                    // Application.displayDialogueBox(header,"hai");
                }
                if (header.equals(Holder.RiskfinD_ORetail_Export)) {
                    System.out.println("Debit -------" + header);
                }
                Holder.curDBID = 0;
                memberCount = 0;

                //Invokes this function to get the last record Nr , this will be incremented in case of record to be added.
                setSerialNumberNr();

                while ((CurrentLine = br.readLine()) != null) {
                    validRecordStatus = 0;
                    
                    //Application.getMessagesTextArea().append(CurrentLine + "\n");
                    //publish(CurrentLine);
                    LineOfDatatoBeAnalysed = CurrentLine.split(",");
                    System.out.println(LineOfDatatoBeAnalysed.length);
                    int InsepDate = 0, BirthDate = 0;
                    if (LineOfDatatoBeAnalysed.length > 1) {

                        try {
                            memberType = null;
                            if (!doStartAnalysis(LineOfDatatoBeAnalysed)) {
                                errorFlag = 1;
                            }

                            System.out.println(Holder.sqlmember_db);

                            try {

                                //public static String columnNames = "Nr, Surname, FullName, Initials, H Adr1, H Adr2, H Adr3, P Adr1, P Adr2, P Adr3, P Kode, Tel H, Tel W, Tel C, Married, RefNr, Agentcode, Paymentmethod, BeginDate, CaptiorDate, EndDate, Reason, GroupLink, Sex, ID, ProductLink, WaitingPeriod, BirthDate, FullPremium, DuplID, LastPayment, ExtraFees, ChangeDate, EMail, BarCode, CreateUser, InsepDate, ImportSwi, ShortPayments, CommReceived, Medium, BranchNo, SyncHQ, SpecialProduct1, SpecialProduct2, SpecialProduct3, SyncBranch, SpecialProduct1Date, SpecialProduct2Date, SpecialProduct3Date, SpecialProduct1WP, SpecialProduct2WP, SpecialProduct3WP, MainPolicyNr, MainPolicyBranch, NickName, Source, Package_Id, OverridePrem, Memo";      
                            } catch (Exception e) {
                                showMessageDialog(null, e, e.toString(), 1);

                            }
                            
                            if(errorFlag==0)
                            {

                            if ("Member".equals(memberType)) {
                                validRecordStatus = isValidRecord;

                                memberCount++;

                                Holder.curDBID++;

                                DoAnalyse.failIfInterrupted();
                                Application.getMessagesTextArea().setBackground(Color.lightGray);
                                publish("\u2713 " + " ID : " + member_data.get("ID") + " Member Data Detected , Surname is " + member_data.get("Surname"));

                                String insertQuery = "\nINSERT INTO `member_db` (`Nr`,`Surname`,`FullName`,`Initials`,`H Adr1`,`H Adr2`,`H Adr3`,`P Adr1`,`P Adr2`,`P Adr3`,`P Kode`,`Tel H`,`Tel W`,`Tel C`,`Married`,`RefNr`,`Agentcode`,`Paymentmethod`,`BeginDate`,`CaptiorDate`,`EndDate`,`Reason`,`GroupLink`,`Sex`,`ID`,`ProductLink`,`WaitingPeriod`,`BirthDate`,`FullPremium`,`DuplID`,`LastPayment`,`ExtraFees`,`ChangeDate`,`EMail`,`BarCode`,`CreateUser`,`InsepDate`,`ImportSwi`,`ShortPayments`,`CommReceived`,`Medium`,`BranchNo`,`SyncHQ`,`SpecialProduct1`,`SpecialProduct2`,`SpecialProduct3`,`SyncBranch`,`SpecialProduct1Date`,`SpecialProduct2Date`,`SpecialProduct3Date`,`SpecialProduct1WP`,`SpecialProduct2WP`,`SpecialProduct3WP`,`MainPolicyNr`,`MainPolicyBranch`,`NickName`,`Source`,`Package_Id`,`OverridePrem`,`Memo`) VALUES"
                                        + " (" + Holder.curDBID + ",'" + member_data.get("Surname") + "',NULL,'" + member_data.get("Initials") + "',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'" + member_data.get("Married") + "','0','',0,0,0," + Holder.curDBID + ",NULL,0,'','" + member_data.get("ID") + "',0,0," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",'0',0,0,'0.00',0,NULL,NULL,'RS'," + getDateAsIntegerValue(InsepDateSelected) + ",'" + ImportSWI + "',NULL,NULL,NULL," + Holder.branchInfo[0].toString() + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,'0.00',NULL);";

                                strGroupData[groupDataCount] = insertQuery;
                               
                                CurRefID = Holder.curDBID;

                                String curCSV = Holder.curDBID + "," + member_data.get("Surname") + ",NULL," + member_data.get("Initials") + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," + member_data.get("Married") + ",0,,0,0,0," + Holder.curDBID + ",NULL,0,," + member_data.get("ID") + ",0,0," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",0,0,0,0.00,0,NULL,NULL,RS," + getDateAsIntegerValue(member_data.get("InsepDate")) + ",NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,0.00,NULL";
                                writeToCSVFile(curCSV);

                                //RECORIND FALTS IN A SEPARTE TABLE
                                //heading of fault report
                                PdfPCell FRD1 = new PdfPCell(new Phrase(Holder.curDBID));
                                FRD1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD1);
                                PdfPCell FRD2 = new PdfPCell(new Phrase(member_data.get("ID")));
                                FRD2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD2);
                                PdfPCell FRD3 = new PdfPCell(new Phrase(member_data.get("Surname")));
                                FRD3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD3);
                                PdfPCell FRD4 = new PdfPCell(new Phrase(member_data.get("Initials")));
                                FRD4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD4);
                                PdfPCell FRD5 = new PdfPCell(new Phrase("NULL"));
                                FRD5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD5);
                                PdfPCell FRD6 = new PdfPCell(new Phrase(strErrorReasonMember[groupDataCount]));
                                FRD6.setBackgroundColor(BaseColor.GREEN);
                                if (validRecordStatus == 1) {

                                    FRD6.setBackgroundColor(BaseColor.RED);
                                   // FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    // Holder.faltReporttable.addCell(FRD6);
                                }
                                FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD6);

                                setProgress(count + 1);

                                member_data.clear();
                            }
                            if ("Child".equals(memberType)) {
                                DoAnalyse.failIfInterrupted();

                                publish("\u2713 " + " ID : " + member_data.get("ID") + " Child Data Detected , Surname is " + member_data.get("Surname"));

                                String insertQuery = "\nINSERT INTO `children_db` (`Nr`,`Surname`,`Names`,`ID`,`CaptiorDate`,`BeginDate`,`EndDate`,`LinkID`,`BirthDate`,`ChangeDate`,`ImportSwi`,`Over21Confirm`,`WaitingPeriod`,`SpecialProduct1`,`SpecialProduct2`,`SpecialProduct3`,`SyncHQ`,`SyncBranch`,`BranchNo`,`SpecialProduct1Date`,`SpecialProduct2Date`,`SpecialProduct3Date`,`SpecialProduct1WP`,`SpecialProduct2WP`,`SpecialProduct3WP`,`NickName`,`KindofChild`,`Disabled`) VALUES "
                                        + " (" + (ChildCount + Holder.curDBID) + ",'" + member_data.get("Surname") + "',NULL,'" + member_data.get("ID") + "',20060504,20050101,0," + CurRefID + "," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",20090513,'" + ImportSWI + "',NULL,NULL,NULL,NULL,NULL,NULL,NULL," + Holder.branchInfo[0].toString() + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL);";

                                strGroupData[groupDataCount] += insertQuery;
                                ChildCount++;

                                String curCSV = (ChildCount + Holder.curDBID) + "," + member_data.get("Surname") + ",NULL," + member_data.get("Initials") + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," + member_data.get("Married") + ",0,,0,0,0," + Holder.curDBID + ",NULL,0,," + member_data.get("ID") + ",0,0," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",0,0,0,0.00,0,NULL,NULL,RS," + getDateAsIntegerValue(member_data.get("InsepDate")) + ",NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,0.00,NULL";
                                writeToCSVFile(curCSV);
                                setProgress(count + 1);
                                
                                //RECORIND FALTS IN A SEPARTE TABLE
                                //heading of fault report
                                PdfPCell FRD1 = new PdfPCell(new Phrase(Holder.curDBID));
                                FRD1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD1);
                                PdfPCell FRD2 = new PdfPCell(new Phrase(member_data.get("ID")));
                                FRD2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD2);
                                PdfPCell FRD3 = new PdfPCell(new Phrase(member_data.get("Surname")));
                                FRD3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD3);
                                PdfPCell FRD4 = new PdfPCell(new Phrase(member_data.get("Initials")));
                                FRD4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD4);
                                PdfPCell FRD5 = new PdfPCell(new Phrase("NULL"));
                                FRD5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD5);
                                PdfPCell FRD6 = new PdfPCell(new Phrase(strErrorReasonChild[groupDataCount]));
                                FRD6.setBackgroundColor(BaseColor.GREEN);
                                if (validRecordStatus == 1) {

                                    FRD6.setBackgroundColor(BaseColor.RED);
                                   // FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    // Holder.faltReporttable.addCell(FRD6);
                                }
                                FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD6);

                                member_data.clear();
                            }
                            if ("Spouse".equals(memberType)) {
                                DoAnalyse.failIfInterrupted();

                                publish("\u2713 " + " ID : " + member_data.get("ID") + " Spouse Data Detected , Surname is" + member_data.get("Surname"));

                                String insertQuery = "\nINSERT INTO `spouse_db` (`Nr`,`SSurname`,`SNames`,`SInitials`,`SID`,`SSex`,`LinkID`,`SCaptiorDate`,`SBeginDate`,`SBirthDate`,`SWaitingPeriod`,`SEndDate`,`SChangeDate`,`SImportSwi`,`SpecialProduct1`,`SpecialProduct2`,`SpecialProduct3`,`SSyncHQ`,`SSyncBranch`,`SBranchNo`,`SpecialProduct1Date`,`SpecialProduct2Date`,`SpecialProduct3Date`,`SpecialProduct1WP`,`SpecialProduct2WP`,`SpecialProduct3WP`,`SNickName`) VALUES "
                                        + " (" + (spouseCount + Holder.curDBID) + ",'" + member_data.get("Surname") + "',NULL,'" + member_data.get("Initials") + "','" + member_data.get("ID") + "','M'," + CurRefID + ",20060504,20050101," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",180,0,20090513,'" + ImportSWI + "',NULL,NULL,NULL,NULL,NULL," + Holder.branchInfo[0].toString() + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL);";

                                String curCSV = (spouseCount + Holder.curDBID) + "," + member_data.get("Surname") + ",NULL," + member_data.get("Initials") + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," + member_data.get("Married") + ",0,,0,0,0," + Holder.curDBID + ",NULL,0,," + member_data.get("ID") + ",0,0," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",0,0,0,0.00,0,NULL,NULL,RS," + getDateAsIntegerValue(member_data.get("InsepDate")) + "," + Holder.branchInfo[0].toString() + ",NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,0.00,NULL";
                                strGroupData[groupDataCount] += insertQuery;
                                spouseCount++;

                                writeToCSVFile(curCSV);
                                setProgress(count + 5);
                                
                                //RECORIND FALTS IN A SEPARTE TABLE
                                //heading of fault report
                                PdfPCell FRD1 = new PdfPCell(new Phrase(Holder.curDBID));
                                FRD1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD1);
                                PdfPCell FRD2 = new PdfPCell(new Phrase(member_data.get("ID")));
                                FRD2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD2);
                                PdfPCell FRD3 = new PdfPCell(new Phrase(member_data.get("Surname")));
                                FRD3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD3);
                                PdfPCell FRD4 = new PdfPCell(new Phrase(member_data.get("Initials")));
                                FRD4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD4);
                                PdfPCell FRD5 = new PdfPCell(new Phrase("NULL"));
                                FRD5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD5);
                                PdfPCell FRD6 = new PdfPCell(new Phrase(strErrorReasonSpouse[groupDataCount]));
                                FRD6.setBackgroundColor(BaseColor.GREEN);
                                if (validRecordStatus == 1) {

                                    FRD6.setBackgroundColor(BaseColor.RED);
                                   // FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    // Holder.faltReporttable.addCell(FRD6);
                                }
                                FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD6);

                                member_data.clear();
                            }

                            if ("Extended".equals(memberType)) {
                                DoAnalyse.failIfInterrupted();

                                publish("\u2713 " + " ID : " + member_data.get("ID") + " Extended Data Detected , Surname is" + member_data.get("Surname"));

                                String insertQuery = "\nINSERT INTO `extended_db` (`Nr`,`Surname`,`Names`,`Initials`,`ID`,`Premium`,`BeginDate`,`CaptiorDate`,`LinkID`,`BirthDate`,`EndDate`,`WaitingPeriod`,`ProductLink`,`ChangeDate`,`ImportSwi`,`SpecialProduct1`,`SpecialProduct2`,`SpecialProduct3`,`IncludedPremium`,`SyncHQ`,`SyncBranch`,`BranchNo`,`SpecialProduct1Date`,`SpecialProduct2Date`,`SpecialProduct3Date`,`SpecialProduct1WP`,`SpecialProduct2WP`,`SpecialProduct3WP`,`NickName`,`Package_Id`,`UpgradeNo`) VALUES  "
                                        + "(" + (extendedCount + Holder.curDBID) + ",'" + member_data.get("Surname") + "',NULL,'" + member_data.get("Initials") + " ','" + member_data.get("ID") + " ',NULL,20050101,20060504," + CurRefID + "," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",0,0,649,NULL,'" + ImportSWI + "',NULL,NULL,NULL,NULL,NULL," + Holder.branchInfo[0].toString() + ",0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0);";
                                String curCSV = (extendedCount + Holder.curDBID) + "," + member_data.get("Surname") + ",NULL," + member_data.get("Initials") + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," + member_data.get("Married") + ",0,,0,0,0," + Holder.curDBID + ",NULL,0,," + member_data.get("ID") + ",0,0," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",0,0,0,0.00,0,NULL,NULL,RS," + getDateAsIntegerValue(member_data.get("InsepDate")) + "," + Holder.branchInfo[0].toString() + ",NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,0.00,NULL";
                                strGroupData[groupDataCount] += insertQuery;
                                extendedCount++;
                                writeToCSVFile(curCSV);
                                setProgress(count + 5);
                                
                                //RECORIND FALTS IN A SEPARTE TABLE
                                //heading of fault report
                                PdfPCell FRD1 = new PdfPCell(new Phrase(Holder.curDBID));
                                FRD1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD1);
                                PdfPCell FRD2 = new PdfPCell(new Phrase(member_data.get("ID")));
                                FRD2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD2);
                                PdfPCell FRD3 = new PdfPCell(new Phrase(member_data.get("Surname")));
                                FRD3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD3);
                                PdfPCell FRD4 = new PdfPCell(new Phrase(member_data.get("Initials")));
                                FRD4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD4);
                                PdfPCell FRD5 = new PdfPCell(new Phrase("NULL"));
                                FRD5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD5);
                                PdfPCell FRD6 = new PdfPCell(new Phrase(strErrorReasonExtended[groupDataCount]));
                                FRD6.setBackgroundColor(BaseColor.GREEN);
                                if (validRecordStatus == 1) {

                                    FRD6.setBackgroundColor(BaseColor.RED);
                                   // FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    // Holder.faltReporttable.addCell(FRD6);
                                }
                                FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD6);

                                member_data.clear();
                            }

                            if ("Bank".equals(memberType)) {
                                DoAnalyse.failIfInterrupted();
                                publish("\u2713 " + " ID : " + member_data.get("ID") + " Bank Data Detected , Bank Name is" + member_data.get("Surname"));

                                String insertQuery = "\nINSERT INTO `bank_db` (`Nr`, `BankName`, `BranchName`, `BranchCode`, `AccountNo`, `AccountHolderName`, `TypeAccount`, `DeductionDate`,`LinkID`, `LinkType`, `BranchNo`, `OldSwitch`, `TimePeriod`) VALUES ("
                                        + Holder.curDBID + ",'" + member_data.get("Initials") + "','" + member_data.get("Surname") + "', NULL,'" + member_data.get("ID") + "',NULL, 1, 0," + Holder.curDBID + ", 'M'," + Holder.branchInfo[0].toString() + ", NULL, 0);";

                                String curCSV = Holder.curDBID + "," + member_data.get("Surname") + ",NULL," + member_data.get("Initials") + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," + member_data.get("Married") + ",0,,0,0,0," + Holder.curDBID + ",NULL,0,," + member_data.get("ID") + ",0,0," + getDateAsIntegerValue(member_data.get("BirthDate")) + ",0,0,0,0.00,0,NULL,NULL,RS," + getDateAsIntegerValue(member_data.get("InsepDate")) + ",NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,0.00,NULL";
                                strGroupData[groupDataCount] += insertQuery;
                                writeToCSVFile(curCSV);
                                setProgress(count + 1);
                                
                                //RECORIND FALTS IN A SEPARTE TABLE
                                //heading of fault report
                                PdfPCell FRD1 = new PdfPCell(new Phrase(Holder.curDBID));
                                FRD1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD1);
                                PdfPCell FRD2 = new PdfPCell(new Phrase(member_data.get("ID")));
                                FRD2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD2);
                                PdfPCell FRD3 = new PdfPCell(new Phrase(member_data.get("Surname")));
                                FRD3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD3);
                                PdfPCell FRD4 = new PdfPCell(new Phrase(member_data.get("Initials")));
                                FRD4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD4);
                                PdfPCell FRD5 = new PdfPCell(new Phrase("NULL"));
                                FRD5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD5);
                                PdfPCell FRD6 = new PdfPCell(new Phrase(strErrorReasonBank[groupDataCount]));
                                FRD6.setBackgroundColor(BaseColor.GREEN);
                                if (validRecordStatus == 1) {

                                    FRD6.setBackgroundColor(BaseColor.RED);
                                   // FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    // Holder.faltReporttable.addCell(FRD6);
                                }
                                FRD6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                Holder.faltReporttable.addCell(FRD6);

                                member_data.clear();
                            }
                            }

                        } catch (InterruptedException ex) {
                            showMessageDialog(null, ex, ex.toString(), 1);

                            Logger.getLogger(DoAnalyse.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }

                }

                if (isValidRecord != 0) {
                    SuccessFlag = 1;
                    //   System.out.println(strErrorReason[groupDataCount]);
                    showMessageDialog(null, "Import process Not Success  \n some of the records may have errors in it \n Please refer the PDF document for Further details.", "Import process Not Success ", 1);

                } else {
                    int dialogResult = JOptionPane.showConfirmDialog(null, "Do you want to save ?" + strGroupData, "Warning", JOptionPane.YES_NO_OPTION);
                    if (dialogResult == JOptionPane.YES_OPTION) {
                        try {

                            for (int j = 1; j <= memberCount; j++) {
                                if (!strGroupData[j].toString().isEmpty()) {
                                    Object[] splitQueries = strGroupData[j].split("\n");
                                    //showMessageDialog(null, strGroupData[j].toString(), strGroupData[j].toString(), 1);

                                    for (int i = 0; i < splitQueries.length; i++) {
                                        if (!splitQueries[i].toString().isEmpty()) {
                                            System.out.println(splitQueries[i].toString());
                                            Holder.stmt.addBatch(splitQueries[i].toString());
                                            // Holder.stmt.executeUpdate(splitQueries[i].toString());
                                        }

                                    }
                                }
                            }
                            Holder.stmt.executeBatch();
                            Holder.conn.commit();

                        } catch (SQLException ex) {

                            //  showMessageDialog(null, "Sorry! \n Process Cannot be Completed Successfully.\n " + ex, "Sorry! \n Process Cannot be Completed Successfully.\n " + ex.toString(), 1);
                            Logger.getLogger(DoAnalyse.class.getName()).log(Level.SEVERE, null, ex);
                            SuccessFlag = 1;

                        }

                    }

                }

                try {
                    Holder.document.add(Holder.table);
                    Holder.FaultReportPDFDoc.add(Holder.faltReporttable);
                    writerInsert.close();
                    writerCSV.close();
                } catch (DocumentException ex) {
                    showMessageDialog(null, ex, ex.toString(), 1);

                    Logger.getLogger(DoAnalyse.class.getName()).log(Level.SEVERE, null, ex);
                }
                Holder.document.close();
                Holder.FaultReportPDFDoc.close();

            } catch (IOException ex) {
                showMessageDialog(null, ex, ex.toString(), 1);

                Logger.getLogger(Application.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            showMessageDialog(null, "Select File", "Select File To import", 1);
            //  return;
        }

    }

    /**
     * Saves Data to a CSV file.
     * <p>
     * This method is to save data to a CSV file
     *
     * @param DataToInsert, the line of data to be written to file
     * @return integer , return an integer value
     */
    public int writeToCSVFile(String DataToInsert) {

        try {

            writerCSV.write(DataToInsert);
            writerCSV.newLine();

        } catch (IOException ex) {
            showMessageDialog(null, ex, ex.toString(), 1);
            Logger.getLogger(DoAnalyse.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 1;
    }

    /**
     * Method to Start data Analysis.
     * <p>
     * This method Method can be used to Start data Analysis
     *
     * @param LineOfDatatoBeAnalysed the line of data extracted from CSV file
     * @return boolean, Returns either true or false values
     *
     */
    public boolean doStartAnalysis(Object[] LineOfDatatoBeAnalysed) {

        Object CurrentValue = null, CurrentHeaderField;
        System.out.println(LineOfDatatoBeAnalysed.length);

        // The column number 8 is the Relation column , which can be Member, Spouse or Child
        try {
            if (LineOfDatatoBeAnalysed[7].toString().isEmpty()) {
                CurrentValue = "NULL";
            } else {

                CurrentValue = LineOfDatatoBeAnalysed[7];
                CurrentValue = CurrentValue.toString().replace("\"", "");
            }
        } catch (Exception e) {
            CurrentValue = "NULL";
        }

        if ("Member".equals(CurrentValue.toString())) {

            memberType = "Member";
            groupDataCount++;

            // doAnalyseAndStoreMainMemberData(LineOfDatatoBeAnalysed);
        } else if ("Spouse".equals(CurrentValue.toString())) {
            memberType = "Spouse";
            // doAnalyseAndStoreSpouseMemberData(LineOfDatatoBeAnalysed);
        } else if ("Child".equals(CurrentValue.toString())) {
            memberType = "Child";
            // doAnalyseAndStoreChildrenMemberData(LineOfDatatoBeAnalysed);
        } else if ("Extended".equals(CurrentValue.toString())) {
            memberType = "Extended";
            //  doAnalyseAndStoreExtendedMemberData(LineOfDatatoBeAnalysed);
        } else if ("Bank".equals(CurrentValue.toString())) {
            memberType = "Bank";
            // doAnalyseAndStoreBankData(LineOfDatatoBeAnalysed);
        } else {
            memberType = "UnKnown";
        }

        if (!"UnKnown".equals(memberType)) {
            doAnalyseMemberData(LineOfDatatoBeAnalysed);
        }

        return true;

    }

    /**
     * doAnalyseMemberData method is the one which analyze each and every line
     * of data from the CSV file to be imported.
     * <p>
     * This method is to extract each and every values and invokes respective
     * validation function for validating it.
     *
     * @param LineOfDatatoBeAnalysed, the line of data to be written to file
     *
     */
    public void doAnalyseMemberData(Object[] LineOfDatatoBeAnalysed) {

        Object CurrentValue = null, CurrentHeaderField, CurrentDBColmn;
        System.out.println(LineOfDatatoBeAnalysed.length);

        for (int i = 0; i < 30; i++) {

            CurrentHeaderField = Holder.arrayOfHeaderFields[i].toString();
            CurrentHeaderField = CurrentHeaderField.toString().replace("\"", "");

            try {
                if (LineOfDatatoBeAnalysed[i].toString().isEmpty()) {
                    CurrentValue = "NULL";
                } else {

                    CurrentValue = LineOfDatatoBeAnalysed[i];

                    CurrentValue = CurrentValue.toString().replace("\"", "");

                }
            } catch (Exception e) {
                CurrentValue = "NULL";
                //  showMessageDialog(null, e, e.toString(), 1);
            }

            //Intialise the colors for cells
            PdfPCell c1 = new PdfPCell(new Phrase(CurrentValue.toString()));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            //  c1.setBackgroundColor(BaseColor.GRAY);

            if (doSwitchtheCurrentValue(CurrentHeaderField.toString(), CurrentValue.toString())) {
                //  c1.setBackgroundColor(BaseColor.GREEN);

            } else {
                c1.setBackgroundColor(BaseColor.RED);
            }

            //   System.out.println("SURNA<A"+getDBColumnName(CurrentHeaderField.toString().trim()));
            member_data.put(getDBColumnName(CurrentHeaderField.toString().trim()), CurrentValue.toString());

            Holder.table.addCell(c1);

        }

    }

    /**
     * setSerialNumberNr is to identify the maximum of the serial number from
     * the database table.
     * <p>
     * This method is to is to identify the maximum of the serial number from
     * the database table.
     *
     */
    public void setSerialNumberNr() {
        try {
            String sql = "SELECT MAX(Nr) from member_db";
            ResultSet rs = Holder.stmt.executeQuery(sql);
            rs.next();
            int max = rs.getInt(1);
            if (max > 0) {
                Holder.curDBID = max;
            } else {
                Holder.curDBID = 1;
            }
            System.out.println("VFSVINU" + Holder.curDBID);
            rs.close();

        } catch (Exception e) {
            showMessageDialog(null, e, e.toString(), 1);
        }
    }

    /**
     * getMonthValue
     * <p>
     * This method is to get the integer value corresponding to the name of the
     * month.
     *
     * @param Month, the name of the month
     * @return int, return an integer value
     */
    public int getMonthValue(String Month) {
        int retValue = 0;
        switch (Month) {
            case "Jan":
                retValue = 1;
                break;
            case "Feb":
                retValue = 2;
                break;
            case "Mar":
                retValue = 3;
                break;
            case "Apr":
                retValue = 4;
                break;
            case "May":
                retValue = 5;
                break;
            case "Jun":
                retValue = 6;
                break;
            case "Jul":
                retValue = 7;
                break;
            case "Aug":
                retValue = 8;
                break;
            case "Sep":
                retValue = 9;
                break;
            case "Oct":
                retValue = 10;
                break;
            case "Nov":
                retValue = 11;
                break;
            case "Dec":
                retValue = 12;
                break;
            default:
                retValue = 0;

        }
        return retValue;
    }

    /**
     * getDateAsIntegerValue
     * <p>
     * This method is to convert Date in String format to Integer format.
     *
     * @param strDate, the date in String format
     * @return int, returns an integer value
     */
    public int getDateAsIntegerValue(String strDate) {
        int Value;
        try {
            // Convert string to date
            String dateToBeParsed = strDate.replace("/", "").trim();
            int inputDate = Integer.parseInt(dateToBeParsed);
            DateFormat df = new SimpleDateFormat("yyyyMMdd");
            Date dateOld = df.parse(String.valueOf(inputDate));

            //   System.out.println(dateOld);
            //Convert date to Integer
            String s = df.format(dateOld);
            Value = Integer.valueOf(s);
            System.out.println(Value);
            return Value;
        } catch (Exception e) {

            return 0;
        }
    }

    /**
     * getDBColumnName.
     * <p>
     * This Method can be used to get the original column names used in the
     * database. not.
     *
     * @param curValue the value extracted from CSV file.
     * @return String, Returns original column names.
     *
     */
    public String getDBColumnName(String curValue) {
        if ("No".equals(curValue)) {
            return "Nr";
        }
        if ("Surname".equals(curValue)) {
            return "Surname";
        }
        if ("Mem No".equals(curValue)) {
            return "ID";
        }

        if ("Inception Date".equals(curValue)) {
            return "InsepDate";
        }
       // public static String RiskfinD_ORetail_Export = "\"No\",\"Mem No\",\"Ref No\",\"Initials\",\"Surname\",\"ID\",\"Birth Date\",\"Rel\",\"Coverage\",\"Premium\",\"Additional Premium\",\"Additional Cover\",\"Product Description\",\"SP1 Description\",\"SP1 Premium\",\"SP2 Description\",\"SP2 Premium\",\"SP3 Description\",\"SP3 Premium\",\"Last Payment\",\"Inception Date\",\"Transaction Date\",\"Effective Date\",\"Age\",\"Married\",\"Cancel Date\",\"C/R\",\"Agent Code\",\"Extra Fees\",\"IncludedPremium\"";

        //public static String columnNames = "Nr, Surname, FullName, Initials, H Adr1, H Adr2, H Adr3, P Adr1, P Adr2, P Adr3, P Kode, Tel H, Tel W, Tel C, Married, RefNr, Agentcode, Paymentmethod, BeginDate, CaptiorDate, EndDate, Reason, GroupLink, Sex, ID, ProductLink, WaitingPeriod, BirthDate, FullPremium, DuplID, LastPayment, ExtraFees, ChangeDate, EMail, BarCode, CreateUser, InsepDate, ImportSwi, ShortPayments, CommReceived, Medium, BranchNo, SyncHQ, SpecialProduct1, SpecialProduct2, SpecialProduct3, SyncBranch, SpecialProduct1Date, SpecialProduct2Date, SpecialProduct3Date, SpecialProduct1WP, SpecialProduct2WP, SpecialProduct3WP, MainPolicyNr, MainPolicyBranch, NickName, Source, Package_Id, OverridePrem, Memo";  
        if ("Ref No".equals(curValue)) {
            return "RefNr";
        }
        if ("Initials".equals(curValue)) {
            return "Initials";
        }

        if ("ID".equals(curValue)) {
            return "ID";
        }

        if ("Birth Date".equals(curValue)) {
            return "BirthDate";
        }
        if ("Rel".equals(curValue)) {
            return "Rel";
        }
        if ("Premium".equals(curValue)) {
            return "FullPremium";
        }

        if ("Married".equals(curValue)) {
            return "Married";
        }

        return "";
    }

   
    /**
     * Switching the current value for data analysis .
     * <p>
     * This Method can be used to Switch the current value for data analysis
     *
     * @param Field the name of field name extracted from CSV file
     * @param Value the line of data value extracted from CSV file
     * @return boolean, Returns either true or false values
     *
     */
    public boolean doSwitchtheCurrentValue(String Field, String Value) {
        int errorFlag = 0;

        switch (Field) {
            case "Inception Date":
                if (!ValidateInceptionDate(Value)) {
                   
                    setErrorMessage( "\n" + memberType + " Invalid Inception Date;");

                    errorFlag = 1;
                }
                break;
            case "ID":
                System.out.println("ID " + Value);
                if (Value == null) {
                    errorFlag = 1;
                }
                if (!ValidateID(Value)) {
                    //strErrorReason[groupDataCount] += "\n" + memberType + " Invalid ID;";
                     setErrorMessage( "\n" + memberType + " Invalid ID");

                    errorFlag = 1;
                }
                if (!isIDExixts(Value)) {
                   // strErrorReason[groupDataCount] += "\n" + memberType + " ID exists;";
                     setErrorMessage( "\n" + memberType + " ID exists");
                    errorFlag = 1;
                }

                break;

            case "Birth Date":
                if (!ValidateBirthDate(Value)) {
                   // strErrorReason[groupDataCount] += "\n" + memberType + "Invalid  Birth Date;";
                    setErrorMessage("\n" + memberType + " ID exists");
                 

                    errorFlag = 1;
                }
                break;

        }

        if (errorFlag == 1) {
            isValidRecord = 1;
            validRecordStatus = 1;
            return false;

        }

        return true;

    }
    
    public void setErrorMessage(String Message)
    {
          if ("Member".equals(memberType)) {

            strErrorReason[groupDataCount] =Message;
             strErrorReasonMember[groupDataCount] +=Message;

           
        } else if ("Spouse".equals(memberType)) {
            strErrorReasonSpouse[groupDataCount] =Message;
        } else if ("Child".equals(memberType)) {
            strErrorReasonChild[groupDataCount] =Message;
        } else if ("Extended".equals(memberType)) {
            strErrorReasonExtended[groupDataCount] =Message;
        } else if ("Bank".equals(memberType)) {
             strErrorReasonBank[groupDataCount] =Message;
           
        } else {
            memberType = "UnKnown";
        }

        if (!"UnKnown".equals(memberType)) {
            
        }
        
    }

    /**
     * Check whether the Inception Date is valid or not.
     * <p>
     * This Method can be used to Check whether the Inception Date is valid or
     * not.
     *
     * @param InceptionDate the date of inception extracted from CSV file.
     * @return boolean, Returns either true or false values
     *
     */
    public boolean ValidateInceptionDate(String InceptionDate) {
        boolean retValue = true;

        if (InceptionDate.isEmpty() || InceptionDate.equals("NULL")) {
            retValue = false;
        } else {

            Object[] date = InceptionDate.split("/");

            //Initializing values of year/moth/date
            int year = Integer.parseInt(date[0].toString());
            int month = Integer.parseInt(date[1].toString());
            int day = Integer.parseInt(date[2].toString());

            //Calculating the number of days in a month
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, year);
            calendar.set(Calendar.MONTH, month);
            int numDays = calendar.getActualMaximum(Calendar.DATE);
            System.out.println("Month" + month + "Number of days" + numDays);
            // Validate Month 
            if (month < 1 || month > 12) {
                retValue = false;
            }

            if (!(day <= numDays)) {
                return false;
            }

        }

        return retValue;
    }

    /**
     * isValidAgeGroup
     * <p>
     * This method is to validate the age group.
     *
     * @param AgeGroup, the agegroup
     * @return boolean, return a true or false value
     */
    public boolean isValidAgeGroup(String AgeGroup) {
        if (AgeGroup.isEmpty()) {
            return false;
        }
        return true;
    }

    /**
     * isIDExixts.
     * <p>
     * This Method can be used to Check whether an Id exists in the database
     * table or not. not.
     *
     * @param ID the ID value extracted from CSV file.
     * @return boolean, Returns either true or false values
     *
     */
    public boolean isIDExixts(String ID) {
        if (ID.isEmpty()) {
            return false;
        }

        String tableName = memberType.toLowerCase() + "_db";
        String sql = "SELECT * from " + tableName + "WHERE ID='" + ID + "'";
        try {
            ResultSet rs = Holder.stmt.executeQuery(sql);
            if (rs.next()) {

                return false;

            }
            System.out.println("VFSVINU" + Holder.curDBID);
            rs.close();
        } catch (Exception e) {
            //return false;
        }

        return true;
    }

    /*
     *<p> Module : SAIDValidator
     * Format : YYMMDDGSSSCAZ
     * YYMMDD : Date of birth (DOB)
     * G : Gender. 0-4 Female; 5-9 Male
     * SSS : Sequence No. for DOB/G combination
     * C : Citizenship. 0 SA; 1 Other
     * A : Usually 8, or 9 but can be other v
     * Reference : http://xml-fx.com/services/saidvalidator.aspx
     * Author : Vinu
     * Date Written : 01-09-2014
     * @param ID the ID value extracted from CSV file.
     * @return boolean, Returns either true or false values
     */
    public static boolean ValidateID(String ID) {

        Integer i1, i2, i3, i4, i5;
        String s;
        boolean ValidateID = true;

        String i11, i22;
        if ("NULL".equals(ID.toString())) {
            return false;
        } else {
            if (ID.length() == 13) {

                try {

                    //Step [1] : Add all the digits in the odd positions (excluding last digit).
                    i1 = Integer.parseInt(ID.substring(0, 1)) + Integer.parseInt(ID.substring(2, 3)) + Integer.parseInt(ID.substring(4, 5)) + Integer.parseInt(ID.substring(6, 7)) + Integer.parseInt(ID.substring(8, 9)) + Integer.parseInt(ID.substring(10, 11));

                    //Step [2]: Move the even positions into a field and multiply the number by 2.
                    i22 = ID.substring(1, 2) + ID.substring(3, 4) + ID.substring(5, 6) + ID.substring(7, 8) + ID.substring(9, 10) + ID.substring(11, 12);
                    i2 = Integer.valueOf(i22) * 2;

                    if ((Integer.parseInt(ID.substring(6, 7).toString()) >= 0 && Integer.parseInt(ID.substring(6, 7).toString()) <= 9)
                            // This is to validate Gender
                            && (Integer.parseInt(ID.substring(10, 11).toString()) == 0 || Integer.parseInt(ID.substring(10, 11).toString()) == 1) // // This is to validate Citizenship
                            ) {
                        //Step [3] : Add the digits of the result in [2].
                        i3 = 0;
                        for (int x = 0; x < i2.toString().length(); x++) {
                            i3 += Integer.parseInt(i2.toString().substring(x, x + 1));
                        }

                        System.out.println(i1 + " : " + i2 + " : " + i3);

                        //Step [4]  Add the answer in [3] to the answer in [1].
                        i4 = i3 + i1;

                        System.out.println(i1 + " : " + i2 + " : " + i3 + " : " + i4);

                        //Step [5] Subtract the second digit of [4](i.e. 3) from 10  
                        i5 = 10 - Integer.parseInt(i4.toString().substring(1, 2));

                        System.out.println(i1 + " : " + i2 + " : " + i3 + " : " + i4 + " : " + i5 + " : " + ID.substring(12, 13));

                        if (!ID.substring(12, 13).equals(i5.toString())) {
                            ValidateID = false;
                        }

                    } else {
                        ValidateID = false;
                    }

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    // ValidateID = false;
                }
            } else {
                ValidateID = false;
            }

        }

        return ValidateID;

    }

    /**
     * ValidateBirthDate.
     * <p>
     * This Method can be used to Validate BirthDate. not.
     *
     * @param BirthDate the BirthDate value extracted from CSV file.
     * @return boolean, Returns either true or false values
     *
     */
    public static boolean ValidateBirthDate(String BirthDate) {
        boolean retValue = true;

        if (BirthDate.isEmpty() || BirthDate.equals("NULL")) {
            retValue = false;
        } else {
            //  System.out.println("Birth Date " + BirthDate);
            Object[] date = BirthDate.split("/");

            //Initializing values of year/moth/date
            int year = Integer.parseInt(date[0].toString());
            int month = Integer.parseInt(date[1].toString());
            int day = Integer.parseInt(date[2].toString());

            //Calculating the number of days in a month
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, year);
            calendar.set(Calendar.MONTH, month);
            int numDays = calendar.getActualMaximum(Calendar.DATE);
            System.out.println("Month" + month + "Number of days" + numDays);
            // Validate Month 
            if (month < 1 || month > 12) {
                retValue = false;
            }

            if (!(day <= numDays)) {
                return false;
            }

        }

        return retValue;

    }

    @Override
    protected void process(final List<String> chunks) {
        // Updates the messages text area
        // Messages received from the doInBackground() (when invoking the publish() method)
        for (final String string : chunks) {
            getMessagesTextArea().append(string);
            getMessagesTextArea().append("\n");
        }
    }
    /*
    
     * method to get the TextArea object
     * @return JTextArea, the value of JTextArea object
     */

    public JTextArea getMessagesTextArea() {
        return Holder.messagesTextArea;
    }

    /**
     * @param messagesTextArea the Holder.messagesTextArea to set
     */
    public void setMessagesTextArea(JTextArea messagesTextArea) {
        Holder.messagesTextArea = messagesTextArea;
    }
}
