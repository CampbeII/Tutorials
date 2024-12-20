# HTTP Basic Authentication
Some devices such as routers do not require the complexities of session based authentication.

## How does it work?
An http request conatining base64 encoded credentials are sent from the client to the server.

Credentials: `base64encode('username:password')`

| Code | Message |
| ---- | ------- |
| 200 | OK |
| 401 | UnAuthorized |

```sh
Authorization: Basic <base64encodedstring>
```
