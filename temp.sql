--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO bond;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO bond;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO bond;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO bond;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO bond;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO bond;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO bond;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO bond;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO bond;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO bond;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO bond;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO bond;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO bond;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO bond;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO bond;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO bond;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO bond;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO bond;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO bond;

--
-- Name: submissions_disposition; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.submissions_disposition (
    id integer NOT NULL,
    disposition character varying(30) NOT NULL
);


ALTER TABLE public.submissions_disposition OWNER TO bond;

--
-- Name: submissions_disposition_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.submissions_disposition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_disposition_id_seq OWNER TO bond;

--
-- Name: submissions_disposition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.submissions_disposition_id_seq OWNED BY public.submissions_disposition.id;


--
-- Name: submissions_publisher; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.submissions_publisher (
    id integer NOT NULL,
    publisher character varying(50) NOT NULL,
    web_address character varying(256),
    min_words integer,
    max_words integer,
    remarks text
);


ALTER TABLE public.submissions_publisher OWNER TO bond;

--
-- Name: submissions_publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.submissions_publisher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_publisher_id_seq OWNER TO bond;

--
-- Name: submissions_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.submissions_publisher_id_seq OWNED BY public.submissions_publisher.id;


--
-- Name: submissions_submission; Type: TABLE; Schema: public; Owner: bond
--

