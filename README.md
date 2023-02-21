This is the repo of commonly used Docker recipes.

We keep them here so that they do not change without knowing about it.

#### PHP7.4

Enable xdebug - in `.env` or docker-compose.yml set `ENABLE_XDEBUG="true"`

If you get the error "Phpstorm Xdebug Error: cannot Accept External Xdebug Connection: Cannot Evaluate Expression `$_server['server_port']`",
it can mean that `$http_x_forwarded_port` in the nginx config doesnt work, just override it for now with `80` for localdev.

in default.conf

```
-           fastcgi_param  SERVER_PORT $http_x_forwarded_port;
+           fastcgi_param SERVER_PORT 80;
```