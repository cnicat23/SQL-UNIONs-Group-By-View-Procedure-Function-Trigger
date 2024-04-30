Create Database BlogDB
use BlogDB

Create Table Categories(
Id int primary key identity,
Name nvarchar(50) not null unique
)

Insert into Categories (Name) Values 
('book'),
('electornics'),
('fashion'),
('Science'),
('Sports')

Select * from Categories

Create Table Tags(
Id int primary key identity,
Name nvarchar(50) not null unique
)

Insert into Tags (Name) Values 
('cooking'),
('fashion'),
('football'),
('voleybol'),
('photography'),
('programming')

Select * from Tags

Create Table Users(
Id int primary key identity,
UserName nvarchar(50) not null unique,
FullName nvarchar(50) not null,
Age int
Check(Age > 0 and Age < 150)
)

Insert into Users (UserName, FullName, Age) Values 
('Sirac', 'Sirac Huseynov', 20),
('Zaman', 'Zaman Safarov', 22),
('Fuad', 'Fuad Memmedov', 20),
('Nicat', 'Nicat Cabbarov', 26),
('test', 'test testt', 35)

Select * from Users

Create Table Blogs(
Id int primary key identity,
Title nvarchar(50) not null,
Description nvarchar(250) not null,
UsersID int foreign key references Users(Id),
CategoriesID int foreign key references Categories(Id)
)

Insert into Blogs (Title, Description, UsersID, CategoriesID) Values 
('testttt', 'lorem ipsummmmm.', 1, 1),
('testtt222', 'testtt22222222222222222222', 2, 2),
('hello world', 'hello world tesssstt', 4, 3),
('master23233333', 'master3333333', 3, 4),
('lorem a 55555', 'lorem ipsum 55555555', 5, 5);

Select * from Blogs

Create Table Comments(
Id int primary key identity,
Content nvarchar(250) not null,
UsersID int foreign key references Users(Id),
BlogsID int foreign key references Blogs(Id)
)

Insert into Comments (Content, UsersID, BlogsID) Values 
('Nice', 2, 1),
('bad', 4, 2),
('positive', 1, 3),
('Interesting', 3, 4),
('good', 5, 5)

Select * from Comments

Create Table Blogs_Tags(
Id int primary key identity,
BlogsID int foreign key references Blogs(Id),
TagsID int foreign key references Tags(Id)
)

Insert into Blogs_Tags (BlogsID, TagsID) Values 
(1, 1),
(1, 2),
(3, 3),
(4, 4),
(5, 5)

Select * from Blogs_Tags

Create View VW_GetTitleName
as
Select Blogs.Title as 'Blog title', Users.UserName as 'Username', Users.FullName as 'FullName' from Blogs
Join Users
ON Users.Id = Blogs.UsersID

Select * from VW_GetTitleName

Create View VW_GetName
as
select Blogs.Title as 'Blog title', Categories.Name as 'Category Name' from Blogs
Join Categories
on Categories.Id = Blogs.CategoriesID

Select * from VW_GetName


Create Procedure SP_GetComments @userId int
as
Select * from Comments
where Comments.UsersID = @userId

Exec SP_GetComments 2

Create Procedure SP_GetBlogs @userId int
as
Select * from Blogs
where Blogs.UsersID = @userId 

Exec SP_GetBlogs 1



Create Function UFN_GetBlogsCount(@categoryId int)
Returns int
Begin
	Declare @TotalCount Int;

	Select @TotalCount = Count(Blogs.Id) from Blogs
	where Blogs.CategoriesID = @categoryId
	
	return @TotalCount
End

Select dbo.UFN_GetBlogsCount(2)

Create Function UFN_GetUBlogs(@UId int) 
Returns Table as
	return (Select * from Blogs
	where Blogs.UsersID = @UId)

Select * from UFN_GetUBlogs(3)

Create Trigger TRGR_Delete 
on Blogs
Instead Of Delete
as
Begin
	Declare @isDeleted int;
	Declare @id int;
	Select @id = Id from deleted;
	Update Blogs Set @isDeleted=1
	where Id = @Id
End

Delete From Blogs
where Blogs.Id=2

Select * from Blogs