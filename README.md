# Web Application

This repository contains flask Web application code. We can deploy The entire stack - MySQL, Redis, and the backend application using docker swarm .
Once we execute this though docker stack deploy, it will create entire stack with four application replicas, Redis and MySQL database.
We can scale this web application by launching multiple backend application containers. 

### Architecture
![Architecture](https://github.com/navojha/dockerswarm-docker-compose-flask-mysql-redis/blob/main/Screenshots/Architecture_docker_Swarm.png?raw=true)


    Backend application
        Model the following in the primary database
        i. Identifier
        ii. Name
        iii. Amount of gold 
    Application Endpoints
        a. Create player
            i. Store Identifier and Name in MySQL
            ii. Store Identifier and Gold in Redis
        b. Get player
            i. Retrieve Identifier and Name from the MySQL
            ii. Retrieve Gold from Redis 


## Table of Contents
    1. Getting started
    2. Local deployment
    3. Testing
    4. Logs
### Getting started
#### Requirements
    Docker latest version should be installed on local machine.
#### Clone the repository 
    git clone https://github.com/navojha/dockerswarm-docker-compose-flask-mysql-redis.git
    cd dockerswarm-docker-compose-flask-mysql-redis

    $tree
     .   
    ├──Dockerfile
    ├──README.md
    ├──app.py
    ├──docker-compose.yml
    ├──requirements.txt
    └──templates
### Local deployment
     The entire stack - MySQL, Redis, and the backend application - will be deployable using docker swarn

    docker-compose build

    docker stack deploy -c docker-compose.yml mydeployment

    Creating network mydeployment_default
    Creating service mydeployment_app
    Creating service mydeployment_redis
    Creating service mydeployment_mysql


    docker service ls

    ID             NAME                 MODE         REPLICAS   IMAGE                PORTS
    o9ws1rojddga   mydeployment_app     replicated   4/4        flask-redis:1.0      *:8083->8083/tcp
    t2ba9tbdqzcs   mydeployment_mysql   replicated   1/1        mysql:8.0            
    8if9cwkp02z8   mydeployment_redis   replicated   1/1        redis:6.2.7-alpine   

    docker stack ps mydeployment

    ID             NAME                   IMAGE                NODE             DESIRED STATE   CURRENT STATE                ERROR     PORTS
    i1lqikc29tya   mydeployment_app.1     flask-redis:1.0      docker-desktop   Running         Running about a minute ago             
    o8crjgzsoqqo   mydeployment_app.2     flask-redis:1.0      docker-desktop   Running         Running about a minute ago             
    o2vpwhaninnf   mydeployment_app.3     flask-redis:1.0      docker-desktop   Running         Running about a minute ago             
    vad0irgl6weh   mydeployment_app.4     flask-redis:1.0      docker-desktop   Running         Running about a minute ago             
    wo8vyr5n7w3i   mydeployment_mysql.1   mysql:8.0            docker-desktop   Running         Running 44 seconds ago                 
    jl75g73wsi39   mydeployment_redis.1   redis:6.2.7-alpine   docker-desktop   Running         Running about a minute ago             

##### Scaleing the web application


    docker service scale mydeployment_app=20

    mydeployment_app scaled to 20
    overall progress: 20 out of 20 tasks 
    1/20: running   [==================================================>] 
    2/20: running   [==================================================>] 
    3/20: running   [==================================================>] 
    4/20: running   [==================================================>] 
    5/20: running   [==================================================>] 
    6/20: running   [==================================================>] 
    7/20: running   [==================================================>] 
    8/20: running   [==================================================>] 
    9/20: running   [==================================================>] 
    10/20: running   [==================================================>] 
    11/20: running   [==================================================>] 
    12/20: running   [==================================================>] 
    13/20: running   [==================================================>] 
    14/20: running   [==================================================>] 
    15/20: running   [==================================================>] 
    16/20: running   [==================================================>] 
    17/20: running   [==================================================>] 
    18/20: running   [==================================================>] 
    19/20: running   [==================================================>] 
    20/20: running   [==================================================>] 
    verify: Service converged 

    docker service ls   

    ID             NAME                 MODE         REPLICAS   IMAGE                PORTS
    o9ws1rojddga   mydeployment_app     replicated   20/20      flask-redis:1.0      *:8083->8083/tcp
    t2ba9tbdqzcs   mydeployment_mysql   replicated   1/1        mysql:8.0            
    8if9cwkp02z8   mydeployment_redis   replicated   1/1        redis:6.2.7-alpine 

### Testing
##### Create Player Table
localhost:8083
This will create the player table.
![reate Player Table](https://github.com/navojha/docker-compose-flask-mysql-redis/blob/main/Screenshots/Table_Created.png?raw=true)

##### Insert records in Player
    localhost:8083/Createplayer
    This End Point will use to enter the Player data.
![Insert records in Player](https://github.com/navojha/docker-compose-flask-mysql-redis/blob/main/Screenshots/Create_player.png?raw=true)

#### Player Created
![Player Created](https://github.com/navojha/docker-compose-flask-mysql-redis/blob/main/Screenshots/Player_created.png?raw=true)

#### Get Player Detail
    http://localhost:8083/Getplayer
    This endpoint will Retrieve Identifier and Name from the MySQL and Retrieve Gold from Redis. 
![Get Player Detail](https://github.com/navojha/docker-compose-flask-mysql-redis/blob/main/Screenshots/Get_Player.png?raw=true)

#### Logs

    docker service logs -f mydeployment_app

    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Serving Flask app 'app.py' (lazy loading)
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Environment: development
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Debug mode: on
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Running on all addresses (0.0.0.0)
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |    WARNING: This is a development server. Do not use it in a production deployment.
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Running on http://127.0.0.1:8083
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Running on http://192.168.112.6:8083 (Press CTRL+C to quit)
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Restarting with stat
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Debugger is active!
    mydeployment_app.3.o2vpwhaninnf@docker-desktop    |  * Debugger PIN: 434-925-921
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Serving Flask app 'app.py' (lazy loading)
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Environment: development
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Debug mode: on
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Running on all addresses (0.0.0.0)
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |    WARNING: This is a development server. Do not use it in a production deployment.
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Running on http://127.0.0.1:8083
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Running on http://192.168.112.5:8083 (Press CTRL+C to quit)
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Restarting with stat
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Debugger is active!
    mydeployment_app.2.o8crjgzsoqqo@docker-desktop    |  * Debugger PIN: 116-846-116
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Serving Flask app 'app.py' (lazy loading)
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Environment: development
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Debug mode: on
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Running on all addresses (0.0.0.0)
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |    WARNING: This is a development server. Do not use it in a production deployment.
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Running on http://127.0.0.1:8083
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Running on http://192.168.112.3:8083 (Press CTRL+C to quit)
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Restarting with stat
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Debugger is active!
    mydeployment_app.1.i1lqikc29tya@docker-desktop    |  * Debugger PIN: 975-106-412
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Serving Flask app 'app.py' (lazy loading)
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Environment: development
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Debug mode: on
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Running on all addresses (0.0.0.0)
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |    WARNING: This is a development server. Do not use it in a production deployment.
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Running on http://127.0.0.1:8083
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Running on http://192.168.112.4:8083 (Press CTRL+C to quit)
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Restarting with stat
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Debugger is active!
    mydeployment_app.4.vad0irgl6weh@docker-desktop    |  * Debugger PIN: 478-915-004

    docker service logs -f mydeployment_mysql

    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:49+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.29-1debian10 started.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:49+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:49+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.29-1debian10 started.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:49+00:00 [Note] [Entrypoint]: Initializing database files
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:49.624085Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.29) initializing of server in progress as process 43
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:49.631823Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:50.105464Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:51.203500Z 6 [Warning] [MY-010453] [Server] root@localhost is created with an empty password ! Please consider switching off the --initialize-insecure option.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:54+00:00 [Note] [Entrypoint]: Database files initialized
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:54+00:00 [Note] [Entrypoint]: Starting temporary server
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:54.604908Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.29) starting as process 90
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:54.619292Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:54.813971Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:55.070398Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:55.070498Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:55.076365Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:55.098422Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: /var/run/mysqld/mysqlx.sock
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:55.098621Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.29'  socket: '/var/run/mysqld/mysqld.sock'  port: 0  MySQL Community Server - GPL.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:55+00:00 [Note] [Entrypoint]: Temporary server started.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | Warning: Unable to load '/usr/share/zoneinfo/iso3166.tab' as time zone. Skipping it.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | Warning: Unable to load '/usr/share/zoneinfo/leap-seconds.list' as time zone. Skipping it.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | Warning: Unable to load '/usr/share/zoneinfo/zone.tab' as time zone. Skipping it.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | Warning: Unable to load '/usr/share/zoneinfo/zone1970.tab' as time zone. Skipping it.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:57+00:00 [Note] [Entrypoint]: Creating database mydb
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:57+00:00 [Note] [Entrypoint]: Creating user myuser
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:57+00:00 [Note] [Entrypoint]: Giving user myuser access to schema mydb
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:57+00:00 [Note] [Entrypoint]: Stopping temporary server
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:57.789506Z 13 [System] [MY-013172] [Server] Received SHUTDOWN from user root. Shutting down mysqld (Version: 8.0.29).
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:58.668107Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.29)  MySQL Community Server - GPL.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:58+00:00 [Note] [Entrypoint]: Temporary server stopped
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25 12:50:58+00:00 [Note] [Entrypoint]: MySQL init process done. Ready for start up.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.055287Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.29) starting as process 1
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.062393Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.236952Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.440523Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.440604Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.447167Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.475519Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.29'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
    mydeployment_mysql.1.wo8vyr5n7w3i@docker-desktop    | 2022-05-25T12:50:59.475520Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock

    docker service logs -f mydeployment_redis

    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:C 25 May 2022 12:50:32.802 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:C 25 May 2022 12:50:32.802 # Redis version=6.2.7, bits=64, commit=00000000, modified=0, pid=1, just started
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:C 25 May 2022 12:50:32.802 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:M 25 May 2022 12:50:32.802 * monotonic clock: POSIX clock_gettime
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:M 25 May 2022 12:50:32.803 # A key '__redis__compare_helper' was added to Lua globals which is not on the globals allow list nor listed on the deny list.
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:M 25 May 2022 12:50:32.803 * Running mode=standalone, port=6379.
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:M 25 May 2022 12:50:32.803 # Server initialized
    mydeployment_redis.1.jl75g73wsi39@docker-desktop    | 1:M 25 May 2022 12:50:32.803 * Ready to accept connections
    cc
