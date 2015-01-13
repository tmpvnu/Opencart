          RiskfinADConnection.StartTransaction;
          try
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.SCHEMATA');
              Add('where SCHEMA_NAME='''+ Schema.Text +'''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('CREATE DATABASE ' + Schema.Text + ';');
              end;
              Query.ExecSQL;

              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`bank_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`BankName` varchar(30) default NULL,');
                Add('`BranchName` varchar(30) default NULL,');
                Add('`BranchCode` varchar(15) default NULL,');
                Add('`AccountNo` varchar(15) default NULL,');
                Add('`AccountHolderName` varchar(30) default NULL,');
                Add('`TypeAccount` int(1) default NULL,');
                Add('`DeductionDate` int(10) unsigned default ''0'',');
                Add('`LinkID` int(10) unsigned NOT NULL default ''0'',');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIdInd` (`LinkID`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`children_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Surname` varchar(30) default NULL,');
                Add('`Names` varchar(30) default NULL,');
                Add('`ID` varchar(13) default NULL,');
                Add('`CaptiorDate` int(10) unsigned default ''0'',');
                Add('`BeginDate` int(10) unsigned default ''0'',');
                Add('`EndDate` int(10) unsigned default ''0'',');
                Add('`LinkID` int(10) unsigned NOT NULL default ''0'',');
                Add('`BirthDate` int(10) unsigned default ''0'',');
                Add('`ChangeDate` int(10) unsigned default NULL,');
                Add('`ImportSwi` char default NULL,');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIdInd` (`LinkID`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`death_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`ClaimAmmount` decimal(10,2) default NULL,');
                Add('`DeathReason` varchar(40) default NULL,');
                Add('`DateReceived` int(8) unsigned default NULL,');
                Add('`Accepted` varchar(5) default ''False'',');
                Add('`AcceptedAmmount` decimal(10,2) default NULL,');
                Add('`DeathDate` int(8) unsigned default ''0'',');
                Add('`LinkId` int(11) default ''0'',');
                Add('`DateAccepted` int(8) unsigned default NULL,');
                Add('`DeathConfirmed` varchar(5) default ''False'',');
                Add('`FromWhere` varchar(10) default NULL,');
                Add('`FromId` varchar(13) default NULL,');
                Add('`FromName` varchar(45) default NULL,');
                Add('`FromSurname` varchar(45) default NULL,');
                Add('`ClaimantsNames` varchar(45) default NULL,');
                Add('`ClaimantsSurname` varchar(45) default NULL,');
                Add('`ClaimantsBirthDate` int(10) unsigned default ''0'',');
                Add('`ClaimantsId` varchar(13) default NULL,');
                Add('`ClaimantsTelH` varchar(20) default NULL,');
                Add('`ClaimantsTelW` varchar(20) default NULL,');
                Add('`ClaimantsStrAdr` varchar(100) default NULL,');
                Add('`ClaimantsPosAdr` varchar(100) default NULL,');
                Add('`ClaimantsPosCode` varchar(10) default NULL,');
                Add('`Relationship` varchar(45) default NULL,');
                Add('`MainMemberId` VARCHAR(13) default NULL,');
                Add('`GroupId` INTEGER UNSIGNED,');
                Add('`InseptionDate` INTEGER UNSIGNED,');
                Add('`FromBirthDate` INTEGER UNSIGNED,');
                Add('`Undertaker` VARCHAR(30),');
                Add('`ContactName` VARCHAR(30),');
                Add('`ContactTel` VARCHAR(15),');
                Add('`NameofHospital` VARCHAR(30),');
                Add('`PolicytoContinue` VARCHAR(5),');
                Add('`NameofRecipient` VARCHAR(30),');
                Add('`BankName` VARCHAR(30),');
                Add('`BankBranchName` VARCHAR(30),');
                Add('`BankBranchCode` VARCHAR(20),');
                Add('`BankAccNo` VARCHAR(30),');
                Add('`BankTypeAcc` VARCHAR(20),');
                Add('`UseGroupBank` VARCHAR(5),');
                Add('`ReceivedDT` VARCHAR(20),');
                Add('`ConfirmedDT` VARCHAR(20),');
                Add('`FaxedDT` VARCHAR(20),');
                Add('`CompletedDT` VARCHAR(20),');
                Add('`StatusDesc` VARCHAR(100),');
                Add('`DocPath` VARCHAR(200),');
                Add('`MainMemberRefNr` VARCHAR(20),');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIdInd` (`LinkId`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`extended_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Surname` varchar(30) default NULL,');
                Add('`Names` varchar(30) default NULL,');
                Add('`Initials` varchar(10) default NULL,');
                Add('`ID` varchar(13) default NULL,');
                Add('`Premium` decimal(10,2) default NULL,');
                Add('`BeginDate` int(10) unsigned default ''0'',');
                Add('`CaptiorDate` int(10) unsigned default ''0'',');
                Add('`LinkID` int(10) unsigned NOT NULL default ''0'',');
                Add('`BirthDate` int(10) unsigned default ''0'',');
                Add('`EndDate` int(10) unsigned default ''0'',');
                Add('`WaitingPeriod` int(3) default ''0'',');
                Add('`ProductLink` int(6) unsigned default NULL,');
                Add('`ChangeDate` int(10) unsigned default NULL,');
                Add('`ImportSwi` char default NULL,');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIDInd` (`LinkID`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`group_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`GroupName` varchar(40) default NULL,');
                Add('`CaptiorDate` int(10) unsigned default ''0'',');
                Add('`BeginDate` int(10) unsigned default ''0'',');
                Add('`EndDate` int(10) unsigned default ''0'',');
                Add('`Active` smallint(6) default ''0'',');
                Add('`Contact` varchar(30) default NULL,');
                Add('`StrAdr1` varchar(30) default NULL,');
                Add('`StrAdr2` varchar(30) default NULL,');
                Add('`StrAdr3` varchar(30) default NULL,');
                Add('`PosAdr1` varchar(30) default NULL,');
                Add('`PosAdr2` varchar(30) default NULL,');
                Add('`PosAdr3` varchar(30) default NULL,');
                Add('`PosCode` varchar(4) default NULL,');
                Add('`WTel` varchar(20) default NULL,');
                Add('`CTel` varchar(20) default NULL,');
                Add('`FTel` varchar(20) default NULL,');
                Add('`Producttype` int(10) unsigned default ''0'',');
                Add('`UnderwriterTotal` decimal(10,2) default ''0.00'',');
                Add('`RetailTotal` decimal(10,2) default ''0.00'',');
                Add('`CommisionTotal` decimal(10,2) default ''0.00'',');
                Add('`MemberTotal` int(11) default ''0'',');
                Add('`AgentCode` varchar(20) default NULL,');
                Add('`CustomProduct` varchar(5) default ''False'',');
                Add('`BankName` varchar(30) default NULL,');
                Add('`BranchName` varchar(30) default NULL,');
                Add('`BranchCode` varchar(20) default NULL,');
                Add('`BankAccNo` varchar(30) default NULL,');
                Add('`TypeAcc` varchar(30) default NULL,');
                Add('`LastMonthUpdate` int(10) unsigned default NULL,');
                Add('`EMail` varchar(45) default NULL,');
                Add('`RiskPremium` DECIMAL(10,2) default ''0.00'',');
                Add('`ExtrafeesTotal` DECIMAL(10,2) default ''0.00'',');
                Add('`AddRetailTotal` DECIMAL(10,2),');
                Add('`AddUnderwriterTotal` DECIMAL(10,2),');
                Add('`ManagerCommisionTotal` DECIMAL(10,2),');
                Add('`FSPNo` VARCHAR(20),');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `GroupNameInd` (`GroupName`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`institution_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`InstitutionType` int(1) default NULL,');
                Add('`CompanyCode` varchar(15) default NULL,');
                Add('`TransactionType` varchar(30) default NULL,');
                Add('`DeductionDate` int(10) unsigned default ''0'',');
                Add('`PerselNr` varchar(15) default NULL,');
                Add('`DepartmentCode` varchar(15) default NULL,');
                Add('`OnderskrywersCompanyNr` varchar(15) default NULL,');
                Add('`LinkId` int(10) unsigned NOT NULL default ''0'',');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIdInd` (`LinkId`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`member_db` (');
                Add('`Nr` int(10) unsigned NOT NULL default ''0'',');
                Add('`Surname` varchar(30) NOT NULL default '''',');
                Add('`FullName` varchar(30) default NULL,');
                Add('`Initials` varchar(10) default NULL,');
                Add('`H Adr1` varchar(30) default NULL,');
                Add('`H Adr2` varchar(30) default NULL,');
                Add('`H Adr3` varchar(30) default NULL,');
                Add('`P Adr1` varchar(30) default NULL,');
                Add('`P Adr2` varchar(30) default NULL,');
                Add('`P Adr3` varchar(30) default NULL,');
                Add('`P Kode` varchar(4) default NULL,');
                Add('`Tel H` varchar(15) default NULL,');
                Add('`Tel W` varchar(15) default NULL,');
                Add('`Tel C` varchar(15) default NULL,');
                Add('`Married` char(1) default NULL,');
                Add('`RefNr` varchar(20) default NULL,');
                Add('`Agentcode` varchar(20) default NULL,');
                Add('`PolicyStatus` int(1) default NULL,');
                Add('`Paymentmethod` int(1) default ''0'',');
                Add('`BeginDate` int(10) unsigned default ''0'',');
                add('`CaptiorDate` int(10) unsigned default ''0'',');
                Add('`EndDate` int(10) unsigned default ''0'',');
                Add('`Reason` varchar(40) default NULL,');
                Add('`GroupLink` int(10) unsigned default NULL,');
                Add('`Sex` char(1) default NULL,');
                Add('`ID` varchar(13) NOT NULL default '''',');
                Add('`ProductLink` int(10) unsigned default NULL,');
                Add('`WaitingPeriod` int(3) unsigned default ''0'',');
                Add('`BirthDate` int(10) unsigned NOT NULL default ''0'',');
                Add('`FullPremium` decimal(10,2) default ''0.00'',');
                Add('`DuplID` int(11) default ''0'',');
                Add('`LastPayment` int(10) unsigned default NULL,');
                Add('`ExtraFees` decimal(10,2) default ''0.00'',');
                Add('`ChangeDate` int(10) unsigned default NULL,');
                Add('`EMail` varchar(45) default NULL,');
                Add('`BarCode` varchar(30) default NULL,');
                Add('`CreateUser` varchar(20) default NULL,');
                Add('`InsepDate` integer unsigned default NULL,');
                Add('`ImportSwi` char default NULL,');
                Add('`ShortPayments` DECIMAL(10,2),');
                Add('`CommReceived` INTEGER UNSIGNED,');
                Add('`Medium` VARCHAR(20),');
                Add('PRIMARY KEY  (`Nr`),');
                Add('UNIQUE KEY `IDInd` (`ID`,`DuplID`),');
                Add('KEY `SurnameInd` (`Surname`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`pay_db` (');
                Add('`Nr` int(10) unsigned NOT NULL default ''0'',');
                Add('`LinkId` int(10) unsigned NOT NULL default ''0'',');
                Add('`Ammount` decimal(10,2) NOT NULL default ''0.00'',');
                Add('`PayDate` int(10) unsigned NOT NULL default ''0'',');
                Add('`Month` int(10) unsigned default ''0'',');
                Add('`Year` int(10) unsigned default ''0'',');
                Add('`Printed` varchar(5) default ''False'',');
                Add('`User` varchar(45) default NULL,');
                Add('`RefNo` varchar(20) default NULL,');
                Add('`ShortSwi` VARCHAR(5) NOT NULL DEFAULT ''False'',');
                Add('`Type` VARCHAR(5),');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkInd` (`LinkId`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`product_db` (');
                Add('`nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Description` varchar(40) default NULL,');
                Add('`AgeGroup` int(1) unsigned default NULL,');
                Add('`Coverage` decimal(10,2) default ''0.00'',');
                Add('`SpouseCoverage` decimal(10,2) default ''0.00'',');
                Add('`JoiningFee` decimal(10,2) default ''0.00'',');
                Add('`RetailPremium` decimal(10,2) default ''0.00'',');
                Add('`UnderwriterPremium` decimal(10,2) default ''0.00'',');
                Add('`Period` int(4) default NULL,');
                Add('`CommStructure` int(1) unsigned default NULL,');
                Add('`CommisionAmmount` decimal(10,2) default ''0.00'',');
                Add('`PLLink` int(6) unsigned default NULL,');
                Add('`UnderwriterName` varchar(30) default NULL,');
                Add('`BeginAge` int(11) default ''0'',');
                Add('`EndAge` int(11) default ''0'',');
                Add('`Double` varchar(5) default ''False'',');
                Add('`Married` int(11) default ''0'',');
                Add('`Child1Coverage` decimal(10,2) default ''0.00'',');
                Add('`Child2Coverage` decimal(10,2) default ''0.00'',');
                Add('`Child3Coverage` decimal(10,2) default ''0.00'',');
                Add('`Stillborn` decimal(10,2) default ''0.00'',');
                Add('`ExtendedChildFee` decimal(10,2) default ''1.00'',');
                Add('`CustomDesc` varchar(5) default NULL,');
                Add('`AdditionalCoverage` DECIMAL(10,2) default ''0.00'',');
                Add('`AdditionalRetailPremium` DECIMAL(10,2) default ''0.00'',');
                Add('`AdditionalUnderPremium` DECIMAL(10,2) default ''0.00'',');
                Add('`ManagerCommStructure` INTEGER(1) UNSIGNED,');
                Add('`ManagerCommAmmount` DECIMAL(10,2),');
                Add('PRIMARY KEY  (`nr`),');
                Add('KEY `GroupLinkInd` (`PLLink`,`Description`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`productlist_db` (');
                Add('`Nr` int(10) NOT NULL default ''0'',');
                Add('`Producttype` varchar(20) default NULL,');
                Add('`CustomType` varchar(5) default ''False'',');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `ProducttypeInd` (`Producttype`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`spouse_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`SSurname` varchar(30) default NULL,');
                Add('`SNames` varchar(30) default NULL,');
                Add('`SInitials` varchar(10) default NULL,');
                Add('`SID` varchar(13) default NULL,');
                Add('`SSex` char(1) default NULL,');
                Add('`LinkID` int(10) unsigned NOT NULL default ''0'',');
                Add('`SCaptiorDate` int(10) unsigned default ''0'',');
                Add('`SBeginDate` int(10) unsigned default ''0'',');
                Add('`SBirthDate` int(10) unsigned default ''0'',');
                Add('`SWaitingPeriod` int(3) default ''0'',');
                Add('`SEndDate` int(10) unsigned default ''0'',');
                Add('`SChangeDate` int(10) unsigned default NULL,');
                Add('`SImportSwi` char default NULL,');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIdInd` (`LinkID`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`user_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`UserName` varchar(45) NOT NULL default '''',');
                Add('`Password` varchar(45) default NULL,');
                Add('`Rights` int(10) unsigned default NULL,');
                Add('`LastLogon` DATETIME,');
                Add('PRIMARY KEY  (`Nr`)');
                Add(') ENGINE=MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`notes_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Date` INTEGER(10) UNSIGNED,');
                Add('`LinkID` INTEGER UNSIGNED NOT NULL DEFAULT 0,');
                Add('`FromWhere` CHAR NOT NULL DEFAULT '''',');
                Add('`Description` VARCHAR(150),');
                Add('`AttentionDate` INTEGER(10) UNSIGNED,');
                Add('`NoteBy` VARCHAR(45),');
                Add('`Completed` VARCHAR(5) NOT NULL DEFAULT ''False'',');
                Add('`AttentionTime` VARCHAR(10),');
                Add('`System` VARCHAR(5) NOT NULL DEFAULT ''False'',');
                Add('PRIMARY KEY(`Nr`),');
                Add('UNIQUE `LinkInd`(`LinkID`, `FromWhere`, `Nr`)');
                Add(') ENGINE=MYISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`stock_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Description` VARCHAR(45),');
                Add('`DateCreated` INTEGER UNSIGNED,');
                Add('`DateChanged` INTEGER UNSIGNED,');
                Add('`CostPrice` DECIMAL(10,2),');
                Add('`SalesPrice` DECIMAL(10,2),');
                Add('`Barcode` VARCHAR(30),');
                Add('`Qty` DECIMAL(5,2),');
                Add('`AlertQty` DECIMAL(5,2),');
                Add('`NonStockItem` VARCHAR(5),');
                Add('`StartingQty` DECIMAL(5,2),');
                Add('`AmmountChangeSwi` VARCHAR(5) NOT NULL DEFAULT ''False'',');
                Add('PRIMARY KEY(`Nr`),');
                Add('INDEX `DescrInd`(`Description`)');
                Add(') ENGINE = MYISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`invoice_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL auto_increment,');
                Add('`ClientName` VARCHAR(30),');
                Add('`ClientTelW` VARCHAR(20),');
                Add('`ClientTelC` VARCHAR(20),');
                Add('`ClientAdr1` VARCHAR(30),');
                Add('`ClientAdr2` VARCHAR(30),');
                Add('`ClientAdr3` VARCHAR(30),');
                Add('`ClientPCode` VARCHAR(4),');
                Add('`ClientVatNo` VARCHAR(30),');
                Add('`InvDate` INTEGER UNSIGNED,');
                Add('`InvBy` VARCHAR(45),');
                Add('`MemLink` INTEGER UNSIGNED,');
                Add('`InvClose` VARCHAR(5),');
                Add('`AmmTendered` DECIMAL(10,2),');
                Add('PRIMARY KEY(`Nr`)');
                Add(') ENGINE = MYISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`invoiceitem_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Description` VARCHAR(45),');
                Add('`Price` DECIMAL(10,2),');
                Add('`Qty` DECIMAL(5,2),');
                Add('`StockNo` INTEGER UNSIGNED,');
                Add('`LinkId` INTEGER UNSIGNED NOT NULL,');
                Add('`AmmountChangeSwi` VARCHAR(5),');
                Add('PRIMARY KEY(`Nr`),');
                Add('KEY `LinkInd` (`LinkID`)');
                Add(') ENGINE = MYISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`marketer_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Code` VARCHAR(10) NOT NULL DEFAULT '''',');
                Add('`Name` VARCHAR(30),');
                Add('`Surname` VARCHAR(30),');
                Add('`TelC` VARCHAR(20),');
                Add('`TelW` VARCHAR(20),');
                Add('`TelH` VARCHAR(20),');
                Add('`Refno` VARCHAR(30),');
                Add('`CommTotalM` DECIMAL(10,2),');
                Add('`BeginDate` INTEGER UNSIGNED,');
                Add('`EndDate` INTEGER UNSIGNED,');
                Add('`CountMembers` INTEGER UNSIGNED,');
                Add('`EMail` VARCHAR(30),');
                Add('`Adr1` VARCHAR(30),');
                Add('`Adr2` VARCHAR(30),');
                Add('`Adr3` VARCHAR(30),');
                Add('`PCode` VARCHAR(5),');
                Add('`CommTotal` DECIMAL(10,2),');
                Add('`CountMembersM` DECIMAL(10,2),');
                Add('`Manager` INTEGER UNSIGNED,');
                Add('PRIMARY KEY(`Nr`),');
                Add('INDEX `CodeInd`(`Code`)');
                Add(') ENGINE = MYISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`beneficiary_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`LinkID` INTEGER UNSIGNED NOT NULL,');
                Add('`Name` VARCHAR(45),');
                Add('`BirthDate` INTEGER UNSIGNED,');
                Add('`ID` VARCHAR(13),');
                Add('`Tel` VARCHAR(20),');
                Add('`Pers` DECIMAL(10,2),');
                Add('PRIMARY KEY(`Nr`),');
                Add('INDEX `LinkIDInd`(`LinkID`)');
                Add(') ENGINE = MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`global_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL,');
                Add('`NextMem` INTEGER UNSIGNED NOT NULL,');
                Add('`NextPay` INTEGER UNSIGNED NOT NULL,');
                Add('`SecondPay` INTEGER UNSIGNED NOT NULL,');
                Add('`InvNo` INTEGER UNSIGNED NOT NULL,');
                Add('PRIMARY KEY(`Nr`)');
                Add(') ENGINE = MyISAM;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`totals_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`FromWhere` INTEGER UNSIGNED NOT NULL,');
                Add('`Year` INTEGER UNSIGNED NOT NULL,');
                Add('`Month` INTEGER UNSIGNED NOT NULL,');
                Add('`LinkID` INTEGER UNSIGNED NOT NULL,');
                Add('`RetailTotal` DECIMAL(10,2),');
                Add('`UnderwriterTotal` DECIMAL(10,2),');
                Add('`CommisionTotal` DECIMAL(10,2),');
                Add('`MemberTotal` DECIMAL(10,2),');
                Add('`AddRetailTotal` DECIMAL(10,2),');
                Add('`AddUnderwriterTotal` DECIMAL(10,2),');
                Add('`ManagerCommisionTotal` DECIMAL(10,2),');
                Add('`RiskTotal` DECIMAL(10,2),');
                Add('`Date` INTEGER UNSIGNED,');
                Add('`TotalBy` VARCHAR(20),');
                Add('`ExtraFeesTotal` DECIMAL(10,2),');
                Add('`Type` VARCHAR(5),');
                Add('PRIMARY KEY(`Nr`),');
                Add('INDEX `LinkIdInd` (`LinkID`, `FromWhere`)');
                Add(') ENGINE = MyISAM;');
              end;
              Query.ExecSQL;
              IniFile.WriteString ('Login', 'Username', Login.Text);
              IniFile.WriteString ('Login', 'Password', Encrypt(Password.Text));
              Inifile.WriteString('Login','Database', Schema.Text);
              IniFile.WriteString ('Login', 'Ip', Ip.Text);
              IniFile.WriteString ('ComportSection', 'Comport', 'Driver Receipt');
              if Fileexists(ProgramPath + '\Riskfin.exe') then
              begin
                IniFile.WriteString ('Settings', 'ParticPath', '"' + ProgramPath + '\logo2.jpg"');
                IniFile.WriteString ('Settings', 'ReportsTitle', 'Riskfin Funeral Administrators');
              end
              else
              begin
                IniFile.WriteString ('Settings', 'ParticPath', '"' + ProgramPath + '\blank.jpg"');
                IniFile.WriteString ('Settings', 'ReportsTitle', 'Nano Digital Systems');
              end;
              with Query.SQL do begin
                Clear;
                Add('Insert into `' + Schema.Text + '`.`user_db` (UserName, Password, Rights)');
                Add('Values ("' + Login.Text + '","' + Encrypt(Password.Text) + '",5)');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('Insert into `' + Schema.Text + '`.`global_db` (Nr, NextMem, NextPay, SecondPay, InvNo)');
                Add('Values (1,' + InttoStr(IniFile.ReadInteger('Login', 'NextMem', 0)) + ',' + InttoStr(IniFile.ReadInteger('Login', 'NextPay', 0)) + ',' + InttoStr(IniFile.ReadInteger('Login', 'SecondPay', 1000000)) + ',' + InttoStr(IniFile.ReadInteger('Invoice', 'InvNo', 0)) + ')');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''branch_db''');
              Add('and COLUMN_NAME=''Name''');
            end;
            Query.Open;
            //  v1.0.3.0
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`branch_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Name` varchar(30) default NULL,');
                Add('`Tel` varchar(20) default NULL,');
                Add('`Adr1` varchar(30) default NULL,');
                Add('`Adr2` varchar(30) default NULL,');
                Add('`Adr3` varchar(30) default NULL,');
                Add('`PCode` varchar(5) default NULL,');
                Add('`Contact` varchar(30) default NULL,');
                Add('`LastSync` int(10) unsigned default NULL,');
                Add('`Created` int(10) unsigned default NULL,');
                Add('`StartInvNo` int(10) unsigned default NULL,');
                Add('PRIMARY KEY  (`Nr`)');
                Add(') ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`cashup_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Date` int(10) unsigned default NULL,');
                Add('`User` varchar(30) default NULL,');
                Add('`RealCashTotal` decimal(10,2) default NULL,');
                Add('`RealChequesTotal` decimal(10,2) default NULL,');
                Add('`RealCreditCardTotal` decimal(10,2) default NULL,');
                Add('`RealOtherTotal` decimal(10,2) default NULL,');
                Add('`CountCashTotal` decimal(10,2) default NULL,');
                Add('`CountChequesTotal` decimal(10,2) default NULL,');
                Add('`CountCreditCardTotal` decimal(10,2) default NULL,');
                Add('`CountOtherTotal` decimal(10,2) default NULL,');
                Add('`TotalInvoices` int(10) unsigned default NULL,');
                Add('`CUClosed` varchar(5) default NULL,');
                Add('`SyncHQ` int(10) unsigned default NULL,');
                Add('`RealLayBuys` decimal(10,2) default NULL,');
                Add('`CountLayBuys` decimal(10,2) default NULL,');
                Add('`TotalLayBuys` int(10) unsigned default NULL,');
                Add('`TimeStamp` varchar(20) default NULL,');
                Add('PRIMARY KEY  (`Nr`)');
                Add(') ENGINE=InnoDB DEFAULT CHARSET=latin1;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `PurchaseInvNo` int(10) unsigned AFTER `InvNo`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`invoice_db` ADD COLUMN `InvoiceType` VARCHAR(15) AFTER `AmmTendered`,');
                Add('ADD COLUMN `GLDebNo` VARCHAR(20) AFTER `InvoiceType`,');
                Add('ADD COLUMN `CUSet` INTEGER(11) UNSIGNED AFTER `GLDebNo`,');
                Add('ADD COLUMN `InvTotal` DECIMAL(10,2) AFTER `CUSet`,');
                Add('ADD COLUMN `ShiftSet` VARCHAR(20) AFTER `InvTotal`,');
                Add('ADD COLUMN `InvNo` INTEGER(10) UNSIGNED AFTER `ShiftSet`,');
                Add('ADD COLUMN `ClientEMail` VARCHAR(30) AFTER `InvNo`,');
                Add('ADD COLUMN `BranchNo` INTEGER(11) UNSIGNED AFTER `ClientEMail`,');
                Add('ADD COLUMN `SyncHQ` INTEGER(11) UNSIGNED AFTER `BranchNo`,');
                Add('ADD COLUMN `TermMonths` INTEGER(10) UNSIGNED AFTER `SyncHQ`,');
                Add('ADD COLUMN `Premium` DECIMAL(10,2) AFTER `TermMonths`,');
                Add('ADD COLUMN `RefNo` VARCHAR(15) AFTER `Premium`,');
                Add('ADD UNIQUE INDEX `InvNoInd`(`BranchNo`, `InvNo`)');
                Add(', ENGINE = InnoDB;');
              end;
              Query.ExecSql;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`stocktrnsfer_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Branch_no` int(10) unsigned default NULL,');
                Add('`Date` int(10) unsigned default NULL,');
                Add('`Sync` int(10) unsigned default NULL,');
                Add('`Closed` varchar(5) NOT NULL default ''False'',');
                Add('PRIMARY KEY  (`Nr`)');
                Add(') ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`stocktrnsferitem_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`StockNo` int(10) unsigned default NULL,');
                Add('`Qty` decimal(10,2) default NULL,');
                Add('`BeforeQty` decimal(10,2) default NULL,');
                Add('`Description` varchar(30) default NULL,');
                Add('`LinkID` int(10) unsigned default NULL,');
                Add('`TCStockNo` varchar(20) default NULL,');
                Add('`Transfered` int(10) unsigned default NULL,');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `LinkIDInd` (`LinkID`),');
                Add('KEY `StockNoInd` (`StockNo`)');
                Add(') ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`stock_db` ADD COLUMN `SalesPrice2` DECIMAL(10,2) AFTER `AmmountChangeSwi`,');
                Add('ADD COLUMN `TCStockNo` VARCHAR(20) NOT NULL AFTER `SalesPrice2`,');
                Add('ADD COLUMN `Changed` CHAR(1) AFTER `TCStockNo`,');
                Add('ADD COLUMN `BranchNo` INTEGER(11) UNSIGNED AFTER `Changed`,');
                Add('ADD COLUMN `SyncHQ` INTEGER(11) UNSIGNED AFTER `BranchNo`,');
                Add('ADD COLUMN `BranchMainStockNo` INTEGER(10) UNSIGNED AFTER `SyncHQ`,');
                Add('ADD COLUMN `Group` VARCHAR(20) AFTER `BranchMainStockNo`,');
                Add('ADD COLUMN `ExtraDescr` VARCHAR(255) AFTER `Group`,');
                Add('ADD COLUMN `ModelNo` VARCHAR(20) AFTER `ExtraDescr`,');
                Add('ADD INDEX `BarcodeInd`(`Barcode`)');
                Add(', ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`invoiceitem_db` ADD COLUMN `CostPrice` DECIMAL(10,2) AFTER `AmmountChangeSwi`,');
                Add('ADD COLUMN `Price2` DECIMAL(10,2) AFTER `CostPrice`,');
                Add('ADD COLUMN `Barcode` VARCHAR(30) AFTER `Price2`,');
                Add('ADD COLUMN `TCStockNo` VARCHAR(20) AFTER `Barcode`,');
                Add('ADD COLUMN `ExtraDescr` VARCHAR(255) AFTER `TCStockNo`,');
                Add('ADD COLUMN `ModelNo` VARCHAR(20) AFTER `ExtraDescr`,');
                Add('ADD COLUMN `Comment` VARCHAR(10) AFTER `ModelNo`');
                Add(', ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`invoiceitem_db` ADD COLUMN `Discount` DECIMAL(10,2) AFTER `Comment`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`bank_db` ADD COLUMN `LinkType` VARCHAR(1) NOT NULL DEFAULT ''M'' AFTER `LinkID`,');
                Add('DROP INDEX `LinkIdInd`,');
                Add('ADD INDEX `LinkIdInd` USING BTREE(`LinkID`, `LinkType`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`marketer_db` ADD COLUMN `ReserveAcc` DECIMAL(10,2) AFTER `Manager`,');
                Add('DROP INDEX `CodeInd`,');
                Add('ADD UNIQUE INDEX `CodeInd` USING BTREE(`Code`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`Policy_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`PolicyNo` VARCHAR(30),');
                Add('`RefNo` VARCHAR(30),');
                Add('`PolicyDate` INTEGER UNSIGNED,');
                Add('`PolicySurname` VARCHAR(30),');
                Add('`PolicyInitials` VARCHAR(20),');
                Add('`AgentCode` VARCHAR(20),');
                Add('`PolicyPremium` DECIMAL(10,2),');
                Add('`PolicyType` SMALLINT UNSIGNED,');
                Add('`PolicyPaymentType` SMALLINT UNSIGNED,');
                Add('`PolicyFullCommision` DECIMAL(10,2),');
                Add('`Closed` VARCHAR(5),');
                Add('PRIMARY KEY (`Nr`))');
                Add('ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`PolicyPayment_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Date` INTEGER UNSIGNED,');
                Add('`Year` SMALLINT UNSIGNED,');
                Add('`Month` SMALLINT UNSIGNED,');
                Add('`LinkID` INTEGER UNSIGNED,');
                Add('`Commision` DECIMAL(10,2),');
                Add('`TenPerc` DECIMAL(10,2),');
                Add('PRIMARY KEY (`Nr`))');
                Add('ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `Over21Confirm` VARCHAR(5) AFTER `ImportSwi`;');
              end;
              Query.ExecSQL;
            end;
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''policy_db''');
              Add('and COLUMN_NAME=''Sort''');
            end;
            Query.Open;

            //  v1.0.3.3
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`PolicyPayment_db` ADD COLUMN `Payed` INTEGER UNSIGNED AFTER `TenPerc`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`PolicyPayment_db` ADD COLUMN `User` VARCHAR(45) AFTER `Payed`,');
                Add('ADD COLUMN `DateStamp` VARCHAR(20) AFTER `User`');
                Add(', ROW_FORMAT = DYNAMIC;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`Policy_db` ADD COLUMN `Sort` SMALLINT UNSIGNED AFTER `Closed`,');
                Add('ADD INDEX `AgentCode`(`AgentCode`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`PolicyStatements_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`AgentCode` VARCHAR(20) NOT NULL,');
                Add('`Date` INTEGER UNSIGNED,');
                Add('`StatementTotal` DECIMAL(10,2),');
                Add('`ReservedTotal` DECIMAL(10,2),');
                Add('`Payed` INTEGER UNSIGNED,');
                Add('PRIMARY KEY (`Nr`),');
                Add('INDEX `AgentCodeInd`(`AgentCode`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`PolicyPayment_db` ADD COLUMN `Gross` DECIMAL(10,2) AFTER `DateStamp`,');
                Add('ADD INDEX `LinkIDInd`(`LinkID`);');
              end;
              Query.ExecSQL;
            end;


            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''children_db''');
              Add('and COLUMN_NAME=''WaitingPeriod''');
            end;
            Query.Open;

            //  v1.0.3.6
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `WaitingPeriod` INTEGER(3) UNSIGNED AFTER `Over21Confirm`,');
                Add('ADD COLUMN `SpecialProduct1` SMALLINT UNSIGNED AFTER `WaitingPeriod`,');
                Add('ADD COLUMN `SpecialProduct2` SMALLINT UNSIGNED AFTER `SpecialProduct1`,');
                Add('ADD COLUMN `SpecialProduct3` SMALLINT UNSIGNED AFTER `SpecialProduct2`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `BranchNo` INTEGER UNSIGNED AFTER `Medium`,');
                Add('ADD COLUMN `SyncHQ` INTEGER UNSIGNED AFTER `BranchNo`,');
                Add('ADD COLUMN `SpecialProduct1` INTEGER UNSIGNED AFTER `SyncHQ`,');
                Add('ADD COLUMN `SpecialProduct2` INTEGER UNSIGNED AFTER `SpecialProduct1`,');
                Add('ADD COLUMN `SpecialProduct3` INTEGER UNSIGNED AFTER `SpecialProduct2`');
                Add(', ROW_FORMAT = DYNAMIC;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` ADD COLUMN `SSpecialProduct1` INTEGER UNSIGNED AFTER `SImportSwi`,');
                Add('ADD COLUMN `SSpecialProduct2` INTEGER UNSIGNED AFTER `SSpecialProduct1`,');
                Add('ADD COLUMN `SSpecialProduct3` INTEGER UNSIGNED AFTER `SSpecialProduct2`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `SpecialProduct1` INTEGER UNSIGNED AFTER `ImportSwi`,');
                Add('ADD COLUMN `SpecialProduct2` INTEGER UNSIGNED AFTER `SpecialProduct1`,');
                Add('ADD COLUMN `SpecialProduct3` INTEGER UNSIGNED AFTER `SpecialProduct2`');
                Add(', ENGINE = InnoDB;');
              end;
              Query.ExecSql;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `Owner` VARCHAR(30) AFTER `FSPNo`,');
                Add('ADD COLUMN `BankAccHolder` VARCHAR(30) AFTER `Owner`');
                Add(', ROW_FORMAT = DYNAMIC;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`pay_db` ADD COLUMN `BranchNo` INTEGER UNSIGNED AFTER `Type`,');
                Add('ADD COLUMN `SyncHQ` INTEGER UNSIGNED AFTER `BranchNo`');
                Add(', ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `IncludedPremium` VARCHAR(5) AFTER `SpecialProduct3`');
                Add(', ROW_FORMAT = DYNAMIC;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `Under1Premium` DECIMAL(10,2) AFTER `ManagerCommAmmount`,');
                Add('ADD COLUMN `Under1Coverage` DECIMAL(10,2) AFTER `Under1Premium`,');
                Add('ADD COLUMN `Under1SpouseCover` DECIMAL(10,2) AFTER `Under1Coverage`,');
                Add('ADD COLUMN `Under1Child1Cover` DECIMAL(10,2) AFTER `Under1SpouseCover`,');
                Add('ADD COLUMN `Under1Child2Cover` DECIMAL(10,2) AFTER `Under1Child1Cover`,');
                Add('ADD COLUMN `Under1Child3Cover` DECIMAL(10,2) AFTER `Under1Child2Cover`,');
                Add('ADD COLUMN `Under1StillBorn` DECIMAL(10,2) AFTER `Under1Child3Cover`,');
                Add('ADD COLUMN `Under2Premium` DECIMAL(10,2) AFTER `Under1StillBorn`,');
                Add('ADD COLUMN `Under2Coverage` DECIMAL(10,2) AFTER `Under2Premium`,');
                Add('ADD COLUMN `Under2SpouseCover` DECIMAL(10,2) AFTER `Under2Coverage`,');
                Add('ADD COLUMN `Under2Child1Cover` DECIMAL(10,2) AFTER `Under2SpouseCover`,');
                Add('ADD COLUMN `Under2Child2Cover` DECIMAL(10,2) AFTER `Under2Child1Cover`,');
                Add('ADD COLUMN `Under2Child3Cover` DECIMAL(10,2) AFTER `Under2Child2Cover`,');
                Add('ADD COLUMN `Under2StillBorn` DECIMAL(10,2) AFTER `Under2Child3Cover`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `Under1Name` VARCHAR(30) AFTER `Under2StillBorn`,');
                Add('ADD COLUMN `Under2Name` VARCHAR(30) AFTER `Under1Name`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.TABLES');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''bank_db''');
              Add('and ENGINE=''InnoDB''');
            end;
            Query.Open;

            //  v1.0.3.7
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD INDEX `RefNoInd`(`RefNr`)');
                Add(', ROW_FORMAT = DYNAMIC;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`bank_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`beneficiary_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ENGINE = InnoDB;');
              end;
              Query.ExecSql;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`institution_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`marketer_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`productlist_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`totals_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`user_db` ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''pay_db''');
              Add('and COLUMN_NAME=''SyncBranch''');
            end;
            Query.Open;
      //1.0.3.8

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`pay_db` ADD COLUMN `SyncBranch` INTEGER UNSIGNED AFTER `SyncHQ`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `SyncBranch` INTEGER UNSIGNED AFTER `SpecialProduct3`;');
              end;
              Query.ExecSQL;
            end;


            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''spouse_db''');
              Add('and COLUMN_NAME=''SSyncHQ''');
            end;
            Query.Open;
      //1.0.3.13

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` ADD COLUMN `SSyncHQ` INTEGER UNSIGNED AFTER `SSpecialProduct3`,');
                Add('ADD COLUMN `SSyncBranch` INTEGER UNSIGNED AFTER `SSyncHQ`,');
                Add('ADD COLUMN `SBranchNo` SMALLINT UNSIGNED AFTER `SSyncBranch`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `SyncHQ` INTEGER UNSIGNED AFTER `SpecialProduct3`,');
                Add('ADD COLUMN `SyncBranch` INTEGER UNSIGNED AFTER `SyncHQ`,');
                Add('ADD COLUMN `BranchNo` SMALLINT UNSIGNED AFTER `SyncBranch`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `SyncHQ` INTEGER UNSIGNED AFTER `IncludedPremium`,');
                Add('ADD COLUMN `SyncBranch` INTEGER UNSIGNED AFTER `SyncHQ`,');
                Add('ADD COLUMN `BranchNo` INTEGER UNSIGNED AFTER `SyncBranch`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`pay_db` set BranchNo = 0');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`pay_db` MODIFY COLUMN `BranchNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,');
                Add('DROP PRIMARY KEY,');
                Add('ADD PRIMARY KEY  USING BTREE(`Nr`, `BranchNo`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` ADD COLUMN `SyncHQ` INTEGER UNSIGNED AFTER `System`,');
                Add('ADD COLUMN `SyncBranch` INTEGER UNSIGNED AFTER `SyncHQ`,');
                Add('ADD COLUMN `BranchNo` SMALLINT UNSIGNED AFTER `SyncBranch`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`notes_db` set BranchNo = 0');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` MODIFY COLUMN `BranchNo` SMALLINT UNSIGNED NOT NULL DEFAULT 0,');
                Add('ADD COLUMN `ChangeDate` INTEGER UNSIGNED AFTER `BranchNo`,');
                Add('DROP PRIMARY KEY,');
                Add('ADD PRIMARY KEY  USING BTREE(`Nr`, `BranchNo`);');
              end;
              Query.ExecSQL;
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('select Nr, SyncHQ from `' + Schema.Text + '`.`member_db`');
                Add('where SyncHQ is not null');
              end;
              Query.Open;
              Query.DisableControls;
              try
                Query.First;
                while not Query.EOF do
                begin
                  Query2.Close;
                  with Query2.SQL do begin
                    Clear;
                    Add('update `' + Schema.Text + '`.`spouse_db` set SSyncHQ = ' + InttoStr(Query.FieldByName('SyncHQ').asInteger));
                    Add('where LinkID = ' + InttoStr(Query.FieldByName('Nr').asInteger));
                  end;
                  Query2.ExecSQL;
                  with Query2.SQL do begin
                    Clear;
                    Add('update `' + Schema.Text + '`.`children_db` set SyncHQ = ' + InttoStr(Query.FieldByName('SyncHQ').asInteger));
                    Add('where LinkID = ' + InttoStr(Query.FieldByName('Nr').asInteger));
                  end;
                  Query2.ExecSQL;
                  with Query2.SQL do begin
                    Clear;
                    Add('update `' + Schema.Text + '`.`extended_db` set SyncHQ = ' + InttoStr(Query.FieldByName('SyncHQ').asInteger));
                    Add('where LinkID = ' + InttoStr(Query.FieldByName('Nr').asInteger));
                  end;
                  Query2.ExecSQL;
//                with Query2.SQL do begin
//                  Clear;
//                  Add('update `' + Schema.Text + '`.`notes_db` set SyncHQ = ' + InttoStr(Query.FieldByName('SyncHQ').asInteger));
//                  Add('where LinkID = ' + InttoStr(Query.FieldByName('Nr').asInteger));
//                end;
//                Query2.ExecSQL;

                  Query.Next;
                end;
              finally
              end;
              Query.EnableControls;
              Query.Close;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''memberx_db''');
              Add('and COLUMN_NAME=''DateofDeath''');
            end;
            Query.Open;
    //  1.0.4.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`member_db` set BranchNo = 0');
                Add('where BranchNo is null');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`spouse_db` set SBranchNo = 0');
                Add('where SBranchNo is null');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`children_db` set BranchNo = 0');
                Add('where BranchNo is null');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`extended_db` set BranchNo = 0');
                Add('where BranchNo is null');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` DROP PRIMARY KEY,');
                Add('ADD PRIMARY KEY  USING BTREE(`Nr`, `BranchNo`)');
               end;
               Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` DROP COLUMN `PolicyStatus`,');
                Add('ADD COLUMN `SpecialProduct1Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct1WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3WP` SMALLINT UNSIGNED;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`memberx_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`DateofDeath` INTEGER UNSIGNED,');
                Add('`LastChangedBy` VARCHAR(20),');
                Add('`LinkID` INTEGER UNSIGNED NOT NULL,');
                Add('`BranchNo` INTEGER UNSIGNED,');
                Add('PRIMARY KEY (`Nr`),');
                Add('UNIQUE INDEX `LinkInd`(`LinkID`, `BranchNo`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `SpecialProduct1Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct1WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3WP` SMALLINT UNSIGNED,');
                Add('DROP INDEX `LinkIdInd`,');
                Add('ADD INDEX `LinkIdInd` USING BTREE(`LinkID`, `BranchNo`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` ADD COLUMN `SpecialProduct1Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct1WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3WP` SMALLINT UNSIGNED,');
                Add('DROP INDEX `LinkIdInd`,');
                Add('ADD INDEX `LinkIdInd` USING BTREE(`LinkID`, `SBranchNo`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `SpecialProduct1Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3Date` INTEGER UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct1WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct2WP` SMALLINT UNSIGNED,');
                Add('ADD COLUMN `SpecialProduct3WP` SMALLINT UNSIGNED,');
                Add('DROP INDEX `LinkIDInd`,');
                Add('ADD INDEX `LinkIDInd` USING BTREE(`LinkID`, `BranchNo`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` DROP PRIMARY KEY,');
                Add('ADD PRIMARY KEY  USING BTREE(`Nr`),');
                Add('DROP INDEX `LinkInd`,');
                Add('ADD UNIQUE INDEX `LinkInd` USING BTREE(`LinkID`, `BranchNo`, `FromWhere`, `Nr`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`bank_db` ADD COLUMN `BranchNo` SMALLINT UNSIGNED AFTER `LinkType`,');
                Add('DROP INDEX `LinkIdInd`,');
                Add('ADD INDEX `LinkIdInd` USING BTREE(`LinkID`, `BranchNo`, `LinkType`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`bank_db` set BranchNo = 0');
                Add('where BranchNo is null');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`institution_db` ADD COLUMN `BranchNo` SMALLINT UNSIGNED AFTER `LinkId`,');
                Add('DROP INDEX `LinkIdInd`,');
                Add('ADD INDEX `LinkIdInd` USING BTREE(`LinkId`, `BranchNo`);');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('update `' + Schema.Text + '`.`institution_db` set BranchNo = 0');
                Add('where BranchNo is null');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` CHANGE COLUMN `SSpecialProduct1` `SpecialProduct1` INTEGER UNSIGNED DEFAULT NULL,');
                Add('CHANGE COLUMN `SSpecialProduct2` `SpecialProduct2` INTEGER UNSIGNED DEFAULT NULL,');
                Add('CHANGE COLUMN `SSpecialProduct3` `SpecialProduct3` INTEGER UNSIGNED DEFAULT NULL;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `SpecialProduct1RTotal` DECIMAL(10,2) AFTER `BankAccHolder`,');
                Add('ADD COLUMN `SpecialProduct2RTotal` DECIMAL(10,2) AFTER `SpecialProduct1RTotal`,');
                Add('ADD COLUMN `SpecialProduct3RTotal` DECIMAL(10,2) AFTER `SpecialProduct2RTotal`,');
                Add('ADD COLUMN `SpecialProduct1UTotal` DECIMAL(10,2) AFTER `SpecialProduct3RTotal`,');
                Add('ADD COLUMN `SpecialProduct2UTotal` DECIMAL(10,2) AFTER `SpecialProduct1UTotal`,');
                Add('ADD COLUMN `SpecialProduct3UTotal` DECIMAL(10,2) AFTER `SpecialProduct2UTotal`;');
              end;
              Query.ExecSQL;
              with Query.SQL do begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`totals_db` ADD COLUMN `SpecialProduct1RTotal` DECIMAL(10,2) AFTER `Type`,');
                Add('ADD COLUMN `SpecialProduct2RTotal` DECIMAL(10,2) AFTER `SpecialProduct1RTotal`,');
                Add('ADD COLUMN `SpecialProduct3RTotal` DECIMAL(10,2) AFTER `SpecialProduct2RTotal`,');
                Add('ADD COLUMN `SpecialProduct1UTotal` DECIMAL(10,2) AFTER `SpecialProduct3RTotal`,');
                Add('ADD COLUMN `SpecialProduct2UTotal` DECIMAL(10,2) AFTER `SpecialProduct1UTotal`,');
                Add('ADD COLUMN `SpecialProduct3UTotal` DECIMAL(10,2) AFTER `SpecialProduct2UTotal`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''group_db''');
              Add('and COLUMN_NAME=''DebitOrderActionDay''');
            end;
            Query.Open;
    //1.0.6.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `DebitOrderDir` VARCHAR(100) AFTER `SpecialProduct3UTotal`,');
                Add('ADD COLUMN `DebitOrderActionDay` SMALLINT(2) UNSIGNED AFTER `DebitOrderDir`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`bank_db` ADD COLUMN `OldSwitch` VARCHAR(5) AFTER `BranchNo`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`pay_db` ADD COLUMN `SysDateStamp` TIMESTAMP AFTER `SyncBranch`,');
                Add('ADD COLUMN `RDReason` VARCHAR(45) AFTER `SysDateStamp`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` ADD COLUMN `SysDateStamp` TIMESTAMP AFTER `ChangeDate`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `ServerCheck` VARCHAR(30) AFTER `PurchaseInvNo`,');
                Add('ADD COLUMN `MemberCnt` INTEGER UNSIGNED AFTER `ServerCheck`,');
                Add('ADD COLUMN `ExtendedCnt` INTEGER UNSIGNED AFTER `MemberCnt`,');
                Add('ADD COLUMN `SpecialPCnt` INTEGER UNSIGNED AFTER `ExtendedCnt`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`invoiceitem_db` ADD COLUMN `BranchNo` INTEGER UNSIGNED AFTER `Discount`,');
                Add('DROP INDEX `LinkInd`,');
                Add('ADD INDEX `LinkInd` USING BTREE(`LinkId`, `BranchNo`);');
              end;
              Query.ExecSQL;
            end;
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''death_db''');
              Add('and COLUMN_NAME=''BodyNo''');
            end;
            Query.Open;
    //1.0.6.1

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ADD COLUMN `BodyNo` INTEGER UNSIGNED AFTER `MainMemberRefNr`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`invoice_db` DROP INDEX `InvNoInd`,');
                Add('ADD UNIQUE INDEX `InvNoInd` USING BTREE(`BranchNo`, `InvNo`, `InvClose`);');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''product_db''');
              Add('and COLUMN_NAME=''Extra1TimeCom''');
            end;
            Query.Open;
    //1.0.7.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `Extra1TimeCom` DECIMAL(10,2) AFTER `Under2Name`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `MainPolicy` VARCHAR(20) AFTER `SpecialProduct3WP`,');
                Add('ADD INDEX `MainPolicyInd`(`MainPolicy`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`Policy_db` RENAME TO `' + Schema.Text + '`.`policy_db`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`PolicyPayment_db` RENAME TO `' + Schema.Text + '`.`policypayment_db`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`PolicyStatements_db` RENAME TO `' + Schema.Text + '`.`policystatements_db`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`policy_db` ADD COLUMN `PolicyTelC` VARCHAR(30) AFTER `Sort`,');
                Add('ADD COLUMN `PolicyEMail` VARCHAR(45) AFTER `PolicyTelC`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''totals_db''');
              Add('and COLUMN_NAME=''PaymentsTotal''');
            end;
            Query.Open;
    //1.0.8.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`totals_db` ADD COLUMN `PaymentsTotal` DECIMAL(10,2) AFTER `SpecialProduct3UTotal`,');
                Add('ADD COLUMN `JFeeTotal` DECIMAL(10,2) AFTER `PaymentsTotal`,');
                Add('ADD COLUMN `DebitOrderTotal` DECIMAL(10,2) AFTER `JFeeTotal`,');
                Add('ADD COLUMN `CashTotal` DECIMAL(10,2) AFTER `DebitOrderTotal`,');
                Add('ADD COLUMN `StopOrderTotal` DECIMAL(10,2) AFTER `CashTotal`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''spouse_db''');
              Add('and COLUMN_NAME=''SID''');
              Add('and COLUMN_KEY=''MUL''');
            end;
            Query.Open;
    //1.0.8.5

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` ADD INDEX `IDInd`(`SID`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD INDEX `IDInd`(`ID`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD INDEX `IDInd`(`ID`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ADD INDEX `FromIDInd`(`FromId`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` DROP INDEX `LinkInd`,');
                Add('ADD INDEX `LinkInd` USING BTREE(`LinkID`, `BranchNo`, `FromWhere`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` DROP INDEX `GroupLinkInd`,');
                Add('ADD INDEX `GroupLinkInd` USING BTREE(`PLLink`);');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''ReceiptTop''');
            end;
            Query.Open;
    //1.0.9.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` DROP COLUMN `SpecialPCnt`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` DROP COLUMN `ExtendedCnt`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` DROP COLUMN `MemberCnt`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` DROP COLUMN `ServerCheck`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `ReceiptTop` BLOB AFTER `PurchaseInvNo`,');
                Add('ADD COLUMN `ReceiptBottom` BLOB AFTER `ReceiptTop`,');
                Add('ADD COLUMN `InvBottom` BLOB AFTER `ReceiptBottom`,');
                Add('ADD COLUMN `ReportTitle` VARCHAR(100) AFTER `InvBottom`,');
                Add('ADD COLUMN `CoverageReplace` VARCHAR(20) AFTER `ReportTitle`,');
                Add('ADD COLUMN `ExtraChildFeeCount` INTEGER UNSIGNED AFTER `CoverageReplace`,');
                Add('ADD COLUMN `BehindDay` INTEGER UNSIGNED AFTER `ExtraChildFeeCount`,');
                Add('ADD COLUMN `TestRefNo` VARCHAR(2) AFTER `BehindDay`,');
                Add('ADD COLUMN `ValidateID` VARCHAR(2) AFTER `TestRefNo`,');
                Add('ADD COLUMN `Check21` VARCHAR(2) AFTER `ValidateID`,');
                Add('ADD COLUMN `DisallowRecDate` VARCHAR(2) AFTER `Check21`,');
                Add('ADD COLUMN `AllowPremMonthList` VARCHAR(2) AFTER `DisallowRecDate`,');
                Add('ADD COLUMN `RequiredFields` VARCHAR(2) AFTER `AllowPremMonthList`,');
                Add('ADD COLUMN `AgentField` VARCHAR(2) AFTER `RequiredFields`,');
                Add('ADD COLUMN `NotesReminder` VARCHAR(2) AFTER `AgentField`,');
                Add('ADD COLUMN `RefNoField` VARCHAR(2) AFTER `NotesReminder`,');
                Add('ADD COLUMN `CoverStartDateBehindDay` VARCHAR(2) AFTER `RefNoField`,');
                Add('ADD COLUMN `ShowRecRefNo` VARCHAR(2) AFTER `CoverStartDateBehindDay`,');
                Add('ADD COLUMN `PaymentYrMnthBehindDay` VARCHAR(2) AFTER `ShowRecRefNo`,');
                Add('ADD COLUMN `21Reminder` VARCHAR(2) AFTER `PaymentYrMnthBehindDay`,');
                Add('ADD COLUMN `AutoWP` VARCHAR(2) AFTER `21Reminder`,');
                Add('ADD COLUMN `CanIns` VARCHAR(2) AFTER `AutoWP`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`user_db` ADD COLUMN `SMSUsername` VARCHAR(45) AFTER `LastLogon`,');
                Add('ADD COLUMN `SMSPassword` VARCHAR(45) AFTER `SMSUsername`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `Claim` LONGBLOB AFTER `21Reminder`,');
                Add('ADD COLUMN `Discloser` LONGBLOB AFTER `Claim`,');
                Add('ADD COLUMN `Terms` LONGBLOB AFTER `Discloser`,');
                Add('ADD COLUMN `Title` LONGBLOB AFTER `Terms`,');
                Add('ADD COLUMN `Benefits` LONGBLOB AFTER `Title`,');
                Add('ADD COLUMN `ParticPath` VARCHAR(150) AFTER `Benefits`,');
                Add('ADD COLUMN `ParticRelBlank` VARCHAR(2) AFTER `ParticPath`,');
                Add('ADD COLUMN `ParticShowCan` VARCHAR(2) AFTER `ParticRelBlank`,');
                Add('ADD COLUMN `ParticPlanName` VARCHAR(2) AFTER `ParticShowCan`,');
                Add('ADD COLUMN `ParticLogoWidth` FLOAT AFTER `ParticPlanName`,');
                Add('ADD COLUMN `ParticLogoHeight` FLOAT AFTER `ParticLogoWidth`,');
                Add('ADD COLUMN `ParticLogoLeft` FLOAT AFTER `ParticLogoHeight`,');
                Add('ADD COLUMN `PartFormat` VARCHAR(45) DEFAULT ''Format 3'' AFTER `ParticLogoLeft`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`bank_db` ADD COLUMN `TimePeriod` INTEGER UNSIGNED DEFAULT 0 AFTER `OldSwitch`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''smsmessage''');
              Add('and COLUMN_NAME=''Incomingid''');
            end;
            Query.Open;
      //1.0.9.3

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` MODIFY COLUMN `Description` VARCHAR(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`smsmessage` (');
                Add('`idSMSMessage` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Incomingid` INTEGER UNSIGNED,');
                Add('`Sentid` INTEGER UNSIGNED,');
                Add('`Phonenumber` VARCHAR(30),');
                Add('`Data` VARCHAR(200),');
                Add('`ReceivedDate` VARCHAR(30),');
                Add('`ReadSwitch` VARCHAR(5) DEFAULT ''False'',');
                Add('`CustomerID` VARCHAR(20),');
                Add('PRIMARY KEY (`idSMSMessage`),');
                Add('INDEX `IncomongidInd`(`Incomingid`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`smsmessage` ADD COLUMN `SMSUserName` VARCHAR(45) AFTER `CustomerID`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''DebitOrderDir''');
            end;
            Query.Open;
    //1.0.9.6

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` CHANGE COLUMN `MainPolicy` `MainPolicyNr` INTEGER UNSIGNED DEFAULT NULL,');
                Add('ADD COLUMN `MainPolicyBranch` INTEGER UNSIGNED DEFAULT 0 AFTER `MainPolicyNr`,');
                Add('DROP INDEX `MainPolicyInd`,');
                Add('ADD INDEX `MainPolicyInd` USING BTREE(`MainPolicyNr`, `MainPolicyBranch`);');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `MaxSMS` BIGINT UNSIGNED AFTER `CanIns`,');
                Add('ADD COLUMN `DebitOrderDir` VARCHAR(100) AFTER `MaxSMS`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` DROP COLUMN `DebitOrderDir`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''DAccNo''');
            end;
            Query.Open;
      //1.1.0.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `SP1DescrLink` INTEGER UNSIGNED AFTER `DebitOrderActionDay`,');
                Add('ADD COLUMN `SP2DescrLink` INTEGER UNSIGNED AFTER `SP1DescrLink`,');
                Add('ADD COLUMN `SP3DescrLink` INTEGER UNSIGNED AFTER `SP2DescrLink`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`proddescr_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Description` VARCHAR(45),');
                Add('PRIMARY KEY (`Nr`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ADD COLUMN `DescrLink` INTEGER UNSIGNED AFTER `BodyNo`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`pay_db` ADD COLUMN `UnderPrice` DECIMAL(10,2) AFTER `RDReason`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`accounts_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`AccNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,');
                Add('`Name` VARCHAR(45),');
                Add('`Surname` VARCHAR(45),');
                Add('`ID` VARCHAR(20),');
                Add('`AccType` INTEGER UNSIGNED NOT NULL,');
                Add('`CompanyName` VARCHAR(45),');
                Add('`Tel` VARCHAR(20),');
                Add('`TelF` VARCHAR(20),');
                Add('`TelC` VARCHAR(20),');
                Add('`HAdr1` VARCHAR(30),');
                Add('`HAdr2` VARCHAR(30),');
                Add('`HAdr3` VARCHAR(30),');
                Add('`PAdr1` VARCHAR(30),');
                Add('`PAdr2` VARCHAR(30),');
                Add('`PAdr3` VARCHAR(30),');
                Add('`PCode` VARCHAR(5),');
                Add('`EMail` VARCHAR(45),');
                Add('`ChangeDate` INTEGER UNSIGNED,');
                Add('`CreateDate` INTEGER UNSIGNED,');
                Add('`BeginDate` INTEGER UNSIGNED,');
                Add('`EndDate` INTEGER UNSIGNED DEFAULT 0,');
                Add('`ByUser` VARCHAR(20),');
                Add('`DueDays` INTEGER UNSIGNED,');
                Add('`Total` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('`BranchNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,');
                Add('`SyncHQ` INTEGER UNSIGNED,');
                Add('`SyncBranch` INTEGER UNSIGNED,');
                Add('`Days30` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('`Days60` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('`Days90` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('`Days120` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('`Current` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('`RefNo` VARCHAR(30),');
                Add('`TCNo` VARCHAR(20),');
                Add('`BeginTotal` DECIMAL(10,2) NOT NULL DEFAULT 0,');
                Add('PRIMARY KEY (`Nr`),');
                Add('UNIQUE INDEX `AccNoInd`(`AccNo`, `BranchNo`, `AccType`),');
                Add('INDEX `IDInd`(`ID`),');
                Add('INDEX `AccNameInd`(`Surname`,`Name`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add(' CREATE TABLE `' + Schema.Text + '`.`trans_db` (');
                Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                Add('`Description` varchar(30) default NULL,');
                Add('`Ammount` decimal(10,2) default NULL,');
                Add('`Date` int(10) unsigned default NULL,');
                Add('`LinkID` int(10) unsigned NOT NULL default ''0'',');
                Add('`ShiftSet` int(10) unsigned default NULL,');
                Add('`SyncHQ` int(10) unsigned default NULL,');
                Add('`PaymentType` varchar(15) default NULL,');
                Add('`CUSet` int(10) unsigned default NULL,');
                Add('`PaymentBy` varchar(45) default NULL,');
                Add('`BranchNo` int(10) unsigned NOT NULL default ''0'',');
                Add('`TYear` INTEGER UNSIGNED,');
                Add('`TMonth` INTEGER UNSIGNED,');
                Add('`SyncBranch` INTEGER UNSIGNED,');
                Add('`TransType` CHAR(1) DEFAULT ''L'',');
                Add('`IInvNo` INTEGER UNSIGNED,');
                Add('`IBranchNo` INTEGER UNSIGNED,');
                Add('`RefNo` VARCHAR(20),');
                Add('PRIMARY KEY  (`Nr`),');
                Add('INDEX `LinkIDInd` (`LinkID`, `BranchNo`)');
                Add(') ENGINE=InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `DAccNo` INTEGER UNSIGNED DEFAULT 0 AFTER `DebitOrderDir`,');
                Add('ADD COLUMN `CAccNo` INTEGER UNSIGNED DEFAULT 0 AFTER `DAccNo`,');
                Add('ADD COLUMN `DActiveMonth` INTEGER UNSIGNED DEFAULT 0 AFTER `CAccNo`,');
                Add('ADD COLUMN `CActiveMonth` INTEGER UNSIGNED DEFAULT 0 AFTER `DActiveMonth`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `FormFooter` VARCHAR(250) DEFAULT ''Tel: 012 993 1313, Fax: 086 551 8360'' AFTER `CActiveMonth`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`totals_db` ADD COLUMN `TimeStamp` TIMESTAMP AFTER `StopOrderTotal`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('INSERT INTO `' + Schema.Text + '`.`proddescr_db` (`Nr`,`Description`) VALUES');
                Add('(1,''Funeral''),');
                Add('(2,''Beef''),');
                Add('(3,''Tombstone'');');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''member_db''');
              Add('and COLUMN_NAME=''NickName''');
            end;
            Query.Open;
    //1.1.1.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `NickName` VARCHAR(30) AFTER `MainPolicyBranch`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`spouse_db` ADD COLUMN `SNickName` VARCHAR(30) AFTER `SpecialProduct3WP`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `NickName` VARCHAR(30) AFTER `SpecialProduct3WP`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `NickName` VARCHAR(30) AFTER `SpecialProduct3WP`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`extrabirths` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Name` VARCHAR(45),');
                Add('`TelC` VARCHAR(20),');
                Add('`BirthDate` INTEGER UNSIGNED,');
                Add('PRIMARY KEY (`Nr`),');
                Add('INDEX `BirthDateInd`(`BirthDate`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` MODIFY COLUMN `CoverageReplace` VARCHAR(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`doks_db` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`LinkID` INTEGER UNSIGNED NOT NULL,');
                Add('`BranchNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,');
                Add('`FromWhere` CHAR NOT NULL DEFAULT ''M'',');
                Add('`Data` LONGBLOB,');
                Add('PRIMARY KEY (`Nr`),');
                Add('INDEX `LinkIDInd`(`LinkID`, `BranchNo`, `FromWhere`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `3CommStructure` INTEGER(1) UNSIGNED AFTER `Extra1TimeCom`,');
                Add('ADD COLUMN `3CommAmmount` DECIMAL(10,2) AFTER `3CommStructure`,');
                Add('ADD COLUMN `4CommStructure` INTEGER(1) UNSIGNED AFTER `3CommAmmount`,');
                Add('ADD COLUMN `4CommAmmount` DECIMAL(10,2) AFTER `4CommStructure`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`doks_db` ADD COLUMN `SentRiskfin` INTEGER UNSIGNED AFTER `Data`,');
                Add('ADD COLUMN `CreateDate` INTEGER UNSIGNED AFTER `SentRiskfin`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`totals_db` ADD COLUMN `ClaimsRatioSMS` INTEGER UNSIGNED AFTER `TimeStamp`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''children_db''');
              Add('and COLUMN_NAME=''KindofChild''');
            end;
            Query.Open;
    //1.1.1.3

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                 Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `KindofChild` SMALLINT UNSIGNED DEFAULT 0 AFTER `NickName`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`accounts_db` ADD COLUMN `PaaiementDatum` INTEGER UNSIGNED AFTER `BeginTotal`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''accounts_db''');
              Add('and COLUMN_NAME=''Premium''');
            end;
            Query.Open;
    //1.1.1.5

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`accounts_db` ADD COLUMN `Premium` DECIMAL(10,2) AFTER `PaaiementDatum`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''MTBehindCalc''');
            end;
            Query.Open;
    //1.1.1.8

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `MTBehindCalc` VARCHAR(2) DEFAULT 0 AFTER `FormFooter`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''accounts_db''');
              Add('and COLUMN_NAME=''NumberofPayments''');
            end;
            Query.Open;
    //1.1.1.15

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`accounts_db` ADD COLUMN `NumberofPayments` INTEGER UNSIGNED AFTER `Premium`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `GlobalMonths` VARCHAR(2) DEFAULT 0 AFTER `MTBehindCalc`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''accounts_db''');
              Add('and COLUMN_NAME=''LastPayment''');
            end;
            Query.Open;
    //1.1.1.23

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`accounts_db` ADD COLUMN `LastPayment` INTEGER UNSIGNED AFTER `NumberofPayments`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''group_db''');
              Add('and COLUMN_NAME=''ParticipationLocation''');
            end;
            Query.Open;
    //1.1.2.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `ParticipationLocation` VARCHAR(250) AFTER `SP3DescrLink`,');
                Add('ADD COLUMN `ImportSwitches` VARCHAR(250) AFTER `ParticipationLocation`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''product_db''');
              Add('and COLUMN_NAME=''5CommStructure''');
            end;
            Query.Open;
    //1.1.2.6

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `5CommStructure` INTEGER(1) UNSIGNED AFTER `4CommAmmount`,');
                Add('ADD COLUMN `5CommAmmount` DECIMAL(10,2) AFTER `5CommStructure`,');
                Add('ADD COLUMN `6CommStructure` INTEGER(1) UNSIGNED AFTER `5CommAmmount`,');
                Add('ADD COLUMN `6CommAmmount` DECIMAL(10,2) AFTER `6CommStructure`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''BranchNo''');
            end;
            Query.Open;
    //1.1.2.8

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `BranchNo` INTEGER UNSIGNED DEFAULT NULL AFTER `GlobalMonths`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD INDEX `AgentcodeInd`(`Agentcode`);');
              end;
              Query.ExecSQL;
            end;
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''networkbonus''');
              Add('and COLUMN_NAME=''PoliciesTotal''');
            end;
            Query.Open;
    //1.1.2.9

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`networkbonus` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`PoliciesLevel1` INTEGER UNSIGNED,');
                Add('`PoliciesTotal` INTEGER UNSIGNED,');
                Add('`Bonus` DECIMAL(10,2),');
                Add('PRIMARY KEY (`Nr`),');
                Add('INDEX `PoliciesInd`(`PoliciesLevel1`, `PoliciesTotal`)');
                Add(') ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''UseAccNoasBodyNo''');
            end;
            Query.Open;
    //1.1.3.0

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `UseAccNoasBodyNo` VARCHAR(2) DEFAULT 0 AFTER `BranchNo`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''group_db''');
              Add('and COLUMN_NAME=''UWRefNo''');
            end;
            Query.Open;
    //1.1.3.3

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `UWRefNo` VARCHAR(45) AFTER `ImportSwitches`,');
                Add('ADD COLUMN `DebtorLink` VARCHAR(20) AFTER `UWRefNo`,');
                Add('ADD COLUMN `KontrakOntv` INTEGER UNSIGNED DEFAULT 0 AFTER `DebtorLink`,');
                Add('ADD COLUMN `KwotasieOntv` INTEGER UNSIGNED DEFAULT 0 AFTER `KontrakOntv`,');
                Add('ADD COLUMN `KontrakGestuur` INTEGER UNSIGNED DEFAULT 0 AFTER `KwotasieOntv`,');
                Add('ADD COLUMN `DataDay` INTEGER UNSIGNED AFTER `KontrakGestuur`,');
                Add('ADD COLUMN `PaymentDay` INTEGER UNSIGNED AFTER `DataDay`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`notes_db` ADD COLUMN `ImportantSwi` VARCHAR(5) DEFAULT ''False'' AFTER `SysDateStamp`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''pay_db''');
              Add('and COLUMN_NAME=''PaydMark''');
            end;
            Query.Open;
    //1.1.3.21

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`pay_db` ADD COLUMN `PaydMark` INTEGER UNSIGNED AFTER `UnderPrice`,');
                Add('ADD COLUMN `ReceiptPrinted` INTEGER UNSIGNED AFTER `PaydMark`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`memberx_db` ADD COLUMN `ParticipationPrinted` INTEGER UNSIGNED AFTER `BranchNo`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `AdditionalDescrLink` INTEGER UNSIGNED AFTER `PaymentDay`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`smsmessage` MODIFY COLUMN `CustomerID` VARCHAR(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''death_db''');
              Add('and COLUMN_NAME=''AgeAtDeath''');
            end;
            Query.Open;
    //1.1.3.29

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ADD COLUMN `AgeAtDeath` INTEGER UNSIGNED AFTER `DescrLink`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ADD COLUMN `UndClaimRef` VARCHAR(20) AFTER `AgeAtDeath`;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''coverstattable''');
              Add('and COLUMN_NAME=''Cover''');
            end;
            Query.Open;
    //1.1.3.29

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`coverstattable` (');
                Add('`Nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,');
                Add('`Cover` DECIMAL(10,2),');
                Add('`CoverType` VARCHAR(1),');
                Add('PRIMARY KEY (`Nr`))');
                Add('ENGINE = InnoDB;');
              end;
              Query.ExecSQL;
            end;

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''AddJFee''');
            end;
            Query.Open;
    //1.1.3.32

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `AddJFee` VARCHAR(2) DEFAULT 0 AFTER `UseAccNoasBodyNo`;');
              end;
              Query.ExecSQL;
            end;
    //1.1.3.33

            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''group_db''');
              Add('and COLUMN_NAME=''DebitOrderDir''');
            end;
            Query.Open;
    

            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `DebitOrderDir` VARCHAR(250) AFTER `AdditionalDescrLink`;');
              end;
              Query.ExecSQL;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`death_db` ADD COLUMN `ProdLink` INTEGER UNSIGNED AFTER `UndClaimRef`;');
              end;
              Query.ExecSQL;
            end;
{================================1.1.4.0====================================}
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''group_db''');
              Add('and COLUMN_NAME=''CompanyNr''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `CompanyNr` INTEGER(11) AFTER `DebitOrderDir`;');
              end;
              Query.ExecSQL;
            end;
                                  //Check Company_db
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''company_db''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`company_db` (');
                Add('`Nr` int(11) NOT NULL auto_increment,');
                Add('`Name` varchar(50) default NULL,');
                Add('`Status` int(2) default NULL,');
                Add('`NCUid` varchar(50) default NULL,');
                Add('`NCPw` varchar(15) default NULL,');
                Add('`NCPin` int(10) default NULL,');
                Add('`NCDOCost` decimal(6,2) default ''0.00'',');
                Add('`NCRDCost` decimal(6,2) default ''0.00'',');
                Add('`NCSameDayCost` decimal(6,2) default ''0.00'',');
                Add('`NCMonthlyFee` decimal(6,2) default ''0.00'',');
                Add('`RDSDOCost` decimal(6,2) default ''0.00'',');
                Add('`RDSRDCost` decimal(6,2) default ''0.00'',');
                Add('`CaptionDate` int(10) unsigned default NULL,');
                Add('`BeginDate` int(10) unsigned default NULL,');
                Add('`EndDate` int(10) unsigned default NULL,');
                Add('PRIMARY KEY  (`Nr`),');
                Add('KEY `NameIndex` USING BTREE (`Name`)');
                Add(') ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1');
              end;
              Query.ExecSQL;
            end;
                     // Insert Debit Order History Table if not exist...
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''dohist_db''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`dohist_db` (');
                Add('`Nr` int(11) NOT NULL auto_increment,');
                Add('`CompanyId` int(11) NOT NULL,');
                Add('`BatchDate` int(10) unsigned default NULL,');
                Add('`BatchLines` int(11) default NULL,');
                Add('`Value` decimal(10,2) default NULL,');
                Add('`SameDay` varchar(5) default NULL,');
                Add('`NCUnpdRet` decimal(6,2) default NULL,');
                Add('`NCFeesRet` decimal(6,2) default NULL,');
                Add('`NCSurityRet` decimal(6,2) default NULL,');

                Add('PRIMARY KEY USING BTREE (`Nr`),');
                Add('KEY `CompanyId` (`CompanyId`)');
                Add(') ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1');
              end;
              Query.ExecSQL;
            end;
                   //Add column in Products table for 0-11month children
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''product_db''');
              Add('and COLUMN_NAME=''Child0Coverage''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `Child0Coverage` DECIMAL(10,2) DEFAULT ''0.00'' AFTER `6CommAmmount`;');
              end;
              Query.ExecSQL;
            end;

