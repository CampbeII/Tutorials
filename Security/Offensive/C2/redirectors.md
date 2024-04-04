# C2 Redirectors
A server that redirects HTTPS? requests based on the information contained in the request body.

## Purpose
Servers can be taken down or siezed very quickly. By placing a redirector in between your C2 server and your target network you prevent your C2 server from being exposed in logs and investigations.

## Apache Setup
Install the following apache modules:

| Module | Purpose |
| ------ | ------- |
| [mod_rewrite](https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html) | Rewrite URLs and map them to a resource |
| [mod_proxy](https://httpd.apache.org/docs/2.4/mod/mod_proxy.html) | Implement forward or reverse proxy |
| [mod_proxy_http](https://httpd.apache.org/docs/2.4/mod/mod_proxy_http.html) | Required by mod_proxy |
| [mod_headers](https://httpd.apache.org/docs/2.4/mod/mod_headers.html) | Control and modify headers |

```
a2enmod rewrite && a2enmod proxy && a2enmod proxy_http && a2enmod headers && systemctl restart apache
```

## Apache Configuration
Make the following changes to your apache `.conf` file:

` RewriteCond %{HTTP_USER_AGENT} "^TEST"` - Match user agents starting with TEST

`ProxyPass "/" "http://c2server:8080"` - Forward all requests to C2 server

```
<VirtualHost *:80>
    ServerAdmin wizard@localhost
    DocumentRoot /var/www/html

    RewriteEngine On
    RewriteCond %{HTTP_USER_AGENT} "^TEST"
    ProxyPass "/" "http://localhost:8080"

    <Directory>
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
```
