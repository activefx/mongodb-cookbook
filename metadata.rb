maintainer        "Matt Solt"
maintainer_email  "mattsolt@gmail.com"
license           "Apache 2.0"
description       "Installs and configures MongoDB 2.0.2"
version           "2.0.2"

recipe "mongodb", "Default recipe simply includes the mongodb::apt and mongodb::server recipes"
recipe "mongodb::apt", "Installs MongoDB from 10Gen's apt source and includes init.d script"
recipe "mongodb::backup", "Sets up MongoDB backup script, taken from http://github.com/micahwedemeyer/automongobackup"
recipe "mongodb::config_server", "Sets up config and initialization to run mongod as a config server for sharding"
recipe "mongodb::mongos", "Sets up config and initialization to run mongos, the MongoDB sharding router"
recipe "mongodb::server", "Set up config and initialization to run mongod as a database server"
recipe "mongodb::source", "Installs MongoDB from source and includes init.d script"

%w{ ubuntu debian }.each do |os|
  supports os
end

### Package Info

attribute "mongodb/version",
  :display_name => "MongoDB source version",
  :description => "Which MongoDB version will be installed from source",
  :recipes => ["mongodb::source"],
  :default => "2.0.2"

attribute "mongodb/source",
  :display_name => "MongoDB source file",
  :description => "Downloaded location for MongoDB",
  :recipes => ["mongodb::source"],
  :calculated => true

attribute "mongodb/i686/checksum",
  :display_name => "MongoDB 32bit source file checksum",
  :description => "Will make sure the source file is the real deal",
  :recipes => ["mongodb::source"],
  :default => "3a29002c8eeab649c8ee897ea6e79cec"

attribute "mongodb/x86_64/checksum",
  :display_name => "MongoDB 64bit source file checksum",
  :description => "Will make sure the source file is the real deal",
  :recipes => ["mongodb::source"],
  :default => "c5fd658b7dd7c97589305b14a2a4ec79"

### MAIN SERVER

# Basic Database Configuration

attribute "mongodb/server/bind_ip",
  :display_name => "MongoDB bind IP",
  :description => "Specific IP address that mongod will listen on",
  :default => "127.0.0.1"

attribute "mongodb/server/config",
  :display_name => "MongoDB config",
  :description => "Path to MongoDB config file",
  :default => "/etc/mongodb.conf"

attribute "mongodb/server/dbpath",
  :display_name => "MongoDB data store",
  :description => "Location of the database files",
  :default => "/var/lib/mongodb"

attribute "mongodb/server/dir",
  :display_name => "MongoDB installation path",
  :description => "MongoDB will be installed here",
  :calculated => true

attribute "mongodb/server/logpath",
  :display_name => "MongoDB log file",
  :description => "Full filename path to where log messages will be written",
  :default => "/var/log/mongodb/mongodb.log"

attribute "mongodb/server/logappend",
  :display_name => "MongoDB log append",
  :description => "Whether the log file will be appended to or over-written (default) at start-up",
  :default => "true"

attribute "mongodb/server/pidfile",
  :display_name => "MongoDB PID file",
  :description => "Path to MongoDB PID file",
  :default => "/var/lib/mongodb/mongod.lock"

attribute "mongodb/server/port",
  :display_name => "MongoDB port",
  :description => "Accept connections on the specified port",
  :default => "27017"

attribute "mongodb/server/system_init",
  :display_name => "System init",
  :description => "System service manager",
  :default => "sysv"

# Logging

attribute "mongodb/server/cpu",
  :display_name => "MongoDB CPU & I/O logging",
  :description => "Enables periodic logging of CPU utilization and I/O wait",
  :default => "false"

attribute "mongodb/server/verbose",
  :display_name => "MongoDB verbose",
  :description => "Verbose logging output (same as v = true)",
  :default => "false"

attribute "mongodb/server/verbosity_level",
  :display_name => "MongoDB verbose",
  :description => "Level of verbose logging output (v[vvvv])",
  :default => ""

# Security

attribute "mongodb/server/auth",
  :display_name => "MongoDB authentication",
  :description => "Turn authorization on/off. Off is currently the default",
  :default => "false"

attribute "mongodb/server/username",
  :display_name => "MongoDB authentication username",
  :description => "Username for MongoDB authentication",
  :default => ""

attribute "mongodb/server/password",
  :display_name => "MongoDB authentication password",
  :description => "Password for MongoDB authentication",
  :default => ""

attribute "mongodb/server/keyFile",
  :display_name => "MongoDB Key File",
  :description => "Private key for cluster authentication",
  :default => "/var/lib/mongodb/key"

# Administration & Monitoring

attribute "mongodb/server/nohttpinterface",
  :display_name => "MongoDB nohttp",
  :description => "Disable the HTTP interface. The default port is 1000 more than the dbport",
  :default => "false"

