# Logging

Most logs are stored in 
```sh
/var/log
```

## Log Types
- System logs for general health and system functions. 
- Application logs for software installed on the system.
- Security logs for security events such as authentication attempts.

## Tools

### Aureport
This will give you a nice summary of results, or just the failed results.
```sh
aureport --summary
aureport --failed
```

#### Searching:

| Option | Description |
| ------ | ----------- |
`USER_LOGIN`| User login events |
`DEL_USER`| User delete events |
`ADD_GROUP`| Group has been added |
`USER_CHAUTHTOK` | Auth token has changed |
`DEL_GROUP`| Group deleted |
`CHGRP_ID`| Group id changed |
`ROLE_ASSIGN`| New role assigned |
`ROLE_REMOVE` | Role removed |

```sh
ausearch --message USER_LOGIN --success yes --interpret
ausearch --message USER_LOGIN --success no --interpret

# Root logins
ausearch --message USER_LOGIN --success yes --interpret | grep ct=root | wc -l
```


