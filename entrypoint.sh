#!/bin/bash

echo "Waiting for FMDNS master to become available"

until $(curl --output /dev/null --silent --head --fail http://$FACILE_MANAGER_HOST); do
    printf '.'
    sleep 5
done

printf "h\n/var/www/html/\n" | php /usr/local/facileManager/fmDNS/client.php install

# Make it so that Apache can run sudo commands in order to re-generate the bind9 zone files
cat <<EOF >> /etc/sudoers
Defaults:www-data  !requiretty
Defaults:www-data  !env_reset
www-data ALL=(ALL) NOPASSWD: ALL
EOF

exec /usr/local/bin/docker-php-entrypoint $@