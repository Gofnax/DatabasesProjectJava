PGDMP      #                |           ExamCreationDB    16.3    16.3 2               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    16868    ExamCreationDB    DATABASE     �   CREATE DATABASE "ExamCreationDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
     DROP DATABASE "ExamCreationDB";
                postgres    false            "           0    0    DATABASE "ExamCreationDB"    ACL     4   GRANT ALL ON DATABASE "ExamCreationDB" TO "Emilio";
                   postgres    false    4897            �            1259    17054    answertb    TABLE     �   CREATE TABLE public.answertb (
    answerid integer NOT NULL,
    subjectid integer NOT NULL,
    answer character varying(256) NOT NULL
);
    DROP TABLE public.answertb;
       public         heap    postgres    false            �            1259    17053    answertb_answerid_seq    SEQUENCE     �   CREATE SEQUENCE public.answertb_answerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.answertb_answerid_seq;
       public          postgres    false    218            #           0    0    answertb_answerid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.answertb_answerid_seq OWNED BY public.answertb.answerid;
          public          postgres    false    217            �            1259    17110    examtb    TABLE     �   CREATE TABLE public.examtb (
    examid integer NOT NULL,
    subjectid integer NOT NULL,
    exam character varying(256) NOT NULL,
    examcontent text NOT NULL,
    solutioncontent text NOT NULL
);
    DROP TABLE public.examtb;
       public         heap    postgres    false            �            1259    17109    examtb_examid_seq    SEQUENCE     �   CREATE SEQUENCE public.examtb_examid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.examtb_examid_seq;
       public          postgres    false    220            $           0    0    examtb_examid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.examtb_examid_seq OWNED BY public.examtb.examid;
          public          postgres    false    219            �            1259    17182    mquestion_answertb    TABLE     �   CREATE TABLE public.mquestion_answertb (
    mquestionid integer NOT NULL,
    answerid integer NOT NULL,
    iscorrect boolean NOT NULL
);
 &   DROP TABLE public.mquestion_answertb;
       public         heap    postgres    false            �            1259    17152    mquestiontb    TABLE       CREATE TABLE public.mquestiontb (
    mquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL,
    CONSTRAINT mquestiontb_difficulty_check CHECK (((difficulty >= 0) AND (difficulty <= 2)))
);
    DROP TABLE public.mquestiontb;
       public         heap    postgres    false            �            1259    17151    mquestiontb_mquestionid_seq    SEQUENCE     �   CREATE SEQUENCE public.mquestiontb_mquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.mquestiontb_mquestionid_seq;
       public          postgres    false    222            %           0    0    mquestiontb_mquestionid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.mquestiontb_mquestionid_seq OWNED BY public.mquestiontb.mquestionid;
          public          postgres    false    221            �            1259    17165    oquestiontb    TABLE     3  CREATE TABLE public.oquestiontb (
    oquestionid integer NOT NULL,
    subjectid integer NOT NULL,
    answerid integer NOT NULL,
    question character varying(256) NOT NULL,
    difficulty integer NOT NULL,
    CONSTRAINT oquestiontb_difficulty_check CHECK (((difficulty >= 0) AND (difficulty <= 2)))
);
    DROP TABLE public.oquestiontb;
       public         heap    postgres    false            �            1259    17164    oquestiontb_oquestionid_seq    SEQUENCE     �   CREATE SEQUENCE public.oquestiontb_oquestionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.oquestiontb_oquestionid_seq;
       public          postgres    false    224            &           0    0    oquestiontb_oquestionid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.oquestiontb_oquestionid_seq OWNED BY public.oquestiontb.oquestionid;
          public          postgres    false    223            �            1259    17047 	   subjecttb    TABLE     o   CREATE TABLE public.subjecttb (
    subjectid integer NOT NULL,
    subject character varying(100) NOT NULL
);
    DROP TABLE public.subjecttb;
       public         heap    postgres    false            �            1259    17046    subjecttb_subjectid_seq    SEQUENCE     �   CREATE SEQUENCE public.subjecttb_subjectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.subjecttb_subjectid_seq;
       public          postgres    false    216            '           0    0    subjecttb_subjectid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.subjecttb_subjectid_seq OWNED BY public.subjecttb.subjectid;
          public          postgres    false    215            i           2604    17129    answertb answerid    DEFAULT     v   ALTER TABLE ONLY public.answertb ALTER COLUMN answerid SET DEFAULT nextval('public.answertb_answerid_seq'::regclass);
 @   ALTER TABLE public.answertb ALTER COLUMN answerid DROP DEFAULT;
       public          postgres    false    218    217    218            j           2604    17130    examtb examid    DEFAULT     n   ALTER TABLE ONLY public.examtb ALTER COLUMN examid SET DEFAULT nextval('public.examtb_examid_seq'::regclass);
 <   ALTER TABLE public.examtb ALTER COLUMN examid DROP DEFAULT;
       public          postgres    false    220    219    220            k           2604    17155    mquestiontb mquestionid    DEFAULT     �   ALTER TABLE ONLY public.mquestiontb ALTER COLUMN mquestionid SET DEFAULT nextval('public.mquestiontb_mquestionid_seq'::regclass);
 F   ALTER TABLE public.mquestiontb ALTER COLUMN mquestionid DROP DEFAULT;
       public          postgres    false    222    221    222            l           2604    17168    oquestiontb oquestionid    DEFAULT     �   ALTER TABLE ONLY public.oquestiontb ALTER COLUMN oquestionid SET DEFAULT nextval('public.oquestiontb_oquestionid_seq'::regclass);
 F   ALTER TABLE public.oquestiontb ALTER COLUMN oquestionid DROP DEFAULT;
       public          postgres    false    224    223    224            h           2604    17133    subjecttb subjectid    DEFAULT     z   ALTER TABLE ONLY public.subjecttb ALTER COLUMN subjectid SET DEFAULT nextval('public.subjecttb_subjectid_seq'::regclass);
 B   ALTER TABLE public.subjecttb ALTER COLUMN subjectid DROP DEFAULT;
       public          postgres    false    215    216    216                      0    17054    answertb 
   TABLE DATA           ?   COPY public.answertb (answerid, subjectid, answer) FROM stdin;
    public          postgres    false    218   �;                 0    17110    examtb 
   TABLE DATA           W   COPY public.examtb (examid, subjectid, exam, examcontent, solutioncontent) FROM stdin;
    public          postgres    false    220   �<                 0    17182    mquestion_answertb 
   TABLE DATA           N   COPY public.mquestion_answertb (mquestionid, answerid, iscorrect) FROM stdin;
    public          postgres    false    225   ;>                 0    17152    mquestiontb 
   TABLE DATA           S   COPY public.mquestiontb (mquestionid, subjectid, question, difficulty) FROM stdin;
    public          postgres    false    222   �>                 0    17165    oquestiontb 
   TABLE DATA           ]   COPY public.oquestiontb (oquestionid, subjectid, answerid, question, difficulty) FROM stdin;
    public          postgres    false    224   �?                 0    17047 	   subjecttb 
   TABLE DATA           7   COPY public.subjecttb (subjectid, subject) FROM stdin;
    public          postgres    false    216   @       (           0    0    answertb_answerid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.answertb_answerid_seq', 16, true);
          public          postgres    false    217            )           0    0    examtb_examid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.examtb_examid_seq', 2, true);
          public          postgres    false    219            *           0    0    mquestiontb_mquestionid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.mquestiontb_mquestionid_seq', 12, true);
          public          postgres    false    221            +           0    0    oquestiontb_oquestionid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.oquestiontb_oquestionid_seq', 4, true);
          public          postgres    false    223            ,           0    0    subjecttb_subjectid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.subjecttb_subjectid_seq', 2, true);
          public          postgres    false    215            r           2606    17059    answertb answertb_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_pkey PRIMARY KEY (answerid);
 @   ALTER TABLE ONLY public.answertb DROP CONSTRAINT answertb_pkey;
       public            postgres    false    218            t           2606    17117    examtb examtb_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_pkey PRIMARY KEY (examid);
 <   ALTER TABLE ONLY public.examtb DROP CONSTRAINT examtb_pkey;
       public            postgres    false    220            z           2606    17186 *   mquestion_answertb mquestion_answertb_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_pkey PRIMARY KEY (mquestionid, answerid);
 T   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_pkey;
       public            postgres    false    225    225            v           2606    17158    mquestiontb mquestiontb_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_pkey PRIMARY KEY (mquestionid);
 F   ALTER TABLE ONLY public.mquestiontb DROP CONSTRAINT mquestiontb_pkey;
       public            postgres    false    222            x           2606    17171    oquestiontb oquestiontb_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_pkey PRIMARY KEY (oquestionid);
 F   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_pkey;
       public            postgres    false    224            p           2606    17052    subjecttb subjecttb_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.subjecttb
    ADD CONSTRAINT subjecttb_pkey PRIMARY KEY (subjectid);
 B   ALTER TABLE ONLY public.subjecttb DROP CONSTRAINT subjecttb_pkey;
       public            postgres    false    216            {           2606    17060     answertb answertb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.answertb
    ADD CONSTRAINT answertb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 J   ALTER TABLE ONLY public.answertb DROP CONSTRAINT answertb_subjectid_fkey;
       public          postgres    false    216    218    4720            |           2606    17118    examtb examtb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.examtb
    ADD CONSTRAINT examtb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 F   ALTER TABLE ONLY public.examtb DROP CONSTRAINT examtb_subjectid_fkey;
       public          postgres    false    220    4720    216            �           2606    17187 3   mquestion_answertb mquestion_answertb_answerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);
 ]   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_answerid_fkey;
       public          postgres    false    218    4722    225            �           2606    17192 6   mquestion_answertb mquestion_answertb_mquestionid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestion_answertb
    ADD CONSTRAINT mquestion_answertb_mquestionid_fkey FOREIGN KEY (mquestionid) REFERENCES public.mquestiontb(mquestionid) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.mquestion_answertb DROP CONSTRAINT mquestion_answertb_mquestionid_fkey;
       public          postgres    false    222    225    4726            }           2606    17159 &   mquestiontb mquestiontb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mquestiontb
    ADD CONSTRAINT mquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 P   ALTER TABLE ONLY public.mquestiontb DROP CONSTRAINT mquestiontb_subjectid_fkey;
       public          postgres    false    4720    216    222            ~           2606    17172 %   oquestiontb oquestiontb_answerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_answerid_fkey FOREIGN KEY (answerid) REFERENCES public.answertb(answerid);
 O   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_answerid_fkey;
       public          postgres    false    224    218    4722                       2606    17177 &   oquestiontb oquestiontb_subjectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oquestiontb
    ADD CONSTRAINT oquestiontb_subjectid_fkey FOREIGN KEY (subjectid) REFERENCES public.subjecttb(subjectid);
 P   ALTER TABLE ONLY public.oquestiontb DROP CONSTRAINT oquestiontb_subjectid_fkey;
       public          postgres    false    224    4720    216               �   x���
