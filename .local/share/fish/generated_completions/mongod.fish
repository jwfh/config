# mongod
# Autogenerated from man page /usr/share/man/man1/mongod.1.gz
# using Deroffing man parser
complete -c mongod -l help -s h --description 'Returns information on the options and use of mongod.'
complete -c mongod -l version --description 'Returns the mongod release number. UNINDENT NDENT 0. 0.'
complete -c mongod -l config -s f --description 'Specifies a configuration file for runtime conf… [See Man Page]'
complete -c mongod -l verbose -s v --description 'Increases the amount of internal reporting retu… [See Man Page]'
complete -c mongod -l quiet --description 'Runs the mongod in a quiet mode that attempts t… [See Man Page]'
complete -c mongod -l port --description 'Default: 27017 .'
complete -c mongod -l bind_ip --description 'Default: All interfaces. sp Changed in version 2. 6.'
complete -c mongod -l maxConns --description 'The maximum number of simultaneous connections … [See Man Page]'
complete -c mongod -l syslog --description 'Sends all logging output to the host\\(aqs syslo… [See Man Page]'
complete -c mongod -l syslogFacility --description 'Default: user .'
complete -c mongod -l logpath --description 'Sends all diagnostic logging information to a l… [See Man Page]'
complete -c mongod -l logappend --description 'Appends new entries to the end of the log file … [See Man Page]'
complete -c mongod -l logRotate --description 'Default: rename . sp New in version 3. 0.'
complete -c mongod -l timeStampFormat --description 'Default: iso8601-local .'
complete -c mongod -l traceExceptions --description 'For internal diagnostic use only. UNINDENT NDENT 0. 0.'
complete -c mongod -l pidfilepath --description 'Specifies a file location to hold the process I… [See Man Page]'
complete -c mongod -l keyFile --description 'Specifies the path to a key file that stores th… [See Man Page]'
complete -c mongod -l setParameter --description 'Specifies one of the MongoDB parameters describ… [See Man Page]'
complete -c mongod -l httpinterface --description 'New in version 2. 6. sp Enables the HTTP interface.'
complete -c mongod -l nohttpinterface --description 'Deprecated since version 2.'
complete -c mongod -l nounixsocket --description 'Disables listening on the UNIX domain socket.'
complete -c mongod -l unixSocketPrefix --description 'Default: /tmp . sp The path for the UNIX socket.'
complete -c mongod -l fork --description 'Enables a daemon mode that runs the mongod proc… [See Man Page]'
complete -c mongod -l auth --description 'Enables authorization to control user\\(aqs acce… [See Man Page]'
complete -c mongod -l noauth --description 'Disables authentication.  Currently the default.'
complete -c mongod -l ipv6 --description 'Enables IPv6 support and allows the mongod to c… [See Man Page]'
complete -c mongod -l jsonp --description 'Permits JSONP access via an HTTP interface.'
complete -c mongod -l rest --description 'Enables the simple REST API.'
complete -c mongod -l slowms --description 'Default: 100 .'
complete -c mongod -l profile --description 'Default: 0 .'
complete -c mongod -l cpu --description 'Forces the mongod process to report the percent… [See Man Page]'
complete -c mongod -l sysinfo --description 'Returns diagnostic system information and then exits.'
complete -c mongod -l objcheck --description 'Forces the mongod to validate all requests from… [See Man Page]'
complete -c mongod -l noobjcheck --description 'New in version 2. 4.'
complete -c mongod -l noscripting --description 'Disables the scripting engine. UNINDENT NDENT 0. 0.'
complete -c mongod -l notablescan --description 'Forbids operations that require a table scan.'
complete -c mongod -l shutdown --description 'The \\%--shutdown option cleanly and safely term… [See Man Page]'
complete -c mongod -l dbpath --description 'Default: /data/db on Linux and OS X, datadb on Windows .'
complete -c mongod -l storageEngine --description 'Default: mmapv1 . sp New in version 3. 0. 0.'
complete -c mongod -l wiredTigerDirectoryForIndexes --description 'Type: boolean . sp Default: false . sp New in version 3. 0. 0.'
complete -c mongod -l wiredTigerCacheSizeGB --description 'Default: the maximum of half of physical RAM or 1 gigabyte .'
complete -c mongod -l wiredTigerCheckpointDelaySecs --description 'Default: 60 . sp New in version 3. 0. 0.'
complete -c mongod -l wiredTigerStatisticsLogDelaySecs --description 'Default: 0 . sp New in version 3. 0. 0.'
complete -c mongod -l wiredTigerJournalCompressor --description 'Default: snappy . sp New in version 3. 0. 0.'
complete -c mongod -l wiredTigerCollectionBlockCompressor --description 'Default: none . sp New in version 3. 0. 0.'
complete -c mongod -l wiredTigerIndexPrefixCompression --description 'Default: true . sp New in version 3. 0. 0.'
complete -c mongod -l directoryperdb --description 'Stores each database\\(aqs files in its own fold… [See Man Page]'
complete -c mongod -l noIndexBuildRetry --description 'Stops the mongod from rebuilding incomplete ind… [See Man Page]'
complete -c mongod -l noprealloc --description 'Deprecated since version 2. 6.'
complete -c mongod -l nssize --description 'Default: 16 .'
complete -c mongod -l quota --description 'Enables a maximum limit for the number data fil… [See Man Page]'
complete -c mongod -l quotaFiles --description 'Default: 8 .'
complete -c mongod -l smallfiles --description 'Sets MongoDB to use a smaller default file size.'
complete -c mongod -l syncdelay --description 'Default: 60 .'
complete -c mongod -l upgrade --description 'Upgrades the on-disk data format of the files s… [See Man Page]'
complete -c mongod -l repair --description 'Runs a repair routine on all databases.'
complete -c mongod -l repairpath --description 'Default: A _tmp directory within the path speci… [See Man Page]'
complete -c mongod -l journal --description 'Enables the durability journal to ensure data f… [See Man Page]'
complete -c mongod -l nojournal --description 'Disables the durability journaling.'
complete -c mongod -l journalOptions --description 'Provides functionality for testing.'
complete -c mongod -l journalCommitInterval --description 'Default: 100 or 30 .'
complete -c mongod -l replSet --description 'Configures replication.'
complete -c mongod -l oplogSize --description 'Specifies a maximum size in megabytes for the r… [See Man Page]'
complete -c mongod -l replIndexPrefetch --description 'Default: all . sp New in version 2. 2.   NDENT 7. 0 NDENT 3. 5.'
complete -c mongod -l master --description 'Configures the mongod to run as a replication master.'
complete -c mongod -l slave --description 'Configures the mongod to run as a replication slave.'
complete -c mongod -l source --description 'For use with the \\%--slave option, the --source… [See Man Page]'
complete -c mongod -l only --description 'For use with the \\%--slave option, the --only o… [See Man Page]'
complete -c mongod -l slavedelay --description 'For use with the \\%--slave option, the \\%--slav… [See Man Page]'
complete -c mongod -l autoresync --description 'For use with the \\%--slave option.'
complete -c mongod -l fastsync --description 'In the context of replica set replication, set … [See Man Page]'
complete -c mongod -l configsvr --description 'Declares that this mongod instance serves as th… [See Man Page]'
complete -c mongod -l shardsvr --description 'Configures this mongod instance as a shard in a… [See Man Page]'
complete -c mongod -l sslOnNormalPorts --description 'Deprecated since version 2. 6. sp Enables SSL for mongod.'
complete -c mongod -l sslMode --description 'New in version 2. 6.'
complete -c mongod -l sslPEMKeyFile --description 'New in version 2. 2. sp Specifies the .'
complete -c mongod -l sslPEMKeyPassword --description 'New in version 2. 2.'
complete -c mongod -l clusterAuthMode --description 'Default: keyFile . sp New in version 2. 6.'
complete -c mongod -l sslClusterFile --description 'New in version 2. 6. sp Specifies the .'
complete -c mongod -l sslClusterPassword --description 'New in version 2. 6.'
complete -c mongod -l sslCAFile --description 'New in version 2. 4. sp Specifies the .'
complete -c mongod -l sslCRLFile --description 'New in version 2. 4. sp Specifies the .'
complete -c mongod -l sslAllowInvalidCertificates --description 'New in version 2. 6.'
complete -c mongod -l sslAllowInvalidHostnames --description 'New in version 3. 0.'
complete -c mongod -l sslAllowConnectionsWithoutCertificates --description 'New in version 2. 4. sp Changed in version 3. 0.'
complete -c mongod -l sslFIPSMode --description 'New in version 2. 4.'
complete -c mongod -l auditDestination --description 'New in version 2. 6. sp Enables auditing.'
complete -c mongod -l auditFormat --description 'New in version 2. 6.'
complete -c mongod -l auditPath --description 'New in version 2. 6.'
complete -c mongod -l auditFilter --description 'New in version 2. 6.'
complete -c mongod -l snmp-subagent --description 'Runs SNMP as a subagent.'
complete -c mongod -l 'port.' --description 'disabled.'
complete -c mongod -l 'sslPEMKeyFile).' --description 'certificate-key file is encrypted.'
complete -c mongod -l 'auditFormat.' --description 'T} _ NOTE: Available only in %MongoDB Enterprise.'
complete -c mongod -l snmp-master --description 'Runs SNMP as a master.  For more information, see http://docs.'

