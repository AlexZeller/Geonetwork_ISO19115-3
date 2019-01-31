FROM tomcat:8.5-jre8

ENV DATA_DIR=$CATALINA_HOME/webapps/geonetwork/WEB-INF/data
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -server -Xms512m -Xmx2024m -XX:NewSize=512m -X$

WORKDIR $CATALINA_HOME/webapps

COPY geonetwork.war .

RUN mkdir -p geonetwork && \
     unzip -e geonetwork.war -d geonetwork && \
     rm geonetwork.war

#Set geonetwork data dir
COPY ./docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["catalina.sh", "run"]
