#!/bin/sh
wget https://getcaddy.com -O getcaddy
chmod +x getcaddy
sudo ./getcaddy personal http.browser http.webdav
mkdir -p /etc/caddy
mkdir -p /var/log/caddy
mkdir -p /var/www/html
cat > /etc/systemd/system/caddy.service << END
[Unit]
Description=Caddy HTTP/2 web server

[Service]
User=root
Group=root
Environment=CADDYPATH=/etc/caddy
ExecStart=/usr/local/bin/caddy -agree=true -log=/var/log/caddy/caddy.log -conf=/etc/caddy/Caddyfile -root=/dev/null
ExecReload=/bin/kill -USR1 $MAINPID
LimitNOFILE=1048576
LimitNPROC=64

[Install]
WantedBy=multi-user.target
END
systemctl daemon-reload
systemctl start caddy
systemctl enable caddy
echo "Install Success!"
