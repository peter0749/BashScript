#!/bin/bash

MYSQLHOST="";
MYSQLDB="";
MYSQLUSER="";
MYSQLPASSWD="";
SDCOMM="mysql -u $MYSQLUSER -p$MYSQLPASSWD --host=$MYSQLHOST --database=$MYSQLDB"

echo $SDCOMM

$SDCOMM < turn_off_drupal.sql

sync;

