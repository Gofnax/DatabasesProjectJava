PGDMP              	        |           ExamCreationDB    16.3    16.3 3    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16914    ExamCreationDB    DATABASE     �   CREATE DATABASE "ExamCreationDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Israel.1252';
     DROP DATABASE "ExamCreationDB";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    16915    answertb    TABLE     �   CREATE TABLE public.answertb (
    answerid integer NOT NULL,
    subjectid integer NOT NULL,
    answer character varying(256) NOT NULL
);
    DROP TABLE public.answertb;
       public         heap    postgres    false    4            �            1259    16918    answertb_answerid_seq    SEQUENCE     �   CREATE SEQUENCE public.answertb_answerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.answertb_answerid_seq;
       public          postgres    false    4    215            �           0    0    answertb_answerid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.answertb_answerid_seq OWNED BY public.answertb.answerid;
          public          postgres    false    216            �            1259    16919    examtb    TABLE     �   CREATE TABLE public.examtb (
    examid integer NOT NULL,
    subjectid integer NOT NULL,
    exam character varying(256) NOT NULL,
    examcontent text NOT NULL,
    solutioncontent text NOT NULL
);
    DROP TABLE public.examtb;
       public         heap    postgres    false    4            �            1259    16924    examtb_examid_seq    SEQUENCE     �   CREATE SEQUENCE public.examtb_examid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.examtb_examid_seq;
       public          postgres    false    4    217            �           0    0    examtb_examid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.examtb_examid_seq OWNED BY public.examtb.examid;
          public          postgres    false    218            �            1259    16925    mquestion_answertb    TABLE     �   CREATE TABLE public.mquestion_answertb (
    mquestionid integer NOT NULL,
    answerid integer NOT NULL,
    iscorrect boolean NOT NULL
);
 &   DROP TABLE public.mquestion_answertb;
       public         heap    postgres    false    4            �            1259    16928    mquestiontb    TABLE     �   CREATE TABLE public.mquestiontb (
    mquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL
);
    DROP TABLE public.mquestiontb;
       public         heap    postgres    false    4            �            1259    16931    mquestiontb_mquestionid_seq    SEQUENCE     �   CREATE SEQUENCE public.mquestiontb_mquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.mquestiontb_mquestionid_seq;
       public          postgres    false    220    4            �           0    0    mquestiontb_mquestionid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.mquestiontb_mquestionid_seq OWNED BY public.mquestiontb.mquestionid;
          public          postgres    false    221            �            1259    16932    oquestiontb    TABLE     �   CREATE TABLE public.oquestiontb (
    oquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    answerid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL
);
    DROP TABLE public.oquestiontb;
       public         heap    postgres    false    4            �            1259    16935    oquestiontb_oquestionid_seq    SEQUENCE     �   CREATE SEQUENCE public.oquestiontb_oquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.oquestiontb_oquestionid_seq;
       public          postgres    false    222    4            �           0    0    oquestiontb_oquestionid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.oquestiontb_oquestionid_seq OWNED BY public.oquestiontb.oquestionid;
          public          postgres    false    223            �            1259    16936 	   subjecttb    TABLE     o   CREATE TABLE public.subjecttb (
    subjectid integer NOT NULL,
    subject character varying(100) NOT NULL
);
    DROP TABLE public.subjecttb;
       public         heap    postgres    false    4            �            1259    16939    subjecttb_subjectid_seq    SEQUENCE     �   CREATE SEQUENCE public.subjecttb_subjectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.subjecttb_subjectid_seq;
       public          postgres    false    4    224            �           0    0    subjecttb_subjectid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.subjecttb_subjectid_seq OWNED BY public.subjecttb.subjectid;
          public          postgres    false    225            2           2604    17002    answertb answerid    DEFAULT     v   ALTER TABLE ONLY public.answertb ALTER COLUMN answerid SET DEFAULT nextval('public.answertb_answerid_seq'::regclass);
 @   ALTER TABLE public.answertb ALTER COLUMN answerid DROP DEFAULT;
       public          postgres    false    216    215            3           2604    17003    examtb examid    DEFAULT     n   ALTER TABLE ONLY public.examtb ALTER COLUMN examid SET DEFAULT nextval('public.examtb_examid_seq'::regclass);
 <   ALTER TABLE public.examtb ALTER COLUMN examid DROP DEFAULT;
       public          postgres    false    218    217            4           2604    17004    mquestiontb mquestionid    DEFAULT     �   ALTER TABLE ONLY public.mquestiontb ALTER COLUMN mquestionid SET DEFAULT nextval('public.mquestiontb_mquestionid_seq'::regclass);
 F   ALTER TABLE public.mquestiontb ALTER COLUMN mquestionid DROP DEFAULT;
       public          postgres    false    221    220            5           2604    17005    oquestiontb oquestionid    DEFAULT     �   ALTER TABLE ONLY public.oquestiontb ALTER COLUMN oquestionid SET DEFAULT nextval('public.oquestiontb_oquestionid_seq'::regclass);
 F   ALTER TABLE public.oquestiontb ALTER COLUMN oquestionid DROP DEFAULT;
       public          postgres    false    223    222            6           2604    17006    subjecttb subjectid    DEFAULT     z   ALTER TABLE ONLY public.subjecttb ALTER COLUMN subjectid SET DEFAULT nextval('public.subjecttb_subjectid_seq'::regclass);
 B   ALTER TABLE public.subjecttb ALTER COLUMN subjectid DROP DEFAULT;
       public          postgres    false    225    224            �          0    16915    answertb 
   TABLE DATA           ?   COPY public.answertb (answerid, subjectid, answer) FROM stdin;
    public          postgres    false    215   �;       �          0    16919    examtb 
   TABLE DATA           W   COPY public.examtb (examid, subjectid, exam, examcontent, solutioncontent) FROM stdin;
    public          postgres    false    217   �;       �          0    16925    mquestion_answertb 
   TABLE DATA           N   COPY public.mquestion_answertb (mquestionid, answerid, iscorrect) FROM stdin;
    public          postgres    false    219   <       �          0    16928    mquestiontb 
   TABLE DATA           S   COPY public.mquestiontb (mquestionid, subjectid, question, difficulty) FROM stdin;
    public          postgres    false    220   -<       �          0    16932    oquestiontb 
   TABLE DATA           ]   COPY public.oquestiontb (oquestionid, subjectid, answerid, question, difficulty) FROM stdin;
    public          postgres    false    222   J<       �          0    16936 	   subjecttb 
   TABLE DATA           7   COPY public.subjecttb (subjectid, subject) FROM stdin;
    public          postgres    false    224   g<       �           0    0    answertb_answerid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.answertb_answerid_seq', 1, false);
          public          postgres    false    216            �           0    0    examtb_examid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.examtb_examid_seq', 1, false);
          public          postgres    false    218            �           0    0    mquestiontb_mquestionid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.mquestiontb_mquestionid_seq', 1, false);
          public          postgres    false    221            �           0    0    oquestiontb_oquestionid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.oquestiontb_oquestionid_seq', 1, false);
          public          postgres    false    223            �           0    0    subjecttb_subjectid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.subjecttb_subjectid_seq', 2, true);
          public          postgres    false    225            8           2606    16946    answertb answertb_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_pkey PRIMARY KEY (answerid);
 @   ALTER TABLE ONLY public.answertb DROP CONSTRAINT answertb_pkey;
       public            postgres    false    215            :           2606    16948    examtb examtb_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_pkey PRIMARY KEY (examid);
 <   ALTER TABLE ONLY public.examtb DROP CONSTRAINT examtb_pkey;
       public            postgres    false    217            <           2606    16950 *   mquestion_answertb mquestion_answertb_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_pkey PRIMARY KEY (mquestionid, answerid);
 T   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_pkey;
       public            postgres    false    219    219            >           2606    16952    mquestiontb mquestiontb_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_pkey PRIMARY KEY (mquestionid);
 F   ALTER TABLE ONLY public.mquestiontb DROP CONSTRAINT mquestiontb_pkey;
       public            postgres    false    220            @           2606    16954    oquestiontb oquestiontb_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_pkey PRIMARY KEY (oquestionid);
 F   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_pkey;
       public            postgres    false    222            B           2606    16956    subjecttb subjecttb_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.subjecttb
    ADD CONSTRAINT subjecttb_pkey PRIMARY KEY (subjectid);
 B   ALTER TABLE ONLY public.subjecttb DROP CONSTRAINT subjecttb_pkey;
       public            postgres    false    224            C           2606    16957     answertb answertb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 J   ALTER TABLE ONLY public.answertb DROP CONSTRAINT answertb_subjectid_fkey;
       public          postgres    false    224    4674    215            D           2606    16962    examtb examtb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 F   ALTER TABLE ONLY public.examtb DROP CONSTRAINT examtb_subjectid_fkey;
       public          postgres    false    224    217    4674            E           2606    16967 3   mquestion_answertb mquestion_answertb_answerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);
 ]   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_answerid_fkey;
       public          postgres    false    219    215    4664            F           2606    16972 6   mquestion_answertb mquestion_answertb_mquestionid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_mquestionid_fkey FOREIGN KEY (mquestionid) REFERENCES public.mquestiontb(mquestionid);
 `   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_mquestionid_fkey;
       public          postgres    false    219    4670    220            G           2606    16977 &   mquestiontb mquestiontb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 P   ALTER TABLE ONLY public.mquestiontb DROP CONSTRAINT mquestiontb_subjectid_fkey;
       public          postgres    false    224    220    4674            H           2606    16982 %   oquestiontb oquestiontb_answerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);
 O   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_answerid_fkey;
       public          postgres    false    4664    222    215            I           2606    16987 &   oquestiontb oquestiontb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 P   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_subjectid_fkey;
       public          postgres    false    4674    222    224            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   -   x�3�t�����WH�QH/J�KI�2����IL���O������ �	!     