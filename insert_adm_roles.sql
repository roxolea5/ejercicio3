use mi_rancho;

INSERT INTO `adm_roles` (`rol`,`descripcion`,`activo`) VALUES ("r_admin","Administrador de BD",1),("r_user","Usuario Regular",1),("r_public","Usuario lectura publica",1);

select * from adm_roles;