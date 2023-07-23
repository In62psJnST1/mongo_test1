


关闭大页内存；
关闭防火墙；

---以后用mongod进行安装
useradd mongod    
echo 111111 | passwd  --stdin  mongod 


准备的包
yum -y install net-snmp





mkdir -p /mongodb_data/data/db/
mkdir -p /mongodb_data/logs/
mkdir -p /mongodb_data/etc/


vi mongod 用户的 .bash_profile， 如下

export MONGODB_HOME=/opt/mongodb-linux-x86_64-rhel70-4.4.10/
export PATH=${MONGODB_HOME}/bin:$PATH


tar zxvf /software/mongodb-linux-x86_64-rhel70-4.4.10.tgz  -C /opt/
chown -R mongod:mongod /opt/mongodb-linux-x86_64-rhel70-4.4.10/
chown -R mongod:mongod /mongodb_data/

-----------------------------------
cd /mongodb_data/etc ,
编辑文件   mongodb.conf ，如下
dbpath=/mongodb_data/data/db   #数据存放路径
logpath=/mongodb_data/logs/the.log   #日志路径
logappend=false 				#日志追加（为false则覆盖）
journal=true 				#启用日志文件，默认启用；对数据安全，有较好的保证
#nojournal=true	             #关闭日志文件，默认启用
directoryperdb=true        # 每个库的数据，一个文件夹
quiet=false 				#可以过滤掉一些无用的日志信息，调试时设置为false
port=27017 				#端口号 默认为27017
bind_ip=0.0.0.0
fork=true		#是否在后台运行


-----------------------------------
cd /mongodb_data/etc ,
编辑文件   mongodb.conf ，如下
systemLog:
  destination: file
  path: /mongodb_data/logs/the.log
  logAppend: false
storage:
  journal:
     enabled: true
  dbPath: /mongodb_data/data/
  directoryPerDB: true
processManagement:
  fork: true
net:
  bindIp: 0.0.0.0
  port: 27017
   

启动 ， 发现 在  27017 监听
mongod -f /mongodb_data/etc/mongodb.conf

关闭
/opt/mongodb/mongodb-linux-x86_64-3.6.16/bin/mongod -f /mongodb_data/etc/mongodb.conf   --shutdown


客户端进入 
mongo 192.168.79.224:27017



导数据
/opt/mongodb/mongodb-linux-x86_64-3.6.16/bin/mongoimport -d test -c students students.dat 











