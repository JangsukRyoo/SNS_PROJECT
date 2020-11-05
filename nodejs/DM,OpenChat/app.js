const express = require("express");
const app = express();
const http = require("http");
const server = http.Server(app);
const io = require("socket.io").listen(server);
const mariadb = require("mariadb/callback");


const port = process.env.PORT || 3000;
const conn = mariadb.createConnection({
    host: "localhost",
    port: 3306,
    user: "tt",
    password: "1234",
    database: "mysql"
});

server.listen(port, () => {
    console.log("서버 연결 완료, 포트 : " + port);
});

// 네임스페이스 설정
/*
    1. openChat : 오픈채팅 네임스페이스
*/
const openChat = io.of("/open");
const dmChat = io.of("/dm");

openChat.use((socket, next) => {
    // 사용자에게 충분한 권한이 있는지 확인
    next();
});
dmChat.use((socket, next) => {
    next();
})

const loginIds1 = new Array();
const loginIds2 = new Array();

openChat.on("connection", socket => {

    console.log("오픈채팅 사용자 [" + socket.id + "] 연결 완료");

    socket.on("joinRoom", (data) => {
        socket.join(data.room);

        loginIds1.push({
            socket: socket.id,
            room: data.room,
            user: data.name
        });

        for (var num in loginIds1) {
            if (loginIds1[num]["user"] == data.name && loginIds1[num]["socket"] != socket.id) {
                loginIds1.splice(num, 1);
            }
        }

        openChat.to(data.room).emit("welcome", {
            name: data.name,
            msg: "님이 참여하였습니다.",
        });
        console.log("[" + data.name + "]님이 [" + data.room + "]채팅방에 참여하였습니다.");
        conn.query("insert into CHAT_INFO values (?, ?, ?, ?, 'N', sysdate())", [data.room, ".", data.name + "님이 참여하였습니다.", data.people], (err, res) => {
            if (err) {
                console.log(err);
                conn.rollback();
            }
            else {
                console.log(res);
                conn.commit();
            }
        });
    });

    socket.on("chat", (data) => {
        openChat.to(data.room).emit("broadcast", {name: data.name, msg: data.msg});
        conn.query("insert into CHAT_INFO values"
        + "(?, ?, ?, ?, 'N', sysdate())", [data.room, data.name, data.msg, data.people], (err, res) => {
            if (err) {
                console.log(err);
                conn.rollback();
            }
            else {
                console.log(res);
                conn.commit();
            }
        });
    });

    socket.on("leaveRoom", (data) => {
        // var room = "";
        // var name = "";

        // // 모두 퇴장시 에러 발생후 node가 종료되는 이슈 해결코드
        // try {
        //     // 생성된 방의 수만큼 반복문 실행
        //     for (var key in openChat.sockets.adapter.rooms) {
        //         // loginIds 배열의 값만큼 반복문 실행
        //         var members = loginIds1.filter(chat => {
        //             return chat.room === key;
        //         });
        //         // 현재 소켓 방의 length와 members 배열의 갯수가 일치하지 않는 경우
        //         if (openChat.sockets.adapter.rooms[key].length != members.length) {
        //             // 반복문으로 loginIds에 해당 소켓아이디의 존재여부를 확인한다.
        //             for (var num in loginIds1) {
        //                 // 일치하는 아이디정보가 없을경우 사용자가 방에서 퇴장한것을 확인할 수 있다.
        //                 if (openChat.sockets.adapter.rooms[key].sockets.hasOwnProperty(loginIds1[num]["socket"] == false)) {
        //                     // 퇴장한 사용자의 정보를 변수에 담는다
        //                     room = key;
        //                     name = loginIds1[num]["users"];
        //                     // 퇴장한 사용자의 정보를 loginIds배열에서 삭제한다.
        //                     loginIds1.splice(num, 1);
        //                 }
        //             }
        //             // 해당 방의 인원수를 다시 구한다.
        //         }
        //     }
        // }
        // catch(exception) {
        //     console.log(exception);
        // }
        // finally {
            openChat.to(data.room).emit("bye", {
                name: data.name, 
                msg: "님이 퇴장하였습니다."
            });
            console.log("[" + data.name + "]님이 [" + data.room + "]채팅방에서 퇴장하였습니다.");
            conn.query("insert into CHAT_INFO values (?, ?, ?, ?, 'N', sysdate())", 
            [data.room, ".", data.name + "님이 퇴장하였습니다.", data.people], (err, res) => {
                if (err) {
                    console.log(err);
                    conn.rollback();
                }
                else {
                    console.log(res);
                    conn.commit();
                }
            });
        // }
    });
});

dmChat.on("connection", socket => {

    console.log("DM채팅 사용자 [" + socket.id + "] 연결 완료");

    socket.on("joinRoom", (data) => {
        socket.join(data.room);

        loginIds2.push({
            socket: socket.id,
            room: data.room,
            user: data.name
        });

        for (var num in loginIds2) {
            if (loginIds2[num]["user"] == data.name && loginIds2[num]["socket"] != socket.id) {
                loginIds2.splice(num, 1);
            }
        }

        dmChat.to(data.room).emit("welcome", {
            name: data.name,
            msg: "님이 참여하였습니다.",
        });
        console.log("[" + data.name + "]님이 [" + data.room + "]채팅방에 참여하였습니다.");
    });

    socket.on("chat", (data) => {
        dmChat.to(data.room).emit("broadcast", {name: data.name, msg: data.msg});
        conn.query("insert into DM values"
        + "(?, ?, ?, ?, 'N', sysdate())", [data.room, data.name,data.people,data.msg], (err, res) => {
            if (err) {
                console.log(err);
                conn.rollback();
            }
            else {
                console.log(res);
                conn.commit();
            }
        });
    });

    socket.on("leaveRoom", (data) => {
        var room = "";
        var name = "";

        // 모두 퇴장시 에러 발생후 node가 종료되는 이슈 해결코드
        try {
            // 생성된 방의 수만큼 반복문 실행
            for (var key in dmChat.sockets.adapter.rooms) {
                // loginIds 배열의 값만큼 반복문 실행
                var members = loginIds2.filter(chat => {
                    return chat.room === key;
                });
                // 현재 소켓 방의 length와 members 배열의 갯수가 일치하지 않는 경우
                if (dmChat.sockets.adapter.rooms[key].length != members.length) {
                    // 반복문으로 loginIds에 해당 소켓아이디의 존재여부를 확인한다.
                    for (var num in loginIds2) {
                        // 일치하는 아이디정보가 없을경우 사용자가 방에서 퇴장한것을 확인할 수 있다.
                        if (dmChat.sockets.adapter.rooms[key].sockets.hasOwnProperty(loginIds2[num]["socket"] == false)) {
                            // 퇴장한 사용자의 정보를 변수에 담는다
                            room = key;
                            name = loginIds2[num]["users"];
                            // 퇴장한 사용자의 정보를 loginIds배열에서 삭제한다.
                            loginIds2.splice(num, 1);
                        }
                    }
                    // 해당 방의 인원수를 다시 구한다.
                }
            }
        }
        catch(exception) {
            console.log(exception);
        }
        finally {
            console.log("[" + data.name + "]님이 [" + data.room + "]채팅방에서 퇴장하였습니다.");
        }
    });
});