# Containerize Python
```py
from http.server import HTTPServer, SimpleHTTPRequestHandler

httpd = HTTPServer(('localhost',4200), SimpleHTTPRequestHandler)
httpd.serve_forever()
```
