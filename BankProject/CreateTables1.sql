create database Bank
 create table Admin (AdminID int primary key, Password nvarchar(30))

create table AdminDecision(AdminID int references Admin(AdminID), TempUserID int references Register(TempUserID), ApprovalGiven bit, DecisionDate Date)

create table Benefeciary(BeneficiaryID int IDENTITY(1,1) primary key, UserID int references Users(UserID), BeneficiaryAccountNumber Bigint, BeneficiaryName nvarchar(30) not null) 

create table NetBanking(NetbankingID int primary key Identity(5000,1),UserID int references Users(Userid),Password nvarchar(20) not null, TransactionPassword nvarchar(20) not null)

create table Transactions(TransactionID int primary key Identity(10000,1),SenderUserID int references Users(Userid), ReceiverUserID int references Users(UserID), SenderAccountNumber Bigint references Users(AccountNumber), ReceiversAccountNumber Bigint references Users(AccountNumber), Type nvarchar(20) not null, Date Date not null,Amount float(6) not null)

create table DebitCard(DebitCardNumber Bigint primary key,UserID int references Users(Userid), CVV smallint not null,DateOfIssue Date not null, DateOfExpiry Date not null,PIN int not null)

create table Register(TempUserID int primary key, FirstName nvarchar(30) not null, SecondName nvarchar(30) not null, MiddleName nvarchar(30),
Email nvarchar(20) unique, Phone Bigint not null, Gender varchar(10), AdhaarNumber Bigint not null Unique, FathersName nvarchar(30), DOB Date,
PermanentAddress nvarchar(200) not null, CuurentAddress nvarchar(200) not null,OccupationType nvarchar(30),
 SourceofIncome nvarchar(20),AnnualSalary float, DebitCardOpted bit, NetBankingOpted bit, DateofApplication Date, Approved bit)

 create table Users(UserID int primary key identity(1000,1), FirstName nvarchar(30) not null, SecondName nvarchar(30) not null, MiddleName nvarchar(30),
 Balance Float not null, AccountNumber Bigint not null Unique, Email nvarchar(20) unique, Phone Bigint not null, Gender varchar(10), AdhaarNumber Bigint not null Unique, 
FathersName nvarchar(30), DOB Date, PermanentAddress nvarchar(200) not null, 
CuurentAddress nvarchar(200) not null, OccupationType nvarchar(30), SourceofIncome nvarchar(20),AnnualSalary float, DebitCardOpted bit,
 NetBankingOpted bit, Locked bit, Approved bit)



insert into Register(TempUserID, FirstName, SecondName, MiddleName, Email, Phone, Gender, AdhaarNumber, FathersName, DOB, PermanentAddress, CuurentAddress, OccupationType, 
SourceofIncome, AnnualSalary, DebitCardOpted, NetBankingOpted, DateofApplication, Approved ) 
 values (1114, 'dabu', 'gupta', 'none', 'niku', 2851017221, 'M', 1442424404444, 'KVS', '19980728', '1908M', 'same', 'LTI', 'Salary',
450033.2, 1, 1, '20160810', 0);
insert into Admin values(5000, 'kartik')
insert into AdminDecision values(5000, 1113, 0, '20200801')
go


alter proc sp_InsertProc(@id int, @Userid int, @accno Bigint, @app bit)
as begin
declare @locked int=0;
declare @balance int=1;
declare @accountno Bigint=@accno;
if( @app!=0)
begin
insert into Users(FirstName, SecondName, MiddleName, Email, Phone, Gender, AdhaarNumber, FathersName, DOB, PermanentAddress, CuurentAddress, OccupationType, 
SourceofIncome, AnnualSalary, DebitCardOpted, NetBankingOpted, approved, Locked, Balance, AccountNumber ) select  FirstName, SecondName, MiddleName, Email, Phone, Gender, 
AdhaarNumber, FathersName, DOB, PermanentAddress, CuurentAddress, OccupationType, 
SourceofIncome, AnnualSalary, DebitCardOpted, NetBankingOpted, @app, @locked, @balance, @accountno from Register where TempUserID=@id
update Register set Approved=@app
end
end
go

exec sp_InsertProc @id=1114, @Userid=10001, @accno=139602159, @app=1
go


alter proc sp_Approval(@idfromuser int, @UserID int, @account bigint, @adminapprove bit)
as begin
update AdminDecision
set ApprovalGiven=1
where TempUserID=@idfromuser
exec sp_InsertProc @id=@idfromuser, @Userid=@idfromuser, @accno=@account, @app=@adminapprove
end

