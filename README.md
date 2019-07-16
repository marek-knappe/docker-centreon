# Centreon docker



This is docker image for Centreon full stack
(engine + poller + database). For me is only used for proof of concept so if you want to use it in prod make sure u will secure it a bit (probably set root password for mysql database at least). 

This image is using persisten volume for config files and database (so u can run is as non-persistent docker machine)

to run:

```
docker build . -t centreon
docker -p 8080:80 -v /local/host/dir:/data centreon 
```

Then access centreon on 

```
http://IP:8080
```

This image has few hacks:

- run.sh is running proper symlinks and deleting install directory if setup is already done (indicated by . files in /data and /etc)
- as docker doesn't have proper systemctl system there is init.d script for cbd and centegine that is just killing it and supervisor is restarting it
- First run (before installing), you will get a lot of errors about config files - it's beacause installation didn't generate config files yet - after installation it should be all right
