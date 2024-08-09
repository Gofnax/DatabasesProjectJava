--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-08-09 20:08:33

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 17054)
-- Name: answertb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answertb (
    answerid integer NOT NULL,
    subjectid integer NOT NULL,
    answer character varying(256) NOT NULL
);


ALTER TABLE public.answertb OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17053)
-- Name: answertb_answerid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answertb_answerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answertb_answerid_seq OWNER TO postgres;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 217
-- Name: answertb_answerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answertb_answerid_seq OWNED BY public.answertb.answerid;


--
-- TOC entry 225 (class 1259 OID 17110)
-- Name: examtb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.examtb (
    examid integer NOT NULL,
    subjectid integer NOT NULL,
    exam character varying(256) NOT NULL,
    examcontent text NOT NULL,
    solutioncontent text NOT NULL
);


ALTER TABLE public.examtb OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17109)
-- Name: examtb_examid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.examtb_examid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.examtb_examid_seq OWNER TO postgres;

--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 224
-- Name: examtb_examid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.examtb_examid_seq OWNED BY public.examtb.examid;


--
-- TOC entry 223 (class 1259 OID 17094)
-- Name: mquestion_answertb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mquestion_answertb (
    mquestionid integer NOT NULL,
    answerid integer NOT NULL,
    iscorrect boolean NOT NULL
);


ALTER TABLE public.mquestion_answertb OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17066)
-- Name: mquestiontb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mquestiontb (
    mquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL
);


ALTER TABLE public.mquestiontb OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17065)
-- Name: mquestiontb_mquestionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mquestiontb_mquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mquestiontb_mquestionid_seq OWNER TO postgres;

--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 219
-- Name: mquestiontb_mquestionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mquestiontb_mquestionid_seq OWNED BY public.mquestiontb.mquestionid;


--
-- TOC entry 222 (class 1259 OID 17078)
-- Name: oquestiontb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oquestiontb (
    oquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    answerid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL
);


ALTER TABLE public.oquestiontb OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17077)
-- Name: oquestiontb_oquestionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oquestiontb_oquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oquestiontb_oquestionid_seq OWNER TO postgres;

--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 221
-- Name: oquestiontb_oquestionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oquestiontb_oquestionid_seq OWNED BY public.oquestiontb.oquestionid;


--
-- TOC entry 216 (class 1259 OID 17047)
-- Name: subjecttb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjecttb (
    subjectid integer NOT NULL,
    subject character varying(100) NOT NULL
);


ALTER TABLE public.subjecttb OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17046)
-- Name: subjecttb_subjectid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjecttb_subjectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subjecttb_subjectid_seq OWNER TO postgres;

--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 215
-- Name: subjecttb_subjectid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjecttb_subjectid_seq OWNED BY public.subjecttb.subjectid;


--
-- TOC entry 4713 (class 2604 OID 17057)
-- Name: answertb answerid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answertb ALTER COLUMN answerid SET DEFAULT nextval('public.answertb_answerid_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 17113)
-- Name: examtb examid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examtb ALTER COLUMN examid SET DEFAULT nextval('public.examtb_examid_seq'::regclass);


--
-- TOC entry 4714 (class 2604 OID 17069)
-- Name: mquestiontb mquestionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestiontb ALTER COLUMN mquestionid SET DEFAULT nextval('public.mquestiontb_mquestionid_seq'::regclass);


--
-- TOC entry 4715 (class 2604 OID 17081)
-- Name: oquestiontb oquestionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb ALTER COLUMN oquestionid SET DEFAULT nextval('public.oquestiontb_oquestionid_seq'::regclass);


--
-- TOC entry 4712 (class 2604 OID 17050)
-- Name: subjecttb subjectid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjecttb ALTER COLUMN subjectid SET DEFAULT nextval('public.subjecttb_subjectid_seq'::regclass);


--
-- TOC entry 4882 (class 0 OID 17054)
-- Dependencies: 218
-- Data for Name: answertb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answertb (answerid, subjectid, answer) FROM stdin;
\.


--
-- TOC entry 4889 (class 0 OID 17110)
-- Dependencies: 225
-- Data for Name: examtb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.examtb (examid, subjectid, exam, examcontent, solutioncontent) FROM stdin;
\.


--
-- TOC entry 4887 (class 0 OID 17094)
-- Dependencies: 223
-- Data for Name: mquestion_answertb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mquestion_answertb (mquestionid, answerid, iscorrect) FROM stdin;
\.


--
-- TOC entry 4884 (class 0 OID 17066)
-- Dependencies: 220
-- Data for Name: mquestiontb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mquestiontb (mquestionid, subjectid, question, difficulty) FROM stdin;
\.


--
-- TOC entry 4886 (class 0 OID 17078)
-- Dependencies: 222
-- Data for Name: oquestiontb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oquestiontb (oquestionid, subjectid, answerid, question, difficulty) FROM stdin;
\.


--
-- TOC entry 4880 (class 0 OID 17047)
-- Dependencies: 216
-- Data for Name: subjecttb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjecttb (subjectid, subject) FROM stdin;
\.


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 217
-- Name: answertb_answerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answertb_answerid_seq', 1, false);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 224
-- Name: examtb_examid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.examtb_examid_seq', 1, false);


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 219
-- Name: mquestiontb_mquestionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mquestiontb_mquestionid_seq', 1, false);


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 221
-- Name: oquestiontb_oquestionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oquestiontb_oquestionid_seq', 1, false);


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 215
-- Name: subjecttb_subjectid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjecttb_subjectid_seq', 1, false);


--
-- TOC entry 4720 (class 2606 OID 17059)
-- Name: answertb answertb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_pkey PRIMARY KEY (answerid);


--
-- TOC entry 4728 (class 2606 OID 17117)
-- Name: examtb examtb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_pkey PRIMARY KEY (examid);


--
-- TOC entry 4726 (class 2606 OID 17098)
-- Name: mquestion_answertb mquestion_answertb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_pkey PRIMARY KEY (mquestionid, answerid);


--
-- TOC entry 4722 (class 2606 OID 17071)
-- Name: mquestiontb mquestiontb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_pkey PRIMARY KEY (mquestionid);


--
-- TOC entry 4724 (class 2606 OID 17083)
-- Name: oquestiontb oquestiontb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_pkey PRIMARY KEY (oquestionid);


--
-- TOC entry 4718 (class 2606 OID 17052)
-- Name: subjecttb subjecttb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjecttb
    ADD CONSTRAINT subjecttb_pkey PRIMARY KEY (subjectid);


--
-- TOC entry 4729 (class 2606 OID 17060)
-- Name: answertb answertb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- TOC entry 4735 (class 2606 OID 17118)
-- Name: examtb examtb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- TOC entry 4733 (class 2606 OID 17099)
-- Name: mquestion_answertb mquestion_answertb_answerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);


--
-- TOC entry 4734 (class 2606 OID 17104)
-- Name: mquestion_answertb mquestion_answertb_mquestionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_mquestionid_fkey FOREIGN KEY (mquestionid) REFERENCES public.mquestiontb(mquestionid);


--
-- TOC entry 4730 (class 2606 OID 17072)
-- Name: mquestiontb mquestiontb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- TOC entry 4731 (class 2606 OID 17084)
-- Name: oquestiontb oquestiontb_answerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);


--
-- TOC entry 4732 (class 2606 OID 17089)
-- Name: oquestiontb oquestiontb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


-- Completed on 2024-08-09 20:08:33

--
-- PostgreSQL database dump complete
--