CREATE TABLE public.submissions_submission (
    id integer NOT NULL,
    story character varying(50) NOT NULL,
    word_count integer,
    file character varying(50) NOT NULL,
    date_submitted date NOT NULL,
    disposition_date date,
    disposition_id integer NOT NULL,
    publisher_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.submissions_submission OWNER TO bond;

--
-- Name: submissions_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: bond
--

CREATE SEQUENCE public.submissions_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_submission_id_seq OWNER TO bond;

--
-- Name: submissions_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bond
--

ALTER SEQUENCE public.submissions_submission_id_seq OWNED BY public.submissions_submission.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_disposition ALTER COLUMN id SET DEFAULT nextval('public.submissions_disposition_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_publisher ALTER COLUMN id SET DEFAULT nextval('public.submissions_publisher_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_submission ALTER COLUMN id SET DEFAULT nextval('public.submissions_submission_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add disposition	7	add_disposition
20	Can change disposition	7	change_disposition
21	Can delete disposition	7	delete_disposition
22	Can add publisher	8	add_publisher
23	Can change publisher	8	change_publisher
24	Can delete publisher	8	delete_publisher
25	Can add submission	9	add_submission
26	Can change submission	9	change_submission
27	Can delete submission	9	delete_submission
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 27, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$100000$pKCqe3HoUNEi$+0etaqgf2eHdZlSRpJScOcahlazlEi4rTPjVSRVrsLI=	2018-10-17 09:09:02.305837-04	f	mark	Mark	Twain	mark@twain.com	f	t	2018-09-28 15:21:04-04
1	pbkdf2_sha256$100000$rxAx1vJ4NBXn$5yytArjqSDwNU3qk+y3+5JZDkfdRrA1tBbZazqxdPXw=	2018-10-21 09:31:28.870675-04	t	bond	Bond	Elam	bond@elam.com	t	t	2018-09-27 14:53:55-04
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-09-27 15:32:43.064378-04	1	bond	2	[{"changed": {"fields": ["first_name", "last_name"]}}]	4	1
2	2018-09-28 15:21:04.580975-04	2	mark	1	[{"added": {}}]	4	1
3	2018-09-28 15:21:32.028316-04	2	mark	2	[{"changed": {"fields": ["first_name", "last_name", "email"]}}]	4	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 3, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	submissions	disposition
8	submissions	publisher
9	submissions	submission
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 9, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-09-25 16:46:06.690802-04
2	auth	0001_initial	2018-09-25 16:46:07.276204-04
3	admin	0001_initial	2018-09-25 16:46:07.410432-04
4	admin	0002_logentry_remove_auto_add	2018-09-25 16:46:07.433432-04
5	contenttypes	0002_remove_content_type_name	2018-09-25 16:46:07.521592-04
6	auth	0002_alter_permission_name_max_length	2018-09-25 16:46:07.541836-04
7	auth	0003_alter_user_email_max_length	2018-09-25 16:46:07.566695-04
8	auth	0004_alter_user_username_opts	2018-09-25 16:46:07.583871-04
9	auth	0005_alter_user_last_login_null	2018-09-25 16:46:07.608535-04
10	auth	0006_require_contenttypes_0002	2018-09-25 16:46:07.616718-04
11	auth	0007_alter_validators_add_error_messages	2018-09-25 16:46:07.637293-04
12	auth	0008_alter_user_username_max_length	2018-09-25 16:46:07.678656-04
13	auth	0009_alter_user_last_name_max_length	2018-09-25 16:46:07.737312-04
14	sessions	0001_initial	2018-09-25 16:46:07.822614-04
15	submissions	0001_initial	2018-09-28 15:41:07.202215-04
16	submissions	0002_publisher_submission	2018-09-29 16:44:28.945627-04
17	submissions	0003_auto_20180929_2107	2018-09-29 17:07:51.073111-04
18	submissions	0004_auto_20180929_2109	2018-09-29 17:09:39.39632-04
19	submissions	0005_auto_20180929_2112	2018-09-29 17:12:14.137958-04
20	submissions	0006_auto_20180929_2112	2018-09-29 17:13:00.061098-04
21	submissions	0007_auto_20180930_1748	2018-09-30 13:50:00.986506-04
22	submissions	0008_auto_20180930_1754	2018-09-30 14:04:27.63595-04
23	submissions	0009_auto_20180930_1812	2018-09-30 14:13:10.225945-04
24	submissions	0010_auto_20180930_1814	2018-09-30 14:15:11.170665-04
25	submissions	0011_submission_temp_disposition	2018-09-30 14:17:38.355989-04
26	submissions	0012_remove_submission_temp_disposition	2018-09-30 14:29:38.465554-04
27	submissions	0013_auto_20181021_1352	2018-10-21 09:53:02.46465-04
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 27, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
c68qo6u0zu49csqtns8cedsiwnvx11ev	YTIxMWY0M2NjZjkxYjlmYzVmYzk2NjE3NTc5NTMxMjY5MjhlMjJkODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmNDQzOTg0NjU5ODE5ODhkODQ0OTc5NTgyN2YyMDMwMjA2MTZmMDQ3In0=	2018-10-15 17:19:20.236801-04
\.


--
-- Data for Name: submissions_disposition; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.submissions_disposition (id, disposition) FROM stdin;
1	Rejected
2	Sold
3	Rework
4	Submitted
5	Available
6	Withdrawn
7	Unsure
8	Needs Update
\.


--
-- Name: submissions_disposition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.submissions_disposition_id_seq', 9, true);


--
-- Data for Name: submissions_publisher; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.submissions_publisher (id, publisher, web_address, min_words, max_words, remarks) FROM stdin;
1	Analog	http://www.analogsf.com/contact-us/writers-guidelines/	\N	\N	
2	F&SF	https://www.sfsite.com/fsf/glines.htm	\N	25000	F&SF has no formula for fiction. The speculative element may be slight, but it should be present.
3	Azimov's	http://www.asimovs.com/contact-us/writers-guidelines/	1000	20000	
4	Daily Science Fiction	http://dailysciencefiction.com/submit/story/guidelines	100	1500	We need short short fiction, especially flash fiction. Among our featured stories, a shorter tale will get an extra nudge on the scale when weighed against a longer one..
5	Strange Horizons	http://www.strangehorizons.com/guidelines/fiction.php	0	10000	Prefer under 5000 words. Opening to submissions March 6, 2017,
6	Clark's World	http://clarkesworldmagazine.com/submissions/	1000	16000	Responds within 48 hours.
7	Interzone	http://ttapress.com/interzone/guidelines/	\N	10000	UK magazine.
8	Alfred Hitchcock	https://www.themysteryplace.com/ahmm/guidelines/	\N	12000	
9	Apex	http://www.apex-magazine.com/submission-guidelines/	\N	7500	Currently open to submissoins. Takes about 30 days to respond.
10	Flash Fiction Online	http://flashfictiononline.com/main/submission-guidelines/	500	1000	No personal info in manuscript. Times Roman, not Courier. Automatic paragraph indents.
11	Fantastic Stories	http://www.fantasticstoriesoftheimagination.com/submission-guidelines/	\N	3000	Closed to submissions 4/4/17.We want stories that cover the entire science fiction and fantasy spectrum. We love everything from magic realism to hard SF. We want a story to surprise us and to take us to unexpected places. We love word play, and would like to see stories with a literary bent, though decidedly not a pretentious bent.
12	Lightspeed Magazine	http://www.lightspeedmagazine.com/about/guidelines/	1500	10000	Accepts 1,500 to 10,000 words. Prefers under 5000 words. Open as of 4/24/17, but only to Fantasy, not Science Fiction.
13	Beneath Ceaseless Skys	http://www.beneath-ceaseless-skies.com/submissions/	11000	\N	Secondary-World Setting: We want stories set in what Tolkien called a “secondary world”: some other world that is different from our own primary world in some way. It could be different in terms of zoology (non-human creatures), ecology (climate), or physical laws (the presence of magic). It could be set on Earth but an Earth different from our primary world in terms of time (the historical past) or history (alternate history). 
14	Terraform 	http://motherboard.vice.com/read/how-to-submit-stories-to-terraform	\N	2000	We're looking especially for nearer-future fiction; think a bit more along the lines of sentient chat bots or climate-changed dystopias and less far-flung alien space opera
15	Escape Pod	http://escapepod.org/guidelines/	2000	6000	We are fairly flexible on what counts as “science” (as we’ll delve into superheroes or steampunk on occasion) and are interested in exploring the range of the genre, but we are not looking for fantasy, magical realism, or more than a tinge of horror.  If your story isn’t centered on science, technology, future projections, alternate history, and how any or all of these things intersect with people, we’re probably not the right market for it.
16	Ellery Queen Mystery Magazine	https://www.themysteryplace.com/eqmm/guidelines/	250	8000	EQMM uses stories of almost every length. 2,500-8,000 words is the preferred range, but we occasionally use stories of up to 12,000 words and we feature one or two short novels (up to 20,000 words) each year, although these spaces are usually reserved for established writers. Shorter stories are also considered, including minute mysteries of as little as 250 words. Our rates for original stories are from 5 to 8 ¢ a word, sometimes higher for established authors.
17	Eric Miller	raging@earthlink.net	2500	5000	For a book to be titled 18 Wheels of Science Fiction
18	Allan Kaster	http://www.audiotexttapes.net/	\N	\N	atxtapes@gmail.comsold Chatter of Monkeys
20	Yet one more publisher	wwww	44	33	remark..............
24	PPPPPPPP	\N	\N	\N	
\.


--
-- Name: submissions_publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.submissions_publisher_id_seq', 24, true);


--
-- Data for Name: submissions_submission; Type: TABLE DATA; Schema: public; Owner: bond
--

COPY public.submissions_submission (id, story, word_count, file, date_submitted, disposition_date, disposition_id, publisher_id, user_id) FROM stdin;
225	Mark Twain Story #1	21111	mark.docx	2018-10-16	\N	7	7	2
218	A good Story	1234	very_good.docx	2018-10-07	\N	7	9	1
226	Another Twain Story	4000	twainathome.docx	2018-10-16	\N	1	9	2
115	Quark Soup	\N	Reboot.19.doc	2008-05-25	2008-05-25	1	1	1
212	A Test Story	2222	FingerPrints.41.docx	2018-10-06	\N	3	3	1
217	A good Story	1234	good.docx	2018-10-07	\N	7	9	1
221	Good Good Story	10000	good.docx	2018-10-08	\N	4	1	1
37	The Perils of Poetic License	\N	TimeMachine.18.doc	2002-09-06	2002-09-06	1	2	1
38	The Perils of Poetic License	\N	TimeMachine.18.doc	2002-09-24	2002-09-24	1	1	1
40	A Familiar Story	\N	Mariposa.15.doc	2002-10-26	2002-10-26	1	2	1
41	Marshland Melodies	\N	Exploitation.11.doc	2002-10-28	2002-10-28	1	3	1
42	A Familiar Story	\N	Mariposa.16.doc	2002-12-18	2002-12-18	1	3	1
43	When Might Meets Right	\N	FutureRivals.09.doc	2002-12-18	2002-12-18	1	2	1
44	All That Rises	\N	FutureDroid.41.doc	2002-12-23	2002-12-23	1	1	1
45	Marshland Melodies	\N	Exploitation.12.doc	2002-12-23	2002-12-23	1	1	1
46	When Might Meets Right	\N	FutureRivals.11.doc	2003-01-10	2003-01-10	1	1	1
47	Contingent Liability	\N	Worry.09.doc	2003-01-10	2003-01-10	1	2	1
48	Contingent Liability	\N	Worry.10.doc	2003-01-21	2003-01-21	1	1	1
49	A Kiss from the Queen	\N	Dyslexia.33.doc	2003-09-04	2003-09-04	1	2	1
50	A Kiss from the Queen	\N	Dyslexia.34.doc	2003-09-18	2003-09-18	1	3	1
51	Keepers of the Quantum Foam	\N	Awakening.36.doc	2003-09-24	2003-09-24	1	2	1
52	Keepers of the Quantum Foam	\N	Awakening.37.doc	2003-09-30	2003-09-30	1	3	1
53	A Kiss from the Queen	\N	Dyslexia.35.doc	2004-01-05	2004-01-05	1	1	1
54	Keepers of the Quantum Foam	\N	Awakening.39.doc	2004-02-02	2004-02-02	1	1	1
55	Remembrance of Things to Come	\N	NecessaryMortality.29.doc	2004-02-02	2004-02-02	1	2	1
56	Remembrance of Things to Come	\N	NecessaryMortality.30.doc	2004-02-11	2004-02-11	1	1	1
57	Verba Verde	\N	Mirror.14.doc	2004-02-17	2004-02-17	1	2	1
58	Verba Verde	\N	Mirror.15.doc	2004-02-25	2004-02-25	1	1	1
59	The Honesty of Aldebarans	\N	TimeMachine.24.doc	2004-03-02	2004-03-02	1	1	1
60	Remembrance of Things to Come	\N	NecessaryMortality.30.doc	2004-03-11	2004-03-11	1	3	1
61	The Book of Mildred	\N	FieldsOfLord.37.doc	2004-06-24	2004-06-24	1	2	1
62	The Honesty of Aldebarans	\N	TimeMachine.28.doc	2004-06-30	2004-06-30	1	2	1
63	The Honesty of Aldebarans	\N	TimeMachine.30.doc	2004-07-29	2004-07-29	1	1	1
64	Objects in the Mirror May Not Be There at All	\N	Perturbation.21.doc.	2004-07-29	2004-07-29	1	2	1
65	The Book of Mildred	\N	FieldsOfLord.38.doc	2004-07-30	2004-07-30	1	1	1
66	The Big Reboot	\N	Perturbation.27.doc	2004-08-18	2004-08-18	1	1	1
67	The Many Names of Technology	\N	Worry.19.doc	2004-09-07	2004-09-07	1	1	1
68	The Eighth Deadly Sin	\N	Dopamine.35.doc	2005-03-03	2005-03-03	1	2	1
69	The Big Reboot	\N	Perturbation.28.doc	2005-03-07	2005-03-07	1	1	1
70	A Matter of Perception	\N	Worry.30.doc	2005-03-29	2005-03-29	1	2	1
71	The Eighth Deadly Sin	\N	Dopamine.36.doc	2005-03-30	2005-03-30	1	3	1
72	A Kiss from the Queen	\N	Dyslexia.39.doc	2005-04-28	2005-04-28	1	2	1
73	A Kiss from the Queen	\N	Dyslexia.40.doc	2005-05-11	2005-05-11	1	3	1
74	The Blue-Eyed Brunette	\N	KillingGramps.22.doc	2005-05-23	2005-05-23	1	2	1
75	A Matter of Perception	\N	Worry.34.doc	2005-05-25	2005-05-25	1	1	1
76	The Eighth Deadly Sin	\N	Dopamine.37.doc	2005-05-25	2005-05-25	1	1	1
77	The Book of Mildred	\N	FieldsOfLord.42.doc	2005-06-01	2005-06-01	1	2	1
78	The Case of the Blue-Eyed Brunette	\N	KillingGramps.23.doc	2005-06-03	2005-06-03	1	1	1
79	The Book of Mildred	\N	FieldsOfLord.43.doc	2005-06-14	2005-06-14	1	1	1
80	Design Defect	\N	Hominid.16.doc	2005-07-08	2005-07-08	1	2	1
81	A Kiss from the Queen	\N	Dyslexia.41.doc	2005-07-11	2005-07-11	1	1	1
82	The Book of Mildred	\N	FieldsOfLord.44.doc	2005-07-11	2005-07-11	1	3	1
83	The Eighth Deadly Sin	\N	Dopamine.42.doc	2005-07-20	2005-07-20	1	3	1
84	The Piper's Dream	\N	BlinkAgain.30.doc	2005-07-24	2005-07-24	1	1	1
85	Design Defect	\N	Hominid.17.doc	2005-08-02	2005-08-02	1	1	1
86	Design Defect	\N	Hominid.18.doc 	2005-11-03	2005-11-03	1	3	1
87	Deus Ex Machina	\N	Evolution.34.doc	2005-11-03	2005-11-03	1	2	1
88	Deus Ex Machina	\N	Evolution.35.doc	2005-11-18	2005-11-18	1	1	1
89	Life Everlasting	\N	LifeEverlasting.38.doc	2006-01-06	2006-01-06	1	2	1
90	Deus Ex Machina	\N	Evolution.35.doc	2006-02-02	2006-02-02	1	3	1
91	Life Everlasting	\N	LifeEverlasting.39.doc	2006-02-08	2006-02-08	1	3	1
92	Loose Ends	\N	TippingPoint.24.doc	2006-03-02	2006-03-02	1	2	1
93	Loose Ends	\N	TippingPoint.25.doc	2006-03-17	2006-03-17	1	1	1
94	Loose Ends	\N	TippingPoint.25.doc	2006-04-21	2006-04-21	1	3	1
95	Cat Box Capers	\N	Schrodinger.22.doc	2006-04-21	2006-04-21	1	2	1
96	The Lessons of History	\N	Columbus.20.doc	2006-05-10	2006-05-10	1	2	1
97	Cat Box Capers	\N	Schrodinger.23.doc	2006-05-11	2006-05-11	1	1	1
98	Life Everlasting	\N	LifeEverlasting.40.doc	2006-05-17	2006-05-17	1	1	1
99	The Lessons of History	\N	Columbus.22.doc	2006-05-23	2006-05-23	1	1	1
100	War Dogs	\N	Chromosomes.20.doc	2006-09-06	2006-09-06	1	1	1
101	The Other Problem with Time Travel	\N	NewTimeMachine.22.doc	2006-09-23	2006-09-23	1	1	1
102	Patent Pending	\N	MyGenes.15.doc	2006-10-19	2006-10-19	1	1	1
103	Evolution	\N	FutureBots.40.doc	2007-03-13	2007-03-13	1	1	1
104	The Lessons of History	\N	Columbus.24.doc	2007-03-19	2007-03-19	1	2	1
105	War Dogs	\N	Chromosomes.21.doc	2007-03-21	2007-03-21	1	2	1
106	War Dogs	\N	Chromosomes.21.doc	2007-04-02	2007-04-02	1	3	1
107	Patent Pending	\N	MyGenes.20.doc	2007-04-02	2007-04-02	1	2	1
108	Tangle	\N	SecondChance.34.doc	2007-08-01	2007-08-01	1	1	1
109	Patent Pending	\N	MyGenes.20.doc	2007-08-21	2007-08-21	1	3	1
110	A Plethora of Truth	\N	SoulGene.18.doc	2007-08-21	2007-08-21	1	2	1
111	A Plethora of Truth	\N	SoulGene.20.doc	2007-08-30	2007-08-30	2	1	1
112	The Emperor's Moon	\N	DinoDemise.32.doc	2008-01-14	2008-01-14	1	1	1
113	Keepers of the Quantum Foam	\N	Awakening.50.doc	2008-01-31	2008-01-31	1	1	1
114	The Case of the Disconnected Wife	\N	HouseOfCards.30.doc	2008-05-13	2008-05-13	1	1	1
116	The Other Problem with Time Travel	1000	NewTimeMachine.24.doc	2008-05-28	2008-05-28	1	3	1
117	Evolution	\N	FutureBots.41.doc	2008-05-28	2008-05-28	1	2	1
118	The Anunnaki's Legacy	\N	Blame.40.docx	2009-01-15	2009-01-15	1	1	1
119	Quark Soup	\N	Reboot.35.docx	2009-02-09	2009-02-09	2	1	1
120	The Anunnaki Legacy	\N	Blame.48.docx	2009-06-07	2009-06-07	1	1	1
121	The Little Bang Theory	\N	TimeTheory.20.docx	2009-07-21	2009-07-21	1	1	1
122	The Anunnaki Legacy	\N	Blame.54.docx	2009-08-07	2009-08-07	2	1	1
123	Entitlement	\N	ImmortalityInc.40.docx	2010-01-23	2010-01-23	1	1	1
124	Blind Spot	\N	Memories.40.docx	2010-06-08	2010-06-08	2	1	1
125	Life Everlasting	\N	MoreImmortal.46.docx	2011-01-06	2011-01-06	1	1	1
126	Instinctive Response	\N	SanityVirus.43.docx	2012-01-26	2012-01-26	1	1	1
127	Instinctive Response	\N	SanityVirus.48.docx	2012-03-18	2012-03-18	2	1	1
128	Bag of Bones	\N	Inevitability.64.docx	2012-09-17	2012-09-17	1	1	1
129	Smartphones	\N	Extension.10.docx	2012-10-07	2012-10-07	1	1	1
130	Flying by Wire	\N	FermiBot.17.docx	2013-01-13	2013-01-13	1	1	1
131	Persistence of Illusion	\N	FingerPrints.28.docx	2013-05-25	2013-05-25	1	1	1
132	Unconditional Love	\N	Adjustment.19.docx	2013-12-01	2013-12-01	1	1	1
133	The Eighth Iteration	\N	RobotRebirth.51.docx	2014-02-12	2014-02-12	2	1	1
134	A Switch in Time	\N	Congruence.30.docx	2014-06-09	2014-06-09	1	2	1
135	Dreams of Spanish Gold	\N	Mariposa.33.docx	2014-06-27	2014-06-27	1	2	1
136	Old Bones	\N	Inevitability.75.docx	2014-07-18	2014-07-18	1	2	1
137	Dreams of Spanish Gold	\N	Mariposa.34.docx	2014-07-23	2014-07-23	1	5	1
138	Tracks in Time	\N	Congruence.39.docx	2014-08-15	2014-08-15	1	1	1
139	Dreams of Spanish Gold	\N	Mariposa.33.docx	2014-08-15	2014-08-15	1	6	1
140	Dreams of Spanish Gold	\N	Mariposa.34.docx 	2014-08-17	2014-08-17	2	1	1
141	Persistence of Illusion	\N	FingerPrints.41.docx	2014-09-10	2014-09-10	1	2	1
142	Persistence of Illusion	\N	FingerPrints.42.docx	2014-10-28	2014-10-28	1	6	1
143	Persistence of Illusion	\N	FingerPrints.41.docx	2014-10-31	2014-10-31	1	3	1
144	Old Bones	7700	Inevitability.76.docx	2014-11-01	2014-11-01	1	1	1
145	Persistence of Illusion	\N	FingerPrints.42.docx	2014-12-25	2014-12-25	1	7	1
146	Entangled Lives	\N	ShipGoesHuman.36.docx	2014-12-31	2016-02-01	6	1	1
147	Persistence of Illusion	\N	FingerPrints.42.docx	2015-01-04	2015-01-04	1	8	1
148	Heads in the Cloud	\N	Consciousness.18.docx	2015-02-18	2015-02-18	1	2	1
149	Pinch Points	\N	Congruence.58.docx	2015-04-14	2015-04-14	1	2	1
151	Pinch Points	\N	Congruence.58.docx	2015-05-05	2015-05-05	1	7	1
152	Heads in the Cloud	\N	Consciousness.29.docx	2015-05-06	2015-05-06	1	3	1
153	Pinch Points	\N	Congruence.58.docx	2015-05-07	2015-05-07	1	1	1
154	The Chatter of Monkeys	\N	SafeWorld.32.doc	2015-11-18	2015-11-18	1	2	1
155	The Chatter of Monkeys	6700	SafeWorld.32.doc	2015-11-20	2015-11-20	1	3	1
156	Persistence of Illusion	6700	FingerPrints.42.docx	2015-11-21	2015-11-21	1	5	1
157	Deus ex Machina	2800	Evolution.37.docx	2015-12-01	2015-12-01	1	6	1
213	Yet another story	11111	ffffff	2018-10-06	\N	3	4	1
159	El Pajaro	6700	Pajaro.040.docx	2015-12-03	2015-12-03	5	2	1
161	Snake in the Grass	900	Snake.26.docx	2016-01-02	2016-01-02	1	6	1
163	Snake in the Grass	900	Snake.29.docx	2016-01-08	2016-01-08	1	4	1
167	Heads in the Cloud	6700	Consciousness.30.docx	2016-01-25	2016-02-12	1	7	1
168	The Lessons of History	2100	ColumbusAgain.04.docx	2016-02-08	2016-02-10	5	2	1
169	The Chatter of Monkeys	5900	SafeWorld.42.docx	2016-02-08	2016-07-14	2	1	1
174	A Safer World	900	FixerUppers.13.docx	2015-11-30	2001-11-30	1	4	1
175	Sanctuary	6200	JurassicBot.28.docx	2016-07-05	2016-07-08	1	2	1
176	Sanctuary	7200	JurassicBot.41.docx	2016-09-19	2016-09-20	1	6	1
178	Theater of the Mind	4600	cube.33.docx	2016-12-23	2016-12-29	1	2	1
180	Sanctuary (as Theater)	7400	JurassicBot.45.docx	2017-01-21	2016-01-27	1	7	1
182	A Minor Miscalculation	844	NewTimeMachine.26.docx	2017-01-21	2017-02-03	1	4	1
184	Theater of the Mind	4700	cube.41.docx	2017-03-05	2017-03-06	1	6	1
185	Theater of the Mind	4700	cube.41.docx	2017-03-06	2017-03-26	1	5	1
186	Sanctuary	7400	JurassicBot.46.docx	2017-03-15	2017-07-07	1	3	1
187	Fine Euning	992	aviatrix.20.docx	2017-04-23	2017-05-13	1	4	1
188	Fine Tuning	1000	Aviatrix.21.docx	2017-06-05	2017-06-11	1	2	1
189	El Pajaro	6600	Pajaro.042.docx	2017-06-07	2017-06-08	1	6	1
190	Sanctuary	4700	JurassicBot.46.docx	2017-07-11	2018-02-26	1	1	1
191	Theater of the Mind	4700	cube.41.docx	2017-07-13	2017-08-02	1	3	1
193	Unmarked Bills	6600	DogDay.17.docx	2017-09-05	\N	4	8	1
194	Fine Tuning	1400	Aviatrix.26.docx	2017-09-15	2017-09-16	1	6	1
195	Fine Tuning	1400	Aviatrix.26.docx	2017-09-16	2017-10-31	1	3	1
196	Voices from the Past	4800	BotHappy.60.docx	2017-09-21	2017-09-22	1	2	1
197	Voices from the Past	4200	BotHappy.61.docx	2017-09-25	2017-09-26	1	6	1
199	Fine Tuning	1400	Aviatrix.26.docx	2017-11-25	2018-02-26	2	1	1
200	Voices from the Past	4200	BotHappy.61.docx	2017-11-25	2018-02-12	1	3	1
202	A Day in the Cloud	6900	Consciousness.42.docx	2017-12-11	2017-12-17	1	2	1
203	A Day in the Cloud	6900	Consciousness.42.docx	2018-01-19	2018-01-20	1	6	1
205	In Reykjavik	4800	HarrysRibbon.16.docx	2018-02-28	2018-03-07	1	2	1
206	Voices from the Past	4200	BotHappy.61.docx	2018-02-28	2018-08-07	1	1	1
207	A Day in the Cloud	6900	Consciousness.42.docx	2018-02-28	2018-03-01	1	3	1
1	El Pajaro	\N	pajaro.010	1998-08-08	1998-08-08	1	1	1
2	Birds of Prey	\N	colony.010	1999-06-29	1999-06-29	1	2	1
3	El Pajaro	\N	pajaro.010	1999-06-29	1999-06-29	1	2	1
4	Mariposa	\N	mariposa.010	1999-06-29	1999-06-29	1	2	1
5	Birds of Prey	\N	colony.010	1999-07-15	1999-07-15	1	3	1
6	El Pajaro	\N	pajaro.010	1999-07-15	1999-07-15	1	3	1
7	Mariposa	\N	mariposa.010	1999-07-15	1999-07-15	1	3	1
8	Practical Application	\N	gabriela.010	1999-08-30	1999-08-30	1	2	1
9	Birds of Prey	\N	colony.010	1999-09-03	1999-09-03	1	1	1
10	Mariposa	\N	mariposa.010	1999-09-03	1999-09-03	1	1	1
11	Practical Application	\N	gabriela.010	1999-09-30	1999-09-30	1	1	1
12	Calamari Connection	\N	spider.030.doc	1999-10-05	1999-10-05	1	3	1
13	Calamari Connection	\N	spider.030.doc	2000-03-01	2000-03-01	1	1	1
14	Leap of Faith	\N	yellow.040.doc	2000-03-10	2000-03-10	1	2	1
15	Leap of Faith	\N	yellow.040.doc	2000-03-21	2000-03-21	1	1	1
16	The Creator's Image	\N	Creator.030.doc	2000-08-18	2000-08-18	1	2	1
17	The Creator's Image	\N	Creator.030.doc	2000-09-06	2000-09-06	1	1	1
18	My Blue Gnu	\N	Wildebeest.28.doc	2000-11-30	2000-11-30	1	2	1
19	The Perils of Precision	\N	TimeMachine.030.doc	2000-12-11	2000-12-11	1	1	1
20	The Tabby Factor	\N	AlienVotes.070.doc	2001-01-05	2001-01-05	1	1	1
21	It's Not Nice to Fool with Father Time	\N	LittleChanges.090.doc	2001-01-23	2001-01-23	1	1	1
22	The Lady in White	\N	FamousArtist.070.doc	2001-03-05	2001-03-05	1	1	1
23	It's Not Nice to Fool with Father Time	\N	LittleChanges.090.doc	2001-03-05	2001-03-05	1	3	1
24	The Perils of Precision	\N	TimeMachine.030.doc	2001-03-05	2001-03-05	1	2	1
25	The Tabby Factor	\N	AlienVotes.070.doc	2001-03-19	2001-03-19	1	2	1
26	The Piper's Dream	\N	Blink.120.doc	2001-05-02	2001-05-02	1	2	1
27	The Piper's Dream	\N	Blink.130.doc	2001-05-09	2001-05-09	1	3	1
28	The Lady in White	\N	FamousArtist.080.doc	2001-05-12	2001-05-12	1	2	1
29	My Blue Gnu	\N	Wildebeest.30.doc	2001-07-16	2001-07-16	1	2	1
31	A Bolt From the Blue	\N	SupplyDemand.09.doc	2002-01-30	2002-01-30	1	2	1
32	The Piper's Dream	\N	Blink.140.doc	2002-03-13	2002-03-13	1	1	1
33	Verba Verde	\N	SupplyDemand.10.doc	2002-03-13	2002-03-13	1	3	1
34	Game of Life	\N	GameOfLife.33.doc	2002-03-13	2002-03-13	1	2	1
35	All That Rises	\N	FutureDroid.36.doc	2002-08-19	2002-08-19	1	2	1
36	All That Rises	\N	FutureDroid.37.doc	2002-09-06	2002-09-06	1	3	1
39	Marshland Melodies	\N	Exploitation.11.doc	2002-09-24	2002-09-24	1	2	1
209	In Reykjavik	4800	HarrysRibbon.16.docx	2018-03-14	2018-03-24	1	3	1
211	In Reykjavik	4600	HarrysRibbon16.docx	2018-04-21	2018-07-06	1	1	1
\.


--
-- Name: submissions_submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bond
--

SELECT pg_catalog.setval('public.submissions_submission_id_seq', 226, true);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: submissions_disposition_disposition_key; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_disposition
    ADD CONSTRAINT submissions_disposition_disposition_key UNIQUE (disposition);


--
-- Name: submissions_disposition_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_disposition
    ADD CONSTRAINT submissions_disposition_pkey PRIMARY KEY (id);


--
-- Name: submissions_publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_publisher
    ADD CONSTRAINT submissions_publisher_pkey PRIMARY KEY (id);


--
-- Name: submissions_publisher_publisher_key; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_publisher
    ADD CONSTRAINT submissions_publisher_publisher_key UNIQUE (publisher);


--
-- Name: submissions_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_submission
    ADD CONSTRAINT submissions_submission_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: submissions_disposition_disposition_df7fd0a1_like; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX submissions_disposition_disposition_df7fd0a1_like ON public.submissions_disposition USING btree (disposition varchar_pattern_ops);


--
-- Name: submissions_publisher_publisher_b8bb7dfa_like; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX submissions_publisher_publisher_b8bb7dfa_like ON public.submissions_publisher USING btree (publisher varchar_pattern_ops);


--
-- Name: submissions_submission_disposition_id_036185f0; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX submissions_submission_disposition_id_036185f0 ON public.submissions_submission USING btree (disposition_id);


--
-- Name: submissions_submission_publisher_id_504ac9ba; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX submissions_submission_publisher_id_504ac9ba ON public.submissions_submission USING btree (publisher_id);


--
-- Name: submissions_submission_user_id_f185a147; Type: INDEX; Schema: public; Owner: bond
--

CREATE INDEX submissions_submission_user_id_f185a147 ON public.submissions_submission USING btree (user_id);


--
-- Name: auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submissions_submissi_disposition_id_036185f0_fk_submissio; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_submission
    ADD CONSTRAINT submissions_submissi_disposition_id_036185f0_fk_submissio FOREIGN KEY (disposition_id) REFERENCES public.submissions_disposition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submissions_submissi_publisher_id_504ac9ba_fk_submissio; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_submission
    ADD CONSTRAINT submissions_submissi_publisher_id_504ac9ba_fk_submissio FOREIGN KEY (publisher_id) REFERENCES public.submissions_publisher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submissions_submission_user_id_f185a147_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bond
--

ALTER TABLE ONLY public.submissions_submission
    ADD CONSTRAINT submissions_submission_user_id_f185a147_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

