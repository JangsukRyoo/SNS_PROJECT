drop sequence seq;
DROP TABLE USERS;
drop table CHAT_INFO;
drop table DM;


create sequence seq;
create table USERS
(
   USERS_NO   int primary key,
   USERS_ID   varchar(1000)      unique not null,
   USERS_NICKNAME varchar(1000)    unique NOT NULL,
   USERS_PW   varchar(1000)         not null,
   USERS_NAME   varchar(1000)      not   null,
   USERS_PHONE   varchar(1000)      unique not null,
   USERS_PROFILE   varchar(1000)      not   null,
   USER_INFO   varchar(1000)    not null
)charset = utf8;



create table CHAT_INFO (
   CHAT_ROOM varchar(100) not null,
   CHAT_WRITER varchar(100) not null,
   CHAT_SUBSTANCE varchar(2000) not null,
   CHAT_PEOPLE varchar(1000),
   CHAT_STATUS varchar(5) not null default 'N',
   CHAT_TIME date not null
   
)charset = utf8;


create table DM(
   DM_ROOM varchar(100) not null,
   DM_WRITER varchar(100) not null,
   DM_RECEIVER varchar(100) not null,
   DM_SUBSTANCE varchar(2000) not null,
   DM_STATUS varchar(5) not null default 'N',
   DM_TIME date not null
)charset = utf8;

select * from CHAT_INFO;
select * from DM;

delete from DM;
