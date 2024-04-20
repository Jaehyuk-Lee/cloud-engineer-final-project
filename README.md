## 프로젝트에 웹 소스 적용하는 법

### Nginx에 웹 소스 코드 넣는 법

- 컨테이너 레파지토리: https://github.com/Jaehyuk-Lee/nginx-container-registry

[`html/`](https://github.com/Jaehyuk-Lee/nginx-container-registry/tree/main/html)에 넣으면 Nginx 웹서버 컨테이너의 루트 디렉토리(`/usr/share/nginx/html`)에 넣어진다.

### Node.js 서버 프로그램 추가하는 법

- 컨테이너 레파지토리: https://github.com/Jaehyuk-Lee/nodejs-container-registry

Node.js Docker container는 [`docker/WAS/app/`](docker/WAS/app/)에 `server.js`를 실행함.  
서버 프로그램을 추가하고 싶다면 [`Dockerfile`](docker/WAS/Dockerfile)을 수정해야 함.