�0Eם��/�Ʒk�"��;7��@��$��{'����\S��6���Q�ő��>^R$v�����b�)s�u!�'� ��������;�GG�&�io�ḭ/�E�p�Ѝ$L���/�A��r҃7�)�t�)���,�������I@v�+h��(h,[jx. �A�<6         �  x���MK�@��ɯ�k/b�*ڋ��AQ�x	��f�,lgd?����V�HT
����y�g�,ɒ�0�O�Y����;��)&;.��l W�Z�x	�FX�ּVT�dO�(��,L����ᑬ*�`�������xV�j�T�k׀��c���i�d�h>&�`�ԂJ[P>�GR.�Μp^��=jG��W%����Ƅ[�b�/�B�S-\tڰ7@b�����7�6�d�&
y���$�n�{�|h��Ɍ��+܂���`H:-� 0���e#beͬ�h\7mI��TZ�;c���b����0��v�8�5�ޢ�9��	��0��)�Saʎx_���B���{�#Mk�6��_��C��`x��������ޫl|�V^?�H��4M� �ڪ         �   x�%��!��չb.��ȿ�OK1̀C��)�4j�L����g�󴻚F�av�a�34;����VC6v;���D8�N��|i�� !�>�.ԅw�LiR'�IN��ԛ㶌y��z��4O�/-O-�         �   x���;�0�ᙜ�'���*�v�ԡK�L��q�.�0Er��,d��I��;�=B��39�O.2a 
�Ul0�{��,�ڵ+�!��^��-�[�^Զ�V�"�q�RȤ�r�i{]O�G\�s��挾v�R���j����a��e�ޙiE/��{T.-�5�X5���R���6�sƝߝ��4�]         m   x�=�1� Dњ=Ŝ�
�{jw�ҤAx#,a�V��qM��Xc���o�+zQA�;���o-�M(_�Xt$˕�f���=D���I�ӭ��e��_T�s��X�LDt��$             x�3�t�/�+)�L-�2��M,������� [Ex     