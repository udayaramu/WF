--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-29 08:50:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16427)
-- Name: t_vc_binrange; Type: TABLE; Schema: wf_vcg_db; Owner: postgres
--

CREATE TABLE wf_vcg_db.t_vc_binrange (
    bin_range_id integer NOT NULL,
    vc_bin_prefix character varying(20) NOT NULL,
    vc_bin_start_range character varying(20),
    vc_bin_end_range character varying(20),
    active character(1) DEFAULT 'Y'::bpchar,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE wf_vcg_db.t_vc_binrange OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16426)
-- Name: t_vc_binrange_bin_range_id_seq; Type: SEQUENCE; Schema: wf_vcg_db; Owner: postgres
--

CREATE SEQUENCE wf_vcg_db.t_vc_binrange_bin_range_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE wf_vcg_db.t_vc_binrange_bin_range_id_seq OWNER TO postgres;

--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 218
-- Name: t_vc_binrange_bin_range_id_seq; Type: SEQUENCE OWNED BY; Schema: wf_vcg_db; Owner: postgres
--

ALTER SEQUENCE wf_vcg_db.t_vc_binrange_bin_range_id_seq OWNED BY wf_vcg_db.t_vc_binrange.bin_range_id;


--
-- TOC entry 4647 (class 2604 OID 16430)
-- Name: t_vc_binrange bin_range_id; Type: DEFAULT; Schema: wf_vcg_db; Owner: postgres
--

ALTER TABLE ONLY wf_vcg_db.t_vc_binrange ALTER COLUMN bin_range_id SET DEFAULT nextval('wf_vcg_db.t_vc_binrange_bin_range_id_seq'::regclass);


--
-- TOC entry 4797 (class 0 OID 16427)
-- Dependencies: 219
-- Data for Name: t_vc_binrange; Type: TABLE DATA; Schema: wf_vcg_db; Owner: postgres
--

INSERT INTO wf_vcg_db.t_vc_binrange VALUES (1, '415928', NULL, NULL, 'Y', '2024-05-27 22:44:55.422975+05:30', '2024-05-27 22:44:55.422975+05:30');
INSERT INTO wf_vcg_db.t_vc_binrange VALUES (2, '553254', NULL, NULL, 'Y', '2024-05-27 22:44:55.422975+05:30', '2024-05-27 22:44:55.422975+05:30');
INSERT INTO wf_vcg_db.t_vc_binrange VALUES (3, '480457', NULL, NULL, 'Y', '2024-05-27 22:44:55.422975+05:30', '2024-05-27 22:44:55.422975+05:30');


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 218
-- Name: t_vc_binrange_bin_range_id_seq; Type: SEQUENCE SET; Schema: wf_vcg_db; Owner: postgres
--

SELECT pg_catalog.setval('wf_vcg_db.t_vc_binrange_bin_range_id_seq', 3, true);


--
-- TOC entry 4652 (class 2606 OID 16435)
-- Name: t_vc_binrange t_vc_binrange_pkey; Type: CONSTRAINT; Schema: wf_vcg_db; Owner: postgres
--

ALTER TABLE ONLY wf_vcg_db.t_vc_binrange
    ADD CONSTRAINT t_vc_binrange_pkey PRIMARY KEY (bin_range_id);


-- Completed on 2024-05-29 08:50:56

--
-- PostgreSQL database dump complete
--