exec sp_Approval @idfromuser=1113,@UserID= 1222,@account= 201014,@adminapprove= 1
go

alter proc sp_Netbanking  @Userid int, @pass nvarchar(30)
as begin
insert into NetBanking values ( @Userid, @pass)
end

exec sp_Netbanking  1000, 'kartik' 
go

alter proc sp_UpdatePassword @UserID int, @NetbankingID int,  @oldpass nvarchar(30), @newpass nvarchar(30)
as  begin
declare @old nvarchar(30)
set @old= (select Password from NetBanking where UserID=@UserID and NetbankingID=@NetbankingID)
if(@old= @oldpass)
begin
update NetBanking set Password=@newpass where UserID=@UserID and NetbankingID=@NetbankingID
end
end
go

create proc sp_lockaccount @UserID int
as begin
update Users set Locked=1 where UserID=@UserID
end
go

create proc sp_unlockaccount @UserID int
as begin
update Users set Locked=0 where UserID=@UserID
end
go

create proc sp_ChangeTransactionPassword @UserID int, @NetBankingID int, @CurrentTransPassword nvarchar(20), @NewTransPassword nvarchar(20)
as begin
declare @old nvarchar(20)
set @old=(select TransactionPassword from NetBanking where UserID=@UserID and NetbankingID=@NetBankingID)
if(@old=@CurrentTransPassword)
begin
update NetBanking set TransactionPassword=@NewTransPassword where UserID=@UserID
end
end
go 


insert into NetBanking values(1000, 'kartikt', 'kartikt1')

exec sp_UpdatePassword 1000, 5001, 'kartikt1', 'kartik2'

exec sp_ChangeTransactionPassword 1000, 5001, 'kartikt', 'kartikt1'

Alter table Benefeciary alter column Name nvarchar(50) not null
drop table Benefeciary

go
DELETE FROM Benefeciary where BeneficiaryID=3
go

alter proc sp_AddPayee @UserID int, @AccountNo BigInt, @BeneficiaryName nvarchar(30)
as begin
declare @someac Bigint
set @someac= (select AccountNumber from Users where UserID=@UserID)
if(@AccountNo!=@someac)
begin 
if exists ( select UserID from Users where AccountNumber=@AccountNo)
if not exists( select BeneficiaryID from Benefeciary where BeneficiaryAccountNumber=@AccountNo and UserID=@UserID)
begin
insert into Benefeciary values(@UserID, @AccountNo, @BeneficiaryName)
end
end 
end
go
exec sp_AddPayee @UserID =1000, @AccountNo=20202021, @BeneficiaryName='dabu gupta'
go

update Users set Balance=10000 where UserID=1001
go

select * from Transactions
go

alter proc usp_Payment @BenAccountNumber Bigint, @UserID int, @amount float, @type nvarchar(20)
as begin
if(@type in ('IMPS', 'NEFT', 'RTGS'))
begin
if exists( select AccountNumber from Users where AccountNumber=@BenAccountNumber)
begin
if exists( select BeneficiaryAccountNumber from Benefeciary where @UserID=@UserID)
begin
declare @RecUserID int;
SET @RecUserID= (select UserID from Users where AccountNumber=@BenAccountNumber)
declare @SendersAccountNo Bigint;
SET @SendersAccountNo= (select AccountNumber from Users where UserID=@UserID)
insert into Transactions values (@UserID, @RecUserID, @SendersAccountNo, @BenAccountNumber, @type, GETDATE(), @amount)
insert into Transactions values (@UserID, @RecUserID, @SendersAccountNo, @BenAccountNumber, 'credit', GETDATE(), @amount)
update Users set Balance=Balance-@amount where UserID=@UserID
update Users set Balance=Balance+@amount where UserID=@RecUserID
end
end
END
else if (@type='Debit')
begin
insert into Transactions(SenderUserID, SenderAccountNumber, Type, Date, Amount) values (@UserID, @SendersAccountNo, @type, GETDATE(), @amount)
update Users set Balance=Balance-@amount where UserID=@UserID
end
END

exec usp_Payment 0, 1000, 2000, 'Debit'

select * from Transactions
select * from Users
select * from Register
select * from NetBanking
select * from Benefeciary

go
create proc usp_ForgotPassword @UserID int, @Password nvarchar(20)
as begin
if exists ( select UserID from NetBanking where UserID=@UserID)
begin
update NetBanking set Password=@Password where UserID=@UserID
end
end