{================================1.1.4.2====================================}
            // Insert Products History Table if not exist...
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''producthist_db''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`producthist_db` (');
                 Add('`Nr` int(10) unsigned NOT NULL auto_increment,');
                  Add('`DateFrom` int(10) unsigned default ''0'',');
                  Add('`DateTo` int(10) unsigned default NULL,');
                  Add('`Description` varchar(40) default NULL,');
                  Add('`AgeGroup` int(1) unsigned default NULL,');
                  Add('`Coverage` decimal(10,2) default ''0.00'',');
                  Add('`SpouseCoverage` decimal(10,2) default ''0.00'',');
                  Add('`JoiningFee` decimal(10,2) default ''0.00'',');
                  Add('`RetailPremium` decimal(10,2) default ''0.00'',');
                  Add('`UnderwriterPremium` decimal(10,2) default ''0.00'',');
                  Add('`Period` int(4) unsigned default NULL,');
                  Add('`CommStructure` int(1) unsigned default NULL,');
                  Add('`CommisionAmmount` decimal(10,2) default ''0.00'',');
                  Add('`ProdLink` int(10) unsigned default NULL,');
                  Add('`UnderwriterName` varchar(30) default NULL,');
                  Add('`BeginAge` int(11) default ''0'',');
                  Add('`EndAge` int(11) default ''0'',');
                  Add('`Double` varchar(5) default ''False'',');
                  Add('`Married` int(11) default ''0'',');
                  Add('`Child0Coverage` decimal(10,2) default ''0.00'',');
                  Add('`Child1Coverage` decimal(10,2) default ''0.00'',');
                  Add('`Child2Coverage` decimal(10,2) default ''0.00'',');
                  Add('`Child3Coverage` decimal(10,2) default ''0.00'',');
                  Add('`Stillborn` decimal(10,2) default ''0.00'',');
                  Add('`ExtendedChildFee` decimal(10,2) default ''1.00'',');
                  Add('`CustomDesc` varchar(5) default NULL,');
                  Add('`AdditionalCoverage` decimal(10,2) default ''0.00'',');
                  Add('`AdditionalRetailPremium` decimal(10,2) default ''0.00'',');
                  Add('`AdditionalUnderPremium` decimal(10,2) default ''0.00'',');
                  Add('`ManagerCommStructure` int(1) unsigned default NULL,');
                  Add('`ManagerCommAmmount` decimal(10,2) default NULL,');
                  Add('`Under1Premium` decimal(10,2) default NULL,');
                  Add('`Under1Coverage` decimal(10,2) default NULL,');
                  Add('`Under1SpouseCover` decimal(10,2) default NULL,');
                  Add('`Under1Child1Cover` decimal(10,2) default NULL,');
                  Add('`Under1Child2Cover` decimal(10,2) default NULL,');
                  Add('`Under1Child3Cover` decimal(10,2) default NULL,');
                  Add('`Under1StillBorn` decimal(10,2) default NULL,');
                  Add('`Under2Premium` decimal(10,2) default NULL,');
                  Add('`Under2Coverage` decimal(10,2) default NULL,');
                  Add('`Under2SpouseCover` decimal(10,2) default NULL,');
                  Add('`Under2Child1Cover` decimal(10,2) default NULL,');
                  Add('`Under2Child2Cover` decimal(10,2) default NULL,');
                  Add('`Under2Child3Cover` decimal(10,2) default NULL,');
                  Add('`Under2StillBorn` decimal(10,2) default NULL,');
                  Add('`Under1Name` varchar(30) default NULL,');
                  Add('`Under2Name` varchar(30) default NULL,');
                  Add('`Extra1TimeCom` decimal(10,2) default NULL,');
                  Add('`3CommStructure` int(1) unsigned default NULL,');
                  Add('`3CommAmmount` decimal(10,2) default NULL,');
                  Add('`4CommStructure` int(1) unsigned default NULL,');
                  Add('`4CommAmmount` decimal(10,2) default NULL,');
                  Add('`5CommStructure` int(1) unsigned default NULL,');
                  Add('`5CommAmmount` decimal(10,2) default NULL,');
                  Add('`6CommStructure` int(1) unsigned default NULL,');
                  Add('`6CommAmmount` decimal(10,2) default NULL,');
                  Add('PRIMARY KEY  USING BTREE (`Nr`),');
                  Add('KEY `ProdLink` (`ProdLink`)');
                  Add(') ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1');

              end;
              Query.ExecSQL;
            end;
{================================1.1.4.3====================================}
            // Insert Source field in member table
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''member_db''');
              Add('and COLUMN_NAME=''Source''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `Source` SMALLINT(5) UNSIGNED DEFAULT 0 AFTER `NickName`;');
              end;
              Query.ExecSQL;
            end;

       Query.Close;
{================================1.1.4.4====================================}
            // Insert Extra 1 tme comm2 field in product table
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''product_db''');
              Add('and COLUMN_NAME=''Extra1TimeCom2''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `Extra1TimeCom2` Decimal(10,2) AFTER `Child0Coverage`;');
              end;
              Query.ExecSQL;
            end;

       Query.Close;
{=======================================================================}
{================================1.1.4.5====================================}
            // Insert Package field in member table
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''member_db''');
              Add('and COLUMN_NAME=''Package_Id''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `Package_Id` SMALLINT(5) UNSIGNED DEFAULT 0 AFTER `Source`;');
              end;
              Query.ExecSQL;
            end;
            //Create Package table if not exist
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''package_db''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              with Query.SQL do
              begin
                Clear;
                Add('CREATE TABLE `' + Schema.Text + '`.`package_db` (');
                Add('`Id` SMALLINT(5) unsigned NOT NULL auto_increment,');
                Add('`Description` varchar(50) default NULL,');
                Add('PRIMARY KEY  USING BTREE (`Id`)');
                Add(') ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1');

              end;
              Query.ExecSQL;
            end;



{================================1.1.4.7====================================}
            // Insert Package field in extended table
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''extended_db''');
              Add('and COLUMN_NAME=''Package_Id''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `Package_Id` SMALLINT(5) UNSIGNED DEFAULT 0 AFTER `NickName`;');
              end;
              Query.ExecSQL;
            end;

