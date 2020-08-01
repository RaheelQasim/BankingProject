create database Bank

create table Users(UserID int primary key Identity(1000,1), FirstName nvarchar(30) not null, SecondName nvarchar(30) not null, MiddleName nvarchar(30), Balance Float not null, AccountNumber Bigint not null Unique, Email nvarchar(20) unique, Phone Bigint not null, Gender varchar(10), AdhaarNumber Bigint not null Unique, 
FathersName nvarchar(30), DOB Date, PermanentAddress nvarchar(200) not null, CuurentAddress nvarchar(200) not null, OccupationType nvarchar(30), SourceofIncome nvarchar(20),AnnualSalary float, DebitCardOpted binary, NetBankingOpted binary, Locked binary, approved binary)

create table Benefeciary(BeneficiaryID int IDENTITY(1,1) primary key, UserID int references Users(UserID), BeneficiaryAccountNumber Bigint) 

create table NetBanking(NetbankingID int primary key,UserID int references Users(Userid),Password nvarchar(20) not null)

create table Transactions(TransactionID int primary key,UserID int references Users(Userid), Type nvarchar(20) not null, Date Date not null,Amount float(6) not null)

create table DebitCard(DebitCardNumber Bigint primary key,UserID int references Users(Userid), CVV smallint not null,DateOfIssue Date not null, DateOfExpiry Date not null,PIN int not null)

create table Register(TempUserID int primary key, FirstName nvarchar(30) not null, SecondName nvarchar(30) not null, MiddleName nvarchar(30),Email nvarchar(20) unique, Phone Bigint not null,Gender varchar(10), AdhaarNumber Bigint not null Unique, FathersName nvarchar(30), DOB Date,
PermanentAddress nvarchar(200) not null, CuurentAddress nvarchar(200) not null,OccupationType nvarchar(30), SourceofIncome nvarchar(20),AnnualSalary float, DebitCardOpted binary,NetBankingOpted binary,DateofApplication Date)

create table Admin(AdminID int primary key, Password nvarchar(30))

create table AdminDecision(AdminID int references Admin(AdminID), TempUserID int references Register(TempUserID), ApprovalGiven binary, DecisionDate Date)
