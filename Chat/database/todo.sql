--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

-- Started on 2016-08-26 18:22:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 195 (class 1255 OID 31101)
-- Name: agregar_contacto(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_contacto(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	CONTAR1 INTEGER;
BEGIN	
	CONTAR := COUNT(NOMBREUSUARIO) FROM USUARIO WHERE USUARIO.NOMBREUSUARIO = $1;

	IF CONTAR = 0 THEN
		CONTAR1 := COUNT(USUARIOCONTACTO) FROM CONTACTOS WHERE CONTACTOS.USUARIOCONTACTO = $1;
		IF CONTAR1 = 0 THEN
			INSERT INTO CONTACTOS(USUARIOCONTACTO,IDUSUARIOCONTACTO) VALUES ($1);
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.agregar_contacto(character varying) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 31102)
-- Name: agregar_contacto(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_contacto(character varying, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	CONTAR1 INTEGER;
BEGIN	
	CONTAR := COUNT(NOMBREUSUARIO) FROM USUARIO WHERE USUARIO.NOMBREUSUARIO = $1;

	IF CONTAR != 0 THEN
		CONTAR1 := COUNT(USUARIOCONTACTO) FROM CONTACTOS inner join usuario on contactos.idusuariocontacto = usuario.id where contactos.idusuariocontacto=$2;
		IF CONTAR1 = 0 THEN
			INSERT INTO CONTACTOS(USUARIOCONTACTO,IDUSUARIOCONTACTO) VALUES ($1,$2);
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.agregar_contacto(character varying, integer) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 31105)
-- Name: agregar_contacto(character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_contacto(character varying, integer, character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	CONTAR1 INTEGER;
BEGIN	
	CONTAR := COUNT(NOMBREUSUARIO) FROM USUARIO WHERE USUARIO.NOMBREUSUARIO = $1;

	IF CONTAR != 0 THEN
		CONTAR1 := COUNT(USUARIOCONTACTO) FROM CONTACTOS inner join usuario on contactos.idusuariocontacto = usuario.id where contactos.idusuariocontacto=$2 and contactos.usuariocontacto=$3;
		IF CONTAR1 = 0 THEN
			INSERT INTO CONTACTOS(USUARIOCONTACTO,IDUSUARIOCONTACTO) VALUES ($1,$2);
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.agregar_contacto(character varying, integer, character varying) OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 31154)
-- Name: agregar_participante(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_participante(integer, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	CONTAR1 INTEGER;
BEGIN	
	insert into participantes(idrom,participante) values($1,$2);
	RETURN TRUE;
END;
$_$;


ALTER FUNCTION public.agregar_participante(integer, integer) OWNER TO postgres;

--
-- TOC entry 209 (class 1255 OID 31150)
-- Name: buscar_chat_grupal(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_chat_grupal(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	IDR INTEGER;
BEGIN	
	IDR := (ID) FROM ROM WHERE ROM.DESCRIPCION = $1;
	IF IDR!=0 THEN
		RETURN IDR;
	ELSE
		IDR := 0;
		RETURN IDR;
	END IF;
END;
$_$;


ALTER FUNCTION public.buscar_chat_grupal(character varying) OWNER TO postgres;

--
-- TOC entry 223 (class 1255 OID 31182)
-- Name: buscar_rom(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_rom(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	IDR INTEGER;
BEGIN	
	IDR := (ID) FROM ROM WHERE ROM.DESCRIPCION = $1;
	IF IDR!=0 THEN
		RETURN IDR;
	ELSE
		IDR := 0;
		RETURN IDR;
	END IF;
END;
$_$;


ALTER FUNCTION public.buscar_rom(character varying) OWNER TO postgres;

--
-- TOC entry 208 (class 1255 OID 31103)
-- Name: buscar_usuario(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_usuario(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	IDR INTEGER;
BEGIN	
	IDR := (ID) FROM USUARIO WHERE USUARIO.NOMBREUSUARIO = $1;
	IF IDR!=0 THEN
		RETURN IDR;
	ELSE
		IDR := 0;
		RETURN IDR;
	END IF;
END;
$_$;


ALTER FUNCTION public.buscar_usuario(character varying) OWNER TO postgres;

--
-- TOC entry 220 (class 1255 OID 31155)
-- Name: buscar_usuario_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_usuario_id(integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE
	ID VARCHAR;
BEGIN	
	ID := (nombreusuario) FROM USUARIO WHERE USUARIO.ID = $1;
	RETURN ID;
END;
$_$;


ALTER FUNCTION public.buscar_usuario_id(integer) OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 31104)
-- Name: contactos_usuario(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION contactos_usuario(integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE
	MYCURS REFCURSOR;
BEGIN
	OPEN MYCURS FOR select * FROM CONTACTOS inner join usuario on contactos.idusuariocontacto = usuario.id where usuario.id= $1 order by usuario.nombreusuario;
	RETURN MYCURS;
END;
$_$;


ALTER FUNCTION public.contactos_usuario(integer) OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 31125)
-- Name: crear_rom(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crear_rom(character varying, integer, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	A INTEGER;
BEGIN	
	CONTAR := COUNT(descripcion) FROM rom WHERE rom.descripcion = $1;

	IF CONTAR = 0 THEN
		INSERT INTO rom(descripcion,tipo,idUsuario) VALUES ($1,$2,$3);
		A := ROM.ID FROM ROM WHERE ROM.DESCRIPCION = $1;
		INSERT INTO PARTICIPANTES(IDROM,PARTICIPANTE)VALUES(A,0);
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.crear_rom(character varying, integer, integer) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 31158)
-- Name: crear_rom_privado(character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crear_rom_privado(character varying, integer, integer, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	A INTEGER;
BEGIN	
	CONTAR := COUNT(descripcion) FROM rom WHERE rom.descripcion = $1;

	IF CONTAR = 0 THEN
		INSERT INTO rom(descripcion,tipo,idUsuario) VALUES ($1,$2,$3);
		A := ROM.ID FROM ROM WHERE ROM.DESCRIPCION = $1;
		INSERT INTO PARTICIPANTES(IDROM,PARTICIPANTE)VALUES(A,$4);
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.crear_rom_privado(character varying, integer, integer, integer) OWNER TO postgres;

--
-- TOC entry 191 (class 1255 OID 31082)
-- Name: crear_sala(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crear_sala(character varying, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
BEGIN	
	CONTAR := COUNT(NOMBRESALA) FROM SALA WHERE SALA.NOMBRESALA = $1;

	IF CONTAR = 0 THEN
		INSERT INTO SALA(NOMBRESALA,TIPO) VALUES ($1,$2);
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.crear_sala(character varying, integer) OWNER TO postgres;

--
-- TOC entry 192 (class 1255 OID 31083)
-- Name: crear_usuario(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crear_usuario(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
BEGIN	
	CONTAR := COUNT(NOMBREUSUARIO) FROM USUARIO WHERE USUARIO.NOMBREUSUARIO = $1;

	IF CONTAR = 0 THEN
		INSERT INTO USUARIO(NOMBREUSUARIO) VALUES ($1);
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.crear_usuario(character varying) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 31183)
-- Name: insertar_mensaje(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insertar_mensaje(character varying, character varying, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN		
	INSERT INTO msg(usuario,mensaje,romid) VALUES ($1,$2,$3);
	RETURN FALSE;
END;
$_$;


ALTER FUNCTION public.insertar_mensaje(character varying, character varying, integer) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 31184)
-- Name: mensajes_rom(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mensajes_rom(integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE
	MYCURS REFCURSOR;
BEGIN
	OPEN MYCURS FOR SELECT * from msg where msg.romid=$1;
	RETURN MYCURS;
END;
$_$;


ALTER FUNCTION public.mensajes_rom(integer) OWNER TO postgres;

--
-- TOC entry 194 (class 1255 OID 31085)
-- Name: salas_globales(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION salas_globales(integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE
	MYCURS REFCURSOR;
BEGIN
	OPEN MYCURS FOR SELECT * FROM SALA WHERE SALA.TIPO == $1 ORDER BY ID;
	RETURN MYCURS;
END;
$_$;


ALTER FUNCTION public.salas_globales(integer) OWNER TO postgres;

--
-- TOC entry 221 (class 1255 OID 31156)
-- Name: todas_participantes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION todas_participantes(integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE
	MYCURS REFCURSOR;
BEGIN
	OPEN MYCURS FOR SELECT * from participantes where participantes.IDROM=$1 ORDER BY participantes.PARTICIPANTE;
	RETURN MYCURS;
END;
$_$;


ALTER FUNCTION public.todas_participantes(integer) OWNER TO postgres;

--
-- TOC entry 193 (class 1255 OID 31084)
-- Name: todas_salas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION todas_salas() RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE
	MYCURS REFCURSOR;
BEGIN
	OPEN MYCURS FOR SELECT * FROM SALA ORDER BY ID;
	RETURN MYCURS;
END;
$$;


ALTER FUNCTION public.todas_salas() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 31126)
-- Name: todas_salas_grupales(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION todas_salas_grupales(integer, integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE
	MYCURS REFCURSOR;
BEGIN
	OPEN MYCURS FOR SELECT * from rom inner join participantes on rom.id = participantes.idrom where (rom.idusuario=$1 or participantes.participante=$1) and rom.tipo=$2 ORDER BY rom.ID;
	RETURN MYCURS;
END;
$_$;


ALTER FUNCTION public.todas_salas_grupales(integer, integer) OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 31157)
-- Name: verificar_existencia_rom(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verificar_existencia_rom(character varying, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
	A INTEGER;
BEGIN	
	CONTAR := COUNT(descripcion) FROM rom WHERE rom.descripcion = $1 and rom.tipo = $2;

	IF CONTAR = 0 THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$_$;


ALTER FUNCTION public.verificar_existencia_rom(character varying, integer) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 31151)
-- Name: verificar_particiapnte_sala(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verificar_particiapnte_sala(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
BEGIN	
	CONTAR := COUNT(participantes.id) from participantes where participantes.participante = $1;
	IF CONTAR!=0 THEN
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$_$;


ALTER FUNCTION public.verificar_particiapnte_sala(integer) OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 31152)
-- Name: verificar_particiapnte_sala(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verificar_particiapnte_sala(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
BEGIN	
	CONTAR := COUNT(participantes.id) from participantes where participantes.participante = $1 and participantes.idrom = $2;
	IF CONTAR!=0 THEN
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$_$;


ALTER FUNCTION public.verificar_particiapnte_sala(integer, integer) OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 31153)
-- Name: verificar_participante_sala(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verificar_participante_sala(integer, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	CONTAR INTEGER;
BEGIN	
	CONTAR := COUNT(participantes.id) from participantes where participantes.participante = $1 and participantes.idrom = $2;
	IF CONTAR!=0 THEN
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$_$;


ALTER FUNCTION public.verificar_participante_sala(integer, integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 31036)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuario (
    id integer NOT NULL,
    nombreusuario character varying(15) NOT NULL
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 31034)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_id_seq OWNER TO postgres;

--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 181
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- TOC entry 184 (class 1259 OID 31088)
-- Name: contactos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contactos (
    id integer NOT NULL,
    usuariocontacto character varying(15) NOT NULL,
    idusuariocontacto integer DEFAULT nextval('usuario_id_seq'::regclass) NOT NULL
);


ALTER TABLE contactos OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 31086)
-- Name: contactos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contactos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contactos_id_seq OWNER TO postgres;

--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 183
-- Name: contactos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contactos_id_seq OWNED BY contactos.id;


--
-- TOC entry 190 (class 1259 OID 31161)
-- Name: msg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE msg (
    id integer NOT NULL,
    usuario character varying(15) NOT NULL,
    mensaje character varying(100) NOT NULL,
    romid integer NOT NULL
);


ALTER TABLE msg OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 31159)
-- Name: msg_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE msg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE msg_id_seq OWNER TO postgres;

--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 189
-- Name: msg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE msg_id_seq OWNED BY msg.id;


--
-- TOC entry 188 (class 1259 OID 31129)
-- Name: participantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE participantes (
    id integer NOT NULL,
    idrom integer NOT NULL,
    participante integer NOT NULL
);


ALTER TABLE participantes OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 31127)
-- Name: participantes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE participantes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE participantes_id_seq OWNER TO postgres;

--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 187
-- Name: participantes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE participantes_id_seq OWNED BY participantes.id;


--
-- TOC entry 186 (class 1259 OID 31108)
-- Name: rom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rom (
    id integer NOT NULL,
    idusuario integer DEFAULT nextval('usuario_id_seq'::regclass) NOT NULL,
    descripcion character varying(20) NOT NULL,
    tipo integer NOT NULL
);


ALTER TABLE rom OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 31106)
-- Name: rom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rom_id_seq OWNER TO postgres;

--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 185
-- Name: rom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rom_id_seq OWNED BY rom.id;


--
-- TOC entry 2029 (class 2604 OID 31091)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contactos ALTER COLUMN id SET DEFAULT nextval('contactos_id_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 31164)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY msg ALTER COLUMN id SET DEFAULT nextval('msg_id_seq'::regclass);


--
-- TOC entry 2033 (class 2604 OID 31132)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participantes ALTER COLUMN id SET DEFAULT nextval('participantes_id_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 31111)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rom ALTER COLUMN id SET DEFAULT nextval('rom_id_seq'::regclass);


--
-- TOC entry 2028 (class 2604 OID 31039)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- TOC entry 2038 (class 2606 OID 31094)
-- Name: contactos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contactos
    ADD CONSTRAINT contactos_pk PRIMARY KEY (id);


--
-- TOC entry 2044 (class 2606 OID 31166)
-- Name: msg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY msg
    ADD CONSTRAINT msg_pk PRIMARY KEY (id);


--
-- TOC entry 2042 (class 2606 OID 31134)
-- Name: participantes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participantes
    ADD CONSTRAINT participantes_pk PRIMARY KEY (id);


--
-- TOC entry 2040 (class 2606 OID 31114)
-- Name: rom_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rom
    ADD CONSTRAINT rom_pk PRIMARY KEY (id);


--
-- TOC entry 2036 (class 2606 OID 31041)
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id);


--
-- TOC entry 2048 (class 2606 OID 31177)
-- Name: rom_msg_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY msg
    ADD CONSTRAINT rom_msg_fk FOREIGN KEY (romid) REFERENCES rom(id);


--
-- TOC entry 2047 (class 2606 OID 31145)
-- Name: rom_participantes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participantes
    ADD CONSTRAINT rom_participantes_fk FOREIGN KEY (idrom) REFERENCES rom(id);


--
-- TOC entry 2045 (class 2606 OID 31167)
-- Name: usuario_contactos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contactos
    ADD CONSTRAINT usuario_contactos_fk FOREIGN KEY (idusuariocontacto) REFERENCES usuario(id);


--
-- TOC entry 2046 (class 2606 OID 31172)
-- Name: usuario_rom_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rom
    ADD CONSTRAINT usuario_rom_fk FOREIGN KEY (idusuario) REFERENCES usuario(id);


--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-08-26 18:22:15

--
-- PostgreSQL database dump complete
--

