## 프로젝트에 웹 소스 적용하는 법

### Nginx에 웹 소스 코드 넣는 법
[`docker/web/html`](docker/web/html)에 넣으면 Nginx 웹서버 컨테이너의 루트 디렉토리(`/usr/share/nginx/html`)에 넣어진다.

### Tomcat에 JSP 소스코드 넣는 법

[`docker/WAS/webapp`](docker/WAS/webapp)에 넣으면 Tomcat 서버의 루트 디렉토리(`/usr/local/tomcat/webapps/ROOT`)에 넣어진다.
