# Incident Response Process
A basic IR process consists of the following:
- A RACI matrix that defines the roles and responsibilites of different people
- Escalation matrix that defines how and when incidents are communicated up the escalation ladder to management.
- Severity matrix that defines criteria for assigning severity to an incident.
- Procedures for handling crisis

## Playbooks
There should be a playbook for every incident. Build playbooks by identifying indicators and coresponding actions.
 
 ### Preparation
 Before creating a playbook, you must ensure that you've identified the prerequists. Below is an example of a phishing playbook.

 #### Phishing Playbook

 | Prerequisite | Details | 
 | ------------ | ------- | 
 | Relevant Logs | - Email gateway logs |
 | Required Fields | - Email recipient
 - Email Sender
 - Subject
 - URLs
 - Attachment names & hashes
 - QR codes |
 | Use cases | - known malicious file hashes in attachment
 - suspicious file extension in attachment
 - suspicious sender domain 
 - credential harvesting url in email
 - url conatins typosquatting |
 | Security Controls | - block email
 - quarantine suspicious attachments
 - delete email from inbox |

 Detection:
 Alerts are trigger via user notification or MS Defender. The following triggers will used:
 - Email from a new domain or bad reputation
 - Contain malicious link
 - Contain suspicious attachment

 Analysis:
 Once the playbook is trigger, an analyst must verify the data:
 - Identify the sender / recipient
 - Build context from the email body / headers
 - Extract any urls or attachments
 - Check for credential phishing urls
 - Check user account for any un-authorized log in attempts.

 #### Malware Playbook
 | Prerequisite | Details | 
 | ------------ | ------- | 
 | Relevant Logs | - EDR logs 
 - Sysmon logs
 - Syslog 
 - Windows event logs 
 - Network communication logs |
 | Required Fields | - Process names
 - Parent process names
 - Process ID
 - File/Process hashes
 - Process image path
 - CLI parameters 
 - Acitivity details |
 | Use cases | - Suspicious parent-child relationship
 - suspicious file access
 - suspicious registry events
 - suspicious network activity |
 | Security Controls | - Malware quarantine EDR
 - shellcode blocking
 - exploit protection |

 Detection:
 - EDR marked a process as malicious
 - Trellix has actioned the filesystem
 - Browser has executed a script or process

 Analysis
 - Identify the process that triggered the alert
 - Check the binary's reputation, check has on VT or hybrid analysis
 - Using VT check if the process is marked as safe or by a recognised vendor.
 - If the process was clean, but executed a file. Check that file on VT
 - Check the parent process
 - Identify how the process was started / delivered.
 - If it was delivered via phishing trigger the phishing playbook
 - Execute malware in sandbox
 - Note the activities in a document to aid in containment
 - Preserve evidence
 - Forensic analysis to identify further IOCs
 - Threat hunt

### Workflow Diagrams
[Example workflow](Images/workflow.jpg)


### Detection & Analysis Checklist
Ensure the following points are considered in this portion of the playbook
- Alert trigger
- Verification of data from the logs
- Verify with external sources or intel
- Verify metadata of the IOC (processes, instructions, domain age, etc)
- Action the results

### Escalation Process
L1 - Will analyze 