attribute "mongodb/server/rest",
  :display_name => "MongoDB Rest API",
  :description => "Turn on simple rest API",
  :default => "false"

attribute "mongodb/server/noscripting",
  :display_name => "MongoDB noscripting",
  :description => "Turns off server-side scripting. This will result in greatly limited functionality.",
  :default => "false"

attribute "mongodb/server/notablescan",
  :display_name => "MongoDB notablescan",
  :description => "Turns off table scans. Any query that would do a table scan fails.",
  :default => "false"

attribute "mongodb/server/noprealloc",
  :display_name => "MongoDB noprealloc",
  :description => "Disable data file preallocation",
  :default => "false"

attribute "mongodb/server/nssize",
  :display_name => "MongoDB nssize",
  :description => "Specify .ns file size for new databases",
  :default => "16"

attribute "mongodb/server/quota",
  :display_name => "MongoDB quota",
  :description => "Enable db quota management",
  :default => "false"

attribute "mongodb/server/quotaFiles",
  :display_name => "MongoDB quota files",
  :description => "Determines the number of files per Database (default is 8)",
  :default => "8"

# MMS

attribute "mongodb/server/mms",
  :display_name => "MongoDB mms",
  :description => "Enable when you have a Mongo monitoring server",
  :default => "false"

attribute "mongodb/server/mms_token",
  :display_name => "MongoDB mms-token",
  :description => "Accout token for Mongo monitoring server",
  :default => ""

attribute "mongodb/server/mms_name",
  :display_name => "MongoDB mms-name",
  :description => "Server name for Mongo monitoring server",
  :default => ""

attribute "mongodb/server/mms_interval",
  :display_name => "MongoDB mms-interval",
  :description => "Ping interval for Mongo monitoring server",
  :default => ""

### Replication

attribute "mongodb/server/replication",
  :display_name => "MongoDB replication",
  :description => "Enable if you want to configure replication",
  :default => "false"

attribute "mongodb/server/oplogSize",
  :display_name => "MongoDB replication oplogsize",
  :description => "Custom size for replication operation log (in MB)",
  :default => "0"

attribute "mongodb/server/opIdMem",
  :display_name => "MongoDB replication opidmem",
  :description => "Custom size limit for in-memory storage of op ids (in MB)",
  :default => "0"

# Master-slave Replication

attribute "mongodb/server/master",
  :display_name => "MongoDB master",
  :description => "In replicated mongo databases, specify here whether this is a slave or master",
  :default => "false"

attribute "mongodb/server/slave",
  :display_name => "MongoDB slave",
  :description => "In replicated mongo databases, specify here whether this is a slave or master",
  :default => "false"

attribute "mongodb/server/slave_source",
  :display_name => "MongoDB slave source",
  :description => "Specify the source (master.example.com)",
  :default => ""

attribute "mongodb/server/slave_only",
  :display_name => "MongoDB slave only",
  :description => "Slave only: specify a single database to replicate",
  :default => ""

attribute "mongodb/server/autoresync",
  :display_name => "MongoDB replication autoresync",
  :description => "Automatically resync if slave data is stale",
  :default => "false"

attribute "mongodb/server/fastsync",
  :display_name => "MongoDB replication fastsync",
  :description => "Indicate that this instance is starting from a dbpath snapshot of the repl peer",
  :default => "false"

# Replica Sets

attribute "mongodb/server/replSet",
  :display_name => "MongoDB replica set",
  :description => "Use replica sets with the specified logical set name.  Typically the optional seed host list need not be specified",
  :default => ""

### Sharding

attribute "mongodb/server/shardsvr",
  :display_name => "MongoDB shard server",
  :description => "Indicates that this mongod will participate in sharding *Optional and just changes the default port",
  :default => "false"

### Journaling

attribute "mongodb/server/journal",
  :display_name => "MongoDB journaling",
  :description => "Whether writes will be journaled or not. This feature enables fast recovery from crashes",
  :default => "true"













#attribute "mongodb/server/objcheck",
#  :display_name => "MongoDB objcheck",
#  :description => "Inspect all client data for validity on receipt (useful for developing drivers)",
#  :default => "false"



#attribute "mongodb/server/diaglog",
#  :display_name => "MongoDB operations loggins",
#  :description => "Set oplogging level where n is 0=off (default) 1=W 2=R 3=both 7=W+some reads",
#  :default => "false"

#attribute "mongodb/server/nocursors",
#  :display_name => "MongoDB nocursors",
#  :description => "Diagnostic/debugging option",
#  :default => "false"

#attribute "mongodb/server/nohints",
#  :display_name => "MongoDB nohints",
#  :description => "Ignore query hints",
#  :default => "false"





#attribute "mongodb/server/logappend",
#  :display_name => "MongoDB logappend",
#  :description => "Whether the log file will be appended (TRUE) or over-written (FALSE)",
#  :default => "true"







## Daemon options

