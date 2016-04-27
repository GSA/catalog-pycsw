#!/bin/bash


# configure ini files
/bin/sh /usr/local/bin/pycsw_config.sh

# wait for all services to start-up
if [ "$1" = '--wait-for-dependencies' ]; then
    sh -c "while ! nc -w 1 -z $DB_PORT_5432_TCP_ADDR $DB_PORT_5432_TCP_PORT; do sleep 1; done"
fi

# initialize DB
/usr/lib/pycsw/bin/pycsw-ckan.py -c setup_db -f /etc/pycsw/pycsw-all.cfg

# start apache2
/bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

