#!/usr/bin/env bash

echo "------------------------------"
echo "queues: add"
echo "------------------------------"

QUEUE_NAME=$1

sudo cat - > /etc/supervisor/conf.d/${QUEUE_NAME}.conf <<EOF
[program:${QUEUE_NAME}]
process_name=%(program_name)s_%(process_num)02d
numprocs=1
user=www-data
directory=/var/www
command=php artisan queue:work --daemon --queue=%(program_name)s --tries=3
autostart=true
autorestart=true
redirect_stderr=true
stderr_logfile=/var/log/supervisor/%(program_name)s.err.log
stderr_logfile_maxbytes=10MB
stderr_logfile_backups=10
stdout_logfile=/var/log/supervisor/%(program_name)s.out.log
stdout_logfile_maxbytes=10MB
stdout_logfile_backups=10
EOF

sudo supervisorctl reread > /dev/null
sudo supervisorctl update > /dev/null
sudo service supervisor restart > /dev/null
