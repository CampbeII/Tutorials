# Active Directory
Controls and governs a network of computers, servers and other devices.

## Key Concepts:

### Domain
Acts as a core unit regarding the locgical structure of AD.

### Domain Controller
An AD server that supervises the network. It provides authentication for users and resources.
```sh
User accesses domain > Request send to DC > DC validates > Grant / Deny
```

### Trees & Forests
Trees
- Trees are a set of domains
- shares resources between domains
- Communication is one-way or two-way trust.
- When a new domain is added to the tree it becomes a child of the parent domain.

Forests
- Forests are a set of trees
- Communication between two forests once forest-level trust is estabilished.
- Shares standard global catalogue, directory schema, logical structure, and directory configuration.

Trust in AD
```sh
Server Manager > Tools > Active Directory Domains and Trust
```

- The communication brigde between AD domains
- trust = shared resources

Trust is estabilished based on 2 categories:

| Characteristics | Directions |
| --------------- | ---------- |
| transitive trusts | one-way trusts |
| non-transitive trusts | two-way trusts |

Transitive Trusts
Reflects a 2-way relationship between domains. If there are 3 domains:
```sh
Domain A - Trusts -> Domain B
Domain B - Transitive Trust -> Domain C
Domain A - Trusts -> Domain C
```

Container & Leaves
Each part of the network is treated as on AD object. 
- Resources
- Users
- Services

Objects can be nested (container) or single (leaf)


## Securing Authentication Methods
Secure comminication and data integrity between machines in AD by usisng `Group Policy Managemenet Editor`

LAN Manager Hash
- Passwords are stored with 2 hashes.
- When a password is set with < 15 characters both LM and NT hashes are genered
- LM is weaker than NT and prone to brute force

Prevent the LM hash
```sh
Group Policy Management Editor > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > double click network security - "do not store LM hash value on next password change policy > select "define policy"
```

## SMB Signing
Configuring SMB signing through group policy is crucial to detect MITM attacks that modify SMB traffic in transit.
```sh
Group Policy Management Editor > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > double click microsoft network server: Digitally sign communication (always) > Enable digitally sign communications.
```

## LDAP Signing
Lightweight Directory Access Protocol enables locating and authenticating resources on the network. Attacks typically attempt a replay attack.

```sh
Group Policy Management Editor > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > Domain controller: LDAP server signing requirements > select reqeuire signing from the drop down.
```

## Passwords 

### Rotation
There are a few options available for password rotation:

1. Create a script to update passwords automatically using scheduled tasks and powershell.
2. Add MFA to reduce the frequency of password update requirements.
3. Built-in `Group Managed Services Accounts` (gMSAs) which will change the password every 30 days.

### Policies
Enforce strong passwords, length, complexity, change frequency.
```sh
Group Policy Management Editor > Computer Configuration > Policies > Windows Settings > Security Settings > Account Policies > Password Policy
```
Enforce password history: prevent password reuse
Minimum password length: set between 10 - 14
Complexity requiremens: uppercase, special chars, etc

## Least Privilege
Enusre you create the proper account:
User accounts -> regular duties
Privilege accounts -> elevated permissions
Shared accounts -> shared amongst visitors for specific time.

### Tired Access Model
| Tier | Description |
| 0 | Admin, domain controller, groups |
| 1 | Domain members |
| 2 | End-users like HR, sales staff, visitors |

## Microsoft Security Compliance Toolkit (MSCT)
manage local and domain level policies.

Installing security baselines
You can download baselines from the MSC website. 

Policy Anaylzer
Check group policies for inconsistencies, redundant settings, etc
