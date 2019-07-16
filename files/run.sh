#!/bin/bash
if [ ! -f /data/.initialised ]; then
    mv /var/lib/mysql /data/
    mkdir /data/etc
    cp -r /etc/centreon* /data//etc/
    chown -R centreon-broker.centreon-broker /data/etc/centreon-broker
    chown -R centreon-engine.centreon-engine /data/etc/centreon-engine
    chown -R centreon.centreon /data/etc/centreon
    chmod g+w /data/etc/centreon /data/etc/centreon-broker /data/etc/centreon-engine -R
    touch /data/.initialised
else
    rm -rf /usr/share/centreon/www/install
fi

if [ ! -f /etc/.initialised ]; then
	rm -rf /etc/centreon* 
	rm -rf /var/lib/mysql
	ln -s /data/etc/centreon-engine /etc/centreon-engine
	ln -s /data/etc/centreon-broker /etc/centreon-broker
	ln -s /data/etc/centreon /etc/centreon 
	ln -s /data/mysql /var/lib/mysql
	touch /etc/.initialised
fi


supervisord -c /opt/supervisor.conf -n

