use mi_rancho;


CREATE OR REPLACE VIEW v_full_info AS
SELECT 
    adm_personas.id as adm_p_id,
    adm_personas.tipo_persona,
    adm_personas.curp,
    adm_personas.rfc,
    CONCAT_WS(' ',
            nombre,
            apellido_paterno,
            apellido_materno) AS fullName,
    adm_personas.direccion,
    adm_personas.estado_id,
    adm_personas.municipio_id,
    adm_personas.localidad_id,
    adm_personas.activo as adm_p_activo,
    adm_personas.usuario_creacion_id as adm_p_usuario_creacion_id,
    adm_personas.fecha_creacion as adm_p_fecha_creacion,
    adm_personas.usuario_modificacion_id as adm_p_usuario_modificacion_id,
    adm_personas.fecha_modificacion as adm_p_fecha_modificacion,
    adm_personas.propietario_id as adm_p_propietario_id,
    adm_usuarios.id as adm_u_id,
    adm_usuarios.username,
    adm_usuarios.password,
    adm_usuarios.session_id,
    adm_usuarios.correo_electronico,
    adm_usuarios.usuario_creacion_id as adm_u_usuario_creacion_id,
    adm_usuarios.fecha_creacion as adm_u_fecha_creacion,
    adm_usuarios.usuario_modificacion_id as adm_u_usuario_modificacion_id,
    adm_usuarios.fecha_modificacion as adm_u_fecha_modificacion,
    adm_usuarios.activo as adm_u_activo,
    adm_usuarios.propietario_id as adm_u_propietario_id,
    adm_roles_usuario.id as adm_ru_id,
    adm_roles_usuario.usuario_id as adm_ru_usuario_id,
    adm_roles_usuario.rol as adm_ru_rol,
    adm_roles_usuario.usuario_creacion_id as adm_ru_usuario_creacion,
    adm_roles_usuario.fecha_creacion as adm_ru_fecha_creacion,
    adm_roles_usuario.usuario_modificacion_id as adm_ru_usuario_modificacion_id,
    adm_roles_usuario.fecha_modificacion as adm_ru_fecha_modificacion,
    adm_roles_usuario.activo as adm_ru_activo,
    adm_roles.rol as adm_r_rol,
    adm_roles.descripcion as adm_r_descripcion,
    adm_roles.activo as adm_r_activo
FROM
    adm_personas
        INNER JOIN
    adm_usuario_persona ON adm_personas.id = adm_usuario_persona.persona_id
        INNER JOIN
    adm_usuarios ON adm_usuario_persona.usuario_id = adm_usuarios.id
        INNER JOIN
    adm_roles_usuario ON adm_roles_usuario.usuario_id = adm_usuarios.id
        INNER JOIN
    adm_roles ON adm_roles_usuario.rol = adm_roles.rol;
    
CREATE OR REPLACE VIEW nameAndRol AS
select fullName, adm_r_rol as rol from v_full_info;