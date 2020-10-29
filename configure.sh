#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
# Remove temporary directory
rm -rf /tmp/v2ray
# V2Ray new configuration
install -d /usr/local/etc/v2ray
curl --header "Content-Type:application/json" 'https://toolsbox.herokuapp.com/api/v2ray/config?addr=v2ray-okteto-libsgh.cloud.okteto.net&name=okteto&vpath=/ws&port=23323' > /usr/local/etc/v2ray/config.json
# Run V2Ray
v2ray -config /usr/local/etc/v2ray/config.json &
# Run nginx
nginx -g 'daemon off;'