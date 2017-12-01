# Setting up EF Core
1. Tools > NuGet Package Manager > Package Manager Console
2. Run Install-Package Microsoft.EntityFrameworkCore.SqlServer
3. We will be using some Entity Framework Tools to create a model from the database. So we will install the tools package as well:
Run `Install-Package Microsoft.EntityFrameworkCore.Tools`
4. We will be using some ASP.NET Core Scaffolding tools to create controllers and views later on. So we will install this design package as well:
Run `Install-Package Microsoft.VisualStudio.Web.CodeGeneration.Design`
5. Reverse engineer your model
	Now it's time to create the EF model based on your existing database.
	Tools –> NuGet Package Manager –> Package Manager Console
	Run the following command to create a model from the existing database:
```
Scaffold-DbContext "Server=(localdb)\mssqllocaldb;Database=Blogging;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models
```
	If you receive an error stating The term 'Scaffold-DbContext' is not recognized as the name of a cmdlet, then close and reopen Visual Studio.


Scaffold-DbContext "Server=tcp:surveycollector.database.windows.net,1433;Initial Catalog=ContosoMedicalDB;Persist Security Info=False;User ID=scadmin;Password=P2ssw0rd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models