{================================1.1.4.8====================================}
            // Insert OverridePrem field in Global table
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''OverridePrem''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `OverridePrem` VARCHAR(2) DEFAULT 0 AFTER `AddJFee`;');
              end;
              Query.ExecSQL;
            end;
            // Insert OverridePrem field in Member table
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''member_db''');
              Add('and COLUMN_NAME=''OverridePrem''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `OverridePrem` DECIMAL(10,2) DEFAULT ''0.00'' AFTER `Package_Id`;');
              end;
              Query.ExecSQL;
            end;

            {================================1.1.5.5====================================}
            // Insert CoverageReplace field in Group table so that we can change this setting on
            //group level. Christo TT106
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''group_db''');
              Add('and COLUMN_NAME=''CoverageReplace''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `CoverageReplace` VARCHAR(30) DEFAULT NULL AFTER `CompanyNr`;');
              end;
              Query.ExecSQL;
               //Copy data so that the user at least see what he is used to see
              Query.Close;
               with Query.SQL do begin
                  Clear;
                  Add('select * from riskfin.global_db');
               end;
               Query.Open;
               Query.First;
               if (Query.FieldByName('CoverageReplace').Value <> Null) then
               Begin
                  s := Query.FieldByName('CoverageReplace').Value;
                  Query2.Close;
                  with Query2.SQL do begin
                     Clear;
                     Add('update riskfin.group_db set CoverageReplace = "' + s + '"');

                  end;
                  Query2.ExecSQL;
               end;
               Query2.Close;
            end;
{================================1.1.5.5====================================}
// Insert Memo field on member table
// Tumi TT101
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''member_db''');
              Add('and COLUMN_NAME=''Memo''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`member_db` ADD COLUMN `Memo` VARCHAR(200) DEFAULT NULL AFTER `OverridePrem`;');
              end;
              Query.ExecSQL;
            end;
{================================1.1.5.6====================================}
// Insert disabled field on Children table
// Christo TT40 2011/06/03
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''children_db''');
              Add('and COLUMN_NAME=''Disabled''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
              //ALTER TABLE `riskfin`.`children_db` ADD COLUMN `Disabled` VARCHAR(5) AFTER `KindofChild`;
                Add('ALTER TABLE `' + Schema.Text + '`.`children_db` ADD COLUMN `Disabled` VARCHAR(5) DEFAULT NULL AFTER `KindofChild`;');
              end;
              Query.ExecSQL;
            end;
{================================1.1.5.8====================================}
// Insert UpgradeNo field on Extended_db
// Tumi TT111
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''extended_db''');
              Add('and COLUMN_NAME=''UpgradeNo''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`extended_db` ADD COLUMN `UpgradeNo` INTEGER(10) UNSIGNED DEFAULT 0 AFTER `Package_Id`;');
              end;
              Query.ExecSQL;
            end;

{================================1.1.5.9====================================}
// Insert BlockUser2 field on Global_db
// CG TT112
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''BlockUser2''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `BlockUser2` VARCHAR(2) DEFAULT 0 AFTER `OverridePrem`;');
              end;
              Query.ExecSQL;
            end;
{================================1.1.5.10====================================}
// Insert WaitMonths field on product_db
// CG TT121
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''product_db''');
              Add('and COLUMN_NAME=''WaitMonths''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`product_db` ADD COLUMN `WaitMonths` INTEGER DEFAULT 0 AFTER `Extra1TimeCom2`;');
              end;
              Query.ExecSQL;
            end;
{================================1.1.5.11====================================}
// New CypherSoft Debit orders - Add ACB - and Cypher Codes to global_db
// Also put DebitOrderdir / actionday and Lastmonthupdate in global db
// CG TT155
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''ACBCode''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `ACBCode` VARCHAR(4) AFTER `BlockUser2`;');
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `CypherCode` VARCHAR(4) AFTER `ACBCode`;');
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` MODIFY COLUMN `DebitOrderDir` VARCHAR(250);');
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `DebitOrderActionDay` SMALLINT(2) UNSIGNED AFTER `DebitOrderDir`;');
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `LastMonthUpdate`int(10) unsigned default NULL AFTER `DebitOrderActionDay`;');
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `RefType` VARCHAR(2) default 0 AFTER `LastMonthUpdate`;');
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `RefDescription` VARCHAR(10) AFTER `RefType`;');
                Add('ALTER TABLE `' + Schema.Text + '`.`group_db` ADD COLUMN `RefDescription` VARCHAR(10) AFTER `CoverageReplace`;');
              end;
              Query.ExecSQL;

            end;

            {================================1.1.5.12====================================}
// New CypherSoft Debit orders - Add DoSwapDescr to global_db
// This is for users that want to swap the number & description on the clients bank statement
// CG TT160
            Query.Close;
            with Query.SQL do begin
              Clear;
              Add('select * from information_schema.COLUMNS');
              Add('where TABLE_SCHEMA='''+ Schema.Text +'''');
              Add('and TABLE_NAME=''global_db''');
              Add('and COLUMN_NAME=''DoSwapDescr''');
            end;
            Query.Open;
            If Query.RecordCount = 0 then
            begin
              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`global_db` ADD COLUMN `DoSwapDescr` VARCHAR(2) DEFAULT 0 AFTER `CypherCode`;');
              end;
              Query.ExecSQL;

            end;

       {================================1.1.5.26====================================}
// Changing the data type from integer to big integer to allow for increasing numbers
// This is the SMS ID that gets generated by the service provider during SMS transactions.
// TN TT170

              Query.Close;
              with Query.SQL do
              begin
                Clear;
                Add('ALTER TABLE `' + Schema.Text + '`.`smsmessage` MODIFY COLUMN `Sentid` BIGINT(20) UNSIGNED DEFAULT NULL;');
              end;
              Query.ExecSQL;


{=======================================================================}

       Query.Close;

            RiskfinADConnection.Commit;
          finally
            if RiskfinADConnection.InTransaction then
            begin
              RiskfinADConnection.Rollback;
              showmessage('Something went wrong contact support!');
            end
            Else
               showmessage('Database Update Completed.');
          end;

          RiskfinADConnection.Close;
          Close;

end;

end.
