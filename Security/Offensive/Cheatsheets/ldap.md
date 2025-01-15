# LDAP
Lightweight Directory Access Protocol. Used for accessing and maintaining distributed directory information services over a network.

## Structure
```sh
dc=ldap,dc=example
    ou=people 
        cn=John Smith
        mail=john@example.com
        sn=Smith

    cn=Jane Smith
        mail=jane@example.com
        sn=Smith

    ou=groups 
        cn=Admins
        cn=Users
```

| Syntax | Description |
| ------ | ----------- |
| `dc=ldap,dc=companyname` | Top level domain (TLD) |
| `cn=John Smith` | Common Name |
| `mail=test@example.com` | Attributes |

## Search Queries
A query is made up of several components:

- Base DN (Distinguished Name): Starting point
- Scope: How deep the search will go
    - `base`: search base DN only
    - `one`: immediate children of the base DN
    - `sub`: base DN and all it's descendants
- Filter: Criteria to match
- Attributes: Which characteristics of the matching entries should be returned

### Syntax

| Condition | Description |
| --------- | ----------- |
| `=` | equality |
| `=*` | presence |
| `>=` | greater than |
| `<=` | less than |

```sh
(base DN) (scope) (filter) (attributes)
```

| Filter | Description |
| ------ | ----------- |
| `(cn=John Smith)` | Match all entries with a canonical name matching exactly "John Smith" |
| `(cn=A*)` | Entries begining with "A" |
| `(&(objectClass=user)(|(cn=John*)(cn=Jane*)))` | user entries with cn starting with either "john" or "jane" |

## Tools

1. LDAPSearch
Part of the OpenLDAP suite. This tool can help query LDAP
```sh
ldapsearch -x -H ldap://10.10.10.10:389 -b "dc=ldap,dc=example" "(ou=People)"
```

## Injection

### Tautology-Based Injection
Involves inserting conditions into an LDAP query that are inherently true. 
```sh
(&(uid={vulnerable user input})(password={vulnerable}))

(&(uid=*)(|(&)(userPassword=pwd)))
```


