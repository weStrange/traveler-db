CREATE TABLE public.traveler_user
(
 username character varying(80) NOT NULL,
 birth date NOT NULL,
 gender character varying(40) NOT NULL,
 email character varying(80),
 phone character varying(80),
 address character varying(80),
 city character varying(80),
 country character varying(80),
 photo oid,
 first_name character varying(80),
 last_name character varying(80),
 CONSTRAINT traveler_user_pkey PRIMARY KEY (username)
)
WITH (
 OIDS=FALSE
);
ALTER TABLE public.traveler_user
 OWNER TO postgres;

CREATE TABLE public.personal_card
(
 id bigint NOT NULL,
 start_time date NOT NULL,
 end_time date NOT NULL,
 lon numeric(10,7),
 lat numeric(10,7),
 username_fk character varying(80) NOT NULL,
 active boolean,
 CONSTRAINT personal_card_pkey PRIMARY KEY (id),
 CONSTRAINT personal_card_username_fk_fkey FOREIGN KEY (username_fk)
      REFERENCES public.traveler_user (username) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 )
 WITH (
  OIDS=FALSE
 );
 ALTER TABLE public.personal_card
  OWNER TO postgres;

CREATE TABLE public.group_card
(
 id bigint NOT NULL,
 start_time date NOT NULL,
 end_time date NOT NULL,
 lon numeric(10,7),
 lat numeric(10,7),
 owner_fk character(80) NOT NULL,
 active boolean,
 CONSTRAINT group_card_pkey PRIMARY KEY (id)
)
WITH (
 OIDS=FALSE
);
ALTER TABLE public.group_card
 OWNER TO postgres;

CREATE TABLE public.card_user
(
 card_id bigint,
 username character varying(80),
 CONSTRAINT card_user_card_id_fkey FOREIGN KEY (card_id)
     REFERENCES public.group_card (id) MATCH SIMPLE
     ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT card_user_username_fkey FOREIGN KEY (username)
     REFERENCES public.traveler_user (username) MATCH SIMPLE
     ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
 OIDS=FALSE
);
ALTER TABLE public.card_user
 OWNER TO postgres;

 CREATE TABLE public.user_credentials
 (
  username character varying(80),
  password character varying(160),
  active boolean,
  CONSTRAINT user_credentials_username_fkey FOREIGN KEY (username)
      REFERENCES public.traveler_user (username) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 )
 WITH (
  OIDS=FALSE
 );
 ALTER TABLE public.user_credentials
  OWNER TO postgres;


create table public.mate_matcher (
card1_id bigint NOT NULL,
card1_type int NOT NULL, 
card1_decision boolean NOT NULL,
card2_id bigint NOT NULL,
card2_type int NOT NULL,
card2_decision boolean NOT NULL,
CONSTRAINT mate_matcher_pk PRIMARY KEY (card1_id, card1_type, card2_id, card2_type)
)
WITH (
 OIDS=FALSE
);