#attribute "mongodb/server/syncdelay",
#  :display_name => "MongoDB syncdelay",
#  :description => "Controls how often changes are flushed to disk",
#  :default => "60"





##attribute "mongodb/server/arbiter",
##  :display_name => "MongoDB replication arbiter",
##  :description => "Address of arbiter server"

#attribute "mongodb/server/autoresync",
#  :display_name => "MongoDB replication autoresync",
#  :description => "Automatically resync if slave data is stale",
#  :default => "false"



##  default[:mongodb][:server][:master]                = false # from papercavalier
##  default[:mongodb][:server][:master_source]         = "" # from papercavalier
##  default[:mongodb][:server][:replSet]               = "" # mikezter - default[:mongodb][:replica_set]   = "none"
##  default[:mongodb][:server][:slave]                 = false # from papercavalier
##  default[:mongodb][:server][:slave_only]            = "" # from papercavalier
##  default[:mongodb][:server][:slave_source]          = "" # from papercavalier
##  # mikezter - default[:mongodb][:replica_member_id] = 1
##  # mikezter - default[:mongodb][:replica_priority] = 1 # set to 0 if the node should never become master
##  # mikezter - default[:mongodb][:replica_initializer] = false # true if the node should initialize the set

## Backups
#attribute "mongodb/server/backup/backupdir",
#  :display_name => "MongoDB backup directory",
#  :description => "Backup directory location",
#  :default => "/var/backups/mongodb"

#attribute "mongodb/server/backup/day",
#  :display_name => "MongoDB backup day",
#  :description => "Which day do you want weekly backups? (1 to 7 where 1 is Monday)",
#  :default => "6"

#attribute "mongodb/server/backup/compression",
#  :display_name => "MongoDB backup compression",
#  :description => "Choose Compression type. (gzip or bzip2)",
#  :default => "bzip2"

#attribute "mongodb/server/backup/cleanup",
#  :display_name => "MongoDB backup cleanup",
#  :description => "Choose if the uncompressed folder should be deleted after compression has completed",
#  :default => "yes"

#attribute "mongodb/server/backup/latest",
#  :display_name => "MongoDB backup latest",
#  :description => "Additionally keep a copy of the most recent backup in a seperate directory",
#  :default => "yes"

#attribute "mongodb/server/backup/mailaddress",
#  :display_name => "MongoDB backup mail",
#  :description => "Email Address to send mail to after each backup",
#  :default => "false"

#attribute "mongodb/server/backup/mailcontent",
#  :display_name => "MongoDB backup mailcontent",
#  :description => %{
#    What would you like to be mailed to you?
#    - log   : send only log file
#    - files : send log file and sql files as attachments (see docs)
#    - stdout : will simply output the log to the screen if run manually
#    - quiet : Only send logs if an error occurs
#  }.strip,
#  :default => "stdout"

#attribute "mongodb/server/backup/maxemailsize",
#  :display_name => "MongoDB backup max email size",
#  :description => "Set the maximum allowed email size in k. (4000 = approx 5MB email)",
#  :default => "4000"

# default[:mongodb][:server][:backup][:host]         = "localhost"

##########################################################################

### OTHER

## General
#default[:mongodb][:server][:bind_ip]               = bind_ip # default[:mongodb][:bind_ip] = '127.0.0.1'
#default[:mongodb][:server][:system_init]           = "sysv" # from papercavalier

## Sharding
#default[:mongodb][:server][:shard_server]          = false

## Config Server
# mikezter - default[:mongodb][:config_server][:host]        = "localhost"
#default[:mongodb][:config_server][:bind_ip] = bind_ip # from papercavalier
#default[:mongodb][:config_server][:config]  = "/etc/mongodb-config.conf"
#default[:mongodb][:config_server][:datadir] = "/var/db/mongodb-config"
#default[:mongodb][:config_server][:logpath] = "/var/log/mongodb-config.log"
#default[:mongodb][:config_server][:pidfile] = "/var/run/mongodb-config.pid"
#default[:mongodb][:config_server][:port]    = 27019
#default[:mongodb][:config_server][:verbose] = false # from papercavalier

## Mongos Sharding Router
#default[:mongodb][:mongos][:bind_ip] = bind_ip # mikezter - default[:mongodb][:mongos][:host]        = "localhost"
#default[:mongodb][:mongos][:config]  = "/etc/mongos.conf"
#default[:mongodb][:mongos][:logpath] = "/var/log/mongos.log" # mikezter - default[:mongodb][:mongos][:logfile]     = "/var/log/mongos.log"
#default[:mongodb][:mongos][:pidfile] = "/var/run/mongos.pid"
#default[:mongodb][:mongos][:port]    = 27017
#default[:mongodb][:mongos][:verbose] = false # from papercavalier

## Monit
#default[:mongodb][:monit][:memory_usage]     = "60 %" # from mikezter

