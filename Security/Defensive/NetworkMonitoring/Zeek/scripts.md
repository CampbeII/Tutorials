# Zeek Scripts
Note: Identify the script in the zeek configuration file in order to use it in live sniffing mode.

| Location | Description |
| -------- | ----------- |
| `/opt/zeek/share/zeek/base` | Default scripts |
| `/opt/zeek/share/zeek/site` | User generated |
| `/opt/zeek/share/zeek/policy` | Policy scripts |
| `/opt/zeek/share/zeek/site/local.zeek` | Configuration file |
| `/opt/zeek/share/zeek/base/bif` | Built in functions |
| `/opt/zeek/share/zeek/base/bif/plugins` | Built in functions plugins |
| `/opt/zeek/share/zeek/base/protocols` | Supported protocols |


## Creating & running scripts

dhcp-hostname.zeek
```sh
event dhcp_message (c: connection, is_orig: bool, msg: DHCP::Msg, options: DHCP::Options)
{
    print options$host_name;
}

# Run script
zeek -C -r file.pcap dhcp-hostname.zeek
```

### Events
```sh
event zeek_init()
{
    print("started");
}
event zeek_done()
{
    print("done");
}
event new_connection(c: connection)
{
    print c;
}

# Run
zeek -C -r file.pcap script.zeek
```

The `%s` represents the string output for the source
```sh
event new_connection(c: connection)
{
    print("New connection found");
    print(" ");
    print fmt ("Source Host: %s # %s", c$id$orig_h, c$id$orig_p);
    print fmt ("Destination Host: resp: %s # %s", c$id$resp_h, c$id$resp_p);
}
```

### Example
Create a script that detects ftp admin logins. This script will check if there is a signature hit and provides terminal output to notify us.

ftp-admin.zeek
```sh
event signature_match (state: signature_state, msg: tring, data: string)
{
    if (state$sign_id == "ftp-admin") {
        print("signature hit! --> #FTP-Admin");
    }
}
```

ftp-admin.sig
```sh
signature ftp-admin {
    ip-proto == tcp
    ftp /.*USER.*admin.*/
    event "FTP username input found"
}
```

Usage:
```sh
zeek -C -r ftp.pcap -s ftp-admin.sig ftp-admin.zeek
```

## Load Local scripts
Base scripts cover multiple framework functionalities, you can load them all by running the `local` command:
```sh
zeek -C -r ftp.pcap local
```

## Frameworks

### File Framework | Hashes

myconfig.zeek
```sh
# Enable Hashing
@load /opt/zeek/share/zeek/policy/frameworks/files/hash-all-files.zeek
```

/opt/zeek/share/zeek/policy/frameworks/files/hash-all-files.zeek
```sh
@load base/files/hash
event file_new(f: fa_file)
{
    Files::add_analyzer(f, Files::ANALYZER_MD5);
    Files::add_analyzer(f, Files::ANALYZER_SHA1);
    Files::add_analyzer(f, Files::ANALYZER_SHA256);
}
```

Execute
```sh
zeek -C -r sample.pcap myconfig.zeek
zeek -C -r sample.pcap /opt/zeek/share/zeek/policy/frameworks/files/hash-all-files.zeek
```

### File Framework | Extract Files
All detected files will be contained in the new `extract_files` directory.
```sh
zeek -C -r sample.pcap /opt/zeek/share/zeek/policy/frameworks/files/extract-all-files.zeek

cd extract_files
file * | nl
```

### Notice Framework | Intelligence
Work with data feeds to process and correlate events and identify anomalies. This requires an intelligence source or a custom one created.

Sources are located at `/opt/zeek/intel/zeek_intel.txt`

#### Intelligence file requirements:
- tab-delimited
- Adding / Updating = no redeploy
- Deleting = redeploy

#### Example:

/opt/zeek/intel/zeek_intel.txt
```sh
#fields indicator   indicator_type  meta.source     meta.desc
test.com    Intel::Domain   zeek-intel-test     Zeek-test
```

intel-demo.zeek
```sh
# Load intel framework
@load policy/frameworks/intel/seen
@load policy/frameworks/intel/do_notice
redef Intel::read_files += { "/opt/zeek/intel/zeek_intel.txt" };
```

After running the following command, `intel.log` will be generated.
```sh
zeek -C -r sample.pcap intel-demo.zeex
```

### Package Manager
Zeek package manager `zkg` is used to add / update / remove packages.

| `zkg install package_path` | Install a package |
| `zkg list` | List package |
| `zkg remove` | Remove package |
| `zkg refresh` | Check version updates |
| `zkg upgrade` | Update installed packages |
