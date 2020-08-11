create proc proc_display (@UserId int)
as begin
select * from Users where UserID=@UserId
end
go
create proc proc_displaytoadmin
as begin
select * from Users where Approved=0
end
go

alter proc proc_RegisterNetBanking(@AccountNumber Bigint, @LoginPassword nvarchar(100), @TransactionPassword nvarchar(100), @status bit)
as begin
declare @UserID int
set @UserID= (select UserID from Account
where AccountNumber=@AccountNumber)
insert into NetBanking(UserID, LoginPassword, TransactionPassword, DatePasswordSet, NetBankingStatus) values (@UserID, @LoginPassword, @TransactionPassword, GETDATE(), @status)
end
go

select * from NetBanking
exec proc_RegisterNetBanking @AccountNumber=500000000, @LoginPassword='kartik',@TransactionPassword= 'kartiktransaction', @status=1
go

alter proc proc_RegisterUser(@FirstName nvarchar(100), @SecondName nvarchar(100), @MiddleName nvarchar(100),
@Email nvarchar(200), @Phone Bigint, @Gender varchar(10), @AdhaarNumber Bigint, @FathersName nvarchar(30), @DOB Date,
@PermanentAddress nvarchar(500), @CurrentAddress nvarchar(500), @OccupationType nvarchar(30),
@SourceofIncome nvarchar(20), @AnnualSalary float, @DebitCardOpted bit, @NetBankingOpted bit, @DateofApplication Date, @Approved bit)
as begin
if( @CurrentAddress='same')
begin
insert into Users values( @FirstName, @SecondName, @MiddleName,
@Email, @Phone, @Gender, @AdhaarNumber, @FathersName, @DOB,
@PermanentAddress, @PermanentAddress, @OccupationType,
@SourceofIncome, @AnnualSalary, @DebitCardOpted, @NetBankingOpted, @DateofApplication, @Approved)
end
else
begin
insert into Users values( @FirstName, @SecondName, @MiddleName,
@Email, @Phone, @Gender, @AdhaarNumber, @FathersName, @DOB,
@PermanentAddress, @CurrentAddress, @OccupationType,
@SourceofIncome, @AnnualSalary, @DebitCardOpted, @NetBankingOpted, @DateofApplication, @Approved)
end
end
go

exec proc_RegisterUser 'sss', 'kkkk', 'none', 'kartik.niku', 8851017223, 'M', 4444222222, 'KVS', '2016-08-17', '1908m', 'SAME', 'Salaried', 'LTI', 10000, 1,1, '2016-08-09', 0 
go

alter proc proc_AdminDecision @AdminID int, @UserID INT, @ApprovalGiven bit, @ApprovalDate Date
as begin
insert into AdminDecision (AdminID, UserID, DecisionDate, ApprovalGiven) values( @AdminID, @UserID,  @ApprovalDate, @ApprovalGiven)
if(@ApprovalGiven=1)
begin
insert into Account values(@UserID, 0, 0)
end
end
go

SELECT * FROM Users
select * from Account

exec proc_AdminDecision 1, 1003, 1, '2020-06-20'
go

create proc proc_ForgotLoginPassword @UserID int, @LoginPassword nvarchar(100)
as begin
update NetBanking
set LoginPassword=@LoginPassword
where UserID=@UserID
end
go

create proc proc_ForgotTransactionPassword @UserID int, @TransactionPassword nvarchar(100)
as begin
update NetBanking
set TransactionPassword=@TransactionPassword
where UserID=@UserID
end
go

ALTER proc proc_SetNewPassword (@UserID int, @OldLoginPassword nvarchar(100), @OldTransactionPassword nvarchar(100),
@NewLoginPassword nvarchar(100), @NewTransactionPassword nvarchar(100))
as begin
declare @olpass nvarchar(100)
set @olpass= (select LoginPassword from NetBanking where UserID=@UserID)
declare @otpass nvarchar(100)
set @otpass= (select TransactionPassword from NetBanking where UserID=@UserID)
if(@OldLoginPassword=@olpass and @OldTransactionPassword=@otpass and @NewLoginPassword!=@olpass and @NewTransactionPassword!=@otpass )
begin
update NetBanking
set TransactionPassword=@NewTransactionPassword 
where UserID=@UserID 
update NetBanking
set LoginPassword=@NewLoginPassword 
where UserID=@UserID 
end
end 
go

select * from NetBanking
exec proc_SetNewPassword 1000, 'kartiklogin', 'kartiktransaction','newkartiklogin', 'newkartiktransaction'
go

alter proc proc_payment @BenAccountNumber Bigint, @SenderAccountNumber Bigint, @amount float, @type nvarchar(20), @status bit, @remarks nvarchar(20)
as begin
		declare @lockedstatus bit;
		set @lockedstatus= (select Locked from Account where AccountNumber=@SenderAccountNumber)
		if(@lockedstatus=0)
		begin
			declare @SenderID int;
			SET @SenderID= (select a.UserID from Users a inner join Account b on b.UserID=a.UserID
			where b.AccountNumber=@SenderAccountNumber)
			if(@type in ('IMPS', 'NEFT', 'RTGS'))
			begin
				if(@BenAccountNumber in (select BeneficiaryAccountNumber from Beneficiary where UserID=@SenderID) and @SenderID in ( select UserID from Users ) and @SenderAccountNumber in (Select AccountNumber from Account) and @BenAccountNumber in(select AccountNumber from Account) )
				begin
				
					insert into Transactions(SenderUserID, SenderAccountNumber, ReceiverAccountNumber, TransactionType, Date, Amount, TransactionStatus, Remarks) values (@SenderID, @SenderAccountNumber, @BenAccountNumber, @type+'-Debit', GETDATE(), @amount, @status , @remarks)
					insert into Transactions values (@SenderID, @SenderAccountNumber, @BenAccountNumber, @type+'-Credit', GETDATE(), @amount, @status , @remarks)
					update Account set Balance=Balance-@amount where AccountNumber=@SenderAccountNumber
					update Account set Balance=Balance+@amount where AccountNumber=@BenAccountNumber
				end
				else if( @BenAccountNumber in (select BeneficiaryAccountNumber from Beneficiary where UserID=@SenderID) and  @BenAccountNumber not in (select AccountNumber from Account))
					begin
					insert into Transactions(SenderUserID, SenderAccountNumber, ReceiverAccountNumber, TransactionType, Date, Amount, TransactionStatus, Remarks) values (@SenderID, @SenderAccountNumber, @BenAccountNumber, @type+'-Debit', GETDATE(), @amount, @status , @remarks)
					update Account set Balance=Balance-@amount where AccountNumber=@SenderAccountNumber
					end
			end
		end
	end
go

select * from Beneficiary
select * from Users
select * from Account
select * from Transactions
update Account
set Locked=1 
where AccountNumber=500000000


delete from Beneficiary
