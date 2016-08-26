
CREATE SEQUENCE public.usuario_id_seq;

CREATE TABLE public.usuario (
                id INTEGER DEFAULT nextval('usuario_id_seq'::regclass) NOT NULL DEFAULT nextval('public.usuario_id_seq'),
                nombreusuario VARCHAR(15) NOT NULL,
                CONSTRAINT usuario_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;

CREATE SEQUENCE public.rom_id_seq;

CREATE TABLE public.rom (
                id INTEGER NOT NULL DEFAULT nextval('public.rom_id_seq'),
                idUsuario INTEGER DEFAULT nextval('usuario_id_seq'::regclass) NOT NULL,
                descripcion VARCHAR(20) NOT NULL,
                tipo INTEGER NOT NULL,
                CONSTRAINT rom_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.rom_id_seq OWNED BY public.rom.id;

CREATE SEQUENCE public.msg_id_seq;

CREATE TABLE public.msg (
                id INTEGER NOT NULL DEFAULT nextval('public.msg_id_seq'),
                usuario VARCHAR(15) NOT NULL,
                mensaje VARCHAR(100) NOT NULL,
                romid INTEGER NOT NULL,
                CONSTRAINT msg_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.msg_id_seq OWNED BY public.msg.id;

CREATE SEQUENCE public.participantes_id_seq;

CREATE TABLE public.participantes (
                id INTEGER NOT NULL DEFAULT nextval('public.participantes_id_seq'),
                idrom INTEGER NOT NULL,
                participante INTEGER NOT NULL,
                CONSTRAINT participantes_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.participantes_id_seq OWNED BY public.participantes.id;

CREATE SEQUENCE public.contactos_id_seq;

CREATE TABLE public.contactos (
                id INTEGER DEFAULT nextval('contactos_id_seq'::regclass) NOT NULL DEFAULT nextval('public.contactos_id_seq'),
                usuariocontacto VARCHAR(15) NOT NULL,
                idusuariocontacto INTEGER DEFAULT nextval('usuario_id_seq'::regclass) NOT NULL,
                CONSTRAINT contactos_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.contactos_id_seq OWNED BY public.contactos.id;

ALTER TABLE public.contactos ADD CONSTRAINT usuario_contactos_fk
FOREIGN KEY (idusuariocontacto)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.rom ADD CONSTRAINT usuario_rom_fk
FOREIGN KEY (idUsuario)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.participantes ADD CONSTRAINT rom_participantes_fk
FOREIGN KEY (idrom)
REFERENCES public.rom (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.msg ADD CONSTRAINT rom_msg_fk
FOREIGN KEY (romid)
REFERENCES public.rom (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;