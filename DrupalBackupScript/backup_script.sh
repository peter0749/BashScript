#!/bin/sh
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

date=`date +%Y%m%d_%H%M`;

MYSQLHOST="";
MYSQLDB="";
MYSQLUSER="";
MYSQLPASSWD="";
SQL_DOWN_SCRIPT="";
SQL_UP_SCRIPT="";
SQL_BACKUP="";
DRUPAL_BACKUP="";
DRUPAL_DIR="";

BACKUPMYSQL="mysqldump -u $MYSQLUSER -p$MYSQLPASSWD --host=$MYSQLHOST  $MYSQLDB  --skip-lock-tables";

mysql -u $MYSQLUSER -p$MYSQLPASSWD --host=$MYSQLHOST --database=$MYSQLDB <  $SQL_DOWN_SCRIPT
sync;

echo 'Turn Offline mode';

#Backup
$BACKUPMYSQL > /tmp/$date.sql;
echo 'Copied to tmp';

#Compress
xz /tmp/$date.sql;
echo 'Compressed';

#Copy back
cp /tmp/$date.sql.xz $SQL_BACKUP/$date.sql.xz;
echo 'Copied to backup dir';

#Clean up
sync;
rm -f /tmp/$date.sql.xz;
echo 'Successfully Backup-ed MySQL Database';

#Backup Drupal
tar zcvfp $DRUPAL_BACKUP/$date.tar.gz $DRUPAL_DIR
echo 'Successfully Backup-ed Drupal Files'

mysql -u $MYSQLUSER -p$MYSQLPASSWD --host=$MYSQLHOST --database=$MYSQLDB <  $SQL_UP_SCRIPT
echo 'Website is back online!'
sync;

