--1. load all categories within the database
create procedure [dbo].[Category_Load]
as
select CategoryID, Name
from Category
where Status = 1
order by Name 
GO

--2.retrieves all artists belonging to a specific category
create procedure [dbo].[Artist_by_Category]
@categorytyped int
as
select Artists.ArtistID, Artists.Name
from [dbo].[Artists],[dbo].[ArtistCat]
where Artists.ArtistID = ArtistCat.ArtistID
and ArtistCat.CategoryID = @categorytyped
and Artists.Status = 1 and ArtistCat.Status = 1
order by Artists.Name
GO

--3.retrieves all songs belonging to a specific artist
create procedure [dbo].[Songs_by_Artist]
@ArtistID int,
@categoryID int
as
select Songs.SongID,Songs.SongName
from [dbo].[Songs],[dbo].[SongsCategory]
where Songs.SongID = SongsCategory.Song
and SongsCategory.Category = @categoryID
and Songs.Artist = @ArtistID
and Songs.Status = 1
and SongsCategory.Status = 1
order by Songs.SongName
GO

--4.validates user credentials (username and password)
create procedure [dbo].[Validate_Login]
@username nvarchar(15),
@password nvarchar(128)
as
select PersonID
from Persons
where UserName = @username
and Password = @password
and Status = 1
GO