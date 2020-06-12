
DROP DATABASE IF EXISTS mi_rancho;

CREATE DATABASE `mi_rancho` /*!40100 COLLATE 'utf8_spanish_ci' */;


CREATE TABLE IF NOT EXISTS `mi_rancho`.`cat_paises` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID numerico del pais',
  `nombre` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'Nombre del pais',
  `abreviatura` VARCHAR(5) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'Abreviatura',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Catalogo de Paises';

CREATE TABLE IF NOT EXISTS `mi_rancho`.`cat_estados` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID numerico del Estado',
  `desc_estado` VARCHAR(250) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'Descripcion del Estado',
  `pais_id` INT(11) NULL DEFAULT NULL COMMENT 'Pais.id',
  PRIMARY KEY (`id`),
  INDEX `FK_pais` (`pais_id` ASC),
  CONSTRAINT `FK_pais`
    FOREIGN KEY (`pais_id`)
    REFERENCES `mi_rancho`.`cat_paises` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Catalogo de Estados';

CREATE TABLE IF NOT EXISTS `mi_rancho`.`cat_municipios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID nummerico del Municipio',
  `desc_municipio` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'Descripcion del Municipio',
  `estado_id` INT(11) NULL DEFAULT NULL COMMENT 'ID numerico del Estado',
  PRIMARY KEY (`id`),
  INDEX `idx_1` (`estado_id` ASC),
  CONSTRAINT `fk_cat_municipios_cat_estados`
    FOREIGN KEY (`estado_id`)
    REFERENCES `mi_rancho`.`cat_estados` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Catalogo de Municipios';

CREATE TABLE IF NOT EXISTS `mi_rancho`.`cat_localidades` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID nummerico de la localidad',
  `desc_localidad` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'Descripcion del Municipio',
  `estado_id` INT(11) NULL DEFAULT NULL COMMENT 'ID numerico del Estado',
  `municipio_id` INT(11) NULL DEFAULT NULL COMMENT 'ID numerico del municipio',
  PRIMARY KEY (`id`),
  INDEX `fk_cat_loc_cat_estados` (`estado_id` ASC),
  INDEX `FK_cat_localidades_cat_municipios` (`municipio_id` ASC),
  INDEX `idx_desc_localidad` (`desc_localidad` ASC),
  CONSTRAINT `FK_cat_localidades_cat_municipios`
    FOREIGN KEY (`municipio_id`)
    REFERENCES `mi_rancho`.`cat_municipios` (`id`),
  CONSTRAINT `fk_cat_loc_cat_estados`
    FOREIGN KEY (`estado_id`)
    REFERENCES `mi_rancho`.`cat_estados` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Catalogo de Localidades';

-- ############################################################

CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_propietarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NULL,
  `activo` TINYINT(4) NULL DEFAULT NULL,
  `identificador` VARCHAR(250) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'esta tabla contiene los clientes del programa. Esta tabla se llena manualmente';


CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_usuarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id autonumerico',
  `username` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL COMMENT 'nombre del usuario unico',
  `password` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL COMMENT 'Contraseña',
  `session_id` VARCHAR(70) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `correo_electronico` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `usuario_creacion_id` INT(11) NULL DEFAULT NULL COMMENT 'Referencia a usuario.id',
  `fecha_creacion` TIMESTAMP NULL DEFAULT NULL COMMENT 'new Date().toISOString();',
  `usuario_modificacion_id` INT(11) NULL DEFAULT NULL COMMENT 'Referencia a usuario.id',
  `fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `activo` TINYINT(4) NULL DEFAULT NULL COMMENT '1 activo, 0 inactivo',
  `propietario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uk_email` (`correo_electronico` ASC)  ,
  UNIQUE INDEX `uk_usuario` (`username` ASC)  ,
  INDEX `fk_adm_usuarios_cat_propietarios1_idx` (`propietario_id` ASC)  ,
  CONSTRAINT `fk_adm_usuarios_cat_propietarios1`
    FOREIGN KEY (`propietario_id`)
    REFERENCES `mi_rancho`.`adm_propietarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_roles` (
  `rol` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'El rol del usuario',
  `descripcion` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL COMMENT 'La descripcion del rol',
  `activo` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Catalogo de roles';


CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_roles_usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Id autonumerico',
  `usuario_id` INT(11) NOT NULL COMMENT 'Referencia a usuario.id',
  `rol` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `usuario_creacion_id` INT(11) NULL DEFAULT NULL COMMENT 'Referencia a usuarios.id',
  `fecha_creacion` TIMESTAMP NULL DEFAULT NULL,
  `usuario_modificacion_id` INT(11) NULL DEFAULT NULL COMMENT 'Referencia a usuarios.id',
  `fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `activo` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `IXFK_roles_usuario_usuarios` (`usuario_id` ASC)  ,
  INDEX `fk_roles_usuario_roles1_idx` (`rol` ASC)  ,
  CONSTRAINT `FK_roles_usuario_usuarios`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mi_rancho`.`adm_usuarios` (`id`),
  CONSTRAINT `fk_roles_usuario_roles1`
    FOREIGN KEY (`rol`)
    REFERENCES `mi_rancho`.`adm_roles` (`rol`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Asociacion entre roles y usuarios';
-- #########################################################


CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_personas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo_persona` TINYINT(1) NULL DEFAULT NULL COMMENT '1-fisica, 2-moral',
  `curp` VARCHAR(18) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `rfc` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `nombre` VARCHAR(75) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `apellido_paterno` VARCHAR(150) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `apellido_materno` VARCHAR(150) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `direccion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `estado_id` INT(11) NULL DEFAULT NULL,
  `municipio_id` INT(11) NULL DEFAULT NULL,
  `localidad_id` INT(11) NULL DEFAULT NULL,
  `activo` TINYINT(4) NULL DEFAULT b'1',
  `usuario_creacion_id` INT(11) UNSIGNED NOT NULL DEFAULT '1',
  `fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_modificacion_id` INT(11) NOT NULL DEFAULT '1',
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `propietario_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_curp` (`curp` ASC) ,
  INDEX `idx_rfc` (`rfc` ASC)  ,
  INDEX `idx_nombre_persona` (`nombre` ASC)  ,
  INDEX `fk_persona_estado` (`estado_id` ASC)  ,
  CONSTRAINT `fk_persona_estado`
    FOREIGN KEY (`estado_id`)
    REFERENCES `mi_rancho`.`cat_estados` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci
COMMENT = 'Cualquier actor es una persona';

CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_usuario_persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `persona_id` INT(11) NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_adm_usuario_persona_personas1_idx` (`persona_id` ASC) ,
  INDEX `fk_adm_usuario_persona_adm_usuarios1_idx` (`usuario_id` ASC) ,
  CONSTRAINT `fk_adm_usuario_persona_personas1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `mi_rancho`.`adm_personas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adm_usuario_persona_adm_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mi_rancho`.`adm_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mi_rancho`.`adm_usuario_persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `persona_id` INT(11) NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_adm_usuario_persona_personas1_idx` (`persona_id` ASC)  ,
  INDEX `fk_adm_usuario_persona_adm_usuarios1_idx` (`usuario_id` ASC)  ,
  CONSTRAINT `fk_adm_usuario_persona_personas1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `mi_rancho`.`adm_personas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adm_usuario_persona_adm_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mi_rancho`.`adm_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;