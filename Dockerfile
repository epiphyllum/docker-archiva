FROM hary/ubuntu
MAINTAINER hary <94093146@qq.com>

# 添加archiva用户
RUN useradd -m -s /bin/bash archiva

#
# 安装jdk, archiva到应用用户
# 安装mysql 驱动
#
ADD [ "assets/packages/jdk1.7.0_67.tar.gz", "/home/archiva/opt/" ]
ADD [ "assets/packages/apache-archiva-2.2.0-bin.tar.gz", "/home/archiva/opt/" ]

#
RUN mv /home/archiva/opt/apache-archiva-2.2.0 /home/archiva/opt/archiva \
 && mv /home/archiva/opt/jdk1.7.0_67 /home/archiva/opt/jdk

ADD [ "assets/packages/mysql-connector-java-5.1.6-bin.jar", "/home/archiva/opt/archiva/lib/" ]
ADD [ "assets/config/jetty.xml", "/home/archiva/opt/archiva/conf/jetty.xml" ]
ADD [ "assets/start", "/start" ]
ADD [ "assets/run", "/home/archiva/"]

# 配置用户的环境变量, 修改conf/wrapper.conf, 添加驱动
RUN chown -R archiva:archiva /home/archiva \
 && echo 'export JAVA_HOME=/home/archiva/opt/jdk' >> /home/archiva/.bashrc \
 && echo 'export ARCHIVA_HOME=/home/archiva/opt/archiva' >> /home/archiva/.bashrc \
 && echo 'export PATH=$JAVA_HOME/bin:$ARCHIVA_HOME/bin:$PATH' >> /home/archiva/.bashrc  \
 && echo 'wrapper.java.classpath.27=%REPO_DIR%/mysql-connector-java-5.1.6-bin.jar' >> /home/archiva/opt/archiva/conf/wrapper.conf

# 80端口服务
EXPOSE 8080

# 挂数据目录
VOLUME ["/home/archiva/opt/archiva/logs"]
VOLUME ["/home/archiva/opt/archiva/data"]
VOLUME ["/home/archiva/opt/archiva/temp"]
VOLUME ["/home/archiva/opt/archiva/repositories"]

# 启动
CMD [ "/start" ]


#############################################################################
#  start中调用run

