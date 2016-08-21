
CREATE SEQUENCE public.usuario_id_seq;

CREATE TABLE public.Usuario (
                id INTEGER NOT NULL DEFAULT nextval('public.usuario_id_seq'),
                nombreUsuario VARCHAR(15) NOT NULL,
                CONSTRAINT usuario_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.usuario_id_seq OWNED BY public.Usuario.id;

CREATE SEQUENCE public.sala_id_seq;

CREATE TABLE public.Sala (
                id INTEGER NOT NULL DEFAULT nextval('public.sala_id_seq'),
                NombreSala VARCHAR(15) NOT NULL,
                CONSTRAINT sala_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.sala_id_seq OWNED BY public.Sala.id;

CREATE SEQUENCE public.salausuario_idsalausuario_seq;

CREATE TABLE public.SalaUsuario (
                idSalaUsuario INTEGER NOT NULL DEFAULT nextval('public.salausuario_idsalausuario_seq'),
                idUsuario INTEGER NOT NULL,
                idSala INTEGER NOT NULL,
                CONSTRAINT salausuario_pk PRIMARY KEY (idSalaUsuario)
);


ALTER SEQUENCE public.salausuario_idsalausuario_seq OWNED BY public.SalaUsuario.idSalaUsuario;

ALTER TABLE public.SalaUsuario ADD CONSTRAINT usuario_salausuario_fk
FOREIGN KEY (idUsuario)
REFERENCES public.Usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.SalaUsuario ADD CONSTRAINT sala_salausuario_fk
FOREIGN KEY (idSala)
REFERENCES public.Sala (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;