create database Bank
 create table Admin (AdminID int primary key, Password nvarchar(30))

create table AdminDecision(AdminID int references Admin(AdminID), UserID int references Users(UserID), ApprovalGiven bit, DecisionDate Date)

create table Beneficiary(BeneficiaryID int IDENTITY(1,1) primary key, name nvarchar(100),  UserID int references Users(UserID), BeneficiaryAccountNumber Bigint not null unique, BeneficiaryStatus bit not null ) 

create table NetBanking(ReferenceID int primary key identity(5000,1) ,UserID int references Users(Userid), LoginPassword nvarchar(50) not null, TransactionPassword nvarchar(50) not null, DatePasswordSet Date, NetBankingStatus bit)

create table Transactions(TransactionID int primary key Identity(20000,1),SenderUserID int references Users(Userid), SenderAccountNumber Bigint references Account(AccountNumber), ReceiverAccountNumber Bigint, TransactionType nvarchar(20) not null, Date Date default(GETDATE()) not null,Amount float(6) not null, TransactionStatus bit not null, Remarks nvarchar(100))

create table DebitCard(DebitCardNumber Bigint primary key,UserID int references Users(Userid), CVV smallint not null,DateOfIssue Date default(GETDATE()) not null, DateOfExpiry Date not null,PIN int not null, DebitCardStatus bit not null, Maxlimit float not null)

create table Users(UserID int primary key IDENTITY(1000,1), FirstName nvarchar(100) not null, SecondName nvarchar(30) not null, MiddleName nvarchar(100),
Email nvarchar(200) unique, Phone Bigint not null, Gender varchar(10), AdhaarNumber Bigint not null Unique, FathersName nvarchar(30), DOB Date,
PermanentAddress nvarchar(500) not null, CuurentAddress nvarchar(500) not null,OccupationType nvarchar(30),
 SourceofIncome nvarchar(20),AnnualSalary float, DebitCardOpted bit, NetBankingOpted bit, DateofApplication Date default(GETDATE()), Approved bit)
 drop table Users

 create table Account(UserID int references Users(UserID),Balance Float not null, AccountNumber Bigint primary key IDENTITY(500000000,1), Locked bit not null) 


insert into Users( FirstName, SecondName, MiddleName, Email, Phone, Gender, AdhaarNumber, FathersName, DOB, PermanentAddress, CurrentAddress, OccupationType, 
SourceofIncome, AnnualSalary, DebitCardOpted, NetBankingOpted, DateofApplication, Approved ) 
 values ('sss', 'gupta', 'none', 'nikupp', 28510172, 'M', 42424404444, 'KVS', '19980728', '1908M', 'same', 'LTI', 'Salary',
450033.2, 1, 1, '20160810', 0);
go







