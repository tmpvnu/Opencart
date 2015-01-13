/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package assistimport;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfPTable;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.swing.JFileChooser;
import javax.swing.JTextArea;

/**
 *
 * @author Vinu
 */
public class Holder {

    public static String vers = "1.3"; //<--------------------------VERSION----
    public static final long serialVersionUID = -8668818312732181049L;
    public static String url;
    public static String user;
    public static String pass;
    public static String schema;
    public static DoAnalyse doaAalyse;
    public static Application appMain;

    // Variable to set the type of Transaction, TransactionType can be Debit order or Credit Order
    public static String TransactionType = "";

    /*
     * rdbInfo is an Object array which is used to store the Database connection details that are extracted from rdbInfo.txt file
     */
    public static Object[] rdbInfo;
    public static JFileChooser jFileChooser;
    public static Object[] branchInfo;
    ;
    /*
    
    
    
     */
    public static String faultReportCSVheader = "\"Nr\",\"Surname\",\"FullName\",\"Initials\",\"H Adr1\",\"H Adr2\",\"H Adr3\",\"P Adr1\",\"P Adr2\",\"P Adr3\",\"P Kode\",\"Tel H\",\"Tel W\",\"Tel C\",\"Married\",\"RefNr\",\"Agentcode\",\"Paymentmethod\",\"BeginDate\",\"CaptiorDate\",\"EndDate\",\"Reason\",\"GroupLink\",\"Sex\",\"ID\",\"ProductLink\",\"WaitingPeriod\",\"BirthDate\",\"FullPremium\",\"DuplID\",\"LastPayment\",\"ExtraFees\",\"ChangeDate\",\"EMail\",\"BarCode\",\"CreateUser\",\"InsepDate\",\"ImportSwi\",\"ShortPayments\",\"CommReceived\",\"Medium\",\"BranchNo\",\"SyncHQ\",\"SpecialProduct1\",\"SpecialProduct2\",\"SpecialProduct3\",\"SyncBranch\",\"SpecialProduct1Date\",\"SpecialProduct2Date\",\"SpecialProduct3Date\",\"SpecialProduct1WP\",\"SpecialProduct2WP\",\"SpecialProduct3WP\",\"MainPolicyNr\",\"MainPolicyBranch\",\"NickName\",\"Source\",\"Package_Id\",\"OverridePrem\",\"Memo\"";


    /*
     * Predefined headers for verifying the header  format of the RiskfinCashUnderwrter_Export.CSV file.
     */
    public static String RiskfinCashUnderwrter_Export = "\"No\",\"Mem No\",\"Ref No\",\"Initials\",\"Surname\",\"ID\",\"Birth Date\",\"Rel\",\"Coverage\",\"Premium\",\"Additional Premium\",\"Additional Cover\",\"Product Description\",\"SP1 Description\",\"SP1 Premium\",\"SP2 Description\",\"SP2 Premium\",\"SP3 Description\",\"SP3 Premium\",\"Last Payment\",\"Inception Date\",\"Transaction Date\",\"Effective Date\",\"Age\",\"Married\",\"Cancel Date\",\"C/R\",\"Agent Code\",\"Extra Fees\",\"IncludedPremium\"";

    /*
    
     * Predefined headers for verifying the header  format of the  RiskfinDebitOrderRetail_Export.CSV file.
     */
    public static String RiskfinD_ORetail_Export = "\"No\",\"Mem No\",\"Ref No\",\"Initials\",\"Surname\",\"ID\",\"Birth Date\",\"Rel\",\"Coverage\",\"Premium\",\"Additional Premium\",\"Additional Cover\",\"Product Description\",\"SP1 Description\",\"SP1 Premium\",\"SP2 Description\",\"SP2 Premium\",\"SP3 Description\",\"SP3 Premium\",\"Last Payment\",\"Inception Date\",\"Transaction Date\",\"Effective Date\",\"Age\",\"Married\",\"Cancel Date\",\"C/R\",\"Agent Code\",\"Extra Fees\",\"IncludedPremium\"";

    public static String columnNames = "Nr, Surname, FullName, Initials, H Adr1, H Adr2, H Adr3, P Adr1, P Adr2, P Adr3, P Kode, Tel H, Tel W, Tel C, Married, RefNr, Agentcode, Paymentmethod, BeginDate, CaptiorDate, EndDate, Reason, GroupLink, Sex, ID, ProductLink, WaitingPeriod, BirthDate, FullPremium, DuplID, LastPayment, ExtraFees, ChangeDate, EMail, BarCode, CreateUser, InsepDate, ImportSwi, ShortPayments, CommReceived, Medium, BranchNo, SyncHQ, SpecialProduct1, SpecialProduct2, SpecialProduct3, SyncBranch, SpecialProduct1Date, SpecialProduct2Date, SpecialProduct3Date, SpecialProduct1WP, SpecialProduct2WP, SpecialProduct3WP, MainPolicyNr, MainPolicyBranch, NickName, Source, Package_Id, OverridePrem, Memo";
    /*
     * provide folder name to access to server connect files
     */
    public static String ServerConnectFolderName = "C:\\ServerConnect\\";

    /*
    
     * The Exact path of CSV file that we want to use for importing details into the server machine
     */
    public static File path_of_CSVfile = null;

    /*
     * Variables needed for database connection
     */
    public static PreparedStatement preparedStatement = null;
    public static Connection conn;
    public static Statement stmt = null;

    public static int curDBID = 0;

    public static String sqlmember_db = "INSERT INTO member_db "
            + "(Surname,FullName, Initials, "
            + "Surname, FullName, Initials, "
            + "H Adr1, H Adr2, H Adr3, P Adr1,"
            + " P Adr2, P Adr3, P Kode, Tel H, "
            + "Tel W, Tel C, Married, RefNr, Agentcode,"
            + " Paymentmethod, BeginDate, CaptiorDate, EndDate,"
            + " Reason, GroupLink, Sex, ID, ProductLink,"
            + " WaitingPeriod, BirthDate, FullPremium, DuplID, "
            + "LastPayment, ExtraFees, ChangeDate, EMail, BarCode,"
            + " CreateUser, InsepDate, ImportSwi, ShortPayments, C"
            + "ommReceived, Medium, BranchNo, SyncHQ, SpecialProduct1, "
            + "SpecialProduct2, SpecialProduct3, SyncBranch, SpecialProduct1Date, "
            + "SpecialProduct2Date, SpecialProduct3Date, SpecialProduct1WP, "
            + "SpecialProduct2WP, SpecialProduct3WP, MainPolicyNr,"
            + " MainPolicyBranch, NickName, Source, Package_Id,"
            + " OverridePrem, Memo)"
            + " VALUES (";

    public static JTextArea messagesTextArea;
    public static Object[] arrayOfHeaderFields;
    public static Object[] columnNamesDB;
    public static Document document;
    public static Document FaultReportPDFDoc;
    public static ReportGeneratePDF Report = new ReportGeneratePDF();
    public static ReportGeneratePDF FaultReport = new ReportGeneratePDF();

    /*
     * String FILE  will store the path and file name of report to be saved. 
     */
    public static String ReportSourceFolder = "C:\\Reports\\";
    public static String FILE = "C:\\Reports\\PDF\\";
    public static String csvFILE = "C:\\Reports\\CSV\\";
    public static String FaultReportFile = "C:\\Reports\\FALT\\";
    public final static PdfPTable table = new PdfPTable(30);
    public final static PdfPTable faltReporttable = new PdfPTable(6);

}
