create database Bank

create table Users(UserID int primary key Identity(1000,1), FirstName nvarchar(30) not null, SecondName nvarchar(30) not null, MiddleName nvarchar(30), Balance Float not null, AccountNumber Bigint not null Unique, Email nvarchar(20) unique, Phone Bigint not null, Gender varchar(10), AdhaarNumber Bigint not null Unique, 
FathersName nvarchar(30), DOB Date, PermanentAddress nvarchar(200) not null, CuurentAddress nvarchar(200) not null, OccupationType nvarchar(30), SourceofIncome nvarchar(20),AnnualSalary float, DebitCardOpted binary, NetBankingOpted binary, Locked binary, approved binary)

create table Benefeciary(BeneficiaryID int IDENTITY(1,1) primary key, UserID int references Users(UserID), BeneficiaryAccountNumber Bigint) 
