--1. insert new person
CREATE procedure [dbo].[Persons_Insert]
@FName nvarchar(40),
@LName nvarchar(40),
@userName nvarchar(15),
@password nvarchar(128),
@email nvarchar(125),
@NewPersonID int OUTPUT
as
INSERT INTO [dbo].[Persons]
           ([FirstName]
           ,[LastName]
           ,[UserName]
           ,[Password]
           ,[EmailAddress]
           ,[Role]
           ,[Status])
     VALUES
           (@FName,
           @LName,
           @userName,
           @password,
           @email
           ,1
           ,1)
           set @NewPersonID = SCOPE_IDENTITY()
GO

--2. insert new address
create procedure [dbo].[Address_Insert]
@Street nvarchar(50),
@Suite nvarchar(8),
@City nvarchar(50),
@ProvinceState nvarchar(3),
@Country nvarchar(3),
@PostalCode nvarchar(8),
@PersonID int

as
INSERT INTO [dbo].[Addresses]
           ([Street]
           ,[Suite]
           ,[City]
           ,[ProvinceState]
           ,[Country]
           ,[PostalCode]
           ,[PersonID]
           ,[Status])
     VALUES
           (@Street,
@Suite,
@City,
@ProvinceState ,
@Country,
@PostalCode ,
@PersonID
,1)
GO

--3. insert new phone
CREATE procedure [dbo].[Phone_Number_Insert]
@Phonenumber nvarchar(15),
@extension nvarchar(6),
@PersonID int
as 
INSERT INTO [dbo].[PhoneNumbers]
           ([PhoneNumber]
           ,[Extension]
           ,[Type]
           ,[PersonID]
           ,[Status])
     VALUES
           (@Phonenumber,
           @extension,
           3,
           @PersonID,
           1)
GO

--4. insert new secret question
create procedure [dbo].[SecretQuestion_Insert]
@question nvarchar(225),
@answer nvarchar(120),
@PersonID int
as
INSERT INTO [dbo].[SecretQuestion]
           ([Question]
           ,[Answer]
           ,[PersonID])
     VALUES
           (@question,
           @answer,
           @PersonID)
GO

--5. simplify the full profile insert
create procedure [dbo].[Create_Full_Profile]
    @FName NVARCHAR(40),
    @LName NVARCHAR(40),
    @userName NVARCHAR(15),
    @password NVARCHAR(128),
    @email NVARCHAR(125),
    @Street NVARCHAR(50),
    @Suite NVARCHAR(8),
    @City NVARCHAR(50),
    @ProvinceState NVARCHAR(3),
    @Country NVARCHAR(3),
    @PostalCode NVARCHAR(8),
    @Phonenumber NVARCHAR(15),
    @extension NVARCHAR(6) = NULL,
    @question NVARCHAR(225),
    @answer NVARCHAR(120)
AS
begin
    declare @NewID int

    BEGIN TRAN

    EXEC [dbo].[Persons_Insert] 
        @FName = @FName, 
        @LName = @LName, 
        @userName = @userName, 
        @password = @password, 
        @email = @email,
        @NewPersonID = @NewID OUTPUT

    EXEC [dbo].[Address_Insert] 
        @Street = @Street, 
        @Suite = @Suite, 
        @City = @City, 
        @ProvinceState = @ProvinceState, 
        @Country = @Country, 
        @PostalCode = @PostalCode,
        @PersonID = @NewID

    EXEC [dbo].[Phone_Number_Insert] 
        @Phonenumber = @Phonenumber, 
        @extension = @extension,
        @PersonID = @NewID

    EXEC [dbo].[SecretQuestion_Insert] 
        @question = @question, 
        @answer = @answer, 
        @PersonID = @NewID
    
    COMMIT TRAN
    select @NewID as NewProfileID

END

GO

