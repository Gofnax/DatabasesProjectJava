toc.dat                                                                                             0000600 0004000 0002000 00000034701 14655457210 0014455 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP               	        |           ExamCreationDB    16.3    16.3 1               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                    0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                    0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                    1262    16868    ExamCreationDB    DATABASE     �   CREATE DATABASE "ExamCreationDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
     DROP DATABASE "ExamCreationDB";
                postgres    false         �            1259    17054    answertb    TABLE     �   CREATE TABLE public.answertb (
    answerid integer NOT NULL,
    subjectid integer NOT NULL,
    answer character varying(256) NOT NULL
);
    DROP TABLE public.answertb;
       public         heap    postgres    false         �            1259    17053    answertb_answerid_seq    SEQUENCE     �   CREATE SEQUENCE public.answertb_answerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.answertb_answerid_seq;
       public          postgres    false    218                     0    0    answertb_answerid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.answertb_answerid_seq OWNED BY public.answertb.answerid;
          public          postgres    false    217         �            1259    17110    examtb    TABLE     �   CREATE TABLE public.examtb (
    examid integer NOT NULL,
    subjectid integer NOT NULL,
    exam character varying(256) NOT NULL,
    examcontent text NOT NULL,
    solutioncontent text NOT NULL
);
    DROP TABLE public.examtb;
       public         heap    postgres    false         �            1259    17109    examtb_examid_seq    SEQUENCE     �   CREATE SEQUENCE public.examtb_examid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.examtb_examid_seq;
       public          postgres    false    225         !           0    0    examtb_examid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.examtb_examid_seq OWNED BY public.examtb.examid;
          public          postgres    false    224         �            1259    17094    mquestion_answertb    TABLE     �   CREATE TABLE public.mquestion_answertb (
    mquestionid integer NOT NULL,
    answerid integer NOT NULL,
    iscorrect boolean NOT NULL
);
 &   DROP TABLE public.mquestion_answertb;
       public         heap    postgres    false         �            1259    17066    mquestiontb    TABLE     �   CREATE TABLE public.mquestiontb (
    mquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL
);
    DROP TABLE public.mquestiontb;
       public         heap    postgres    false         �            1259    17065    mquestiontb_mquestionid_seq    SEQUENCE     �   CREATE SEQUENCE public.mquestiontb_mquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.mquestiontb_mquestionid_seq;
       public          postgres    false    220         "           0    0    mquestiontb_mquestionid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.mquestiontb_mquestionid_seq OWNED BY public.mquestiontb.mquestionid;
          public          postgres    false    219         �            1259    17078    oquestiontb    TABLE     �   CREATE TABLE public.oquestiontb (
    oquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    answerid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL
);
    DROP TABLE public.oquestiontb;
       public         heap    postgres    false         �            1259    17077    oquestiontb_oquestionid_seq    SEQUENCE     �   CREATE SEQUENCE public.oquestiontb_oquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.oquestiontb_oquestionid_seq;
       public          postgres    false    222         #           0    0    oquestiontb_oquestionid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.oquestiontb_oquestionid_seq OWNED BY public.oquestiontb.oquestionid;
          public          postgres    false    221         �            1259    17047 	   subjecttb    TABLE     o   CREATE TABLE public.subjecttb (
    subjectid integer NOT NULL,
    subject character varying(100) NOT NULL
);
    DROP TABLE public.subjecttb;
       public         heap    postgres    false         �            1259    17046    subjecttb_subjectid_seq    SEQUENCE     �   CREATE SEQUENCE public.subjecttb_subjectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.subjecttb_subjectid_seq;
       public          postgres    false    216         $           0    0    subjecttb_subjectid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.subjecttb_subjectid_seq OWNED BY public.subjecttb.subjectid;
          public          postgres    false    215         i           2604    17123    answertb answerid    DEFAULT     v   ALTER TABLE ONLY public.answertb ALTER COLUMN answerid SET DEFAULT nextval('public.answertb_answerid_seq'::regclass);
 @   ALTER TABLE public.answertb ALTER COLUMN answerid DROP DEFAULT;
       public          postgres    false    217    218    218         l           2604    17124    examtb examid    DEFAULT     n   ALTER TABLE ONLY public.examtb ALTER COLUMN examid SET DEFAULT nextval('public.examtb_examid_seq'::regclass);
 <   ALTER TABLE public.examtb ALTER COLUMN examid DROP DEFAULT;
       public          postgres    false    224    225    225         j           2604    17125    mquestiontb mquestionid    DEFAULT     �   ALTER TABLE ONLY public.mquestiontb ALTER COLUMN mquestionid SET DEFAULT nextval('public.mquestiontb_mquestionid_seq'::regclass);
 F   ALTER TABLE public.mquestiontb ALTER COLUMN mquestionid DROP DEFAULT;
       public          postgres    false    220    219    220         k           2604    17126    oquestiontb oquestionid    DEFAULT     �   ALTER TABLE ONLY public.oquestiontb ALTER COLUMN oquestionid SET DEFAULT nextval('public.oquestiontb_oquestionid_seq'::regclass);
 F   ALTER TABLE public.oquestiontb ALTER COLUMN oquestionid DROP DEFAULT;
       public          postgres    false    222    221    222         h           2604    17127    subjecttb subjectid    DEFAULT     z   ALTER TABLE ONLY public.subjecttb ALTER COLUMN subjectid SET DEFAULT nextval('public.subjecttb_subjectid_seq'::regclass);
 B   ALTER TABLE public.subjecttb ALTER COLUMN subjectid DROP DEFAULT;
       public          postgres    false    215    216    216                   0    17054    answertb 
   TABLE DATA           ?   COPY public.answertb (answerid, subjectid, answer) FROM stdin;
    public          postgres    false    218       4882.dat           0    17110    examtb 
   TABLE DATA           W   COPY public.examtb (examid, subjectid, exam, examcontent, solutioncontent) FROM stdin;
    public          postgres    false    225       4889.dat           0    17094    mquestion_answertb 
   TABLE DATA           N   COPY public.mquestion_answertb (mquestionid, answerid, iscorrect) FROM stdin;
    public          postgres    false    223       4887.dat           0    17066    mquestiontb 
   TABLE DATA           S   COPY public.mquestiontb (mquestionid, subjectid, question, difficulty) FROM stdin;
    public          postgres    false    220       4884.dat           0    17078    oquestiontb 
   TABLE DATA           ]   COPY public.oquestiontb (oquestionid, subjectid, answerid, question, difficulty) FROM stdin;
    public          postgres    false    222       4886.dat           0    17047 	   subjecttb 
   TABLE DATA           7   COPY public.subjecttb (subjectid, subject) FROM stdin;
    public          postgres    false    216       4880.dat %           0    0    answertb_answerid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.answertb_answerid_seq', 1, false);
          public          postgres    false    217         &           0    0    examtb_examid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.examtb_examid_seq', 1, false);
          public          postgres    false    224         '           0    0    mquestiontb_mquestionid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.mquestiontb_mquestionid_seq', 1, false);
          public          postgres    false    219         (           0    0    oquestiontb_oquestionid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.oquestiontb_oquestionid_seq', 1, false);
          public          postgres    false    221         )           0    0    subjecttb_subjectid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.subjecttb_subjectid_seq', 1, true);
          public          postgres    false    215         p           2606    17059    answertb answertb_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_pkey PRIMARY KEY (answerid);
 @   ALTER TABLE ONLY public.answertb DROP CONSTRAINT answertb_pkey;
       public            postgres    false    218         x           2606    17117    examtb examtb_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_pkey PRIMARY KEY (examid);
 <   ALTER TABLE ONLY public.examtb DROP CONSTRAINT examtb_pkey;
       public            postgres    false    225         v           2606    17098 *   mquestion_answertb mquestion_answertb_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_pkey PRIMARY KEY (mquestionid, answerid);
 T   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_pkey;
       public            postgres    false    223    223         r           2606    17071    mquestiontb mquestiontb_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_pkey PRIMARY KEY (mquestionid);
 F   ALTER TABLE ONLY public.mquestiontb DROP CONSTRAINT mquestiontb_pkey;
       public            postgres    false    220         t           2606    17083    oquestiontb oquestiontb_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_pkey PRIMARY KEY (oquestionid);
 F   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_pkey;
       public            postgres    false    222         n           2606    17052    subjecttb subjecttb_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.subjecttb
    ADD CONSTRAINT subjecttb_pkey PRIMARY KEY (subjectid);
 B   ALTER TABLE ONLY public.subjecttb DROP CONSTRAINT subjecttb_pkey;
       public            postgres    false    216         y           2606    17060     answertb answertb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 J   ALTER TABLE ONLY public.answertb DROP CONSTRAINT answertb_subjectid_fkey;
       public          postgres    false    218    216    4718                    2606    17118    examtb examtb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 F   ALTER TABLE ONLY public.examtb DROP CONSTRAINT examtb_subjectid_fkey;
       public          postgres    false    4718    225    216         }           2606    17099 3   mquestion_answertb mquestion_answertb_answerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);
 ]   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_answerid_fkey;
       public          postgres    false    4720    223    218         ~           2606    17104 6   mquestion_answertb mquestion_answertb_mquestionid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_mquestionid_fkey FOREIGN KEY (mquestionid) REFERENCES public.mquestiontb(mquestionid);
 `   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_mquestionid_fkey;
       public          postgres    false    4722    223    220         z           2606    17072 &   mquestiontb mquestiontb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 P   ALTER TABLE ONLY public.mquestiontb DROP CONSTRAINT mquestiontb_subjectid_fkey;
       public          postgres    false    216    4718    220         {           2606    17084 %   oquestiontb oquestiontb_answerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);
 O   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_answerid_fkey;
       public          postgres    false    222    4720    218         |           2606    17089 &   oquestiontb oquestiontb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 P   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_subjectid_fkey;
       public          postgres    false    222    4718    216                                                                       4882.dat                                                                                            0000600 0004000 0002000 00000000005 14655457210 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4889.dat                                                                                            0000600 0004000 0002000 00000000005 14655457210 0014272 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4887.dat                                                                                            0000600 0004000 0002000 00000000005 14655457210 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4884.dat                                                                                            0000600 0004000 0002000 00000000005 14655457210 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4886.dat                                                                                            0000600 0004000 0002000 00000000005 14655457210 0014267 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4880.dat                                                                                            0000600 0004000 0002000 00000000030 14655457210 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Emilio el grande
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        restore.sql                                                                                         0000600 0004000 0002000 00000027254 14655457210 0015407 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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

DROP DATABASE "ExamCreationDB";
--
-- Name: ExamCreationDB; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "ExamCreationDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE "ExamCreationDB" OWNER TO postgres;

\connect "ExamCreationDB"

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
-- Name: answertb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answertb (
    answerid integer NOT NULL,
    subjectid integer NOT NULL,
    answer character varying(256) NOT NULL
);


ALTER TABLE public.answertb OWNER TO postgres;

--
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
-- Name: answertb_answerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answertb_answerid_seq OWNED BY public.answertb.answerid;


--
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
-- Name: examtb_examid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.examtb_examid_seq OWNED BY public.examtb.examid;


--
-- Name: mquestion_answertb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mquestion_answertb (
    mquestionid integer NOT NULL,
    answerid integer NOT NULL,
    iscorrect boolean NOT NULL
);


ALTER TABLE public.mquestion_answertb OWNER TO postgres;

--
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
-- Name: mquestiontb_mquestionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mquestiontb_mquestionid_seq OWNED BY public.mquestiontb.mquestionid;


--
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
-- Name: oquestiontb_oquestionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oquestiontb_oquestionid_seq OWNED BY public.oquestiontb.oquestionid;


--
-- Name: subjecttb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjecttb (
    subjectid integer NOT NULL,
    subject character varying(100) NOT NULL
);


ALTER TABLE public.subjecttb OWNER TO postgres;

--
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
-- Name: subjecttb_subjectid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjecttb_subjectid_seq OWNED BY public.subjecttb.subjectid;


--
-- Name: answertb answerid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answertb ALTER COLUMN answerid SET DEFAULT nextval('public.answertb_answerid_seq'::regclass);


--
-- Name: examtb examid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examtb ALTER COLUMN examid SET DEFAULT nextval('public.examtb_examid_seq'::regclass);


--
-- Name: mquestiontb mquestionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestiontb ALTER COLUMN mquestionid SET DEFAULT nextval('public.mquestiontb_mquestionid_seq'::regclass);


--
-- Name: oquestiontb oquestionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb ALTER COLUMN oquestionid SET DEFAULT nextval('public.oquestiontb_oquestionid_seq'::regclass);


--
-- Name: subjecttb subjectid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjecttb ALTER COLUMN subjectid SET DEFAULT nextval('public.subjecttb_subjectid_seq'::regclass);


--
-- Data for Name: answertb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answertb (answerid, subjectid, answer) FROM stdin;
\.
COPY public.answertb (answerid, subjectid, answer) FROM '$$PATH$$/4882.dat';

--
-- Data for Name: examtb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.examtb (examid, subjectid, exam, examcontent, solutioncontent) FROM stdin;
\.
COPY public.examtb (examid, subjectid, exam, examcontent, solutioncontent) FROM '$$PATH$$/4889.dat';

--
-- Data for Name: mquestion_answertb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mquestion_answertb (mquestionid, answerid, iscorrect) FROM stdin;
\.
COPY public.mquestion_answertb (mquestionid, answerid, iscorrect) FROM '$$PATH$$/4887.dat';

--
-- Data for Name: mquestiontb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mquestiontb (mquestionid, subjectid, question, difficulty) FROM stdin;
\.
COPY public.mquestiontb (mquestionid, subjectid, question, difficulty) FROM '$$PATH$$/4884.dat';

--
-- Data for Name: oquestiontb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oquestiontb (oquestionid, subjectid, answerid, question, difficulty) FROM stdin;
\.
COPY public.oquestiontb (oquestionid, subjectid, answerid, question, difficulty) FROM '$$PATH$$/4886.dat';

--
-- Data for Name: subjecttb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjecttb (subjectid, subject) FROM stdin;
\.
COPY public.subjecttb (subjectid, subject) FROM '$$PATH$$/4880.dat';

--
-- Name: answertb_answerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answertb_answerid_seq', 1, false);


--
-- Name: examtb_examid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.examtb_examid_seq', 1, false);


--
-- Name: mquestiontb_mquestionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mquestiontb_mquestionid_seq', 1, false);


--
-- Name: oquestiontb_oquestionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oquestiontb_oquestionid_seq', 1, false);


--
-- Name: subjecttb_subjectid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjecttb_subjectid_seq', 1, true);


--
-- Name: answertb answertb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_pkey PRIMARY KEY (answerid);


--
-- Name: examtb examtb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_pkey PRIMARY KEY (examid);


--
-- Name: mquestion_answertb mquestion_answertb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_pkey PRIMARY KEY (mquestionid, answerid);


--
-- Name: mquestiontb mquestiontb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_pkey PRIMARY KEY (mquestionid);


--
-- Name: oquestiontb oquestiontb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_pkey PRIMARY KEY (oquestionid);


--
-- Name: subjecttb subjecttb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjecttb
    ADD CONSTRAINT subjecttb_pkey PRIMARY KEY (subjectid);


--
-- Name: answertb answertb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- Name: examtb examtb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- Name: mquestion_answertb mquestion_answertb_answerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);


--
-- Name: mquestion_answertb mquestion_answertb_mquestionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_mquestionid_fkey FOREIGN KEY (mquestionid) REFERENCES public.mquestiontb(mquestionid);


--
-- Name: mquestiontb mquestiontb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- Name: oquestiontb oquestiontb_answerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);


--
-- Name: oquestiontb oquestiontb_subjectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    