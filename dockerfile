FROM iamdevopstrainer/tomcat:base
COPY target/artifact11-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh", "run"]
