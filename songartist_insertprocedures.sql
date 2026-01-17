--1.insert new artist
create procedure [dbo].[Artist_Insert]
@Name nvarchar(120)
as
INSERT INTO [dbo].[Artists]
           ([Name]
           ,[Status])
     VALUES
           (@Name,
           1)
           select SCOPE_IDENTITY() as NewArtistID
GO

--2.maps an artist to a specific vategory
create procedure [dbo].[ArtistCat_Insert]
@NewArtistID int,
@CatID int
as
INSERT INTO [dbo].[ArtistCat]
           ([ArtistID]
           ,[CategoryID]
           ,[Status])
     VALUES
           (@NewArtistID
           ,@CatID
           ,1)
GO

--3.insert new song

create procedure [dbo].[Song_Insert]
@SongName nvarchar(125),
@ArtistID int
as
INSERT INTO [dbo].[Songs]
           ([SongName]
           ,[Artist]
           ,[Status])
     VALUES
           (@SongName
           ,@ArtistID
           ,1)
           select SCOPE_IDENTITY() as NewSongID
GO

--4.maps an song to a specific category
create procedure [dbo].[SongsCat_Insert]
@CategoryID int,
@SongID int
as
INSERT INTO [dbo].[SongsCategory]
           ([Song]
           ,[Category]
           ,[Status])
     VALUES
           (@SongID
           ,@CategoryID
           ,1)
GO


