### SOURCE PACKAGES
default[:mongodb][:version]           = "2.0.2"
default[:mongodb][:source]            = "http://fastdl.mongodb.org/linux/mongodb-linux-#{node[:kernel][:machine]}-#{mongodb[:version]}.tgz"
# http://dl.mongodb.org/dl/linux/i686
default[:mongodb][:i686][:checksum]   = "3a29002c8eeab649c8ee897ea6e79cec"
# http://dl.mongodb.org/dl/linux/x86_64
default[:mongodb][:x86_64][:checksum] = "c5fd658b7dd7c97589305b14a2a4ec79"

bind_ip = [ "127.0.0.1" ]

# we'll be re-using this across all server type configs
if node[:network][:interfaces][:eth0]
  bind_ip << node[:network][:interfaces][:eth0][:addresses].select do |address, values|
    values['family'] == 'inet'
  end.first.first
else
  bind_ip = [ "0.0.0.0" ]
end

##########################################################################
### MAIN SERVER

### GENERAL
default[:mongodb][:server][:bind_ip]               = bind_ip
default[:mongodb][:server][:config]                = "/etc/mongodb.conf"
default[:mongodb][:server][:dbpath]                = "/var/lib/mongodb" # "/var/db/mongodb"
default[:mongodb][:server][:dir]                   = "/opt/mongodb-#{mongodb[:version]}"
default[:mongodb][:server][:logpath]               = "/var/log/mongodb.log"
default[:mongodb][:server][:logappend]             = true
default[:mongodb][:server][:pidfile]               = "/var/lib/mongodb/mongod.lock" # "/var/run/mongodb.pid"
default[:mongodb][:server][:port]                  = 27017
default[:mongodb][:server][:system_init]           = "sysv"

### EXTRA
# Administration & Monitoring
default[:mongodb][:server][:nohttpinterface]       = false
default[:mongodb][:server][:rest]                  = false
default[:mongodb][:server][:noscripting]           = false
default[:mongodb][:server][:notablescan]           = false
default[:mongodb][:server][:noprealloc]            = false
default[:mongodb][:server][:nssize]                = false
default[:mongodb][:server][:quota]                 = false
default[:mongodb][:server][:quotaFiles]            = ""
# Logging
default[:mongodb][:server][:cpu]                   = false
default[:mongodb][:server][:verbose]               = false
# Security
default[:mongodb][:server][:auth]                  = false
default[:mongodb][:server][:username]              = ""
default[:mongodb][:server][:password]              = ""
# Sharding
default[:mongodb][:server][:shardsvr]              = false # default[:mongodb][:server][:shard_server]
# Journaling
default[:mongodb][:server][:journal]               = false
# Additional Configuration Options
default[:mongodb][:server][:directoryperdb]        = false
default[:mongodb][:server][:quiet]                 = false
default[:mongodb][:server][:repairpath]            = ""
default[:mongodb][:server][:objcheck]              = false
default[:mongodb][:server][:syncdelay]             = 60
default[:mongodb][:server][:diaglog]               = false
default[:mongodb][:server][:nocursors]             = false
default[:mongodb][:server][:nohints]               = false
default[:mongodb][:server][:smallfiles]            = false
default[:mongodb][:server][:nounixsocket]          = false

### MMS
default[:mongodb][:server][:mms]                   = false
default[:mongodb][:server][:mms_interval]         = ""
default[:mongodb][:server][:mms_name]             = ""
default[:mongodb][:server][:mms_token]            = ""

### MASTER/SLAVE
default[:mongodb][:server][:master]                = false
default[:mongodb][:server][:slave]                 = false
default[:mongodb][:server][:slave_source]          = "" # <server:port>
default[:mongodb][:server][:slave_only]            = "" # <db>

### MASTER/SLAVE & REPLICATION
default[:mongodb][:server][:replication]           = false
default[:mongodb][:server][:autoresync]            = false
default[:mongodb][:server][:fastsync]              = false
default[:mongodb][:server][:opidmem]               = 0
default[:mongodb][:server][:oplogsize]             = 0
default[:mongodb][:server][:arbiter]               = "" # <server:port>

### REPLICATION
default[:mongodb][:server][:replSet]               = ""
default[:mongodb][:server][:replica_member_id]     = 0
default[:mongodb][:server][:replica_initializer]   = false # set to true if the node should initialize the set
default[:mongodb][:server][:keyFile]               = ""
# Optional Replica Set Config Options
default[:mongodb][:server][:arbiter_only]          = false
default[:mongodb][:server][:build_indexes]         = true
default[:mongodb][:server][:hidden]                = false
default[:mongodb][:server][:priority]              = 1 # set to 0 if the node should never become master - v1.8 - only 1 or 0, v2.0 - can be specific priorty number
#default[:mongodb][:server][:tags]                  = [] # v2.0
default[:mongodb][:server][:slave_delay]           = 0
default[:mongodb][:server][:votes]                 = 1

### BACKUP
default[:mongodb][:server][:backup][:backupdir]    = "/var/backups/mongodb"
default[:mongodb][:server][:backup][:cleanup]      = "yes"
default[:mongodb][:server][:backup][:compression]  = "bzip2"
default[:mongodb][:server][:backup][:day]          = 6
default[:mongodb][:server][:backup][:host]         = "localhost"
default[:mongodb][:server][:backup][:latest]       = "yes"
default[:mongodb][:server][:backup][:mailaddress]  = false
default[:mongodb][:server][:backup][:mailcontent]  = "stdout"
default[:mongodb][:server][:backup][:maxemailsize] = 4000

##########################################################################
### CONFIG SERVER
default[:mongodb][:config_server][:bind_ip] = bind_ip
default[:mongodb][:config_server][:config]  = "/etc/mongodb-config.conf"
default[:mongodb][:config_server][:datadir] = "/var/db/mongodb-config"
default[:mongodb][:config_server][:logpath] = "/var/log/mongodb-config.log"
default[:mongodb][:config_server][:pidfile] = "/var/run/mongodb-config.pid"
default[:mongodb][:config_server][:port]    = 27019
default[:mongodb][:config_server][:verbose] = false

##########################################################################
### MONGOS - SHARDING ROUTER
default[:mongodb][:mongos][:bind_ip] = bind_ip
default[:mongodb][:mongos][:config]  = "/etc/mongos.conf"
default[:mongodb][:mongos][:logpath] = "/var/log/mongos.log"
default[:mongodb][:mongos][:pidfile] = "/var/run/mongos.pid"
default[:mongodb][:mongos][:port]    = 27017
default[:mongodb][:mongos][:verbose] = false

##########################################################################
### Monit
default[:mongodb][:monit][:memory_usage]     = "60 %" # from mikezter

