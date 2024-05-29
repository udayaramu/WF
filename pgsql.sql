-- Table: wf_vcg_db.t_can_master

-- DROP TABLE IF EXISTS wf_vcg_db.t_can_master;

CREATE TABLE IF NOT EXISTS wf_vcg_db.t_can_master
(
    can_id integer NOT NULL DEFAULT nextval('wf_vcg_db.t_can_master_can_id_seq'::regclass),
    can character varying(70) COLLATE pg_catalog."default" NOT NULL,
    can_cvv character varying(5) COLLATE pg_catalog."default",
    can_exp character varying(6) COLLATE pg_catalog."default",
    pan_id bigint NOT NULL,
    binrange_id integer NOT NULL,
    status character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'A'::bpchar,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    currency_id integer NOT NULL DEFAULT 840,
    cpn_amt real NOT NULL DEFAULT 0.0,
    multiuse "char" NOT NULL DEFAULT 'N'::"char",
    tolerance_min real DEFAULT 0.0,
    tolerance_max real DEFAULT 0.0,
    created_by character varying(100) COLLATE pg_catalog."default",
    modified_by character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT t_can_master_pkey PRIMARY KEY (can_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wf_vcg_db.t_can_master
    OWNER to postgres;


-- Table: wf_vcg_db.t_card_network

-- DROP TABLE IF EXISTS wf_vcg_db.t_card_network;

CREATE TABLE IF NOT EXISTS wf_vcg_db.t_card_network
(
    network_id integer NOT NULL DEFAULT nextval('wf_vcg_db.t_card_network_network_id_seq'::regclass),
    network_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    df_bin_range_id integer,
    active character(1) COLLATE pg_catalog."default" DEFAULT 'Y'::bpchar,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT t_card_network_pkey PRIMARY KEY (network_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wf_vcg_db.t_card_network
    OWNER to postgres;

-- Table: wf_vcg_db.t_pan_master

-- DROP TABLE IF EXISTS wf_vcg_db.t_pan_master;

CREATE TABLE IF NOT EXISTS wf_vcg_db.t_pan_master
(
    pan_id integer NOT NULL DEFAULT nextval('wf_vcg_db.t_pan_master_pan_id_seq'::regclass),
    pan character varying(70) COLLATE pg_catalog."default" NOT NULL,
    pan_cvv character varying(5) COLLATE pg_catalog."default",
    pan_exp character varying(6) COLLATE pg_catalog."default",
    binrange_id integer NOT NULL,
    active character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'A'::bpchar,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT t_pan_master_pkey PRIMARY KEY (pan_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wf_vcg_db.t_pan_master
    OWNER to postgres;

-- Table: wf_vcg_db.t_vc_binrange

-- DROP TABLE IF EXISTS wf_vcg_db.t_vc_binrange;

CREATE TABLE IF NOT EXISTS wf_vcg_db.t_vc_binrange
(
    bin_range_id integer NOT NULL DEFAULT nextval('wf_vcg_db.t_vc_binrange_bin_range_id_seq'::regclass),
    vc_bin_prefix character varying(20) COLLATE pg_catalog."default" NOT NULL,
    vc_bin_start_range character varying(20) COLLATE pg_catalog."default",
    vc_bin_end_range character varying(20) COLLATE pg_catalog."default",
    active character(1) COLLATE pg_catalog."default" DEFAULT 'Y'::bpchar,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT t_vc_binrange_pkey PRIMARY KEY (bin_range_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wf_vcg_db.t_vc_binrange
    OWNER to postgres;
