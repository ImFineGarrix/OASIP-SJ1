use oasip;

delete from users;

insert into users values 
(1, "OASIP ADMIN", "$argon2id$v=19$m=15360,t=3,p=1$V+uFWsvD3Qc$ECVBTWeoFOA3kJ47v2BElIEmTHmTzioCQLNoRHznnDg", "oasip.admin@kmutt.ac.th", "admin", "2022-07-31 17:00:00", "2022-07-31 17:00:00");

insert into users values 
(2, "Somchai Jaidee", "$argon2id$v=19$m=15360,t=3,p=1$WLmNcKtIOMM$H1sAI127A525UMhg1tvdrr0LDMeML8dt5id2HPvS39Y", "somchai.jai@kmutt.ac.th", "lecturer", "2022-08-08 08:00:00", "2022-08-08 08:00:00");

insert into users values 
(3, "Komkrid Rakdee", "$argon2id$v=19$m=15360,t=3,p=1$VJtf2xUR45Q$6EaFVRe9j+p/chmfneBssUE02jhKblwf8f53JR5R7vI", "komkrid.rak@mail.kmutt.ac.th", "student", "2022-08-08 08:00:01", "2022-08-08 08:00:01");

insert into users values 
(4, "สมเกียรติ ขยันเรียน", "$argon2id$v=19$m=15360,t=3,p=1$oPTAOW891ts$av/Fx2DjcliN2qp8vcBFgJLmseh4yvS1LWo6Shne5/M", "somkiat.kay@kmutt.ac.th", "student", "2022-08-16 02:00:00", "2022-08-16 02:00:00");
