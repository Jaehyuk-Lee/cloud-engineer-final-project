FROM tomcat:9.0.87-jdk11-corretto

# docker/WAS 디렉토리 안에 있는 소스코드를 Tomcat ROOT 디렉토리로 복사
ADD ./webapp /usr/local/tomcat/webapps/ROOT

CMD ["catalina.sh", "run"]
