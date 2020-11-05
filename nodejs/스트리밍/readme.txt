첨부된 Git-bash 설치 파일 먼저 설치

vscode 작업영역에 live_clone 추가 후

Vscode 설정 탭에서
terminal.integrated.shell.windows
검색 후 setting.json 에 아래 코드로 대체, 전체 복붙하시면 됩니다.


 {
    "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe",
    "explorer.confirmDelete": false,
    "terminal.integrated.shellArgs.linux": [
        "bash"
    ],
    "terminal.integrated.automationShell.windows": "",
    "cmake.configureOnOpen": true
}


Git bash 터미널 새로 생성 후
라이브러리 설치 명령어
npm i peerjs -g

npm i uuid 
npm i socket.io
npm i ejs
npm i express
npm i http

1번 bash 터미널
node server.js

2번 bash 터미널
peerjs --port 3001

