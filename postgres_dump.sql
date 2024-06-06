--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6 (Ubuntu 15.6-1.pgdg22.04+1)
-- Dumped by pg_dump version 15.6 (Ubuntu 15.6-1.pgdg22.04+1)

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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: sofa
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO sofa;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: country; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.country (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    external_id integer NOT NULL
);


ALTER TABLE public.country OWNER TO sofa;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO sofa;

--
-- Name: event; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.event (
    id integer NOT NULL,
    tournament_id integer NOT NULL,
    home_team_id integer NOT NULL,
    away_team_id integer NOT NULL,
    home_score_id integer,
    away_score_id integer,
    slug character varying(255) NOT NULL,
    start_date timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    round integer NOT NULL,
    status character varying(255) NOT NULL,
    winner_code character varying(255) DEFAULT NULL::character varying,
    external_id integer NOT NULL
);


ALTER TABLE public.event OWNER TO sofa;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO sofa;

--
-- Name: incident; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.incident (
    id integer NOT NULL,
    player_id integer NOT NULL,
    team_side character varying(255) NOT NULL,
    color character varying(255) NOT NULL,
    "time" integer NOT NULL,
    type character varying(255) NOT NULL,
    external_id integer NOT NULL
);


ALTER TABLE public.incident OWNER TO sofa;

--
-- Name: incident_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_id_seq OWNER TO sofa;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO sofa;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messenger_messages_id_seq OWNER TO sofa;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sofa
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: player; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.player (
    id integer NOT NULL,
    country_id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    external_id integer NOT NULL
);


ALTER TABLE public.player OWNER TO sofa;

--
-- Name: player_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_id_seq OWNER TO sofa;

--
-- Name: score; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.score (
    id integer NOT NULL,
    total integer,
    period1 integer,
    period2 integer,
    period3 integer,
    period4 integer,
    overtime integer,
    external_id integer NOT NULL
);


ALTER TABLE public.score OWNER TO sofa;

--
-- Name: score_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.score_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.score_id_seq OWNER TO sofa;

--
-- Name: sport; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.sport (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    external_id integer NOT NULL
);


ALTER TABLE public.sport OWNER TO sofa;

--
-- Name: sport_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.sport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sport_id_seq OWNER TO sofa;

--
-- Name: team; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.team (
    id integer NOT NULL,
    country_id integer NOT NULL,
    name character varying(255) NOT NULL,
    manager_name character varying(255) DEFAULT NULL::character varying,
    venue character varying(255) DEFAULT NULL::character varying,
    external_id integer NOT NULL
);


ALTER TABLE public.team OWNER TO sofa;

--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_id_seq OWNER TO sofa;

--
-- Name: tournament; Type: TABLE; Schema: public; Owner: sofa
--

CREATE TABLE public.tournament (
    id integer NOT NULL,
    sport_id integer NOT NULL,
    country_id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    external_id integer NOT NULL
);


ALTER TABLE public.tournament OWNER TO sofa;

--
-- Name: tournament_id_seq; Type: SEQUENCE; Schema: public; Owner: sofa
--

CREATE SEQUENCE public.tournament_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_id_seq OWNER TO sofa;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.country (id, name, external_id) FROM stdin;
1	England	70
2	Croatia	56
3	Spain	218
4	USA	239
5	Canada	41
6	Canada	41
7	Canada	41
8	Canada	41
9	Canada	41
10	Canada	41
11	Canada	41
12	Canada	41
13	Canada	41
14	Canada	41
15	Canada	41
16	Canada	41
17	Canada	41
18	Canada	41
19	Canada	41
20	Canada	41
21	Canada	41
22	Canada	41
23	Canada	41
24	Canada	41
25	Canada	41
26	Canada	41
27	Canada	41
28	Canada	41
29	Canada	41
30	Canada	41
31	Canada	41
32	Canada	41
33	Canada	41
34	Canada	41
35	Canada	41
36	Canada	41
37	Canada	41
38	Canada	41
39	Canada	41
40	Canada	41
41	Canada	41
42	Canada	41
43	Canada	41
44	Canada	41
45	Canada	41
46	Canada	41
47	Canada	41
48	Canada	41
49	Canada	41
50	Canada	41
51	Canada	41
52	Canada	41
53	Canada	41
54	Canada	41
55	Canada	41
56	Canada	41
57	Canada	41
58	Canada	41
59	Canada	41
60	Canada	41
61	Canada	41
62	Canada	41
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.event (id, tournament_id, home_team_id, away_team_id, home_score_id, away_score_id, slug, start_date, round, status, winner_code, external_id) FROM stdin;
2	1	3	4	3	4	manchester-united-fulham	2024-05-18 17:40:00	20	finished	draw	2
4	1	7	8	7	8	tottenham-hotspur-everton	2024-05-18 14:00:00	20	finished	home	4
5	1	9	10	9	10	burnley-crystal-palace	2024-01-06 16:50:00	1	finished	away	5
6	1	11	12	11	12	crystal-palace-burnley	2024-05-18 12:50:00	20	finished	away	6
7	1	13	14	13	14	west-ham-united-luton-town	2024-01-06 11:40:00	1	finished	away	7
8	1	15	16	15	16	luton-town-west-ham-united	2024-05-18 15:50:00	20	finished	draw	8
9	1	17	18	17	18	brighton-and-hove-albion-liverpool	2024-01-06 12:00:00	1	finished	home	9
10	1	19	20	19	20	liverpool-brighton-and-hove-albion	2024-05-18 19:30:00	20	finished	away	10
11	1	21	22	21	22	chelsea-sheffield-united	2024-01-07 19:50:00	1	finished	home	11
12	1	23	24	23	24	sheffield-united-chelsea	2024-05-19 16:00:00	20	finished	home	12
13	1	25	26	25	26	brentford-bournemouth	2024-01-07 16:50:00	1	finished	draw	13
14	1	27	28	27	28	bournemouth-brentford	2024-05-19 11:30:00	20	finished	away	14
15	1	29	30	29	30	newcastle-united-arsenal	2024-01-07 18:10:00	1	finished	home	15
16	1	31	32	31	32	arsenal-newcastle-united	2024-05-19 13:00:00	20	finished	draw	16
17	1	33	34	33	34	aston-villa-nottingham-forest	2024-01-07 16:20:00	1	finished	draw	17
18	1	35	36	35	36	nottingham-forest-aston-villa	2024-05-19 10:00:00	20	finished	home	18
19	1	37	38	37	38	wolverhampton-manchester-city	2024-01-07 16:00:00	1	finished	draw	19
20	1	39	40	39	40	manchester-city-wolverhampton	2024-05-19 12:00:00	20	finished	away	20
21	1	41	42	41	42	nottingham-forest-sheffield-united	2024-01-13 14:40:00	2	finished	draw	21
22	1	43	44	43	44	sheffield-united-nottingham-forest	2024-05-25 13:50:00	21	finished	away	22
23	1	45	46	45	46	liverpool-manchester-united	2024-01-13 18:30:00	2	finished	away	23
24	1	47	48	47	48	manchester-united-liverpool	2024-05-25 14:20:00	21	finished	draw	24
25	1	49	50	49	50	wolverhampton-luton-town	2024-01-13 12:10:00	2	finished	home	25
26	1	51	52	51	52	luton-town-wolverhampton	2024-05-25 14:50:00	21	finished	home	26
27	1	53	54	53	54	brighton-and-hove-albion-newcastle-united	2024-01-13 13:50:00	2	finished	away	27
28	1	55	56	55	56	newcastle-united-brighton-and-hove-albion	2024-05-25 12:00:00	21	finished	away	28
29	1	57	58	57	58	brentford-fulham	2024-01-13 10:40:00	2	finished	home	29
30	1	59	60	59	60	fulham-brentford	2024-05-25 15:00:00	21	finished	away	30
31	1	61	62	61	62	aston-villa-west-ham-united	2024-01-14 18:30:00	2	finished	home	31
32	1	63	64	63	64	west-ham-united-aston-villa	2024-05-26 10:50:00	21	finished	draw	32
33	1	65	66	65	66	crystal-palace-tottenham-hotspur	2024-01-14 15:20:00	2	finished	away	33
34	1	67	68	67	68	tottenham-hotspur-crystal-palace	2024-05-26 19:10:00	21	finished	home	34
35	1	69	70	69	70	bournemouth-chelsea	2024-01-14 12:50:00	2	finished	away	35
36	1	71	72	71	72	chelsea-bournemouth	2024-05-26 11:30:00	21	finished	away	36
37	1	73	74	73	74	burnley-arsenal	2024-01-14 17:10:00	2	finished	away	37
38	1	75	76	75	76	arsenal-burnley	2024-05-26 19:10:00	21	finished	home	38
39	1	77	78	77	78	manchester-city-everton	2024-01-14 19:50:00	2	finished	draw	39
40	1	79	80	79	80	everton-manchester-city	2024-05-26 18:20:00	21	finished	home	40
41	1	81	82	81	82	brighton-and-hove-albion-manchester-city	2024-01-20 15:10:00	3	finished	home	41
42	1	83	84	83	84	manchester-city-brighton-and-hove-albion	2024-06-01 14:10:00	22	notstarted	\N	42
43	1	85	86	85	86	aston-villa-everton	2024-01-20 15:40:00	3	finished	draw	43
44	1	87	88	87	88	everton-aston-villa	2024-06-01 19:00:00	22	notstarted	\N	44
45	1	89	90	89	90	liverpool-bournemouth	2024-01-20 12:40:00	3	finished	away	45
46	1	91	92	91	92	bournemouth-liverpool	2024-06-01 18:50:00	22	notstarted	\N	46
47	1	93	94	93	94	manchester-united-brentford	2024-01-20 19:30:00	3	finished	home	47
48	1	95	96	95	96	brentford-manchester-united	2024-06-01 16:50:00	22	notstarted	\N	48
49	1	97	98	97	98	luton-town-sheffield-united	2024-01-20 17:50:00	3	finished	home	49
50	1	99	100	99	100	sheffield-united-luton-town	2024-06-01 17:40:00	22	notstarted	\N	50
51	1	101	102	101	102	tottenham-hotspur-burnley	2024-01-21 15:00:00	3	finished	away	51
52	1	103	104	103	104	burnley-tottenham-hotspur	2024-06-02 17:20:00	22	notstarted	\N	52
53	1	105	106	105	106	nottingham-forest-chelsea	2024-01-21 13:10:00	3	finished	away	53
54	1	107	108	107	108	chelsea-nottingham-forest	2024-06-02 18:20:00	22	notstarted	\N	54
55	1	109	110	109	110	crystal-palace-west-ham-united	2024-01-21 18:20:00	3	finished	home	55
56	1	111	112	111	112	west-ham-united-crystal-palace	2024-06-02 17:20:00	22	notstarted	\N	56
57	1	113	114	113	114	newcastle-united-wolverhampton	2024-01-21 18:20:00	3	finished	home	57
58	1	115	116	115	116	wolverhampton-newcastle-united	2024-06-02 13:00:00	22	notstarted	\N	58
59	1	117	118	117	118	fulham-arsenal	2024-01-21 13:10:00	3	finished	away	59
60	1	119	120	119	120	arsenal-fulham	2024-06-02 13:50:00	22	notstarted	\N	60
61	1	121	122	121	122	burnley-aston-villa	2024-01-27 10:20:00	4	finished	away	61
62	1	123	124	123	124	aston-villa-burnley	2024-06-08 14:40:00	23	notstarted	\N	62
63	1	125	126	125	126	manchester-united-west-ham-united	2024-01-27 17:50:00	4	finished	draw	63
64	1	127	128	127	128	west-ham-united-manchester-united	2024-06-08 14:50:00	23	notstarted	\N	64
65	1	129	130	129	130	arsenal-manchester-city	2024-01-27 18:10:00	4	finished	draw	65
66	1	131	132	131	132	manchester-city-arsenal	2024-06-08 18:30:00	23	notstarted	\N	66
67	1	133	134	133	134	fulham-luton-town	2024-01-27 11:30:00	4	finished	home	67
68	1	135	136	135	136	luton-town-fulham	2024-06-08 19:50:00	23	notstarted	\N	68
69	1	137	138	137	138	tottenham-hotspur-nottingham-forest	2024-01-27 13:50:00	4	finished	draw	69
70	1	139	140	139	140	nottingham-forest-tottenham-hotspur	2024-06-08 19:00:00	23	notstarted	\N	70
1	2	1	2	1	2	vukasin-milorad	2024-05-29 22:48:00	2	ongoing	home	1
71	1	141	142	141	142	newcastle-united-chelsea	2024-01-28 13:10:00	4	finished	home	71
72	1	143	144	143	144	chelsea-newcastle-united	2024-06-09 15:00:00	23	notstarted	\N	72
73	1	145	146	145	146	bournemouth-wolverhampton	2024-01-28 12:10:00	4	finished	home	73
74	1	147	148	147	148	wolverhampton-bournemouth	2024-06-09 10:20:00	23	notstarted	\N	74
75	1	149	150	149	150	everton-liverpool	2024-01-28 11:40:00	4	finished	home	75
76	1	151	152	151	152	liverpool-everton	2024-06-09 15:50:00	23	notstarted	\N	76
77	1	153	154	153	154	brighton-and-hove-albion-crystal-palace	2024-01-28 15:20:00	4	finished	away	77
78	1	155	156	155	156	crystal-palace-brighton-and-hove-albion	2024-06-09 11:10:00	23	notstarted	\N	78
79	1	157	158	157	158	brentford-sheffield-united	2024-01-28 18:40:00	4	finished	home	79
80	1	159	160	159	160	sheffield-united-brentford	2024-06-09 19:00:00	23	notstarted	\N	80
81	1	161	162	161	162	manchester-united-chelsea	2024-02-03 13:10:00	5	finished	home	81
82	1	163	164	163	164	chelsea-manchester-united	2024-06-15 18:20:00	24	notstarted	\N	82
83	1	165	166	165	166	everton-west-ham-united	2024-02-03 19:00:00	5	finished	away	83
84	1	167	168	167	168	west-ham-united-everton	2024-06-15 13:20:00	24	notstarted	\N	84
85	1	169	170	169	170	newcastle-united-manchester-city	2024-02-03 14:50:00	5	finished	away	85
86	1	171	172	171	172	manchester-city-newcastle-united	2024-06-15 17:10:00	24	notstarted	\N	86
87	1	173	174	173	174	brentford-liverpool	2024-02-03 10:30:00	5	finished	away	87
88	1	175	176	175	176	liverpool-brentford	2024-06-15 16:10:00	24	notstarted	\N	88
89	1	177	178	177	178	arsenal-sheffield-united	2024-02-03 13:20:00	5	finished	home	89
90	1	179	180	179	180	sheffield-united-arsenal	2024-06-15 13:20:00	24	notstarted	\N	90
91	1	181	182	181	182	aston-villa-tottenham-hotspur	2024-02-04 17:30:00	5	finished	draw	91
92	1	183	184	183	184	tottenham-hotspur-aston-villa	2024-06-16 16:10:00	24	notstarted	\N	92
93	1	185	186	185	186	bournemouth-burnley	2024-02-04 16:50:00	5	finished	home	93
94	1	187	188	187	188	burnley-bournemouth	2024-06-16 15:00:00	24	notstarted	\N	94
95	1	189	190	189	190	nottingham-forest-fulham	2024-02-04 14:20:00	5	finished	home	95
96	1	191	192	191	192	fulham-nottingham-forest	2024-06-16 13:00:00	24	notstarted	\N	96
97	1	193	194	193	194	brighton-and-hove-albion-wolverhampton	2024-02-04 17:40:00	5	finished	away	97
98	1	195	196	195	196	wolverhampton-brighton-and-hove-albion	2024-06-16 19:30:00	24	notstarted	\N	98
99	1	197	198	197	198	luton-town-crystal-palace	2024-02-04 16:00:00	5	finished	away	99
100	1	199	200	199	200	crystal-palace-luton-town	2024-06-16 18:20:00	24	notstarted	\N	100
101	1	201	202	201	202	brighton-and-hove-albion-luton-town	2024-02-10 14:20:00	6	finished	away	101
102	1	203	204	203	204	luton-town-brighton-and-hove-albion	2024-06-22 16:30:00	25	notstarted	\N	102
103	1	205	206	205	206	west-ham-united-liverpool	2024-02-10 12:00:00	6	finished	home	103
104	1	207	208	207	208	liverpool-west-ham-united	2024-06-22 19:50:00	25	notstarted	\N	104
105	1	209	210	209	210	tottenham-hotspur-wolverhampton	2024-02-10 12:40:00	6	finished	home	105
106	1	211	212	211	212	wolverhampton-tottenham-hotspur	2024-06-22 16:00:00	25	notstarted	\N	106
107	1	213	214	213	214	newcastle-united-nottingham-forest	2024-02-10 16:50:00	6	finished	draw	107
108	1	215	216	215	216	nottingham-forest-newcastle-united	2024-06-22 18:10:00	25	notstarted	\N	108
109	1	217	218	217	218	manchester-city-bournemouth	2024-02-10 10:10:00	6	finished	away	109
110	1	219	220	219	220	bournemouth-manchester-city	2024-06-22 10:40:00	25	notstarted	\N	110
111	1	221	222	221	222	fulham-crystal-palace	2024-02-11 18:00:00	6	finished	away	111
112	1	223	224	223	224	crystal-palace-fulham	2024-06-23 15:20:00	25	notstarted	\N	112
113	1	225	226	225	226	aston-villa-arsenal	2024-02-11 18:40:00	6	finished	away	113
114	1	227	228	227	228	arsenal-aston-villa	2024-06-23 15:00:00	25	notstarted	\N	114
115	1	229	230	229	230	everton-burnley	2024-02-11 19:50:00	6	finished	home	115
116	1	231	232	231	232	burnley-everton	2024-06-23 16:20:00	25	notstarted	\N	116
117	1	233	234	233	234	manchester-united-sheffield-united	2024-02-11 17:20:00	6	finished	away	117
118	1	235	236	235	236	sheffield-united-manchester-united	2024-06-23 17:50:00	25	notstarted	\N	118
119	1	237	238	237	238	chelsea-brentford	2024-02-11 16:30:00	6	finished	home	119
120	1	239	240	239	240	brentford-chelsea	2024-06-23 18:50:00	25	notstarted	\N	120
121	1	241	242	241	242	sheffield-united-aston-villa	2024-02-17 16:50:00	7	finished	home	121
122	1	243	244	243	244	aston-villa-sheffield-united	2024-06-29 14:50:00	26	notstarted	\N	122
123	1	245	246	245	246	arsenal-crystal-palace	2024-02-17 18:40:00	7	finished	draw	123
124	1	247	248	247	248	crystal-palace-arsenal	2024-06-29 11:00:00	26	notstarted	\N	124
125	1	249	250	249	250	fulham-newcastle-united	2024-02-17 15:40:00	7	finished	away	125
126	1	251	252	251	252	newcastle-united-fulham	2024-06-29 12:00:00	26	notstarted	\N	126
127	1	253	254	253	254	bournemouth-luton-town	2024-02-17 15:00:00	7	finished	draw	127
128	1	255	256	255	256	luton-town-bournemouth	2024-06-29 19:50:00	26	notstarted	\N	128
129	1	257	258	257	258	nottingham-forest-manchester-city	2024-02-17 18:40:00	7	finished	draw	129
130	1	259	260	259	260	manchester-city-nottingham-forest	2024-06-29 12:00:00	26	notstarted	\N	130
131	1	261	262	261	262	everton-brentford	2024-02-18 18:50:00	7	finished	home	131
132	1	263	264	263	264	brentford-everton	2024-06-30 19:10:00	26	notstarted	\N	132
133	1	265	266	265	266	chelsea-brighton-and-hove-albion	2024-02-18 10:00:00	7	finished	home	133
134	1	267	268	267	268	brighton-and-hove-albion-chelsea	2024-06-30 16:40:00	26	notstarted	\N	134
135	1	269	270	269	270	west-ham-united-wolverhampton	2024-02-18 17:50:00	7	finished	home	135
136	1	271	272	271	272	wolverhampton-west-ham-united	2024-06-30 18:00:00	26	notstarted	\N	136
137	1	273	274	273	274	burnley-manchester-united	2024-02-18 18:40:00	7	finished	home	137
138	1	275	276	275	276	manchester-united-burnley	2024-06-30 18:10:00	26	notstarted	\N	138
139	1	277	278	277	278	tottenham-hotspur-liverpool	2024-02-18 12:50:00	7	finished	home	139
140	1	279	280	279	280	liverpool-tottenham-hotspur	2024-06-30 13:50:00	26	notstarted	\N	140
141	1	281	282	281	282	tottenham-hotspur-luton-town	2024-02-24 14:50:00	8	finished	home	141
142	1	283	284	283	284	luton-town-tottenham-hotspur	2024-07-06 14:40:00	27	notstarted	\N	142
143	1	285	286	285	286	brighton-and-hove-albion-fulham	2024-02-24 12:50:00	8	finished	home	143
144	1	287	288	287	288	fulham-brighton-and-hove-albion	2024-07-06 19:40:00	27	notstarted	\N	144
145	1	289	290	289	290	manchester-city-crystal-palace	2024-02-24 16:10:00	8	finished	draw	145
146	1	291	292	291	292	crystal-palace-manchester-city	2024-07-06 18:20:00	27	notstarted	\N	146
147	1	293	294	293	294	west-ham-united-burnley	2024-02-24 10:00:00	8	finished	away	147
148	1	295	296	295	296	burnley-west-ham-united	2024-07-06 18:00:00	27	notstarted	\N	148
149	1	297	298	297	298	wolverhampton-brentford	2024-02-24 19:30:00	8	finished	home	149
150	1	299	300	299	300	brentford-wolverhampton	2024-07-06 15:50:00	27	notstarted	\N	150
151	1	301	302	301	302	sheffield-united-everton	2024-02-25 18:10:00	8	finished	away	151
152	1	303	304	303	304	everton-sheffield-united	2024-07-07 17:40:00	27	notstarted	\N	152
153	1	305	306	305	306	nottingham-forest-arsenal	2024-02-25 10:20:00	8	finished	away	153
154	1	307	308	307	308	arsenal-nottingham-forest	2024-07-07 19:10:00	27	notstarted	\N	154
155	1	309	310	309	310	aston-villa-bournemouth	2024-02-25 19:20:00	8	finished	home	155
156	1	311	312	311	312	bournemouth-aston-villa	2024-07-07 19:00:00	27	notstarted	\N	156
157	1	313	314	313	314	chelsea-liverpool	2024-02-25 14:20:00	8	finished	draw	157
158	1	315	316	315	316	liverpool-chelsea	2024-07-07 17:10:00	27	notstarted	\N	158
159	1	317	318	317	318	newcastle-united-manchester-united	2024-02-25 12:40:00	8	finished	away	159
160	1	319	320	319	320	manchester-united-newcastle-united	2024-07-07 19:10:00	27	notstarted	\N	160
161	1	321	322	321	322	burnley-sheffield-united	2024-03-02 14:40:00	9	finished	away	161
162	1	323	324	323	324	sheffield-united-burnley	2024-07-13 15:30:00	28	notstarted	\N	162
163	1	325	326	325	326	nottingham-forest-everton	2024-03-02 19:30:00	9	finished	draw	163
164	1	327	328	327	328	everton-nottingham-forest	2024-07-13 12:40:00	28	notstarted	\N	164
165	1	329	330	329	330	west-ham-united-manchester-city	2024-03-02 13:10:00	9	finished	draw	165
166	1	331	332	331	332	manchester-city-west-ham-united	2024-07-13 11:10:00	28	notstarted	\N	166
167	1	333	334	333	334	manchester-united-crystal-palace	2024-03-02 17:10:00	9	finished	away	167
168	1	335	336	335	336	crystal-palace-manchester-united	2024-07-13 17:50:00	28	notstarted	\N	168
169	1	337	338	337	338	bournemouth-brighton-and-hove-albion	2024-03-02 10:40:00	9	finished	draw	169
170	1	339	340	339	340	brighton-and-hove-albion-bournemouth	2024-07-13 14:20:00	28	notstarted	\N	170
171	1	341	342	341	342	tottenham-hotspur-chelsea	2024-03-03 10:50:00	9	finished	away	171
172	1	343	344	343	344	chelsea-tottenham-hotspur	2024-07-14 17:40:00	28	notstarted	\N	172
173	1	345	346	345	346	arsenal-wolverhampton	2024-03-03 17:30:00	9	finished	draw	173
174	1	347	348	347	348	wolverhampton-arsenal	2024-07-14 11:40:00	28	notstarted	\N	174
175	1	349	350	349	350	liverpool-newcastle-united	2024-03-03 12:20:00	9	finished	home	175
176	1	351	352	351	352	newcastle-united-liverpool	2024-07-14 12:40:00	28	notstarted	\N	176
177	1	353	354	353	354	luton-town-brentford	2024-03-03 16:00:00	9	finished	away	177
178	1	355	356	355	356	brentford-luton-town	2024-07-14 15:10:00	28	notstarted	\N	178
179	1	357	358	357	358	aston-villa-fulham	2024-03-03 13:40:00	9	finished	away	179
180	1	359	360	359	360	fulham-aston-villa	2024-07-14 14:20:00	28	notstarted	\N	180
181	1	361	362	361	362	chelsea-manchester-city	2024-03-09 17:50:00	10	finished	draw	181
182	1	363	364	363	364	manchester-city-chelsea	2024-07-20 12:00:00	29	notstarted	\N	182
183	1	365	366	365	366	luton-town-nottingham-forest	2024-03-09 10:00:00	10	finished	away	183
184	1	367	368	367	368	nottingham-forest-luton-town	2024-07-20 13:10:00	29	notstarted	\N	184
185	1	369	370	369	370	burnley-fulham	2024-03-09 12:30:00	10	finished	away	185
186	1	371	372	371	372	fulham-burnley	2024-07-20 10:10:00	29	notstarted	\N	186
187	1	373	374	373	374	sheffield-united-tottenham-hotspur	2024-03-09 16:30:00	10	finished	home	187
188	1	375	376	375	376	tottenham-hotspur-sheffield-united	2024-07-20 10:30:00	29	notstarted	\N	188
189	1	377	378	377	378	brighton-and-hove-albion-west-ham-united	2024-03-09 12:40:00	10	finished	draw	189
190	1	379	380	379	380	west-ham-united-brighton-and-hove-albion	2024-07-20 17:40:00	29	notstarted	\N	190
191	1	381	382	381	382	everton-wolverhampton	2024-03-10 10:30:00	10	finished	draw	191
192	1	383	384	383	384	wolverhampton-everton	2024-07-21 17:20:00	29	notstarted	\N	192
193	1	385	386	385	386	brentford-arsenal	2024-03-10 14:30:00	10	finished	away	193
194	1	387	388	387	388	arsenal-brentford	2024-07-21 15:10:00	29	notstarted	\N	194
195	1	389	390	389	390	liverpool-aston-villa	2024-03-10 17:10:00	10	finished	draw	195
196	1	391	392	391	392	aston-villa-liverpool	2024-07-21 16:30:00	29	notstarted	\N	196
197	1	393	394	393	394	crystal-palace-newcastle-united	2024-03-10 11:50:00	10	finished	home	197
198	1	395	396	395	396	newcastle-united-crystal-palace	2024-07-21 11:30:00	29	notstarted	\N	198
199	1	397	398	397	398	bournemouth-manchester-united	2024-03-10 19:50:00	10	finished	home	199
200	1	399	400	399	400	manchester-united-bournemouth	2024-07-21 14:20:00	29	notstarted	\N	200
201	1	401	402	401	402	manchester-city-burnley	2024-03-16 18:40:00	11	finished	away	201
202	1	403	404	403	404	burnley-manchester-city	2024-07-27 16:00:00	30	notstarted	\N	202
203	1	405	406	405	406	bournemouth-arsenal	2024-03-16 17:30:00	11	finished	away	203
204	1	407	408	407	408	arsenal-bournemouth	2024-07-27 15:10:00	30	notstarted	\N	204
205	1	409	410	409	410	sheffield-united-west-ham-united	2024-03-16 13:20:00	11	finished	home	205
206	1	411	412	411	412	west-ham-united-sheffield-united	2024-07-27 15:30:00	30	notstarted	\N	206
207	1	413	414	413	414	newcastle-united-brentford	2024-03-16 15:00:00	11	finished	away	207
208	1	415	416	415	416	brentford-newcastle-united	2024-07-27 11:00:00	30	notstarted	\N	208
209	1	417	418	417	418	aston-villa-crystal-palace	2024-03-16 15:30:00	11	finished	draw	209
210	1	419	420	419	420	crystal-palace-aston-villa	2024-07-27 14:20:00	30	notstarted	\N	210
211	1	421	422	421	422	wolverhampton-nottingham-forest	2024-03-17 12:20:00	11	finished	draw	211
212	1	423	424	423	424	nottingham-forest-wolverhampton	2024-07-28 13:50:00	30	notstarted	\N	212
213	1	425	426	425	426	luton-town-liverpool	2024-03-17 12:20:00	11	finished	home	213
214	1	427	428	427	428	liverpool-luton-town	2024-07-28 17:30:00	30	notstarted	\N	214
215	1	429	430	429	430	manchester-united-brighton-and-hove-albion	2024-03-17 11:10:00	11	finished	away	215
216	1	431	432	431	432	brighton-and-hove-albion-manchester-united	2024-07-28 13:20:00	30	notstarted	\N	216
217	1	433	434	433	434	everton-chelsea	2024-03-17 18:10:00	11	finished	home	217
218	1	435	436	435	436	chelsea-everton	2024-07-28 10:10:00	30	notstarted	\N	218
219	1	437	438	437	438	fulham-tottenham-hotspur	2024-03-17 17:10:00	11	finished	draw	219
220	1	439	440	439	440	tottenham-hotspur-fulham	2024-07-28 17:10:00	30	notstarted	\N	220
221	1	441	442	441	442	newcastle-united-aston-villa	2024-03-23 19:50:00	12	finished	away	221
222	1	443	444	443	444	aston-villa-newcastle-united	2024-08-03 18:30:00	31	notstarted	\N	222
223	1	445	446	445	446	tottenham-hotspur-manchester-city	2024-03-23 15:30:00	12	finished	away	223
224	1	447	448	447	448	manchester-city-tottenham-hotspur	2024-08-03 19:50:00	31	notstarted	\N	224
225	1	449	450	449	450	nottingham-forest-burnley	2024-03-23 13:10:00	12	finished	away	225
226	1	451	452	451	452	burnley-nottingham-forest	2024-08-03 10:50:00	31	notstarted	\N	226
227	1	453	454	453	454	brighton-and-hove-albion-everton	2024-03-23 18:30:00	12	finished	home	227
228	1	455	456	455	456	everton-brighton-and-hove-albion	2024-08-03 14:50:00	31	notstarted	\N	228
229	1	457	458	457	458	liverpool-fulham	2024-03-23 19:30:00	12	finished	away	229
230	1	459	460	459	460	fulham-liverpool	2024-08-03 13:50:00	31	notstarted	\N	230
231	1	461	462	461	462	luton-town-chelsea	2024-03-24 13:30:00	12	finished	draw	231
232	1	463	464	463	464	chelsea-luton-town	2024-08-04 16:00:00	31	notstarted	\N	232
233	1	465	466	465	466	arsenal-manchester-united	2024-03-24 19:00:00	12	finished	home	233
234	1	467	468	467	468	manchester-united-arsenal	2024-08-04 17:20:00	31	notstarted	\N	234
235	1	469	470	469	470	brentford-crystal-palace	2024-03-24 19:50:00	12	finished	home	235
236	1	471	472	471	472	crystal-palace-brentford	2024-08-04 11:50:00	31	notstarted	\N	236
237	1	473	474	473	474	wolverhampton-sheffield-united	2024-03-24 10:40:00	12	finished	draw	237
238	1	475	476	475	476	sheffield-united-wolverhampton	2024-08-04 16:40:00	31	notstarted	\N	238
239	1	477	478	477	478	bournemouth-west-ham-united	2024-03-24 11:20:00	12	finished	home	239
240	1	479	480	479	480	west-ham-united-bournemouth	2024-08-04 17:20:00	31	notstarted	\N	240
241	1	481	482	481	482	luton-town-arsenal	2024-03-30 16:50:00	13	finished	home	241
242	1	483	484	483	484	arsenal-luton-town	2024-08-10 15:10:00	32	notstarted	\N	242
243	1	485	486	485	486	tottenham-hotspur-west-ham-united	2024-03-30 16:00:00	13	finished	draw	243
244	1	487	488	487	488	west-ham-united-tottenham-hotspur	2024-08-10 13:40:00	32	notstarted	\N	244
245	1	489	490	489	490	bournemouth-newcastle-united	2024-03-30 10:50:00	13	finished	away	245
246	1	491	492	491	492	newcastle-united-bournemouth	2024-08-10 17:10:00	32	notstarted	\N	246
247	1	493	494	493	494	brighton-and-hove-albion-aston-villa	2024-03-30 13:20:00	13	finished	away	247
248	1	495	496	495	496	aston-villa-brighton-and-hove-albion	2024-08-10 10:30:00	32	notstarted	\N	248
249	1	497	498	497	498	fulham-wolverhampton	2024-03-30 15:30:00	13	finished	home	249
250	1	499	500	499	500	wolverhampton-fulham	2024-08-10 16:50:00	32	notstarted	\N	250
251	1	501	502	501	502	manchester-united-everton	2024-03-31 19:10:00	13	finished	home	251
252	1	503	504	503	504	everton-manchester-united	2024-08-11 17:50:00	32	notstarted	\N	252
253	1	505	506	505	506	liverpool-crystal-palace	2024-03-31 15:40:00	13	finished	home	253
254	1	507	508	507	508	crystal-palace-liverpool	2024-08-11 17:20:00	32	notstarted	\N	254
255	1	509	510	509	510	burnley-chelsea	2024-03-31 17:30:00	13	finished	away	255
256	1	511	512	511	512	chelsea-burnley	2024-08-11 13:50:00	32	notstarted	\N	256
257	1	513	514	513	514	manchester-city-sheffield-united	2024-03-31 10:10:00	13	finished	home	257
258	1	515	516	515	516	sheffield-united-manchester-city	2024-08-11 15:20:00	32	notstarted	\N	258
259	1	517	518	517	518	brentford-nottingham-forest	2024-03-31 13:20:00	13	finished	draw	259
260	1	519	520	519	520	nottingham-forest-brentford	2024-08-11 14:00:00	32	notstarted	\N	260
261	1	521	522	521	522	fulham-manchester-city	2024-04-06 12:50:00	14	finished	draw	261
262	1	523	524	523	524	manchester-city-fulham	2024-08-17 18:40:00	33	notstarted	\N	262
263	1	525	526	525	526	arsenal-liverpool	2024-04-06 18:50:00	14	finished	draw	263
264	1	527	528	527	528	liverpool-arsenal	2024-08-17 14:30:00	33	notstarted	\N	264
265	1	529	530	529	530	aston-villa-wolverhampton	2024-04-06 16:40:00	14	finished	away	265
266	1	531	532	531	532	wolverhampton-aston-villa	2024-08-17 13:10:00	33	notstarted	\N	266
267	1	533	534	533	534	brentford-burnley	2024-04-06 12:20:00	14	finished	draw	267
268	1	535	536	535	536	burnley-brentford	2024-08-17 16:40:00	33	notstarted	\N	268
269	1	537	538	537	538	everton-crystal-palace	2024-04-06 19:30:00	14	finished	away	269
270	1	539	540	539	540	crystal-palace-everton	2024-08-17 12:20:00	33	notstarted	\N	270
271	1	541	542	541	542	nottingham-forest-bournemouth	2024-04-07 14:50:00	14	finished	away	271
272	1	543	544	543	544	bournemouth-nottingham-forest	2024-08-18 14:20:00	33	notstarted	\N	272
273	1	545	546	545	546	manchester-united-tottenham-hotspur	2024-04-07 15:20:00	14	finished	home	273
274	1	547	548	547	548	tottenham-hotspur-manchester-united	2024-08-18 13:40:00	33	notstarted	\N	274
275	1	549	550	549	550	brighton-and-hove-albion-sheffield-united	2024-04-07 16:00:00	14	finished	home	275
276	1	551	552	551	552	sheffield-united-brighton-and-hove-albion	2024-08-18 16:00:00	33	notstarted	\N	276
277	1	553	554	553	554	chelsea-west-ham-united	2024-04-07 18:30:00	14	finished	away	277
278	1	555	556	555	556	west-ham-united-chelsea	2024-08-18 13:30:00	33	notstarted	\N	278
279	1	557	558	557	558	luton-town-newcastle-united	2024-04-07 15:50:00	14	finished	draw	279
280	1	559	560	559	560	newcastle-united-luton-town	2024-08-18 12:20:00	33	notstarted	\N	280
281	1	561	562	561	562	chelsea-aston-villa	2024-04-13 14:30:00	15	finished	home	281
282	1	563	564	563	564	aston-villa-chelsea	2024-08-24 17:30:00	34	notstarted	\N	282
283	1	565	566	565	566	manchester-united-luton-town	2024-04-13 12:40:00	15	finished	draw	283
284	1	567	568	567	568	luton-town-manchester-united	2024-08-24 18:10:00	34	notstarted	\N	284
285	1	569	570	569	570	brentford-brighton-and-hove-albion	2024-04-13 16:50:00	15	finished	draw	285
286	1	571	572	571	572	brighton-and-hove-albion-brentford	2024-08-24 17:30:00	34	notstarted	\N	286
287	1	573	574	573	574	west-ham-united-fulham	2024-04-13 14:20:00	15	finished	away	287
288	1	575	576	575	576	fulham-west-ham-united	2024-08-24 16:40:00	34	notstarted	\N	288
289	1	577	578	577	578	burnley-wolverhampton	2024-04-13 17:30:00	15	finished	home	289
290	1	579	580	579	580	wolverhampton-burnley	2024-08-24 18:10:00	34	notstarted	\N	290
291	1	581	582	581	582	arsenal-tottenham-hotspur	2024-04-14 14:50:00	15	finished	home	291
292	1	583	584	583	584	tottenham-hotspur-arsenal	2024-08-25 18:20:00	34	notstarted	\N	292
293	1	585	586	585	586	newcastle-united-sheffield-united	2024-04-14 11:50:00	15	finished	away	293
294	1	587	588	587	588	sheffield-united-newcastle-united	2024-08-25 17:50:00	34	notstarted	\N	294
295	1	589	590	589	590	liverpool-manchester-city	2024-04-14 13:20:00	15	finished	away	295
296	1	591	592	591	592	manchester-city-liverpool	2024-08-25 15:20:00	34	notstarted	\N	296
297	1	593	594	593	594	everton-bournemouth	2024-04-14 18:10:00	15	finished	draw	297
298	1	595	596	595	596	bournemouth-everton	2024-08-25 13:10:00	34	notstarted	\N	298
299	1	597	598	597	598	crystal-palace-nottingham-forest	2024-04-14 16:30:00	15	finished	away	299
300	1	599	600	599	600	nottingham-forest-crystal-palace	2024-08-25 19:00:00	34	notstarted	\N	300
301	1	601	602	601	602	burnley-brighton-and-hove-albion	2024-04-20 19:20:00	16	finished	away	301
302	1	603	604	603	604	brighton-and-hove-albion-burnley	2024-08-31 12:50:00	35	notstarted	\N	302
303	1	605	606	605	606	arsenal-everton	2024-04-20 19:40:00	16	finished	away	303
304	1	607	608	607	608	everton-arsenal	2024-08-31 11:20:00	35	notstarted	\N	304
305	1	609	610	609	610	brentford-manchester-city	2024-04-20 11:20:00	16	finished	home	305
306	1	611	612	611	612	manchester-city-brentford	2024-08-31 15:00:00	35	notstarted	\N	306
307	1	613	614	613	614	nottingham-forest-manchester-united	2024-04-20 18:20:00	16	finished	draw	307
308	1	615	616	615	616	manchester-united-nottingham-forest	2024-08-31 19:30:00	35	notstarted	\N	308
309	1	617	618	617	618	tottenham-hotspur-bournemouth	2024-04-20 10:20:00	16	finished	home	309
310	1	619	620	619	620	bournemouth-tottenham-hotspur	2024-08-31 14:00:00	35	notstarted	\N	310
311	1	621	622	621	622	west-ham-united-newcastle-united	2024-04-21 10:10:00	16	finished	away	311
312	1	623	624	623	624	newcastle-united-west-ham-united	2024-09-01 15:20:00	35	notstarted	\N	312
313	1	625	626	625	626	liverpool-wolverhampton	2024-04-21 16:50:00	16	finished	home	313
314	1	627	628	627	628	wolverhampton-liverpool	2024-09-01 16:50:00	35	notstarted	\N	314
315	1	629	630	629	630	fulham-chelsea	2024-04-21 16:10:00	16	finished	away	315
316	1	631	632	631	632	chelsea-fulham	2024-09-01 10:00:00	35	notstarted	\N	316
317	1	633	634	633	634	crystal-palace-sheffield-united	2024-04-21 11:40:00	16	finished	away	317
318	1	635	636	635	636	sheffield-united-crystal-palace	2024-09-01 12:30:00	35	notstarted	\N	318
319	1	637	638	637	638	aston-villa-luton-town	2024-04-21 12:00:00	16	finished	home	319
320	1	639	640	639	640	luton-town-aston-villa	2024-09-01 17:40:00	35	notstarted	\N	320
321	1	641	642	641	642	aston-villa-manchester-united	2024-04-27 13:20:00	17	finished	home	321
322	1	643	644	643	644	manchester-united-aston-villa	2024-09-07 18:20:00	36	notstarted	\N	322
323	1	645	646	645	646	brighton-and-hove-albion-tottenham-hotspur	2024-04-27 19:10:00	17	finished	draw	323
324	1	647	648	647	648	tottenham-hotspur-brighton-and-hove-albion	2024-09-07 19:20:00	36	notstarted	\N	324
325	1	649	650	649	650	brentford-west-ham-united	2024-04-27 18:50:00	17	finished	draw	325
326	1	651	652	651	652	west-ham-united-brentford	2024-09-07 13:30:00	36	notstarted	\N	326
327	1	653	654	653	654	crystal-palace-wolverhampton	2024-04-27 15:40:00	17	finished	away	327
328	1	655	656	655	656	wolverhampton-crystal-palace	2024-09-07 10:30:00	36	notstarted	\N	328
329	1	657	658	657	658	burnley-newcastle-united	2024-04-27 12:10:00	17	finished	away	329
330	1	659	660	659	660	newcastle-united-burnley	2024-09-07 18:40:00	36	notstarted	\N	330
331	1	661	662	661	662	manchester-city-luton-town	2024-04-28 16:30:00	17	finished	away	331
332	1	663	664	663	664	luton-town-manchester-city	2024-09-08 13:20:00	36	notstarted	\N	332
333	1	665	666	665	666	bournemouth-sheffield-united	2024-04-28 18:40:00	17	finished	away	333
334	1	667	668	667	668	sheffield-united-bournemouth	2024-09-08 13:20:00	36	notstarted	\N	334
335	1	669	670	669	670	arsenal-chelsea	2024-04-28 13:10:00	17	finished	away	335
336	1	671	672	671	672	chelsea-arsenal	2024-09-08 14:40:00	36	notstarted	\N	336
337	1	673	674	673	674	liverpool-nottingham-forest	2024-04-28 18:30:00	17	finished	home	337
338	1	675	676	675	676	nottingham-forest-liverpool	2024-09-08 17:30:00	36	notstarted	\N	338
339	1	677	678	677	678	fulham-everton	2024-04-28 16:00:00	17	finished	home	339
340	1	679	680	679	680	everton-fulham	2024-09-08 11:30:00	36	notstarted	\N	340
341	1	681	682	681	682	crystal-palace-bournemouth	2024-05-04 16:00:00	18	finished	away	341
342	1	683	684	683	684	bournemouth-crystal-palace	2024-09-14 17:00:00	37	notstarted	\N	342
343	1	685	686	685	686	tottenham-hotspur-newcastle-united	2024-05-04 12:00:00	18	finished	home	343
344	1	687	688	687	688	newcastle-united-tottenham-hotspur	2024-09-14 19:20:00	37	notstarted	\N	344
345	1	689	690	689	690	arsenal-west-ham-united	2024-05-04 18:50:00	18	finished	home	345
346	1	691	692	691	692	west-ham-united-arsenal	2024-09-14 16:50:00	37	notstarted	\N	346
347	1	693	694	693	694	fulham-sheffield-united	2024-05-04 18:30:00	18	finished	draw	347
348	1	695	696	695	696	sheffield-united-fulham	2024-09-14 17:40:00	37	notstarted	\N	348
349	1	697	698	697	698	everton-luton-town	2024-05-04 13:20:00	18	finished	draw	349
350	1	699	700	699	700	luton-town-everton	2024-09-14 11:40:00	37	notstarted	\N	350
351	1	701	702	701	702	manchester-united-manchester-city	2024-05-05 17:30:00	18	finished	home	351
352	1	703	704	703	704	manchester-city-manchester-united	2024-09-15 11:50:00	37	notstarted	\N	352
353	1	705	706	705	706	burnley-liverpool	2024-05-05 18:30:00	18	finished	draw	353
354	1	707	708	707	708	liverpool-burnley	2024-09-15 14:40:00	37	notstarted	\N	354
355	1	709	710	709	710	wolverhampton-chelsea	2024-05-05 18:50:00	18	finished	home	355
356	1	711	712	711	712	chelsea-wolverhampton	2024-09-15 18:50:00	37	notstarted	\N	356
357	1	713	714	713	714	aston-villa-brentford	2024-05-05 19:20:00	18	finished	draw	357
358	1	715	716	715	716	brentford-aston-villa	2024-09-15 16:50:00	37	notstarted	\N	358
359	1	717	718	717	718	nottingham-forest-brighton-and-hove-albion	2024-05-05 13:30:00	18	finished	draw	359
360	1	719	720	719	720	brighton-and-hove-albion-nottingham-forest	2024-09-15 17:40:00	37	notstarted	\N	360
361	1	721	722	721	722	fulham-bournemouth	2024-05-11 11:10:00	19	finished	draw	361
362	1	723	724	723	724	bournemouth-fulham	2024-09-21 19:20:00	38	notstarted	\N	362
363	1	725	726	725	726	wolverhampton-manchester-united	2024-05-11 13:00:00	19	finished	away	363
364	1	727	728	727	728	manchester-united-wolverhampton	2024-09-21 13:50:00	38	notstarted	\N	364
365	1	729	730	729	730	brentford-tottenham-hotspur	2024-05-11 13:50:00	19	finished	draw	365
366	1	731	732	731	732	tottenham-hotspur-brentford	2024-09-21 17:00:00	38	notstarted	\N	366
367	1	733	734	733	734	brighton-and-hove-albion-arsenal	2024-05-11 17:30:00	19	finished	draw	367
368	1	735	736	735	736	arsenal-brighton-and-hove-albion	2024-09-21 17:40:00	38	notstarted	\N	368
369	1	737	738	737	738	west-ham-united-nottingham-forest	2024-05-11 12:10:00	19	finished	draw	369
370	1	739	740	739	740	nottingham-forest-west-ham-united	2024-09-21 18:10:00	38	notstarted	\N	370
371	1	741	742	741	742	crystal-palace-chelsea	2024-05-12 17:30:00	19	finished	home	371
372	1	743	744	743	744	chelsea-crystal-palace	2024-09-22 14:10:00	38	notstarted	\N	372
373	1	745	746	745	746	newcastle-united-everton	2024-05-12 16:10:00	19	finished	home	373
374	1	747	748	747	748	everton-newcastle-united	2024-09-22 15:00:00	38	notstarted	\N	374
375	1	749	750	749	750	luton-town-burnley	2024-05-12 19:20:00	19	finished	home	375
376	1	751	752	751	752	burnley-luton-town	2024-09-22 14:50:00	38	notstarted	\N	376
377	1	753	754	753	754	aston-villa-manchester-city	2024-05-12 10:10:00	19	finished	draw	377
378	1	755	756	755	756	manchester-city-aston-villa	2024-09-22 18:00:00	38	notstarted	\N	378
379	1	757	758	757	758	sheffield-united-liverpool	2024-05-12 18:20:00	19	finished	draw	379
380	1	759	760	759	760	liverpool-sheffield-united	2024-09-22 19:40:00	38	notstarted	\N	380
381	2	761	762	761	762	nk-varazdin-nk-lokomotiva-zagreb	2024-01-06 12:00:00	1	finished	draw	381
382	2	763	764	763	764	nk-lokomotiva-zagreb-nk-varazdin	2024-03-09 14:30:00	10	finished	home	382
383	2	765	766	765	766	nk-varazdin-nk-lokomotiva-zagreb	2024-05-11 15:50:00	19	finished	draw	383
384	2	767	768	767	768	nk-lokomotiva-zagreb-nk-varazdin	2024-07-13 15:30:00	28	notstarted	\N	384
385	2	769	770	769	770	nk-osijek-nk-rudes	2024-01-06 18:10:00	1	finished	away	385
386	2	771	772	771	772	nk-rudes-nk-osijek	2024-03-09 13:10:00	10	finished	draw	386
387	2	773	774	773	774	nk-osijek-nk-rudes	2024-05-11 11:30:00	19	finished	home	387
388	2	775	776	775	776	nk-rudes-nk-osijek	2024-07-13 19:10:00	28	notstarted	\N	388
389	2	777	778	777	778	hnk-gorica-hnk-rijeka	2024-01-06 18:30:00	1	finished	home	389
390	2	779	780	779	780	hnk-rijeka-hnk-gorica	2024-03-09 14:50:00	10	finished	away	390
391	2	781	782	781	782	hnk-gorica-hnk-rijeka	2024-05-11 11:20:00	19	finished	home	391
392	2	783	784	783	784	hnk-rijeka-hnk-gorica	2024-07-13 10:40:00	28	notstarted	\N	392
393	2	785	786	785	786	nk-istra-1961-gnk-dinamo-zagreb	2024-01-07 17:20:00	1	finished	home	393
394	2	787	788	787	788	gnk-dinamo-zagreb-nk-istra-1961	2024-03-10 18:10:00	10	finished	home	394
395	2	789	790	789	790	nk-istra-1961-gnk-dinamo-zagreb	2024-05-12 14:10:00	19	finished	away	395
396	2	791	792	791	792	gnk-dinamo-zagreb-nk-istra-1961	2024-07-14 15:20:00	28	notstarted	\N	396
397	2	793	794	793	794	nk-slaven-belupo-hnk-hajduk-split	2024-01-07 11:50:00	1	finished	home	397
398	2	795	796	795	796	hnk-hajduk-split-nk-slaven-belupo	2024-03-10 11:40:00	10	finished	home	398
399	2	797	798	797	798	nk-slaven-belupo-hnk-hajduk-split	2024-05-12 17:40:00	19	finished	draw	399
400	2	799	800	799	800	hnk-hajduk-split-nk-slaven-belupo	2024-07-14 12:20:00	28	notstarted	\N	400
401	2	801	802	801	802	nk-lokomotiva-zagreb-hnk-hajduk-split	2024-01-13 11:10:00	2	finished	draw	401
402	2	803	804	803	804	hnk-hajduk-split-nk-lokomotiva-zagreb	2024-03-16 12:00:00	11	finished	draw	402
403	2	805	806	805	806	nk-lokomotiva-zagreb-hnk-hajduk-split	2024-05-18 11:50:00	20	finished	away	403
404	2	807	808	807	808	hnk-hajduk-split-nk-lokomotiva-zagreb	2024-07-20 15:30:00	29	notstarted	\N	404
405	2	809	810	809	810	gnk-dinamo-zagreb-hnk-rijeka	2024-01-13 15:00:00	2	finished	away	405
406	2	811	812	811	812	hnk-rijeka-gnk-dinamo-zagreb	2024-03-16 15:20:00	11	finished	away	406
407	2	813	814	813	814	gnk-dinamo-zagreb-hnk-rijeka	2024-05-18 18:30:00	20	finished	home	407
408	2	815	816	815	816	hnk-rijeka-gnk-dinamo-zagreb	2024-07-20 15:30:00	29	notstarted	\N	408
409	2	817	818	817	818	nk-varazdin-nk-osijek	2024-01-13 16:10:00	2	finished	home	409
410	2	819	820	819	820	nk-osijek-nk-varazdin	2024-03-16 10:30:00	11	finished	draw	410
411	2	821	822	821	822	nk-varazdin-nk-osijek	2024-05-18 18:10:00	20	finished	draw	411
412	2	823	824	823	824	nk-osijek-nk-varazdin	2024-07-20 18:00:00	29	notstarted	\N	412
413	2	825	826	825	826	nk-slaven-belupo-hnk-gorica	2024-01-14 18:50:00	2	finished	home	413
414	2	827	828	827	828	hnk-gorica-nk-slaven-belupo	2024-03-17 11:00:00	11	finished	home	414
415	2	829	830	829	830	nk-slaven-belupo-hnk-gorica	2024-05-19 11:00:00	20	finished	draw	415
416	2	831	832	831	832	hnk-gorica-nk-slaven-belupo	2024-07-21 12:40:00	29	notstarted	\N	416
417	2	833	834	833	834	nk-rudes-nk-istra-1961	2024-01-14 14:10:00	2	finished	draw	417
418	2	835	836	835	836	nk-istra-1961-nk-rudes	2024-03-17 14:40:00	11	finished	away	418
419	2	837	838	837	838	nk-rudes-nk-istra-1961	2024-05-19 12:20:00	20	finished	home	419
420	2	839	840	839	840	nk-istra-1961-nk-rudes	2024-07-21 12:10:00	29	notstarted	\N	420
421	2	841	842	841	842	hnk-rijeka-nk-osijek	2024-01-20 16:20:00	3	finished	home	421
422	2	843	844	843	844	nk-osijek-hnk-rijeka	2024-03-23 10:10:00	12	finished	draw	422
423	2	845	846	845	846	hnk-rijeka-nk-osijek	2024-05-25 11:50:00	21	finished	home	423
424	2	847	848	847	848	nk-osijek-hnk-rijeka	2024-07-27 13:50:00	30	notstarted	\N	424
425	2	849	850	849	850	nk-slaven-belupo-nk-istra-1961	2024-01-20 18:30:00	3	finished	away	425
426	2	851	852	851	852	nk-istra-1961-nk-slaven-belupo	2024-03-23 16:00:00	12	finished	away	426
427	2	853	854	853	854	nk-slaven-belupo-nk-istra-1961	2024-05-25 14:40:00	21	finished	away	427
428	2	855	856	855	856	nk-istra-1961-nk-slaven-belupo	2024-07-27 15:40:00	30	notstarted	\N	428
429	2	857	858	857	858	hnk-hajduk-split-hnk-gorica	2024-01-20 11:10:00	3	finished	away	429
430	2	859	860	859	860	hnk-gorica-hnk-hajduk-split	2024-03-23 12:30:00	12	finished	away	430
431	2	861	862	861	862	hnk-hajduk-split-hnk-gorica	2024-05-25 19:10:00	21	finished	away	431
432	2	863	864	863	864	hnk-gorica-hnk-hajduk-split	2024-07-27 17:20:00	30	notstarted	\N	432
433	2	865	866	865	866	nk-varazdin-nk-rudes	2024-01-21 16:00:00	3	finished	draw	433
434	2	867	868	867	868	nk-rudes-nk-varazdin	2024-03-24 10:10:00	12	finished	home	434
435	2	869	870	869	870	nk-varazdin-nk-rudes	2024-05-26 13:50:00	21	finished	draw	435
436	2	871	872	871	872	nk-rudes-nk-varazdin	2024-07-28 15:40:00	30	notstarted	\N	436
437	2	873	874	873	874	nk-lokomotiva-zagreb-gnk-dinamo-zagreb	2024-01-21 15:40:00	3	finished	draw	437
438	2	875	876	875	876	gnk-dinamo-zagreb-nk-lokomotiva-zagreb	2024-03-24 19:30:00	12	finished	away	438
439	2	877	878	877	878	nk-lokomotiva-zagreb-gnk-dinamo-zagreb	2024-05-26 15:00:00	21	finished	draw	439
440	2	879	880	879	880	gnk-dinamo-zagreb-nk-lokomotiva-zagreb	2024-07-28 18:40:00	30	notstarted	\N	440
441	2	881	882	881	882	nk-slaven-belupo-gnk-dinamo-zagreb	2024-01-27 13:40:00	4	finished	draw	441
442	2	883	884	883	884	gnk-dinamo-zagreb-nk-slaven-belupo	2024-03-30 13:50:00	13	finished	away	442
443	2	885	886	885	886	nk-slaven-belupo-gnk-dinamo-zagreb	2024-06-01 16:00:00	22	notstarted	\N	443
444	2	887	888	887	888	gnk-dinamo-zagreb-nk-slaven-belupo	2024-08-03 10:20:00	31	notstarted	\N	444
445	2	889	890	889	890	nk-varazdin-nk-istra-1961	2024-01-27 14:20:00	4	finished	home	445
446	2	891	892	891	892	nk-istra-1961-nk-varazdin	2024-03-30 19:50:00	13	finished	away	446
447	2	893	894	893	894	nk-varazdin-nk-istra-1961	2024-06-01 16:50:00	22	notstarted	\N	447
448	2	895	896	895	896	nk-istra-1961-nk-varazdin	2024-08-03 16:40:00	31	notstarted	\N	448
449	2	897	898	897	898	nk-rudes-nk-lokomotiva-zagreb	2024-01-27 15:10:00	4	finished	away	449
450	2	899	900	899	900	nk-lokomotiva-zagreb-nk-rudes	2024-03-30 19:10:00	13	finished	away	450
451	2	901	902	901	902	nk-rudes-nk-lokomotiva-zagreb	2024-06-01 11:20:00	22	notstarted	\N	451
452	2	903	904	903	904	nk-lokomotiva-zagreb-nk-rudes	2024-08-03 16:40:00	31	notstarted	\N	452
453	2	905	906	905	906	nk-osijek-hnk-gorica	2024-01-28 16:30:00	4	finished	away	453
454	2	907	908	907	908	hnk-gorica-nk-osijek	2024-03-31 17:40:00	13	finished	home	454
455	2	909	910	909	910	nk-osijek-hnk-gorica	2024-06-02 11:00:00	22	notstarted	\N	455
456	2	911	912	911	912	hnk-gorica-nk-osijek	2024-08-04 13:50:00	31	notstarted	\N	456
457	2	913	914	913	914	hnk-rijeka-hnk-hajduk-split	2024-01-28 15:50:00	4	finished	home	457
458	2	915	916	915	916	hnk-hajduk-split-hnk-rijeka	2024-03-31 15:40:00	13	finished	away	458
459	2	917	918	917	918	hnk-rijeka-hnk-hajduk-split	2024-06-02 12:40:00	22	notstarted	\N	459
460	2	919	920	919	920	hnk-hajduk-split-hnk-rijeka	2024-08-04 10:50:00	31	notstarted	\N	460
461	2	921	922	921	922	nk-istra-1961-hnk-rijeka	2024-02-03 12:00:00	5	finished	away	461
462	2	923	924	923	924	hnk-rijeka-nk-istra-1961	2024-04-06 18:40:00	14	finished	home	462
463	2	925	926	925	926	nk-istra-1961-hnk-rijeka	2024-06-08 10:10:00	23	notstarted	\N	463
464	2	927	928	927	928	hnk-rijeka-nk-istra-1961	2024-08-10 10:10:00	32	notstarted	\N	464
465	2	929	930	929	930	nk-varazdin-gnk-dinamo-zagreb	2024-02-03 10:30:00	5	finished	draw	465
466	2	931	932	931	932	gnk-dinamo-zagreb-nk-varazdin	2024-04-06 11:40:00	14	finished	away	466
467	2	933	934	933	934	nk-varazdin-gnk-dinamo-zagreb	2024-06-08 14:30:00	23	notstarted	\N	467
468	2	935	936	935	936	gnk-dinamo-zagreb-nk-varazdin	2024-08-10 10:00:00	32	notstarted	\N	468
469	2	937	938	937	938	nk-osijek-nk-slaven-belupo	2024-02-03 14:10:00	5	finished	away	469
470	2	939	940	939	940	nk-slaven-belupo-nk-osijek	2024-04-06 10:10:00	14	finished	draw	470
471	2	941	942	941	942	nk-osijek-nk-slaven-belupo	2024-06-08 11:30:00	23	notstarted	\N	471
472	2	943	944	943	944	nk-slaven-belupo-nk-osijek	2024-08-10 10:20:00	32	notstarted	\N	472
473	2	945	946	945	946	nk-lokomotiva-zagreb-hnk-gorica	2024-02-04 12:40:00	5	finished	away	473
474	2	947	948	947	948	hnk-gorica-nk-lokomotiva-zagreb	2024-04-07 10:20:00	14	finished	away	474
475	2	949	950	949	950	nk-lokomotiva-zagreb-hnk-gorica	2024-06-09 17:10:00	23	notstarted	\N	475
476	2	951	952	951	952	hnk-gorica-nk-lokomotiva-zagreb	2024-08-11 16:10:00	32	notstarted	\N	476
477	2	953	954	953	954	nk-rudes-hnk-hajduk-split	2024-02-04 11:10:00	5	finished	away	477
478	2	955	956	955	956	hnk-hajduk-split-nk-rudes	2024-04-07 12:00:00	14	finished	away	478
479	2	957	958	957	958	nk-rudes-hnk-hajduk-split	2024-06-09 11:00:00	23	notstarted	\N	479
480	2	959	960	959	960	hnk-hajduk-split-nk-rudes	2024-08-11 15:40:00	32	notstarted	\N	480
481	2	961	962	961	962	nk-osijek-nk-lokomotiva-zagreb	2024-02-10 12:20:00	6	finished	away	481
482	2	963	964	963	964	nk-lokomotiva-zagreb-nk-osijek	2024-04-13 12:00:00	15	finished	home	482
483	2	965	966	965	966	nk-osijek-nk-lokomotiva-zagreb	2024-06-15 15:10:00	24	notstarted	\N	483
484	2	967	968	967	968	nk-lokomotiva-zagreb-nk-osijek	2024-08-17 12:10:00	33	notstarted	\N	484
485	2	969	970	969	970	nk-rudes-gnk-dinamo-zagreb	2024-02-10 13:10:00	6	finished	home	485
486	2	971	972	971	972	gnk-dinamo-zagreb-nk-rudes	2024-04-13 16:50:00	15	finished	away	486
487	2	973	974	973	974	nk-rudes-gnk-dinamo-zagreb	2024-06-15 15:20:00	24	notstarted	\N	487
488	2	975	976	975	976	gnk-dinamo-zagreb-nk-rudes	2024-08-17 17:20:00	33	notstarted	\N	488
489	2	977	978	977	978	nk-istra-1961-hnk-hajduk-split	2024-02-10 15:40:00	6	finished	draw	489
490	2	979	980	979	980	hnk-hajduk-split-nk-istra-1961	2024-04-13 19:00:00	15	finished	away	490
491	2	981	982	981	982	nk-istra-1961-hnk-hajduk-split	2024-06-15 14:50:00	24	notstarted	\N	491
492	2	983	984	983	984	hnk-hajduk-split-nk-istra-1961	2024-08-17 11:30:00	33	notstarted	\N	492
493	2	985	986	985	986	nk-slaven-belupo-hnk-rijeka	2024-02-11 17:30:00	6	finished	draw	493
494	2	987	988	987	988	hnk-rijeka-nk-slaven-belupo	2024-04-14 10:50:00	15	finished	away	494
495	2	989	990	989	990	nk-slaven-belupo-hnk-rijeka	2024-06-16 17:20:00	24	notstarted	\N	495
496	2	991	992	991	992	hnk-rijeka-nk-slaven-belupo	2024-08-18 17:30:00	33	notstarted	\N	496
497	2	993	994	993	994	hnk-gorica-nk-varazdin	2024-02-11 18:10:00	6	finished	home	497
498	2	995	996	995	996	nk-varazdin-hnk-gorica	2024-04-14 17:10:00	15	finished	home	498
499	2	997	998	997	998	hnk-gorica-nk-varazdin	2024-06-16 13:50:00	24	notstarted	\N	499
500	2	999	1000	999	1000	nk-varazdin-hnk-gorica	2024-08-18 13:40:00	33	notstarted	\N	500
501	2	1001	1002	1001	1002	hnk-rijeka-nk-lokomotiva-zagreb	2024-02-17 19:10:00	7	finished	home	501
502	2	1003	1004	1003	1004	nk-lokomotiva-zagreb-hnk-rijeka	2024-04-20 19:40:00	16	finished	home	502
503	2	1005	1006	1005	1006	hnk-rijeka-nk-lokomotiva-zagreb	2024-06-22 13:50:00	25	notstarted	\N	503
504	2	1007	1008	1007	1008	nk-lokomotiva-zagreb-hnk-rijeka	2024-08-24 15:50:00	34	notstarted	\N	504
505	2	1009	1010	1009	1010	nk-varazdin-hnk-hajduk-split	2024-02-17 13:50:00	7	finished	draw	505
506	2	1011	1012	1011	1012	hnk-hajduk-split-nk-varazdin	2024-04-20 18:10:00	16	finished	home	506
507	2	1013	1014	1013	1014	nk-varazdin-hnk-hajduk-split	2024-06-22 16:50:00	25	notstarted	\N	507
508	2	1015	1016	1015	1016	hnk-hajduk-split-nk-varazdin	2024-08-24 17:10:00	34	notstarted	\N	508
509	2	1017	1018	1017	1018	nk-osijek-gnk-dinamo-zagreb	2024-02-17 15:00:00	7	finished	away	509
510	2	1019	1020	1019	1020	gnk-dinamo-zagreb-nk-osijek	2024-04-20 15:30:00	16	finished	home	510
511	2	1021	1022	1021	1022	nk-osijek-gnk-dinamo-zagreb	2024-06-22 13:10:00	25	notstarted	\N	511
512	2	1023	1024	1023	1024	gnk-dinamo-zagreb-nk-osijek	2024-08-24 14:30:00	34	notstarted	\N	512
513	2	1025	1026	1025	1026	hnk-gorica-nk-istra-1961	2024-02-18 14:40:00	7	finished	away	513
514	2	1027	1028	1027	1028	nk-istra-1961-hnk-gorica	2024-04-21 19:00:00	16	finished	away	514
515	2	1029	1030	1029	1030	hnk-gorica-nk-istra-1961	2024-06-23 18:50:00	25	notstarted	\N	515
516	2	1031	1032	1031	1032	nk-istra-1961-hnk-gorica	2024-08-25 12:30:00	34	notstarted	\N	516
517	2	1033	1034	1033	1034	nk-slaven-belupo-nk-rudes	2024-02-18 16:40:00	7	finished	away	517
518	2	1035	1036	1035	1036	nk-rudes-nk-slaven-belupo	2024-04-21 19:30:00	16	finished	draw	518
519	2	1037	1038	1037	1038	nk-slaven-belupo-nk-rudes	2024-06-23 15:20:00	25	notstarted	\N	519
520	2	1039	1040	1039	1040	nk-rudes-nk-slaven-belupo	2024-08-25 10:00:00	34	notstarted	\N	520
521	2	1041	1042	1041	1042	nk-rudes-hnk-rijeka	2024-02-24 15:30:00	8	finished	home	521
522	2	1043	1044	1043	1044	hnk-rijeka-nk-rudes	2024-04-27 16:00:00	17	finished	away	522
523	2	1045	1046	1045	1046	nk-rudes-hnk-rijeka	2024-06-29 15:30:00	26	notstarted	\N	523
524	2	1047	1048	1047	1048	hnk-rijeka-nk-rudes	2024-08-31 14:10:00	35	notstarted	\N	524
525	2	1049	1050	1049	1050	nk-varazdin-nk-slaven-belupo	2024-02-24 10:20:00	8	finished	home	525
526	2	1051	1052	1051	1052	nk-slaven-belupo-nk-varazdin	2024-04-27 15:20:00	17	finished	draw	526
527	2	1053	1054	1053	1054	nk-varazdin-nk-slaven-belupo	2024-06-29 10:00:00	26	notstarted	\N	527
528	2	1055	1056	1055	1056	nk-slaven-belupo-nk-varazdin	2024-08-31 11:20:00	35	notstarted	\N	528
529	2	1057	1058	1057	1058	nk-istra-1961-nk-lokomotiva-zagreb	2024-02-24 16:10:00	8	finished	home	529
530	2	1059	1060	1059	1060	nk-lokomotiva-zagreb-nk-istra-1961	2024-04-27 19:30:00	17	finished	away	530
531	2	1061	1062	1061	1062	nk-istra-1961-nk-lokomotiva-zagreb	2024-06-29 12:40:00	26	notstarted	\N	531
532	2	1063	1064	1063	1064	nk-lokomotiva-zagreb-nk-istra-1961	2024-08-31 18:10:00	35	notstarted	\N	532
533	2	1065	1066	1065	1066	hnk-gorica-gnk-dinamo-zagreb	2024-02-25 17:30:00	8	finished	draw	533
534	2	1067	1068	1067	1068	gnk-dinamo-zagreb-hnk-gorica	2024-04-28 15:40:00	17	finished	draw	534
535	2	1069	1070	1069	1070	hnk-gorica-gnk-dinamo-zagreb	2024-06-30 19:30:00	26	notstarted	\N	535
536	2	1071	1072	1071	1072	gnk-dinamo-zagreb-hnk-gorica	2024-09-01 11:50:00	35	notstarted	\N	536
537	2	1073	1074	1073	1074	hnk-hajduk-split-nk-osijek	2024-02-25 16:00:00	8	finished	away	537
538	2	1075	1076	1075	1076	nk-osijek-hnk-hajduk-split	2024-04-28 12:10:00	17	finished	draw	538
539	2	1077	1078	1077	1078	hnk-hajduk-split-nk-osijek	2024-06-30 14:50:00	26	notstarted	\N	539
540	2	1079	1080	1079	1080	nk-osijek-hnk-hajduk-split	2024-09-01 12:20:00	35	notstarted	\N	540
541	2	1081	1082	1081	1082	nk-lokomotiva-zagreb-nk-slaven-belupo	2024-03-02 17:20:00	9	finished	home	541
542	2	1083	1084	1083	1084	nk-slaven-belupo-nk-lokomotiva-zagreb	2024-05-04 14:10:00	18	finished	away	542
543	2	1085	1086	1085	1086	nk-lokomotiva-zagreb-nk-slaven-belupo	2024-07-06 10:20:00	27	notstarted	\N	543
544	2	1087	1088	1087	1088	nk-slaven-belupo-nk-lokomotiva-zagreb	2024-09-07 14:20:00	36	notstarted	\N	544
545	2	1089	1090	1089	1090	nk-varazdin-hnk-rijeka	2024-03-02 15:50:00	9	finished	away	545
546	2	1091	1092	1091	1092	hnk-rijeka-nk-varazdin	2024-05-04 14:50:00	18	finished	home	546
547	2	1093	1094	1093	1094	nk-varazdin-hnk-rijeka	2024-07-06 16:40:00	27	notstarted	\N	547
548	2	1095	1096	1095	1096	hnk-rijeka-nk-varazdin	2024-09-07 17:50:00	36	notstarted	\N	548
549	2	1097	1098	1097	1098	hnk-hajduk-split-gnk-dinamo-zagreb	2024-03-02 19:00:00	9	finished	draw	549
550	2	1099	1100	1099	1100	gnk-dinamo-zagreb-hnk-hajduk-split	2024-05-04 10:00:00	18	finished	home	550
551	2	1101	1102	1101	1102	hnk-hajduk-split-gnk-dinamo-zagreb	2024-07-06 18:20:00	27	notstarted	\N	551
552	2	1103	1104	1103	1104	gnk-dinamo-zagreb-hnk-hajduk-split	2024-09-07 14:00:00	36	notstarted	\N	552
553	2	1105	1106	1105	1106	hnk-gorica-nk-rudes	2024-03-03 19:00:00	9	finished	home	553
554	2	1107	1108	1107	1108	nk-rudes-hnk-gorica	2024-05-05 19:20:00	18	finished	home	554
555	2	1109	1110	1109	1110	hnk-gorica-nk-rudes	2024-07-07 10:20:00	27	notstarted	\N	555
556	2	1111	1112	1111	1112	nk-rudes-hnk-gorica	2024-09-08 18:10:00	36	notstarted	\N	556
557	2	1113	1114	1113	1114	nk-istra-1961-nk-osijek	2024-03-03 19:20:00	9	finished	away	557
558	2	1115	1116	1115	1116	nk-osijek-nk-istra-1961	2024-05-05 15:10:00	18	finished	away	558
559	2	1117	1118	1117	1118	nk-istra-1961-nk-osijek	2024-07-07 15:00:00	27	notstarted	\N	559
560	2	1119	1120	1119	1120	nk-osijek-nk-istra-1961	2024-09-08 13:10:00	36	notstarted	\N	560
561	3	1121	1122	1121	1122	villarreal-osasuna	2024-01-06 18:20:00	1	finished	home	561
562	3	1123	1124	1123	1124	osasuna-villarreal	2024-05-18 14:50:00	20	finished	draw	562
563	3	1125	1126	1125	1126	las-palmas-getafe	2024-01-06 11:40:00	1	finished	away	563
564	3	1127	1128	1127	1128	getafe-las-palmas	2024-05-18 11:20:00	20	finished	home	564
565	3	1129	1130	1129	1130	real-betis-granada	2024-01-06 18:50:00	1	finished	away	565
566	3	1131	1132	1131	1132	granada-real-betis	2024-05-18 13:30:00	20	finished	draw	566
567	3	1133	1134	1133	1134	deportivo-alaves-barcelona	2024-01-06 19:00:00	1	finished	home	567
568	3	1135	1136	1135	1136	barcelona-deportivo-alaves	2024-05-18 10:40:00	20	finished	away	568
569	3	1137	1138	1137	1138	atletico-madrid-mallorca	2024-01-06 18:30:00	1	finished	draw	569
570	3	1139	1140	1139	1140	mallorca-atletico-madrid	2024-05-18 14:30:00	20	finished	home	570
571	3	1141	1142	1141	1142	valencia-celta-vigo	2024-01-07 11:50:00	1	finished	draw	571
572	3	1143	1144	1143	1144	celta-vigo-valencia	2024-05-19 15:50:00	20	finished	home	572
573	3	1145	1146	1145	1146	sevilla-girona-fc	2024-01-07 17:00:00	1	finished	draw	573
574	3	1147	1148	1147	1148	girona-fc-sevilla	2024-05-19 10:40:00	20	finished	home	574
575	3	1149	1150	1149	1150	real-sociedad-cadiz	2024-01-07 17:30:00	1	finished	away	575
576	3	1151	1152	1151	1152	cadiz-real-sociedad	2024-05-19 11:40:00	20	finished	draw	576
577	3	1153	1154	1153	1154	athletic-club-rayo-vallecano	2024-01-07 11:00:00	1	finished	away	577
578	3	1155	1156	1155	1156	rayo-vallecano-athletic-club	2024-05-19 12:50:00	20	finished	away	578
579	3	1157	1158	1157	1158	almeria-real-madrid	2024-01-07 13:00:00	1	finished	draw	579
580	3	1159	1160	1159	1160	real-madrid-almeria	2024-05-19 12:30:00	20	finished	draw	580
581	3	1161	1162	1161	1162	valencia-athletic-club	2024-01-13 14:00:00	2	finished	draw	581
582	3	1163	1164	1163	1164	athletic-club-valencia	2024-05-25 17:30:00	21	finished	home	582
583	3	1165	1166	1165	1166	almeria-getafe	2024-01-13 12:30:00	2	finished	home	583
584	3	1167	1168	1167	1168	getafe-almeria	2024-05-25 11:20:00	21	finished	draw	584
585	3	1169	1170	1169	1170	rayo-vallecano-deportivo-alaves	2024-01-13 11:20:00	2	finished	away	585
586	3	1171	1172	1171	1172	deportivo-alaves-rayo-vallecano	2024-05-25 14:30:00	21	finished	draw	586
587	3	1173	1174	1173	1174	cadiz-las-palmas	2024-01-13 10:30:00	2	finished	home	587
588	3	1175	1176	1175	1176	las-palmas-cadiz	2024-05-25 12:50:00	21	finished	home	588
589	3	1177	1178	1177	1178	girona-fc-atletico-madrid	2024-01-13 19:30:00	2	finished	home	589
590	3	1179	1180	1179	1180	atletico-madrid-girona-fc	2024-05-25 17:30:00	21	finished	home	590
591	3	1181	1182	1181	1182	granada-real-sociedad	2024-01-14 16:50:00	2	finished	home	591
592	3	1183	1184	1183	1184	real-sociedad-granada	2024-05-26 17:50:00	21	finished	draw	592
593	3	1185	1186	1185	1186	barcelona-celta-vigo	2024-01-14 11:30:00	2	finished	away	593
594	3	1187	1188	1187	1188	celta-vigo-barcelona	2024-05-26 18:30:00	21	finished	home	594
595	3	1189	1190	1189	1190	sevilla-villarreal	2024-01-14 15:40:00	2	finished	away	595
596	3	1191	1192	1191	1192	villarreal-sevilla	2024-05-26 13:50:00	21	finished	draw	596
597	3	1193	1194	1193	1194	mallorca-real-betis	2024-01-14 10:40:00	2	finished	away	597
598	3	1195	1196	1195	1196	real-betis-mallorca	2024-05-26 10:00:00	21	finished	draw	598
599	3	1197	1198	1197	1198	real-madrid-osasuna	2024-01-14 13:30:00	2	finished	away	599
600	3	1199	1200	1199	1200	osasuna-real-madrid	2024-05-26 16:20:00	21	finished	draw	600
601	3	1201	1202	1201	1202	granada-girona-fc	2024-01-20 11:10:00	3	finished	away	601
602	3	1203	1204	1203	1204	girona-fc-granada	2024-06-01 11:40:00	22	notstarted	\N	602
603	3	1205	1206	1205	1206	almeria-celta-vigo	2024-01-20 13:20:00	3	finished	home	603
604	3	1207	1208	1207	1208	celta-vigo-almeria	2024-06-01 10:40:00	22	notstarted	\N	604
605	3	1209	1210	1209	1210	real-madrid-sevilla	2024-01-20 18:00:00	3	finished	draw	605
606	3	1211	1212	1211	1212	sevilla-real-madrid	2024-06-01 14:40:00	22	notstarted	\N	606
607	3	1213	1214	1213	1214	villarreal-valencia	2024-01-20 17:30:00	3	finished	away	607
608	3	1215	1216	1215	1216	valencia-villarreal	2024-06-01 15:00:00	22	notstarted	\N	608
609	3	1217	1218	1217	1218	deportivo-alaves-cadiz	2024-01-20 15:10:00	3	finished	home	609
610	3	1219	1220	1219	1220	cadiz-deportivo-alaves	2024-06-01 19:30:00	22	notstarted	\N	610
611	3	1221	1222	1221	1222	real-betis-real-sociedad	2024-01-21 10:00:00	3	finished	draw	611
612	3	1223	1224	1223	1224	real-sociedad-real-betis	2024-06-02 15:40:00	22	notstarted	\N	612
613	3	1225	1226	1225	1226	rayo-vallecano-atletico-madrid	2024-01-21 18:30:00	3	finished	away	613
614	3	1227	1228	1227	1228	atletico-madrid-rayo-vallecano	2024-06-02 12:10:00	22	notstarted	\N	614
615	3	1229	1230	1229	1230	osasuna-athletic-club	2024-01-21 15:30:00	3	finished	home	615
616	3	1231	1232	1231	1232	athletic-club-osasuna	2024-06-02 11:20:00	22	notstarted	\N	616
617	3	1233	1234	1233	1234	las-palmas-mallorca	2024-01-21 14:40:00	3	finished	away	617
618	3	1235	1236	1235	1236	mallorca-las-palmas	2024-06-02 13:00:00	22	notstarted	\N	618
619	3	1237	1238	1237	1238	barcelona-getafe	2024-01-21 15:50:00	3	finished	away	619
620	3	1239	1240	1239	1240	getafe-barcelona	2024-06-02 16:20:00	22	notstarted	\N	620
621	3	1241	1242	1241	1242	mallorca-celta-vigo	2024-01-27 17:40:00	4	finished	away	621
622	3	1243	1244	1243	1244	celta-vigo-mallorca	2024-06-08 17:10:00	23	notstarted	\N	622
623	3	1245	1246	1245	1246	valencia-las-palmas	2024-01-27 19:40:00	4	finished	draw	623
624	3	1247	1248	1247	1248	las-palmas-valencia	2024-06-08 17:30:00	23	notstarted	\N	624
625	3	1249	1250	1249	1250	rayo-vallecano-almeria	2024-01-27 12:30:00	4	finished	home	625
626	3	1251	1252	1251	1252	almeria-rayo-vallecano	2024-06-08 13:50:00	23	notstarted	\N	626
627	3	1253	1254	1253	1254	real-madrid-real-sociedad	2024-01-27 18:00:00	4	finished	draw	627
628	3	1255	1256	1255	1256	real-sociedad-real-madrid	2024-06-08 13:20:00	23	notstarted	\N	628
629	3	1257	1258	1257	1258	villarreal-granada	2024-01-27 10:20:00	4	finished	draw	629
630	3	1259	1260	1259	1260	granada-villarreal	2024-06-08 18:00:00	23	notstarted	\N	630
631	3	1261	1262	1261	1262	atletico-madrid-barcelona	2024-01-28 11:10:00	4	finished	draw	631
632	3	1263	1264	1263	1264	barcelona-atletico-madrid	2024-06-09 17:20:00	23	notstarted	\N	632
633	3	1265	1266	1265	1266	getafe-real-betis	2024-01-28 15:30:00	4	finished	home	633
634	3	1267	1268	1267	1268	real-betis-getafe	2024-06-09 12:40:00	23	notstarted	\N	634
635	3	1269	1270	1269	1270	deportivo-alaves-girona-fc	2024-01-28 13:10:00	4	finished	home	635
636	3	1271	1272	1271	1272	girona-fc-deportivo-alaves	2024-06-09 11:30:00	23	notstarted	\N	636
637	3	1273	1274	1273	1274	cadiz-athletic-club	2024-01-28 15:30:00	4	finished	draw	637
638	3	1275	1276	1275	1276	athletic-club-cadiz	2024-06-09 11:10:00	23	notstarted	\N	638
639	3	1277	1278	1277	1278	sevilla-osasuna	2024-01-28 11:00:00	4	finished	draw	639
640	3	1279	1280	1279	1280	osasuna-sevilla	2024-06-09 10:20:00	23	notstarted	\N	640
641	3	1281	1282	1281	1282	villarreal-barcelona	2024-02-03 19:40:00	5	finished	home	641
642	3	1283	1284	1283	1284	barcelona-villarreal	2024-06-15 12:40:00	24	notstarted	\N	642
643	3	1285	1286	1285	1286	real-sociedad-valencia	2024-02-03 12:10:00	5	finished	draw	643
644	3	1287	1288	1287	1288	valencia-real-sociedad	2024-06-15 11:50:00	24	notstarted	\N	644
645	3	1289	1290	1289	1290	girona-fc-almeria	2024-02-03 17:20:00	5	finished	draw	645
646	3	1291	1292	1291	1292	almeria-girona-fc	2024-06-15 15:30:00	24	notstarted	\N	646
647	3	1293	1294	1293	1294	deportivo-alaves-las-palmas	2024-02-03 11:50:00	5	finished	home	647
648	3	1295	1296	1295	1296	las-palmas-deportivo-alaves	2024-06-15 14:30:00	24	notstarted	\N	648
649	3	1297	1298	1297	1298	osasuna-rayo-vallecano	2024-02-03 18:50:00	5	finished	draw	649
650	3	1299	1300	1299	1300	rayo-vallecano-osasuna	2024-06-15 19:30:00	24	notstarted	\N	650
651	3	1301	1302	1301	1302	real-betis-atletico-madrid	2024-02-04 16:00:00	5	finished	home	651
652	3	1303	1304	1303	1304	atletico-madrid-real-betis	2024-06-16 15:40:00	24	notstarted	\N	652
653	3	1305	1306	1305	1306	getafe-athletic-club	2024-02-04 17:30:00	5	finished	draw	653
654	3	1307	1308	1307	1308	athletic-club-getafe	2024-06-16 14:30:00	24	notstarted	\N	654
655	3	1309	1310	1309	1310	mallorca-cadiz	2024-02-04 14:10:00	5	finished	home	655
656	3	1311	1312	1311	1312	cadiz-mallorca	2024-06-16 17:50:00	24	notstarted	\N	656
657	3	1313	1314	1313	1314	sevilla-celta-vigo	2024-02-04 17:10:00	5	finished	home	657
658	3	1315	1316	1315	1316	celta-vigo-sevilla	2024-06-16 11:40:00	24	notstarted	\N	658
659	3	1317	1318	1317	1318	granada-real-madrid	2024-02-04 11:20:00	5	finished	home	659
660	3	1319	1320	1319	1320	real-madrid-granada	2024-06-16 10:10:00	24	notstarted	\N	660
661	3	1321	1322	1321	1322	real-madrid-cadiz	2024-02-10 10:00:00	6	finished	home	661
662	3	1323	1324	1323	1324	cadiz-real-madrid	2024-06-22 10:20:00	25	notstarted	\N	662
663	3	1325	1326	1325	1326	almeria-granada	2024-02-10 19:30:00	6	finished	home	663
664	3	1327	1328	1327	1328	granada-almeria	2024-06-22 18:00:00	25	notstarted	\N	664
665	3	1329	1330	1329	1330	sevilla-real-sociedad	2024-02-10 14:00:00	6	finished	away	665
666	3	1331	1332	1331	1332	real-sociedad-sevilla	2024-06-22 12:00:00	25	notstarted	\N	666
667	3	1333	1334	1333	1334	valencia-real-betis	2024-02-10 15:30:00	6	finished	away	667
668	3	1335	1336	1335	1336	real-betis-valencia	2024-06-22 14:50:00	25	notstarted	\N	668
669	3	1337	1338	1337	1338	mallorca-villarreal	2024-02-10 15:00:00	6	finished	home	669
670	3	1339	1340	1339	1340	villarreal-mallorca	2024-06-22 13:00:00	25	notstarted	\N	670
671	3	1341	1342	1341	1342	deportivo-alaves-getafe	2024-02-11 15:30:00	6	finished	home	671
672	3	1343	1344	1343	1344	getafe-deportivo-alaves	2024-06-23 17:30:00	25	notstarted	\N	672
673	3	1345	1346	1345	1346	athletic-club-barcelona	2024-02-11 10:20:00	6	finished	away	673
674	3	1347	1348	1347	1348	barcelona-athletic-club	2024-06-23 14:50:00	25	notstarted	\N	674
675	3	1349	1350	1349	1350	osasuna-atletico-madrid	2024-02-11 19:40:00	6	finished	away	675
676	3	1351	1352	1351	1352	atletico-madrid-osasuna	2024-06-23 16:40:00	25	notstarted	\N	676
677	3	1353	1354	1353	1354	girona-fc-rayo-vallecano	2024-02-11 11:20:00	6	finished	away	677
678	3	1355	1356	1355	1356	rayo-vallecano-girona-fc	2024-06-23 11:40:00	25	notstarted	\N	678
679	3	1357	1358	1357	1358	celta-vigo-las-palmas	2024-02-11 16:10:00	6	finished	home	679
680	3	1359	1360	1359	1360	las-palmas-celta-vigo	2024-06-23 11:50:00	25	notstarted	\N	680
681	3	1361	1362	1361	1362	real-sociedad-girona-fc	2024-02-17 11:50:00	7	finished	home	681
682	3	1363	1364	1363	1364	girona-fc-real-sociedad	2024-06-29 17:10:00	26	notstarted	\N	682
683	3	1365	1366	1365	1366	granada-rayo-vallecano	2024-02-17 19:10:00	7	finished	draw	683
684	3	1367	1368	1367	1368	rayo-vallecano-granada	2024-06-29 15:30:00	26	notstarted	\N	684
685	3	1369	1370	1369	1370	getafe-mallorca	2024-02-17 14:00:00	7	finished	home	685
686	3	1371	1372	1371	1372	mallorca-getafe	2024-06-29 18:40:00	26	notstarted	\N	686
687	3	1373	1374	1373	1374	valencia-almeria	2024-02-17 12:10:00	7	finished	draw	687
688	3	1375	1376	1375	1376	almeria-valencia	2024-06-29 13:10:00	26	notstarted	\N	688
689	3	1377	1378	1377	1378	sevilla-athletic-club	2024-02-17 16:40:00	7	finished	away	689
690	3	1379	1380	1379	1380	athletic-club-sevilla	2024-06-29 10:40:00	26	notstarted	\N	690
691	3	1381	1382	1381	1382	las-palmas-real-madrid	2024-02-18 11:50:00	7	finished	away	691
692	3	1383	1384	1383	1384	real-madrid-las-palmas	2024-06-30 18:00:00	26	notstarted	\N	692
693	3	1385	1386	1385	1386	deportivo-alaves-atletico-madrid	2024-02-18 12:40:00	7	finished	home	693
694	3	1387	1388	1387	1388	atletico-madrid-deportivo-alaves	2024-06-30 17:10:00	26	notstarted	\N	694
695	3	1389	1390	1389	1390	villarreal-cadiz	2024-02-18 10:50:00	7	finished	home	695
696	3	1391	1392	1391	1392	cadiz-villarreal	2024-06-30 17:40:00	26	notstarted	\N	696
697	3	1393	1394	1393	1394	celta-vigo-real-betis	2024-02-18 10:50:00	7	finished	draw	697
698	3	1395	1396	1395	1396	real-betis-celta-vigo	2024-06-30 18:30:00	26	notstarted	\N	698
699	3	1397	1398	1397	1398	osasuna-barcelona	2024-02-18 18:50:00	7	finished	home	699
700	3	1399	1400	1399	1400	barcelona-osasuna	2024-06-30 18:00:00	26	notstarted	\N	700
701	3	1401	1402	1401	1402	real-madrid-valencia	2024-02-24 15:10:00	8	finished	away	701
702	3	1403	1404	1403	1404	valencia-real-madrid	2024-07-06 15:30:00	27	notstarted	\N	702
703	3	1405	1406	1405	1406	real-betis-sevilla	2024-02-24 10:40:00	8	finished	home	703
704	3	1407	1408	1407	1408	sevilla-real-betis	2024-07-06 16:00:00	27	notstarted	\N	704
705	3	1409	1410	1409	1410	girona-fc-osasuna	2024-02-24 14:30:00	8	finished	home	705
706	3	1411	1412	1411	1412	osasuna-girona-fc	2024-07-06 15:10:00	27	notstarted	\N	706
707	3	1413	1414	1413	1414	mallorca-granada	2024-02-24 15:30:00	8	finished	home	707
708	3	1415	1416	1415	1416	granada-mallorca	2024-07-06 18:00:00	27	notstarted	\N	708
709	3	1417	1418	1417	1418	celta-vigo-atletico-madrid	2024-02-24 14:30:00	8	finished	away	709
710	3	1419	1420	1419	1420	atletico-madrid-celta-vigo	2024-07-06 15:50:00	27	notstarted	\N	710
711	3	1421	1422	1421	1422	athletic-club-villarreal	2024-02-25 10:20:00	8	finished	away	711
712	3	1423	1424	1423	1424	villarreal-athletic-club	2024-07-07 13:50:00	27	notstarted	\N	712
713	3	1425	1426	1425	1426	getafe-rayo-vallecano	2024-02-25 18:10:00	8	finished	away	713
714	3	1427	1428	1427	1428	rayo-vallecano-getafe	2024-07-07 18:20:00	27	notstarted	\N	714
715	3	1429	1430	1429	1430	deportivo-alaves-real-sociedad	2024-02-25 18:00:00	8	finished	draw	715
716	3	1431	1432	1431	1432	real-sociedad-deportivo-alaves	2024-07-07 17:30:00	27	notstarted	\N	716
717	3	1433	1434	1433	1434	almeria-las-palmas	2024-02-25 16:00:00	8	finished	away	717
718	3	1435	1436	1435	1436	las-palmas-almeria	2024-07-07 12:00:00	27	notstarted	\N	718
719	3	1437	1438	1437	1438	cadiz-barcelona	2024-02-25 16:20:00	8	finished	home	719
720	3	1439	1440	1439	1440	barcelona-cadiz	2024-07-07 17:10:00	27	notstarted	\N	720
721	3	1441	1442	1441	1442	las-palmas-athletic-club	2024-03-02 18:20:00	9	finished	away	721
722	3	1443	1444	1443	1444	athletic-club-las-palmas	2024-07-13 11:10:00	28	notstarted	\N	722
723	3	1445	1446	1445	1446	getafe-real-madrid	2024-03-02 11:20:00	9	finished	away	723
724	3	1447	1448	1447	1448	real-madrid-getafe	2024-07-13 12:20:00	28	notstarted	\N	724
725	3	1449	1450	1449	1450	atletico-madrid-granada	2024-03-02 14:30:00	9	finished	away	725
726	3	1451	1452	1451	1452	granada-atletico-madrid	2024-07-13 16:30:00	28	notstarted	\N	726
727	3	1453	1454	1453	1454	barcelona-real-betis	2024-03-02 17:00:00	9	finished	home	727
728	3	1455	1456	1455	1456	real-betis-barcelona	2024-07-13 18:30:00	28	notstarted	\N	728
729	3	1457	1458	1457	1458	sevilla-valencia	2024-03-02 16:50:00	9	finished	away	729
730	3	1459	1460	1459	1460	valencia-sevilla	2024-07-13 19:10:00	28	notstarted	\N	730
731	3	1461	1462	1461	1462	real-sociedad-villarreal	2024-03-03 15:10:00	9	finished	draw	731
732	3	1463	1464	1463	1464	villarreal-real-sociedad	2024-07-14 16:10:00	28	notstarted	\N	732
733	3	1465	1466	1465	1466	almeria-mallorca	2024-03-03 10:10:00	9	finished	home	733
734	3	1467	1468	1467	1468	mallorca-almeria	2024-07-14 15:40:00	28	notstarted	\N	734
735	3	1469	1470	1469	1470	rayo-vallecano-celta-vigo	2024-03-03 13:40:00	9	finished	away	735
736	3	1471	1472	1471	1472	celta-vigo-rayo-vallecano	2024-07-14 16:30:00	28	notstarted	\N	736
737	3	1473	1474	1473	1474	cadiz-girona-fc	2024-03-03 13:10:00	9	finished	away	737
738	3	1475	1476	1475	1476	girona-fc-cadiz	2024-07-14 19:00:00	28	notstarted	\N	738
739	3	1477	1478	1477	1478	osasuna-deportivo-alaves	2024-03-03 16:00:00	9	finished	home	739
740	3	1479	1480	1479	1480	deportivo-alaves-osasuna	2024-07-14 16:20:00	28	notstarted	\N	740
741	3	1481	1482	1481	1482	almeria-real-sociedad	2024-03-09 14:00:00	10	finished	home	741
742	3	1483	1484	1483	1484	real-sociedad-almeria	2024-07-20 15:40:00	29	notstarted	\N	742
743	3	1485	1486	1485	1486	girona-fc-barcelona	2024-03-09 15:30:00	10	finished	home	743
744	3	1487	1488	1487	1488	barcelona-girona-fc	2024-07-20 10:30:00	29	notstarted	\N	744
745	3	1489	1490	1489	1490	celta-vigo-villarreal	2024-03-09 14:20:00	10	finished	away	745
746	3	1491	1492	1491	1492	villarreal-celta-vigo	2024-07-20 19:20:00	29	notstarted	\N	746
747	3	1493	1494	1493	1494	real-madrid-mallorca	2024-03-09 14:30:00	10	finished	home	747
748	3	1495	1496	1495	1496	mallorca-real-madrid	2024-07-20 18:40:00	29	notstarted	\N	748
749	3	1497	1498	1497	1498	las-palmas-osasuna	2024-03-09 15:00:00	10	finished	away	749
750	3	1499	1500	1499	1500	osasuna-las-palmas	2024-07-20 13:20:00	29	notstarted	\N	750
751	3	1501	1502	1501	1502	sevilla-rayo-vallecano	2024-03-10 17:10:00	10	finished	away	751
752	3	1503	1504	1503	1504	rayo-vallecano-sevilla	2024-07-21 15:20:00	29	notstarted	\N	752
753	3	1505	1506	1505	1506	valencia-getafe	2024-03-10 15:00:00	10	finished	home	753
754	3	1507	1508	1507	1508	getafe-valencia	2024-07-21 11:10:00	29	notstarted	\N	754
755	3	1509	1510	1509	1510	deportivo-alaves-real-betis	2024-03-10 11:20:00	10	finished	away	755
756	3	1511	1512	1511	1512	real-betis-deportivo-alaves	2024-07-21 18:10:00	29	notstarted	\N	756
757	3	1513	1514	1513	1514	granada-cadiz	2024-03-10 16:50:00	10	finished	home	757
758	3	1515	1516	1515	1516	cadiz-granada	2024-07-21 12:10:00	29	notstarted	\N	758
759	3	1517	1518	1517	1518	atletico-madrid-athletic-club	2024-03-10 14:10:00	10	finished	draw	759
760	3	1519	1520	1519	1520	athletic-club-atletico-madrid	2024-07-21 19:30:00	29	notstarted	\N	760
761	3	1521	1522	1521	1522	barcelona-real-sociedad	2024-03-16 17:40:00	11	finished	draw	761
762	3	1523	1524	1523	1524	real-sociedad-barcelona	2024-07-27 14:00:00	30	notstarted	\N	762
763	3	1525	1526	1525	1526	getafe-celta-vigo	2024-03-16 10:00:00	11	finished	home	763
764	3	1527	1528	1527	1528	celta-vigo-getafe	2024-07-27 13:40:00	30	notstarted	\N	764
765	3	1529	1530	1529	1530	real-madrid-real-betis	2024-03-16 15:10:00	11	finished	home	765
766	3	1531	1532	1531	1532	real-betis-real-madrid	2024-07-27 12:00:00	30	notstarted	\N	766
767	3	1533	1534	1533	1534	osasuna-cadiz	2024-03-16 14:10:00	11	finished	away	767
768	3	1535	1536	1535	1536	cadiz-osasuna	2024-07-27 17:40:00	30	notstarted	\N	768
769	3	1537	1538	1537	1538	mallorca-sevilla	2024-03-16 11:50:00	11	finished	home	769
770	3	1539	1540	1539	1540	sevilla-mallorca	2024-07-27 10:40:00	30	notstarted	\N	770
771	3	1541	1542	1541	1542	villarreal-rayo-vallecano	2024-03-17 19:20:00	11	finished	away	771
772	3	1543	1544	1543	1544	rayo-vallecano-villarreal	2024-07-28 15:40:00	30	notstarted	\N	772
773	3	1545	1546	1545	1546	atletico-madrid-las-palmas	2024-03-17 11:00:00	11	finished	draw	773
774	3	1547	1548	1547	1548	las-palmas-atletico-madrid	2024-07-28 15:30:00	30	notstarted	\N	774
775	3	1549	1550	1549	1550	deportivo-alaves-granada	2024-03-17 12:50:00	11	finished	home	775
776	3	1551	1552	1551	1552	granada-deportivo-alaves	2024-07-28 11:40:00	30	notstarted	\N	776
777	3	1553	1554	1553	1554	almeria-athletic-club	2024-03-17 12:00:00	11	finished	draw	777
778	3	1555	1556	1555	1556	athletic-club-almeria	2024-07-28 13:00:00	30	notstarted	\N	778
779	3	1557	1558	1557	1558	girona-fc-valencia	2024-03-17 13:40:00	11	finished	home	779
780	3	1559	1560	1559	1560	valencia-girona-fc	2024-07-28 10:00:00	30	notstarted	\N	780
781	3	1561	1562	1561	1562	atletico-madrid-almeria	2024-03-23 18:40:00	12	finished	away	781
782	3	1563	1564	1563	1564	almeria-atletico-madrid	2024-08-03 14:00:00	31	notstarted	\N	782
783	3	1565	1566	1565	1566	deportivo-alaves-valencia	2024-03-23 12:00:00	12	finished	draw	783
784	3	1567	1568	1567	1568	valencia-deportivo-alaves	2024-08-03 14:10:00	31	notstarted	\N	784
785	3	1569	1570	1569	1570	real-sociedad-osasuna	2024-03-23 12:40:00	12	finished	home	785
786	3	1571	1572	1571	1572	osasuna-real-sociedad	2024-08-03 16:00:00	31	notstarted	\N	786
787	3	1573	1574	1573	1574	granada-las-palmas	2024-03-23 17:40:00	12	finished	home	787
788	3	1575	1576	1575	1576	las-palmas-granada	2024-08-03 17:10:00	31	notstarted	\N	788
789	3	1577	1578	1577	1578	villarreal-real-betis	2024-03-23 12:10:00	12	finished	home	789
790	3	1579	1580	1579	1580	real-betis-villarreal	2024-08-03 12:10:00	31	notstarted	\N	790
791	3	1581	1582	1581	1582	athletic-club-mallorca	2024-03-24 18:10:00	12	finished	away	791
792	3	1583	1584	1583	1584	mallorca-athletic-club	2024-08-04 15:40:00	31	notstarted	\N	792
793	3	1585	1586	1585	1586	rayo-vallecano-barcelona	2024-03-24 19:40:00	12	finished	home	793
794	3	1587	1588	1587	1588	barcelona-rayo-vallecano	2024-08-04 16:30:00	31	notstarted	\N	794
795	3	1589	1590	1589	1590	celta-vigo-cadiz	2024-03-24 15:40:00	12	finished	draw	795
796	3	1591	1592	1591	1592	cadiz-celta-vigo	2024-08-04 17:00:00	31	notstarted	\N	796
797	3	1593	1594	1593	1594	sevilla-getafe	2024-03-24 12:30:00	12	finished	draw	797
798	3	1595	1596	1595	1596	getafe-sevilla	2024-08-04 15:50:00	31	notstarted	\N	798
799	3	1597	1598	1597	1598	real-madrid-girona-fc	2024-03-24 15:40:00	12	finished	home	799
800	3	1599	1600	1599	1600	girona-fc-real-madrid	2024-08-04 15:30:00	31	notstarted	\N	800
801	3	1601	1602	1601	1602	getafe-granada	2024-03-30 11:30:00	13	finished	away	801
802	3	1603	1604	1603	1604	granada-getafe	2024-08-10 11:20:00	32	notstarted	\N	802
803	3	1605	1606	1605	1606	las-palmas-rayo-vallecano	2024-03-30 19:30:00	13	finished	home	803
804	3	1607	1608	1607	1608	rayo-vallecano-las-palmas	2024-08-10 12:30:00	32	notstarted	\N	804
805	3	1609	1610	1609	1610	real-madrid-celta-vigo	2024-03-30 16:50:00	13	finished	draw	805
806	3	1611	1612	1611	1612	celta-vigo-real-madrid	2024-08-10 10:40:00	32	notstarted	\N	806
807	3	1613	1614	1613	1614	villarreal-deportivo-alaves	2024-03-30 18:40:00	13	finished	away	807
808	3	1615	1616	1615	1616	deportivo-alaves-villarreal	2024-08-10 14:30:00	32	notstarted	\N	808
809	3	1617	1618	1617	1618	mallorca-valencia	2024-03-30 18:40:00	13	finished	home	809
810	3	1619	1620	1619	1620	valencia-mallorca	2024-08-10 15:40:00	32	notstarted	\N	810
811	3	1621	1622	1621	1622	osasuna-almeria	2024-03-31 14:20:00	13	finished	draw	811
812	3	1623	1624	1623	1624	almeria-osasuna	2024-08-11 10:40:00	32	notstarted	\N	812
813	3	1625	1626	1625	1626	cadiz-real-betis	2024-03-31 19:00:00	13	finished	draw	813
814	3	1627	1628	1627	1628	real-betis-cadiz	2024-08-11 11:30:00	32	notstarted	\N	814
815	3	1629	1630	1629	1630	athletic-club-girona-fc	2024-03-31 13:40:00	13	finished	away	815
816	3	1631	1632	1631	1632	girona-fc-athletic-club	2024-08-11 13:50:00	32	notstarted	\N	816
817	3	1633	1634	1633	1634	barcelona-sevilla	2024-03-31 15:00:00	13	finished	home	817
818	3	1635	1636	1635	1636	sevilla-barcelona	2024-08-11 15:10:00	32	notstarted	\N	818
819	3	1637	1638	1637	1638	real-sociedad-atletico-madrid	2024-03-31 11:00:00	13	finished	home	819
820	3	1639	1640	1639	1640	atletico-madrid-real-sociedad	2024-08-11 14:10:00	32	notstarted	\N	820
821	3	1641	1642	1641	1642	real-sociedad-celta-vigo	2024-04-06 19:30:00	14	finished	home	821
822	3	1643	1644	1643	1644	celta-vigo-real-sociedad	2024-08-17 15:50:00	33	notstarted	\N	822
823	3	1645	1646	1645	1646	real-betis-girona-fc	2024-04-06 11:50:00	14	finished	away	823
824	3	1647	1648	1647	1648	girona-fc-real-betis	2024-08-17 17:10:00	33	notstarted	\N	824
825	3	1649	1650	1649	1650	villarreal-getafe	2024-04-06 18:30:00	14	finished	home	825
826	3	1651	1652	1651	1652	getafe-villarreal	2024-08-17 18:10:00	33	notstarted	\N	826
827	3	1653	1654	1653	1654	barcelona-mallorca	2024-04-06 16:10:00	14	finished	draw	827
828	3	1655	1656	1655	1656	mallorca-barcelona	2024-08-17 19:50:00	33	notstarted	\N	828
829	3	1657	1658	1657	1658	las-palmas-sevilla	2024-04-06 10:10:00	14	finished	draw	829
830	3	1659	1660	1659	1660	sevilla-las-palmas	2024-08-17 19:50:00	33	notstarted	\N	830
831	3	1661	1662	1661	1662	real-madrid-rayo-vallecano	2024-04-07 16:30:00	14	finished	away	831
832	3	1663	1664	1663	1664	rayo-vallecano-real-madrid	2024-08-18 15:10:00	33	notstarted	\N	832
833	3	1665	1666	1665	1666	atletico-madrid-valencia	2024-04-07 16:00:00	14	finished	away	833
834	3	1667	1668	1667	1668	valencia-atletico-madrid	2024-08-18 15:20:00	33	notstarted	\N	834
835	3	1669	1670	1669	1670	granada-osasuna	2024-04-07 17:10:00	14	finished	away	835
836	3	1671	1672	1671	1672	osasuna-granada	2024-08-18 10:20:00	33	notstarted	\N	836
837	3	1673	1674	1673	1674	cadiz-almeria	2024-04-07 16:40:00	14	finished	draw	837
838	3	1675	1676	1675	1676	almeria-cadiz	2024-08-18 11:40:00	33	notstarted	\N	838
839	3	1677	1678	1677	1678	deportivo-alaves-athletic-club	2024-04-07 16:20:00	14	finished	draw	839
840	3	1679	1680	1679	1680	athletic-club-deportivo-alaves	2024-08-18 15:50:00	33	notstarted	\N	840
841	3	1681	1682	1681	1682	cadiz-valencia	2024-04-13 16:50:00	15	finished	draw	841
842	3	1683	1684	1683	1684	valencia-cadiz	2024-08-24 19:30:00	34	notstarted	\N	842
843	3	1685	1686	1685	1686	almeria-barcelona	2024-04-13 13:10:00	15	finished	draw	843
844	3	1687	1688	1687	1688	barcelona-almeria	2024-08-24 14:40:00	34	notstarted	\N	844
845	3	1689	1690	1689	1690	mallorca-rayo-vallecano	2024-04-13 17:40:00	15	finished	draw	845
846	3	1691	1692	1691	1692	rayo-vallecano-mallorca	2024-08-24 15:00:00	34	notstarted	\N	846
847	3	1693	1694	1693	1694	villarreal-las-palmas	2024-04-13 14:40:00	15	finished	home	847
848	3	1695	1696	1695	1696	las-palmas-villarreal	2024-08-24 16:20:00	34	notstarted	\N	848
849	3	1697	1698	1697	1698	atletico-madrid-real-madrid	2024-04-13 12:00:00	15	finished	draw	849
850	3	1699	1700	1699	1700	real-madrid-atletico-madrid	2024-08-24 13:20:00	34	notstarted	\N	850
851	3	1701	1702	1701	1702	real-sociedad-athletic-club	2024-04-14 19:20:00	15	finished	away	851
852	3	1703	1704	1703	1704	athletic-club-real-sociedad	2024-08-25 11:20:00	34	notstarted	\N	852
853	3	1705	1706	1705	1706	deportivo-alaves-sevilla	2024-04-14 16:20:00	15	finished	home	853
854	3	1707	1708	1707	1708	sevilla-deportivo-alaves	2024-08-25 16:40:00	34	notstarted	\N	854
855	3	1709	1710	1709	1710	real-betis-osasuna	2024-04-14 18:50:00	15	finished	home	855
856	3	1711	1712	1711	1712	osasuna-real-betis	2024-08-25 15:20:00	34	notstarted	\N	856
857	3	1713	1714	1713	1714	getafe-girona-fc	2024-04-14 15:50:00	15	finished	home	857
858	3	1715	1716	1715	1716	girona-fc-getafe	2024-08-25 19:10:00	34	notstarted	\N	858
859	3	1717	1718	1717	1718	granada-celta-vigo	2024-04-14 16:10:00	15	finished	away	859
860	3	1719	1720	1719	1720	celta-vigo-granada	2024-08-25 15:40:00	34	notstarted	\N	860
861	3	1721	1722	1721	1722	granada-barcelona	2024-04-20 16:00:00	16	finished	away	861
862	3	1723	1724	1723	1724	barcelona-granada	2024-08-31 18:50:00	35	notstarted	\N	862
863	3	1725	1726	1725	1726	real-madrid-villarreal	2024-04-20 10:50:00	16	finished	home	863
864	3	1727	1728	1727	1728	villarreal-real-madrid	2024-08-31 10:20:00	35	notstarted	\N	864
865	3	1729	1730	1729	1730	almeria-real-betis	2024-04-20 10:40:00	16	finished	home	865
866	3	1731	1732	1731	1732	real-betis-almeria	2024-08-31 17:40:00	35	notstarted	\N	866
867	3	1733	1734	1733	1734	girona-fc-las-palmas	2024-04-20 14:50:00	16	finished	draw	867
868	3	1735	1736	1735	1736	las-palmas-girona-fc	2024-08-31 19:50:00	35	notstarted	\N	868
869	3	1737	1738	1737	1738	valencia-osasuna	2024-04-20 12:20:00	16	finished	draw	869
870	3	1739	1740	1739	1740	osasuna-valencia	2024-08-31 18:20:00	35	notstarted	\N	870
871	3	1741	1742	1741	1742	sevilla-atletico-madrid	2024-04-21 19:50:00	16	finished	home	871
872	3	1743	1744	1743	1744	atletico-madrid-sevilla	2024-09-01 16:40:00	35	notstarted	\N	872
873	3	1745	1746	1745	1746	deportivo-alaves-mallorca	2024-04-21 15:00:00	16	finished	home	873
874	3	1747	1748	1747	1748	mallorca-deportivo-alaves	2024-09-01 11:50:00	35	notstarted	\N	874
875	3	1749	1750	1749	1750	real-sociedad-getafe	2024-04-21 15:30:00	16	finished	home	875
876	3	1751	1752	1751	1752	getafe-real-sociedad	2024-09-01 12:20:00	35	notstarted	\N	876
877	3	1753	1754	1753	1754	celta-vigo-athletic-club	2024-04-21 11:20:00	16	finished	draw	877
878	3	1755	1756	1755	1756	athletic-club-celta-vigo	2024-09-01 16:40:00	35	notstarted	\N	878
879	3	1757	1758	1757	1758	cadiz-rayo-vallecano	2024-04-21 13:00:00	16	finished	home	879
880	3	1759	1760	1759	1760	rayo-vallecano-cadiz	2024-09-01 17:50:00	35	notstarted	\N	880
881	3	1761	1762	1761	1762	real-sociedad-mallorca	2024-04-27 16:20:00	17	finished	away	881
882	3	1763	1764	1763	1764	mallorca-real-sociedad	2024-09-07 16:30:00	36	notstarted	\N	882
883	3	1765	1766	1765	1766	barcelona-real-madrid	2024-04-27 15:00:00	17	finished	away	883
884	3	1767	1768	1767	1768	real-madrid-barcelona	2024-09-07 13:40:00	36	notstarted	\N	884
885	3	1769	1770	1769	1770	las-palmas-real-betis	2024-04-27 17:00:00	17	finished	home	885
886	3	1771	1772	1771	1772	real-betis-las-palmas	2024-09-07 14:20:00	36	notstarted	\N	886
887	3	1773	1774	1773	1774	rayo-vallecano-valencia	2024-04-27 15:00:00	17	finished	draw	887
888	3	1775	1776	1775	1776	valencia-rayo-vallecano	2024-09-07 16:20:00	36	notstarted	\N	888
889	3	1777	1778	1777	1778	granada-athletic-club	2024-04-27 16:40:00	17	finished	draw	889
890	3	1779	1780	1779	1780	athletic-club-granada	2024-09-07 17:00:00	36	notstarted	\N	890
891	3	1781	1782	1781	1782	cadiz-sevilla	2024-04-28 10:50:00	17	finished	draw	891
892	3	1783	1784	1783	1784	sevilla-cadiz	2024-09-08 11:40:00	36	notstarted	\N	892
893	3	1785	1786	1785	1786	atletico-madrid-getafe	2024-04-28 17:00:00	17	finished	home	893
894	3	1787	1788	1787	1788	getafe-atletico-madrid	2024-09-08 18:00:00	36	notstarted	\N	894
895	3	1789	1790	1789	1790	almeria-deportivo-alaves	2024-04-28 10:00:00	17	finished	home	895
896	3	1791	1792	1791	1792	deportivo-alaves-almeria	2024-09-08 17:20:00	36	notstarted	\N	896
897	3	1793	1794	1793	1794	villarreal-girona-fc	2024-04-28 12:50:00	17	finished	away	897
898	3	1795	1796	1795	1796	girona-fc-villarreal	2024-09-08 18:40:00	36	notstarted	\N	898
899	3	1797	1798	1797	1798	osasuna-celta-vigo	2024-04-28 15:20:00	17	finished	home	899
900	3	1799	1800	1799	1800	celta-vigo-osasuna	2024-09-08 12:10:00	36	notstarted	\N	900
901	3	1801	1802	1801	1802	girona-fc-mallorca	2024-05-04 18:20:00	18	finished	draw	901
902	3	1803	1804	1803	1804	mallorca-girona-fc	2024-09-14 13:30:00	37	notstarted	\N	902
903	3	1805	1806	1805	1806	las-palmas-real-sociedad	2024-05-04 14:50:00	18	finished	draw	903
904	3	1807	1808	1807	1808	real-sociedad-las-palmas	2024-09-14 19:30:00	37	notstarted	\N	904
905	3	1809	1810	1809	1810	barcelona-valencia	2024-05-04 19:40:00	18	finished	draw	905
906	3	1811	1812	1811	1812	valencia-barcelona	2024-09-14 15:50:00	37	notstarted	\N	906
907	3	1813	1814	1813	1814	almeria-villarreal	2024-05-04 13:10:00	18	finished	draw	907
908	3	1815	1816	1815	1816	villarreal-almeria	2024-09-14 14:20:00	37	notstarted	\N	908
909	3	1817	1818	1817	1818	osasuna-getafe	2024-05-04 12:10:00	18	finished	away	909
910	3	1819	1820	1819	1820	getafe-osasuna	2024-09-14 16:50:00	37	notstarted	\N	910
911	3	1821	1822	1821	1822	real-betis-rayo-vallecano	2024-05-05 18:00:00	18	finished	away	911
912	3	1823	1824	1823	1824	rayo-vallecano-real-betis	2024-09-15 19:10:00	37	notstarted	\N	912
913	3	1825	1826	1825	1826	sevilla-granada	2024-05-05 17:20:00	18	finished	away	913
914	3	1827	1828	1827	1828	granada-sevilla	2024-09-15 18:20:00	37	notstarted	\N	914
915	3	1829	1830	1829	1830	athletic-club-real-madrid	2024-05-05 18:10:00	18	finished	away	915
916	3	1831	1832	1831	1832	real-madrid-athletic-club	2024-09-15 19:40:00	37	notstarted	\N	916
917	3	1833	1834	1833	1834	cadiz-atletico-madrid	2024-05-05 12:40:00	18	finished	draw	917
918	3	1835	1836	1835	1836	atletico-madrid-cadiz	2024-09-15 17:30:00	37	notstarted	\N	918
919	3	1837	1838	1837	1838	celta-vigo-deportivo-alaves	2024-05-05 10:30:00	18	finished	home	919
920	3	1839	1840	1839	1840	deportivo-alaves-celta-vigo	2024-09-15 11:00:00	37	notstarted	\N	920
921	3	1841	1842	1841	1842	atletico-madrid-villarreal	2024-05-11 11:10:00	19	finished	home	921
922	3	1843	1844	1843	1844	villarreal-atletico-madrid	2024-09-21 17:50:00	38	notstarted	\N	922
923	3	1845	1846	1845	1846	celta-vigo-girona-fc	2024-05-11 15:10:00	19	finished	draw	923
924	3	1847	1848	1847	1848	girona-fc-celta-vigo	2024-09-21 12:50:00	38	notstarted	\N	924
925	3	1849	1850	1849	1850	barcelona-las-palmas	2024-05-11 14:50:00	19	finished	home	925
926	3	1851	1852	1851	1852	las-palmas-barcelona	2024-09-21 16:10:00	38	notstarted	\N	926
927	3	1853	1854	1853	1854	sevilla-almeria	2024-05-11 11:40:00	19	finished	home	927
928	3	1855	1856	1855	1856	almeria-sevilla	2024-09-21 14:40:00	38	notstarted	\N	928
929	3	1857	1858	1857	1858	rayo-vallecano-real-sociedad	2024-05-11 15:10:00	19	finished	draw	929
930	3	1859	1860	1859	1860	real-sociedad-rayo-vallecano	2024-09-21 18:50:00	38	notstarted	\N	930
931	3	1861	1862	1861	1862	real-betis-athletic-club	2024-05-12 18:50:00	19	finished	away	931
932	3	1863	1864	1863	1864	athletic-club-real-betis	2024-09-22 14:30:00	38	notstarted	\N	932
933	3	1865	1866	1865	1866	mallorca-osasuna	2024-05-12 13:30:00	19	finished	home	933
934	3	1867	1868	1867	1868	osasuna-mallorca	2024-09-22 12:40:00	38	notstarted	\N	934
935	3	1869	1870	1869	1870	deportivo-alaves-real-madrid	2024-05-12 18:20:00	19	finished	draw	935
936	3	1871	1872	1871	1872	real-madrid-deportivo-alaves	2024-09-22 13:50:00	38	notstarted	\N	936
937	3	1873	1874	1873	1874	valencia-granada	2024-05-12 14:00:00	19	finished	home	937
938	3	1875	1876	1875	1876	granada-valencia	2024-09-22 15:40:00	38	notstarted	\N	938
939	3	1877	1878	1877	1878	cadiz-getafe	2024-05-12 18:20:00	19	finished	away	939
940	3	1879	1880	1879	1880	getafe-cadiz	2024-09-22 12:50:00	38	notstarted	\N	940
941	4	1881	1882	1881	1882	minnesota-timberwolves-new-orleans-pelicans	2024-01-06 15:50:00	1	finished	home	941
942	4	1883	1884	1883	1884	new-orleans-pelicans-minnesota-timberwolves	2024-07-27 12:40:00	30	notstarted	\N	942
943	4	1885	1886	1885	1886	dallas-mavericks-atlanta-hawks	2024-01-06 18:30:00	1	finished	home	943
944	4	1887	1888	1887	1888	atlanta-hawks-dallas-mavericks	2024-07-27 14:20:00	30	notstarted	\N	944
945	4	1889	1890	1889	1890	orlando-magic-brooklyn-nets	2024-01-06 12:50:00	1	finished	home	945
946	4	1891	1892	1891	1892	brooklyn-nets-orlando-magic	2024-07-27 10:40:00	30	notstarted	\N	946
947	4	1893	1894	1893	1894	los-angeles-lakers-new-york-knicks	2024-01-06 19:00:00	1	finished	away	947
948	4	1895	1896	1895	1896	new-york-knicks-los-angeles-lakers	2024-07-27 14:00:00	30	notstarted	\N	948
949	4	1897	1898	1897	1898	oklahoma-city-thunder-washington-wizards	2024-01-06 18:20:00	1	finished	away	949
950	4	1899	1900	1899	1900	washington-wizards-oklahoma-city-thunder	2024-07-27 19:50:00	30	notstarted	\N	950
951	4	1901	1902	1901	1902	toronto-raptors-boston-celtics	2024-01-06 12:50:00	1	finished	home	951
952	4	1903	1904	1903	1904	boston-celtics-toronto-raptors	2024-07-27 11:50:00	30	notstarted	\N	952
953	4	1905	1906	1905	1906	utah-jazz-houston-rockets	2024-01-06 15:40:00	1	finished	away	953
954	4	1907	1908	1907	1908	houston-rockets-utah-jazz	2024-07-27 16:50:00	30	notstarted	\N	954
955	4	1909	1910	1909	1910	phoenix-suns-detroit-pistons	2024-01-06 16:50:00	1	finished	home	955
956	4	1911	1912	1911	1912	detroit-pistons-phoenix-suns	2024-07-27 19:30:00	30	notstarted	\N	956
957	4	1913	1914	1913	1914	san-antonio-spurs-sacramento-kings	2024-01-07 14:50:00	1	finished	away	957
958	4	1915	1916	1915	1916	sacramento-kings-san-antonio-spurs	2024-07-28 16:20:00	30	notstarted	\N	958
959	4	1917	1918	1917	1918	denver-nuggets-miami-heat	2024-01-07 16:30:00	1	finished	home	959
960	4	1919	1920	1919	1920	miami-heat-denver-nuggets	2024-07-28 14:50:00	30	notstarted	\N	960
961	4	1921	1922	1921	1922	indiana-pacers-golden-state-warriors	2024-01-07 17:00:00	1	finished	away	961
962	4	1923	1924	1923	1924	golden-state-warriors-indiana-pacers	2024-07-28 10:10:00	30	notstarted	\N	962
963	4	1925	1926	1925	1926	charlotte-hornets-cleveland-cavaliers	2024-01-07 14:00:00	1	finished	away	963
964	4	1927	1928	1927	1928	cleveland-cavaliers-charlotte-hornets	2024-07-28 11:10:00	30	notstarted	\N	964
965	4	1929	1930	1929	1930	milwaukee-bucks-philadelphia-76ers	2024-01-07 19:50:00	1	finished	away	965
966	4	1931	1932	1931	1932	philadelphia-76ers-milwaukee-bucks	2024-07-28 18:50:00	30	notstarted	\N	966
967	4	1933	1934	1933	1934	chicago-bulls-memphis-grizzlies	2024-01-07 13:30:00	1	finished	away	967
968	4	1935	1936	1935	1936	memphis-grizzlies-chicago-bulls	2024-07-28 10:30:00	30	notstarted	\N	968
969	4	1937	1938	1937	1938	portland-trail-blazers-los-angeles-clippers	2024-01-07 11:00:00	1	finished	home	969
970	4	1939	1940	1939	1940	los-angeles-clippers-portland-trail-blazers	2024-07-28 12:50:00	30	notstarted	\N	970
971	4	1941	1942	1941	1942	new-york-knicks-toronto-raptors	2024-01-13 12:30:00	2	finished	away	971
972	4	1943	1944	1943	1944	toronto-raptors-new-york-knicks	2024-08-03 18:00:00	31	notstarted	\N	972
973	4	1945	1946	1945	1946	portland-trail-blazers-brooklyn-nets	2024-01-13 11:40:00	2	finished	home	973
974	4	1947	1948	1947	1948	brooklyn-nets-portland-trail-blazers	2024-08-03 11:30:00	31	notstarted	\N	974
975	4	1949	1950	1949	1950	atlanta-hawks-los-angeles-lakers	2024-01-13 19:30:00	2	finished	away	975
976	4	1951	1952	1951	1952	los-angeles-lakers-atlanta-hawks	2024-08-03 10:30:00	31	notstarted	\N	976
977	4	1953	1954	1953	1954	indiana-pacers-philadelphia-76ers	2024-01-13 19:20:00	2	finished	away	977
978	4	1955	1956	1955	1956	philadelphia-76ers-indiana-pacers	2024-08-03 16:50:00	31	notstarted	\N	978
979	4	1957	1958	1957	1958	sacramento-kings-oklahoma-city-thunder	2024-01-13 17:30:00	2	finished	away	979
980	4	1959	1960	1959	1960	oklahoma-city-thunder-sacramento-kings	2024-08-03 14:10:00	31	notstarted	\N	980
981	4	1961	1962	1961	1962	detroit-pistons-washington-wizards	2024-01-13 13:20:00	2	finished	away	981
982	4	1963	1964	1963	1964	washington-wizards-detroit-pistons	2024-08-03 17:40:00	31	notstarted	\N	982
983	4	1965	1966	1965	1966	charlotte-hornets-phoenix-suns	2024-01-13 11:20:00	2	finished	home	983
984	4	1967	1968	1967	1968	phoenix-suns-charlotte-hornets	2024-08-03 18:40:00	31	notstarted	\N	984
985	4	1969	1970	1969	1970	denver-nuggets-los-angeles-clippers	2024-01-13 15:50:00	2	finished	home	985
986	4	1971	1972	1971	1972	los-angeles-clippers-denver-nuggets	2024-08-03 18:30:00	31	notstarted	\N	986
987	4	1973	1974	1973	1974	utah-jazz-minnesota-timberwolves	2024-01-14 11:10:00	2	finished	home	987
988	4	1975	1976	1975	1976	minnesota-timberwolves-utah-jazz	2024-08-04 17:50:00	31	notstarted	\N	988
989	4	1977	1978	1977	1978	boston-celtics-houston-rockets	2024-01-14 17:20:00	2	finished	home	989
990	4	1979	1980	1979	1980	houston-rockets-boston-celtics	2024-08-04 10:30:00	31	notstarted	\N	990
991	4	1981	1982	1981	1982	new-orleans-pelicans-orlando-magic	2024-01-14 10:50:00	2	finished	home	991
992	4	1983	1984	1983	1984	orlando-magic-new-orleans-pelicans	2024-08-04 11:50:00	31	notstarted	\N	992
993	4	1985	1986	1985	1986	memphis-grizzlies-dallas-mavericks	2024-01-14 16:00:00	2	finished	home	993
994	4	1987	1988	1987	1988	dallas-mavericks-memphis-grizzlies	2024-08-04 19:50:00	31	notstarted	\N	994
995	4	1989	1990	1989	1990	golden-state-warriors-milwaukee-bucks	2024-01-14 19:50:00	2	finished	home	995
996	4	1991	1992	1991	1992	milwaukee-bucks-golden-state-warriors	2024-08-04 14:40:00	31	notstarted	\N	996
997	4	1993	1994	1993	1994	chicago-bulls-cleveland-cavaliers	2024-01-14 10:10:00	2	finished	home	997
998	4	1995	1996	1995	1996	cleveland-cavaliers-chicago-bulls	2024-08-04 15:00:00	31	notstarted	\N	998
999	4	1997	1998	1997	1998	san-antonio-spurs-miami-heat	2024-01-14 15:20:00	2	finished	home	999
1000	4	1999	2000	1999	2000	miami-heat-san-antonio-spurs	2024-08-04 12:20:00	31	notstarted	\N	1000
1001	4	2001	2002	2001	2002	oklahoma-city-thunder-toronto-raptors	2024-01-20 17:50:00	3	finished	home	1001
1002	4	2003	2004	2003	2004	toronto-raptors-oklahoma-city-thunder	2024-08-10 18:50:00	32	notstarted	\N	1002
1003	4	2005	2006	2005	2006	los-angeles-clippers-charlotte-hornets	2024-01-20 11:10:00	3	finished	home	1003
1004	4	2007	2008	2007	2008	charlotte-hornets-los-angeles-clippers	2024-08-10 13:40:00	32	notstarted	\N	1004
1005	4	2009	2010	2009	2010	portland-trail-blazers-sacramento-kings	2024-01-20 10:10:00	3	finished	home	1005
1006	4	2011	2012	2011	2012	sacramento-kings-portland-trail-blazers	2024-08-10 10:00:00	32	notstarted	\N	1006
1007	4	2013	2014	2013	2014	los-angeles-lakers-minnesota-timberwolves	2024-01-20 16:30:00	3	finished	home	1007
1008	4	2015	2016	2015	2016	minnesota-timberwolves-los-angeles-lakers	2024-08-10 13:10:00	32	notstarted	\N	1008
1009	4	2017	2018	2017	2018	utah-jazz-new-orleans-pelicans	2024-01-20 16:10:00	3	finished	away	1009
1010	4	2019	2020	2019	2020	new-orleans-pelicans-utah-jazz	2024-08-10 17:20:00	32	notstarted	\N	1010
1011	4	2021	2022	2021	2022	boston-celtics-atlanta-hawks	2024-01-20 11:50:00	3	finished	home	1011
1012	4	2023	2024	2023	2024	atlanta-hawks-boston-celtics	2024-08-10 10:00:00	32	notstarted	\N	1012
1013	4	2025	2026	2025	2026	cleveland-cavaliers-dallas-mavericks	2024-01-20 10:20:00	3	finished	away	1013
1014	4	2027	2028	2027	2028	dallas-mavericks-cleveland-cavaliers	2024-08-10 19:00:00	32	notstarted	\N	1014
1015	4	2029	2030	2029	2030	chicago-bulls-denver-nuggets	2024-01-20 19:50:00	3	finished	away	1015
1016	4	2031	2032	2031	2032	denver-nuggets-chicago-bulls	2024-08-10 19:20:00	32	notstarted	\N	1016
1017	4	2033	2034	2033	2034	houston-rockets-philadelphia-76ers	2024-01-21 12:30:00	3	finished	home	1017
1018	4	2035	2036	2035	2036	philadelphia-76ers-houston-rockets	2024-08-11 16:00:00	32	notstarted	\N	1018
1019	4	2037	2038	2037	2038	new-york-knicks-brooklyn-nets	2024-01-21 10:30:00	3	finished	home	1019
1020	4	2039	2040	2039	2040	brooklyn-nets-new-york-knicks	2024-08-11 18:20:00	32	notstarted	\N	1020
1021	4	2041	2042	2041	2042	miami-heat-indiana-pacers	2024-01-21 14:00:00	3	finished	home	1021
1022	4	2043	2044	2043	2044	indiana-pacers-miami-heat	2024-08-11 14:50:00	32	notstarted	\N	1022
1023	4	2045	2046	2045	2046	san-antonio-spurs-golden-state-warriors	2024-01-21 17:40:00	3	finished	home	1023
1024	4	2047	2048	2047	2048	golden-state-warriors-san-antonio-spurs	2024-08-11 18:00:00	32	notstarted	\N	1024
1025	4	2049	2050	2049	2050	detroit-pistons-memphis-grizzlies	2024-01-21 18:20:00	3	finished	home	1025
1026	4	2051	2052	2051	2052	memphis-grizzlies-detroit-pistons	2024-08-11 10:00:00	32	notstarted	\N	1026
1027	4	2053	2054	2053	2054	orlando-magic-washington-wizards	2024-01-21 11:30:00	3	finished	away	1027
1028	4	2055	2056	2055	2056	washington-wizards-orlando-magic	2024-08-11 13:50:00	32	notstarted	\N	1028
1029	4	2057	2058	2057	2058	milwaukee-bucks-phoenix-suns	2024-01-21 19:50:00	3	finished	home	1029
1030	4	2059	2060	2059	2060	phoenix-suns-milwaukee-bucks	2024-08-11 18:40:00	32	notstarted	\N	1030
1031	4	2061	2062	2061	2062	dallas-mavericks-golden-state-warriors	2024-01-27 19:50:00	4	finished	away	1031
1032	4	2063	2064	2063	2064	golden-state-warriors-dallas-mavericks	2024-08-17 14:20:00	33	notstarted	\N	1032
1033	4	2065	2066	2065	2066	brooklyn-nets-philadelphia-76ers	2024-01-27 15:50:00	4	finished	away	1033
1034	4	2067	2068	2067	2068	philadelphia-76ers-brooklyn-nets	2024-08-17 19:00:00	33	notstarted	\N	1034
1035	4	2069	2070	2069	2070	minnesota-timberwolves-portland-trail-blazers	2024-01-27 11:30:00	4	finished	away	1035
1036	4	2071	2072	2071	2072	portland-trail-blazers-minnesota-timberwolves	2024-08-17 10:10:00	33	notstarted	\N	1036
1037	4	2073	2074	2073	2074	miami-heat-orlando-magic	2024-01-27 15:20:00	4	finished	away	1037
1038	4	2075	2076	2075	2076	orlando-magic-miami-heat	2024-08-17 10:30:00	33	notstarted	\N	1038
1039	4	2077	2078	2077	2078	cleveland-cavaliers-toronto-raptors	2024-01-27 13:20:00	4	finished	away	1039
1040	4	2079	2080	2079	2080	toronto-raptors-cleveland-cavaliers	2024-08-17 10:00:00	33	notstarted	\N	1040
1041	4	2081	2082	2081	2082	washington-wizards-new-york-knicks	2024-01-27 17:40:00	4	finished	home	1041
1042	4	2083	2084	2083	2084	new-york-knicks-washington-wizards	2024-08-17 13:30:00	33	notstarted	\N	1042
1043	4	2085	2086	2085	2086	utah-jazz-charlotte-hornets	2024-01-27 19:10:00	4	finished	home	1043
1044	4	2087	2088	2087	2088	charlotte-hornets-utah-jazz	2024-08-17 18:40:00	33	notstarted	\N	1044
1045	4	2089	2090	2089	2090	oklahoma-city-thunder-phoenix-suns	2024-01-27 19:50:00	4	finished	away	1045
1046	4	2091	2092	2091	2092	phoenix-suns-oklahoma-city-thunder	2024-08-17 14:00:00	33	notstarted	\N	1046
1047	4	2093	2094	2093	2094	new-orleans-pelicans-memphis-grizzlies	2024-01-28 16:40:00	4	finished	home	1047
1048	4	2095	2096	2095	2096	memphis-grizzlies-new-orleans-pelicans	2024-08-18 16:10:00	33	notstarted	\N	1048
1049	4	2097	2098	2097	2098	indiana-pacers-houston-rockets	2024-01-28 13:20:00	4	finished	away	1049
1050	4	2099	2100	2099	2100	houston-rockets-indiana-pacers	2024-08-18 19:40:00	33	notstarted	\N	1050
1051	4	2101	2102	2101	2102	chicago-bulls-los-angeles-lakers	2024-01-28 19:00:00	4	finished	home	1051
1052	4	2103	2104	2103	2104	los-angeles-lakers-chicago-bulls	2024-08-18 11:20:00	33	notstarted	\N	1052
1053	4	2105	2106	2105	2106	atlanta-hawks-denver-nuggets	2024-01-28 16:30:00	4	finished	home	1053
1054	4	2107	2108	2107	2108	denver-nuggets-atlanta-hawks	2024-08-18 15:10:00	33	notstarted	\N	1054
1055	4	2109	2110	2109	2110	detroit-pistons-sacramento-kings	2024-01-28 15:50:00	4	finished	home	1055
1056	4	2111	2112	2111	2112	sacramento-kings-detroit-pistons	2024-08-18 11:50:00	33	notstarted	\N	1056
1057	4	2113	2114	2113	2114	milwaukee-bucks-los-angeles-clippers	2024-01-28 15:30:00	4	finished	away	1057
1058	4	2115	2116	2115	2116	los-angeles-clippers-milwaukee-bucks	2024-08-18 11:00:00	33	notstarted	\N	1058
1059	4	2117	2118	2117	2118	boston-celtics-san-antonio-spurs	2024-01-28 12:40:00	4	finished	home	1059
1060	4	2119	2120	2119	2120	san-antonio-spurs-boston-celtics	2024-08-18 10:30:00	33	notstarted	\N	1060
1061	4	2121	2122	2121	2122	washington-wizards-denver-nuggets	2024-02-03 18:10:00	5	finished	away	1061
1062	4	2123	2124	2123	2124	denver-nuggets-washington-wizards	2024-08-24 18:50:00	34	notstarted	\N	1062
1063	4	2125	2126	2125	2126	cleveland-cavaliers-detroit-pistons	2024-02-03 16:40:00	5	finished	away	1063
1064	4	2127	2128	2127	2128	detroit-pistons-cleveland-cavaliers	2024-08-24 13:00:00	34	notstarted	\N	1064
1065	4	2129	2130	2129	2130	miami-heat-new-york-knicks	2024-02-03 11:50:00	5	finished	home	1065
1066	4	2131	2132	2131	2132	new-york-knicks-miami-heat	2024-08-24 11:00:00	34	notstarted	\N	1066
1067	4	2133	2134	2133	2134	philadelphia-76ers-orlando-magic	2024-02-03 16:30:00	5	finished	away	1067
1068	4	2135	2136	2135	2136	orlando-magic-philadelphia-76ers	2024-08-24 16:30:00	34	notstarted	\N	1068
1069	4	2137	2138	2137	2138	atlanta-hawks-indiana-pacers	2024-02-03 16:10:00	5	finished	away	1069
1070	4	2139	2140	2139	2140	indiana-pacers-atlanta-hawks	2024-08-24 14:20:00	34	notstarted	\N	1070
1071	4	2141	2142	2141	2142	phoenix-suns-new-orleans-pelicans	2024-02-03 18:40:00	5	finished	away	1071
1072	4	2143	2144	2143	2144	new-orleans-pelicans-phoenix-suns	2024-08-24 17:30:00	34	notstarted	\N	1072
1073	4	2145	2146	2145	2146	houston-rockets-milwaukee-bucks	2024-02-03 10:10:00	5	finished	away	1073
1074	4	2147	2148	2147	2148	milwaukee-bucks-houston-rockets	2024-08-24 18:00:00	34	notstarted	\N	1074
1075	4	2149	2150	2149	2150	sacramento-kings-toronto-raptors	2024-02-03 13:20:00	5	finished	home	1075
1076	4	2151	2152	2151	2152	toronto-raptors-sacramento-kings	2024-08-24 11:50:00	34	notstarted	\N	1076
1077	4	2153	2154	2153	2154	los-angeles-lakers-utah-jazz	2024-02-04 14:40:00	5	finished	away	1077
1078	4	2155	2156	2155	2156	utah-jazz-los-angeles-lakers	2024-08-25 18:40:00	34	notstarted	\N	1078
1079	4	2157	2158	2157	2158	los-angeles-clippers-oklahoma-city-thunder	2024-02-04 12:10:00	5	finished	away	1079
1080	4	2159	2160	2159	2160	oklahoma-city-thunder-los-angeles-clippers	2024-08-25 19:50:00	34	notstarted	\N	1080
1081	4	2161	2162	2161	2162	dallas-mavericks-minnesota-timberwolves	2024-02-04 19:40:00	5	finished	away	1081
1082	4	2163	2164	2163	2164	minnesota-timberwolves-dallas-mavericks	2024-08-25 10:10:00	34	notstarted	\N	1082
1083	4	2165	2166	2165	2166	golden-state-warriors-memphis-grizzlies	2024-02-04 12:10:00	5	finished	away	1083
1084	4	2167	2168	2167	2168	memphis-grizzlies-golden-state-warriors	2024-08-25 12:10:00	34	notstarted	\N	1084
1085	4	2169	2170	2169	2170	boston-celtics-brooklyn-nets	2024-02-04 17:30:00	5	finished	away	1085
1086	4	2171	2172	2171	2172	brooklyn-nets-boston-celtics	2024-08-25 12:20:00	34	notstarted	\N	1086
1087	4	2173	2174	2173	2174	san-antonio-spurs-portland-trail-blazers	2024-02-04 14:40:00	5	finished	away	1087
1088	4	2175	2176	2175	2176	portland-trail-blazers-san-antonio-spurs	2024-08-25 16:30:00	34	notstarted	\N	1088
1089	4	2177	2178	2177	2178	charlotte-hornets-chicago-bulls	2024-02-04 10:00:00	5	finished	away	1089
1090	4	2179	2180	2179	2180	chicago-bulls-charlotte-hornets	2024-08-25 19:50:00	34	notstarted	\N	1090
1091	4	2181	2182	2181	2182	indiana-pacers-new-york-knicks	2024-02-10 17:30:00	6	finished	away	1091
1092	4	2183	2184	2183	2184	new-york-knicks-indiana-pacers	2024-08-31 11:40:00	35	notstarted	\N	1092
1093	4	2185	2186	2185	2186	portland-trail-blazers-new-orleans-pelicans	2024-02-10 12:40:00	6	finished	home	1093
1094	4	2187	2188	2187	2188	new-orleans-pelicans-portland-trail-blazers	2024-08-31 17:30:00	35	notstarted	\N	1094
1095	4	2189	2190	2189	2190	san-antonio-spurs-oklahoma-city-thunder	2024-02-10 15:30:00	6	finished	away	1095
1096	4	2191	2192	2191	2192	oklahoma-city-thunder-san-antonio-spurs	2024-08-31 18:50:00	35	notstarted	\N	1096
1097	4	2193	2194	2193	2194	miami-heat-los-angeles-clippers	2024-02-10 12:30:00	6	finished	home	1097
1098	4	2195	2196	2195	2196	los-angeles-clippers-miami-heat	2024-08-31 11:00:00	35	notstarted	\N	1098
1099	4	2197	2198	2197	2198	houston-rockets-charlotte-hornets	2024-02-10 17:40:00	6	finished	home	1099
1100	4	2199	2200	2199	2200	charlotte-hornets-houston-rockets	2024-08-31 11:00:00	35	notstarted	\N	1100
1101	4	2201	2202	2201	2202	minnesota-timberwolves-milwaukee-bucks	2024-02-10 17:00:00	6	finished	home	1101
1102	4	2203	2204	2203	2204	milwaukee-bucks-minnesota-timberwolves	2024-08-31 13:10:00	35	notstarted	\N	1102
1103	4	2205	2206	2205	2206	los-angeles-lakers-cleveland-cavaliers	2024-02-10 17:00:00	6	finished	away	1103
1104	4	2207	2208	2207	2208	cleveland-cavaliers-los-angeles-lakers	2024-08-31 10:40:00	35	notstarted	\N	1104
1105	4	2209	2210	2209	2210	detroit-pistons-philadelphia-76ers	2024-02-10 13:30:00	6	finished	home	1105
1106	4	2211	2212	2211	2212	philadelphia-76ers-detroit-pistons	2024-08-31 19:20:00	35	notstarted	\N	1106
1107	4	2213	2214	2213	2214	phoenix-suns-atlanta-hawks	2024-02-11 11:40:00	6	finished	home	1107
1108	4	2215	2216	2215	2216	atlanta-hawks-phoenix-suns	2024-09-01 18:30:00	35	notstarted	\N	1108
1109	4	2217	2218	2217	2218	utah-jazz-boston-celtics	2024-02-11 13:20:00	6	finished	home	1109
1110	4	2219	2220	2219	2220	boston-celtics-utah-jazz	2024-09-01 14:40:00	35	notstarted	\N	1110
1111	4	2221	2222	2221	2222	denver-nuggets-memphis-grizzlies	2024-02-11 12:20:00	6	finished	home	1111
1112	4	2223	2224	2223	2224	memphis-grizzlies-denver-nuggets	2024-09-01 17:20:00	35	notstarted	\N	1112
1113	4	2225	2226	2225	2226	chicago-bulls-washington-wizards	2024-02-11 16:30:00	6	finished	away	1113
1114	4	2227	2228	2227	2228	washington-wizards-chicago-bulls	2024-09-01 16:00:00	35	notstarted	\N	1114
1115	4	2229	2230	2229	2230	golden-state-warriors-brooklyn-nets	2024-02-11 14:20:00	6	finished	home	1115
1116	4	2231	2232	2231	2232	brooklyn-nets-golden-state-warriors	2024-09-01 15:40:00	35	notstarted	\N	1116
1117	4	2233	2234	2233	2234	dallas-mavericks-toronto-raptors	2024-02-11 13:10:00	6	finished	away	1117
1118	4	2235	2236	2235	2236	toronto-raptors-dallas-mavericks	2024-09-01 18:00:00	35	notstarted	\N	1118
1119	4	2237	2238	2237	2238	sacramento-kings-orlando-magic	2024-02-11 15:10:00	6	finished	home	1119
1120	4	2239	2240	2239	2240	orlando-magic-sacramento-kings	2024-09-01 10:10:00	35	notstarted	\N	1120
1121	4	2241	2242	2241	2242	minnesota-timberwolves-miami-heat	2024-02-17 15:50:00	7	finished	away	1121
1122	4	2243	2244	2243	2244	miami-heat-minnesota-timberwolves	2024-09-07 13:40:00	36	notstarted	\N	1122
1123	4	2245	2246	2245	2246	portland-trail-blazers-dallas-mavericks	2024-02-17 17:50:00	7	finished	home	1123
1124	4	2247	2248	2247	2248	dallas-mavericks-portland-trail-blazers	2024-09-07 18:10:00	36	notstarted	\N	1124
1125	4	2249	2250	2249	2250	chicago-bulls-houston-rockets	2024-02-17 18:20:00	7	finished	home	1125
1126	4	2251	2252	2251	2252	houston-rockets-chicago-bulls	2024-09-07 19:20:00	36	notstarted	\N	1126
1127	4	2253	2254	2253	2254	atlanta-hawks-new-york-knicks	2024-02-17 12:40:00	7	finished	home	1127
1128	4	2255	2256	2255	2256	new-york-knicks-atlanta-hawks	2024-09-07 13:30:00	36	notstarted	\N	1128
1129	4	2257	2258	2257	2258	boston-celtics-phoenix-suns	2024-02-17 15:20:00	7	finished	home	1129
1130	4	2259	2260	2259	2260	phoenix-suns-boston-celtics	2024-09-07 18:40:00	36	notstarted	\N	1130
1131	4	2261	2262	2261	2262	memphis-grizzlies-cleveland-cavaliers	2024-02-17 17:50:00	7	finished	away	1131
1132	4	2263	2264	2263	2264	cleveland-cavaliers-memphis-grizzlies	2024-09-07 10:10:00	36	notstarted	\N	1132
1133	4	2265	2266	2265	2266	charlotte-hornets-golden-state-warriors	2024-02-17 13:10:00	7	finished	away	1133
1134	4	2267	2268	2267	2268	golden-state-warriors-charlotte-hornets	2024-09-07 19:40:00	36	notstarted	\N	1134
1135	4	2269	2270	2269	2270	milwaukee-bucks-utah-jazz	2024-02-17 16:00:00	7	finished	home	1135
1136	4	2271	2272	2271	2272	utah-jazz-milwaukee-bucks	2024-09-07 16:20:00	36	notstarted	\N	1136
1137	4	2273	2274	2273	2274	indiana-pacers-denver-nuggets	2024-02-18 11:30:00	7	finished	away	1137
1138	4	2275	2276	2275	2276	denver-nuggets-indiana-pacers	2024-09-08 18:30:00	36	notstarted	\N	1138
1139	4	2277	2278	2277	2278	los-angeles-clippers-detroit-pistons	2024-02-18 13:30:00	7	finished	home	1139
1140	4	2279	2280	2279	2280	detroit-pistons-los-angeles-clippers	2024-09-08 15:40:00	36	notstarted	\N	1140
1141	4	2281	2282	2281	2282	new-orleans-pelicans-philadelphia-76ers	2024-02-18 15:00:00	7	finished	away	1141
1142	4	2283	2284	2283	2284	philadelphia-76ers-new-orleans-pelicans	2024-09-08 13:30:00	36	notstarted	\N	1142
1143	4	2285	2286	2285	2286	washington-wizards-sacramento-kings	2024-02-18 12:00:00	7	finished	away	1143
1144	4	2287	2288	2287	2288	sacramento-kings-washington-wizards	2024-09-08 16:20:00	36	notstarted	\N	1144
1145	4	2289	2290	2289	2290	oklahoma-city-thunder-orlando-magic	2024-02-18 10:00:00	7	finished	away	1145
1146	4	2291	2292	2291	2292	orlando-magic-oklahoma-city-thunder	2024-09-08 11:20:00	36	notstarted	\N	1146
1147	4	2293	2294	2293	2294	toronto-raptors-san-antonio-spurs	2024-02-18 12:40:00	7	finished	home	1147
1148	4	2295	2296	2295	2296	san-antonio-spurs-toronto-raptors	2024-09-08 11:20:00	36	notstarted	\N	1148
1149	4	2297	2298	2297	2298	brooklyn-nets-los-angeles-lakers	2024-02-18 18:00:00	7	finished	home	1149
1150	4	2299	2300	2299	2300	los-angeles-lakers-brooklyn-nets	2024-09-08 15:40:00	36	notstarted	\N	1150
1151	4	2301	2302	2301	2302	orlando-magic-phoenix-suns	2024-02-24 19:40:00	8	finished	home	1151
1152	4	2303	2304	2303	2304	phoenix-suns-orlando-magic	2024-09-14 18:40:00	37	notstarted	\N	1152
1153	4	2305	2306	2305	2306	charlotte-hornets-oklahoma-city-thunder	2024-02-24 11:00:00	8	finished	home	1153
1154	4	2307	2308	2307	2308	oklahoma-city-thunder-charlotte-hornets	2024-09-14 16:20:00	37	notstarted	\N	1154
1155	4	2309	2310	2309	2310	cleveland-cavaliers-philadelphia-76ers	2024-02-24 14:50:00	8	finished	away	1155
1156	4	2311	2312	2311	2312	philadelphia-76ers-cleveland-cavaliers	2024-09-14 10:50:00	37	notstarted	\N	1156
1157	4	2313	2314	2313	2314	toronto-raptors-new-orleans-pelicans	2024-02-24 15:30:00	8	finished	away	1157
1158	4	2315	2316	2315	2316	new-orleans-pelicans-toronto-raptors	2024-09-14 10:10:00	37	notstarted	\N	1158
1159	4	2317	2318	2317	2318	los-angeles-clippers-new-york-knicks	2024-02-24 10:50:00	8	finished	home	1159
1160	4	2319	2320	2319	2320	new-york-knicks-los-angeles-clippers	2024-09-14 13:30:00	37	notstarted	\N	1160
1161	4	2321	2322	2321	2322	indiana-pacers-milwaukee-bucks	2024-02-24 14:00:00	8	finished	away	1161
1162	4	2323	2324	2323	2324	milwaukee-bucks-indiana-pacers	2024-09-14 19:20:00	37	notstarted	\N	1162
1163	4	2325	2326	2325	2326	utah-jazz-denver-nuggets	2024-02-24 16:30:00	8	finished	away	1163
1164	4	2327	2328	2327	2328	denver-nuggets-utah-jazz	2024-09-14 10:40:00	37	notstarted	\N	1164
1165	4	2329	2330	2329	2330	detroit-pistons-golden-state-warriors	2024-02-24 12:10:00	8	finished	home	1165
1166	4	2331	2332	2331	2332	golden-state-warriors-detroit-pistons	2024-09-14 19:10:00	37	notstarted	\N	1166
1167	4	2333	2334	2333	2334	memphis-grizzlies-washington-wizards	2024-02-25 19:20:00	8	finished	away	1167
1168	4	2335	2336	2335	2336	washington-wizards-memphis-grizzlies	2024-09-15 13:30:00	37	notstarted	\N	1168
1169	4	2337	2338	2337	2338	minnesota-timberwolves-brooklyn-nets	2024-02-25 19:20:00	8	finished	home	1169
1170	4	2339	2340	2339	2340	brooklyn-nets-minnesota-timberwolves	2024-09-15 14:00:00	37	notstarted	\N	1170
1171	4	2341	2342	2341	2342	houston-rockets-san-antonio-spurs	2024-02-25 16:30:00	8	finished	home	1171
1172	4	2343	2344	2343	2344	san-antonio-spurs-houston-rockets	2024-09-15 17:20:00	37	notstarted	\N	1172
1173	4	2345	2346	2345	2346	portland-trail-blazers-chicago-bulls	2024-02-25 11:50:00	8	finished	away	1173
1174	4	2347	2348	2347	2348	chicago-bulls-portland-trail-blazers	2024-09-15 10:10:00	37	notstarted	\N	1174
1175	4	2349	2350	2349	2350	sacramento-kings-atlanta-hawks	2024-02-25 10:00:00	8	finished	home	1175
1176	4	2351	2352	2351	2352	atlanta-hawks-sacramento-kings	2024-09-15 17:10:00	37	notstarted	\N	1176
1177	4	2353	2354	2353	2354	miami-heat-los-angeles-lakers	2024-02-25 10:30:00	8	finished	home	1177
1178	4	2355	2356	2355	2356	los-angeles-lakers-miami-heat	2024-09-15 10:10:00	37	notstarted	\N	1178
1179	4	2357	2358	2357	2358	boston-celtics-dallas-mavericks	2024-02-25 13:50:00	8	finished	away	1179
1180	4	2359	2360	2359	2360	dallas-mavericks-boston-celtics	2024-09-15 12:20:00	37	notstarted	\N	1180
1181	4	2361	2362	2361	2362	charlotte-hornets-milwaukee-bucks	2024-03-02 19:40:00	9	finished	home	1181
1182	4	2363	2364	2363	2364	milwaukee-bucks-charlotte-hornets	2024-09-21 13:40:00	38	notstarted	\N	1182
1183	4	2365	2366	2365	2366	los-angeles-clippers-houston-rockets	2024-03-02 17:50:00	9	finished	home	1183
1184	4	2367	2368	2367	2368	houston-rockets-los-angeles-clippers	2024-09-21 12:00:00	38	notstarted	\N	1184
1185	4	2369	2370	2369	2370	portland-trail-blazers-washington-wizards	2024-03-02 12:00:00	9	finished	away	1185
1186	4	2371	2372	2371	2372	washington-wizards-portland-trail-blazers	2024-09-21 16:10:00	38	notstarted	\N	1186
1187	4	2373	2374	2373	2374	philadelphia-76ers-sacramento-kings	2024-03-02 19:50:00	9	finished	away	1187
1188	4	2375	2376	2375	2376	sacramento-kings-philadelphia-76ers	2024-09-21 12:10:00	38	notstarted	\N	1188
1189	4	2377	2378	2377	2378	phoenix-suns-brooklyn-nets	2024-03-02 15:40:00	9	finished	away	1189
1190	4	2379	2380	2379	2380	brooklyn-nets-phoenix-suns	2024-09-21 11:10:00	38	notstarted	\N	1190
1191	4	2381	2382	2381	2382	memphis-grizzlies-toronto-raptors	2024-03-02 15:10:00	9	finished	away	1191
1192	4	2383	2384	2383	2384	toronto-raptors-memphis-grizzlies	2024-09-21 15:40:00	38	notstarted	\N	1192
1193	4	2385	2386	2385	2386	orlando-magic-golden-state-warriors	2024-03-02 12:20:00	9	finished	away	1193
1194	4	2387	2388	2387	2388	golden-state-warriors-orlando-magic	2024-09-21 13:00:00	38	notstarted	\N	1194
1195	4	2389	2390	2389	2390	dallas-mavericks-chicago-bulls	2024-03-02 11:30:00	9	finished	home	1195
1196	4	2391	2392	2391	2392	chicago-bulls-dallas-mavericks	2024-09-21 10:00:00	38	notstarted	\N	1196
1197	4	2393	2394	2393	2394	los-angeles-lakers-detroit-pistons	2024-03-03 13:20:00	9	finished	away	1197
1198	4	2395	2396	2395	2396	detroit-pistons-los-angeles-lakers	2024-09-22 19:20:00	38	notstarted	\N	1198
1199	4	2397	2398	2397	2398	new-york-knicks-cleveland-cavaliers	2024-03-03 15:20:00	9	finished	home	1199
1200	4	2399	2400	2399	2400	cleveland-cavaliers-new-york-knicks	2024-09-22 12:00:00	38	notstarted	\N	1200
1201	4	2401	2402	2401	2402	san-antonio-spurs-atlanta-hawks	2024-03-03 18:30:00	9	finished	away	1201
1202	4	2403	2404	2403	2404	atlanta-hawks-san-antonio-spurs	2024-09-22 11:00:00	38	notstarted	\N	1202
1203	4	2405	2406	2405	2406	utah-jazz-indiana-pacers	2024-03-03 16:10:00	9	finished	home	1203
1204	4	2407	2408	2407	2408	indiana-pacers-utah-jazz	2024-09-22 15:50:00	38	notstarted	\N	1204
1205	4	2409	2410	2409	2410	new-orleans-pelicans-oklahoma-city-thunder	2024-03-03 19:10:00	9	finished	away	1205
1206	4	2411	2412	2411	2412	oklahoma-city-thunder-new-orleans-pelicans	2024-09-22 19:40:00	38	notstarted	\N	1206
1207	4	2413	2414	2413	2414	denver-nuggets-minnesota-timberwolves	2024-03-03 15:10:00	9	finished	away	1207
1208	4	2415	2416	2415	2416	minnesota-timberwolves-denver-nuggets	2024-09-22 17:20:00	38	notstarted	\N	1208
1209	4	2417	2418	2417	2418	boston-celtics-miami-heat	2024-03-03 14:00:00	9	finished	home	1209
1210	4	2419	2420	2419	2420	miami-heat-boston-celtics	2024-09-22 17:50:00	38	notstarted	\N	1210
1211	4	2421	2422	2421	2422	dallas-mavericks-charlotte-hornets	2024-03-09 15:10:00	10	finished	away	1211
1212	4	2423	2424	2423	2424	charlotte-hornets-dallas-mavericks	2024-09-28 14:50:00	39	notstarted	\N	1212
1213	4	2425	2426	2425	2426	minnesota-timberwolves-detroit-pistons	2024-03-09 12:30:00	10	finished	home	1213
1214	4	2427	2428	2427	2428	detroit-pistons-minnesota-timberwolves	2024-09-28 17:10:00	39	notstarted	\N	1214
1215	4	2429	2430	2429	2430	philadelphia-76ers-portland-trail-blazers	2024-03-09 18:30:00	10	finished	home	1215
1216	4	2431	2432	2431	2432	portland-trail-blazers-philadelphia-76ers	2024-09-28 11:00:00	39	notstarted	\N	1216
1217	4	2433	2434	2433	2434	miami-heat-milwaukee-bucks	2024-03-09 16:00:00	10	finished	home	1217
1218	4	2435	2436	2435	2436	milwaukee-bucks-miami-heat	2024-09-28 19:10:00	39	notstarted	\N	1218
1219	4	2437	2438	2437	2438	toronto-raptors-los-angeles-lakers	2024-03-09 15:10:00	10	finished	away	1219
1220	4	2439	2440	2439	2440	los-angeles-lakers-toronto-raptors	2024-09-28 11:40:00	39	notstarted	\N	1220
1221	4	2441	2442	2441	2442	chicago-bulls-new-york-knicks	2024-03-09 19:30:00	10	finished	home	1221
1222	4	2443	2444	2443	2444	new-york-knicks-chicago-bulls	2024-09-28 13:30:00	39	notstarted	\N	1222
1223	4	2445	2446	2445	2446	san-antonio-spurs-cleveland-cavaliers	2024-03-09 10:40:00	10	finished	away	1223
1224	4	2447	2448	2447	2448	cleveland-cavaliers-san-antonio-spurs	2024-09-28 12:50:00	39	notstarted	\N	1224
1225	4	2449	2450	2449	2450	washington-wizards-houston-rockets	2024-03-09 13:00:00	10	finished	away	1225
1226	4	2451	2452	2451	2452	houston-rockets-washington-wizards	2024-09-28 13:20:00	39	notstarted	\N	1226
1227	4	2453	2454	2453	2454	orlando-magic-denver-nuggets	2024-03-10 14:10:00	10	finished	home	1227
1228	4	2455	2456	2455	2456	denver-nuggets-orlando-magic	2024-09-29 14:10:00	39	notstarted	\N	1228
1229	4	2457	2458	2457	2458	new-orleans-pelicans-brooklyn-nets	2024-03-10 15:00:00	10	finished	home	1229
1230	4	2459	2460	2459	2460	brooklyn-nets-new-orleans-pelicans	2024-09-29 10:50:00	39	notstarted	\N	1230
1231	4	2461	2462	2461	2462	sacramento-kings-memphis-grizzlies	2024-03-10 17:10:00	10	finished	home	1231
1232	4	2463	2464	2463	2464	memphis-grizzlies-sacramento-kings	2024-09-29 10:40:00	39	notstarted	\N	1232
1233	4	2465	2466	2465	2466	atlanta-hawks-golden-state-warriors	2024-03-10 15:50:00	10	finished	away	1233
1234	4	2467	2468	2467	2468	golden-state-warriors-atlanta-hawks	2024-09-29 17:00:00	39	notstarted	\N	1234
1235	4	2469	2470	2469	2470	boston-celtics-indiana-pacers	2024-03-10 10:30:00	10	finished	home	1235
1236	4	2471	2472	2471	2472	indiana-pacers-boston-celtics	2024-09-29 13:00:00	39	notstarted	\N	1236
1237	4	2473	2474	2473	2474	utah-jazz-oklahoma-city-thunder	2024-03-10 10:30:00	10	finished	home	1237
1238	4	2475	2476	2475	2476	oklahoma-city-thunder-utah-jazz	2024-09-29 16:10:00	39	notstarted	\N	1238
1239	4	2477	2478	2477	2478	phoenix-suns-los-angeles-clippers	2024-03-10 13:00:00	10	finished	home	1239
1240	4	2479	2480	2479	2480	los-angeles-clippers-phoenix-suns	2024-09-29 13:30:00	39	notstarted	\N	1240
1241	4	2481	2482	2481	2482	miami-heat-toronto-raptors	2024-03-16 17:50:00	11	finished	away	1241
1242	4	2483	2484	2483	2484	toronto-raptors-miami-heat	2024-10-05 17:10:00	40	notstarted	\N	1242
1243	4	2485	2486	2485	2486	memphis-grizzlies-phoenix-suns	2024-03-16 12:40:00	11	finished	home	1243
1244	4	2487	2488	2487	2488	phoenix-suns-memphis-grizzlies	2024-10-05 14:20:00	40	notstarted	\N	1244
1245	4	2489	2490	2489	2490	new-york-knicks-portland-trail-blazers	2024-03-16 15:40:00	11	finished	home	1245
1246	4	2491	2492	2491	2492	portland-trail-blazers-new-york-knicks	2024-10-05 13:40:00	40	notstarted	\N	1246
1247	4	2493	2494	2493	2494	sacramento-kings-milwaukee-bucks	2024-03-16 16:40:00	11	finished	home	1247
1248	4	2495	2496	2495	2496	milwaukee-bucks-sacramento-kings	2024-10-05 13:00:00	40	notstarted	\N	1248
1249	4	2497	2498	2497	2498	dallas-mavericks-detroit-pistons	2024-03-16 14:00:00	11	finished	away	1249
1250	4	2499	2500	2499	2500	detroit-pistons-dallas-mavericks	2024-10-05 10:30:00	40	notstarted	\N	1250
1251	4	2501	2502	2501	2502	utah-jazz-los-angeles-clippers	2024-03-16 18:30:00	11	finished	away	1251
1252	4	2503	2504	2503	2504	los-angeles-clippers-utah-jazz	2024-10-05 17:00:00	40	notstarted	\N	1252
1253	4	2505	2506	2505	2506	washington-wizards-golden-state-warriors	2024-03-16 17:20:00	11	finished	home	1253
1254	4	2507	2508	2507	2508	golden-state-warriors-washington-wizards	2024-10-05 17:10:00	40	notstarted	\N	1254
1255	4	2509	2510	2509	2510	los-angeles-lakers-oklahoma-city-thunder	2024-03-16 12:20:00	11	finished	home	1255
1256	4	2511	2512	2511	2512	oklahoma-city-thunder-los-angeles-lakers	2024-10-05 11:50:00	40	notstarted	\N	1256
1257	4	2513	2514	2513	2514	charlotte-hornets-indiana-pacers	2024-03-17 13:10:00	11	finished	away	1257
1258	4	2515	2516	2515	2516	indiana-pacers-charlotte-hornets	2024-10-06 10:20:00	40	notstarted	\N	1258
1259	4	2517	2518	2517	2518	cleveland-cavaliers-boston-celtics	2024-03-17 18:20:00	11	finished	away	1259
1260	4	2519	2520	2519	2520	boston-celtics-cleveland-cavaliers	2024-10-06 13:20:00	40	notstarted	\N	1260
1261	4	2521	2522	2521	2522	atlanta-hawks-minnesota-timberwolves	2024-03-17 18:50:00	11	finished	away	1261
1262	4	2523	2524	2523	2524	minnesota-timberwolves-atlanta-hawks	2024-10-06 17:00:00	40	notstarted	\N	1262
1263	4	2525	2526	2525	2526	new-orleans-pelicans-san-antonio-spurs	2024-03-17 12:20:00	11	finished	home	1263
1264	4	2527	2528	2527	2528	san-antonio-spurs-new-orleans-pelicans	2024-10-06 11:20:00	40	notstarted	\N	1264
1265	4	2529	2530	2529	2530	denver-nuggets-brooklyn-nets	2024-03-17 11:10:00	11	finished	away	1265
1266	4	2531	2532	2531	2532	brooklyn-nets-denver-nuggets	2024-10-06 11:40:00	40	notstarted	\N	1266
1267	4	2533	2534	2533	2534	philadelphia-76ers-chicago-bulls	2024-03-17 18:50:00	11	finished	away	1267
1268	4	2535	2536	2535	2536	chicago-bulls-philadelphia-76ers	2024-10-06 12:50:00	40	notstarted	\N	1268
1269	4	2537	2538	2537	2538	orlando-magic-houston-rockets	2024-03-17 13:10:00	11	finished	away	1269
1270	4	2539	2540	2539	2540	houston-rockets-orlando-magic	2024-10-06 17:40:00	40	notstarted	\N	1270
1271	4	2541	2542	2541	2542	dallas-mavericks-los-angeles-lakers	2024-03-23 10:00:00	12	finished	away	1271
1272	4	2543	2544	2543	2544	los-angeles-lakers-dallas-mavericks	2024-10-12 12:00:00	41	notstarted	\N	1272
1273	4	2545	2546	2545	2546	washington-wizards-cleveland-cavaliers	2024-03-23 18:00:00	12	finished	home	1273
1274	4	2547	2548	2547	2548	cleveland-cavaliers-washington-wizards	2024-10-12 19:20:00	41	notstarted	\N	1274
1275	4	2549	2550	2549	2550	milwaukee-bucks-chicago-bulls	2024-03-23 15:40:00	12	finished	away	1275
1276	4	2551	2552	2551	2552	chicago-bulls-milwaukee-bucks	2024-10-12 17:30:00	41	notstarted	\N	1276
1277	4	2553	2554	2553	2554	toronto-raptors-golden-state-warriors	2024-03-23 10:10:00	12	finished	home	1277
1278	4	2555	2556	2555	2556	golden-state-warriors-toronto-raptors	2024-10-12 10:40:00	41	notstarted	\N	1278
1279	4	2557	2558	2557	2558	phoenix-suns-houston-rockets	2024-03-23 13:40:00	12	finished	away	1279
1280	4	2559	2560	2559	2560	houston-rockets-phoenix-suns	2024-10-12 14:50:00	41	notstarted	\N	1280
1281	4	2561	2562	2561	2562	portland-trail-blazers-memphis-grizzlies	2024-03-23 13:20:00	12	finished	away	1281
1282	4	2563	2564	2563	2564	memphis-grizzlies-portland-trail-blazers	2024-10-12 18:40:00	41	notstarted	\N	1282
1283	4	2565	2566	2565	2566	atlanta-hawks-los-angeles-clippers	2024-03-23 15:50:00	12	finished	away	1283
1284	4	2567	2568	2567	2568	los-angeles-clippers-atlanta-hawks	2024-10-12 17:20:00	41	notstarted	\N	1284
1285	4	2569	2570	2569	2570	new-york-knicks-minnesota-timberwolves	2024-03-23 10:40:00	12	finished	home	1285
1286	4	2571	2572	2571	2572	minnesota-timberwolves-new-york-knicks	2024-10-12 17:00:00	41	notstarted	\N	1286
1287	4	2573	2574	2573	2574	brooklyn-nets-miami-heat	2024-03-24 11:40:00	12	finished	home	1287
1288	4	2575	2576	2575	2576	miami-heat-brooklyn-nets	2024-10-13 11:50:00	41	notstarted	\N	1288
1289	4	2577	2578	2577	2578	orlando-magic-san-antonio-spurs	2024-03-24 12:20:00	12	finished	home	1289
1290	4	2579	2580	2579	2580	san-antonio-spurs-orlando-magic	2024-10-13 12:50:00	41	notstarted	\N	1290
1291	4	2581	2582	2581	2582	philadelphia-76ers-denver-nuggets	2024-03-24 18:00:00	12	finished	home	1291
1292	4	2583	2584	2583	2584	denver-nuggets-philadelphia-76ers	2024-10-13 14:00:00	41	notstarted	\N	1292
1293	4	2585	2586	2585	2586	detroit-pistons-boston-celtics	2024-03-24 12:10:00	12	finished	home	1293
1294	4	2587	2588	2587	2588	boston-celtics-detroit-pistons	2024-10-13 14:00:00	41	notstarted	\N	1294
1295	4	2589	2590	2589	2590	sacramento-kings-utah-jazz	2024-03-24 17:40:00	12	finished	home	1295
1296	4	2591	2592	2591	2592	utah-jazz-sacramento-kings	2024-10-13 11:00:00	41	notstarted	\N	1296
1297	4	2593	2594	2593	2594	charlotte-hornets-new-orleans-pelicans	2024-03-24 13:40:00	12	finished	away	1297
1298	4	2595	2596	2595	2596	new-orleans-pelicans-charlotte-hornets	2024-10-13 11:30:00	41	notstarted	\N	1298
1299	4	2597	2598	2597	2598	indiana-pacers-oklahoma-city-thunder	2024-03-24 19:40:00	12	finished	away	1299
1300	4	2599	2600	2599	2600	oklahoma-city-thunder-indiana-pacers	2024-10-13 11:30:00	41	notstarted	\N	1300
1301	4	2601	2602	2601	2602	utah-jazz-cleveland-cavaliers	2024-03-30 15:30:00	13	finished	away	1301
1302	4	2603	2604	2603	2604	cleveland-cavaliers-utah-jazz	2024-10-19 10:00:00	42	notstarted	\N	1302
1303	4	2605	2606	2605	2606	los-angeles-lakers-indiana-pacers	2024-03-30 10:40:00	13	finished	away	1303
1304	4	2607	2608	2607	2608	indiana-pacers-los-angeles-lakers	2024-10-19 13:10:00	42	notstarted	\N	1304
1305	4	2609	2610	2609	2610	washington-wizards-brooklyn-nets	2024-03-30 17:10:00	13	finished	home	1305
1306	4	2611	2612	2611	2612	brooklyn-nets-washington-wizards	2024-10-19 15:50:00	42	notstarted	\N	1306
1307	4	2613	2614	2613	2614	philadelphia-76ers-oklahoma-city-thunder	2024-03-30 19:30:00	13	finished	away	1307
1308	4	2615	2616	2615	2616	oklahoma-city-thunder-philadelphia-76ers	2024-10-19 15:30:00	42	notstarted	\N	1308
1309	4	2617	2618	2617	2618	sacramento-kings-chicago-bulls	2024-03-30 17:30:00	13	finished	away	1309
1310	4	2619	2620	2619	2620	chicago-bulls-sacramento-kings	2024-10-19 11:40:00	42	notstarted	\N	1310
1311	4	2621	2622	2621	2622	golden-state-warriors-new-orleans-pelicans	2024-03-30 17:00:00	13	finished	home	1311
1312	4	2623	2624	2623	2624	new-orleans-pelicans-golden-state-warriors	2024-10-19 19:40:00	42	notstarted	\N	1312
1313	4	2625	2626	2625	2626	atlanta-hawks-detroit-pistons	2024-03-30 13:30:00	13	finished	away	1313
1314	4	2627	2628	2627	2628	detroit-pistons-atlanta-hawks	2024-10-19 13:10:00	42	notstarted	\N	1314
1315	4	2629	2630	2629	2630	miami-heat-dallas-mavericks	2024-03-30 13:40:00	13	finished	home	1315
1316	4	2631	2632	2631	2632	dallas-mavericks-miami-heat	2024-10-19 12:20:00	42	notstarted	\N	1316
1317	4	2633	2634	2633	2634	charlotte-hornets-toronto-raptors	2024-03-31 15:00:00	13	finished	away	1317
1318	4	2635	2636	2635	2636	toronto-raptors-charlotte-hornets	2024-10-20 17:00:00	42	notstarted	\N	1318
1319	4	2637	2638	2637	2638	minnesota-timberwolves-san-antonio-spurs	2024-03-31 19:10:00	13	finished	away	1319
1320	4	2639	2640	2639	2640	san-antonio-spurs-minnesota-timberwolves	2024-10-20 11:10:00	42	notstarted	\N	1320
1321	4	2641	2642	2641	2642	portland-trail-blazers-boston-celtics	2024-03-31 19:30:00	13	finished	away	1321
1322	4	2643	2644	2643	2644	boston-celtics-portland-trail-blazers	2024-10-20 15:40:00	42	notstarted	\N	1322
1323	4	2645	2646	2645	2646	los-angeles-clippers-memphis-grizzlies	2024-03-31 14:40:00	13	finished	home	1323
1324	4	2647	2648	2647	2648	memphis-grizzlies-los-angeles-clippers	2024-10-20 19:40:00	42	notstarted	\N	1324
1325	4	2649	2650	2649	2650	houston-rockets-new-york-knicks	2024-03-31 14:50:00	13	finished	home	1325
1326	4	2651	2652	2651	2652	new-york-knicks-houston-rockets	2024-10-20 18:00:00	42	notstarted	\N	1326
1327	4	2653	2654	2653	2654	orlando-magic-milwaukee-bucks	2024-03-31 18:30:00	13	finished	home	1327
1328	4	2655	2656	2655	2656	milwaukee-bucks-orlando-magic	2024-10-20 15:40:00	42	notstarted	\N	1328
1329	4	2657	2658	2657	2658	denver-nuggets-phoenix-suns	2024-03-31 16:00:00	13	finished	home	1329
1330	4	2659	2660	2659	2660	phoenix-suns-denver-nuggets	2024-10-20 10:50:00	42	notstarted	\N	1330
1331	4	2661	2662	2661	2662	toronto-raptors-washington-wizards	2024-04-06 18:30:00	14	finished	away	1331
1332	4	2663	2664	2663	2664	washington-wizards-toronto-raptors	2024-10-26 15:20:00	43	notstarted	\N	1332
1333	4	2665	2666	2665	2666	sacramento-kings-denver-nuggets	2024-04-06 12:20:00	14	finished	home	1333
1334	4	2667	2668	2667	2668	denver-nuggets-sacramento-kings	2024-10-26 17:00:00	43	notstarted	\N	1334
1335	4	2669	2670	2669	2670	houston-rockets-atlanta-hawks	2024-04-06 16:50:00	14	finished	away	1335
1336	4	2671	2672	2671	2672	atlanta-hawks-houston-rockets	2024-10-26 17:30:00	43	notstarted	\N	1336
1337	4	2673	2674	2673	2674	orlando-magic-chicago-bulls	2024-04-06 18:00:00	14	finished	home	1337
1338	4	2675	2676	2675	2676	chicago-bulls-orlando-magic	2024-10-26 16:00:00	43	notstarted	\N	1338
1339	4	2677	2678	2677	2678	charlotte-hornets-brooklyn-nets	2024-04-06 13:40:00	14	finished	away	1339
1340	4	2679	2680	2679	2680	brooklyn-nets-charlotte-hornets	2024-10-26 16:50:00	43	notstarted	\N	1340
1341	4	2681	2682	2681	2682	indiana-pacers-minnesota-timberwolves	2024-04-06 13:10:00	14	finished	home	1341
1342	4	2683	2684	2683	2684	minnesota-timberwolves-indiana-pacers	2024-10-26 12:00:00	43	notstarted	\N	1342
1343	4	2685	2686	2685	2686	philadelphia-76ers-golden-state-warriors	2024-04-06 17:00:00	14	finished	away	1343
1344	4	2687	2688	2687	2688	golden-state-warriors-philadelphia-76ers	2024-10-26 18:00:00	43	notstarted	\N	1344
1345	4	2689	2690	2689	2690	new-orleans-pelicans-cleveland-cavaliers	2024-04-06 18:30:00	14	finished	home	1345
1346	4	2691	2692	2691	2692	cleveland-cavaliers-new-orleans-pelicans	2024-10-26 17:50:00	43	notstarted	\N	1346
1347	4	2693	2694	2693	2694	dallas-mavericks-los-angeles-clippers	2024-04-07 15:40:00	14	finished	away	1347
1348	4	2695	2696	2695	2696	los-angeles-clippers-dallas-mavericks	2024-10-27 12:00:00	43	notstarted	\N	1348
1349	4	2697	2698	2697	2698	miami-heat-memphis-grizzlies	2024-04-07 18:20:00	14	finished	home	1349
1350	4	2699	2700	2699	2700	memphis-grizzlies-miami-heat	2024-10-27 11:00:00	43	notstarted	\N	1350
1351	4	2701	2702	2701	2702	portland-trail-blazers-detroit-pistons	2024-04-07 12:00:00	14	finished	home	1351
1352	4	2703	2704	2703	2704	detroit-pistons-portland-trail-blazers	2024-10-27 10:50:00	43	notstarted	\N	1352
1353	4	2705	2706	2705	2706	los-angeles-lakers-boston-celtics	2024-04-07 18:50:00	14	finished	away	1353
1354	4	2707	2708	2707	2708	boston-celtics-los-angeles-lakers	2024-10-27 14:00:00	43	notstarted	\N	1354
1355	4	2709	2710	2709	2710	phoenix-suns-san-antonio-spurs	2024-04-07 11:30:00	14	finished	away	1355
1356	4	2711	2712	2711	2712	san-antonio-spurs-phoenix-suns	2024-10-27 19:40:00	43	notstarted	\N	1356
1357	4	2713	2714	2713	2714	utah-jazz-new-york-knicks	2024-04-07 14:10:00	14	finished	home	1357
1358	4	2715	2716	2715	2716	new-york-knicks-utah-jazz	2024-10-27 16:40:00	43	notstarted	\N	1358
1359	4	2717	2718	2717	2718	milwaukee-bucks-oklahoma-city-thunder	2024-04-07 15:50:00	14	finished	away	1359
1360	4	2719	2720	2719	2720	oklahoma-city-thunder-milwaukee-bucks	2024-10-27 12:00:00	43	notstarted	\N	1360
1361	4	2721	2722	2721	2722	philadelphia-76ers-toronto-raptors	2024-04-13 10:30:00	15	finished	away	1361
1362	4	2723	2724	2723	2724	toronto-raptors-philadelphia-76ers	2024-11-02 18:20:00	44	notstarted	\N	1362
1363	4	2725	2726	2725	2726	boston-celtics-chicago-bulls	2024-04-13 15:00:00	15	finished	away	1363
1364	4	2727	2728	2727	2728	chicago-bulls-boston-celtics	2024-11-02 13:20:00	44	notstarted	\N	1364
1365	4	2729	2730	2729	2730	orlando-magic-los-angeles-clippers	2024-04-13 15:00:00	15	finished	home	1365
1366	4	2731	2732	2731	2732	los-angeles-clippers-orlando-magic	2024-11-02 15:10:00	44	notstarted	\N	1366
1367	4	2733	2734	2733	2734	los-angeles-lakers-sacramento-kings	2024-04-13 12:00:00	15	finished	home	1367
1368	4	2735	2736	2735	2736	sacramento-kings-los-angeles-lakers	2024-11-02 17:40:00	44	notstarted	\N	1368
1369	4	2737	2738	2737	2738	memphis-grizzlies-new-york-knicks	2024-04-13 19:20:00	15	finished	away	1369
1370	4	2739	2740	2739	2740	new-york-knicks-memphis-grizzlies	2024-11-02 10:10:00	44	notstarted	\N	1370
1371	4	2741	2742	2741	2742	oklahoma-city-thunder-cleveland-cavaliers	2024-04-13 19:20:00	15	finished	home	1371
1372	4	2743	2744	2743	2744	cleveland-cavaliers-oklahoma-city-thunder	2024-11-02 14:10:00	44	notstarted	\N	1372
1373	4	2745	2746	2745	2746	san-antonio-spurs-brooklyn-nets	2024-04-13 11:10:00	15	finished	home	1373
1374	4	2747	2748	2747	2748	brooklyn-nets-san-antonio-spurs	2024-11-02 17:30:00	44	notstarted	\N	1374
1375	4	2749	2750	2749	2750	charlotte-hornets-minnesota-timberwolves	2024-04-13 14:50:00	15	finished	away	1375
1376	4	2751	2752	2751	2752	minnesota-timberwolves-charlotte-hornets	2024-11-02 18:50:00	44	notstarted	\N	1376
1377	4	2753	2754	2753	2754	denver-nuggets-detroit-pistons	2024-04-14 14:10:00	15	finished	home	1377
1378	4	2755	2756	2755	2756	detroit-pistons-denver-nuggets	2024-11-03 12:50:00	44	notstarted	\N	1378
1379	4	2757	2758	2757	2758	portland-trail-blazers-indiana-pacers	2024-04-14 12:30:00	15	finished	home	1379
1380	4	2759	2760	2759	2760	indiana-pacers-portland-trail-blazers	2024-11-03 14:40:00	44	notstarted	\N	1380
1381	4	2761	2762	2761	2762	houston-rockets-miami-heat	2024-04-14 16:20:00	15	finished	home	1381
1382	4	2763	2764	2763	2764	miami-heat-houston-rockets	2024-11-03 15:10:00	44	notstarted	\N	1382
1383	4	2765	2766	2765	2766	washington-wizards-atlanta-hawks	2024-04-14 15:10:00	15	finished	home	1383
1384	4	2767	2768	2767	2768	atlanta-hawks-washington-wizards	2024-11-03 11:10:00	44	notstarted	\N	1384
1385	4	2769	2770	2769	2770	milwaukee-bucks-new-orleans-pelicans	2024-04-14 16:00:00	15	finished	away	1385
1386	4	2771	2772	2771	2772	new-orleans-pelicans-milwaukee-bucks	2024-11-03 13:30:00	44	notstarted	\N	1386
1387	4	2773	2774	2773	2774	utah-jazz-golden-state-warriors	2024-04-14 18:40:00	15	finished	away	1387
1388	4	2775	2776	2775	2776	golden-state-warriors-utah-jazz	2024-11-03 11:40:00	44	notstarted	\N	1388
1389	4	2777	2778	2777	2778	phoenix-suns-dallas-mavericks	2024-04-14 11:20:00	15	finished	home	1389
1390	4	2779	2780	2779	2780	dallas-mavericks-phoenix-suns	2024-11-03 10:30:00	44	notstarted	\N	1390
1391	4	2781	2782	2781	2782	sacramento-kings-indiana-pacers	2024-04-20 19:20:00	16	finished	home	1391
1392	4	2783	2784	2783	2784	indiana-pacers-sacramento-kings	2024-11-09 12:30:00	45	notstarted	\N	1392
1393	4	2785	2786	2785	2786	golden-state-warriors-minnesota-timberwolves	2024-04-20 14:10:00	16	finished	away	1393
1394	4	2787	2788	2787	2788	minnesota-timberwolves-golden-state-warriors	2024-11-09 15:50:00	45	notstarted	\N	1394
1395	4	2789	2790	2789	2790	cleveland-cavaliers-atlanta-hawks	2024-04-20 11:00:00	16	finished	away	1395
1396	4	2791	2792	2791	2792	atlanta-hawks-cleveland-cavaliers	2024-11-09 14:00:00	45	notstarted	\N	1396
1397	4	2793	2794	2793	2794	chicago-bulls-san-antonio-spurs	2024-04-20 12:10:00	16	finished	home	1397
1398	4	2795	2796	2795	2796	san-antonio-spurs-chicago-bulls	2024-11-09 18:20:00	45	notstarted	\N	1398
1399	4	2797	2798	2797	2798	los-angeles-lakers-houston-rockets	2024-04-20 16:50:00	16	finished	away	1399
1400	4	2799	2800	2799	2800	houston-rockets-los-angeles-lakers	2024-11-09 12:50:00	45	notstarted	\N	1400
1401	4	2801	2802	2801	2802	oklahoma-city-thunder-boston-celtics	2024-04-20 18:20:00	16	finished	home	1401
1402	4	2803	2804	2803	2804	boston-celtics-oklahoma-city-thunder	2024-11-09 10:40:00	45	notstarted	\N	1402
1403	4	2805	2806	2805	2806	washington-wizards-milwaukee-bucks	2024-04-20 14:50:00	16	finished	away	1403
1404	4	2807	2808	2807	2808	milwaukee-bucks-washington-wizards	2024-11-09 10:10:00	45	notstarted	\N	1404
1405	4	2809	2810	2809	2810	new-orleans-pelicans-los-angeles-clippers	2024-04-20 15:40:00	16	finished	home	1405
1406	4	2811	2812	2811	2812	los-angeles-clippers-new-orleans-pelicans	2024-11-09 16:40:00	45	notstarted	\N	1406
1407	4	2813	2814	2813	2814	toronto-raptors-brooklyn-nets	2024-04-21 17:30:00	16	finished	home	1407
1408	4	2815	2816	2815	2816	brooklyn-nets-toronto-raptors	2024-11-10 15:30:00	45	notstarted	\N	1408
1409	4	2817	2818	2817	2818	phoenix-suns-philadelphia-76ers	2024-04-21 15:00:00	16	finished	home	1409
1410	4	2819	2820	2819	2820	philadelphia-76ers-phoenix-suns	2024-11-10 15:40:00	45	notstarted	\N	1410
1411	4	2821	2822	2821	2822	charlotte-hornets-new-york-knicks	2024-04-21 17:50:00	16	finished	home	1411
1412	4	2823	2824	2823	2824	new-york-knicks-charlotte-hornets	2024-11-10 18:40:00	45	notstarted	\N	1412
1413	4	2825	2826	2825	2826	denver-nuggets-portland-trail-blazers	2024-04-21 18:30:00	16	finished	away	1413
1414	4	2827	2828	2827	2828	portland-trail-blazers-denver-nuggets	2024-11-10 18:20:00	45	notstarted	\N	1414
1415	4	2829	2830	2829	2830	dallas-mavericks-utah-jazz	2024-04-21 18:40:00	16	finished	home	1415
1416	4	2831	2832	2831	2832	utah-jazz-dallas-mavericks	2024-11-10 15:10:00	45	notstarted	\N	1416
1417	4	2833	2834	2833	2834	orlando-magic-memphis-grizzlies	2024-04-21 16:00:00	16	finished	away	1417
1418	4	2835	2836	2835	2836	memphis-grizzlies-orlando-magic	2024-11-10 10:50:00	45	notstarted	\N	1418
1419	4	2837	2838	2837	2838	miami-heat-detroit-pistons	2024-04-21 13:50:00	16	finished	away	1419
1420	4	2839	2840	2839	2840	detroit-pistons-miami-heat	2024-11-10 17:10:00	45	notstarted	\N	1420
1421	4	2841	2842	2841	2842	dallas-mavericks-san-antonio-spurs	2024-04-27 12:50:00	17	finished	away	1421
1422	4	2843	2844	2843	2844	san-antonio-spurs-dallas-mavericks	2024-11-16 17:40:00	46	notstarted	\N	1422
1423	4	2845	2846	2845	2846	washington-wizards-boston-celtics	2024-04-27 15:10:00	17	finished	home	1423
1424	4	2847	2848	2847	2848	boston-celtics-washington-wizards	2024-11-16 13:30:00	46	notstarted	\N	1424
1425	4	2849	2850	2849	2850	charlotte-hornets-los-angeles-lakers	2024-04-27 10:20:00	17	finished	home	1425
1426	4	2851	2852	2851	2852	los-angeles-lakers-charlotte-hornets	2024-11-16 16:40:00	46	notstarted	\N	1426
1427	4	2853	2854	2853	2854	brooklyn-nets-detroit-pistons	2024-04-27 10:40:00	17	finished	away	1427
1428	4	2855	2856	2855	2856	detroit-pistons-brooklyn-nets	2024-11-16 14:40:00	46	notstarted	\N	1428
1429	4	2857	2858	2857	2858	milwaukee-bucks-toronto-raptors	2024-04-27 15:00:00	17	finished	home	1429
1430	4	2859	2860	2859	2860	toronto-raptors-milwaukee-bucks	2024-11-16 17:50:00	46	notstarted	\N	1430
1431	4	2861	2862	2861	2862	chicago-bulls-miami-heat	2024-04-27 13:50:00	17	finished	home	1431
1432	4	2863	2864	2863	2864	miami-heat-chicago-bulls	2024-11-16 11:10:00	46	notstarted	\N	1432
1433	4	2865	2866	2865	2866	portland-trail-blazers-phoenix-suns	2024-04-27 19:20:00	17	finished	away	1433
1434	4	2867	2868	2867	2868	phoenix-suns-portland-trail-blazers	2024-11-16 16:50:00	46	notstarted	\N	1434
1435	4	2869	2870	2869	2870	atlanta-hawks-utah-jazz	2024-04-27 13:40:00	17	finished	away	1435
1436	4	2871	2872	2871	2872	utah-jazz-atlanta-hawks	2024-11-16 18:40:00	46	notstarted	\N	1436
1437	4	2873	2874	2873	2874	new-york-knicks-denver-nuggets	2024-04-28 14:10:00	17	finished	away	1437
1438	4	2875	2876	2875	2876	denver-nuggets-new-york-knicks	2024-11-17 15:40:00	46	notstarted	\N	1438
1439	4	2877	2878	2877	2878	philadelphia-76ers-los-angeles-clippers	2024-04-28 17:10:00	17	finished	away	1439
1440	4	2879	2880	2879	2880	los-angeles-clippers-philadelphia-76ers	2024-11-17 19:00:00	46	notstarted	\N	1440
1441	4	2881	2882	2881	2882	memphis-grizzlies-houston-rockets	2024-04-28 10:40:00	17	finished	away	1441
1442	4	2883	2884	2883	2884	houston-rockets-memphis-grizzlies	2024-11-17 10:40:00	46	notstarted	\N	1442
1443	4	2885	2886	2885	2886	golden-state-warriors-oklahoma-city-thunder	2024-04-28 13:40:00	17	finished	home	1443
1444	4	2887	2888	2887	2888	oklahoma-city-thunder-golden-state-warriors	2024-11-17 12:30:00	46	notstarted	\N	1444
1445	4	2889	2890	2889	2890	new-orleans-pelicans-sacramento-kings	2024-04-28 16:40:00	17	finished	home	1445
1446	4	2891	2892	2891	2892	sacramento-kings-new-orleans-pelicans	2024-11-17 12:50:00	46	notstarted	\N	1446
1447	4	2893	2894	2893	2894	indiana-pacers-orlando-magic	2024-04-28 13:30:00	17	finished	home	1447
1448	4	2895	2896	2895	2896	orlando-magic-indiana-pacers	2024-11-17 12:00:00	46	notstarted	\N	1448
1449	4	2897	2898	2897	2898	cleveland-cavaliers-minnesota-timberwolves	2024-04-28 12:20:00	17	finished	away	1449
1450	4	2899	2900	2899	2900	minnesota-timberwolves-cleveland-cavaliers	2024-11-17 10:00:00	46	notstarted	\N	1450
1451	4	2901	2902	2901	2902	detroit-pistons-chicago-bulls	2024-05-04 18:50:00	18	finished	home	1451
1452	4	2903	2904	2903	2904	chicago-bulls-detroit-pistons	2024-11-23 12:10:00	47	notstarted	\N	1452
1453	4	2905	2906	2905	2906	washington-wizards-phoenix-suns	2024-05-04 13:10:00	18	finished	away	1453
1454	4	2907	2908	2907	2908	phoenix-suns-washington-wizards	2024-11-23 13:40:00	47	notstarted	\N	1454
1455	4	2909	2910	2909	2910	sacramento-kings-charlotte-hornets	2024-05-04 13:10:00	18	finished	away	1455
1456	4	2911	2912	2911	2912	charlotte-hornets-sacramento-kings	2024-11-23 10:50:00	47	notstarted	\N	1456
1457	4	2913	2914	2913	2914	orlando-magic-utah-jazz	2024-05-04 15:00:00	18	finished	home	1457
1458	4	2915	2916	2915	2916	utah-jazz-orlando-magic	2024-11-23 12:40:00	47	notstarted	\N	1458
1459	4	2917	2918	2917	2918	new-york-knicks-philadelphia-76ers	2024-05-04 15:50:00	18	finished	away	1459
1460	4	2919	2920	2919	2920	philadelphia-76ers-new-york-knicks	2024-11-23 14:20:00	47	notstarted	\N	1460
1461	4	2921	2922	2921	2922	miami-heat-new-orleans-pelicans	2024-05-04 18:30:00	18	finished	away	1461
1462	4	2923	2924	2923	2924	new-orleans-pelicans-miami-heat	2024-11-23 15:10:00	47	notstarted	\N	1462
1463	4	2925	2926	2925	2926	dallas-mavericks-milwaukee-bucks	2024-05-04 12:00:00	18	finished	away	1463
1464	4	2927	2928	2927	2928	milwaukee-bucks-dallas-mavericks	2024-11-23 11:00:00	47	notstarted	\N	1464
1465	4	2929	2930	2929	2930	san-antonio-spurs-denver-nuggets	2024-05-04 10:30:00	18	finished	home	1465
1466	4	2931	2932	2931	2932	denver-nuggets-san-antonio-spurs	2024-11-23 16:50:00	47	notstarted	\N	1466
1467	4	2933	2934	2933	2934	oklahoma-city-thunder-brooklyn-nets	2024-05-05 14:30:00	18	finished	draw	1467
1468	4	2935	2936	2935	2936	brooklyn-nets-oklahoma-city-thunder	2024-11-24 13:10:00	47	notstarted	\N	1468
1469	4	2937	2938	2937	2938	toronto-raptors-atlanta-hawks	2024-05-05 10:30:00	18	finished	away	1469
1470	4	2939	2940	2939	2940	atlanta-hawks-toronto-raptors	2024-11-24 17:50:00	47	notstarted	\N	1470
1471	4	2941	2942	2941	2942	los-angeles-lakers-golden-state-warriors	2024-05-05 13:50:00	18	finished	away	1471
1472	4	2943	2944	2943	2944	golden-state-warriors-los-angeles-lakers	2024-11-24 17:40:00	47	notstarted	\N	1472
1473	4	2945	2946	2945	2946	cleveland-cavaliers-portland-trail-blazers	2024-05-05 10:00:00	18	finished	away	1473
1474	4	2947	2948	2947	2948	portland-trail-blazers-cleveland-cavaliers	2024-11-24 13:10:00	47	notstarted	\N	1474
1475	4	2949	2950	2949	2950	los-angeles-clippers-boston-celtics	2024-05-05 14:20:00	18	finished	away	1475
1476	4	2951	2952	2951	2952	boston-celtics-los-angeles-clippers	2024-11-24 17:20:00	47	notstarted	\N	1476
1477	4	2953	2954	2953	2954	memphis-grizzlies-indiana-pacers	2024-05-05 17:40:00	18	finished	away	1477
1478	4	2955	2956	2955	2956	indiana-pacers-memphis-grizzlies	2024-11-24 16:50:00	47	notstarted	\N	1478
1479	4	2957	2958	2957	2958	houston-rockets-minnesota-timberwolves	2024-05-05 12:40:00	18	finished	away	1479
1480	4	2959	2960	2959	2960	minnesota-timberwolves-houston-rockets	2024-11-24 19:00:00	47	notstarted	\N	1480
1481	4	2961	2962	2961	2962	indiana-pacers-chicago-bulls	2024-05-11 15:20:00	19	finished	home	1481
1482	4	2963	2964	2963	2964	chicago-bulls-indiana-pacers	2024-11-30 17:00:00	48	notstarted	\N	1482
1483	4	2965	2966	2965	2966	detroit-pistons-new-york-knicks	2024-05-11 12:00:00	19	finished	away	1483
1484	4	2967	2968	2967	2968	new-york-knicks-detroit-pistons	2024-11-30 15:40:00	48	notstarted	\N	1484
1485	4	2969	2970	2969	2970	cleveland-cavaliers-los-angeles-clippers	2024-05-11 18:20:00	19	finished	home	1485
1486	4	2971	2972	2971	2972	los-angeles-clippers-cleveland-cavaliers	2024-11-30 18:20:00	48	notstarted	\N	1486
1487	4	2973	2974	2973	2974	denver-nuggets-oklahoma-city-thunder	2024-05-11 19:20:00	19	finished	away	1487
1488	4	2975	2976	2975	2976	oklahoma-city-thunder-denver-nuggets	2024-11-30 14:40:00	48	notstarted	\N	1488
1489	4	2977	2978	2977	2978	toronto-raptors-phoenix-suns	2024-05-11 10:30:00	19	finished	home	1489
1490	4	2979	2980	2979	2980	phoenix-suns-toronto-raptors	2024-11-30 13:50:00	48	notstarted	\N	1490
1491	4	2981	2982	2981	2982	orlando-magic-boston-celtics	2024-05-11 19:00:00	19	finished	home	1491
1492	4	2983	2984	2983	2984	boston-celtics-orlando-magic	2024-11-30 18:30:00	48	notstarted	\N	1492
1493	4	2985	2986	2985	2986	portland-trail-blazers-milwaukee-bucks	2024-05-11 18:00:00	19	finished	home	1493
1494	4	2987	2988	2987	2988	milwaukee-bucks-portland-trail-blazers	2024-11-30 12:50:00	48	notstarted	\N	1494
1495	4	2989	2990	2989	2990	golden-state-warriors-miami-heat	2024-05-11 17:10:00	19	finished	away	1495
1496	4	2991	2992	2991	2992	miami-heat-golden-state-warriors	2024-11-30 16:20:00	48	notstarted	\N	1496
1497	4	2993	2994	2993	2994	minnesota-timberwolves-washington-wizards	2024-05-12 18:40:00	19	finished	away	1497
1498	4	2995	2996	2995	2996	washington-wizards-minnesota-timberwolves	2024-12-01 16:20:00	48	notstarted	\N	1498
1499	4	2997	2998	2997	2998	brooklyn-nets-houston-rockets	2024-05-12 15:10:00	19	finished	home	1499
1500	4	2999	3000	2999	3000	houston-rockets-brooklyn-nets	2024-12-01 13:00:00	48	notstarted	\N	1500
1501	4	3001	3002	3001	3002	sacramento-kings-dallas-mavericks	2024-05-12 17:50:00	19	finished	home	1501
1502	4	3003	3004	3003	3004	dallas-mavericks-sacramento-kings	2024-12-01 19:50:00	48	notstarted	\N	1502
1503	4	3005	3006	3005	3006	utah-jazz-san-antonio-spurs	2024-05-12 10:50:00	19	finished	away	1503
1504	4	3007	3008	3007	3008	san-antonio-spurs-utah-jazz	2024-12-01 12:30:00	48	notstarted	\N	1504
1505	4	3009	3010	3009	3010	memphis-grizzlies-philadelphia-76ers	2024-05-12 11:20:00	19	finished	home	1505
1506	4	3011	3012	3011	3012	philadelphia-76ers-memphis-grizzlies	2024-12-01 17:00:00	48	notstarted	\N	1506
1507	4	3013	3014	3013	3014	charlotte-hornets-atlanta-hawks	2024-05-12 16:20:00	19	finished	away	1507
1508	4	3015	3016	3015	3016	atlanta-hawks-charlotte-hornets	2024-12-01 15:10:00	48	notstarted	\N	1508
1509	4	3017	3018	3017	3018	new-orleans-pelicans-los-angeles-lakers	2024-05-12 10:10:00	19	finished	away	1509
1510	4	3019	3020	3019	3020	los-angeles-lakers-new-orleans-pelicans	2024-12-01 15:20:00	48	notstarted	\N	1510
1511	4	3021	3022	3021	3022	boston-celtics-charlotte-hornets	2024-05-18 19:20:00	20	finished	away	1511
1512	4	3023	3024	3023	3024	charlotte-hornets-boston-celtics	2024-12-07 16:00:00	49	notstarted	\N	1512
1513	4	3025	3026	3025	3026	utah-jazz-miami-heat	2024-05-18 10:40:00	20	finished	away	1513
1514	4	3027	3028	3027	3028	miami-heat-utah-jazz	2024-12-07 19:00:00	49	notstarted	\N	1514
1515	4	3029	3030	3029	3030	brooklyn-nets-sacramento-kings	2024-05-18 12:30:00	20	finished	away	1515
1516	4	3031	3032	3031	3032	sacramento-kings-brooklyn-nets	2024-12-07 13:10:00	49	notstarted	\N	1516
1517	4	3033	3034	3033	3034	toronto-raptors-orlando-magic	2024-05-18 17:00:00	20	finished	home	1517
1518	4	3035	3036	3035	3036	orlando-magic-toronto-raptors	2024-12-07 13:40:00	49	notstarted	\N	1518
1519	4	3037	3038	3037	3038	minnesota-timberwolves-oklahoma-city-thunder	2024-05-18 10:00:00	20	finished	home	1519
1520	4	3039	3040	3039	3040	oklahoma-city-thunder-minnesota-timberwolves	2024-12-07 10:50:00	49	notstarted	\N	1520
1521	4	3041	3042	3041	3042	washington-wizards-los-angeles-lakers	2024-05-18 18:20:00	20	finished	home	1521
1522	4	3043	3044	3043	3044	los-angeles-lakers-washington-wizards	2024-12-07 12:00:00	49	notstarted	\N	1522
1523	4	3045	3046	3045	3046	milwaukee-bucks-new-york-knicks	2024-05-18 18:10:00	20	finished	home	1523
1524	4	3047	3048	3047	3048	new-york-knicks-milwaukee-bucks	2024-12-07 13:50:00	49	notstarted	\N	1524
1525	4	3049	3050	3049	3050	denver-nuggets-houston-rockets	2024-05-18 16:20:00	20	finished	home	1525
1526	4	3051	3052	3051	3052	houston-rockets-denver-nuggets	2024-12-07 15:20:00	49	notstarted	\N	1526
1527	4	3053	3054	3053	3054	san-antonio-spurs-memphis-grizzlies	2024-05-19 14:40:00	20	finished	away	1527
1528	4	3055	3056	3055	3056	memphis-grizzlies-san-antonio-spurs	2024-12-08 12:20:00	49	notstarted	\N	1528
1529	4	3057	3058	3057	3058	cleveland-cavaliers-phoenix-suns	2024-05-19 16:00:00	20	finished	away	1529
1530	4	3059	3060	3059	3060	phoenix-suns-cleveland-cavaliers	2024-12-08 18:50:00	49	notstarted	\N	1530
1531	4	3061	3062	3061	3062	golden-state-warriors-portland-trail-blazers	2024-05-19 16:30:00	20	finished	home	1531
1532	4	3063	3064	3063	3064	portland-trail-blazers-golden-state-warriors	2024-12-08 18:40:00	49	notstarted	\N	1532
1533	4	3065	3066	3065	3066	indiana-pacers-dallas-mavericks	2024-05-19 10:10:00	20	finished	away	1533
1534	4	3067	3068	3067	3068	dallas-mavericks-indiana-pacers	2024-12-08 19:00:00	49	notstarted	\N	1534
1535	4	3069	3070	3069	3070	detroit-pistons-new-orleans-pelicans	2024-05-19 10:30:00	20	finished	home	1535
1536	4	3071	3072	3071	3072	new-orleans-pelicans-detroit-pistons	2024-12-08 19:20:00	49	notstarted	\N	1536
1537	4	3073	3074	3073	3074	chicago-bulls-los-angeles-clippers	2024-05-19 19:40:00	20	finished	home	1537
1538	4	3075	3076	3075	3076	los-angeles-clippers-chicago-bulls	2024-12-08 13:20:00	49	notstarted	\N	1538
1539	4	3077	3078	3077	3078	atlanta-hawks-philadelphia-76ers	2024-05-19 15:00:00	20	finished	draw	1539
1540	4	3079	3080	3079	3080	philadelphia-76ers-atlanta-hawks	2024-12-08 10:40:00	49	notstarted	\N	1540
1541	4	3081	3082	3081	3082	phoenix-suns-chicago-bulls	2024-05-25 10:20:00	21	finished	away	1541
1542	4	3083	3084	3083	3084	chicago-bulls-phoenix-suns	2024-12-14 18:00:00	50	notstarted	\N	1542
1543	4	3085	3086	3085	3086	san-antonio-spurs-los-angeles-lakers	2024-05-25 14:30:00	21	finished	away	1543
1544	4	3087	3088	3087	3088	los-angeles-lakers-san-antonio-spurs	2024-12-14 16:30:00	50	notstarted	\N	1544
1545	4	3089	3090	3089	3090	orlando-magic-dallas-mavericks	2024-05-25 17:40:00	21	finished	away	1545
1546	4	3091	3092	3091	3092	dallas-mavericks-orlando-magic	2024-12-14 18:00:00	50	notstarted	\N	1546
1547	4	3093	3094	3093	3094	cleveland-cavaliers-miami-heat	2024-05-25 10:10:00	21	finished	away	1547
1548	4	3095	3096	3095	3096	miami-heat-cleveland-cavaliers	2024-12-14 11:20:00	50	notstarted	\N	1548
1549	4	3097	3098	3097	3098	boston-celtics-denver-nuggets	2024-05-25 15:40:00	21	finished	draw	1549
1550	4	3099	3100	3099	3100	denver-nuggets-boston-celtics	2024-12-14 13:40:00	50	notstarted	\N	1550
1551	4	3101	3102	3101	3102	washington-wizards-new-orleans-pelicans	2024-05-25 16:10:00	21	finished	away	1551
1552	4	3103	3104	3103	3104	new-orleans-pelicans-washington-wizards	2024-12-14 12:50:00	50	notstarted	\N	1552
1553	4	3105	3106	3105	3106	minnesota-timberwolves-memphis-grizzlies	2024-05-25 19:10:00	21	finished	home	1553
1554	4	3107	3108	3107	3108	memphis-grizzlies-minnesota-timberwolves	2024-12-14 18:40:00	50	notstarted	\N	1554
1555	4	3109	3110	3109	3110	oklahoma-city-thunder-houston-rockets	2024-05-25 13:20:00	21	finished	home	1555
1556	4	3111	3112	3111	3112	houston-rockets-oklahoma-city-thunder	2024-12-14 14:40:00	50	notstarted	\N	1556
1557	4	3113	3114	3113	3114	milwaukee-bucks-atlanta-hawks	2024-05-26 12:50:00	21	finished	home	1557
1558	4	3115	3116	3115	3116	atlanta-hawks-milwaukee-bucks	2024-12-15 14:10:00	50	notstarted	\N	1558
1559	4	3117	3118	3117	3118	portland-trail-blazers-utah-jazz	2024-05-26 12:10:00	21	finished	away	1559
1560	4	3119	3120	3119	3120	utah-jazz-portland-trail-blazers	2024-12-15 11:30:00	50	notstarted	\N	1560
1561	4	3121	3122	3121	3122	brooklyn-nets-indiana-pacers	2024-05-26 14:10:00	21	finished	home	1561
1562	4	3123	3124	3123	3124	indiana-pacers-brooklyn-nets	2024-12-15 15:40:00	50	notstarted	\N	1562
1563	4	3125	3126	3125	3126	toronto-raptors-detroit-pistons	2024-05-26 14:50:00	21	finished	home	1563
1564	4	3127	3128	3127	3128	detroit-pistons-toronto-raptors	2024-12-15 15:40:00	50	notstarted	\N	1564
1565	4	3129	3130	3129	3130	new-york-knicks-golden-state-warriors	2024-05-26 18:20:00	21	finished	away	1565
1566	4	3131	3132	3131	3132	golden-state-warriors-new-york-knicks	2024-12-15 12:30:00	50	notstarted	\N	1566
1567	4	3133	3134	3133	3134	los-angeles-clippers-sacramento-kings	2024-05-26 18:00:00	21	finished	home	1567
1568	4	3135	3136	3135	3136	sacramento-kings-los-angeles-clippers	2024-12-15 17:50:00	50	notstarted	\N	1568
1569	4	3137	3138	3137	3138	philadelphia-76ers-charlotte-hornets	2024-05-26 14:10:00	21	finished	away	1569
1570	4	3139	3140	3139	3140	charlotte-hornets-philadelphia-76ers	2024-12-15 15:50:00	50	notstarted	\N	1570
1571	4	3141	3142	3141	3142	los-angeles-lakers-phoenix-suns	2024-06-01 18:40:00	22	notstarted	\N	1571
1572	4	3143	3144	3143	3144	phoenix-suns-los-angeles-lakers	2024-12-21 10:10:00	51	notstarted	\N	1572
1573	4	3145	3146	3145	3146	minnesota-timberwolves-toronto-raptors	2024-06-01 18:50:00	22	notstarted	\N	1573
1574	4	3147	3148	3147	3148	toronto-raptors-minnesota-timberwolves	2024-12-21 18:00:00	51	notstarted	\N	1574
1575	4	3149	3150	3149	3150	memphis-grizzlies-brooklyn-nets	2024-06-01 13:30:00	22	notstarted	\N	1575
1576	4	3151	3152	3151	3152	brooklyn-nets-memphis-grizzlies	2024-12-21 13:10:00	51	notstarted	\N	1576
1577	4	3153	3154	3153	3154	detroit-pistons-utah-jazz	2024-06-01 10:10:00	22	notstarted	\N	1577
1578	4	3155	3156	3155	3156	utah-jazz-detroit-pistons	2024-12-21 11:40:00	51	notstarted	\N	1578
1579	4	3157	3158	3157	3158	los-angeles-clippers-washington-wizards	2024-06-01 10:50:00	22	notstarted	\N	1579
1580	4	3159	3160	3159	3160	washington-wizards-los-angeles-clippers	2024-12-21 10:40:00	51	notstarted	\N	1580
1581	4	3161	3162	3161	3162	denver-nuggets-dallas-mavericks	2024-06-01 11:10:00	22	notstarted	\N	1581
1582	4	3163	3164	3163	3164	dallas-mavericks-denver-nuggets	2024-12-21 18:00:00	51	notstarted	\N	1582
1583	4	3165	3166	3165	3166	portland-trail-blazers-atlanta-hawks	2024-06-01 11:30:00	22	notstarted	\N	1583
1584	4	3167	3168	3167	3168	atlanta-hawks-portland-trail-blazers	2024-12-21 15:40:00	51	notstarted	\N	1584
1585	4	3169	3170	3169	3170	milwaukee-bucks-boston-celtics	2024-06-01 14:30:00	22	notstarted	\N	1585
1586	4	3171	3172	3171	3172	boston-celtics-milwaukee-bucks	2024-12-21 10:50:00	51	notstarted	\N	1586
1587	4	3173	3174	3173	3174	charlotte-hornets-orlando-magic	2024-06-02 19:40:00	22	notstarted	\N	1587
1588	4	3175	3176	3175	3176	orlando-magic-charlotte-hornets	2024-12-22 11:40:00	51	notstarted	\N	1588
1589	4	3177	3178	3177	3178	golden-state-warriors-chicago-bulls	2024-06-02 13:00:00	22	notstarted	\N	1589
1590	4	3179	3180	3179	3180	chicago-bulls-golden-state-warriors	2024-12-22 12:10:00	51	notstarted	\N	1590
1591	4	3181	3182	3181	3182	sacramento-kings-new-york-knicks	2024-06-02 14:30:00	22	notstarted	\N	1591
1592	4	3183	3184	3183	3184	new-york-knicks-sacramento-kings	2024-12-22 15:30:00	51	notstarted	\N	1592
1593	4	3185	3186	3185	3186	cleveland-cavaliers-indiana-pacers	2024-06-02 16:30:00	22	notstarted	\N	1593
1594	4	3187	3188	3187	3188	indiana-pacers-cleveland-cavaliers	2024-12-22 19:00:00	51	notstarted	\N	1594
1595	4	3189	3190	3189	3190	oklahoma-city-thunder-miami-heat	2024-06-02 11:10:00	22	notstarted	\N	1595
1596	4	3191	3192	3191	3192	miami-heat-oklahoma-city-thunder	2024-12-22 19:10:00	51	notstarted	\N	1596
1597	4	3193	3194	3193	3194	houston-rockets-new-orleans-pelicans	2024-06-02 18:20:00	22	notstarted	\N	1597
1598	4	3195	3196	3195	3196	new-orleans-pelicans-houston-rockets	2024-12-22 16:40:00	51	notstarted	\N	1598
1599	4	3197	3198	3197	3198	philadelphia-76ers-san-antonio-spurs	2024-06-02 11:00:00	22	notstarted	\N	1599
1600	4	3199	3200	3199	3200	san-antonio-spurs-philadelphia-76ers	2024-12-22 13:30:00	51	notstarted	\N	1600
1601	4	3201	3202	3201	3202	denver-nuggets-toronto-raptors	2024-06-08 15:10:00	23	notstarted	\N	1601
1602	4	3203	3204	3203	3204	toronto-raptors-denver-nuggets	2024-12-28 11:00:00	52	notstarted	\N	1602
1603	4	3205	3206	3205	3206	miami-heat-phoenix-suns	2024-06-08 13:40:00	23	notstarted	\N	1603
1604	4	3207	3208	3207	3208	phoenix-suns-miami-heat	2024-12-28 11:50:00	52	notstarted	\N	1604
1605	4	3209	3210	3209	3210	san-antonio-spurs-los-angeles-clippers	2024-06-08 17:20:00	23	notstarted	\N	1605
1606	4	3211	3212	3211	3212	los-angeles-clippers-san-antonio-spurs	2024-12-28 14:40:00	52	notstarted	\N	1606
1607	4	3213	3214	3213	3214	cleveland-cavaliers-sacramento-kings	2024-06-08 18:10:00	23	notstarted	\N	1607
1608	4	3215	3216	3215	3216	sacramento-kings-cleveland-cavaliers	2024-12-28 16:20:00	52	notstarted	\N	1608
1609	4	3217	3218	3217	3218	boston-celtics-minnesota-timberwolves	2024-06-08 18:20:00	23	notstarted	\N	1609
1610	4	3219	3220	3219	3220	minnesota-timberwolves-boston-celtics	2024-12-28 15:50:00	52	notstarted	\N	1610
1611	4	3221	3222	3221	3222	indiana-pacers-detroit-pistons	2024-06-08 18:30:00	23	notstarted	\N	1611
1612	4	3223	3224	3223	3224	detroit-pistons-indiana-pacers	2024-12-28 17:10:00	52	notstarted	\N	1612
1613	4	3225	3226	3225	3226	charlotte-hornets-washington-wizards	2024-06-08 13:10:00	23	notstarted	\N	1613
1614	4	3227	3228	3227	3228	washington-wizards-charlotte-hornets	2024-12-28 17:20:00	52	notstarted	\N	1614
1615	4	3229	3230	3229	3230	dallas-mavericks-new-york-knicks	2024-06-08 13:10:00	23	notstarted	\N	1615
1616	4	3231	3232	3231	3232	new-york-knicks-dallas-mavericks	2024-12-28 11:50:00	52	notstarted	\N	1616
1617	4	3233	3234	3233	3234	philadelphia-76ers-los-angeles-lakers	2024-06-09 19:50:00	23	notstarted	\N	1617
1618	4	3235	3236	3235	3236	los-angeles-lakers-philadelphia-76ers	2024-12-29 11:10:00	52	notstarted	\N	1618
1619	4	3237	3238	3237	3238	oklahoma-city-thunder-chicago-bulls	2024-06-09 10:00:00	23	notstarted	\N	1619
1620	4	3239	3240	3239	3240	chicago-bulls-oklahoma-city-thunder	2024-12-29 14:50:00	52	notstarted	\N	1620
1621	4	3241	3242	3241	3242	brooklyn-nets-milwaukee-bucks	2024-06-09 16:40:00	23	notstarted	\N	1621
1622	4	3243	3244	3243	3244	milwaukee-bucks-brooklyn-nets	2024-12-29 12:50:00	52	notstarted	\N	1622
1623	4	3245	3246	3245	3246	memphis-grizzlies-utah-jazz	2024-06-09 17:10:00	23	notstarted	\N	1623
1624	4	3247	3248	3247	3248	utah-jazz-memphis-grizzlies	2024-12-29 19:00:00	52	notstarted	\N	1624
1625	4	3249	3250	3249	3250	houston-rockets-golden-state-warriors	2024-06-09 14:50:00	23	notstarted	\N	1625
1626	4	3251	3252	3251	3252	golden-state-warriors-houston-rockets	2024-12-29 18:10:00	52	notstarted	\N	1626
1627	4	3253	3254	3253	3254	portland-trail-blazers-orlando-magic	2024-06-09 11:30:00	23	notstarted	\N	1627
1628	4	3255	3256	3255	3256	orlando-magic-portland-trail-blazers	2024-12-29 15:30:00	52	notstarted	\N	1628
1629	4	3257	3258	3257	3258	new-orleans-pelicans-atlanta-hawks	2024-06-09 12:50:00	23	notstarted	\N	1629
1630	4	3259	3260	3259	3260	atlanta-hawks-new-orleans-pelicans	2024-12-29 16:30:00	52	notstarted	\N	1630
1631	4	3261	3262	3261	3262	atlanta-hawks-chicago-bulls	2024-06-15 17:50:00	24	notstarted	\N	1631
1632	4	3263	3264	3263	3264	chicago-bulls-atlanta-hawks	2025-01-04 19:00:00	53	notstarted	\N	1632
1633	4	3265	3266	3265	3266	washington-wizards-philadelphia-76ers	2024-06-15 10:50:00	24	notstarted	\N	1633
1634	4	3267	3268	3267	3268	philadelphia-76ers-washington-wizards	2025-01-04 13:50:00	53	notstarted	\N	1634
1635	4	3269	3270	3269	3270	brooklyn-nets-cleveland-cavaliers	2024-06-15 16:10:00	24	notstarted	\N	1635
1636	4	3271	3272	3271	3272	cleveland-cavaliers-brooklyn-nets	2025-01-04 10:50:00	53	notstarted	\N	1636
1637	4	3273	3274	3273	3274	denver-nuggets-charlotte-hornets	2024-06-15 14:00:00	24	notstarted	\N	1637
1638	4	3275	3276	3275	3276	charlotte-hornets-denver-nuggets	2025-01-04 19:10:00	53	notstarted	\N	1638
1639	4	3277	3278	3277	3278	milwaukee-bucks-detroit-pistons	2024-06-15 14:40:00	24	notstarted	\N	1639
1640	4	3279	3280	3279	3280	detroit-pistons-milwaukee-bucks	2025-01-04 12:40:00	53	notstarted	\N	1640
1641	4	3281	3282	3281	3282	indiana-pacers-toronto-raptors	2024-06-15 14:00:00	24	notstarted	\N	1641
1642	4	3283	3284	3283	3284	toronto-raptors-indiana-pacers	2025-01-04 11:20:00	53	notstarted	\N	1642
1643	4	3285	3286	3285	3286	dallas-mavericks-houston-rockets	2024-06-15 16:20:00	24	notstarted	\N	1643
1644	4	3287	3288	3287	3288	houston-rockets-dallas-mavericks	2025-01-04 11:20:00	53	notstarted	\N	1644
1645	4	3289	3290	3289	3290	utah-jazz-phoenix-suns	2024-06-15 10:40:00	24	notstarted	\N	1645
1646	4	3291	3292	3291	3292	phoenix-suns-utah-jazz	2025-01-04 12:20:00	53	notstarted	\N	1646
1647	4	3293	3294	3293	3294	los-angeles-lakers-portland-trail-blazers	2024-06-16 14:40:00	24	notstarted	\N	1647
1648	4	3295	3296	3295	3296	portland-trail-blazers-los-angeles-lakers	2025-01-05 15:30:00	53	notstarted	\N	1648
1649	4	3297	3298	3297	3298	orlando-magic-minnesota-timberwolves	2024-06-16 14:30:00	24	notstarted	\N	1649
1650	4	3299	3300	3299	3300	minnesota-timberwolves-orlando-magic	2025-01-05 10:20:00	53	notstarted	\N	1650
1651	4	3301	3302	3301	3302	san-antonio-spurs-new-york-knicks	2024-06-16 13:30:00	24	notstarted	\N	1651
1652	4	3303	3304	3303	3304	new-york-knicks-san-antonio-spurs	2025-01-05 13:50:00	53	notstarted	\N	1652
1653	4	3305	3306	3305	3306	los-angeles-clippers-golden-state-warriors	2024-06-16 15:10:00	24	notstarted	\N	1653
1654	4	3307	3308	3307	3308	golden-state-warriors-los-angeles-clippers	2025-01-05 10:40:00	53	notstarted	\N	1654
1655	4	3309	3310	3309	3310	new-orleans-pelicans-boston-celtics	2024-06-16 18:50:00	24	notstarted	\N	1655
1656	4	3311	3312	3311	3312	boston-celtics-new-orleans-pelicans	2025-01-05 17:10:00	53	notstarted	\N	1656
1657	4	3313	3314	3313	3314	miami-heat-sacramento-kings	2024-06-16 13:40:00	24	notstarted	\N	1657
1658	4	3315	3316	3315	3316	sacramento-kings-miami-heat	2025-01-05 11:50:00	53	notstarted	\N	1658
1659	4	3317	3318	3317	3318	oklahoma-city-thunder-memphis-grizzlies	2024-06-16 17:00:00	24	notstarted	\N	1659
1660	4	3319	3320	3319	3320	memphis-grizzlies-oklahoma-city-thunder	2025-01-05 15:20:00	53	notstarted	\N	1660
1661	4	3321	3322	3321	3322	dallas-mavericks-brooklyn-nets	2024-06-22 19:50:00	25	notstarted	\N	1661
1662	4	3323	3324	3323	3324	brooklyn-nets-dallas-mavericks	2025-01-11 14:20:00	54	notstarted	\N	1662
1663	4	3325	3326	3325	3326	atlanta-hawks-miami-heat	2024-06-22 12:50:00	25	notstarted	\N	1663
1664	4	3327	3328	3327	3328	miami-heat-atlanta-hawks	2025-01-11 15:20:00	54	notstarted	\N	1664
1665	4	3329	3330	3329	3330	washington-wizards-san-antonio-spurs	2024-06-22 11:10:00	25	notstarted	\N	1665
1666	4	3331	3332	3331	3332	san-antonio-spurs-washington-wizards	2025-01-11 11:50:00	54	notstarted	\N	1666
1667	4	3333	3334	3333	3334	memphis-grizzlies-los-angeles-lakers	2024-06-22 17:20:00	25	notstarted	\N	1667
1668	4	3335	3336	3335	3336	los-angeles-lakers-memphis-grizzlies	2025-01-11 10:30:00	54	notstarted	\N	1668
1669	4	3337	3338	3337	3338	chicago-bulls-minnesota-timberwolves	2024-06-22 19:30:00	25	notstarted	\N	1669
1670	4	3339	3340	3339	3340	minnesota-timberwolves-chicago-bulls	2025-01-11 18:10:00	54	notstarted	\N	1670
1671	4	3341	3342	3341	3342	golden-state-warriors-boston-celtics	2024-06-22 16:10:00	25	notstarted	\N	1671
1672	4	3343	3344	3343	3344	boston-celtics-golden-state-warriors	2025-01-11 14:20:00	54	notstarted	\N	1672
1673	4	3345	3346	3345	3346	orlando-magic-new-york-knicks	2024-06-22 13:50:00	25	notstarted	\N	1673
1674	4	3347	3348	3347	3348	new-york-knicks-orlando-magic	2025-01-11 14:30:00	54	notstarted	\N	1674
1675	4	3349	3350	3349	3350	utah-jazz-philadelphia-76ers	2024-06-22 12:20:00	25	notstarted	\N	1675
1676	4	3351	3352	3351	3352	philadelphia-76ers-utah-jazz	2025-01-11 16:10:00	54	notstarted	\N	1676
1677	4	3353	3354	3353	3354	portland-trail-blazers-charlotte-hornets	2024-06-23 16:10:00	25	notstarted	\N	1677
1678	4	3355	3356	3355	3356	charlotte-hornets-portland-trail-blazers	2025-01-12 15:00:00	54	notstarted	\N	1678
1679	4	3357	3358	3357	3358	los-angeles-clippers-indiana-pacers	2024-06-23 10:00:00	25	notstarted	\N	1679
1680	4	3359	3360	3359	3360	indiana-pacers-los-angeles-clippers	2025-01-12 14:50:00	54	notstarted	\N	1680
1681	4	3361	3362	3361	3362	new-orleans-pelicans-denver-nuggets	2024-06-23 17:00:00	25	notstarted	\N	1681
1682	4	3363	3364	3363	3364	denver-nuggets-new-orleans-pelicans	2025-01-12 10:20:00	54	notstarted	\N	1682
1683	4	3365	3366	3365	3366	phoenix-suns-sacramento-kings	2024-06-23 15:50:00	25	notstarted	\N	1683
1684	4	3367	3368	3367	3368	sacramento-kings-phoenix-suns	2025-01-12 15:20:00	54	notstarted	\N	1684
1685	4	3369	3370	3369	3370	cleveland-cavaliers-milwaukee-bucks	2024-06-23 18:50:00	25	notstarted	\N	1685
1686	4	3371	3372	3371	3372	milwaukee-bucks-cleveland-cavaliers	2025-01-12 16:30:00	54	notstarted	\N	1686
1687	4	3373	3374	3373	3374	houston-rockets-toronto-raptors	2024-06-23 13:40:00	25	notstarted	\N	1687
1688	4	3375	3376	3375	3376	toronto-raptors-houston-rockets	2025-01-12 19:30:00	54	notstarted	\N	1688
1689	4	3377	3378	3377	3378	detroit-pistons-oklahoma-city-thunder	2024-06-23 10:00:00	25	notstarted	\N	1689
1690	4	3379	3380	3379	3380	oklahoma-city-thunder-detroit-pistons	2025-01-12 16:40:00	54	notstarted	\N	1690
1691	4	3381	3382	3381	3382	toronto-raptors-chicago-bulls	2024-06-29 12:00:00	26	notstarted	\N	1691
1692	4	3383	3384	3383	3384	chicago-bulls-toronto-raptors	2025-01-18 18:20:00	55	notstarted	\N	1692
1693	4	3385	3386	3385	3386	charlotte-hornets-miami-heat	2024-06-29 15:40:00	26	notstarted	\N	1693
1694	4	3387	3388	3387	3388	miami-heat-charlotte-hornets	2025-01-18 17:00:00	55	notstarted	\N	1694
1695	4	3389	3390	3389	3390	detroit-pistons-orlando-magic	2024-06-29 11:40:00	26	notstarted	\N	1695
1696	4	3391	3392	3391	3392	orlando-magic-detroit-pistons	2025-01-18 19:00:00	55	notstarted	\N	1696
1697	4	3393	3394	3393	3394	atlanta-hawks-oklahoma-city-thunder	2024-06-29 17:00:00	26	notstarted	\N	1697
1698	4	3395	3396	3395	3396	oklahoma-city-thunder-atlanta-hawks	2025-01-18 11:10:00	55	notstarted	\N	1698
1699	4	3397	3398	3397	3398	phoenix-suns-indiana-pacers	2024-06-29 18:40:00	26	notstarted	\N	1699
1700	4	3399	3400	3399	3400	indiana-pacers-phoenix-suns	2025-01-18 17:40:00	55	notstarted	\N	1700
1701	4	3401	3402	3401	3402	san-antonio-spurs-milwaukee-bucks	2024-06-29 15:00:00	26	notstarted	\N	1701
1702	4	3403	3404	3403	3404	milwaukee-bucks-san-antonio-spurs	2025-01-18 10:30:00	55	notstarted	\N	1702
1703	4	3405	3406	3405	3406	los-angeles-lakers-denver-nuggets	2024-06-29 12:40:00	26	notstarted	\N	1703
1704	4	3407	3408	3407	3408	denver-nuggets-los-angeles-lakers	2025-01-18 16:30:00	55	notstarted	\N	1704
1705	4	3409	3410	3409	3410	utah-jazz-washington-wizards	2024-06-29 11:30:00	26	notstarted	\N	1705
1706	4	3411	3412	3411	3412	washington-wizards-utah-jazz	2025-01-18 17:40:00	55	notstarted	\N	1706
1707	4	3413	3414	3413	3414	new-orleans-pelicans-new-york-knicks	2024-06-30 10:30:00	26	notstarted	\N	1707
1708	4	3415	3416	3415	3416	new-york-knicks-new-orleans-pelicans	2025-01-19 14:30:00	55	notstarted	\N	1708
1709	4	3417	3418	3417	3418	cleveland-cavaliers-golden-state-warriors	2024-06-30 10:30:00	26	notstarted	\N	1709
1710	4	3419	3420	3419	3420	golden-state-warriors-cleveland-cavaliers	2025-01-19 15:50:00	55	notstarted	\N	1710
1711	4	3421	3422	3421	3422	brooklyn-nets-los-angeles-clippers	2024-06-30 14:40:00	26	notstarted	\N	1711
1712	4	3423	3424	3423	3424	los-angeles-clippers-brooklyn-nets	2025-01-19 15:00:00	55	notstarted	\N	1712
1713	4	3425	3426	3425	3426	houston-rockets-portland-trail-blazers	2024-06-30 15:40:00	26	notstarted	\N	1713
1714	4	3427	3428	3427	3428	portland-trail-blazers-houston-rockets	2025-01-19 14:30:00	55	notstarted	\N	1714
1715	4	3429	3430	3429	3430	minnesota-timberwolves-sacramento-kings	2024-06-30 19:30:00	26	notstarted	\N	1715
1716	4	3431	3432	3431	3432	sacramento-kings-minnesota-timberwolves	2025-01-19 19:50:00	55	notstarted	\N	1716
1717	4	3433	3434	3433	3434	dallas-mavericks-philadelphia-76ers	2024-06-30 19:30:00	26	notstarted	\N	1717
1718	4	3435	3436	3435	3436	philadelphia-76ers-dallas-mavericks	2025-01-19 11:10:00	55	notstarted	\N	1718
1719	4	3437	3438	3437	3438	boston-celtics-memphis-grizzlies	2024-06-30 16:50:00	26	notstarted	\N	1719
1720	4	3439	3440	3439	3440	memphis-grizzlies-boston-celtics	2025-01-19 18:00:00	55	notstarted	\N	1720
1721	4	3441	3442	3441	3442	boston-celtics-philadelphia-76ers	2024-07-06 18:00:00	27	notstarted	\N	1721
1722	4	3443	3444	3443	3444	philadelphia-76ers-boston-celtics	2025-01-25 14:10:00	56	notstarted	\N	1722
1723	4	3445	3446	3445	3446	sacramento-kings-golden-state-warriors	2024-07-06 19:10:00	27	notstarted	\N	1723
1724	4	3447	3448	3447	3448	golden-state-warriors-sacramento-kings	2025-01-25 17:30:00	56	notstarted	\N	1724
1725	4	3449	3450	3449	3450	phoenix-suns-minnesota-timberwolves	2024-07-06 14:00:00	27	notstarted	\N	1725
1726	4	3451	3452	3451	3452	minnesota-timberwolves-phoenix-suns	2025-01-25 18:20:00	56	notstarted	\N	1726
1727	4	3453	3454	3453	3454	chicago-bulls-brooklyn-nets	2024-07-06 15:20:00	27	notstarted	\N	1727
1728	4	3455	3456	3455	3456	brooklyn-nets-chicago-bulls	2025-01-25 15:30:00	56	notstarted	\N	1728
1729	4	3457	3458	3457	3458	miami-heat-portland-trail-blazers	2024-07-06 13:00:00	27	notstarted	\N	1729
1730	4	3459	3460	3459	3460	portland-trail-blazers-miami-heat	2025-01-25 12:00:00	56	notstarted	\N	1730
1731	4	3461	3462	3461	3462	detroit-pistons-san-antonio-spurs	2024-07-06 19:00:00	27	notstarted	\N	1731
1732	4	3463	3464	3463	3464	san-antonio-spurs-detroit-pistons	2025-01-25 14:00:00	56	notstarted	\N	1732
1733	4	3465	3466	3465	3466	atlanta-hawks-orlando-magic	2024-07-06 15:20:00	27	notstarted	\N	1733
1734	4	3467	3468	3467	3468	orlando-magic-atlanta-hawks	2025-01-25 17:30:00	56	notstarted	\N	1734
1735	4	3469	3470	3469	3470	milwaukee-bucks-denver-nuggets	2024-07-06 11:00:00	27	notstarted	\N	1735
1736	4	3471	3472	3471	3472	denver-nuggets-milwaukee-bucks	2025-01-25 11:10:00	56	notstarted	\N	1736
1737	4	3473	3474	3473	3474	memphis-grizzlies-charlotte-hornets	2024-07-07 12:10:00	27	notstarted	\N	1737
1738	4	3475	3476	3475	3476	charlotte-hornets-memphis-grizzlies	2025-01-26 16:10:00	56	notstarted	\N	1738
1739	4	3477	3478	3477	3478	los-angeles-lakers-los-angeles-clippers	2024-07-07 11:40:00	27	notstarted	\N	1739
1740	4	3479	3480	3479	3480	los-angeles-clippers-los-angeles-lakers	2025-01-26 10:00:00	56	notstarted	\N	1740
1741	4	3481	3482	3481	3482	indiana-pacers-new-orleans-pelicans	2024-07-07 12:30:00	27	notstarted	\N	1741
1742	4	3483	3484	3483	3484	new-orleans-pelicans-indiana-pacers	2025-01-26 16:10:00	56	notstarted	\N	1742
1743	4	3485	3486	3485	3486	houston-rockets-cleveland-cavaliers	2024-07-07 10:20:00	27	notstarted	\N	1743
1744	4	3487	3488	3487	3488	cleveland-cavaliers-houston-rockets	2025-01-26 15:00:00	56	notstarted	\N	1744
1745	4	3489	3490	3489	3490	utah-jazz-toronto-raptors	2024-07-07 12:50:00	27	notstarted	\N	1745
1746	4	3491	3492	3491	3492	toronto-raptors-utah-jazz	2025-01-26 18:50:00	56	notstarted	\N	1746
1747	4	3493	3494	3493	3494	new-york-knicks-oklahoma-city-thunder	2024-07-07 16:30:00	27	notstarted	\N	1747
1748	4	3495	3496	3495	3496	oklahoma-city-thunder-new-york-knicks	2025-01-26 15:00:00	56	notstarted	\N	1748
1749	4	3497	3498	3497	3498	dallas-mavericks-washington-wizards	2024-07-07 12:30:00	27	notstarted	\N	1749
1750	4	3499	3500	3499	3500	washington-wizards-dallas-mavericks	2025-01-26 10:40:00	56	notstarted	\N	1750
1751	4	3501	3502	3501	3502	memphis-grizzlies-atlanta-hawks	2024-07-13 13:30:00	28	notstarted	\N	1751
1752	4	3503	3504	3503	3504	atlanta-hawks-memphis-grizzlies	2025-02-01 15:30:00	57	notstarted	\N	1752
1753	4	3505	3506	3505	3506	detroit-pistons-houston-rockets	2024-07-13 18:40:00	28	notstarted	\N	1753
1754	4	3507	3508	3507	3508	houston-rockets-detroit-pistons	2025-02-01 10:30:00	57	notstarted	\N	1754
1755	4	3509	3510	3509	3510	toronto-raptors-portland-trail-blazers	2024-07-13 15:30:00	28	notstarted	\N	1755
1756	4	3511	3512	3511	3512	portland-trail-blazers-toronto-raptors	2025-02-01 10:00:00	57	notstarted	\N	1756
1757	4	3513	3514	3513	3514	new-york-knicks-phoenix-suns	2024-07-13 12:20:00	28	notstarted	\N	1757
1758	4	3515	3516	3515	3516	phoenix-suns-new-york-knicks	2025-02-01 13:20:00	57	notstarted	\N	1758
1759	4	3517	3518	3517	3518	new-orleans-pelicans-chicago-bulls	2024-07-13 16:00:00	28	notstarted	\N	1759
1760	4	3519	3520	3519	3520	chicago-bulls-new-orleans-pelicans	2025-02-01 12:30:00	57	notstarted	\N	1760
1761	4	3521	3522	3521	3522	charlotte-hornets-san-antonio-spurs	2024-07-13 10:10:00	28	notstarted	\N	1761
1762	4	3523	3524	3523	3524	san-antonio-spurs-charlotte-hornets	2025-02-01 14:30:00	57	notstarted	\N	1762
1763	4	3525	3526	3525	3526	indiana-pacers-washington-wizards	2024-07-13 14:00:00	28	notstarted	\N	1763
1764	4	3527	3528	3527	3528	washington-wizards-indiana-pacers	2025-02-01 14:50:00	57	notstarted	\N	1764
1765	4	3529	3530	3529	3530	golden-state-warriors-denver-nuggets	2024-07-13 18:20:00	28	notstarted	\N	1765
1766	4	3531	3532	3531	3532	denver-nuggets-golden-state-warriors	2025-02-01 19:30:00	57	notstarted	\N	1766
1767	4	3533	3534	3533	3534	brooklyn-nets-utah-jazz	2024-07-14 11:50:00	28	notstarted	\N	1767
1768	4	3535	3536	3535	3536	utah-jazz-brooklyn-nets	2025-02-02 10:10:00	57	notstarted	\N	1768
1769	4	3537	3538	3537	3538	cleveland-cavaliers-orlando-magic	2024-07-14 11:40:00	28	notstarted	\N	1769
1770	4	3539	3540	3539	3540	orlando-magic-cleveland-cavaliers	2025-02-02 18:00:00	57	notstarted	\N	1770
1771	4	3541	3542	3541	3542	milwaukee-bucks-los-angeles-lakers	2024-07-14 10:20:00	28	notstarted	\N	1771
1772	4	3543	3544	3543	3544	los-angeles-lakers-milwaukee-bucks	2025-02-02 10:00:00	57	notstarted	\N	1772
1773	4	3545	3546	3545	3546	miami-heat-philadelphia-76ers	2024-07-14 12:50:00	28	notstarted	\N	1773
1774	4	3547	3548	3547	3548	philadelphia-76ers-miami-heat	2025-02-02 16:30:00	57	notstarted	\N	1774
1775	4	3549	3550	3549	3550	boston-celtics-sacramento-kings	2024-07-14 14:50:00	28	notstarted	\N	1775
1776	4	3551	3552	3551	3552	sacramento-kings-boston-celtics	2025-02-02 19:20:00	57	notstarted	\N	1776
1777	4	3553	3554	3553	3554	oklahoma-city-thunder-dallas-mavericks	2024-07-14 10:40:00	28	notstarted	\N	1777
1778	4	3555	3556	3555	3556	dallas-mavericks-oklahoma-city-thunder	2025-02-02 17:00:00	57	notstarted	\N	1778
1779	4	3557	3558	3557	3558	minnesota-timberwolves-los-angeles-clippers	2024-07-14 16:00:00	28	notstarted	\N	1779
1780	4	3559	3560	3559	3560	los-angeles-clippers-minnesota-timberwolves	2025-02-02 10:50:00	57	notstarted	\N	1780
1781	4	3561	3562	3561	3562	charlotte-hornets-detroit-pistons	2024-07-20 12:50:00	29	notstarted	\N	1781
1782	4	3563	3564	3563	3564	detroit-pistons-charlotte-hornets	2025-02-08 18:40:00	58	notstarted	\N	1782
1783	4	3565	3566	3565	3566	orlando-magic-los-angeles-lakers	2024-07-20 12:00:00	29	notstarted	\N	1783
1784	4	3567	3568	3567	3568	los-angeles-lakers-orlando-magic	2025-02-08 13:10:00	58	notstarted	\N	1784
1785	4	3569	3570	3569	3570	indiana-pacers-san-antonio-spurs	2024-07-20 18:20:00	29	notstarted	\N	1785
1786	4	3571	3572	3571	3572	san-antonio-spurs-indiana-pacers	2025-02-08 13:30:00	58	notstarted	\N	1786
1787	4	3573	3574	3573	3574	oklahoma-city-thunder-portland-trail-blazers	2024-07-20 19:50:00	29	notstarted	\N	1787
1788	4	3575	3576	3575	3576	portland-trail-blazers-oklahoma-city-thunder	2025-02-08 14:50:00	58	notstarted	\N	1788
1789	4	3577	3578	3577	3578	chicago-bulls-utah-jazz	2024-07-20 18:10:00	29	notstarted	\N	1789
1790	4	3579	3580	3579	3580	utah-jazz-chicago-bulls	2025-02-08 17:10:00	58	notstarted	\N	1790
1791	4	3581	3582	3581	3582	milwaukee-bucks-memphis-grizzlies	2024-07-20 16:20:00	29	notstarted	\N	1791
1792	4	3583	3584	3583	3584	memphis-grizzlies-milwaukee-bucks	2025-02-08 15:40:00	58	notstarted	\N	1792
1793	4	3585	3586	3585	3586	minnesota-timberwolves-philadelphia-76ers	2024-07-20 10:50:00	29	notstarted	\N	1793
1794	4	3587	3588	3587	3588	philadelphia-76ers-minnesota-timberwolves	2025-02-08 16:40:00	58	notstarted	\N	1794
1795	4	3589	3590	3589	3590	houston-rockets-sacramento-kings	2024-07-20 10:30:00	29	notstarted	\N	1795
1796	4	3591	3592	3591	3592	sacramento-kings-houston-rockets	2025-02-08 11:50:00	58	notstarted	\N	1796
1797	4	3593	3594	3593	3594	brooklyn-nets-atlanta-hawks	2024-07-21 15:10:00	29	notstarted	\N	1797
1798	4	3595	3596	3595	3596	atlanta-hawks-brooklyn-nets	2025-02-09 19:50:00	58	notstarted	\N	1798
1799	4	3597	3598	3597	3598	dallas-mavericks-new-orleans-pelicans	2024-07-21 18:00:00	29	notstarted	\N	1799
1800	4	3599	3600	3599	3600	new-orleans-pelicans-dallas-mavericks	2025-02-09 14:00:00	58	notstarted	\N	1800
1801	4	3601	3602	3601	3602	cleveland-cavaliers-denver-nuggets	2024-07-21 12:00:00	29	notstarted	\N	1801
1802	4	3603	3604	3603	3604	denver-nuggets-cleveland-cavaliers	2025-02-09 16:40:00	58	notstarted	\N	1802
1803	4	3605	3606	3605	3606	los-angeles-clippers-toronto-raptors	2024-07-21 19:20:00	29	notstarted	\N	1803
1804	4	3607	3608	3607	3608	toronto-raptors-los-angeles-clippers	2025-02-09 15:50:00	58	notstarted	\N	1804
1805	4	3609	3610	3609	3610	washington-wizards-miami-heat	2024-07-21 11:40:00	29	notstarted	\N	1805
1806	4	3611	3612	3611	3612	miami-heat-washington-wizards	2025-02-09 18:50:00	58	notstarted	\N	1806
1807	4	3613	3614	3613	3614	boston-celtics-new-york-knicks	2024-07-21 12:10:00	29	notstarted	\N	1807
1808	4	3615	3616	3615	3616	new-york-knicks-boston-celtics	2025-02-09 15:50:00	58	notstarted	\N	1808
1809	4	3617	3618	3617	3618	phoenix-suns-golden-state-warriors	2024-07-21 17:20:00	29	notstarted	\N	1809
1810	4	3619	3620	3619	3620	golden-state-warriors-phoenix-suns	2025-02-09 14:40:00	58	notstarted	\N	1810
1811	5	3621	3622	3621	3622	buffalo-bills-minnesota-vikings	2024-01-06 10:10:00	1	finished	away	1811
1812	5	3623	3624	3623	3624	minnesota-vikings-buffalo-bills	2024-08-10 12:40:00	32	notstarted	\N	1812
1813	5	3625	3626	3625	3626	new-york-jets-denver-broncos	2024-01-06 13:10:00	1	finished	away	1813
1814	5	3627	3628	3627	3628	denver-broncos-new-york-jets	2024-08-10 16:20:00	32	notstarted	\N	1814
1815	5	3629	3630	3629	3630	washington-commanders-indianapolis-colts	2024-01-06 12:40:00	1	finished	away	1815
1816	5	3631	3632	3631	3632	indianapolis-colts-washington-commanders	2024-08-10 18:40:00	32	notstarted	\N	1816
1817	5	3633	3634	3633	3634	atlanta-falcons-cleveland-browns	2024-01-06 16:00:00	1	finished	home	1817
1818	5	3635	3636	3635	3636	cleveland-browns-atlanta-falcons	2024-08-10 17:20:00	32	notstarted	\N	1818
1819	5	3637	3638	3637	3638	tampa-bay-buccaneers-detroit-lions	2024-01-06 16:10:00	1	finished	away	1819
1820	5	3639	3640	3639	3640	detroit-lions-tampa-bay-buccaneers	2024-08-10 19:30:00	32	notstarted	\N	1820
1821	5	3641	3642	3641	3642	jacksonville-jaguars-carolina-panthers	2024-01-06 15:30:00	1	finished	away	1821
1822	5	3643	3644	3643	3644	carolina-panthers-jacksonville-jaguars	2024-08-10 11:10:00	32	notstarted	\N	1822
1823	5	3645	3646	3645	3646	green-bay-packers-new-york-giants	2024-01-06 11:50:00	1	finished	home	1823
1824	5	3647	3648	3647	3648	new-york-giants-green-bay-packers	2024-08-10 16:20:00	32	notstarted	\N	1824
1825	5	3649	3650	3649	3650	chicago-bears-los-angeles-rams	2024-01-06 13:00:00	1	finished	home	1825
1826	5	3651	3652	3651	3652	los-angeles-rams-chicago-bears	2024-08-10 13:50:00	32	notstarted	\N	1826
1827	5	3653	3654	3653	3654	houston-texans-new-orleans-saints	2024-01-07 18:40:00	1	finished	away	1827
1828	5	3655	3656	3655	3656	new-orleans-saints-houston-texans	2024-08-11 18:40:00	32	notstarted	\N	1828
1829	5	3657	3658	3657	3658	las-vegas-raiders-dallas-cowboys	2024-01-07 13:20:00	1	finished	away	1829
1830	5	3659	3660	3659	3660	dallas-cowboys-las-vegas-raiders	2024-08-11 11:20:00	32	notstarted	\N	1830
1831	5	3661	3662	3661	3662	pittsburgh-steelers-tennessee-titans	2024-01-07 10:20:00	1	finished	home	1831
1832	5	3663	3664	3663	3664	tennessee-titans-pittsburgh-steelers	2024-08-11 16:20:00	32	notstarted	\N	1832
1833	5	3665	3666	3665	3666	los-angeles-chargers-seattle-seahawks	2024-01-07 18:40:00	1	finished	away	1833
1834	5	3667	3668	3667	3668	seattle-seahawks-los-angeles-chargers	2024-08-11 18:10:00	32	notstarted	\N	1834
1835	5	3669	3670	3669	3670	arizona-cardinals-cincinnati-bengals	2024-01-07 10:50:00	1	finished	home	1835
1836	5	3671	3672	3671	3672	cincinnati-bengals-arizona-cardinals	2024-08-11 13:30:00	32	notstarted	\N	1836
1837	5	3673	3674	3673	3674	san-francisco-49ers-kansas-city-chiefs	2024-01-07 17:20:00	1	finished	home	1837
1838	5	3675	3676	3675	3676	kansas-city-chiefs-san-francisco-49ers	2024-08-11 13:40:00	32	notstarted	\N	1838
1839	5	3677	3678	3677	3678	new-england-patriots-philadelphia-eagles	2024-01-07 13:30:00	1	finished	home	1839
1840	5	3679	3680	3679	3680	philadelphia-eagles-new-england-patriots	2024-08-11 19:40:00	32	notstarted	\N	1840
1841	5	3681	3682	3681	3682	baltimore-ravens-miami-dolphins	2024-01-07 16:30:00	1	finished	home	1841
1842	5	3683	3684	3683	3684	miami-dolphins-baltimore-ravens	2024-08-11 15:20:00	32	notstarted	\N	1842
1843	5	3685	3686	3685	3686	buffalo-bills-denver-broncos	2024-01-13 19:30:00	2	finished	home	1843
1844	5	3687	3688	3687	3688	denver-broncos-buffalo-bills	2024-08-17 18:40:00	33	notstarted	\N	1844
1845	5	3689	3690	3689	3690	san-francisco-49ers-los-angeles-rams	2024-01-13 11:50:00	2	finished	home	1845
1846	5	3691	3692	3691	3692	los-angeles-rams-san-francisco-49ers	2024-08-17 17:10:00	33	notstarted	\N	1846
1847	5	3693	3694	3693	3694	kansas-city-chiefs-houston-texans	2024-01-13 12:10:00	2	finished	away	1847
1848	5	3695	3696	3695	3696	houston-texans-kansas-city-chiefs	2024-08-17 18:30:00	33	notstarted	\N	1848
1849	5	3697	3698	3697	3698	new-york-jets-pittsburgh-steelers	2024-01-13 15:10:00	2	finished	away	1849
1850	5	3699	3700	3699	3700	pittsburgh-steelers-new-york-jets	2024-08-17 13:50:00	33	notstarted	\N	1850
1851	5	3701	3702	3701	3702	atlanta-falcons-new-orleans-saints	2024-01-13 18:30:00	2	finished	away	1851
1852	5	3703	3704	3703	3704	new-orleans-saints-atlanta-falcons	2024-08-17 14:20:00	33	notstarted	\N	1852
1853	5	3705	3706	3705	3706	philadelphia-eagles-new-york-giants	2024-01-13 17:40:00	2	finished	home	1853
1854	5	3707	3708	3707	3708	new-york-giants-philadelphia-eagles	2024-08-17 15:30:00	33	notstarted	\N	1854
1855	5	3709	3710	3709	3710	baltimore-ravens-arizona-cardinals	2024-01-13 10:30:00	2	finished	home	1855
1856	5	3711	3712	3711	3712	arizona-cardinals-baltimore-ravens	2024-08-17 19:50:00	33	notstarted	\N	1856
1857	5	3713	3714	3713	3714	indianapolis-colts-chicago-bears	2024-01-13 19:10:00	2	finished	home	1857
1858	5	3715	3716	3715	3716	chicago-bears-indianapolis-colts	2024-08-17 15:20:00	33	notstarted	\N	1858
1859	5	3717	3718	3717	3718	detroit-lions-jacksonville-jaguars	2024-01-14 16:50:00	2	finished	home	1859
1860	5	3719	3720	3719	3720	jacksonville-jaguars-detroit-lions	2024-08-18 13:40:00	33	notstarted	\N	1860
1861	5	3721	3722	3721	3722	miami-dolphins-las-vegas-raiders	2024-01-14 16:20:00	2	finished	away	1861
1862	5	3723	3724	3723	3724	las-vegas-raiders-miami-dolphins	2024-08-18 12:30:00	33	notstarted	\N	1862
1863	5	3725	3726	3725	3726	dallas-cowboys-los-angeles-chargers	2024-01-14 10:30:00	2	finished	home	1863
1864	5	3727	3728	3727	3728	los-angeles-chargers-dallas-cowboys	2024-08-18 18:00:00	33	notstarted	\N	1864
1865	5	3729	3730	3729	3730	green-bay-packers-minnesota-vikings	2024-01-14 19:40:00	2	finished	away	1865
1866	5	3731	3732	3731	3732	minnesota-vikings-green-bay-packers	2024-08-18 13:20:00	33	notstarted	\N	1866
1867	5	3733	3734	3733	3734	tennessee-titans-new-england-patriots	2024-01-14 18:00:00	2	finished	home	1867
1868	5	3735	3736	3735	3736	new-england-patriots-tennessee-titans	2024-08-18 13:40:00	33	notstarted	\N	1868
1869	5	3737	3738	3737	3738	cincinnati-bengals-washington-commanders	2024-01-14 17:30:00	2	finished	home	1869
1870	5	3739	3740	3739	3740	washington-commanders-cincinnati-bengals	2024-08-18 15:10:00	33	notstarted	\N	1870
1871	5	3741	3742	3741	3742	cleveland-browns-carolina-panthers	2024-01-14 13:10:00	2	finished	home	1871
1872	5	3743	3744	3743	3744	carolina-panthers-cleveland-browns	2024-08-18 10:30:00	33	notstarted	\N	1872
1873	5	3745	3746	3745	3746	tampa-bay-buccaneers-seattle-seahawks	2024-01-14 19:50:00	2	finished	home	1873
1874	5	3747	3748	3747	3748	seattle-seahawks-tampa-bay-buccaneers	2024-08-18 11:50:00	33	notstarted	\N	1874
1875	5	3749	3750	3749	3750	tennessee-titans-new-york-jets	2024-01-20 16:40:00	3	finished	home	1875
1876	5	3751	3752	3751	3752	new-york-jets-tennessee-titans	2024-08-24 13:10:00	34	notstarted	\N	1876
1877	5	3753	3754	3753	3754	tampa-bay-buccaneers-new-york-giants	2024-01-20 19:10:00	3	finished	home	1877
1878	5	3755	3756	3755	3756	new-york-giants-tampa-bay-buccaneers	2024-08-24 11:20:00	34	notstarted	\N	1878
1879	5	3757	3758	3757	3758	jacksonville-jaguars-pittsburgh-steelers	2024-01-20 10:10:00	3	finished	away	1879
1880	5	3759	3760	3759	3760	pittsburgh-steelers-jacksonville-jaguars	2024-08-24 11:40:00	34	notstarted	\N	1880
1881	5	3761	3762	3761	3762	minnesota-vikings-seattle-seahawks	2024-01-20 16:50:00	3	finished	home	1881
1882	5	3763	3764	3763	3764	seattle-seahawks-minnesota-vikings	2024-08-24 18:10:00	34	notstarted	\N	1882
1883	5	3765	3766	3765	3766	washington-commanders-chicago-bears	2024-01-20 15:20:00	3	finished	away	1883
1884	5	3767	3768	3767	3768	chicago-bears-washington-commanders	2024-08-24 19:10:00	34	notstarted	\N	1884
1885	5	3769	3770	3769	3770	green-bay-packers-los-angeles-rams	2024-01-20 11:30:00	3	finished	home	1885
1886	5	3771	3772	3771	3772	los-angeles-rams-green-bay-packers	2024-08-24 12:10:00	34	notstarted	\N	1886
1887	5	3773	3774	3773	3774	detroit-lions-san-francisco-49ers	2024-01-20 11:20:00	3	finished	away	1887
1888	5	3775	3776	3775	3776	san-francisco-49ers-detroit-lions	2024-08-24 13:40:00	34	notstarted	\N	1888
1889	5	3777	3778	3777	3778	arizona-cardinals-los-angeles-chargers	2024-01-20 13:20:00	3	finished	home	1889
1890	5	3779	3780	3779	3780	los-angeles-chargers-arizona-cardinals	2024-08-24 11:40:00	34	notstarted	\N	1890
1891	5	3781	3782	3781	3782	buffalo-bills-atlanta-falcons	2024-01-21 12:50:00	3	finished	home	1891
1892	5	3783	3784	3783	3784	atlanta-falcons-buffalo-bills	2024-08-25 11:10:00	34	notstarted	\N	1892
1893	5	3785	3786	3785	3786	baltimore-ravens-kansas-city-chiefs	2024-01-21 13:40:00	3	finished	away	1893
1894	5	3787	3788	3787	3788	kansas-city-chiefs-baltimore-ravens	2024-08-25 11:00:00	34	notstarted	\N	1894
1895	5	3789	3790	3789	3790	carolina-panthers-cincinnati-bengals	2024-01-21 10:40:00	3	finished	home	1895
1896	5	3791	3792	3791	3792	cincinnati-bengals-carolina-panthers	2024-08-25 19:20:00	34	notstarted	\N	1896
1897	5	3793	3794	3793	3794	new-orleans-saints-cleveland-browns	2024-01-21 10:20:00	3	finished	away	1897
1898	5	3795	3796	3795	3796	cleveland-browns-new-orleans-saints	2024-08-25 10:10:00	34	notstarted	\N	1898
1899	5	3797	3798	3797	3798	las-vegas-raiders-indianapolis-colts	2024-01-21 15:30:00	3	finished	away	1899
1900	5	3799	3800	3799	3800	indianapolis-colts-las-vegas-raiders	2024-08-25 19:10:00	34	notstarted	\N	1900
1901	5	3801	3802	3801	3802	philadelphia-eagles-miami-dolphins	2024-01-21 17:30:00	3	finished	away	1901
1902	5	3803	3804	3803	3804	miami-dolphins-philadelphia-eagles	2024-08-25 12:10:00	34	notstarted	\N	1902
1903	5	3805	3806	3805	3806	new-england-patriots-denver-broncos	2024-01-21 12:20:00	3	finished	home	1903
1904	5	3807	3808	3807	3808	denver-broncos-new-england-patriots	2024-08-25 17:40:00	34	notstarted	\N	1904
1905	5	3809	3810	3809	3810	houston-texans-dallas-cowboys	2024-01-21 18:00:00	3	finished	home	1905
1906	5	3811	3812	3811	3812	dallas-cowboys-houston-texans	2024-08-25 18:50:00	34	notstarted	\N	1906
1907	5	3813	3814	3813	3814	kansas-city-chiefs-los-angeles-chargers	2024-01-27 14:40:00	4	finished	away	1907
1908	5	3815	3816	3815	3816	los-angeles-chargers-kansas-city-chiefs	2024-08-31 17:50:00	35	notstarted	\N	1908
1909	5	3817	3818	3817	3818	denver-broncos-arizona-cardinals	2024-01-27 11:40:00	4	finished	away	1909
1910	5	3819	3820	3819	3820	arizona-cardinals-denver-broncos	2024-08-31 18:40:00	35	notstarted	\N	1910
1911	5	3821	3822	3821	3822	baltimore-ravens-new-england-patriots	2024-01-27 10:40:00	4	finished	away	1911
1912	5	3823	3824	3823	3824	new-england-patriots-baltimore-ravens	2024-08-31 10:00:00	35	notstarted	\N	1912
1913	5	3825	3826	3825	3826	miami-dolphins-los-angeles-rams	2024-01-27 16:30:00	4	finished	home	1913
1914	5	3827	3828	3827	3828	los-angeles-rams-miami-dolphins	2024-08-31 15:20:00	35	notstarted	\N	1914
1915	5	3829	3830	3829	3830	houston-texans-cincinnati-bengals	2024-01-27 13:20:00	4	finished	home	1915
1916	5	3831	3832	3831	3832	cincinnati-bengals-houston-texans	2024-08-31 10:10:00	35	notstarted	\N	1916
1917	5	3833	3834	3833	3834	chicago-bears-new-orleans-saints	2024-01-27 16:20:00	4	finished	away	1917
1918	5	3835	3836	3835	3836	new-orleans-saints-chicago-bears	2024-08-31 16:50:00	35	notstarted	\N	1918
1919	5	3837	3838	3837	3838	seattle-seahawks-carolina-panthers	2024-01-27 11:00:00	4	finished	home	1919
1920	5	3839	3840	3839	3840	carolina-panthers-seattle-seahawks	2024-08-31 17:20:00	35	notstarted	\N	1920
1921	5	3841	3842	3841	3842	new-york-jets-atlanta-falcons	2024-01-27 16:00:00	4	finished	away	1921
1922	5	3843	3844	3843	3844	atlanta-falcons-new-york-jets	2024-08-31 12:00:00	35	notstarted	\N	1922
1923	5	3845	3846	3845	3846	new-york-giants-buffalo-bills	2024-01-28 14:10:00	4	finished	away	1923
1924	5	3847	3848	3847	3848	buffalo-bills-new-york-giants	2024-09-01 15:20:00	35	notstarted	\N	1924
1925	5	3849	3850	3849	3850	washington-commanders-jacksonville-jaguars	2024-01-28 19:30:00	4	finished	away	1925
1926	5	3851	3852	3851	3852	jacksonville-jaguars-washington-commanders	2024-09-01 10:40:00	35	notstarted	\N	1926
1927	5	3853	3854	3853	3854	cleveland-browns-green-bay-packers	2024-01-28 14:20:00	4	finished	away	1927
1928	5	3855	3856	3855	3856	green-bay-packers-cleveland-browns	2024-09-01 13:30:00	35	notstarted	\N	1928
1929	5	3857	3858	3857	3858	minnesota-vikings-philadelphia-eagles	2024-01-28 17:50:00	4	finished	home	1929
1930	5	3859	3860	3859	3860	philadelphia-eagles-minnesota-vikings	2024-09-01 17:20:00	35	notstarted	\N	1930
1931	5	3861	3862	3861	3862	tennessee-titans-las-vegas-raiders	2024-01-28 11:30:00	4	finished	home	1931
1932	5	3863	3864	3863	3864	las-vegas-raiders-tennessee-titans	2024-09-01 13:20:00	35	notstarted	\N	1932
1933	5	3865	3866	3865	3866	pittsburgh-steelers-indianapolis-colts	2024-01-28 16:50:00	4	finished	home	1933
1934	5	3867	3868	3867	3868	indianapolis-colts-pittsburgh-steelers	2024-09-01 16:50:00	35	notstarted	\N	1934
1935	5	3869	3870	3869	3870	san-francisco-49ers-tampa-bay-buccaneers	2024-01-28 19:40:00	4	finished	home	1935
1936	5	3871	3872	3871	3872	tampa-bay-buccaneers-san-francisco-49ers	2024-09-01 15:40:00	35	notstarted	\N	1936
1937	5	3873	3874	3873	3874	dallas-cowboys-detroit-lions	2024-01-28 11:20:00	4	finished	away	1937
1938	5	3875	3876	3875	3876	detroit-lions-dallas-cowboys	2024-09-01 11:00:00	35	notstarted	\N	1938
1939	5	3877	3878	3877	3878	new-orleans-saints-cincinnati-bengals	2024-02-03 10:00:00	5	finished	home	1939
1940	5	3879	3880	3879	3880	cincinnati-bengals-new-orleans-saints	2024-09-07 19:50:00	36	notstarted	\N	1940
1941	5	3881	3882	3881	3882	atlanta-falcons-jacksonville-jaguars	2024-02-03 16:20:00	5	finished	home	1941
1942	5	3883	3884	3883	3884	jacksonville-jaguars-atlanta-falcons	2024-09-07 14:10:00	36	notstarted	\N	1942
1943	5	3885	3886	3885	3886	new-england-patriots-new-york-jets	2024-02-03 14:50:00	5	finished	away	1943
1944	5	3887	3888	3887	3888	new-york-jets-new-england-patriots	2024-09-07 17:00:00	36	notstarted	\N	1944
1945	5	3889	3890	3889	3890	philadelphia-eagles-seattle-seahawks	2024-02-03 14:10:00	5	finished	away	1945
1946	5	3891	3892	3891	3892	seattle-seahawks-philadelphia-eagles	2024-09-07 12:20:00	36	notstarted	\N	1946
1947	5	3893	3894	3893	3894	houston-texans-washington-commanders	2024-02-03 18:30:00	5	finished	away	1947
1948	5	3895	3896	3895	3896	washington-commanders-houston-texans	2024-09-07 16:00:00	36	notstarted	\N	1948
1949	5	3897	3898	3897	3898	pittsburgh-steelers-chicago-bears	2024-02-03 15:40:00	5	finished	away	1949
1950	5	3899	3900	3899	3900	chicago-bears-pittsburgh-steelers	2024-09-07 12:30:00	36	notstarted	\N	1950
1951	5	3901	3902	3901	3902	new-york-giants-detroit-lions	2024-02-03 10:30:00	5	finished	home	1951
1952	5	3903	3904	3903	3904	detroit-lions-new-york-giants	2024-09-07 12:50:00	36	notstarted	\N	1952
1953	5	3905	3906	3905	3906	tampa-bay-buccaneers-tennessee-titans	2024-02-03 19:50:00	5	finished	home	1953
1954	5	3907	3908	3907	3908	tennessee-titans-tampa-bay-buccaneers	2024-09-07 16:30:00	36	notstarted	\N	1954
1955	5	3909	3910	3909	3910	buffalo-bills-dallas-cowboys	2024-02-04 10:20:00	5	finished	away	1955
1956	5	3911	3912	3911	3912	dallas-cowboys-buffalo-bills	2024-09-08 17:30:00	36	notstarted	\N	1956
1957	5	3913	3914	3913	3914	kansas-city-chiefs-green-bay-packers	2024-02-04 11:20:00	5	finished	home	1957
1958	5	3915	3916	3915	3916	green-bay-packers-kansas-city-chiefs	2024-09-08 12:50:00	36	notstarted	\N	1958
1959	5	3917	3918	3917	3918	cleveland-browns-las-vegas-raiders	2024-02-04 11:40:00	5	finished	home	1959
1960	5	3919	3920	3919	3920	las-vegas-raiders-cleveland-browns	2024-09-08 13:20:00	36	notstarted	\N	1960
1961	5	3921	3922	3921	3922	los-angeles-chargers-carolina-panthers	2024-02-04 13:10:00	5	finished	away	1961
1962	5	3923	3924	3923	3924	carolina-panthers-los-angeles-chargers	2024-09-08 10:10:00	36	notstarted	\N	1962
1963	5	3925	3926	3925	3926	denver-broncos-los-angeles-rams	2024-02-04 13:50:00	5	finished	away	1963
1964	5	3927	3928	3927	3928	los-angeles-rams-denver-broncos	2024-09-08 16:50:00	36	notstarted	\N	1964
1965	5	3929	3930	3929	3930	miami-dolphins-arizona-cardinals	2024-02-04 15:30:00	5	finished	home	1965
1966	5	3931	3932	3931	3932	arizona-cardinals-miami-dolphins	2024-09-08 17:50:00	36	notstarted	\N	1966
1967	5	3933	3934	3933	3934	san-francisco-49ers-indianapolis-colts	2024-02-04 18:20:00	5	finished	away	1967
1968	5	3935	3936	3935	3936	indianapolis-colts-san-francisco-49ers	2024-09-08 17:00:00	36	notstarted	\N	1968
1969	5	3937	3938	3937	3938	baltimore-ravens-minnesota-vikings	2024-02-04 18:40:00	5	finished	away	1969
1970	5	3939	3940	3939	3940	minnesota-vikings-baltimore-ravens	2024-09-08 14:50:00	36	notstarted	\N	1970
1971	5	3941	3942	3941	3942	buffalo-bills-carolina-panthers	2024-02-10 13:30:00	6	finished	home	1971
1972	5	3943	3944	3943	3944	carolina-panthers-buffalo-bills	2024-09-14 16:00:00	37	notstarted	\N	1972
1973	5	3945	3946	3945	3946	los-angeles-chargers-san-francisco-49ers	2024-02-10 14:30:00	6	finished	away	1973
1974	5	3947	3948	3947	3948	san-francisco-49ers-los-angeles-chargers	2024-09-14 10:00:00	37	notstarted	\N	1974
1975	5	3949	3950	3949	3950	washington-commanders-miami-dolphins	2024-02-10 15:30:00	6	finished	away	1975
1976	5	3951	3952	3951	3952	miami-dolphins-washington-commanders	2024-09-14 16:00:00	37	notstarted	\N	1976
1977	5	3953	3954	3953	3954	new-york-giants-new-york-jets	2024-02-10 11:10:00	6	finished	away	1977
1978	5	3955	3956	3955	3956	new-york-jets-new-york-giants	2024-09-14 10:50:00	37	notstarted	\N	1978
1979	5	3957	3958	3957	3958	tennessee-titans-atlanta-falcons	2024-02-10 13:10:00	6	finished	away	1979
1980	5	3959	3960	3959	3960	atlanta-falcons-tennessee-titans	2024-09-14 11:20:00	37	notstarted	\N	1980
1981	5	3961	3962	3961	3962	baltimore-ravens-detroit-lions	2024-02-10 11:40:00	6	finished	away	1981
1982	5	3963	3964	3963	3964	detroit-lions-baltimore-ravens	2024-09-14 19:30:00	37	notstarted	\N	1982
1983	5	3965	3966	3965	3966	houston-texans-new-england-patriots	2024-02-10 19:30:00	6	finished	home	1983
1984	5	3967	3968	3967	3968	new-england-patriots-houston-texans	2024-09-14 17:20:00	37	notstarted	\N	1984
1985	5	3969	3970	3969	3970	new-orleans-saints-los-angeles-rams	2024-02-10 15:10:00	6	finished	home	1985
1986	5	3971	3972	3971	3972	los-angeles-rams-new-orleans-saints	2024-09-14 11:20:00	37	notstarted	\N	1986
1987	5	3973	3974	3973	3974	cincinnati-bengals-seattle-seahawks	2024-02-11 11:30:00	6	finished	home	1987
1988	5	3975	3976	3975	3976	seattle-seahawks-cincinnati-bengals	2024-09-15 19:10:00	37	notstarted	\N	1988
1989	5	3977	3978	3977	3978	dallas-cowboys-chicago-bears	2024-02-11 19:20:00	6	finished	away	1989
1990	5	3979	3980	3979	3980	chicago-bears-dallas-cowboys	2024-09-15 18:50:00	37	notstarted	\N	1990
1991	5	3981	3982	3981	3982	arizona-cardinals-jacksonville-jaguars	2024-02-11 18:50:00	6	finished	home	1991
1992	5	3983	3984	3983	3984	jacksonville-jaguars-arizona-cardinals	2024-09-15 11:10:00	37	notstarted	\N	1992
1993	5	3985	3986	3985	3986	pittsburgh-steelers-minnesota-vikings	2024-02-11 15:00:00	6	finished	home	1993
1994	5	3987	3988	3987	3988	minnesota-vikings-pittsburgh-steelers	2024-09-15 10:30:00	37	notstarted	\N	1994
1995	5	3989	3990	3989	3990	cleveland-browns-denver-broncos	2024-02-11 14:20:00	6	finished	away	1995
1996	5	3991	3992	3991	3992	denver-broncos-cleveland-browns	2024-09-15 10:50:00	37	notstarted	\N	1996
1997	5	3993	3994	3993	3994	green-bay-packers-tampa-bay-buccaneers	2024-02-11 14:00:00	6	finished	away	1997
1998	5	3995	3996	3995	3996	tampa-bay-buccaneers-green-bay-packers	2024-09-15 12:20:00	37	notstarted	\N	1998
1999	5	3997	3998	3997	3998	las-vegas-raiders-kansas-city-chiefs	2024-02-11 15:40:00	6	finished	home	1999
2000	5	3999	4000	3999	4000	kansas-city-chiefs-las-vegas-raiders	2024-09-15 18:30:00	37	notstarted	\N	2000
2001	5	4001	4002	4001	4002	philadelphia-eagles-indianapolis-colts	2024-02-11 19:20:00	6	finished	away	2001
2002	5	4003	4004	4003	4004	indianapolis-colts-philadelphia-eagles	2024-09-15 13:00:00	37	notstarted	\N	2002
2003	5	4005	4006	4005	4006	philadelphia-eagles-dallas-cowboys	2024-02-17 16:20:00	7	finished	home	2003
2004	5	4007	4008	4007	4008	dallas-cowboys-philadelphia-eagles	2024-09-21 11:50:00	38	notstarted	\N	2004
2005	5	4009	4010	4009	4010	san-francisco-49ers-tennessee-titans	2024-02-17 12:00:00	7	finished	home	2005
2006	5	4011	4012	4011	4012	tennessee-titans-san-francisco-49ers	2024-09-21 11:20:00	38	notstarted	\N	2006
2007	5	4013	4014	4013	4014	new-england-patriots-los-angeles-rams	2024-02-17 10:40:00	7	finished	home	2007
2008	5	4015	4016	4015	4016	los-angeles-rams-new-england-patriots	2024-09-21 11:10:00	38	notstarted	\N	2008
2009	5	4017	4018	4017	4018	cincinnati-bengals-kansas-city-chiefs	2024-02-17 13:10:00	7	finished	away	2009
2010	5	4019	4020	4019	4020	kansas-city-chiefs-cincinnati-bengals	2024-09-21 18:20:00	38	notstarted	\N	2010
2011	5	4021	4022	4021	4022	tampa-bay-buccaneers-arizona-cardinals	2024-02-17 13:40:00	7	finished	home	2011
2012	5	4023	4024	4023	4024	arizona-cardinals-tampa-bay-buccaneers	2024-09-21 18:00:00	38	notstarted	\N	2012
2013	5	4025	4026	4025	4026	carolina-panthers-new-york-jets	2024-02-17 19:10:00	7	finished	away	2013
2014	5	4027	4028	4027	4028	new-york-jets-carolina-panthers	2024-09-21 15:50:00	38	notstarted	\N	2014
2015	5	4029	4030	4029	4030	minnesota-vikings-cleveland-browns	2024-02-17 15:50:00	7	finished	home	2015
2016	5	4031	4032	4031	4032	cleveland-browns-minnesota-vikings	2024-09-21 18:20:00	38	notstarted	\N	2016
2017	5	4033	4034	4033	4034	jacksonville-jaguars-baltimore-ravens	2024-02-17 15:20:00	7	finished	home	2017
2018	5	4035	4036	4035	4036	baltimore-ravens-jacksonville-jaguars	2024-09-21 12:00:00	38	notstarted	\N	2018
2019	5	4037	4038	4037	4038	buffalo-bills-indianapolis-colts	2024-02-18 10:20:00	7	finished	home	2019
2020	5	4039	4040	4039	4040	indianapolis-colts-buffalo-bills	2024-09-22 19:40:00	38	notstarted	\N	2020
2021	5	4041	4042	4041	4042	green-bay-packers-detroit-lions	2024-02-18 19:10:00	7	finished	home	2021
2022	5	4043	4044	4043	4044	detroit-lions-green-bay-packers	2024-09-22 18:10:00	38	notstarted	\N	2022
2023	5	4045	4046	4045	4046	washington-commanders-new-york-giants	2024-02-18 12:50:00	7	finished	away	2023
2024	5	4047	4048	4047	4048	new-york-giants-washington-commanders	2024-09-22 12:40:00	38	notstarted	\N	2024
2025	5	4049	4050	4049	4050	chicago-bears-atlanta-falcons	2024-02-18 13:10:00	7	finished	home	2025
2026	5	4051	4052	4051	4052	atlanta-falcons-chicago-bears	2024-09-22 11:40:00	38	notstarted	\N	2026
2027	5	4053	4054	4053	4054	pittsburgh-steelers-new-orleans-saints	2024-02-18 17:30:00	7	finished	away	2027
2028	5	4055	4056	4055	4056	new-orleans-saints-pittsburgh-steelers	2024-09-22 16:40:00	38	notstarted	\N	2028
2029	5	4057	4058	4057	4058	seattle-seahawks-denver-broncos	2024-02-18 14:20:00	7	finished	away	2029
2030	5	4059	4060	4059	4060	denver-broncos-seattle-seahawks	2024-09-22 15:30:00	38	notstarted	\N	2030
2031	5	4061	4062	4061	4062	los-angeles-chargers-miami-dolphins	2024-02-18 14:20:00	7	finished	away	2031
2032	5	4063	4064	4063	4064	miami-dolphins-los-angeles-chargers	2024-09-22 17:10:00	38	notstarted	\N	2032
2033	5	4065	4066	4065	4066	las-vegas-raiders-houston-texans	2024-02-18 18:20:00	7	finished	home	2033
2034	5	4067	4068	4067	4068	houston-texans-las-vegas-raiders	2024-09-22 16:50:00	38	notstarted	\N	2034
2035	5	4069	4070	4069	4070	miami-dolphins-carolina-panthers	2024-02-24 12:20:00	8	finished	away	2035
2036	5	4071	4072	4071	4072	carolina-panthers-miami-dolphins	2024-09-28 17:20:00	39	notstarted	\N	2036
2037	5	4073	4074	4073	4074	philadelphia-eagles-los-angeles-chargers	2024-02-24 13:40:00	8	finished	away	2037
2038	5	4075	4076	4075	4076	los-angeles-chargers-philadelphia-eagles	2024-09-28 17:00:00	39	notstarted	\N	2038
2039	5	4077	4078	4077	4078	denver-broncos-cincinnati-bengals	2024-02-24 15:30:00	8	finished	home	2039
2040	5	4079	4080	4079	4080	cincinnati-bengals-denver-broncos	2024-09-28 18:50:00	39	notstarted	\N	2040
2041	5	4081	4082	4081	4082	houston-texans-seattle-seahawks	2024-02-24 15:10:00	8	finished	away	2041
2042	5	4083	4084	4083	4084	seattle-seahawks-houston-texans	2024-09-28 19:20:00	39	notstarted	\N	2042
2043	5	4085	4086	4085	4086	dallas-cowboys-atlanta-falcons	2024-02-24 19:30:00	8	finished	home	2043
2044	5	4087	4088	4087	4088	atlanta-falcons-dallas-cowboys	2024-09-28 18:30:00	39	notstarted	\N	2044
2045	5	4089	4090	4089	4090	new-england-patriots-washington-commanders	2024-02-24 19:50:00	8	finished	away	2045
2046	5	4091	4092	4091	4092	washington-commanders-new-england-patriots	2024-09-28 14:50:00	39	notstarted	\N	2046
2047	5	4093	4094	4093	4094	tennessee-titans-jacksonville-jaguars	2024-02-24 16:10:00	8	finished	home	2047
2048	5	4095	4096	4095	4096	jacksonville-jaguars-tennessee-titans	2024-09-28 18:00:00	39	notstarted	\N	2048
2049	5	4097	4098	4097	4098	buffalo-bills-new-york-jets	2024-02-24 17:30:00	8	finished	home	2049
2050	5	4099	4100	4099	4100	new-york-jets-buffalo-bills	2024-09-28 14:00:00	39	notstarted	\N	2050
2051	5	4101	4102	4101	4102	san-francisco-49ers-las-vegas-raiders	2024-02-25 18:10:00	8	finished	home	2051
2052	5	4103	4104	4103	4104	las-vegas-raiders-san-francisco-49ers	2024-09-29 17:40:00	39	notstarted	\N	2052
2053	5	4105	4106	4105	4106	minnesota-vikings-los-angeles-rams	2024-02-25 10:20:00	8	finished	away	2053
2054	5	4107	4108	4107	4108	los-angeles-rams-minnesota-vikings	2024-09-29 15:20:00	39	notstarted	\N	2054
2055	5	4109	4110	4109	4110	detroit-lions-arizona-cardinals	2024-02-25 18:10:00	8	finished	home	2055
2056	5	4111	4112	4111	4112	arizona-cardinals-detroit-lions	2024-09-29 13:20:00	39	notstarted	\N	2056
2057	5	4113	4114	4113	4114	cleveland-browns-pittsburgh-steelers	2024-02-25 16:30:00	8	finished	home	2057
2058	5	4115	4116	4115	4116	pittsburgh-steelers-cleveland-browns	2024-09-29 10:20:00	39	notstarted	\N	2058
2059	5	4117	4118	4117	4118	new-orleans-saints-kansas-city-chiefs	2024-02-25 12:30:00	8	finished	away	2059
2060	5	4119	4120	4119	4120	kansas-city-chiefs-new-orleans-saints	2024-09-29 17:00:00	39	notstarted	\N	2060
2061	5	4121	4122	4121	4122	chicago-bears-green-bay-packers	2024-02-25 19:10:00	8	finished	home	2061
2062	5	4123	4124	4123	4124	green-bay-packers-chicago-bears	2024-09-29 12:20:00	39	notstarted	\N	2062
2063	5	4125	4126	4125	4126	tampa-bay-buccaneers-indianapolis-colts	2024-02-25 11:20:00	8	finished	away	2063
2064	5	4127	4128	4127	4128	indianapolis-colts-tampa-bay-buccaneers	2024-09-29 14:50:00	39	notstarted	\N	2064
2065	5	4129	4130	4129	4130	baltimore-ravens-new-york-giants	2024-02-25 15:50:00	8	finished	home	2065
2066	5	4131	4132	4131	4132	new-york-giants-baltimore-ravens	2024-09-29 17:10:00	39	notstarted	\N	2066
2067	5	4133	4134	4133	4134	atlanta-falcons-washington-commanders	2024-03-02 17:30:00	9	finished	home	2067
2068	5	4135	4136	4135	4136	washington-commanders-atlanta-falcons	2024-10-05 11:50:00	40	notstarted	\N	2068
2069	5	4137	4138	4137	4138	chicago-bears-new-york-jets	2024-03-02 16:40:00	9	finished	home	2069
2070	5	4139	4140	4139	4140	new-york-jets-chicago-bears	2024-10-05 13:30:00	40	notstarted	\N	2070
2071	5	4141	4142	4141	4142	carolina-panthers-baltimore-ravens	2024-03-02 14:10:00	9	finished	away	2071
2072	5	4143	4144	4143	4144	baltimore-ravens-carolina-panthers	2024-10-05 18:10:00	40	notstarted	\N	2072
2073	5	4145	4146	4145	4146	san-francisco-49ers-arizona-cardinals	2024-03-02 17:30:00	9	finished	home	2073
2074	5	4147	4148	4147	4148	arizona-cardinals-san-francisco-49ers	2024-10-05 17:40:00	40	notstarted	\N	2074
2075	5	4149	4150	4149	4150	miami-dolphins-indianapolis-colts	2024-03-02 13:00:00	9	finished	away	2075
2076	5	4151	4152	4151	4152	indianapolis-colts-miami-dolphins	2024-10-05 17:30:00	40	notstarted	\N	2076
2077	5	4153	4154	4153	4154	new-orleans-saints-minnesota-vikings	2024-03-02 16:10:00	9	finished	away	2077
2078	5	4155	4156	4155	4156	minnesota-vikings-new-orleans-saints	2024-10-05 14:30:00	40	notstarted	\N	2078
2079	5	4157	4158	4157	4158	los-angeles-chargers-tampa-bay-buccaneers	2024-03-02 10:00:00	9	finished	home	2079
2080	5	4159	4160	4159	4160	tampa-bay-buccaneers-los-angeles-chargers	2024-10-05 10:40:00	40	notstarted	\N	2080
2081	5	4161	4162	4161	4162	pittsburgh-steelers-detroit-lions	2024-03-02 16:20:00	9	finished	away	2081
2082	5	4163	4164	4163	4164	detroit-lions-pittsburgh-steelers	2024-10-05 15:40:00	40	notstarted	\N	2082
2083	5	4165	4166	4165	4166	los-angeles-rams-cincinnati-bengals	2024-03-03 15:40:00	9	finished	home	2083
2084	5	4167	4168	4167	4168	cincinnati-bengals-los-angeles-rams	2024-10-06 10:00:00	40	notstarted	\N	2084
2085	5	4169	4170	4169	4170	houston-texans-green-bay-packers	2024-03-03 17:10:00	9	finished	home	2085
2086	5	4171	4172	4171	4172	green-bay-packers-houston-texans	2024-10-06 13:20:00	40	notstarted	\N	2086
2087	5	4173	4174	4173	4174	kansas-city-chiefs-denver-broncos	2024-03-03 14:50:00	9	finished	home	2087
2088	5	4175	4176	4175	4176	denver-broncos-kansas-city-chiefs	2024-10-06 17:00:00	40	notstarted	\N	2088
2089	5	4177	4178	4177	4178	new-york-giants-seattle-seahawks	2024-03-03 17:10:00	9	finished	home	2089
2090	5	4179	4180	4179	4180	seattle-seahawks-new-york-giants	2024-10-06 15:10:00	40	notstarted	\N	2090
2091	5	4181	4182	4181	4182	dallas-cowboys-tennessee-titans	2024-03-03 15:10:00	9	finished	away	2091
2092	5	4183	4184	4183	4184	tennessee-titans-dallas-cowboys	2024-10-06 14:40:00	40	notstarted	\N	2092
2093	5	4185	4186	4185	4186	philadelphia-eagles-las-vegas-raiders	2024-03-03 12:50:00	9	finished	away	2093
2094	5	4187	4188	4187	4188	las-vegas-raiders-philadelphia-eagles	2024-10-06 18:30:00	40	notstarted	\N	2094
2095	5	4189	4190	4189	4190	jacksonville-jaguars-new-england-patriots	2024-03-03 18:10:00	9	finished	home	2095
2096	5	4191	4192	4191	4192	new-england-patriots-jacksonville-jaguars	2024-10-06 13:30:00	40	notstarted	\N	2096
2097	5	4193	4194	4193	4194	buffalo-bills-cleveland-browns	2024-03-03 19:40:00	9	finished	away	2097
2098	5	4195	4196	4195	4196	cleveland-browns-buffalo-bills	2024-10-06 14:00:00	40	notstarted	\N	2098
2099	5	4197	4198	4197	4198	indianapolis-colts-los-angeles-chargers	2024-03-09 18:20:00	10	finished	away	2099
2100	5	4199	4200	4199	4200	los-angeles-chargers-indianapolis-colts	2024-10-12 15:30:00	41	notstarted	\N	2100
2101	5	4201	4202	4201	4202	los-angeles-rams-buffalo-bills	2024-03-09 19:30:00	10	finished	home	2101
2102	5	4203	4204	4203	4204	buffalo-bills-los-angeles-rams	2024-10-12 13:50:00	41	notstarted	\N	2102
2103	5	4205	4206	4205	4206	cleveland-browns-chicago-bears	2024-03-09 16:00:00	10	finished	home	2103
2104	5	4207	4208	4207	4208	chicago-bears-cleveland-browns	2024-10-12 13:20:00	41	notstarted	\N	2104
2105	5	4209	4210	4209	4210	new-york-giants-miami-dolphins	2024-03-09 12:40:00	10	finished	away	2105
2106	5	4211	4212	4211	4212	miami-dolphins-new-york-giants	2024-10-12 11:10:00	41	notstarted	\N	2106
2107	5	4213	4214	4213	4214	carolina-panthers-detroit-lions	2024-03-09 15:10:00	10	finished	home	2107
2108	5	4215	4216	4215	4216	detroit-lions-carolina-panthers	2024-10-12 12:30:00	41	notstarted	\N	2108
2109	5	4217	4218	4217	4218	philadelphia-eagles-new-york-jets	2024-03-09 15:20:00	10	finished	away	2109
2110	5	4219	4220	4219	4220	new-york-jets-philadelphia-eagles	2024-10-12 11:50:00	41	notstarted	\N	2110
2111	5	4221	4222	4221	4222	pittsburgh-steelers-atlanta-falcons	2024-03-09 14:40:00	10	finished	home	2111
2112	5	4223	4224	4223	4224	atlanta-falcons-pittsburgh-steelers	2024-10-12 14:30:00	41	notstarted	\N	2112
2113	5	4225	4226	4225	4226	tampa-bay-buccaneers-new-orleans-saints	2024-03-09 15:20:00	10	finished	home	2113
2114	5	4227	4228	4227	4228	new-orleans-saints-tampa-bay-buccaneers	2024-10-12 13:40:00	41	notstarted	\N	2114
2115	5	4229	4230	4229	4230	denver-broncos-baltimore-ravens	2024-03-10 15:20:00	10	finished	home	2115
2116	5	4231	4232	4231	4232	baltimore-ravens-denver-broncos	2024-10-13 11:00:00	41	notstarted	\N	2116
2117	5	4233	4234	4233	4234	minnesota-vikings-las-vegas-raiders	2024-03-10 17:30:00	10	finished	away	2117
2118	5	4235	4236	4235	4236	las-vegas-raiders-minnesota-vikings	2024-10-13 19:10:00	41	notstarted	\N	2118
2119	5	4237	4238	4237	4238	kansas-city-chiefs-jacksonville-jaguars	2024-03-10 13:10:00	10	finished	home	2119
2120	5	4239	4240	4239	4240	jacksonville-jaguars-kansas-city-chiefs	2024-10-13 19:00:00	41	notstarted	\N	2120
2121	5	4241	4242	4241	4242	dallas-cowboys-new-england-patriots	2024-03-10 18:40:00	10	finished	home	2121
2122	5	4243	4244	4243	4244	new-england-patriots-dallas-cowboys	2024-10-13 19:30:00	41	notstarted	\N	2122
2123	5	4245	4246	4245	4246	cincinnati-bengals-tennessee-titans	2024-03-10 10:10:00	10	finished	away	2123
2124	5	4247	4248	4247	4248	tennessee-titans-cincinnati-bengals	2024-10-13 19:30:00	41	notstarted	\N	2124
2125	5	4249	4250	4249	4250	green-bay-packers-washington-commanders	2024-03-10 12:30:00	10	finished	home	2125
2126	5	4251	4252	4251	4252	washington-commanders-green-bay-packers	2024-10-13 11:30:00	41	notstarted	\N	2126
2127	5	4253	4254	4253	4254	houston-texans-arizona-cardinals	2024-03-10 18:50:00	10	finished	away	2127
2128	5	4255	4256	4255	4256	arizona-cardinals-houston-texans	2024-10-13 12:30:00	41	notstarted	\N	2128
2129	5	4257	4258	4257	4258	seattle-seahawks-san-francisco-49ers	2024-03-10 17:10:00	10	finished	away	2129
2130	5	4259	4260	4259	4260	san-francisco-49ers-seattle-seahawks	2024-10-13 10:40:00	41	notstarted	\N	2130
2131	5	4261	4262	4261	4262	kansas-city-chiefs-carolina-panthers	2024-03-16 18:00:00	11	finished	away	2131
2132	5	4263	4264	4263	4264	carolina-panthers-kansas-city-chiefs	2024-10-19 14:20:00	42	notstarted	\N	2132
2133	5	4265	4266	4265	4266	tampa-bay-buccaneers-las-vegas-raiders	2024-03-16 19:00:00	11	finished	away	2133
2134	5	4267	4268	4267	4268	las-vegas-raiders-tampa-bay-buccaneers	2024-10-19 11:30:00	42	notstarted	\N	2134
2135	5	4269	4270	4269	4270	seattle-seahawks-new-orleans-saints	2024-03-16 17:40:00	11	finished	away	2135
2136	5	4271	4272	4271	4272	new-orleans-saints-seattle-seahawks	2024-10-19 17:00:00	42	notstarted	\N	2136
2137	5	4273	4274	4273	4274	miami-dolphins-tennessee-titans	2024-03-16 17:50:00	11	finished	away	2137
2138	5	4275	4276	4275	4276	tennessee-titans-miami-dolphins	2024-10-19 17:00:00	42	notstarted	\N	2138
2139	5	4277	4278	4277	4278	new-england-patriots-indianapolis-colts	2024-03-16 15:30:00	11	finished	home	2139
2140	5	4279	4280	4279	4280	indianapolis-colts-new-england-patriots	2024-10-19 17:00:00	42	notstarted	\N	2140
2141	5	4281	4282	4281	4282	san-francisco-49ers-new-york-giants	2024-03-16 17:10:00	11	finished	home	2141
2142	5	4283	4284	4283	4284	new-york-giants-san-francisco-49ers	2024-10-19 12:10:00	42	notstarted	\N	2142
2143	5	4285	4286	4285	4286	chicago-bears-los-angeles-chargers	2024-03-16 13:20:00	11	finished	home	2143
2144	5	4287	4288	4287	4288	los-angeles-chargers-chicago-bears	2024-10-19 10:40:00	42	notstarted	\N	2144
2145	5	4289	4290	4289	4290	atlanta-falcons-arizona-cardinals	2024-03-16 12:50:00	11	finished	home	2145
2146	5	4291	4292	4291	4292	arizona-cardinals-atlanta-falcons	2024-10-19 18:10:00	42	notstarted	\N	2146
2147	5	4293	4294	4293	4294	washington-commanders-detroit-lions	2024-03-17 12:00:00	11	finished	away	2147
2148	5	4295	4296	4295	4296	detroit-lions-washington-commanders	2024-10-20 19:20:00	42	notstarted	\N	2148
2149	5	4297	4298	4297	4298	jacksonville-jaguars-cleveland-browns	2024-03-17 13:10:00	11	finished	away	2149
2150	5	4299	4300	4299	4300	cleveland-browns-jacksonville-jaguars	2024-10-20 11:30:00	42	notstarted	\N	2150
2151	5	4301	4302	4301	4302	baltimore-ravens-dallas-cowboys	2024-03-17 15:50:00	11	finished	away	2151
2152	5	4303	4304	4303	4304	dallas-cowboys-baltimore-ravens	2024-10-20 14:40:00	42	notstarted	\N	2152
2153	5	4305	4306	4305	4306	minnesota-vikings-houston-texans	2024-03-17 16:50:00	11	finished	home	2153
2154	5	4307	4308	4307	4308	houston-texans-minnesota-vikings	2024-10-20 12:30:00	42	notstarted	\N	2154
2155	5	4309	4310	4309	4310	philadelphia-eagles-pittsburgh-steelers	2024-03-17 10:40:00	11	finished	home	2155
2156	5	4311	4312	4311	4312	pittsburgh-steelers-philadelphia-eagles	2024-10-20 10:30:00	42	notstarted	\N	2156
2157	5	4313	4314	4313	4314	los-angeles-rams-new-york-jets	2024-03-17 11:10:00	11	finished	home	2157
2158	5	4315	4316	4315	4316	new-york-jets-los-angeles-rams	2024-10-20 13:30:00	42	notstarted	\N	2158
2159	5	4317	4318	4317	4318	denver-broncos-green-bay-packers	2024-03-17 15:20:00	11	finished	home	2159
2160	5	4319	4320	4319	4320	green-bay-packers-denver-broncos	2024-10-20 12:00:00	42	notstarted	\N	2160
2161	5	4321	4322	4321	4322	buffalo-bills-cincinnati-bengals	2024-03-17 17:00:00	11	finished	home	2161
2162	5	4323	4324	4323	4324	cincinnati-bengals-buffalo-bills	2024-10-20 14:30:00	42	notstarted	\N	2162
2163	5	4325	4326	4325	4326	new-york-giants-dallas-cowboys	2024-03-23 11:20:00	12	finished	away	2163
2164	5	4327	4328	4327	4328	dallas-cowboys-new-york-giants	2024-10-26 18:00:00	43	notstarted	\N	2164
2165	5	4329	4330	4329	4330	arizona-cardinals-carolina-panthers	2024-03-23 12:40:00	12	finished	away	2165
2166	5	4331	4332	4331	4332	carolina-panthers-arizona-cardinals	2024-10-26 15:20:00	43	notstarted	\N	2166
2167	5	4333	4334	4333	4334	san-francisco-49ers-atlanta-falcons	2024-03-23 13:10:00	12	finished	away	2167
2168	5	4335	4336	4335	4336	atlanta-falcons-san-francisco-49ers	2024-10-26 13:20:00	43	notstarted	\N	2168
2169	5	4337	4338	4337	4338	las-vegas-raiders-detroit-lions	2024-03-23 10:10:00	12	finished	home	2169
2170	5	4339	4340	4339	4340	detroit-lions-las-vegas-raiders	2024-10-26 11:50:00	43	notstarted	\N	2170
2171	5	4341	4342	4341	4342	cincinnati-bengals-indianapolis-colts	2024-03-23 19:00:00	12	finished	home	2171
2172	5	4343	4344	4343	4344	indianapolis-colts-cincinnati-bengals	2024-10-26 14:00:00	43	notstarted	\N	2172
2173	5	4345	4346	4345	4346	denver-broncos-miami-dolphins	2024-03-23 13:40:00	12	finished	home	2173
2174	5	4347	4348	4347	4348	miami-dolphins-denver-broncos	2024-10-26 19:30:00	43	notstarted	\N	2174
2175	5	4349	4350	4349	4350	jacksonville-jaguars-seattle-seahawks	2024-03-23 16:30:00	12	finished	away	2175
2176	5	4351	4352	4351	4352	seattle-seahawks-jacksonville-jaguars	2024-10-26 19:30:00	43	notstarted	\N	2176
2177	5	4353	4354	4353	4354	washington-commanders-los-angeles-rams	2024-03-23 16:00:00	12	finished	home	2177
2178	5	4355	4356	4355	4356	los-angeles-rams-washington-commanders	2024-10-26 19:10:00	43	notstarted	\N	2178
2179	5	4357	4358	4357	4358	baltimore-ravens-tampa-bay-buccaneers	2024-03-24 17:40:00	12	finished	home	2179
2180	5	4359	4360	4359	4360	tampa-bay-buccaneers-baltimore-ravens	2024-10-27 11:20:00	43	notstarted	\N	2180
2181	5	4361	4362	4361	4362	new-york-jets-new-orleans-saints	2024-03-24 15:20:00	12	finished	home	2181
2182	5	4363	4364	4363	4364	new-orleans-saints-new-york-jets	2024-10-27 10:00:00	43	notstarted	\N	2182
2183	5	4365	4366	4365	4366	philadelphia-eagles-buffalo-bills	2024-03-24 15:00:00	12	finished	home	2183
2184	5	4367	4368	4367	4368	buffalo-bills-philadelphia-eagles	2024-10-27 11:30:00	43	notstarted	\N	2184
2185	5	4369	4370	4369	4370	new-england-patriots-minnesota-vikings	2024-03-24 17:50:00	12	finished	away	2185
2186	5	4371	4372	4371	4372	minnesota-vikings-new-england-patriots	2024-10-27 10:50:00	43	notstarted	\N	2186
2187	5	4373	4374	4373	4374	los-angeles-chargers-tennessee-titans	2024-03-24 11:30:00	12	finished	home	2187
2188	5	4375	4376	4375	4376	tennessee-titans-los-angeles-chargers	2024-10-27 11:50:00	43	notstarted	\N	2188
2189	5	4377	4378	4377	4378	houston-texans-chicago-bears	2024-03-24 15:50:00	12	finished	home	2189
2190	5	4379	4380	4379	4380	chicago-bears-houston-texans	2024-10-27 13:30:00	43	notstarted	\N	2190
2191	5	4381	4382	4381	4382	cleveland-browns-kansas-city-chiefs	2024-03-24 16:10:00	12	finished	home	2191
2192	5	4383	4384	4383	4384	kansas-city-chiefs-cleveland-browns	2024-10-27 19:00:00	43	notstarted	\N	2192
2193	5	4385	4386	4385	4386	pittsburgh-steelers-green-bay-packers	2024-03-24 12:40:00	12	finished	away	2193
2194	5	4387	4388	4387	4388	green-bay-packers-pittsburgh-steelers	2024-10-27 10:00:00	43	notstarted	\N	2194
2195	5	4389	4390	4389	4390	new-orleans-saints-jacksonville-jaguars	2024-03-30 18:10:00	13	finished	home	2195
2196	5	4391	4392	4391	4392	jacksonville-jaguars-new-orleans-saints	2024-11-02 13:50:00	44	notstarted	\N	2196
2197	5	4393	4394	4393	4394	pittsburgh-steelers-houston-texans	2024-03-30 18:10:00	13	finished	home	2197
2198	5	4395	4396	4395	4396	houston-texans-pittsburgh-steelers	2024-11-02 11:30:00	44	notstarted	\N	2198
2199	5	4397	4398	4397	4398	green-bay-packers-miami-dolphins	2024-03-30 11:40:00	13	finished	away	2199
2200	5	4399	4400	4399	4400	miami-dolphins-green-bay-packers	2024-11-02 11:00:00	44	notstarted	\N	2200
2201	5	4401	4402	4401	4402	washington-commanders-cleveland-browns	2024-03-30 16:40:00	13	finished	away	2201
2202	5	4403	4404	4403	4404	cleveland-browns-washington-commanders	2024-11-02 11:40:00	44	notstarted	\N	2202
2203	5	4405	4406	4405	4406	atlanta-falcons-tampa-bay-buccaneers	2024-03-30 11:20:00	13	finished	home	2203
2204	5	4407	4408	4407	4408	tampa-bay-buccaneers-atlanta-falcons	2024-11-02 12:40:00	44	notstarted	\N	2204
2205	5	4409	4410	4409	4410	minnesota-vikings-new-york-giants	2024-03-30 15:30:00	13	finished	away	2205
2206	5	4411	4412	4411	4412	new-york-giants-minnesota-vikings	2024-11-02 13:10:00	44	notstarted	\N	2206
2207	5	4413	4414	4413	4414	arizona-cardinals-new-york-jets	2024-03-30 19:30:00	13	finished	home	2207
2208	5	4415	4416	4415	4416	new-york-jets-arizona-cardinals	2024-11-02 10:00:00	44	notstarted	\N	2208
2209	5	4417	4418	4417	4418	carolina-panthers-philadelphia-eagles	2024-03-30 12:30:00	13	finished	home	2209
2210	5	4419	4420	4419	4420	philadelphia-eagles-carolina-panthers	2024-11-02 14:10:00	44	notstarted	\N	2210
2211	5	4421	4422	4421	4422	detroit-lions-cincinnati-bengals	2024-03-31 10:40:00	13	finished	away	2211
2212	5	4423	4424	4423	4424	cincinnati-bengals-detroit-lions	2024-11-03 14:10:00	44	notstarted	\N	2212
2213	5	4425	4426	4425	4426	indianapolis-colts-baltimore-ravens	2024-03-31 18:50:00	13	finished	away	2213
2214	5	4427	4428	4427	4428	baltimore-ravens-indianapolis-colts	2024-11-03 18:00:00	44	notstarted	\N	2214
2215	5	4429	4430	4429	4430	kansas-city-chiefs-buffalo-bills	2024-03-31 18:10:00	13	finished	home	2215
2216	5	4431	4432	4431	4432	buffalo-bills-kansas-city-chiefs	2024-11-03 12:40:00	44	notstarted	\N	2216
2217	5	4433	4434	4433	4434	los-angeles-chargers-los-angeles-rams	2024-03-31 14:00:00	13	finished	away	2217
2218	5	4435	4436	4435	4436	los-angeles-rams-los-angeles-chargers	2024-11-03 13:10:00	44	notstarted	\N	2218
2219	5	4437	4438	4437	4438	tennessee-titans-denver-broncos	2024-03-31 17:50:00	13	finished	away	2219
2220	5	4439	4440	4439	4440	denver-broncos-tennessee-titans	2024-11-03 14:20:00	44	notstarted	\N	2220
2221	5	4441	4442	4441	4442	new-england-patriots-las-vegas-raiders	2024-03-31 19:30:00	13	finished	home	2221
2222	5	4443	4444	4443	4444	las-vegas-raiders-new-england-patriots	2024-11-03 13:10:00	44	notstarted	\N	2222
2223	5	4445	4446	4445	4446	chicago-bears-seattle-seahawks	2024-03-31 18:20:00	13	finished	away	2223
2224	5	4447	4448	4447	4448	seattle-seahawks-chicago-bears	2024-11-03 14:10:00	44	notstarted	\N	2224
2225	5	4449	4450	4449	4450	dallas-cowboys-san-francisco-49ers	2024-03-31 18:20:00	13	finished	away	2225
2226	5	4451	4452	4451	4452	san-francisco-49ers-dallas-cowboys	2024-11-03 19:30:00	44	notstarted	\N	2226
2227	5	4453	4454	4453	4454	new-york-jets-seattle-seahawks	2024-04-06 16:20:00	14	finished	home	2227
2228	5	4455	4456	4455	4456	seattle-seahawks-new-york-jets	2024-11-09 13:20:00	45	notstarted	\N	2228
2229	5	4457	4458	4457	4458	cleveland-browns-los-angeles-rams	2024-04-06 19:50:00	14	finished	away	2229
2230	5	4459	4460	4459	4460	los-angeles-rams-cleveland-browns	2024-11-09 12:40:00	45	notstarted	\N	2230
2231	5	4461	4462	4461	4462	las-vegas-raiders-arizona-cardinals	2024-04-06 13:50:00	14	finished	home	2231
2232	5	4463	4464	4463	4464	arizona-cardinals-las-vegas-raiders	2024-11-09 16:00:00	45	notstarted	\N	2232
2233	5	4465	4466	4465	4466	new-orleans-saints-green-bay-packers	2024-04-06 12:00:00	14	finished	home	2233
2234	5	4467	4468	4467	4468	green-bay-packers-new-orleans-saints	2024-11-09 19:50:00	45	notstarted	\N	2234
2235	5	4469	4470	4469	4470	dallas-cowboys-pittsburgh-steelers	2024-04-06 19:00:00	14	finished	home	2235
2236	5	4471	4472	4471	4472	pittsburgh-steelers-dallas-cowboys	2024-11-09 16:30:00	45	notstarted	\N	2236
2237	5	4473	4474	4473	4474	denver-broncos-chicago-bears	2024-04-06 19:50:00	14	finished	home	2237
2238	5	4475	4476	4475	4476	chicago-bears-denver-broncos	2024-11-09 17:50:00	45	notstarted	\N	2238
2239	5	4477	4478	4477	4478	detroit-lions-houston-texans	2024-04-06 15:10:00	14	finished	away	2239
2240	5	4479	4480	4479	4480	houston-texans-detroit-lions	2024-11-09 15:00:00	45	notstarted	\N	2240
2241	5	4481	4482	4481	4482	san-francisco-49ers-minnesota-vikings	2024-04-06 11:20:00	14	finished	away	2241
2242	5	4483	4484	4483	4484	minnesota-vikings-san-francisco-49ers	2024-11-09 16:20:00	45	notstarted	\N	2242
2243	5	4485	4486	4485	4486	buffalo-bills-tampa-bay-buccaneers	2024-04-07 12:20:00	14	finished	away	2243
2244	5	4487	4488	4487	4488	tampa-bay-buccaneers-buffalo-bills	2024-11-10 10:40:00	45	notstarted	\N	2244
2245	5	4489	4490	4489	4490	carolina-panthers-atlanta-falcons	2024-04-07 15:40:00	14	finished	home	2245
2246	5	4491	4492	4491	4492	atlanta-falcons-carolina-panthers	2024-11-10 10:00:00	45	notstarted	\N	2246
2247	5	4493	4494	4493	4494	washington-commanders-philadelphia-eagles	2024-04-07 18:00:00	14	finished	home	2247
2248	5	4495	4496	4495	4496	philadelphia-eagles-washington-commanders	2024-11-10 18:50:00	45	notstarted	\N	2248
2249	5	4497	4498	4497	4498	new-york-giants-jacksonville-jaguars	2024-04-07 16:20:00	14	finished	away	2249
2250	5	4499	4500	4499	4500	jacksonville-jaguars-new-york-giants	2024-11-10 11:20:00	45	notstarted	\N	2250
2251	5	4501	4502	4501	4502	tennessee-titans-baltimore-ravens	2024-04-07 13:30:00	14	finished	home	2251
2252	5	4503	4504	4503	4504	baltimore-ravens-tennessee-titans	2024-11-10 15:50:00	45	notstarted	\N	2252
2253	5	4505	4506	4505	4506	new-england-patriots-miami-dolphins	2024-04-07 13:00:00	14	finished	home	2253
2254	5	4507	4508	4507	4508	miami-dolphins-new-england-patriots	2024-11-10 15:40:00	45	notstarted	\N	2254
2255	5	4509	4510	4509	4510	los-angeles-chargers-cincinnati-bengals	2024-04-07 18:30:00	14	finished	home	2255
2256	5	4511	4512	4511	4512	cincinnati-bengals-los-angeles-chargers	2024-11-10 16:30:00	45	notstarted	\N	2256
2257	5	4513	4514	4513	4514	indianapolis-colts-kansas-city-chiefs	2024-04-07 12:10:00	14	finished	away	2257
2258	5	4515	4516	4515	4516	kansas-city-chiefs-indianapolis-colts	2024-11-10 12:00:00	45	notstarted	\N	2258
2259	5	4517	4518	4517	4518	dallas-cowboys-new-york-jets	2024-04-13 16:20:00	15	finished	home	2259
2260	5	4519	4520	4519	4520	new-york-jets-dallas-cowboys	2024-11-16 14:30:00	46	notstarted	\N	2260
2261	5	4521	4522	4521	4522	baltimore-ravens-los-angeles-chargers	2024-04-13 14:40:00	15	finished	away	2261
2262	5	4523	4524	4523	4524	los-angeles-chargers-baltimore-ravens	2024-11-16 19:40:00	46	notstarted	\N	2262
2263	5	4525	4526	4525	4526	las-vegas-raiders-chicago-bears	2024-04-13 16:00:00	15	finished	home	2263
2264	5	4527	4528	4527	4528	chicago-bears-las-vegas-raiders	2024-11-16 17:00:00	46	notstarted	\N	2264
2265	5	4529	4530	4529	4530	carolina-panthers-tennessee-titans	2024-04-13 17:50:00	15	finished	away	2265
2266	5	4531	4532	4531	4532	tennessee-titans-carolina-panthers	2024-11-16 14:10:00	46	notstarted	\N	2266
2267	5	4533	4534	4533	4534	new-york-giants-indianapolis-colts	2024-04-13 18:50:00	15	finished	home	2267
2268	5	4535	4536	4535	4536	indianapolis-colts-new-york-giants	2024-11-16 12:20:00	46	notstarted	\N	2268
2269	5	4537	4538	4537	4538	buffalo-bills-miami-dolphins	2024-04-13 15:20:00	15	finished	home	2269
2270	5	4539	4540	4539	4540	miami-dolphins-buffalo-bills	2024-11-16 19:20:00	46	notstarted	\N	2270
2271	5	4541	4542	4541	4542	kansas-city-chiefs-tampa-bay-buccaneers	2024-04-13 18:10:00	15	finished	home	2271
2272	5	4543	4544	4543	4544	tampa-bay-buccaneers-kansas-city-chiefs	2024-11-16 12:40:00	46	notstarted	\N	2272
2273	5	4545	4546	4545	4546	cleveland-browns-houston-texans	2024-04-13 12:10:00	15	finished	home	2273
2274	5	4547	4548	4547	4548	houston-texans-cleveland-browns	2024-11-16 12:30:00	46	notstarted	\N	2274
2275	5	4549	4550	4549	4550	arizona-cardinals-philadelphia-eagles	2024-04-14 16:20:00	15	finished	home	2275
2276	5	4551	4552	4551	4552	philadelphia-eagles-arizona-cardinals	2024-11-17 17:30:00	46	notstarted	\N	2276
2277	5	4553	4554	4553	4554	denver-broncos-jacksonville-jaguars	2024-04-14 15:40:00	15	finished	home	2277
2278	5	4555	4556	4555	4556	jacksonville-jaguars-denver-broncos	2024-11-17 14:30:00	46	notstarted	\N	2278
2279	5	4557	4558	4557	4558	washington-commanders-minnesota-vikings	2024-04-14 18:30:00	15	finished	away	2279
2280	5	4559	4560	4559	4560	minnesota-vikings-washington-commanders	2024-11-17 12:00:00	46	notstarted	\N	2280
2281	5	4561	4562	4561	4562	atlanta-falcons-cincinnati-bengals	2024-04-14 12:20:00	15	finished	home	2281
2282	5	4563	4564	4563	4564	cincinnati-bengals-atlanta-falcons	2024-11-17 13:20:00	46	notstarted	\N	2282
2283	5	4565	4566	4565	4566	san-francisco-49ers-green-bay-packers	2024-04-14 14:50:00	15	finished	home	2283
2284	5	4567	4568	4567	4568	green-bay-packers-san-francisco-49ers	2024-11-17 10:10:00	46	notstarted	\N	2284
2285	5	4569	4570	4569	4570	los-angeles-rams-detroit-lions	2024-04-14 14:40:00	15	finished	away	2285
2286	5	4571	4572	4571	4572	detroit-lions-los-angeles-rams	2024-11-17 12:30:00	46	notstarted	\N	2286
2287	5	4573	4574	4573	4574	new-orleans-saints-new-england-patriots	2024-04-14 10:00:00	15	finished	home	2287
2288	5	4575	4576	4575	4576	new-england-patriots-new-orleans-saints	2024-11-17 16:30:00	46	notstarted	\N	2288
2289	5	4577	4578	4577	4578	pittsburgh-steelers-seattle-seahawks	2024-04-14 12:10:00	15	finished	away	2289
2290	5	4579	4580	4579	4580	seattle-seahawks-pittsburgh-steelers	2024-11-17 12:10:00	46	notstarted	\N	2290
2291	5	4581	4582	4581	4582	chicago-bears-arizona-cardinals	2024-04-20 10:50:00	16	finished	home	2291
2292	5	4583	4584	4583	4584	arizona-cardinals-chicago-bears	2024-11-23 17:10:00	47	notstarted	\N	2292
2293	5	4585	4586	4585	4586	philadelphia-eagles-new-orleans-saints	2024-04-20 13:50:00	16	finished	home	2293
2294	5	4587	4588	4587	4588	new-orleans-saints-philadelphia-eagles	2024-11-23 15:00:00	47	notstarted	\N	2294
2295	5	4589	4590	4589	4590	buffalo-bills-los-angeles-chargers	2024-04-20 12:40:00	16	finished	away	2295
2296	5	4591	4592	4591	4592	los-angeles-chargers-buffalo-bills	2024-11-23 12:00:00	47	notstarted	\N	2296
2297	5	4593	4594	4593	4594	seattle-seahawks-indianapolis-colts	2024-04-20 12:00:00	16	finished	home	2297
2298	5	4595	4596	4595	4596	indianapolis-colts-seattle-seahawks	2024-11-23 19:00:00	47	notstarted	\N	2298
2299	5	4597	4598	4597	4598	pittsburgh-steelers-kansas-city-chiefs	2024-04-20 19:20:00	16	finished	away	2299
2300	5	4599	4600	4599	4600	kansas-city-chiefs-pittsburgh-steelers	2024-11-23 17:30:00	47	notstarted	\N	2300
2301	5	4601	4602	4601	4602	jacksonville-jaguars-houston-texans	2024-04-20 17:20:00	16	finished	home	2301
2302	5	4603	4604	4603	4604	houston-texans-jacksonville-jaguars	2024-11-23 16:50:00	47	notstarted	\N	2302
2303	5	4605	4606	4605	4606	green-bay-packers-carolina-panthers	2024-04-20 12:00:00	16	finished	away	2303
2304	5	4607	4608	4607	4608	carolina-panthers-green-bay-packers	2024-11-23 18:30:00	47	notstarted	\N	2304
2305	5	4609	4610	4609	4610	dallas-cowboys-miami-dolphins	2024-04-20 15:30:00	16	finished	home	2305
2306	5	4611	4612	4611	4612	miami-dolphins-dallas-cowboys	2024-11-23 19:10:00	47	notstarted	\N	2306
2307	5	4613	4614	4613	4614	las-vegas-raiders-new-york-jets	2024-04-21 15:00:00	16	finished	away	2307
2308	5	4615	4616	4615	4616	new-york-jets-las-vegas-raiders	2024-11-24 14:20:00	47	notstarted	\N	2308
2309	5	4617	4618	4617	4618	denver-broncos-detroit-lions	2024-04-21 13:40:00	16	finished	home	2309
2310	5	4619	4620	4619	4620	detroit-lions-denver-broncos	2024-11-24 19:40:00	47	notstarted	\N	2310
2311	5	4621	4622	4621	4622	cincinnati-bengals-new-england-patriots	2024-04-21 17:10:00	16	finished	home	2311
2312	5	4623	4624	4623	4624	new-england-patriots-cincinnati-bengals	2024-11-24 16:10:00	47	notstarted	\N	2312
2313	5	4625	4626	4625	4626	cleveland-browns-san-francisco-49ers	2024-04-21 11:40:00	16	finished	home	2313
2314	5	4627	4628	4627	4628	san-francisco-49ers-cleveland-browns	2024-11-24 17:00:00	47	notstarted	\N	2314
2315	5	4629	4630	4629	4630	washington-commanders-tennessee-titans	2024-04-21 13:00:00	16	finished	home	2315
2316	5	4631	4632	4631	4632	tennessee-titans-washington-commanders	2024-11-24 18:50:00	47	notstarted	\N	2316
2317	5	4633	4634	4633	4634	new-york-giants-los-angeles-rams	2024-04-21 10:40:00	16	finished	home	2317
2318	5	4635	4636	4635	4636	los-angeles-rams-new-york-giants	2024-11-24 17:10:00	47	notstarted	\N	2318
2319	5	4637	4638	4637	4638	tampa-bay-buccaneers-minnesota-vikings	2024-04-21 15:00:00	16	finished	home	2319
2320	5	4639	4640	4639	4640	minnesota-vikings-tampa-bay-buccaneers	2024-11-24 15:20:00	47	notstarted	\N	2320
2321	5	4641	4642	4641	4642	atlanta-falcons-baltimore-ravens	2024-04-21 13:50:00	16	finished	away	2321
2322	5	4643	4644	4643	4644	baltimore-ravens-atlanta-falcons	2024-11-24 11:10:00	47	notstarted	\N	2322
2323	5	4645	4646	4645	4646	new-england-patriots-new-york-giants	2024-04-27 19:20:00	17	finished	away	2323
2324	5	4647	4648	4647	4648	new-york-giants-new-england-patriots	2024-11-30 14:00:00	48	notstarted	\N	2324
2325	5	4649	4650	4649	4650	tennessee-titans-houston-texans	2024-04-27 16:00:00	17	finished	home	2325
2326	5	4651	4652	4651	4652	houston-texans-tennessee-titans	2024-11-30 19:10:00	48	notstarted	\N	2326
2327	5	4653	4654	4653	4654	kansas-city-chiefs-minnesota-vikings	2024-04-27 13:30:00	17	finished	home	2327
2328	5	4655	4656	4655	4656	minnesota-vikings-kansas-city-chiefs	2024-11-30 11:50:00	48	notstarted	\N	2328
2329	5	4657	4658	4657	4658	san-francisco-49ers-cincinnati-bengals	2024-04-27 10:30:00	17	finished	away	2329
2330	5	4659	4660	4659	4660	cincinnati-bengals-san-francisco-49ers	2024-11-30 15:40:00	48	notstarted	\N	2330
2331	5	4661	4662	4661	4662	los-angeles-chargers-las-vegas-raiders	2024-04-27 16:30:00	17	finished	home	2331
2332	5	4663	4664	4663	4664	las-vegas-raiders-los-angeles-chargers	2024-11-30 16:10:00	48	notstarted	\N	2332
2333	5	4665	4666	4665	4666	buffalo-bills-arizona-cardinals	2024-04-27 16:00:00	17	finished	home	2333
2334	5	4667	4668	4667	4668	arizona-cardinals-buffalo-bills	2024-11-30 18:50:00	48	notstarted	\N	2334
2335	5	4669	4670	4669	4670	miami-dolphins-tampa-bay-buccaneers	2024-04-27 14:40:00	17	finished	home	2335
2336	5	4671	4672	4671	4672	tampa-bay-buccaneers-miami-dolphins	2024-11-30 14:00:00	48	notstarted	\N	2336
2337	5	4673	4674	4673	4674	los-angeles-rams-carolina-panthers	2024-04-27 11:10:00	17	finished	home	2337
2338	5	4675	4676	4675	4676	carolina-panthers-los-angeles-rams	2024-11-30 10:30:00	48	notstarted	\N	2338
2339	5	4677	4678	4677	4678	new-york-jets-cleveland-browns	2024-04-28 17:50:00	17	finished	away	2339
2340	5	4679	4680	4679	4680	cleveland-browns-new-york-jets	2024-12-01 11:50:00	48	notstarted	\N	2340
2341	5	4681	4682	4681	4682	denver-broncos-indianapolis-colts	2024-04-28 19:20:00	17	finished	home	2341
2342	5	4683	4684	4683	4684	indianapolis-colts-denver-broncos	2024-12-01 11:20:00	48	notstarted	\N	2342
2343	5	4685	4686	4685	4686	baltimore-ravens-seattle-seahawks	2024-04-28 12:30:00	17	finished	away	2343
2344	5	4687	4688	4687	4688	seattle-seahawks-baltimore-ravens	2024-12-01 10:40:00	48	notstarted	\N	2344
2345	5	4689	4690	4689	4690	pittsburgh-steelers-washington-commanders	2024-04-28 19:50:00	17	finished	home	2345
2346	5	4691	4692	4691	4692	washington-commanders-pittsburgh-steelers	2024-12-01 15:30:00	48	notstarted	\N	2346
2347	5	4693	4694	4693	4694	philadelphia-eagles-jacksonville-jaguars	2024-04-28 13:00:00	17	finished	home	2347
2348	5	4695	4696	4695	4696	jacksonville-jaguars-philadelphia-eagles	2024-12-01 12:20:00	48	notstarted	\N	2348
2349	5	4697	4698	4697	4698	new-orleans-saints-dallas-cowboys	2024-04-28 14:30:00	17	finished	home	2349
2350	5	4699	4700	4699	4700	dallas-cowboys-new-orleans-saints	2024-12-01 14:10:00	48	notstarted	\N	2350
2351	5	4701	4702	4701	4702	green-bay-packers-atlanta-falcons	2024-04-28 14:10:00	17	finished	away	2351
2352	5	4703	4704	4703	4704	atlanta-falcons-green-bay-packers	2024-12-01 12:20:00	48	notstarted	\N	2352
2353	5	4705	4706	4705	4706	detroit-lions-chicago-bears	2024-04-28 18:40:00	17	finished	away	2353
2354	5	4707	4708	4707	4708	chicago-bears-detroit-lions	2024-12-01 18:40:00	48	notstarted	\N	2354
2355	5	4709	4710	4709	4710	denver-broncos-new-york-giants	2024-05-04 12:20:00	18	finished	away	2355
2356	5	4711	4712	4711	4712	new-york-giants-denver-broncos	2024-12-07 17:20:00	49	notstarted	\N	2356
2357	5	4713	4714	4713	4714	pittsburgh-steelers-buffalo-bills	2024-05-04 11:30:00	18	finished	away	2357
2358	5	4715	4716	4715	4716	buffalo-bills-pittsburgh-steelers	2024-12-07 14:00:00	49	notstarted	\N	2358
2359	5	4717	4718	4717	4718	new-england-patriots-green-bay-packers	2024-05-04 15:00:00	18	finished	home	2359
2360	5	4719	4720	4719	4720	green-bay-packers-new-england-patriots	2024-12-07 14:50:00	49	notstarted	\N	2360
2361	5	4721	4722	4721	4722	arizona-cardinals-los-angeles-rams	2024-05-04 16:10:00	18	finished	home	2361
2362	5	4723	4724	4723	4724	los-angeles-rams-arizona-cardinals	2024-12-07 15:20:00	49	notstarted	\N	2362
2363	5	4725	4726	4725	4726	tennessee-titans-cleveland-browns	2024-05-04 19:30:00	18	finished	away	2363
2364	5	4727	4728	4727	4728	cleveland-browns-tennessee-titans	2024-12-07 13:40:00	49	notstarted	\N	2364
2365	5	4729	4730	4729	4730	miami-dolphins-cincinnati-bengals	2024-05-04 15:00:00	18	finished	home	2365
2366	5	4731	4732	4731	4732	cincinnati-bengals-miami-dolphins	2024-12-07 18:00:00	49	notstarted	\N	2366
2367	5	4733	4734	4733	4734	detroit-lions-kansas-city-chiefs	2024-05-04 18:20:00	18	finished	away	2367
2368	5	4735	4736	4735	4736	kansas-city-chiefs-detroit-lions	2024-12-07 15:10:00	49	notstarted	\N	2368
2369	5	4737	4738	4737	4738	indianapolis-colts-houston-texans	2024-05-04 16:10:00	18	finished	away	2369
2370	5	4739	4740	4739	4740	houston-texans-indianapolis-colts	2024-12-07 18:40:00	49	notstarted	\N	2370
2371	5	4741	4742	4741	4742	new-york-jets-baltimore-ravens	2024-05-05 11:50:00	18	finished	away	2371
2372	5	4743	4744	4743	4744	baltimore-ravens-new-york-jets	2024-12-08 11:40:00	49	notstarted	\N	2372
2373	5	4745	4746	4745	4746	jacksonville-jaguars-los-angeles-chargers	2024-05-05 14:10:00	18	finished	home	2373
2374	5	4747	4748	4747	4748	los-angeles-chargers-jacksonville-jaguars	2024-12-08 14:20:00	49	notstarted	\N	2374
2375	5	4749	4750	4749	4750	san-francisco-49ers-chicago-bears	2024-05-05 18:20:00	18	finished	home	2375
2376	5	4751	4752	4751	4752	chicago-bears-san-francisco-49ers	2024-12-08 14:00:00	49	notstarted	\N	2376
2377	5	4753	4754	4753	4754	dallas-cowboys-washington-commanders	2024-05-05 14:50:00	18	finished	away	2377
2378	5	4755	4756	4755	4756	washington-commanders-dallas-cowboys	2024-12-08 18:10:00	49	notstarted	\N	2378
2379	5	4757	4758	4757	4758	las-vegas-raiders-new-orleans-saints	2024-05-05 19:50:00	18	finished	draw	2379
2380	5	4759	4760	4759	4760	new-orleans-saints-las-vegas-raiders	2024-12-08 12:20:00	49	notstarted	\N	2380
2381	5	4761	4762	4761	4762	philadelphia-eagles-tampa-bay-buccaneers	2024-05-05 14:20:00	18	finished	away	2381
2382	5	4763	4764	4763	4764	tampa-bay-buccaneers-philadelphia-eagles	2024-12-08 17:30:00	49	notstarted	\N	2382
2383	5	4765	4766	4765	4766	atlanta-falcons-seattle-seahawks	2024-05-05 15:10:00	18	finished	away	2383
2384	5	4767	4768	4767	4768	seattle-seahawks-atlanta-falcons	2024-12-08 11:20:00	49	notstarted	\N	2384
2385	5	4769	4770	4769	4770	minnesota-vikings-carolina-panthers	2024-05-05 12:20:00	18	finished	draw	2385
2386	5	4771	4772	4771	4772	carolina-panthers-minnesota-vikings	2024-12-08 13:20:00	49	notstarted	\N	2386
2387	5	4773	4774	4773	4774	houston-texans-buffalo-bills	2024-05-11 15:40:00	19	finished	home	2387
2388	5	4775	4776	4775	4776	buffalo-bills-houston-texans	2024-12-14 11:00:00	50	notstarted	\N	2388
2389	5	4777	4778	4777	4778	green-bay-packers-jacksonville-jaguars	2024-05-11 18:10:00	19	finished	home	2389
2390	5	4779	4780	4779	4780	jacksonville-jaguars-green-bay-packers	2024-12-14 14:40:00	50	notstarted	\N	2390
2391	5	4781	4782	4781	4782	cincinnati-bengals-pittsburgh-steelers	2024-05-11 12:00:00	19	finished	home	2391
2392	5	4783	4784	4783	4784	pittsburgh-steelers-cincinnati-bengals	2024-12-14 13:30:00	50	notstarted	\N	2392
2393	5	4785	4786	4785	4786	atlanta-falcons-kansas-city-chiefs	2024-05-11 11:50:00	19	finished	home	2393
2394	5	4787	4788	4787	4788	kansas-city-chiefs-atlanta-falcons	2024-12-14 15:40:00	50	notstarted	\N	2394
2395	5	4789	4790	4789	4790	denver-broncos-washington-commanders	2024-05-11 11:20:00	19	finished	draw	2395
2396	5	4791	4792	4791	4792	washington-commanders-denver-broncos	2024-12-14 16:40:00	50	notstarted	\N	2396
2397	5	4793	4794	4793	4794	indianapolis-colts-tennessee-titans	2024-05-11 18:00:00	19	finished	home	2397
2398	5	4795	4796	4795	4796	tennessee-titans-indianapolis-colts	2024-12-14 14:40:00	50	notstarted	\N	2398
2399	5	4797	4798	4797	4798	arizona-cardinals-minnesota-vikings	2024-05-11 15:00:00	19	finished	away	2399
2400	5	4799	4800	4799	4800	minnesota-vikings-arizona-cardinals	2024-12-14 10:10:00	50	notstarted	\N	2400
2401	5	4801	4802	4801	4802	new-york-giants-chicago-bears	2024-05-11 12:30:00	19	finished	home	2401
2402	5	4803	4804	4803	4804	chicago-bears-new-york-giants	2024-12-14 15:00:00	50	notstarted	\N	2402
2403	5	4805	4806	4805	4806	los-angeles-rams-tampa-bay-buccaneers	2024-05-12 15:00:00	19	finished	home	2403
2404	5	4807	4808	4807	4808	tampa-bay-buccaneers-los-angeles-rams	2024-12-15 14:00:00	50	notstarted	\N	2404
2405	5	4809	4810	4809	4810	las-vegas-raiders-baltimore-ravens	2024-05-12 12:30:00	19	finished	home	2405
2406	5	4811	4812	4811	4812	baltimore-ravens-las-vegas-raiders	2024-12-15 14:20:00	50	notstarted	\N	2406
2407	5	4813	4814	4813	4814	philadelphia-eagles-san-francisco-49ers	2024-05-12 11:50:00	19	finished	home	2407
2408	5	4815	4816	4815	4816	san-francisco-49ers-philadelphia-eagles	2024-12-15 16:30:00	50	notstarted	\N	2408
2409	5	4817	4818	4817	4818	dallas-cowboys-carolina-panthers	2024-05-12 19:10:00	19	finished	home	2409
2410	5	4819	4820	4819	4820	carolina-panthers-dallas-cowboys	2024-12-15 14:40:00	50	notstarted	\N	2410
2411	5	4821	4822	4821	4822	seattle-seahawks-miami-dolphins	2024-05-12 17:40:00	19	finished	home	2411
2412	5	4823	4824	4823	4824	miami-dolphins-seattle-seahawks	2024-12-15 18:10:00	50	notstarted	\N	2412
2413	5	4825	4826	4825	4826	new-york-jets-detroit-lions	2024-05-12 19:00:00	19	finished	away	2413
2414	5	4827	4828	4827	4828	detroit-lions-new-york-jets	2024-12-15 13:20:00	50	notstarted	\N	2414
2415	5	4829	4830	4829	4830	new-england-patriots-cleveland-browns	2024-05-12 15:20:00	19	finished	away	2415
2416	5	4831	4832	4831	4832	cleveland-browns-new-england-patriots	2024-12-15 16:40:00	50	notstarted	\N	2416
2417	5	4833	4834	4833	4834	los-angeles-chargers-new-orleans-saints	2024-05-12 10:50:00	19	finished	home	2417
2418	5	4835	4836	4835	4836	new-orleans-saints-los-angeles-chargers	2024-12-15 12:00:00	50	notstarted	\N	2418
2419	5	4837	4838	4837	4838	baltimore-ravens-cleveland-browns	2024-05-18 10:10:00	20	finished	away	2419
2420	5	4839	4840	4839	4840	cleveland-browns-baltimore-ravens	2024-12-21 11:30:00	51	notstarted	\N	2420
2421	5	4841	4842	4841	4842	las-vegas-raiders-denver-broncos	2024-05-18 15:30:00	20	finished	home	2421
2422	5	4843	4844	4843	4844	denver-broncos-las-vegas-raiders	2024-12-21 11:30:00	51	notstarted	\N	2422
2423	5	4845	4846	4845	4846	tampa-bay-buccaneers-houston-texans	2024-05-18 17:20:00	20	finished	away	2423
2424	5	4847	4848	4847	4848	houston-texans-tampa-bay-buccaneers	2024-12-21 16:10:00	51	notstarted	\N	2424
2425	5	4849	4850	4849	4850	kansas-city-chiefs-arizona-cardinals	2024-05-18 11:50:00	20	finished	away	2425
2426	5	4851	4852	4851	4852	arizona-cardinals-kansas-city-chiefs	2024-12-21 11:50:00	51	notstarted	\N	2426
2427	5	4853	4854	4853	4854	minnesota-vikings-indianapolis-colts	2024-05-18 18:10:00	20	finished	away	2427
2428	5	4855	4856	4855	4856	indianapolis-colts-minnesota-vikings	2024-12-21 13:30:00	51	notstarted	\N	2428
2429	5	4857	4858	4857	4858	buffalo-bills-new-orleans-saints	2024-05-18 17:20:00	20	finished	away	2429
2430	5	4859	4860	4859	4860	new-orleans-saints-buffalo-bills	2024-12-21 15:30:00	51	notstarted	\N	2430
2431	5	4861	4862	4861	4862	new-england-patriots-san-francisco-49ers	2024-05-18 14:10:00	20	finished	draw	2431
2432	5	4863	4864	4863	4864	san-francisco-49ers-new-england-patriots	2024-12-21 12:50:00	51	notstarted	\N	2432
2433	5	4865	4866	4865	4866	new-york-jets-jacksonville-jaguars	2024-05-18 13:40:00	20	finished	home	2433
2434	5	4867	4868	4867	4868	jacksonville-jaguars-new-york-jets	2024-12-21 14:30:00	51	notstarted	\N	2434
2435	5	4869	4870	4869	4870	cincinnati-bengals-chicago-bears	2024-05-19 12:40:00	20	finished	home	2435
2436	5	4871	4872	4871	4872	chicago-bears-cincinnati-bengals	2024-12-22 17:50:00	51	notstarted	\N	2436
2437	5	4873	4874	4873	4874	pittsburgh-steelers-los-angeles-rams	2024-05-19 18:20:00	20	finished	draw	2437
2438	5	4875	4876	4875	4876	los-angeles-rams-pittsburgh-steelers	2024-12-22 18:20:00	51	notstarted	\N	2438
2439	5	4877	4878	4877	4878	dallas-cowboys-seattle-seahawks	2024-05-19 15:20:00	20	finished	home	2439
2440	5	4879	4880	4879	4880	seattle-seahawks-dallas-cowboys	2024-12-22 18:20:00	51	notstarted	\N	2440
2441	5	4881	4882	4881	4882	atlanta-falcons-new-york-giants	2024-05-19 14:50:00	20	finished	away	2441
2442	5	4883	4884	4883	4884	new-york-giants-atlanta-falcons	2024-12-22 18:00:00	51	notstarted	\N	2442
2443	5	4885	4886	4885	4886	los-angeles-chargers-green-bay-packers	2024-05-19 10:00:00	20	finished	away	2443
2444	5	4887	4888	4887	4888	green-bay-packers-los-angeles-chargers	2024-12-22 19:30:00	51	notstarted	\N	2444
2445	5	4889	4890	4889	4890	tennessee-titans-philadelphia-eagles	2024-05-19 19:30:00	20	finished	home	2445
2446	5	4891	4892	4891	4892	philadelphia-eagles-tennessee-titans	2024-12-22 13:00:00	51	notstarted	\N	2446
2447	5	4893	4894	4893	4894	carolina-panthers-washington-commanders	2024-05-19 19:00:00	20	finished	home	2447
2448	5	4895	4896	4895	4896	washington-commanders-carolina-panthers	2024-12-22 13:30:00	51	notstarted	\N	2448
2449	5	4897	4898	4897	4898	detroit-lions-miami-dolphins	2024-05-19 11:50:00	20	finished	home	2449
2450	5	4899	4900	4899	4900	miami-dolphins-detroit-lions	2024-12-22 10:00:00	51	notstarted	\N	2450
2451	5	4901	4902	4901	4902	san-francisco-49ers-buffalo-bills	2024-05-25 18:00:00	21	finished	home	2451
2452	5	4903	4904	4903	4904	buffalo-bills-san-francisco-49ers	2024-12-28 15:00:00	52	notstarted	\N	2452
2453	5	4905	4906	4905	4906	pittsburgh-steelers-new-york-giants	2024-05-25 10:00:00	21	finished	home	2453
2454	5	4907	4908	4907	4908	new-york-giants-pittsburgh-steelers	2024-12-28 17:10:00	52	notstarted	\N	2454
2455	5	4909	4910	4909	4910	philadelphia-eagles-chicago-bears	2024-05-25 12:30:00	21	finished	away	2455
2456	5	4911	4912	4911	4912	chicago-bears-philadelphia-eagles	2024-12-28 11:00:00	52	notstarted	\N	2456
2457	5	4913	4914	4913	4914	atlanta-falcons-indianapolis-colts	2024-05-25 14:10:00	21	finished	home	2457
2458	5	4915	4916	4915	4916	indianapolis-colts-atlanta-falcons	2024-12-28 14:40:00	52	notstarted	\N	2458
2459	5	4917	4918	4917	4918	miami-dolphins-cleveland-browns	2024-05-25 18:50:00	21	finished	home	2459
2460	5	4919	4920	4919	4920	cleveland-browns-miami-dolphins	2024-12-28 11:50:00	52	notstarted	\N	2460
2461	5	4921	4922	4921	4922	carolina-panthers-tampa-bay-buccaneers	2024-05-25 11:30:00	21	finished	away	2461
2462	5	4923	4924	4923	4924	tampa-bay-buccaneers-carolina-panthers	2024-12-28 18:20:00	52	notstarted	\N	2462
2463	5	4925	4926	4925	4926	dallas-cowboys-arizona-cardinals	2024-05-25 13:10:00	21	finished	away	2463
2464	5	4927	4928	4927	4928	arizona-cardinals-dallas-cowboys	2024-12-28 14:00:00	52	notstarted	\N	2464
2465	5	4929	4930	4929	4930	houston-texans-los-angeles-rams	2024-05-25 19:40:00	21	finished	draw	2465
2466	5	4931	4932	4931	4932	los-angeles-rams-houston-texans	2024-12-28 11:20:00	52	notstarted	\N	2466
2467	5	4933	4934	4933	4934	new-england-patriots-kansas-city-chiefs	2024-05-26 18:30:00	21	finished	home	2467
2468	5	4935	4936	4935	4936	kansas-city-chiefs-new-england-patriots	2024-12-29 13:50:00	52	notstarted	\N	2468
2469	5	4937	4938	4937	4938	green-bay-packers-cincinnati-bengals	2024-05-26 18:10:00	21	finished	away	2469
2470	5	4939	4940	4939	4940	cincinnati-bengals-green-bay-packers	2024-12-29 16:00:00	52	notstarted	\N	2470
2471	5	4941	4942	4941	4942	baltimore-ravens-washington-commanders	2024-05-26 14:20:00	21	finished	away	2471
2472	5	4943	4944	4943	4944	washington-commanders-baltimore-ravens	2024-12-29 18:40:00	52	notstarted	\N	2472
2473	5	4945	4946	4945	4946	minnesota-vikings-new-york-jets	2024-05-26 19:30:00	21	finished	draw	2473
2474	5	4947	4948	4947	4948	new-york-jets-minnesota-vikings	2024-12-29 14:30:00	52	notstarted	\N	2474
2475	5	4949	4950	4949	4950	jacksonville-jaguars-las-vegas-raiders	2024-05-26 13:00:00	21	finished	home	2475
2476	5	4951	4952	4951	4952	las-vegas-raiders-jacksonville-jaguars	2024-12-29 18:20:00	52	notstarted	\N	2476
2477	5	4953	4954	4953	4954	seattle-seahawks-detroit-lions	2024-05-26 12:20:00	21	finished	away	2477
2478	5	4955	4956	4955	4956	detroit-lions-seattle-seahawks	2024-12-29 13:40:00	52	notstarted	\N	2478
2479	5	4957	4958	4957	4958	los-angeles-chargers-denver-broncos	2024-05-26 11:50:00	21	finished	away	2479
2480	5	4959	4960	4959	4960	denver-broncos-los-angeles-chargers	2024-12-29 16:00:00	52	notstarted	\N	2480
2481	5	4961	4962	4961	4962	new-orleans-saints-tennessee-titans	2024-05-26 11:40:00	21	finished	home	2481
2482	5	4963	4964	4963	4964	tennessee-titans-new-orleans-saints	2024-12-29 13:20:00	52	notstarted	\N	2482
2483	5	4965	4966	4965	4966	baltimore-ravens-pittsburgh-steelers	2024-06-01 11:30:00	22	notstarted	\N	2483
2484	5	4967	4968	4967	4968	pittsburgh-steelers-baltimore-ravens	2025-01-04 15:00:00	53	notstarted	\N	2484
2485	5	4969	4970	4969	4970	jacksonville-jaguars-miami-dolphins	2024-06-01 13:10:00	22	notstarted	\N	2485
2486	5	4971	4972	4971	4972	miami-dolphins-jacksonville-jaguars	2025-01-04 12:10:00	53	notstarted	\N	2486
2487	5	4973	4974	4973	4974	tennessee-titans-detroit-lions	2024-06-01 11:30:00	22	notstarted	\N	2487
2488	5	4975	4976	4975	4976	detroit-lions-tennessee-titans	2025-01-04 11:40:00	53	notstarted	\N	2488
2489	5	4977	4978	4977	4978	kansas-city-chiefs-washington-commanders	2024-06-01 15:30:00	22	notstarted	\N	2489
2490	5	4979	4980	4979	4980	washington-commanders-kansas-city-chiefs	2025-01-04 14:30:00	53	notstarted	\N	2490
2491	5	4981	4982	4981	4982	houston-texans-los-angeles-chargers	2024-06-01 17:50:00	22	notstarted	\N	2491
2492	5	4983	4984	4983	4984	los-angeles-chargers-houston-texans	2025-01-04 12:30:00	53	notstarted	\N	2492
2493	5	4985	4986	4985	4986	minnesota-vikings-atlanta-falcons	2024-06-01 13:00:00	22	notstarted	\N	2493
2494	5	4987	4988	4987	4988	atlanta-falcons-minnesota-vikings	2025-01-04 14:20:00	53	notstarted	\N	2494
2495	5	4989	4990	4989	4990	new-york-jets-tampa-bay-buccaneers	2024-06-01 16:00:00	22	notstarted	\N	2495
2496	5	4991	4992	4991	4992	tampa-bay-buccaneers-new-york-jets	2025-01-04 14:20:00	53	notstarted	\N	2496
2497	5	4993	4994	4993	4994	san-francisco-49ers-new-orleans-saints	2024-06-01 19:30:00	22	notstarted	\N	2497
2498	5	4995	4996	4995	4996	new-orleans-saints-san-francisco-49ers	2025-01-04 12:20:00	53	notstarted	\N	2498
2499	5	4997	4998	4997	4998	seattle-seahawks-new-england-patriots	2024-06-02 10:30:00	22	notstarted	\N	2499
2500	5	4999	5000	4999	5000	new-england-patriots-seattle-seahawks	2025-01-05 10:40:00	53	notstarted	\N	2500
2501	5	5001	5002	5001	5002	los-angeles-rams-las-vegas-raiders	2024-06-02 18:20:00	22	notstarted	\N	2501
2502	5	5003	5004	5003	5004	las-vegas-raiders-los-angeles-rams	2025-01-05 10:20:00	53	notstarted	\N	2502
2503	5	5005	5006	5005	5006	cleveland-browns-new-york-giants	2024-06-02 17:10:00	22	notstarted	\N	2503
2504	5	5007	5008	5007	5008	new-york-giants-cleveland-browns	2025-01-05 14:10:00	53	notstarted	\N	2504
2505	5	5009	5010	5009	5010	cincinnati-bengals-philadelphia-eagles	2024-06-02 18:10:00	22	notstarted	\N	2505
2506	5	5011	5012	5011	5012	philadelphia-eagles-cincinnati-bengals	2025-01-05 15:00:00	53	notstarted	\N	2506
2507	5	5013	5014	5013	5014	buffalo-bills-chicago-bears	2024-06-02 16:20:00	22	notstarted	\N	2507
2508	5	5015	5016	5015	5016	chicago-bears-buffalo-bills	2025-01-05 18:50:00	53	notstarted	\N	2508
2509	5	5017	5018	5017	5018	dallas-cowboys-denver-broncos	2024-06-02 17:00:00	22	notstarted	\N	2509
2510	5	5019	5020	5019	5020	denver-broncos-dallas-cowboys	2025-01-05 14:50:00	53	notstarted	\N	2510
2511	5	5021	5022	5021	5022	green-bay-packers-arizona-cardinals	2024-06-02 16:30:00	22	notstarted	\N	2511
2512	5	5023	5024	5023	5024	arizona-cardinals-green-bay-packers	2025-01-05 13:20:00	53	notstarted	\N	2512
2513	5	5025	5026	5025	5026	indianapolis-colts-carolina-panthers	2024-06-02 18:40:00	22	notstarted	\N	2513
2514	5	5027	5028	5027	5028	carolina-panthers-indianapolis-colts	2025-01-05 12:00:00	53	notstarted	\N	2514
2515	5	5029	5030	5029	5030	new-orleans-saints-miami-dolphins	2024-06-08 18:50:00	23	notstarted	\N	2515
2516	5	5031	5032	5031	5032	miami-dolphins-new-orleans-saints	2025-01-11 19:50:00	54	notstarted	\N	2516
2517	5	5033	5034	5033	5034	pittsburgh-steelers-new-england-patriots	2024-06-08 12:20:00	23	notstarted	\N	2517
2518	5	5035	5036	5035	5036	new-england-patriots-pittsburgh-steelers	2025-01-11 16:10:00	54	notstarted	\N	2518
2519	5	5037	5038	5037	5038	las-vegas-raiders-seattle-seahawks	2024-06-08 17:40:00	23	notstarted	\N	2519
2520	5	5039	5040	5039	5040	seattle-seahawks-las-vegas-raiders	2025-01-11 13:00:00	54	notstarted	\N	2520
2521	5	5041	5042	5041	5042	los-angeles-rams-tennessee-titans	2024-06-08 18:20:00	23	notstarted	\N	2521
2522	5	5043	5044	5043	5044	tennessee-titans-los-angeles-rams	2025-01-11 16:30:00	54	notstarted	\N	2522
2523	5	5045	5046	5045	5046	arizona-cardinals-new-york-giants	2024-06-08 15:50:00	23	notstarted	\N	2523
2524	5	5047	5048	5047	5048	new-york-giants-arizona-cardinals	2025-01-11 17:20:00	54	notstarted	\N	2524
2525	5	5049	5050	5049	5050	indianapolis-colts-detroit-lions	2024-06-08 15:10:00	23	notstarted	\N	2525
2526	5	5051	5052	5051	5052	detroit-lions-indianapolis-colts	2025-01-11 18:00:00	54	notstarted	\N	2526
2527	5	5053	5054	5053	5054	dallas-cowboys-minnesota-vikings	2024-06-08 19:40:00	23	notstarted	\N	2527
2528	5	5055	5056	5055	5056	minnesota-vikings-dallas-cowboys	2025-01-11 13:40:00	54	notstarted	\N	2528
2529	5	5057	5058	5057	5058	philadelphia-eagles-baltimore-ravens	2024-06-08 15:40:00	23	notstarted	\N	2529
2530	5	5059	5060	5059	5060	baltimore-ravens-philadelphia-eagles	2025-01-11 17:10:00	54	notstarted	\N	2530
2531	5	5061	5062	5061	5062	cleveland-browns-cincinnati-bengals	2024-06-09 16:40:00	23	notstarted	\N	2531
2532	5	5063	5064	5063	5064	cincinnati-bengals-cleveland-browns	2025-01-12 14:20:00	54	notstarted	\N	2532
2533	5	5065	5066	5065	5066	jacksonville-jaguars-buffalo-bills	2024-06-09 16:20:00	23	notstarted	\N	2533
2534	5	5067	5068	5067	5068	buffalo-bills-jacksonville-jaguars	2025-01-12 13:00:00	54	notstarted	\N	2534
2535	5	5069	5070	5069	5070	washington-commanders-tampa-bay-buccaneers	2024-06-09 13:50:00	23	notstarted	\N	2535
2536	5	5071	5072	5071	5072	tampa-bay-buccaneers-washington-commanders	2025-01-12 13:40:00	54	notstarted	\N	2536
2537	5	5073	5074	5073	5074	san-francisco-49ers-denver-broncos	2024-06-09 16:20:00	23	notstarted	\N	2537
2538	5	5075	5076	5075	5076	denver-broncos-san-francisco-49ers	2025-01-12 16:20:00	54	notstarted	\N	2538
2539	5	5077	5078	5077	5078	chicago-bears-kansas-city-chiefs	2024-06-09 15:30:00	23	notstarted	\N	2539
2540	5	5079	5080	5079	5080	kansas-city-chiefs-chicago-bears	2025-01-12 17:30:00	54	notstarted	\N	2540
2541	5	5081	5082	5081	5082	carolina-panthers-houston-texans	2024-06-09 14:20:00	23	notstarted	\N	2541
2542	5	5083	5084	5083	5084	houston-texans-carolina-panthers	2025-01-12 14:10:00	54	notstarted	\N	2542
2543	5	5085	5086	5085	5086	atlanta-falcons-los-angeles-chargers	2024-06-09 10:50:00	23	notstarted	\N	2543
2544	5	5087	5088	5087	5088	los-angeles-chargers-atlanta-falcons	2025-01-12 14:10:00	54	notstarted	\N	2544
2545	5	5089	5090	5089	5090	new-york-jets-green-bay-packers	2024-06-09 19:20:00	23	notstarted	\N	2545
2546	5	5091	5092	5091	5092	green-bay-packers-new-york-jets	2025-01-12 17:50:00	54	notstarted	\N	2546
2547	5	5093	5094	5093	5094	las-vegas-raiders-pittsburgh-steelers	2024-06-15 19:50:00	24	notstarted	\N	2547
2548	5	5095	5096	5095	5096	pittsburgh-steelers-las-vegas-raiders	2025-01-18 12:20:00	55	notstarted	\N	2548
2549	5	5097	5098	5097	5098	indianapolis-colts-dallas-cowboys	2024-06-15 14:40:00	24	notstarted	\N	2549
2550	5	5099	5100	5099	5100	dallas-cowboys-indianapolis-colts	2025-01-18 16:40:00	55	notstarted	\N	2550
2551	5	5101	5102	5101	5102	jacksonville-jaguars-minnesota-vikings	2024-06-15 15:20:00	24	notstarted	\N	2551
2552	5	5103	5104	5103	5104	minnesota-vikings-jacksonville-jaguars	2025-01-18 12:20:00	55	notstarted	\N	2552
2553	5	5105	5106	5105	5106	philadelphia-eagles-cleveland-browns	2024-06-15 15:10:00	24	notstarted	\N	2553
2554	5	5107	5108	5107	5108	cleveland-browns-philadelphia-eagles	2025-01-18 10:20:00	55	notstarted	\N	2554
2555	5	5109	5110	5109	5110	los-angeles-rams-kansas-city-chiefs	2024-06-15 13:30:00	24	notstarted	\N	2555
2556	5	5111	5112	5111	5112	kansas-city-chiefs-los-angeles-rams	2025-01-18 18:30:00	55	notstarted	\N	2556
2557	5	5113	5114	5113	5114	san-francisco-49ers-houston-texans	2024-06-15 12:20:00	24	notstarted	\N	2557
2558	5	5115	5116	5115	5116	houston-texans-san-francisco-49ers	2025-01-18 17:10:00	55	notstarted	\N	2558
2559	5	5117	5118	5117	5118	miami-dolphins-atlanta-falcons	2024-06-15 11:00:00	24	notstarted	\N	2559
2560	5	5119	5120	5119	5120	atlanta-falcons-miami-dolphins	2025-01-18 11:50:00	55	notstarted	\N	2560
2561	5	5121	5122	5121	5122	chicago-bears-new-england-patriots	2024-06-15 19:00:00	24	notstarted	\N	2561
2562	5	5123	5124	5123	5124	new-england-patriots-chicago-bears	2025-01-18 13:40:00	55	notstarted	\N	2562
2563	5	5125	5126	5125	5126	detroit-lions-los-angeles-chargers	2024-06-16 18:10:00	24	notstarted	\N	2563
2564	5	5127	5128	5127	5128	los-angeles-chargers-detroit-lions	2025-01-19 18:50:00	55	notstarted	\N	2564
2565	5	5129	5130	5129	5130	carolina-panthers-new-orleans-saints	2024-06-16 14:30:00	24	notstarted	\N	2565
2566	5	5131	5132	5131	5132	new-orleans-saints-carolina-panthers	2025-01-19 17:00:00	55	notstarted	\N	2566
2567	5	5133	5134	5133	5134	seattle-seahawks-green-bay-packers	2024-06-16 15:40:00	24	notstarted	\N	2567
2568	5	5135	5136	5135	5136	green-bay-packers-seattle-seahawks	2025-01-19 12:40:00	55	notstarted	\N	2568
2569	5	5137	5138	5137	5138	new-york-jets-washington-commanders	2024-06-16 12:00:00	24	notstarted	\N	2569
2570	5	5139	5140	5139	5140	washington-commanders-new-york-jets	2025-01-19 18:30:00	55	notstarted	\N	2570
2571	5	5141	5142	5141	5142	buffalo-bills-baltimore-ravens	2024-06-16 17:40:00	24	notstarted	\N	2571
2572	5	5143	5144	5143	5144	baltimore-ravens-buffalo-bills	2025-01-19 15:50:00	55	notstarted	\N	2572
2573	5	5145	5146	5145	5146	denver-broncos-tampa-bay-buccaneers	2024-06-16 17:20:00	24	notstarted	\N	2573
2574	5	5147	5148	5147	5148	tampa-bay-buccaneers-denver-broncos	2025-01-19 19:10:00	55	notstarted	\N	2574
2575	5	5149	5150	5149	5150	new-york-giants-cincinnati-bengals	2024-06-16 14:20:00	24	notstarted	\N	2575
2576	5	5151	5152	5151	5152	cincinnati-bengals-new-york-giants	2025-01-19 19:40:00	55	notstarted	\N	2576
2577	5	5153	5154	5153	5154	arizona-cardinals-tennessee-titans	2024-06-16 11:20:00	24	notstarted	\N	2577
2578	5	5155	5156	5155	5156	tennessee-titans-arizona-cardinals	2025-01-19 11:20:00	55	notstarted	\N	2578
2579	5	5157	5158	5157	5158	buffalo-bills-tennessee-titans	2024-06-22 15:10:00	25	notstarted	\N	2579
2580	5	5159	5160	5159	5160	tennessee-titans-buffalo-bills	2025-01-25 10:00:00	56	notstarted	\N	2580
2581	5	5161	5162	5161	5162	kansas-city-chiefs-miami-dolphins	2024-06-22 17:50:00	25	notstarted	\N	2581
2582	5	5163	5164	5163	5164	miami-dolphins-kansas-city-chiefs	2025-01-25 16:40:00	56	notstarted	\N	2582
2583	5	5165	5166	5165	5166	houston-texans-philadelphia-eagles	2024-06-22 12:40:00	25	notstarted	\N	2583
2584	5	5167	5168	5167	5168	philadelphia-eagles-houston-texans	2025-01-25 16:40:00	56	notstarted	\N	2584
2585	5	5169	5170	5169	5170	new-york-giants-las-vegas-raiders	2024-06-22 19:40:00	25	notstarted	\N	2585
2586	5	5171	5172	5171	5172	las-vegas-raiders-new-york-giants	2025-01-25 19:30:00	56	notstarted	\N	2586
2587	5	5173	5174	5173	5174	denver-broncos-minnesota-vikings	2024-06-22 15:20:00	25	notstarted	\N	2587
2588	5	5175	5176	5175	5176	minnesota-vikings-denver-broncos	2025-01-25 14:50:00	56	notstarted	\N	2588
2589	5	5177	5178	5177	5178	green-bay-packers-indianapolis-colts	2024-06-22 11:20:00	25	notstarted	\N	2589
2590	5	5179	5180	5179	5180	indianapolis-colts-green-bay-packers	2025-01-25 16:50:00	56	notstarted	\N	2590
2591	5	5181	5182	5181	5182	carolina-panthers-new-england-patriots	2024-06-22 17:10:00	25	notstarted	\N	2591
2592	5	5183	5184	5183	5184	new-england-patriots-carolina-panthers	2025-01-25 13:10:00	56	notstarted	\N	2592
2593	5	5185	5186	5185	5186	cincinnati-bengals-tampa-bay-buccaneers	2024-06-22 17:20:00	25	notstarted	\N	2593
2594	5	5187	5188	5187	5188	tampa-bay-buccaneers-cincinnati-bengals	2025-01-25 19:10:00	56	notstarted	\N	2594
2595	5	5189	5190	5189	5190	new-orleans-saints-washington-commanders	2024-06-23 11:50:00	25	notstarted	\N	2595
2596	5	5191	5192	5191	5192	washington-commanders-new-orleans-saints	2025-01-26 13:00:00	56	notstarted	\N	2596
2597	5	5193	5194	5193	5194	arizona-cardinals-pittsburgh-steelers	2024-06-23 19:40:00	25	notstarted	\N	2597
2598	5	5195	5196	5195	5196	pittsburgh-steelers-arizona-cardinals	2025-01-26 19:40:00	56	notstarted	\N	2598
2599	5	5197	5198	5197	5198	chicago-bears-baltimore-ravens	2024-06-23 17:00:00	25	notstarted	\N	2599
2600	5	5199	5200	5199	5200	baltimore-ravens-chicago-bears	2025-01-26 10:40:00	56	notstarted	\N	2600
2601	5	5201	5202	5201	5202	san-francisco-49ers-jacksonville-jaguars	2024-06-23 19:40:00	25	notstarted	\N	2601
2602	5	5203	5204	5203	5204	jacksonville-jaguars-san-francisco-49ers	2025-01-26 18:20:00	56	notstarted	\N	2602
2603	5	5205	5206	5205	5206	los-angeles-rams-dallas-cowboys	2024-06-23 10:00:00	25	notstarted	\N	2603
2604	5	5207	5208	5207	5208	dallas-cowboys-los-angeles-rams	2025-01-26 12:20:00	56	notstarted	\N	2604
2605	5	5209	5210	5209	5210	detroit-lions-atlanta-falcons	2024-06-23 12:40:00	25	notstarted	\N	2605
2606	5	5211	5212	5211	5212	atlanta-falcons-detroit-lions	2025-01-26 12:00:00	56	notstarted	\N	2606
2607	5	5213	5214	5213	5214	seattle-seahawks-cleveland-browns	2024-06-23 18:10:00	25	notstarted	\N	2607
2608	5	5215	5216	5215	5216	cleveland-browns-seattle-seahawks	2025-01-26 19:20:00	56	notstarted	\N	2608
2609	5	5217	5218	5217	5218	new-york-jets-los-angeles-chargers	2024-06-23 14:30:00	25	notstarted	\N	2609
2610	5	5219	5220	5219	5220	los-angeles-chargers-new-york-jets	2025-01-26 13:40:00	56	notstarted	\N	2610
2611	5	5221	5222	5221	5222	denver-broncos-carolina-panthers	2024-06-29 11:30:00	26	notstarted	\N	2611
2612	5	5223	5224	5223	5224	carolina-panthers-denver-broncos	2025-02-01 11:30:00	57	notstarted	\N	2612
2613	5	5225	5226	5225	5226	philadelphia-eagles-los-angeles-rams	2024-06-29 11:40:00	26	notstarted	\N	2613
2614	5	5227	5228	5227	5228	los-angeles-rams-philadelphia-eagles	2025-02-01 17:30:00	57	notstarted	\N	2614
2615	5	5229	5230	5229	5230	new-orleans-saints-indianapolis-colts	2024-06-29 17:10:00	26	notstarted	\N	2615
2616	5	5231	5232	5231	5232	indianapolis-colts-new-orleans-saints	2025-02-01 11:20:00	57	notstarted	\N	2616
2617	5	5233	5234	5233	5234	san-francisco-49ers-baltimore-ravens	2024-06-29 15:20:00	26	notstarted	\N	2617
2618	5	5235	5236	5235	5236	baltimore-ravens-san-francisco-49ers	2025-02-01 14:00:00	57	notstarted	\N	2618
2619	5	5237	5238	5237	5238	atlanta-falcons-las-vegas-raiders	2024-06-29 10:40:00	26	notstarted	\N	2619
2620	5	5239	5240	5239	5240	las-vegas-raiders-atlanta-falcons	2025-02-01 10:00:00	57	notstarted	\N	2620
2621	5	5241	5242	5241	5242	green-bay-packers-buffalo-bills	2024-06-29 15:50:00	26	notstarted	\N	2621
2622	5	5243	5244	5243	5244	buffalo-bills-green-bay-packers	2025-02-01 12:10:00	57	notstarted	\N	2622
2623	5	5245	5246	5245	5246	tampa-bay-buccaneers-cleveland-browns	2024-06-29 18:20:00	26	notstarted	\N	2623
2624	5	5247	5248	5247	5248	cleveland-browns-tampa-bay-buccaneers	2025-02-01 17:30:00	57	notstarted	\N	2624
2625	5	5249	5250	5249	5250	minnesota-vikings-chicago-bears	2024-06-29 19:10:00	26	notstarted	\N	2625
2626	5	5251	5252	5251	5252	chicago-bears-minnesota-vikings	2025-02-01 16:20:00	57	notstarted	\N	2626
2627	5	5253	5254	5253	5254	detroit-lions-new-england-patriots	2024-06-30 11:30:00	26	notstarted	\N	2627
2628	5	5255	5256	5255	5256	new-england-patriots-detroit-lions	2025-02-02 10:10:00	57	notstarted	\N	2628
2629	5	5257	5258	5257	5258	tennessee-titans-new-york-giants	2024-06-30 15:30:00	26	notstarted	\N	2629
2630	5	5259	5260	5259	5260	new-york-giants-tennessee-titans	2025-02-02 14:30:00	57	notstarted	\N	2630
2631	5	5261	5262	5261	5262	arizona-cardinals-washington-commanders	2024-06-30 11:30:00	26	notstarted	\N	2631
2632	5	5263	5264	5263	5264	washington-commanders-arizona-cardinals	2025-02-02 15:40:00	57	notstarted	\N	2632
2633	5	5265	5266	5265	5266	dallas-cowboys-jacksonville-jaguars	2024-06-30 14:30:00	26	notstarted	\N	2633
2634	5	5267	5268	5267	5268	jacksonville-jaguars-dallas-cowboys	2025-02-02 16:00:00	57	notstarted	\N	2634
2635	5	5269	5270	5269	5270	houston-texans-miami-dolphins	2024-06-30 11:40:00	26	notstarted	\N	2635
2636	5	5271	5272	5271	5272	miami-dolphins-houston-texans	2025-02-02 17:50:00	57	notstarted	\N	2636
2637	5	5273	5274	5273	5274	seattle-seahawks-kansas-city-chiefs	2024-06-30 16:20:00	26	notstarted	\N	2637
2638	5	5275	5276	5275	5276	kansas-city-chiefs-seattle-seahawks	2025-02-02 19:40:00	57	notstarted	\N	2638
2639	5	5277	5278	5277	5278	pittsburgh-steelers-los-angeles-chargers	2024-06-30 10:50:00	26	notstarted	\N	2639
2640	5	5279	5280	5279	5280	los-angeles-chargers-pittsburgh-steelers	2025-02-02 11:20:00	57	notstarted	\N	2640
2641	5	5281	5282	5281	5282	new-york-jets-cincinnati-bengals	2024-06-30 10:00:00	26	notstarted	\N	2641
2642	5	5283	5284	5283	5284	cincinnati-bengals-new-york-jets	2025-02-02 18:40:00	57	notstarted	\N	2642
2643	5	5285	5286	5285	5286	kansas-city-chiefs-new-york-giants	2024-07-06 17:10:00	27	notstarted	\N	2643
2644	5	5287	5288	5287	5288	new-york-giants-kansas-city-chiefs	2025-02-08 14:10:00	58	notstarted	\N	2644
2645	5	5289	5290	5289	5290	baltimore-ravens-los-angeles-rams	2024-07-06 15:00:00	27	notstarted	\N	2645
2646	5	5291	5292	5291	5292	los-angeles-rams-baltimore-ravens	2025-02-08 13:20:00	58	notstarted	\N	2646
2647	5	5293	5294	5293	5294	new-orleans-saints-denver-broncos	2024-07-06 17:50:00	27	notstarted	\N	2647
2648	5	5295	5296	5295	5296	denver-broncos-new-orleans-saints	2025-02-08 10:30:00	58	notstarted	\N	2648
2649	5	5297	5298	5297	5298	miami-dolphins-pittsburgh-steelers	2024-07-06 18:00:00	27	notstarted	\N	2649
2650	5	5299	5300	5299	5300	pittsburgh-steelers-miami-dolphins	2025-02-08 11:30:00	58	notstarted	\N	2650
2651	5	5301	5302	5301	5302	atlanta-falcons-new-england-patriots	2024-07-06 14:50:00	27	notstarted	\N	2651
2652	5	5303	5304	5303	5304	new-england-patriots-atlanta-falcons	2025-02-08 17:10:00	58	notstarted	\N	2652
2653	5	5305	5306	5305	5306	indianapolis-colts-jacksonville-jaguars	2024-07-06 15:10:00	27	notstarted	\N	2653
2654	5	5307	5308	5307	5308	jacksonville-jaguars-indianapolis-colts	2025-02-08 14:00:00	58	notstarted	\N	2654
2655	5	5309	5310	5309	5310	philadelphia-eagles-green-bay-packers	2024-07-06 14:50:00	27	notstarted	\N	2655
2656	5	5311	5312	5311	5312	green-bay-packers-philadelphia-eagles	2025-02-08 17:30:00	58	notstarted	\N	2656
2657	5	5313	5314	5313	5314	dallas-cowboys-cincinnati-bengals	2024-07-06 19:20:00	27	notstarted	\N	2657
2658	5	5315	5316	5315	5316	cincinnati-bengals-dallas-cowboys	2025-02-08 15:10:00	58	notstarted	\N	2658
2659	5	5317	5318	5317	5318	los-angeles-chargers-washington-commanders	2024-07-07 19:00:00	27	notstarted	\N	2659
2660	5	5319	5320	5319	5320	washington-commanders-los-angeles-chargers	2025-02-09 11:50:00	58	notstarted	\N	2660
2661	5	5321	5322	5321	5322	tampa-bay-buccaneers-chicago-bears	2024-07-07 12:10:00	27	notstarted	\N	2661
2662	5	5323	5324	5323	5324	chicago-bears-tampa-bay-buccaneers	2025-02-09 12:30:00	58	notstarted	\N	2662
2663	5	5325	5326	5325	5326	san-francisco-49ers-carolina-panthers	2024-07-07 13:00:00	27	notstarted	\N	2663
2664	5	5327	5328	5327	5328	carolina-panthers-san-francisco-49ers	2025-02-09 11:40:00	58	notstarted	\N	2664
2665	5	5329	5330	5329	5330	seattle-seahawks-arizona-cardinals	2024-07-07 15:30:00	27	notstarted	\N	2665
2666	5	5331	5332	5331	5332	arizona-cardinals-seattle-seahawks	2025-02-09 14:00:00	58	notstarted	\N	2666
2667	5	5333	5334	5333	5334	cleveland-browns-detroit-lions	2024-07-07 15:40:00	27	notstarted	\N	2667
2668	5	5335	5336	5335	5336	detroit-lions-cleveland-browns	2025-02-09 17:30:00	58	notstarted	\N	2668
2669	5	5337	5338	5337	5338	buffalo-bills-las-vegas-raiders	2024-07-07 16:40:00	27	notstarted	\N	2669
2670	5	5339	5340	5339	5340	las-vegas-raiders-buffalo-bills	2025-02-09 19:30:00	58	notstarted	\N	2670
2671	5	5341	5342	5341	5342	new-york-jets-houston-texans	2024-07-07 13:40:00	27	notstarted	\N	2671
2672	5	5343	5344	5343	5344	houston-texans-new-york-jets	2025-02-09 15:30:00	58	notstarted	\N	2672
2673	5	5345	5346	5345	5346	tennessee-titans-minnesota-vikings	2024-07-07 18:40:00	27	notstarted	\N	2673
2674	5	5347	5348	5347	5348	minnesota-vikings-tennessee-titans	2025-02-09 11:50:00	58	notstarted	\N	2674
2675	5	5349	5350	5349	5350	tampa-bay-buccaneers-new-england-patriots	2024-07-13 15:20:00	28	notstarted	\N	2675
2676	5	5351	5352	5351	5352	new-england-patriots-tampa-bay-buccaneers	2025-02-15 13:30:00	59	notstarted	\N	2676
2677	5	5353	5354	5353	5354	baltimore-ravens-houston-texans	2024-07-13 16:20:00	28	notstarted	\N	2677
2678	5	5355	5356	5355	5356	houston-texans-baltimore-ravens	2025-02-15 16:20:00	59	notstarted	\N	2678
2679	5	5357	5358	5357	5358	atlanta-falcons-los-angeles-rams	2024-07-13 12:00:00	28	notstarted	\N	2679
2680	5	5359	5360	5359	5360	los-angeles-rams-atlanta-falcons	2025-02-15 13:40:00	59	notstarted	\N	2680
2681	5	5361	5362	5361	5362	los-angeles-chargers-cleveland-browns	2024-07-13 10:10:00	28	notstarted	\N	2681
2682	5	5363	5364	5363	5364	cleveland-browns-los-angeles-chargers	2025-02-15 17:40:00	59	notstarted	\N	2682
2683	5	5365	5366	5365	5366	seattle-seahawks-tennessee-titans	2024-07-13 16:50:00	28	notstarted	\N	2683
2684	5	5367	5368	5367	5368	tennessee-titans-seattle-seahawks	2025-02-15 12:10:00	59	notstarted	\N	2684
2685	5	5369	5370	5369	5370	minnesota-vikings-cincinnati-bengals	2024-07-13 14:10:00	28	notstarted	\N	2685
2686	5	5371	5372	5371	5372	cincinnati-bengals-minnesota-vikings	2025-02-15 10:20:00	59	notstarted	\N	2686
2687	5	5373	5374	5373	5374	new-york-giants-carolina-panthers	2024-07-13 14:20:00	28	notstarted	\N	2687
2688	5	5375	5376	5375	5376	carolina-panthers-new-york-giants	2025-02-15 18:20:00	59	notstarted	\N	2688
2689	5	5377	5378	5377	5378	pittsburgh-steelers-san-francisco-49ers	2024-07-13 11:10:00	28	notstarted	\N	2689
2690	5	5379	5380	5379	5380	san-francisco-49ers-pittsburgh-steelers	2025-02-15 11:30:00	59	notstarted	\N	2690
2691	5	5381	5382	5381	5382	chicago-bears-jacksonville-jaguars	2024-07-14 12:10:00	28	notstarted	\N	2691
2692	5	5383	5384	5383	5384	jacksonville-jaguars-chicago-bears	2025-02-16 19:50:00	59	notstarted	\N	2692
2693	5	5385	5386	5385	5386	indianapolis-colts-arizona-cardinals	2024-07-14 18:30:00	28	notstarted	\N	2693
2694	5	5387	5388	5387	5388	arizona-cardinals-indianapolis-colts	2025-02-16 16:50:00	59	notstarted	\N	2694
2695	5	5389	5390	5389	5390	washington-commanders-buffalo-bills	2024-07-14 15:00:00	28	notstarted	\N	2695
2696	5	5391	5392	5391	5392	buffalo-bills-washington-commanders	2025-02-16 19:10:00	59	notstarted	\N	2696
2697	5	5393	5394	5393	5394	las-vegas-raiders-green-bay-packers	2024-07-14 15:00:00	28	notstarted	\N	2697
2698	5	5395	5396	5395	5396	green-bay-packers-las-vegas-raiders	2025-02-16 18:10:00	59	notstarted	\N	2698
2699	5	5397	5398	5397	5398	dallas-cowboys-kansas-city-chiefs	2024-07-14 12:50:00	28	notstarted	\N	2699
2700	5	5399	5400	5399	5400	kansas-city-chiefs-dallas-cowboys	2025-02-16 12:10:00	59	notstarted	\N	2700
2701	5	5401	5402	5401	5402	new-orleans-saints-detroit-lions	2024-07-14 13:30:00	28	notstarted	\N	2701
2702	5	5403	5404	5403	5404	detroit-lions-new-orleans-saints	2025-02-16 16:10:00	59	notstarted	\N	2702
2703	5	5405	5406	5405	5406	new-york-jets-miami-dolphins	2024-07-14 16:30:00	28	notstarted	\N	2703
2704	5	5407	5408	5407	5408	miami-dolphins-new-york-jets	2025-02-16 19:50:00	59	notstarted	\N	2704
2705	5	5409	5410	5409	5410	philadelphia-eagles-denver-broncos	2024-07-14 14:00:00	28	notstarted	\N	2705
2706	5	5411	5412	5411	5412	denver-broncos-philadelphia-eagles	2025-02-16 14:40:00	59	notstarted	\N	2706
2707	5	5413	5414	5413	5414	tampa-bay-buccaneers-jacksonville-jaguars	2024-07-20 10:30:00	29	notstarted	\N	2707
2708	5	5415	5416	5415	5416	jacksonville-jaguars-tampa-bay-buccaneers	2025-02-22 11:20:00	60	notstarted	\N	2708
2709	5	5417	5418	5417	5418	las-vegas-raiders-cincinnati-bengals	2024-07-20 17:50:00	29	notstarted	\N	2709
2710	5	5419	5420	5419	5420	cincinnati-bengals-las-vegas-raiders	2025-02-22 16:00:00	60	notstarted	\N	2710
2711	5	5421	5422	5421	5422	carolina-panthers-pittsburgh-steelers	2024-07-20 11:50:00	29	notstarted	\N	2711
2712	5	5423	5424	5423	5424	pittsburgh-steelers-carolina-panthers	2025-02-22 15:20:00	60	notstarted	\N	2712
2713	5	5425	5426	5425	5426	miami-dolphins-san-francisco-49ers	2024-07-20 17:40:00	29	notstarted	\N	2713
2714	5	5427	5428	5427	5428	san-francisco-49ers-miami-dolphins	2025-02-22 19:40:00	60	notstarted	\N	2714
2715	5	5429	5430	5429	5430	washington-commanders-seattle-seahawks	2024-07-20 19:00:00	29	notstarted	\N	2715
2716	5	5431	5432	5431	5432	seattle-seahawks-washington-commanders	2025-02-22 12:20:00	60	notstarted	\N	2716
2717	5	5433	5434	5433	5434	buffalo-bills-detroit-lions	2024-07-20 16:20:00	29	notstarted	\N	2717
2718	5	5435	5436	5435	5436	detroit-lions-buffalo-bills	2025-02-22 17:00:00	60	notstarted	\N	2718
2719	5	5437	5438	5437	5438	philadelphia-eagles-atlanta-falcons	2024-07-20 13:10:00	29	notstarted	\N	2719
2720	5	5439	5440	5439	5440	atlanta-falcons-philadelphia-eagles	2025-02-22 17:30:00	60	notstarted	\N	2720
2721	5	5441	5442	5441	5442	los-angeles-rams-indianapolis-colts	2024-07-20 15:20:00	29	notstarted	\N	2721
2722	5	5443	5444	5443	5444	indianapolis-colts-los-angeles-rams	2025-02-22 16:40:00	60	notstarted	\N	2722
2723	5	5445	5446	5445	5446	minnesota-vikings-los-angeles-chargers	2024-07-21 15:40:00	29	notstarted	\N	2723
2724	5	5447	5448	5447	5448	los-angeles-chargers-minnesota-vikings	2025-02-23 13:50:00	60	notstarted	\N	2724
2725	5	5449	5450	5449	5450	green-bay-packers-baltimore-ravens	2024-07-21 10:50:00	29	notstarted	\N	2725
2726	5	5451	5452	5451	5452	baltimore-ravens-green-bay-packers	2025-02-23 13:20:00	60	notstarted	\N	2726
2727	5	5453	5454	5453	5454	new-york-giants-new-orleans-saints	2024-07-21 11:20:00	29	notstarted	\N	2727
2728	5	5455	5456	5455	5456	new-orleans-saints-new-york-giants	2025-02-23 14:00:00	60	notstarted	\N	2728
2729	5	5457	5458	5457	5458	new-england-patriots-arizona-cardinals	2024-07-21 12:30:00	29	notstarted	\N	2729
2730	5	5459	5460	5459	5460	arizona-cardinals-new-england-patriots	2025-02-23 11:00:00	60	notstarted	\N	2730
2731	5	5461	5462	5461	5462	tennessee-titans-chicago-bears	2024-07-21 15:10:00	29	notstarted	\N	2731
2732	5	5463	5464	5463	5464	chicago-bears-tennessee-titans	2025-02-23 12:10:00	60	notstarted	\N	2732
2733	5	5465	5466	5465	5466	cleveland-browns-dallas-cowboys	2024-07-21 10:50:00	29	notstarted	\N	2733
2734	5	5467	5468	5467	5468	dallas-cowboys-cleveland-browns	2025-02-23 17:20:00	60	notstarted	\N	2734
2735	5	5469	5470	5469	5470	denver-broncos-houston-texans	2024-07-21 10:40:00	29	notstarted	\N	2735
2736	5	5471	5472	5471	5472	houston-texans-denver-broncos	2025-02-23 18:10:00	60	notstarted	\N	2736
2737	5	5473	5474	5473	5474	new-york-jets-kansas-city-chiefs	2024-07-21 19:40:00	29	notstarted	\N	2737
2738	5	5475	5476	5475	5476	kansas-city-chiefs-new-york-jets	2025-02-23 18:40:00	60	notstarted	\N	2738
2739	5	5477	5478	5477	5478	new-orleans-saints-arizona-cardinals	2024-07-27 12:00:00	30	notstarted	\N	2739
2740	5	5479	5480	5479	5480	arizona-cardinals-new-orleans-saints	2025-03-01 18:40:00	61	notstarted	\N	2740
2741	5	5481	5482	5481	5482	new-york-jets-san-francisco-49ers	2024-07-27 19:10:00	30	notstarted	\N	2741
2742	5	5483	5484	5483	5484	san-francisco-49ers-new-york-jets	2025-03-01 11:50:00	61	notstarted	\N	2742
2743	5	5485	5486	5485	5486	los-angeles-chargers-new-england-patriots	2024-07-27 17:40:00	30	notstarted	\N	2743
2744	5	5487	5488	5487	5488	new-england-patriots-los-angeles-chargers	2025-03-01 19:00:00	61	notstarted	\N	2744
2745	5	5489	5490	5489	5490	cleveland-browns-indianapolis-colts	2024-07-27 18:40:00	30	notstarted	\N	2745
2746	5	5491	5492	5491	5492	indianapolis-colts-cleveland-browns	2025-03-01 12:30:00	61	notstarted	\N	2746
2747	5	5493	5494	5493	5494	kansas-city-chiefs-tennessee-titans	2024-07-27 16:00:00	30	notstarted	\N	2747
2748	5	5495	5496	5495	5496	tennessee-titans-kansas-city-chiefs	2025-03-01 18:30:00	61	notstarted	\N	2748
2749	5	5497	5498	5497	5498	washington-commanders-las-vegas-raiders	2024-07-27 16:40:00	30	notstarted	\N	2749
2750	5	5499	5500	5499	5500	las-vegas-raiders-washington-commanders	2025-03-01 14:40:00	61	notstarted	\N	2750
2751	5	5501	5502	5501	5502	carolina-panthers-chicago-bears	2024-07-27 14:20:00	30	notstarted	\N	2751
2752	5	5503	5504	5503	5504	chicago-bears-carolina-panthers	2025-03-01 10:10:00	61	notstarted	\N	2752
2753	5	5505	5506	5505	5506	baltimore-ravens-cincinnati-bengals	2024-07-27 13:50:00	30	notstarted	\N	2753
2754	5	5507	5508	5507	5508	cincinnati-bengals-baltimore-ravens	2025-03-01 12:50:00	61	notstarted	\N	2754
2755	5	5509	5510	5509	5510	denver-broncos-atlanta-falcons	2024-07-28 15:20:00	30	notstarted	\N	2755
2756	5	5511	5512	5511	5512	atlanta-falcons-denver-broncos	2025-03-02 10:00:00	61	notstarted	\N	2756
2757	5	5513	5514	5513	5514	tampa-bay-buccaneers-pittsburgh-steelers	2024-07-28 10:00:00	30	notstarted	\N	2757
2758	5	5515	5516	5515	5516	pittsburgh-steelers-tampa-bay-buccaneers	2025-03-02 17:20:00	61	notstarted	\N	2758
2759	5	5517	5518	5517	5518	jacksonville-jaguars-los-angeles-rams	2024-07-28 10:20:00	30	notstarted	\N	2759
2760	5	5519	5520	5519	5520	los-angeles-rams-jacksonville-jaguars	2025-03-02 17:20:00	61	notstarted	\N	2760
2761	5	5521	5522	5521	5522	new-york-giants-houston-texans	2024-07-28 17:10:00	30	notstarted	\N	2761
2762	5	5523	5524	5523	5524	houston-texans-new-york-giants	2025-03-02 14:10:00	61	notstarted	\N	2762
2763	5	5525	5526	5525	5526	miami-dolphins-minnesota-vikings	2024-07-28 19:00:00	30	notstarted	\N	2763
2764	5	5527	5528	5527	5528	minnesota-vikings-miami-dolphins	2025-03-02 16:30:00	61	notstarted	\N	2764
2765	5	5529	5530	5529	5530	philadelphia-eagles-detroit-lions	2024-07-28 18:20:00	30	notstarted	\N	2765
2766	5	5531	5532	5531	5532	detroit-lions-philadelphia-eagles	2025-03-02 13:20:00	61	notstarted	\N	2766
2767	5	5533	5534	5533	5534	buffalo-bills-seattle-seahawks	2024-07-28 19:50:00	30	notstarted	\N	2767
2768	5	5535	5536	5535	5536	seattle-seahawks-buffalo-bills	2025-03-02 14:40:00	61	notstarted	\N	2768
2769	5	5537	5538	5537	5538	green-bay-packers-dallas-cowboys	2024-07-28 17:40:00	30	notstarted	\N	2769
2770	5	5539	5540	5539	5540	dallas-cowboys-green-bay-packers	2025-03-02 15:00:00	61	notstarted	\N	2770
2771	5	5541	5542	5541	5542	las-vegas-raiders-carolina-panthers	2024-08-03 19:50:00	31	notstarted	\N	2771
2772	5	5543	5544	5543	5544	carolina-panthers-las-vegas-raiders	2025-03-08 17:20:00	62	notstarted	\N	2772
2773	5	5545	5546	5545	5546	denver-broncos-pittsburgh-steelers	2024-08-03 11:10:00	31	notstarted	\N	2773
2774	5	5547	5548	5547	5548	pittsburgh-steelers-denver-broncos	2025-03-08 14:50:00	62	notstarted	\N	2774
2775	5	5549	5550	5549	5550	new-york-giants-los-angeles-chargers	2024-08-03 14:00:00	31	notstarted	\N	2775
2776	5	5551	5552	5551	5552	los-angeles-chargers-new-york-giants	2025-03-08 11:10:00	62	notstarted	\N	2776
2777	5	5553	5554	5553	5554	arizona-cardinals-cleveland-browns	2024-08-03 10:00:00	31	notstarted	\N	2777
2778	5	5555	5556	5555	5556	cleveland-browns-arizona-cardinals	2025-03-08 15:00:00	62	notstarted	\N	2778
2779	5	5557	5558	5557	5558	dallas-cowboys-tampa-bay-buccaneers	2024-08-03 15:30:00	31	notstarted	\N	2779
2780	5	5559	5560	5559	5560	tampa-bay-buccaneers-dallas-cowboys	2025-03-08 10:30:00	62	notstarted	\N	2780
2781	5	5561	5562	5561	5562	cincinnati-bengals-jacksonville-jaguars	2024-08-03 11:50:00	31	notstarted	\N	2781
2782	5	5563	5564	5563	5564	jacksonville-jaguars-cincinnati-bengals	2025-03-08 12:20:00	62	notstarted	\N	2782
2783	5	5565	5566	5565	5566	atlanta-falcons-houston-texans	2024-08-03 17:50:00	31	notstarted	\N	2783
2784	5	5567	5568	5567	5568	houston-texans-atlanta-falcons	2025-03-08 12:40:00	62	notstarted	\N	2784
2785	5	5569	5570	5569	5570	seattle-seahawks-los-angeles-rams	2024-08-03 11:00:00	31	notstarted	\N	2785
2786	5	5571	5572	5571	5572	los-angeles-rams-seattle-seahawks	2025-03-08 15:00:00	62	notstarted	\N	2786
2787	5	5573	5574	5573	5574	new-york-jets-indianapolis-colts	2024-08-04 17:30:00	31	notstarted	\N	2787
2788	5	5575	5576	5575	5576	indianapolis-colts-new-york-jets	2025-03-09 11:30:00	62	notstarted	\N	2788
2789	5	5577	5578	5577	5578	minnesota-vikings-detroit-lions	2024-08-04 15:40:00	31	notstarted	\N	2789
2790	5	5579	5580	5579	5580	detroit-lions-minnesota-vikings	2025-03-09 16:20:00	62	notstarted	\N	2790
2791	5	5581	5582	5581	5582	philadelphia-eagles-kansas-city-chiefs	2024-08-04 12:00:00	31	notstarted	\N	2791
2792	5	5583	5584	5583	5584	kansas-city-chiefs-philadelphia-eagles	2025-03-09 11:00:00	62	notstarted	\N	2792
2793	5	5585	5586	5585	5586	washington-commanders-san-francisco-49ers	2024-08-04 17:10:00	31	notstarted	\N	2793
2794	5	5587	5588	5587	5588	san-francisco-49ers-washington-commanders	2025-03-09 15:10:00	62	notstarted	\N	2794
2795	5	5589	5590	5589	5590	tennessee-titans-green-bay-packers	2024-08-04 15:00:00	31	notstarted	\N	2795
2796	5	5591	5592	5591	5592	green-bay-packers-tennessee-titans	2025-03-09 19:30:00	62	notstarted	\N	2796
2797	5	5593	5594	5593	5594	chicago-bears-miami-dolphins	2024-08-04 13:10:00	31	notstarted	\N	2797
2798	5	5595	5596	5595	5596	miami-dolphins-chicago-bears	2025-03-09 16:00:00	62	notstarted	\N	2798
2799	5	5597	5598	5597	5598	buffalo-bills-new-england-patriots	2024-08-04 11:20:00	31	notstarted	\N	2799
2800	5	5599	5600	5599	5600	new-england-patriots-buffalo-bills	2025-03-09 10:40:00	62	notstarted	\N	2800
2801	5	5601	5602	5601	5602	new-orleans-saints-baltimore-ravens	2024-08-04 14:30:00	31	notstarted	\N	2801
2802	5	5603	5604	5603	5604	baltimore-ravens-new-orleans-saints	2025-03-09 16:50:00	62	notstarted	\N	2802
3	3	5	6	5	6	everton-tottenham-hotspur	2024-01-06 15:30:00	1	finished	away	3
\.


--
-- Data for Name: incident; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.incident (id, player_id, team_side, color, "time", type, external_id) FROM stdin;
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.player (id, country_id, name, slug, "position", external_id) FROM stdin;
\.


--
-- Data for Name: score; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.score (id, total, period1, period2, period3, period4, overtime, external_id) FROM stdin;
3	2	\N	2	\N	\N	\N	2
4	2	\N	2	\N	\N	\N	2
5	2	2	0	\N	\N	\N	3
6	4	2	2	\N	\N	\N	3
7	2	\N	2	\N	\N	\N	4
8	1	\N	1	\N	\N	\N	4
9	2	2	0	\N	\N	\N	5
10	3	2	1	\N	\N	\N	5
11	1	\N	1	\N	\N	\N	6
12	2	\N	2	\N	\N	\N	6
13	0	0	0	\N	\N	\N	7
14	1	1	0	\N	\N	\N	7
15	1	\N	1	\N	\N	\N	8
16	1	\N	1	\N	\N	\N	8
17	3	1	2	\N	\N	\N	9
18	2	1	1	\N	\N	\N	9
19	0	\N	0	\N	\N	\N	10
20	2	\N	2	\N	\N	\N	10
21	2	1	1	\N	\N	\N	11
22	1	0	1	\N	\N	\N	11
23	2	\N	2	\N	\N	\N	12
24	1	\N	1	\N	\N	\N	12
25	2	2	0	\N	\N	\N	13
26	2	2	0	\N	\N	\N	13
27	0	\N	0	\N	\N	\N	14
28	2	\N	2	\N	\N	\N	14
29	2	2	0	\N	\N	\N	15
30	1	1	0	\N	\N	\N	15
31	2	\N	2	\N	\N	\N	16
32	2	\N	2	\N	\N	\N	16
33	3	1	2	\N	\N	\N	17
34	3	2	1	\N	\N	\N	17
35	2	\N	2	\N	\N	\N	18
36	0	\N	0	\N	\N	\N	18
37	2	1	1	\N	\N	\N	19
38	2	1	1	\N	\N	\N	19
39	1	\N	1	\N	\N	\N	20
40	2	\N	2	\N	\N	\N	20
41	3	1	2	\N	\N	\N	21
42	3	2	1	\N	\N	\N	21
43	0	\N	0	\N	\N	\N	22
44	1	\N	1	\N	\N	\N	22
45	3	1	2	\N	\N	\N	23
46	4	2	2	\N	\N	\N	23
47	1	\N	1	\N	\N	\N	24
48	1	\N	1	\N	\N	\N	24
49	3	2	1	\N	\N	\N	25
50	2	2	0	\N	\N	\N	25
51	2	\N	2	\N	\N	\N	26
52	1	\N	1	\N	\N	\N	26
53	0	0	0	\N	\N	\N	27
54	1	0	1	\N	\N	\N	27
55	0	\N	0	\N	\N	\N	28
56	2	\N	2	\N	\N	\N	28
57	3	1	2	\N	\N	\N	29
58	2	0	2	\N	\N	\N	29
59	0	\N	0	\N	\N	\N	30
60	2	\N	2	\N	\N	\N	30
61	3	2	1	\N	\N	\N	31
62	2	1	1	\N	\N	\N	31
63	1	\N	1	\N	\N	\N	32
64	1	\N	1	\N	\N	\N	32
65	2	2	0	\N	\N	\N	33
66	3	2	1	\N	\N	\N	33
67	2	\N	2	\N	\N	\N	34
68	1	\N	1	\N	\N	\N	34
69	0	0	0	\N	\N	\N	35
70	1	1	0	\N	\N	\N	35
71	1	\N	1	\N	\N	\N	36
72	2	\N	2	\N	\N	\N	36
73	1	1	0	\N	\N	\N	37
74	3	1	2	\N	\N	\N	37
75	2	\N	2	\N	\N	\N	38
76	0	\N	0	\N	\N	\N	38
77	2	2	0	\N	\N	\N	39
78	2	1	1	\N	\N	\N	39
79	2	\N	2	\N	\N	\N	40
80	0	\N	0	\N	\N	\N	40
81	2	2	0	\N	\N	\N	41
82	0	0	0	\N	\N	\N	41
83	\N	\N	\N	\N	\N	\N	42
84	\N	\N	\N	\N	\N	\N	42
85	2	1	1	\N	\N	\N	43
86	2	1	1	\N	\N	\N	43
87	\N	\N	\N	\N	\N	\N	44
88	\N	\N	\N	\N	\N	\N	44
89	1	1	0	\N	\N	\N	45
90	4	2	2	\N	\N	\N	45
91	\N	\N	\N	\N	\N	\N	46
92	\N	\N	\N	\N	\N	\N	46
93	1	1	0	\N	\N	\N	47
94	0	0	0	\N	\N	\N	47
95	\N	\N	\N	\N	\N	\N	48
96	\N	\N	\N	\N	\N	\N	48
97	1	0	1	\N	\N	\N	49
98	0	0	0	\N	\N	\N	49
99	\N	\N	\N	\N	\N	\N	50
100	\N	\N	\N	\N	\N	\N	50
101	0	0	0	\N	\N	\N	51
102	1	1	0	\N	\N	\N	51
103	\N	\N	\N	\N	\N	\N	52
104	\N	\N	\N	\N	\N	\N	52
105	1	0	1	\N	\N	\N	53
106	3	1	2	\N	\N	\N	53
107	\N	\N	\N	\N	\N	\N	54
108	\N	\N	\N	\N	\N	\N	54
109	3	1	2	\N	\N	\N	55
110	2	0	2	\N	\N	\N	55
111	\N	\N	\N	\N	\N	\N	56
112	\N	\N	\N	\N	\N	\N	56
113	3	2	1	\N	\N	\N	57
114	1	0	1	\N	\N	\N	57
115	\N	\N	\N	\N	\N	\N	58
116	\N	\N	\N	\N	\N	\N	58
117	1	1	0	\N	\N	\N	59
118	3	2	1	\N	\N	\N	59
119	\N	\N	\N	\N	\N	\N	60
120	\N	\N	\N	\N	\N	\N	60
121	1	1	0	\N	\N	\N	61
122	4	2	2	\N	\N	\N	61
123	\N	\N	\N	\N	\N	\N	62
124	\N	\N	\N	\N	\N	\N	62
125	2	0	2	\N	\N	\N	63
126	2	1	1	\N	\N	\N	63
127	\N	\N	\N	\N	\N	\N	64
128	\N	\N	\N	\N	\N	\N	64
129	3	1	2	\N	\N	\N	65
130	3	2	1	\N	\N	\N	65
131	\N	\N	\N	\N	\N	\N	66
132	\N	\N	\N	\N	\N	\N	66
133	3	2	1	\N	\N	\N	67
134	2	0	2	\N	\N	\N	67
135	\N	\N	\N	\N	\N	\N	68
136	\N	\N	\N	\N	\N	\N	68
137	1	0	1	\N	\N	\N	69
138	1	1	0	\N	\N	\N	69
139	\N	\N	\N	\N	\N	\N	70
140	\N	\N	\N	\N	\N	\N	70
141	2	0	2	\N	\N	\N	71
142	1	1	0	\N	\N	\N	71
143	\N	\N	\N	\N	\N	\N	72
144	\N	\N	\N	\N	\N	\N	72
145	4	2	2	\N	\N	\N	73
146	2	1	1	\N	\N	\N	73
147	\N	\N	\N	\N	\N	\N	74
148	\N	\N	\N	\N	\N	\N	74
149	4	2	2	\N	\N	\N	75
150	2	1	1	\N	\N	\N	75
151	\N	\N	\N	\N	\N	\N	76
152	\N	\N	\N	\N	\N	\N	76
153	1	1	0	\N	\N	\N	77
154	3	1	2	\N	\N	\N	77
155	\N	\N	\N	\N	\N	\N	78
156	\N	\N	\N	\N	\N	\N	78
157	3	2	1	\N	\N	\N	79
158	1	1	0	\N	\N	\N	79
159	\N	\N	\N	\N	\N	\N	80
160	\N	\N	\N	\N	\N	\N	80
161	4	2	2	\N	\N	\N	81
162	0	0	0	\N	\N	\N	81
163	\N	\N	\N	\N	\N	\N	82
164	\N	\N	\N	\N	\N	\N	82
165	2	0	2	\N	\N	\N	83
166	4	2	2	\N	\N	\N	83
167	\N	\N	\N	\N	\N	\N	84
168	\N	\N	\N	\N	\N	\N	84
169	0	0	0	\N	\N	\N	85
170	1	0	1	\N	\N	\N	85
171	\N	\N	\N	\N	\N	\N	86
172	\N	\N	\N	\N	\N	\N	86
173	3	1	2	\N	\N	\N	87
174	4	2	2	\N	\N	\N	87
175	\N	\N	\N	\N	\N	\N	88
176	\N	\N	\N	\N	\N	\N	88
177	1	0	1	\N	\N	\N	89
178	0	0	0	\N	\N	\N	89
179	\N	\N	\N	\N	\N	\N	90
180	\N	\N	\N	\N	\N	\N	90
181	3	2	1	\N	\N	\N	91
182	3	2	1	\N	\N	\N	91
183	\N	\N	\N	\N	\N	\N	92
184	\N	\N	\N	\N	\N	\N	92
185	3	2	1	\N	\N	\N	93
186	2	0	2	\N	\N	\N	93
187	\N	\N	\N	\N	\N	\N	94
188	\N	\N	\N	\N	\N	\N	94
189	4	2	2	\N	\N	\N	95
190	2	1	1	\N	\N	\N	95
191	\N	\N	\N	\N	\N	\N	96
192	\N	\N	\N	\N	\N	\N	96
193	2	0	2	\N	\N	\N	97
194	4	2	2	\N	\N	\N	97
195	\N	\N	\N	\N	\N	\N	98
196	\N	\N	\N	\N	\N	\N	98
197	2	1	1	\N	\N	\N	99
198	4	2	2	\N	\N	\N	99
199	\N	\N	\N	\N	\N	\N	100
200	\N	\N	\N	\N	\N	\N	100
201	0	0	0	\N	\N	\N	101
202	2	2	0	\N	\N	\N	101
203	\N	\N	\N	\N	\N	\N	102
204	\N	\N	\N	\N	\N	\N	102
205	3	1	2	\N	\N	\N	103
206	1	0	1	\N	\N	\N	103
207	\N	\N	\N	\N	\N	\N	104
208	\N	\N	\N	\N	\N	\N	104
209	2	0	2	\N	\N	\N	105
210	1	0	1	\N	\N	\N	105
211	\N	\N	\N	\N	\N	\N	106
212	\N	\N	\N	\N	\N	\N	106
213	2	2	0	\N	\N	\N	107
214	2	0	2	\N	\N	\N	107
215	\N	\N	\N	\N	\N	\N	108
216	\N	\N	\N	\N	\N	\N	108
217	1	0	1	\N	\N	\N	109
218	2	1	1	\N	\N	\N	109
219	\N	\N	\N	\N	\N	\N	110
220	\N	\N	\N	\N	\N	\N	110
221	3	2	1	\N	\N	\N	111
222	4	2	2	\N	\N	\N	111
223	\N	\N	\N	\N	\N	\N	112
224	\N	\N	\N	\N	\N	\N	112
225	0	0	0	\N	\N	\N	113
226	1	1	0	\N	\N	\N	113
227	\N	\N	\N	\N	\N	\N	114
228	\N	\N	\N	\N	\N	\N	114
229	3	1	2	\N	\N	\N	115
230	1	0	1	\N	\N	\N	115
231	\N	\N	\N	\N	\N	\N	116
232	\N	\N	\N	\N	\N	\N	116
233	1	0	1	\N	\N	\N	117
234	2	0	2	\N	\N	\N	117
235	\N	\N	\N	\N	\N	\N	118
236	\N	\N	\N	\N	\N	\N	118
237	3	2	1	\N	\N	\N	119
238	1	0	1	\N	\N	\N	119
239	\N	\N	\N	\N	\N	\N	120
240	\N	\N	\N	\N	\N	\N	120
241	4	2	2	\N	\N	\N	121
242	1	0	1	\N	\N	\N	121
243	\N	\N	\N	\N	\N	\N	122
244	\N	\N	\N	\N	\N	\N	122
245	0	0	0	\N	\N	\N	123
246	0	0	0	\N	\N	\N	123
247	\N	\N	\N	\N	\N	\N	124
248	\N	\N	\N	\N	\N	\N	124
249	1	1	0	\N	\N	\N	125
250	2	2	0	\N	\N	\N	125
251	\N	\N	\N	\N	\N	\N	126
252	\N	\N	\N	\N	\N	\N	126
253	3	1	2	\N	\N	\N	127
254	3	2	1	\N	\N	\N	127
255	\N	\N	\N	\N	\N	\N	128
256	\N	\N	\N	\N	\N	\N	128
257	3	1	2	\N	\N	\N	129
258	3	1	2	\N	\N	\N	129
259	\N	\N	\N	\N	\N	\N	130
260	\N	\N	\N	\N	\N	\N	130
261	2	1	1	\N	\N	\N	131
262	1	0	1	\N	\N	\N	131
263	\N	\N	\N	\N	\N	\N	132
264	\N	\N	\N	\N	\N	\N	132
265	2	1	1	\N	\N	\N	133
266	0	0	0	\N	\N	\N	133
267	\N	\N	\N	\N	\N	\N	134
268	\N	\N	\N	\N	\N	\N	134
269	2	0	2	\N	\N	\N	135
270	1	1	0	\N	\N	\N	135
271	\N	\N	\N	\N	\N	\N	136
272	\N	\N	\N	\N	\N	\N	136
273	2	1	1	\N	\N	\N	137
274	0	0	0	\N	\N	\N	137
275	\N	\N	\N	\N	\N	\N	138
276	\N	\N	\N	\N	\N	\N	138
277	3	1	2	\N	\N	\N	139
278	2	0	2	\N	\N	\N	139
279	\N	\N	\N	\N	\N	\N	140
280	\N	\N	\N	\N	\N	\N	140
281	2	2	0	\N	\N	\N	141
282	1	1	0	\N	\N	\N	141
283	\N	\N	\N	\N	\N	\N	142
284	\N	\N	\N	\N	\N	\N	142
285	4	2	2	\N	\N	\N	143
286	1	1	0	\N	\N	\N	143
287	\N	\N	\N	\N	\N	\N	144
288	\N	\N	\N	\N	\N	\N	144
289	3	1	2	\N	\N	\N	145
290	3	1	2	\N	\N	\N	145
291	\N	\N	\N	\N	\N	\N	146
292	\N	\N	\N	\N	\N	\N	146
293	3	2	1	\N	\N	\N	147
294	4	2	2	\N	\N	\N	147
295	\N	\N	\N	\N	\N	\N	148
296	\N	\N	\N	\N	\N	\N	148
297	3	2	1	\N	\N	\N	149
298	1	0	1	\N	\N	\N	149
299	\N	\N	\N	\N	\N	\N	150
300	\N	\N	\N	\N	\N	\N	150
301	2	1	1	\N	\N	\N	151
302	4	2	2	\N	\N	\N	151
303	\N	\N	\N	\N	\N	\N	152
304	\N	\N	\N	\N	\N	\N	152
305	2	0	2	\N	\N	\N	153
306	3	1	2	\N	\N	\N	153
307	\N	\N	\N	\N	\N	\N	154
308	\N	\N	\N	\N	\N	\N	154
309	2	1	1	\N	\N	\N	155
310	0	0	0	\N	\N	\N	155
311	\N	\N	\N	\N	\N	\N	156
312	\N	\N	\N	\N	\N	\N	156
313	3	1	2	\N	\N	\N	157
314	3	2	1	\N	\N	\N	157
315	\N	\N	\N	\N	\N	\N	158
316	\N	\N	\N	\N	\N	\N	158
317	2	2	0	\N	\N	\N	159
318	3	1	2	\N	\N	\N	159
319	\N	\N	\N	\N	\N	\N	160
320	\N	\N	\N	\N	\N	\N	160
321	0	0	0	\N	\N	\N	161
322	3	2	1	\N	\N	\N	161
323	\N	\N	\N	\N	\N	\N	162
324	\N	\N	\N	\N	\N	\N	162
325	2	2	0	\N	\N	\N	163
326	2	0	2	\N	\N	\N	163
327	\N	\N	\N	\N	\N	\N	164
328	\N	\N	\N	\N	\N	\N	164
329	1	1	0	\N	\N	\N	165
330	1	1	0	\N	\N	\N	165
331	\N	\N	\N	\N	\N	\N	166
332	\N	\N	\N	\N	\N	\N	166
333	1	0	1	\N	\N	\N	167
334	2	0	2	\N	\N	\N	167
335	\N	\N	\N	\N	\N	\N	168
336	\N	\N	\N	\N	\N	\N	168
337	3	1	2	\N	\N	\N	169
338	3	1	2	\N	\N	\N	169
339	\N	\N	\N	\N	\N	\N	170
340	\N	\N	\N	\N	\N	\N	170
341	2	0	2	\N	\N	\N	171
342	3	2	1	\N	\N	\N	171
343	\N	\N	\N	\N	\N	\N	172
344	\N	\N	\N	\N	\N	\N	172
345	2	1	1	\N	\N	\N	173
346	2	2	0	\N	\N	\N	173
347	\N	\N	\N	\N	\N	\N	174
348	\N	\N	\N	\N	\N	\N	174
349	2	2	0	\N	\N	\N	175
350	0	0	0	\N	\N	\N	175
351	\N	\N	\N	\N	\N	\N	176
352	\N	\N	\N	\N	\N	\N	176
353	1	0	1	\N	\N	\N	177
354	2	2	0	\N	\N	\N	177
355	\N	\N	\N	\N	\N	\N	178
356	\N	\N	\N	\N	\N	\N	178
357	0	0	0	\N	\N	\N	179
358	3	1	2	\N	\N	\N	179
359	\N	\N	\N	\N	\N	\N	180
360	\N	\N	\N	\N	\N	\N	180
361	3	2	1	\N	\N	\N	181
362	3	1	2	\N	\N	\N	181
363	\N	\N	\N	\N	\N	\N	182
364	\N	\N	\N	\N	\N	\N	182
365	0	0	0	\N	\N	\N	183
366	1	1	0	\N	\N	\N	183
367	\N	\N	\N	\N	\N	\N	184
368	\N	\N	\N	\N	\N	\N	184
369	2	0	2	\N	\N	\N	185
370	3	1	2	\N	\N	\N	185
371	\N	\N	\N	\N	\N	\N	186
372	\N	\N	\N	\N	\N	\N	186
373	1	0	1	\N	\N	\N	187
374	0	0	0	\N	\N	\N	187
375	\N	\N	\N	\N	\N	\N	188
376	\N	\N	\N	\N	\N	\N	188
377	2	1	1	\N	\N	\N	189
378	2	1	1	\N	\N	\N	189
379	\N	\N	\N	\N	\N	\N	190
380	\N	\N	\N	\N	\N	\N	190
381	2	1	1	\N	\N	\N	191
382	2	2	0	\N	\N	\N	191
383	\N	\N	\N	\N	\N	\N	192
384	\N	\N	\N	\N	\N	\N	192
385	0	0	0	\N	\N	\N	193
386	3	2	1	\N	\N	\N	193
387	\N	\N	\N	\N	\N	\N	194
388	\N	\N	\N	\N	\N	\N	194
389	2	1	1	\N	\N	\N	195
390	2	1	1	\N	\N	\N	195
391	\N	\N	\N	\N	\N	\N	196
392	\N	\N	\N	\N	\N	\N	196
393	1	0	1	\N	\N	\N	197
394	0	0	0	\N	\N	\N	197
395	\N	\N	\N	\N	\N	\N	198
396	\N	\N	\N	\N	\N	\N	198
397	3	2	1	\N	\N	\N	199
398	2	2	0	\N	\N	\N	199
399	\N	\N	\N	\N	\N	\N	200
400	\N	\N	\N	\N	\N	\N	200
401	1	0	1	\N	\N	\N	201
402	2	1	1	\N	\N	\N	201
403	\N	\N	\N	\N	\N	\N	202
404	\N	\N	\N	\N	\N	\N	202
405	1	0	1	\N	\N	\N	203
406	3	2	1	\N	\N	\N	203
407	\N	\N	\N	\N	\N	\N	204
408	\N	\N	\N	\N	\N	\N	204
409	3	2	1	\N	\N	\N	205
410	2	0	2	\N	\N	\N	205
411	\N	\N	\N	\N	\N	\N	206
412	\N	\N	\N	\N	\N	\N	206
413	2	0	2	\N	\N	\N	207
414	4	2	2	\N	\N	\N	207
415	\N	\N	\N	\N	\N	\N	208
416	\N	\N	\N	\N	\N	\N	208
417	2	0	2	\N	\N	\N	209
418	2	0	2	\N	\N	\N	209
419	\N	\N	\N	\N	\N	\N	210
420	\N	\N	\N	\N	\N	\N	210
421	1	0	1	\N	\N	\N	211
422	1	1	0	\N	\N	\N	211
423	\N	\N	\N	\N	\N	\N	212
424	\N	\N	\N	\N	\N	\N	212
425	3	2	1	\N	\N	\N	213
426	1	0	1	\N	\N	\N	213
427	\N	\N	\N	\N	\N	\N	214
428	\N	\N	\N	\N	\N	\N	214
429	1	0	1	\N	\N	\N	215
430	2	0	2	\N	\N	\N	215
431	\N	\N	\N	\N	\N	\N	216
432	\N	\N	\N	\N	\N	\N	216
433	3	2	1	\N	\N	\N	217
434	1	0	1	\N	\N	\N	217
435	\N	\N	\N	\N	\N	\N	218
436	\N	\N	\N	\N	\N	\N	218
437	1	1	0	\N	\N	\N	219
438	1	0	1	\N	\N	\N	219
439	\N	\N	\N	\N	\N	\N	220
440	\N	\N	\N	\N	\N	\N	220
441	0	0	0	\N	\N	\N	221
442	1	1	0	\N	\N	\N	221
443	\N	\N	\N	\N	\N	\N	222
444	\N	\N	\N	\N	\N	\N	222
445	1	1	0	\N	\N	\N	223
446	2	2	0	\N	\N	\N	223
447	\N	\N	\N	\N	\N	\N	224
448	\N	\N	\N	\N	\N	\N	224
449	1	0	1	\N	\N	\N	225
450	3	2	1	\N	\N	\N	225
451	\N	\N	\N	\N	\N	\N	226
452	\N	\N	\N	\N	\N	\N	226
453	4	2	2	\N	\N	\N	227
454	0	0	0	\N	\N	\N	227
455	\N	\N	\N	\N	\N	\N	228
456	\N	\N	\N	\N	\N	\N	228
457	1	1	0	\N	\N	\N	229
458	3	1	2	\N	\N	\N	229
459	\N	\N	\N	\N	\N	\N	230
460	\N	\N	\N	\N	\N	\N	230
461	2	1	1	\N	\N	\N	231
462	2	0	2	\N	\N	\N	231
463	\N	\N	\N	\N	\N	\N	232
464	\N	\N	\N	\N	\N	\N	232
465	2	2	0	\N	\N	\N	233
466	0	0	0	\N	\N	\N	233
467	\N	\N	\N	\N	\N	\N	234
468	\N	\N	\N	\N	\N	\N	234
469	3	2	1	\N	\N	\N	235
470	1	1	0	\N	\N	\N	235
471	\N	\N	\N	\N	\N	\N	236
472	\N	\N	\N	\N	\N	\N	236
473	3	2	1	\N	\N	\N	237
474	3	1	2	\N	\N	\N	237
475	\N	\N	\N	\N	\N	\N	238
476	\N	\N	\N	\N	\N	\N	238
477	1	0	1	\N	\N	\N	239
478	0	0	0	\N	\N	\N	239
479	\N	\N	\N	\N	\N	\N	240
480	\N	\N	\N	\N	\N	\N	240
481	2	2	0	\N	\N	\N	241
482	0	0	0	\N	\N	\N	241
483	\N	\N	\N	\N	\N	\N	242
484	\N	\N	\N	\N	\N	\N	242
485	2	2	0	\N	\N	\N	243
486	2	0	2	\N	\N	\N	243
487	\N	\N	\N	\N	\N	\N	244
488	\N	\N	\N	\N	\N	\N	244
489	0	0	0	\N	\N	\N	245
490	2	2	0	\N	\N	\N	245
491	\N	\N	\N	\N	\N	\N	246
492	\N	\N	\N	\N	\N	\N	246
493	2	2	0	\N	\N	\N	247
494	4	2	2	\N	\N	\N	247
495	\N	\N	\N	\N	\N	\N	248
496	\N	\N	\N	\N	\N	\N	248
497	4	2	2	\N	\N	\N	249
498	1	1	0	\N	\N	\N	249
499	\N	\N	\N	\N	\N	\N	250
500	\N	\N	\N	\N	\N	\N	250
501	4	2	2	\N	\N	\N	251
502	3	2	1	\N	\N	\N	251
503	\N	\N	\N	\N	\N	\N	252
504	\N	\N	\N	\N	\N	\N	252
505	2	0	2	\N	\N	\N	253
506	0	0	0	\N	\N	\N	253
507	\N	\N	\N	\N	\N	\N	254
508	\N	\N	\N	\N	\N	\N	254
509	1	0	1	\N	\N	\N	255
510	2	0	2	\N	\N	\N	255
511	\N	\N	\N	\N	\N	\N	256
512	\N	\N	\N	\N	\N	\N	256
513	3	2	1	\N	\N	\N	257
514	2	2	0	\N	\N	\N	257
515	\N	\N	\N	\N	\N	\N	258
516	\N	\N	\N	\N	\N	\N	258
517	2	2	0	\N	\N	\N	259
518	2	2	0	\N	\N	\N	259
519	\N	\N	\N	\N	\N	\N	260
520	\N	\N	\N	\N	\N	\N	260
521	2	0	2	\N	\N	\N	261
522	2	0	2	\N	\N	\N	261
523	\N	\N	\N	\N	\N	\N	262
524	\N	\N	\N	\N	\N	\N	262
525	1	1	0	\N	\N	\N	263
526	1	0	1	\N	\N	\N	263
527	\N	\N	\N	\N	\N	\N	264
528	\N	\N	\N	\N	\N	\N	264
529	1	1	0	\N	\N	\N	265
530	3	2	1	\N	\N	\N	265
531	\N	\N	\N	\N	\N	\N	266
532	\N	\N	\N	\N	\N	\N	266
533	2	1	1	\N	\N	\N	267
534	2	0	2	\N	\N	\N	267
535	\N	\N	\N	\N	\N	\N	268
536	\N	\N	\N	\N	\N	\N	268
537	2	0	2	\N	\N	\N	269
538	3	2	1	\N	\N	\N	269
539	\N	\N	\N	\N	\N	\N	270
540	\N	\N	\N	\N	\N	\N	270
541	2	0	2	\N	\N	\N	271
542	3	2	1	\N	\N	\N	271
543	\N	\N	\N	\N	\N	\N	272
544	\N	\N	\N	\N	\N	\N	272
545	3	1	2	\N	\N	\N	273
546	0	0	0	\N	\N	\N	273
547	\N	\N	\N	\N	\N	\N	274
548	\N	\N	\N	\N	\N	\N	274
549	2	1	1	\N	\N	\N	275
550	0	0	0	\N	\N	\N	275
551	\N	\N	\N	\N	\N	\N	276
552	\N	\N	\N	\N	\N	\N	276
553	0	0	0	\N	\N	\N	277
554	3	2	1	\N	\N	\N	277
555	\N	\N	\N	\N	\N	\N	278
556	\N	\N	\N	\N	\N	\N	278
557	2	2	0	\N	\N	\N	279
558	2	2	0	\N	\N	\N	279
559	\N	\N	\N	\N	\N	\N	280
560	\N	\N	\N	\N	\N	\N	280
561	3	1	2	\N	\N	\N	281
562	2	2	0	\N	\N	\N	281
563	\N	\N	\N	\N	\N	\N	282
564	\N	\N	\N	\N	\N	\N	282
565	2	2	0	\N	\N	\N	283
566	2	0	2	\N	\N	\N	283
567	\N	\N	\N	\N	\N	\N	284
568	\N	\N	\N	\N	\N	\N	284
569	3	1	2	\N	\N	\N	285
570	3	1	2	\N	\N	\N	285
571	\N	\N	\N	\N	\N	\N	286
572	\N	\N	\N	\N	\N	\N	286
573	2	0	2	\N	\N	\N	287
574	4	2	2	\N	\N	\N	287
575	\N	\N	\N	\N	\N	\N	288
576	\N	\N	\N	\N	\N	\N	288
577	4	2	2	\N	\N	\N	289
578	1	1	0	\N	\N	\N	289
579	\N	\N	\N	\N	\N	\N	290
580	\N	\N	\N	\N	\N	\N	290
581	2	1	1	\N	\N	\N	291
582	1	0	1	\N	\N	\N	291
583	\N	\N	\N	\N	\N	\N	292
584	\N	\N	\N	\N	\N	\N	292
585	0	0	0	\N	\N	\N	293
586	2	2	0	\N	\N	\N	293
587	\N	\N	\N	\N	\N	\N	294
588	\N	\N	\N	\N	\N	\N	294
589	2	2	0	\N	\N	\N	295
590	4	2	2	\N	\N	\N	295
591	\N	\N	\N	\N	\N	\N	296
592	\N	\N	\N	\N	\N	\N	296
593	2	2	0	\N	\N	\N	297
594	2	1	1	\N	\N	\N	297
595	\N	\N	\N	\N	\N	\N	298
596	\N	\N	\N	\N	\N	\N	298
597	1	1	0	\N	\N	\N	299
598	3	2	1	\N	\N	\N	299
599	\N	\N	\N	\N	\N	\N	300
600	\N	\N	\N	\N	\N	\N	300
601	0	0	0	\N	\N	\N	301
602	1	0	1	\N	\N	\N	301
603	\N	\N	\N	\N	\N	\N	302
604	\N	\N	\N	\N	\N	\N	302
605	1	0	1	\N	\N	\N	303
606	2	0	2	\N	\N	\N	303
607	\N	\N	\N	\N	\N	\N	304
608	\N	\N	\N	\N	\N	\N	304
609	4	2	2	\N	\N	\N	305
610	2	2	0	\N	\N	\N	305
611	\N	\N	\N	\N	\N	\N	306
612	\N	\N	\N	\N	\N	\N	306
613	3	1	2	\N	\N	\N	307
614	3	2	1	\N	\N	\N	307
615	\N	\N	\N	\N	\N	\N	308
616	\N	\N	\N	\N	\N	\N	308
617	4	2	2	\N	\N	\N	309
618	1	0	1	\N	\N	\N	309
619	\N	\N	\N	\N	\N	\N	310
620	\N	\N	\N	\N	\N	\N	310
621	1	1	0	\N	\N	\N	311
622	4	2	2	\N	\N	\N	311
623	\N	\N	\N	\N	\N	\N	312
624	\N	\N	\N	\N	\N	\N	312
625	3	2	1	\N	\N	\N	313
626	0	0	0	\N	\N	\N	313
627	\N	\N	\N	\N	\N	\N	314
628	\N	\N	\N	\N	\N	\N	314
629	2	0	2	\N	\N	\N	315
630	3	2	1	\N	\N	\N	315
631	\N	\N	\N	\N	\N	\N	316
632	\N	\N	\N	\N	\N	\N	316
633	0	0	0	\N	\N	\N	317
634	3	1	2	\N	\N	\N	317
635	\N	\N	\N	\N	\N	\N	318
636	\N	\N	\N	\N	\N	\N	318
637	2	1	1	\N	\N	\N	319
638	0	0	0	\N	\N	\N	319
639	\N	\N	\N	\N	\N	\N	320
640	\N	\N	\N	\N	\N	\N	320
641	4	2	2	\N	\N	\N	321
642	1	0	1	\N	\N	\N	321
643	\N	\N	\N	\N	\N	\N	322
644	\N	\N	\N	\N	\N	\N	322
645	2	1	1	\N	\N	\N	323
646	2	0	2	\N	\N	\N	323
647	\N	\N	\N	\N	\N	\N	324
648	\N	\N	\N	\N	\N	\N	324
649	1	0	1	\N	\N	\N	325
650	1	0	1	\N	\N	\N	325
651	\N	\N	\N	\N	\N	\N	326
652	\N	\N	\N	\N	\N	\N	326
653	2	2	0	\N	\N	\N	327
654	3	1	2	\N	\N	\N	327
655	\N	\N	\N	\N	\N	\N	328
656	\N	\N	\N	\N	\N	\N	328
657	0	0	0	\N	\N	\N	329
658	2	1	1	\N	\N	\N	329
659	\N	\N	\N	\N	\N	\N	330
660	\N	\N	\N	\N	\N	\N	330
661	2	2	0	\N	\N	\N	331
662	3	1	2	\N	\N	\N	331
663	\N	\N	\N	\N	\N	\N	332
664	\N	\N	\N	\N	\N	\N	332
665	2	1	1	\N	\N	\N	333
666	4	2	2	\N	\N	\N	333
667	\N	\N	\N	\N	\N	\N	334
668	\N	\N	\N	\N	\N	\N	334
669	1	1	0	\N	\N	\N	335
670	2	1	1	\N	\N	\N	335
671	\N	\N	\N	\N	\N	\N	336
672	\N	\N	\N	\N	\N	\N	336
673	4	2	2	\N	\N	\N	337
674	2	2	0	\N	\N	\N	337
675	\N	\N	\N	\N	\N	\N	338
676	\N	\N	\N	\N	\N	\N	338
677	2	2	0	\N	\N	\N	339
678	1	0	1	\N	\N	\N	339
679	\N	\N	\N	\N	\N	\N	340
680	\N	\N	\N	\N	\N	\N	340
681	1	\N	1	\N	\N	\N	341
682	2	\N	2	\N	\N	\N	341
683	\N	\N	\N	\N	\N	\N	342
684	\N	\N	\N	\N	\N	\N	342
685	2	\N	2	\N	\N	\N	343
686	1	\N	1	\N	\N	\N	343
687	\N	\N	\N	\N	\N	\N	344
688	\N	\N	\N	\N	\N	\N	344
689	1	\N	1	\N	\N	\N	345
690	0	\N	0	\N	\N	\N	345
691	\N	\N	\N	\N	\N	\N	346
692	\N	\N	\N	\N	\N	\N	346
693	1	\N	1	\N	\N	\N	347
694	1	\N	1	\N	\N	\N	347
695	\N	\N	\N	\N	\N	\N	348
696	\N	\N	\N	\N	\N	\N	348
697	2	\N	2	\N	\N	\N	349
698	2	\N	2	\N	\N	\N	349
699	\N	\N	\N	\N	\N	\N	350
700	\N	\N	\N	\N	\N	\N	350
701	2	\N	2	\N	\N	\N	351
702	1	\N	1	\N	\N	\N	351
703	\N	\N	\N	\N	\N	\N	352
704	\N	\N	\N	\N	\N	\N	352
705	1	\N	1	\N	\N	\N	353
706	1	\N	1	\N	\N	\N	353
707	\N	\N	\N	\N	\N	\N	354
708	\N	\N	\N	\N	\N	\N	354
709	2	\N	2	\N	\N	\N	355
710	0	\N	0	\N	\N	\N	355
711	\N	\N	\N	\N	\N	\N	356
712	\N	\N	\N	\N	\N	\N	356
713	1	\N	1	\N	\N	\N	357
714	1	\N	1	\N	\N	\N	357
715	\N	\N	\N	\N	\N	\N	358
716	\N	\N	\N	\N	\N	\N	358
717	0	\N	0	\N	\N	\N	359
718	0	\N	0	\N	\N	\N	359
719	\N	\N	\N	\N	\N	\N	360
720	\N	\N	\N	\N	\N	\N	360
721	0	\N	0	\N	\N	\N	361
722	0	\N	0	\N	\N	\N	361
723	\N	\N	\N	\N	\N	\N	362
724	\N	\N	\N	\N	\N	\N	362
725	0	\N	0	\N	\N	\N	363
726	2	\N	2	\N	\N	\N	363
727	\N	\N	\N	\N	\N	\N	364
728	\N	\N	\N	\N	\N	\N	364
729	1	\N	1	\N	\N	\N	365
730	1	\N	1	\N	\N	\N	365
731	\N	\N	\N	\N	\N	\N	366
732	\N	\N	\N	\N	\N	\N	366
733	1	\N	1	\N	\N	\N	367
734	1	\N	1	\N	\N	\N	367
735	\N	\N	\N	\N	\N	\N	368
736	\N	\N	\N	\N	\N	\N	368
737	1	\N	1	\N	\N	\N	369
738	1	\N	1	\N	\N	\N	369
739	\N	\N	\N	\N	\N	\N	370
740	\N	\N	\N	\N	\N	\N	370
741	2	\N	2	\N	\N	\N	371
742	0	\N	0	\N	\N	\N	371
743	\N	\N	\N	\N	\N	\N	372
744	\N	\N	\N	\N	\N	\N	372
745	2	\N	2	\N	\N	\N	373
746	0	\N	0	\N	\N	\N	373
747	\N	\N	\N	\N	\N	\N	374
748	\N	\N	\N	\N	\N	\N	374
749	2	\N	2	\N	\N	\N	375
750	0	\N	0	\N	\N	\N	375
751	\N	\N	\N	\N	\N	\N	376
752	\N	\N	\N	\N	\N	\N	376
753	0	\N	0	\N	\N	\N	377
754	0	\N	0	\N	\N	\N	377
755	\N	\N	\N	\N	\N	\N	378
756	\N	\N	\N	\N	\N	\N	378
757	2	\N	2	\N	\N	\N	379
758	2	\N	2	\N	\N	\N	379
759	\N	\N	\N	\N	\N	\N	380
760	\N	\N	\N	\N	\N	\N	380
761	2	2	0	\N	\N	\N	381
762	2	1	1	\N	\N	\N	381
763	3	1	2	\N	\N	\N	382
764	1	0	1	\N	\N	\N	382
765	0	\N	0	\N	\N	\N	383
766	0	\N	0	\N	\N	\N	383
767	\N	\N	\N	\N	\N	\N	384
768	\N	\N	\N	\N	\N	\N	384
769	2	2	0	\N	\N	\N	385
770	4	2	2	\N	\N	\N	385
771	2	2	0	\N	\N	\N	386
772	2	2	0	\N	\N	\N	386
773	1	\N	1	\N	\N	\N	387
774	0	\N	0	\N	\N	\N	387
775	\N	\N	\N	\N	\N	\N	388
776	\N	\N	\N	\N	\N	\N	388
777	2	2	0	\N	\N	\N	389
778	0	0	0	\N	\N	\N	389
779	2	1	1	\N	\N	\N	390
780	3	2	1	\N	\N	\N	390
781	2	\N	2	\N	\N	\N	391
782	1	\N	1	\N	\N	\N	391
783	\N	\N	\N	\N	\N	\N	392
784	\N	\N	\N	\N	\N	\N	392
785	4	2	2	\N	\N	\N	393
786	3	1	2	\N	\N	\N	393
787	1	1	0	\N	\N	\N	394
788	0	0	0	\N	\N	\N	394
789	1	\N	1	\N	\N	\N	395
790	2	\N	2	\N	\N	\N	395
791	\N	\N	\N	\N	\N	\N	396
792	\N	\N	\N	\N	\N	\N	396
793	2	1	1	\N	\N	\N	397
794	0	0	0	\N	\N	\N	397
795	2	2	0	\N	\N	\N	398
796	1	1	0	\N	\N	\N	398
797	2	\N	2	\N	\N	\N	399
798	2	\N	2	\N	\N	\N	399
799	\N	\N	\N	\N	\N	\N	400
800	\N	\N	\N	\N	\N	\N	400
801	1	1	0	\N	\N	\N	401
802	1	0	1	\N	\N	\N	401
803	3	1	2	\N	\N	\N	402
804	3	2	1	\N	\N	\N	402
805	0	\N	0	\N	\N	\N	403
806	1	\N	1	\N	\N	\N	403
807	\N	\N	\N	\N	\N	\N	404
808	\N	\N	\N	\N	\N	\N	404
809	3	1	2	\N	\N	\N	405
810	4	2	2	\N	\N	\N	405
811	3	1	2	\N	\N	\N	406
812	4	2	2	\N	\N	\N	406
813	1	\N	1	\N	\N	\N	407
814	0	\N	0	\N	\N	\N	407
815	\N	\N	\N	\N	\N	\N	408
816	\N	\N	\N	\N	\N	\N	408
817	2	2	0	\N	\N	\N	409
818	0	0	0	\N	\N	\N	409
819	1	0	1	\N	\N	\N	410
820	1	0	1	\N	\N	\N	410
821	2	\N	2	\N	\N	\N	411
822	2	\N	2	\N	\N	\N	411
823	\N	\N	\N	\N	\N	\N	412
824	\N	\N	\N	\N	\N	\N	412
825	4	2	2	\N	\N	\N	413
826	1	1	0	\N	\N	\N	413
827	2	2	0	\N	\N	\N	414
828	0	0	0	\N	\N	\N	414
829	1	\N	1	\N	\N	\N	415
830	1	\N	1	\N	\N	\N	415
831	\N	\N	\N	\N	\N	\N	416
832	\N	\N	\N	\N	\N	\N	416
833	2	0	2	\N	\N	\N	417
834	2	1	1	\N	\N	\N	417
835	1	0	1	\N	\N	\N	418
836	3	1	2	\N	\N	\N	418
837	2	\N	2	\N	\N	\N	419
838	0	\N	0	\N	\N	\N	419
839	\N	\N	\N	\N	\N	\N	420
840	\N	\N	\N	\N	\N	\N	420
841	4	2	2	\N	\N	\N	421
842	3	2	1	\N	\N	\N	421
843	2	1	1	\N	\N	\N	422
844	2	1	1	\N	\N	\N	422
845	1	\N	1	\N	\N	\N	423
846	0	\N	0	\N	\N	\N	423
847	\N	\N	\N	\N	\N	\N	424
848	\N	\N	\N	\N	\N	\N	424
849	0	0	0	\N	\N	\N	425
850	2	1	1	\N	\N	\N	425
851	0	0	0	\N	\N	\N	426
852	2	1	1	\N	\N	\N	426
853	0	\N	0	\N	\N	\N	427
854	2	\N	2	\N	\N	\N	427
855	\N	\N	\N	\N	\N	\N	428
856	\N	\N	\N	\N	\N	\N	428
857	2	0	2	\N	\N	\N	429
858	3	2	1	\N	\N	\N	429
859	2	2	0	\N	\N	\N	430
860	3	2	1	\N	\N	\N	430
861	0	\N	0	\N	\N	\N	431
862	1	\N	1	\N	\N	\N	431
863	\N	\N	\N	\N	\N	\N	432
864	\N	\N	\N	\N	\N	\N	432
865	3	1	2	\N	\N	\N	433
866	3	2	1	\N	\N	\N	433
867	3	1	2	\N	\N	\N	434
868	2	1	1	\N	\N	\N	434
869	2	\N	2	\N	\N	\N	435
870	2	\N	2	\N	\N	\N	435
871	\N	\N	\N	\N	\N	\N	436
872	\N	\N	\N	\N	\N	\N	436
873	4	2	2	\N	\N	\N	437
874	4	2	2	\N	\N	\N	437
875	2	1	1	\N	\N	\N	438
876	4	2	2	\N	\N	\N	438
877	0	\N	0	\N	\N	\N	439
878	0	\N	0	\N	\N	\N	439
879	\N	\N	\N	\N	\N	\N	440
880	\N	\N	\N	\N	\N	\N	440
881	2	0	2	\N	\N	\N	441
882	2	2	0	\N	\N	\N	441
883	2	1	1	\N	\N	\N	442
884	4	2	2	\N	\N	\N	442
885	\N	\N	\N	\N	\N	\N	443
886	\N	\N	\N	\N	\N	\N	443
887	\N	\N	\N	\N	\N	\N	444
888	\N	\N	\N	\N	\N	\N	444
889	3	2	1	\N	\N	\N	445
890	2	0	2	\N	\N	\N	445
891	1	0	1	\N	\N	\N	446
892	3	1	2	\N	\N	\N	446
893	\N	\N	\N	\N	\N	\N	447
894	\N	\N	\N	\N	\N	\N	447
895	\N	\N	\N	\N	\N	\N	448
896	\N	\N	\N	\N	\N	\N	448
897	3	1	2	\N	\N	\N	449
898	4	2	2	\N	\N	\N	449
899	0	0	0	\N	\N	\N	450
900	3	1	2	\N	\N	\N	450
901	\N	\N	\N	\N	\N	\N	451
902	\N	\N	\N	\N	\N	\N	451
903	\N	\N	\N	\N	\N	\N	452
904	\N	\N	\N	\N	\N	\N	452
905	3	1	2	\N	\N	\N	453
906	4	2	2	\N	\N	\N	453
907	3	2	1	\N	\N	\N	454
908	2	0	2	\N	\N	\N	454
909	\N	\N	\N	\N	\N	\N	455
910	\N	\N	\N	\N	\N	\N	455
911	\N	\N	\N	\N	\N	\N	456
912	\N	\N	\N	\N	\N	\N	456
913	4	2	2	\N	\N	\N	457
914	2	2	0	\N	\N	\N	457
915	2	1	1	\N	\N	\N	458
916	3	2	1	\N	\N	\N	458
917	\N	\N	\N	\N	\N	\N	459
918	\N	\N	\N	\N	\N	\N	459
919	\N	\N	\N	\N	\N	\N	460
920	\N	\N	\N	\N	\N	\N	460
921	0	0	0	\N	\N	\N	461
1287	\N	\N	\N	\N	\N	\N	644
922	3	2	1	\N	\N	\N	461
923	3	2	1	\N	\N	\N	462
924	2	0	2	\N	\N	\N	462
925	\N	\N	\N	\N	\N	\N	463
926	\N	\N	\N	\N	\N	\N	463
927	\N	\N	\N	\N	\N	\N	464
928	\N	\N	\N	\N	\N	\N	464
929	2	1	1	\N	\N	\N	465
930	2	2	0	\N	\N	\N	465
931	1	1	0	\N	\N	\N	466
932	4	2	2	\N	\N	\N	466
933	\N	\N	\N	\N	\N	\N	467
934	\N	\N	\N	\N	\N	\N	467
935	\N	\N	\N	\N	\N	\N	468
936	\N	\N	\N	\N	\N	\N	468
937	1	1	0	\N	\N	\N	469
938	2	2	0	\N	\N	\N	469
939	1	1	0	\N	\N	\N	470
940	1	0	1	\N	\N	\N	470
941	\N	\N	\N	\N	\N	\N	471
942	\N	\N	\N	\N	\N	\N	471
943	\N	\N	\N	\N	\N	\N	472
944	\N	\N	\N	\N	\N	\N	472
945	1	0	1	\N	\N	\N	473
946	2	1	1	\N	\N	\N	473
947	1	0	1	\N	\N	\N	474
948	2	0	2	\N	\N	\N	474
949	\N	\N	\N	\N	\N	\N	475
950	\N	\N	\N	\N	\N	\N	475
951	\N	\N	\N	\N	\N	\N	476
952	\N	\N	\N	\N	\N	\N	476
953	0	0	0	\N	\N	\N	477
954	1	0	1	\N	\N	\N	477
955	2	2	0	\N	\N	\N	478
956	3	1	2	\N	\N	\N	478
957	\N	\N	\N	\N	\N	\N	479
958	\N	\N	\N	\N	\N	\N	479
959	\N	\N	\N	\N	\N	\N	480
960	\N	\N	\N	\N	\N	\N	480
961	1	1	0	\N	\N	\N	481
962	2	0	2	\N	\N	\N	481
963	3	2	1	\N	\N	\N	482
964	1	1	0	\N	\N	\N	482
965	\N	\N	\N	\N	\N	\N	483
966	\N	\N	\N	\N	\N	\N	483
967	\N	\N	\N	\N	\N	\N	484
968	\N	\N	\N	\N	\N	\N	484
969	4	2	2	\N	\N	\N	485
970	1	0	1	\N	\N	\N	485
971	0	0	0	\N	\N	\N	486
972	4	2	2	\N	\N	\N	486
973	\N	\N	\N	\N	\N	\N	487
974	\N	\N	\N	\N	\N	\N	487
975	\N	\N	\N	\N	\N	\N	488
976	\N	\N	\N	\N	\N	\N	488
977	3	1	2	\N	\N	\N	489
978	3	2	1	\N	\N	\N	489
979	1	0	1	\N	\N	\N	490
980	2	0	2	\N	\N	\N	490
981	\N	\N	\N	\N	\N	\N	491
982	\N	\N	\N	\N	\N	\N	491
983	\N	\N	\N	\N	\N	\N	492
984	\N	\N	\N	\N	\N	\N	492
985	2	0	2	\N	\N	\N	493
986	2	0	2	\N	\N	\N	493
987	0	0	0	\N	\N	\N	494
988	2	1	1	\N	\N	\N	494
989	\N	\N	\N	\N	\N	\N	495
990	\N	\N	\N	\N	\N	\N	495
991	\N	\N	\N	\N	\N	\N	496
992	\N	\N	\N	\N	\N	\N	496
993	1	0	1	\N	\N	\N	497
994	0	0	0	\N	\N	\N	497
995	4	2	2	\N	\N	\N	498
996	2	2	0	\N	\N	\N	498
997	\N	\N	\N	\N	\N	\N	499
998	\N	\N	\N	\N	\N	\N	499
999	\N	\N	\N	\N	\N	\N	500
1000	\N	\N	\N	\N	\N	\N	500
1001	4	2	2	\N	\N	\N	501
1002	2	1	1	\N	\N	\N	501
1003	3	1	2	\N	\N	\N	502
1004	0	0	0	\N	\N	\N	502
1005	\N	\N	\N	\N	\N	\N	503
1006	\N	\N	\N	\N	\N	\N	503
1007	\N	\N	\N	\N	\N	\N	504
1008	\N	\N	\N	\N	\N	\N	504
1009	1	0	1	\N	\N	\N	505
1010	1	1	0	\N	\N	\N	505
1011	3	2	1	\N	\N	\N	506
1012	1	0	1	\N	\N	\N	506
1013	\N	\N	\N	\N	\N	\N	507
1014	\N	\N	\N	\N	\N	\N	507
1015	\N	\N	\N	\N	\N	\N	508
1016	\N	\N	\N	\N	\N	\N	508
1017	1	1	0	\N	\N	\N	509
1018	2	0	2	\N	\N	\N	509
1019	4	2	2	\N	\N	\N	510
1020	3	1	2	\N	\N	\N	510
1021	\N	\N	\N	\N	\N	\N	511
1022	\N	\N	\N	\N	\N	\N	511
1023	\N	\N	\N	\N	\N	\N	512
1024	\N	\N	\N	\N	\N	\N	512
1025	3	2	1	\N	\N	\N	513
1026	4	2	2	\N	\N	\N	513
1027	0	0	0	\N	\N	\N	514
1028	2	0	2	\N	\N	\N	514
1029	\N	\N	\N	\N	\N	\N	515
1030	\N	\N	\N	\N	\N	\N	515
1031	\N	\N	\N	\N	\N	\N	516
1032	\N	\N	\N	\N	\N	\N	516
1033	2	0	2	\N	\N	\N	517
1034	3	2	1	\N	\N	\N	517
1035	0	0	0	\N	\N	\N	518
1036	0	0	0	\N	\N	\N	518
1037	\N	\N	\N	\N	\N	\N	519
1038	\N	\N	\N	\N	\N	\N	519
1039	\N	\N	\N	\N	\N	\N	520
1040	\N	\N	\N	\N	\N	\N	520
1041	3	1	2	\N	\N	\N	521
1042	2	1	1	\N	\N	\N	521
1043	1	1	0	\N	\N	\N	522
1044	2	2	0	\N	\N	\N	522
1045	\N	\N	\N	\N	\N	\N	523
1046	\N	\N	\N	\N	\N	\N	523
1047	\N	\N	\N	\N	\N	\N	524
1048	\N	\N	\N	\N	\N	\N	524
1049	1	1	0	\N	\N	\N	525
1050	0	0	0	\N	\N	\N	525
1051	4	2	2	\N	\N	\N	526
1052	4	2	2	\N	\N	\N	526
1053	\N	\N	\N	\N	\N	\N	527
1054	\N	\N	\N	\N	\N	\N	527
1055	\N	\N	\N	\N	\N	\N	528
1056	\N	\N	\N	\N	\N	\N	528
1057	3	2	1	\N	\N	\N	529
1058	0	0	0	\N	\N	\N	529
1059	1	1	0	\N	\N	\N	530
1060	2	2	0	\N	\N	\N	530
1061	\N	\N	\N	\N	\N	\N	531
1062	\N	\N	\N	\N	\N	\N	531
1063	\N	\N	\N	\N	\N	\N	532
1064	\N	\N	\N	\N	\N	\N	532
1065	3	2	1	\N	\N	\N	533
1066	3	1	2	\N	\N	\N	533
1067	2	0	2	\N	\N	\N	534
1068	2	1	1	\N	\N	\N	534
1069	\N	\N	\N	\N	\N	\N	535
1070	\N	\N	\N	\N	\N	\N	535
1071	\N	\N	\N	\N	\N	\N	536
1072	\N	\N	\N	\N	\N	\N	536
1073	2	2	0	\N	\N	\N	537
1074	3	1	2	\N	\N	\N	537
1075	2	1	1	\N	\N	\N	538
1076	2	2	0	\N	\N	\N	538
1077	\N	\N	\N	\N	\N	\N	539
1078	\N	\N	\N	\N	\N	\N	539
1079	\N	\N	\N	\N	\N	\N	540
1080	\N	\N	\N	\N	\N	\N	540
1081	3	2	1	\N	\N	\N	541
1082	2	0	2	\N	\N	\N	541
1083	0	\N	0	\N	\N	\N	542
1084	2	\N	2	\N	\N	\N	542
1085	\N	\N	\N	\N	\N	\N	543
1086	\N	\N	\N	\N	\N	\N	543
1087	\N	\N	\N	\N	\N	\N	544
1088	\N	\N	\N	\N	\N	\N	544
1089	1	0	1	\N	\N	\N	545
1090	3	2	1	\N	\N	\N	545
1091	2	\N	2	\N	\N	\N	546
1092	0	\N	0	\N	\N	\N	546
1093	\N	\N	\N	\N	\N	\N	547
1094	\N	\N	\N	\N	\N	\N	547
1095	\N	\N	\N	\N	\N	\N	548
1096	\N	\N	\N	\N	\N	\N	548
1097	2	2	0	\N	\N	\N	549
1098	2	2	0	\N	\N	\N	549
1099	2	\N	2	\N	\N	\N	550
1100	1	\N	1	\N	\N	\N	550
1101	\N	\N	\N	\N	\N	\N	551
1102	\N	\N	\N	\N	\N	\N	551
1103	\N	\N	\N	\N	\N	\N	552
1104	\N	\N	\N	\N	\N	\N	552
1105	2	2	0	\N	\N	\N	553
1106	1	1	0	\N	\N	\N	553
1107	1	\N	1	\N	\N	\N	554
1108	0	\N	0	\N	\N	\N	554
1109	\N	\N	\N	\N	\N	\N	555
1110	\N	\N	\N	\N	\N	\N	555
1111	\N	\N	\N	\N	\N	\N	556
1112	\N	\N	\N	\N	\N	\N	556
1113	2	2	0	\N	\N	\N	557
1114	3	2	1	\N	\N	\N	557
1115	0	\N	0	\N	\N	\N	558
1116	1	\N	1	\N	\N	\N	558
1117	\N	\N	\N	\N	\N	\N	559
1118	\N	\N	\N	\N	\N	\N	559
1119	\N	\N	\N	\N	\N	\N	560
1120	\N	\N	\N	\N	\N	\N	560
1121	4	2	2	\N	\N	\N	561
1122	3	2	1	\N	\N	\N	561
1123	0	\N	0	\N	\N	\N	562
1124	0	\N	0	\N	\N	\N	562
1125	2	1	1	\N	\N	\N	563
1126	4	2	2	\N	\N	\N	563
1127	2	\N	2	\N	\N	\N	564
1128	1	\N	1	\N	\N	\N	564
1129	2	2	0	\N	\N	\N	565
1130	3	1	2	\N	\N	\N	565
1131	0	\N	0	\N	\N	\N	566
1132	0	\N	0	\N	\N	\N	566
1133	4	2	2	\N	\N	\N	567
1134	1	1	0	\N	\N	\N	567
1135	1	\N	1	\N	\N	\N	568
1136	2	\N	2	\N	\N	\N	568
1137	1	1	0	\N	\N	\N	569
1138	1	0	1	\N	\N	\N	569
1139	1	\N	1	\N	\N	\N	570
1140	0	\N	0	\N	\N	\N	570
1141	2	1	1	\N	\N	\N	571
1142	2	1	1	\N	\N	\N	571
1143	2	\N	2	\N	\N	\N	572
1144	0	\N	0	\N	\N	\N	572
1145	2	1	1	\N	\N	\N	573
1146	2	1	1	\N	\N	\N	573
1147	2	\N	2	\N	\N	\N	574
1148	0	\N	0	\N	\N	\N	574
1149	0	0	0	\N	\N	\N	575
1150	4	2	2	\N	\N	\N	575
1151	1	\N	1	\N	\N	\N	576
1152	1	\N	1	\N	\N	\N	576
1153	1	1	0	\N	\N	\N	577
1154	2	2	0	\N	\N	\N	577
1155	0	\N	0	\N	\N	\N	578
1156	1	\N	1	\N	\N	\N	578
1157	1	1	0	\N	\N	\N	579
1158	1	1	0	\N	\N	\N	579
1159	0	\N	0	\N	\N	\N	580
1160	0	\N	0	\N	\N	\N	580
1161	4	2	2	\N	\N	\N	581
1162	4	2	2	\N	\N	\N	581
1163	2	\N	2	\N	\N	\N	582
1164	1	\N	1	\N	\N	\N	582
1165	1	0	1	\N	\N	\N	583
1166	0	0	0	\N	\N	\N	583
1167	2	\N	2	\N	\N	\N	584
1168	2	\N	2	\N	\N	\N	584
1169	1	1	0	\N	\N	\N	585
1170	2	1	1	\N	\N	\N	585
1171	1	\N	1	\N	\N	\N	586
1172	1	\N	1	\N	\N	\N	586
1173	2	1	1	\N	\N	\N	587
1174	0	0	0	\N	\N	\N	587
1175	2	\N	2	\N	\N	\N	588
1176	1	\N	1	\N	\N	\N	588
1177	4	2	2	\N	\N	\N	589
1178	2	1	1	\N	\N	\N	589
1179	2	\N	2	\N	\N	\N	590
1180	0	\N	0	\N	\N	\N	590
1181	2	2	0	\N	\N	\N	591
1182	1	0	1	\N	\N	\N	591
1183	2	\N	2	\N	\N	\N	592
1184	2	\N	2	\N	\N	\N	592
1185	2	0	2	\N	\N	\N	593
1186	3	1	2	\N	\N	\N	593
1187	1	\N	1	\N	\N	\N	594
1188	0	\N	0	\N	\N	\N	594
1189	0	0	0	\N	\N	\N	595
1190	3	2	1	\N	\N	\N	595
1191	0	\N	0	\N	\N	\N	596
1192	0	\N	0	\N	\N	\N	596
1193	1	0	1	\N	\N	\N	597
1194	3	1	2	\N	\N	\N	597
1195	0	\N	0	\N	\N	\N	598
1196	0	\N	0	\N	\N	\N	598
1197	2	2	0	\N	\N	\N	599
1198	4	2	2	\N	\N	\N	599
1199	1	\N	1	\N	\N	\N	600
1200	1	\N	1	\N	\N	\N	600
1201	2	2	0	\N	\N	\N	601
1202	3	1	2	\N	\N	\N	601
1203	\N	\N	\N	\N	\N	\N	602
1204	\N	\N	\N	\N	\N	\N	602
1205	4	2	2	\N	\N	\N	603
1206	2	2	0	\N	\N	\N	603
1207	\N	\N	\N	\N	\N	\N	604
1208	\N	\N	\N	\N	\N	\N	604
1209	2	1	1	\N	\N	\N	605
1210	2	0	2	\N	\N	\N	605
1211	\N	\N	\N	\N	\N	\N	606
1212	\N	\N	\N	\N	\N	\N	606
1213	0	0	0	\N	\N	\N	607
1214	1	1	0	\N	\N	\N	607
1215	\N	\N	\N	\N	\N	\N	608
1216	\N	\N	\N	\N	\N	\N	608
1217	3	1	2	\N	\N	\N	609
1218	2	0	2	\N	\N	\N	609
1219	\N	\N	\N	\N	\N	\N	610
1220	\N	\N	\N	\N	\N	\N	610
1221	2	2	0	\N	\N	\N	611
1222	2	2	0	\N	\N	\N	611
1223	\N	\N	\N	\N	\N	\N	612
1224	\N	\N	\N	\N	\N	\N	612
1225	0	0	0	\N	\N	\N	613
1226	2	2	0	\N	\N	\N	613
1227	\N	\N	\N	\N	\N	\N	614
1228	\N	\N	\N	\N	\N	\N	614
1229	3	2	1	\N	\N	\N	615
1230	1	1	0	\N	\N	\N	615
1231	\N	\N	\N	\N	\N	\N	616
1232	\N	\N	\N	\N	\N	\N	616
1233	1	0	1	\N	\N	\N	617
1234	2	1	1	\N	\N	\N	617
1235	\N	\N	\N	\N	\N	\N	618
1236	\N	\N	\N	\N	\N	\N	618
1237	2	2	0	\N	\N	\N	619
1238	4	2	2	\N	\N	\N	619
1239	\N	\N	\N	\N	\N	\N	620
1240	\N	\N	\N	\N	\N	\N	620
1241	2	2	0	\N	\N	\N	621
1242	3	1	2	\N	\N	\N	621
1243	\N	\N	\N	\N	\N	\N	622
1244	\N	\N	\N	\N	\N	\N	622
1245	3	2	1	\N	\N	\N	623
1246	3	1	2	\N	\N	\N	623
1247	\N	\N	\N	\N	\N	\N	624
1248	\N	\N	\N	\N	\N	\N	624
1249	3	2	1	\N	\N	\N	625
1250	2	1	1	\N	\N	\N	625
1251	\N	\N	\N	\N	\N	\N	626
1252	\N	\N	\N	\N	\N	\N	626
1253	2	1	1	\N	\N	\N	627
1254	2	2	0	\N	\N	\N	627
1255	\N	\N	\N	\N	\N	\N	628
1256	\N	\N	\N	\N	\N	\N	628
1257	2	2	0	\N	\N	\N	629
1258	2	0	2	\N	\N	\N	629
1259	\N	\N	\N	\N	\N	\N	630
1260	\N	\N	\N	\N	\N	\N	630
1261	2	1	1	\N	\N	\N	631
1262	2	0	2	\N	\N	\N	631
1263	\N	\N	\N	\N	\N	\N	632
1264	\N	\N	\N	\N	\N	\N	632
1265	3	1	2	\N	\N	\N	633
1266	2	1	1	\N	\N	\N	633
1267	\N	\N	\N	\N	\N	\N	634
1268	\N	\N	\N	\N	\N	\N	634
1269	4	2	2	\N	\N	\N	635
1270	3	2	1	\N	\N	\N	635
1271	\N	\N	\N	\N	\N	\N	636
1272	\N	\N	\N	\N	\N	\N	636
1273	2	1	1	\N	\N	\N	637
1274	2	2	0	\N	\N	\N	637
1275	\N	\N	\N	\N	\N	\N	638
1276	\N	\N	\N	\N	\N	\N	638
1277	2	1	1	\N	\N	\N	639
1278	2	2	0	\N	\N	\N	639
1279	\N	\N	\N	\N	\N	\N	640
1280	\N	\N	\N	\N	\N	\N	640
1281	1	1	0	\N	\N	\N	641
1282	0	0	0	\N	\N	\N	641
1283	\N	\N	\N	\N	\N	\N	642
1284	\N	\N	\N	\N	\N	\N	642
1285	4	2	2	\N	\N	\N	643
1286	4	2	2	\N	\N	\N	643
1288	\N	\N	\N	\N	\N	\N	644
1289	2	1	1	\N	\N	\N	645
1290	2	0	2	\N	\N	\N	645
1291	\N	\N	\N	\N	\N	\N	646
1292	\N	\N	\N	\N	\N	\N	646
1293	2	2	0	\N	\N	\N	647
1294	1	0	1	\N	\N	\N	647
1295	\N	\N	\N	\N	\N	\N	648
1296	\N	\N	\N	\N	\N	\N	648
1297	1	0	1	\N	\N	\N	649
1298	1	0	1	\N	\N	\N	649
1299	\N	\N	\N	\N	\N	\N	650
1300	\N	\N	\N	\N	\N	\N	650
1301	3	2	1	\N	\N	\N	651
1302	1	0	1	\N	\N	\N	651
1303	\N	\N	\N	\N	\N	\N	652
1304	\N	\N	\N	\N	\N	\N	652
1305	3	1	2	\N	\N	\N	653
1306	3	1	2	\N	\N	\N	653
1307	\N	\N	\N	\N	\N	\N	654
1308	\N	\N	\N	\N	\N	\N	654
1309	1	1	0	\N	\N	\N	655
1310	0	0	0	\N	\N	\N	655
1311	\N	\N	\N	\N	\N	\N	656
1312	\N	\N	\N	\N	\N	\N	656
1313	4	2	2	\N	\N	\N	657
1314	2	2	0	\N	\N	\N	657
1315	\N	\N	\N	\N	\N	\N	658
1316	\N	\N	\N	\N	\N	\N	658
1317	3	2	1	\N	\N	\N	659
1318	2	1	1	\N	\N	\N	659
1319	\N	\N	\N	\N	\N	\N	660
1320	\N	\N	\N	\N	\N	\N	660
1321	2	0	2	\N	\N	\N	661
1322	1	0	1	\N	\N	\N	661
1323	\N	\N	\N	\N	\N	\N	662
1324	\N	\N	\N	\N	\N	\N	662
1325	2	1	1	\N	\N	\N	663
1326	0	0	0	\N	\N	\N	663
1327	\N	\N	\N	\N	\N	\N	664
1328	\N	\N	\N	\N	\N	\N	664
1329	2	1	1	\N	\N	\N	665
1330	3	1	2	\N	\N	\N	665
1331	\N	\N	\N	\N	\N	\N	666
1332	\N	\N	\N	\N	\N	\N	666
1333	0	0	0	\N	\N	\N	667
1334	2	2	0	\N	\N	\N	667
1335	\N	\N	\N	\N	\N	\N	668
1336	\N	\N	\N	\N	\N	\N	668
1337	3	1	2	\N	\N	\N	669
1338	2	1	1	\N	\N	\N	669
1339	\N	\N	\N	\N	\N	\N	670
1340	\N	\N	\N	\N	\N	\N	670
1341	2	1	1	\N	\N	\N	671
1342	1	1	0	\N	\N	\N	671
1343	\N	\N	\N	\N	\N	\N	672
1344	\N	\N	\N	\N	\N	\N	672
1345	0	0	0	\N	\N	\N	673
1346	1	1	0	\N	\N	\N	673
1347	\N	\N	\N	\N	\N	\N	674
1348	\N	\N	\N	\N	\N	\N	674
1349	2	0	2	\N	\N	\N	675
1350	3	1	2	\N	\N	\N	675
1351	\N	\N	\N	\N	\N	\N	676
1352	\N	\N	\N	\N	\N	\N	676
1353	1	1	0	\N	\N	\N	677
1354	3	1	2	\N	\N	\N	677
1355	\N	\N	\N	\N	\N	\N	678
1356	\N	\N	\N	\N	\N	\N	678
1357	3	2	1	\N	\N	\N	679
1358	1	0	1	\N	\N	\N	679
1359	\N	\N	\N	\N	\N	\N	680
1360	\N	\N	\N	\N	\N	\N	680
1361	4	2	2	\N	\N	\N	681
1362	1	0	1	\N	\N	\N	681
1363	\N	\N	\N	\N	\N	\N	682
1364	\N	\N	\N	\N	\N	\N	682
1365	1	1	0	\N	\N	\N	683
1366	1	0	1	\N	\N	\N	683
1367	\N	\N	\N	\N	\N	\N	684
1368	\N	\N	\N	\N	\N	\N	684
1369	2	2	0	\N	\N	\N	685
1370	1	1	0	\N	\N	\N	685
1371	\N	\N	\N	\N	\N	\N	686
1372	\N	\N	\N	\N	\N	\N	686
1373	2	0	2	\N	\N	\N	687
1374	2	0	2	\N	\N	\N	687
1375	\N	\N	\N	\N	\N	\N	688
1376	\N	\N	\N	\N	\N	\N	688
1377	1	1	0	\N	\N	\N	689
1378	3	2	1	\N	\N	\N	689
1379	\N	\N	\N	\N	\N	\N	690
1380	\N	\N	\N	\N	\N	\N	690
1381	2	1	1	\N	\N	\N	691
1382	3	1	2	\N	\N	\N	691
1383	\N	\N	\N	\N	\N	\N	692
1384	\N	\N	\N	\N	\N	\N	692
1385	3	1	2	\N	\N	\N	693
1386	0	0	0	\N	\N	\N	693
1387	\N	\N	\N	\N	\N	\N	694
1388	\N	\N	\N	\N	\N	\N	694
1389	2	0	2	\N	\N	\N	695
1390	1	1	0	\N	\N	\N	695
1391	\N	\N	\N	\N	\N	\N	696
1392	\N	\N	\N	\N	\N	\N	696
1393	2	0	2	\N	\N	\N	697
1394	2	1	1	\N	\N	\N	697
1395	\N	\N	\N	\N	\N	\N	698
1396	\N	\N	\N	\N	\N	\N	698
1397	4	2	2	\N	\N	\N	699
1398	1	1	0	\N	\N	\N	699
1399	\N	\N	\N	\N	\N	\N	700
1400	\N	\N	\N	\N	\N	\N	700
1401	1	1	0	\N	\N	\N	701
1402	4	2	2	\N	\N	\N	701
1403	\N	\N	\N	\N	\N	\N	702
1404	\N	\N	\N	\N	\N	\N	702
1405	3	2	1	\N	\N	\N	703
1406	1	0	1	\N	\N	\N	703
1407	\N	\N	\N	\N	\N	\N	704
1408	\N	\N	\N	\N	\N	\N	704
1409	2	1	1	\N	\N	\N	705
1410	1	1	0	\N	\N	\N	705
1411	\N	\N	\N	\N	\N	\N	706
1412	\N	\N	\N	\N	\N	\N	706
1413	2	2	0	\N	\N	\N	707
1414	0	0	0	\N	\N	\N	707
1415	\N	\N	\N	\N	\N	\N	708
1416	\N	\N	\N	\N	\N	\N	708
1417	1	0	1	\N	\N	\N	709
1418	4	2	2	\N	\N	\N	709
1419	\N	\N	\N	\N	\N	\N	710
1420	\N	\N	\N	\N	\N	\N	710
1421	1	0	1	\N	\N	\N	711
1422	2	0	2	\N	\N	\N	711
1423	\N	\N	\N	\N	\N	\N	712
1424	\N	\N	\N	\N	\N	\N	712
1425	1	0	1	\N	\N	\N	713
1426	4	2	2	\N	\N	\N	713
1427	\N	\N	\N	\N	\N	\N	714
1428	\N	\N	\N	\N	\N	\N	714
1429	2	1	1	\N	\N	\N	715
1430	2	0	2	\N	\N	\N	715
1431	\N	\N	\N	\N	\N	\N	716
1432	\N	\N	\N	\N	\N	\N	716
1433	2	0	2	\N	\N	\N	717
1434	3	1	2	\N	\N	\N	717
1435	\N	\N	\N	\N	\N	\N	718
1436	\N	\N	\N	\N	\N	\N	718
1437	3	2	1	\N	\N	\N	719
1438	2	2	0	\N	\N	\N	719
1439	\N	\N	\N	\N	\N	\N	720
1440	\N	\N	\N	\N	\N	\N	720
1441	2	0	2	\N	\N	\N	721
1442	3	2	1	\N	\N	\N	721
1443	\N	\N	\N	\N	\N	\N	722
1444	\N	\N	\N	\N	\N	\N	722
1445	0	0	0	\N	\N	\N	723
1446	1	1	0	\N	\N	\N	723
1447	\N	\N	\N	\N	\N	\N	724
1448	\N	\N	\N	\N	\N	\N	724
1449	1	1	0	\N	\N	\N	725
1450	4	2	2	\N	\N	\N	725
1451	\N	\N	\N	\N	\N	\N	726
1452	\N	\N	\N	\N	\N	\N	726
1453	1	1	0	\N	\N	\N	727
1454	0	0	0	\N	\N	\N	727
1455	\N	\N	\N	\N	\N	\N	728
1456	\N	\N	\N	\N	\N	\N	728
1457	2	1	1	\N	\N	\N	729
1458	3	2	1	\N	\N	\N	729
1459	\N	\N	\N	\N	\N	\N	730
1460	\N	\N	\N	\N	\N	\N	730
1461	2	0	2	\N	\N	\N	731
1462	2	2	0	\N	\N	\N	731
1463	\N	\N	\N	\N	\N	\N	732
1464	\N	\N	\N	\N	\N	\N	732
1465	2	0	2	\N	\N	\N	733
1466	0	0	0	\N	\N	\N	733
1467	\N	\N	\N	\N	\N	\N	734
1468	\N	\N	\N	\N	\N	\N	734
1469	2	1	1	\N	\N	\N	735
1470	4	2	2	\N	\N	\N	735
1471	\N	\N	\N	\N	\N	\N	736
1472	\N	\N	\N	\N	\N	\N	736
1848	\N	\N	\N	\N	\N	\N	924
1473	2	0	2	\N	\N	\N	737
1474	4	2	2	\N	\N	\N	737
1475	\N	\N	\N	\N	\N	\N	738
1476	\N	\N	\N	\N	\N	\N	738
1477	3	2	1	\N	\N	\N	739
1478	1	0	1	\N	\N	\N	739
1479	\N	\N	\N	\N	\N	\N	740
1480	\N	\N	\N	\N	\N	\N	740
1481	3	2	1	\N	\N	\N	741
1482	2	1	1	\N	\N	\N	741
1483	\N	\N	\N	\N	\N	\N	742
1484	\N	\N	\N	\N	\N	\N	742
1485	3	1	2	\N	\N	\N	743
1486	2	0	2	\N	\N	\N	743
1487	\N	\N	\N	\N	\N	\N	744
1488	\N	\N	\N	\N	\N	\N	744
1489	2	1	1	\N	\N	\N	745
1490	3	2	1	\N	\N	\N	745
1491	\N	\N	\N	\N	\N	\N	746
1492	\N	\N	\N	\N	\N	\N	746
1493	2	0	2	\N	\N	\N	747
1494	1	1	0	\N	\N	\N	747
1495	\N	\N	\N	\N	\N	\N	748
1496	\N	\N	\N	\N	\N	\N	748
1497	1	1	0	\N	\N	\N	749
1498	4	2	2	\N	\N	\N	749
1499	\N	\N	\N	\N	\N	\N	750
1500	\N	\N	\N	\N	\N	\N	750
1501	1	1	0	\N	\N	\N	751
1502	3	2	1	\N	\N	\N	751
1503	\N	\N	\N	\N	\N	\N	752
1504	\N	\N	\N	\N	\N	\N	752
1505	4	2	2	\N	\N	\N	753
1506	1	0	1	\N	\N	\N	753
1507	\N	\N	\N	\N	\N	\N	754
1508	\N	\N	\N	\N	\N	\N	754
1509	2	0	2	\N	\N	\N	755
1510	4	2	2	\N	\N	\N	755
1511	\N	\N	\N	\N	\N	\N	756
1512	\N	\N	\N	\N	\N	\N	756
1513	2	2	0	\N	\N	\N	757
1514	1	1	0	\N	\N	\N	757
1515	\N	\N	\N	\N	\N	\N	758
1516	\N	\N	\N	\N	\N	\N	758
1517	2	2	0	\N	\N	\N	759
1518	2	2	0	\N	\N	\N	759
1519	\N	\N	\N	\N	\N	\N	760
1520	\N	\N	\N	\N	\N	\N	760
1521	1	1	0	\N	\N	\N	761
1522	1	1	0	\N	\N	\N	761
1523	\N	\N	\N	\N	\N	\N	762
1524	\N	\N	\N	\N	\N	\N	762
1525	4	2	2	\N	\N	\N	763
1526	2	1	1	\N	\N	\N	763
1527	\N	\N	\N	\N	\N	\N	764
1528	\N	\N	\N	\N	\N	\N	764
1529	2	2	0	\N	\N	\N	765
1530	1	1	0	\N	\N	\N	765
1531	\N	\N	\N	\N	\N	\N	766
1532	\N	\N	\N	\N	\N	\N	766
1533	1	1	0	\N	\N	\N	767
1534	2	0	2	\N	\N	\N	767
1535	\N	\N	\N	\N	\N	\N	768
1536	\N	\N	\N	\N	\N	\N	768
1537	2	2	0	\N	\N	\N	769
1538	1	1	0	\N	\N	\N	769
1539	\N	\N	\N	\N	\N	\N	770
1540	\N	\N	\N	\N	\N	\N	770
1541	1	0	1	\N	\N	\N	771
1542	4	2	2	\N	\N	\N	771
1543	\N	\N	\N	\N	\N	\N	772
1544	\N	\N	\N	\N	\N	\N	772
1545	0	0	0	\N	\N	\N	773
1546	0	0	0	\N	\N	\N	773
1547	\N	\N	\N	\N	\N	\N	774
1548	\N	\N	\N	\N	\N	\N	774
1549	3	2	1	\N	\N	\N	775
1550	2	2	0	\N	\N	\N	775
1551	\N	\N	\N	\N	\N	\N	776
1552	\N	\N	\N	\N	\N	\N	776
1553	3	1	2	\N	\N	\N	777
1554	3	1	2	\N	\N	\N	777
1555	\N	\N	\N	\N	\N	\N	778
1556	\N	\N	\N	\N	\N	\N	778
1557	3	1	2	\N	\N	\N	779
1558	1	1	0	\N	\N	\N	779
1559	\N	\N	\N	\N	\N	\N	780
1560	\N	\N	\N	\N	\N	\N	780
1561	2	2	0	\N	\N	\N	781
1562	3	1	2	\N	\N	\N	781
1563	\N	\N	\N	\N	\N	\N	782
1564	\N	\N	\N	\N	\N	\N	782
1565	3	1	2	\N	\N	\N	783
1566	3	2	1	\N	\N	\N	783
1567	\N	\N	\N	\N	\N	\N	784
1568	\N	\N	\N	\N	\N	\N	784
1569	2	2	0	\N	\N	\N	785
1570	1	0	1	\N	\N	\N	785
1571	\N	\N	\N	\N	\N	\N	786
1572	\N	\N	\N	\N	\N	\N	786
1573	3	1	2	\N	\N	\N	787
1574	1	1	0	\N	\N	\N	787
1575	\N	\N	\N	\N	\N	\N	788
1576	\N	\N	\N	\N	\N	\N	788
1577	4	2	2	\N	\N	\N	789
1578	3	1	2	\N	\N	\N	789
1579	\N	\N	\N	\N	\N	\N	790
1580	\N	\N	\N	\N	\N	\N	790
1581	2	2	0	\N	\N	\N	791
1582	4	2	2	\N	\N	\N	791
1583	\N	\N	\N	\N	\N	\N	792
1584	\N	\N	\N	\N	\N	\N	792
1585	3	1	2	\N	\N	\N	793
1586	2	0	2	\N	\N	\N	793
1587	\N	\N	\N	\N	\N	\N	794
1588	\N	\N	\N	\N	\N	\N	794
1589	2	2	0	\N	\N	\N	795
1590	2	2	0	\N	\N	\N	795
1591	\N	\N	\N	\N	\N	\N	796
1592	\N	\N	\N	\N	\N	\N	796
1593	2	2	0	\N	\N	\N	797
1594	2	0	2	\N	\N	\N	797
1595	\N	\N	\N	\N	\N	\N	798
1596	\N	\N	\N	\N	\N	\N	798
1597	4	2	2	\N	\N	\N	799
1598	3	2	1	\N	\N	\N	799
1599	\N	\N	\N	\N	\N	\N	800
1600	\N	\N	\N	\N	\N	\N	800
1601	1	1	0	\N	\N	\N	801
1602	4	2	2	\N	\N	\N	801
1603	\N	\N	\N	\N	\N	\N	802
1604	\N	\N	\N	\N	\N	\N	802
1605	2	0	2	\N	\N	\N	803
1606	1	0	1	\N	\N	\N	803
1607	\N	\N	\N	\N	\N	\N	804
1608	\N	\N	\N	\N	\N	\N	804
1609	1	0	1	\N	\N	\N	805
1610	1	0	1	\N	\N	\N	805
1611	\N	\N	\N	\N	\N	\N	806
1612	\N	\N	\N	\N	\N	\N	806
1613	0	0	0	\N	\N	\N	807
1614	4	2	2	\N	\N	\N	807
1615	\N	\N	\N	\N	\N	\N	808
1616	\N	\N	\N	\N	\N	\N	808
1617	3	1	2	\N	\N	\N	809
1618	2	0	2	\N	\N	\N	809
1619	\N	\N	\N	\N	\N	\N	810
1620	\N	\N	\N	\N	\N	\N	810
1621	3	2	1	\N	\N	\N	811
1622	3	2	1	\N	\N	\N	811
1623	\N	\N	\N	\N	\N	\N	812
1624	\N	\N	\N	\N	\N	\N	812
1625	2	1	1	\N	\N	\N	813
1626	2	2	0	\N	\N	\N	813
1627	\N	\N	\N	\N	\N	\N	814
1628	\N	\N	\N	\N	\N	\N	814
1629	1	0	1	\N	\N	\N	815
1630	2	2	0	\N	\N	\N	815
1631	\N	\N	\N	\N	\N	\N	816
1632	\N	\N	\N	\N	\N	\N	816
1633	3	1	2	\N	\N	\N	817
1634	0	0	0	\N	\N	\N	817
1635	\N	\N	\N	\N	\N	\N	818
1636	\N	\N	\N	\N	\N	\N	818
1637	3	2	1	\N	\N	\N	819
1638	0	0	0	\N	\N	\N	819
1639	\N	\N	\N	\N	\N	\N	820
1640	\N	\N	\N	\N	\N	\N	820
1641	3	2	1	\N	\N	\N	821
1642	1	1	0	\N	\N	\N	821
1643	\N	\N	\N	\N	\N	\N	822
1644	\N	\N	\N	\N	\N	\N	822
1645	0	0	0	\N	\N	\N	823
1646	2	0	2	\N	\N	\N	823
1647	\N	\N	\N	\N	\N	\N	824
1648	\N	\N	\N	\N	\N	\N	824
1649	1	0	1	\N	\N	\N	825
1650	0	0	0	\N	\N	\N	825
1651	\N	\N	\N	\N	\N	\N	826
1652	\N	\N	\N	\N	\N	\N	826
1653	2	1	1	\N	\N	\N	827
1654	2	2	0	\N	\N	\N	827
1655	\N	\N	\N	\N	\N	\N	828
1656	\N	\N	\N	\N	\N	\N	828
1657	3	2	1	\N	\N	\N	829
1658	3	1	2	\N	\N	\N	829
1659	\N	\N	\N	\N	\N	\N	830
1660	\N	\N	\N	\N	\N	\N	830
1661	1	1	0	\N	\N	\N	831
1662	3	1	2	\N	\N	\N	831
1663	\N	\N	\N	\N	\N	\N	832
1664	\N	\N	\N	\N	\N	\N	832
1665	2	2	0	\N	\N	\N	833
1666	3	2	1	\N	\N	\N	833
1667	\N	\N	\N	\N	\N	\N	834
1668	\N	\N	\N	\N	\N	\N	834
1669	1	0	1	\N	\N	\N	835
1670	2	2	0	\N	\N	\N	835
1671	\N	\N	\N	\N	\N	\N	836
1672	\N	\N	\N	\N	\N	\N	836
1673	4	2	2	\N	\N	\N	837
1674	4	2	2	\N	\N	\N	837
1675	\N	\N	\N	\N	\N	\N	838
1676	\N	\N	\N	\N	\N	\N	838
1677	3	1	2	\N	\N	\N	839
1678	3	2	1	\N	\N	\N	839
1679	\N	\N	\N	\N	\N	\N	840
1680	\N	\N	\N	\N	\N	\N	840
1681	2	0	2	\N	\N	\N	841
1682	2	1	1	\N	\N	\N	841
1683	\N	\N	\N	\N	\N	\N	842
1684	\N	\N	\N	\N	\N	\N	842
1685	0	0	0	\N	\N	\N	843
1686	0	0	0	\N	\N	\N	843
1687	\N	\N	\N	\N	\N	\N	844
1688	\N	\N	\N	\N	\N	\N	844
1689	2	2	0	\N	\N	\N	845
1690	2	1	1	\N	\N	\N	845
1691	\N	\N	\N	\N	\N	\N	846
1692	\N	\N	\N	\N	\N	\N	846
1693	4	2	2	\N	\N	\N	847
1694	2	1	1	\N	\N	\N	847
1695	\N	\N	\N	\N	\N	\N	848
1696	\N	\N	\N	\N	\N	\N	848
1697	1	0	1	\N	\N	\N	849
1698	1	1	0	\N	\N	\N	849
1699	\N	\N	\N	\N	\N	\N	850
1700	\N	\N	\N	\N	\N	\N	850
1701	0	0	0	\N	\N	\N	851
1702	4	2	2	\N	\N	\N	851
1703	\N	\N	\N	\N	\N	\N	852
1704	\N	\N	\N	\N	\N	\N	852
1705	3	2	1	\N	\N	\N	853
1706	1	0	1	\N	\N	\N	853
1707	\N	\N	\N	\N	\N	\N	854
1708	\N	\N	\N	\N	\N	\N	854
1709	3	2	1	\N	\N	\N	855
1710	0	0	0	\N	\N	\N	855
1711	\N	\N	\N	\N	\N	\N	856
1712	\N	\N	\N	\N	\N	\N	856
1713	2	1	1	\N	\N	\N	857
1714	1	0	1	\N	\N	\N	857
1715	\N	\N	\N	\N	\N	\N	858
1716	\N	\N	\N	\N	\N	\N	858
1717	1	0	1	\N	\N	\N	859
1718	4	2	2	\N	\N	\N	859
1719	\N	\N	\N	\N	\N	\N	860
1720	\N	\N	\N	\N	\N	\N	860
1721	2	2	0	\N	\N	\N	861
1722	4	2	2	\N	\N	\N	861
1723	\N	\N	\N	\N	\N	\N	862
1724	\N	\N	\N	\N	\N	\N	862
1725	3	1	2	\N	\N	\N	863
1726	2	1	1	\N	\N	\N	863
1727	\N	\N	\N	\N	\N	\N	864
1728	\N	\N	\N	\N	\N	\N	864
1729	2	2	0	\N	\N	\N	865
1730	1	1	0	\N	\N	\N	865
1731	\N	\N	\N	\N	\N	\N	866
1732	\N	\N	\N	\N	\N	\N	866
1733	1	0	1	\N	\N	\N	867
1734	1	1	0	\N	\N	\N	867
1735	\N	\N	\N	\N	\N	\N	868
1736	\N	\N	\N	\N	\N	\N	868
1737	3	1	2	\N	\N	\N	869
1738	3	1	2	\N	\N	\N	869
1739	\N	\N	\N	\N	\N	\N	870
1740	\N	\N	\N	\N	\N	\N	870
1741	3	2	1	\N	\N	\N	871
1742	2	2	0	\N	\N	\N	871
1743	\N	\N	\N	\N	\N	\N	872
1744	\N	\N	\N	\N	\N	\N	872
1745	3	1	2	\N	\N	\N	873
1746	1	0	1	\N	\N	\N	873
1747	\N	\N	\N	\N	\N	\N	874
1748	\N	\N	\N	\N	\N	\N	874
1749	3	2	1	\N	\N	\N	875
1750	1	0	1	\N	\N	\N	875
1751	\N	\N	\N	\N	\N	\N	876
1752	\N	\N	\N	\N	\N	\N	876
1753	3	1	2	\N	\N	\N	877
1754	3	2	1	\N	\N	\N	877
1755	\N	\N	\N	\N	\N	\N	878
1756	\N	\N	\N	\N	\N	\N	878
1757	2	0	2	\N	\N	\N	879
1758	1	1	0	\N	\N	\N	879
1759	\N	\N	\N	\N	\N	\N	880
1760	\N	\N	\N	\N	\N	\N	880
1761	2	0	2	\N	\N	\N	881
1762	4	2	2	\N	\N	\N	881
1763	\N	\N	\N	\N	\N	\N	882
1764	\N	\N	\N	\N	\N	\N	882
1765	2	1	1	\N	\N	\N	883
1766	3	1	2	\N	\N	\N	883
1767	\N	\N	\N	\N	\N	\N	884
1768	\N	\N	\N	\N	\N	\N	884
1769	4	2	2	\N	\N	\N	885
1770	2	2	0	\N	\N	\N	885
1771	\N	\N	\N	\N	\N	\N	886
1772	\N	\N	\N	\N	\N	\N	886
1773	0	0	0	\N	\N	\N	887
1774	0	0	0	\N	\N	\N	887
1775	\N	\N	\N	\N	\N	\N	888
1776	\N	\N	\N	\N	\N	\N	888
1777	3	2	1	\N	\N	\N	889
1778	3	2	1	\N	\N	\N	889
1779	\N	\N	\N	\N	\N	\N	890
1780	\N	\N	\N	\N	\N	\N	890
1781	0	0	0	\N	\N	\N	891
1782	0	0	0	\N	\N	\N	891
1783	\N	\N	\N	\N	\N	\N	892
1784	\N	\N	\N	\N	\N	\N	892
1785	3	1	2	\N	\N	\N	893
1786	2	1	1	\N	\N	\N	893
1787	\N	\N	\N	\N	\N	\N	894
1788	\N	\N	\N	\N	\N	\N	894
1789	2	2	0	\N	\N	\N	895
1790	0	0	0	\N	\N	\N	895
1791	\N	\N	\N	\N	\N	\N	896
1792	\N	\N	\N	\N	\N	\N	896
1793	2	2	0	\N	\N	\N	897
1794	3	2	1	\N	\N	\N	897
1795	\N	\N	\N	\N	\N	\N	898
1796	\N	\N	\N	\N	\N	\N	898
1797	4	2	2	\N	\N	\N	899
1798	0	0	0	\N	\N	\N	899
1799	\N	\N	\N	\N	\N	\N	900
1800	\N	\N	\N	\N	\N	\N	900
1801	1	\N	1	\N	\N	\N	901
1802	1	\N	1	\N	\N	\N	901
1803	\N	\N	\N	\N	\N	\N	902
1804	\N	\N	\N	\N	\N	\N	902
1805	0	\N	0	\N	\N	\N	903
1806	0	\N	0	\N	\N	\N	903
1807	\N	\N	\N	\N	\N	\N	904
1808	\N	\N	\N	\N	\N	\N	904
1809	0	\N	0	\N	\N	\N	905
1810	0	\N	0	\N	\N	\N	905
1811	\N	\N	\N	\N	\N	\N	906
1812	\N	\N	\N	\N	\N	\N	906
1813	2	\N	2	\N	\N	\N	907
1814	2	\N	2	\N	\N	\N	907
1815	\N	\N	\N	\N	\N	\N	908
1816	\N	\N	\N	\N	\N	\N	908
1817	0	\N	0	\N	\N	\N	909
1818	1	\N	1	\N	\N	\N	909
1819	\N	\N	\N	\N	\N	\N	910
1820	\N	\N	\N	\N	\N	\N	910
1821	1	\N	1	\N	\N	\N	911
1822	2	\N	2	\N	\N	\N	911
1823	\N	\N	\N	\N	\N	\N	912
1824	\N	\N	\N	\N	\N	\N	912
1825	1	\N	1	\N	\N	\N	913
1826	2	\N	2	\N	\N	\N	913
1827	\N	\N	\N	\N	\N	\N	914
1828	\N	\N	\N	\N	\N	\N	914
1829	0	\N	0	\N	\N	\N	915
1830	2	\N	2	\N	\N	\N	915
1831	\N	\N	\N	\N	\N	\N	916
1832	\N	\N	\N	\N	\N	\N	916
1833	0	\N	0	\N	\N	\N	917
1834	0	\N	0	\N	\N	\N	917
1835	\N	\N	\N	\N	\N	\N	918
1836	\N	\N	\N	\N	\N	\N	918
1837	2	\N	2	\N	\N	\N	919
1838	0	\N	0	\N	\N	\N	919
1839	\N	\N	\N	\N	\N	\N	920
1840	\N	\N	\N	\N	\N	\N	920
1841	1	\N	1	\N	\N	\N	921
1842	0	\N	0	\N	\N	\N	921
1843	\N	\N	\N	\N	\N	\N	922
1844	\N	\N	\N	\N	\N	\N	922
1845	2	\N	2	\N	\N	\N	923
1846	2	\N	2	\N	\N	\N	923
1847	\N	\N	\N	\N	\N	\N	924
1849	1	\N	1	\N	\N	\N	925
1850	0	\N	0	\N	\N	\N	925
1851	\N	\N	\N	\N	\N	\N	926
1852	\N	\N	\N	\N	\N	\N	926
1853	2	\N	2	\N	\N	\N	927
1854	0	\N	0	\N	\N	\N	927
1855	\N	\N	\N	\N	\N	\N	928
1856	\N	\N	\N	\N	\N	\N	928
1857	1	\N	1	\N	\N	\N	929
1858	1	\N	1	\N	\N	\N	929
1859	\N	\N	\N	\N	\N	\N	930
1860	\N	\N	\N	\N	\N	\N	930
1861	1	\N	1	\N	\N	\N	931
1862	2	\N	2	\N	\N	\N	931
1863	\N	\N	\N	\N	\N	\N	932
1864	\N	\N	\N	\N	\N	\N	932
1865	1	\N	1	\N	\N	\N	933
1866	0	\N	0	\N	\N	\N	933
1867	\N	\N	\N	\N	\N	\N	934
1868	\N	\N	\N	\N	\N	\N	934
1869	2	\N	2	\N	\N	\N	935
1870	2	\N	2	\N	\N	\N	935
1871	\N	\N	\N	\N	\N	\N	936
1872	\N	\N	\N	\N	\N	\N	936
1873	2	\N	2	\N	\N	\N	937
1874	0	\N	0	\N	\N	\N	937
1875	\N	\N	\N	\N	\N	\N	938
1876	\N	\N	\N	\N	\N	\N	938
1877	0	\N	0	\N	\N	\N	939
1878	1	\N	1	\N	\N	\N	939
1879	\N	\N	\N	\N	\N	\N	940
1880	\N	\N	\N	\N	\N	\N	940
1881	95	27	29	18	21	\N	941
1882	88	30	20	15	23	\N	941
1883	\N	\N	\N	\N	\N	\N	942
1884	\N	\N	\N	\N	\N	\N	942
1885	102	26	25	22	29	\N	943
1886	97	22	28	20	27	\N	943
1887	\N	\N	\N	\N	\N	\N	944
1888	\N	\N	\N	\N	\N	\N	944
1889	95	28	29	22	16	\N	945
1890	78	26	18	18	16	\N	945
1891	\N	\N	\N	\N	\N	\N	946
1892	\N	\N	\N	\N	\N	\N	946
1893	73	15	18	19	21	\N	947
1894	87	29	21	21	16	\N	947
1895	\N	\N	\N	\N	\N	\N	948
1896	\N	\N	\N	\N	\N	\N	948
1897	81	26	21	15	19	\N	949
1898	87	15	21	26	25	\N	949
1899	\N	\N	\N	\N	\N	\N	950
1900	\N	\N	\N	\N	\N	\N	950
1901	91	19	16	27	29	\N	951
1902	85	25	16	16	28	\N	951
1903	\N	\N	\N	\N	\N	\N	952
1904	\N	\N	\N	\N	\N	\N	952
1905	80	18	27	18	17	\N	953
1906	93	24	27	22	20	\N	953
1907	\N	\N	\N	\N	\N	\N	954
1908	\N	\N	\N	\N	\N	\N	954
1909	94	25	25	18	26	\N	955
1910	88	21	17	28	22	\N	955
1911	\N	\N	\N	\N	\N	\N	956
1912	\N	\N	\N	\N	\N	\N	956
1913	93	28	26	24	15	\N	957
1914	103	27	20	28	28	\N	957
1915	\N	\N	\N	\N	\N	\N	958
1916	\N	\N	\N	\N	\N	\N	958
1917	96	29	27	19	21	\N	959
1918	94	23	22	23	26	\N	959
1919	\N	\N	\N	\N	\N	\N	960
1920	\N	\N	\N	\N	\N	\N	960
1921	94	18	20	26	30	\N	961
1922	95	25	30	20	20	\N	961
1923	\N	\N	\N	\N	\N	\N	962
1924	\N	\N	\N	\N	\N	\N	962
1925	68	16	19	18	15	\N	963
1926	98	22	25	26	25	\N	963
1927	\N	\N	\N	\N	\N	\N	964
1928	\N	\N	\N	\N	\N	\N	964
1929	91	28	19	18	26	\N	965
1930	92	25	20	17	30	\N	965
1931	\N	\N	\N	\N	\N	\N	966
1932	\N	\N	\N	\N	\N	\N	966
1933	85	22	18	20	25	\N	967
1934	90	17	29	21	23	\N	967
1935	\N	\N	\N	\N	\N	\N	968
1936	\N	\N	\N	\N	\N	\N	968
1937	89	23	19	17	30	\N	969
1938	84	25	23	17	19	\N	969
1939	\N	\N	\N	\N	\N	\N	970
1940	\N	\N	\N	\N	\N	\N	970
1941	91	23	28	16	24	\N	971
1942	101	30	23	28	20	\N	971
1943	\N	\N	\N	\N	\N	\N	972
1944	\N	\N	\N	\N	\N	\N	972
1945	105	26	23	29	27	\N	973
1946	92	15	20	29	28	\N	973
1947	\N	\N	\N	\N	\N	\N	974
1948	\N	\N	\N	\N	\N	\N	974
1949	80	21	21	17	21	\N	975
1950	84	22	25	18	19	\N	975
1951	\N	\N	\N	\N	\N	\N	976
1952	\N	\N	\N	\N	\N	\N	976
1953	72	18	17	20	17	\N	977
1954	93	26	15	22	30	\N	977
1955	\N	\N	\N	\N	\N	\N	978
1956	\N	\N	\N	\N	\N	\N	978
1957	83	24	16	18	25	\N	979
1958	90	16	29	24	21	\N	979
1959	\N	\N	\N	\N	\N	\N	980
1960	\N	\N	\N	\N	\N	\N	980
1961	74	18	19	22	15	\N	981
1962	99	29	22	22	26	\N	981
1963	\N	\N	\N	\N	\N	\N	982
1964	\N	\N	\N	\N	\N	\N	982
1965	99	28	21	28	22	\N	983
1966	92	29	18	26	19	\N	983
1967	\N	\N	\N	\N	\N	\N	984
1968	\N	\N	\N	\N	\N	\N	984
1969	91	25	15	29	22	\N	985
1970	89	23	18	21	27	\N	985
1971	\N	\N	\N	\N	\N	\N	986
1972	\N	\N	\N	\N	\N	\N	986
1973	97	28	25	15	29	\N	987
1974	90	24	21	24	21	\N	987
1975	\N	\N	\N	\N	\N	\N	988
1976	\N	\N	\N	\N	\N	\N	988
1977	91	22	21	21	27	\N	989
1978	78	25	21	16	16	\N	989
1979	\N	\N	\N	\N	\N	\N	990
1980	\N	\N	\N	\N	\N	\N	990
1981	95	28	29	20	18	\N	991
1982	88	28	17	25	18	\N	991
1983	\N	\N	\N	\N	\N	\N	992
1984	\N	\N	\N	\N	\N	\N	992
1985	99	26	17	30	26	\N	993
1986	88	18	21	26	23	\N	993
1987	\N	\N	\N	\N	\N	\N	994
1988	\N	\N	\N	\N	\N	\N	994
1989	93	25	21	19	28	\N	995
1990	91	17	18	29	27	\N	995
1991	\N	\N	\N	\N	\N	\N	996
1992	\N	\N	\N	\N	\N	\N	996
1993	101	23	29	19	30	\N	997
1994	83	19	22	19	23	\N	997
1995	\N	\N	\N	\N	\N	\N	998
1996	\N	\N	\N	\N	\N	\N	998
1997	103	25	28	26	24	\N	999
1998	88	15	23	20	30	\N	999
1999	\N	\N	\N	\N	\N	\N	1000
2000	\N	\N	\N	\N	\N	\N	1000
2001	107	30	22	27	28	\N	1001
2002	77	25	19	17	16	\N	1001
2003	\N	\N	\N	\N	\N	\N	1002
2004	\N	\N	\N	\N	\N	\N	1002
2005	85	29	17	22	17	\N	1003
2006	84	17	30	16	21	\N	1003
2007	\N	\N	\N	\N	\N	\N	1004
2008	\N	\N	\N	\N	\N	\N	1004
2009	111	24	28	30	29	\N	1005
2010	92	21	25	29	17	\N	1005
2011	\N	\N	\N	\N	\N	\N	1006
2012	\N	\N	\N	\N	\N	\N	1006
2013	108	25	28	29	26	\N	1007
2014	89	27	22	18	22	\N	1007
2015	\N	\N	\N	\N	\N	\N	1008
2016	\N	\N	\N	\N	\N	\N	1008
2017	78	25	15	22	16	\N	1009
2018	97	29	18	30	20	\N	1009
2019	\N	\N	\N	\N	\N	\N	1010
2020	\N	\N	\N	\N	\N	\N	1010
2021	109	24	29	28	28	\N	1011
2022	84	15	22	24	23	\N	1011
2023	\N	\N	\N	\N	\N	\N	1012
2024	\N	\N	\N	\N	\N	\N	1012
2025	92	26	18	20	28	\N	1013
2026	97	30	23	20	24	\N	1013
2027	\N	\N	\N	\N	\N	\N	1014
2028	\N	\N	\N	\N	\N	\N	1014
2029	70	17	15	21	17	\N	1015
2030	108	28	25	26	29	\N	1015
2031	\N	\N	\N	\N	\N	\N	1016
2032	\N	\N	\N	\N	\N	\N	1016
2033	101	29	25	22	25	\N	1017
2034	79	16	15	18	30	\N	1017
2035	\N	\N	\N	\N	\N	\N	1018
2036	\N	\N	\N	\N	\N	\N	1018
2037	105	23	29	22	21	10	1019
2038	104	22	18	26	29	9	1019
2039	\N	\N	\N	\N	\N	\N	1020
2040	\N	\N	\N	\N	\N	\N	1020
2041	86	21	19	19	27	\N	1021
2042	79	21	17	18	23	\N	1021
2043	\N	\N	\N	\N	\N	\N	1022
2044	\N	\N	\N	\N	\N	\N	1022
2045	92	27	26	22	17	\N	1023
2046	83	18	16	19	30	\N	1023
2047	\N	\N	\N	\N	\N	\N	1024
2048	\N	\N	\N	\N	\N	\N	1024
2049	86	20	25	22	19	\N	1025
2050	77	25	22	15	15	\N	1025
2051	\N	\N	\N	\N	\N	\N	1026
2052	\N	\N	\N	\N	\N	\N	1026
2053	74	20	15	23	16	\N	1027
2054	76	23	21	17	15	\N	1027
2055	\N	\N	\N	\N	\N	\N	1028
2056	\N	\N	\N	\N	\N	\N	1028
2057	103	29	30	25	19	\N	1029
2058	77	15	17	29	16	\N	1029
2059	\N	\N	\N	\N	\N	\N	1030
2060	\N	\N	\N	\N	\N	\N	1030
2061	105	28	30	27	18	2	1031
2062	112	29	22	25	27	9	1031
2063	\N	\N	\N	\N	\N	\N	1032
2064	\N	\N	\N	\N	\N	\N	1032
2065	98	24	25	24	25	\N	1033
2066	111	27	27	29	28	\N	1033
2067	\N	\N	\N	\N	\N	\N	1034
2068	\N	\N	\N	\N	\N	\N	1034
2069	61	15	15	16	15	\N	1035
2070	98	23	26	20	29	\N	1035
2071	\N	\N	\N	\N	\N	\N	1036
2072	\N	\N	\N	\N	\N	\N	1036
2073	103	19	30	25	29	\N	1037
2074	112	28	30	28	26	\N	1037
2075	\N	\N	\N	\N	\N	\N	1038
2076	\N	\N	\N	\N	\N	\N	1038
2077	83	16	20	22	25	\N	1039
2078	86	22	18	28	18	\N	1039
2079	\N	\N	\N	\N	\N	\N	1040
2080	\N	\N	\N	\N	\N	\N	1040
2081	108	29	22	29	28	\N	1041
2082	96	27	29	18	22	\N	1041
2083	\N	\N	\N	\N	\N	\N	1042
2084	\N	\N	\N	\N	\N	\N	1042
2085	99	27	24	28	20	\N	1043
2086	84	21	20	18	25	\N	1043
2087	\N	\N	\N	\N	\N	\N	1044
2088	\N	\N	\N	\N	\N	\N	1044
2089	84	20	23	18	23	\N	1045
2090	91	29	16	21	25	\N	1045
2091	\N	\N	\N	\N	\N	\N	1046
2092	\N	\N	\N	\N	\N	\N	1046
2093	85	22	20	23	20	\N	1047
2094	83	19	24	19	21	\N	1047
2095	\N	\N	\N	\N	\N	\N	1048
2096	\N	\N	\N	\N	\N	\N	1048
2097	78	16	16	18	28	\N	1049
2098	97	18	20	30	29	\N	1049
2099	\N	\N	\N	\N	\N	\N	1050
2100	\N	\N	\N	\N	\N	\N	1050
2101	99	29	24	25	21	\N	1051
2102	86	18	23	26	19	\N	1051
2103	\N	\N	\N	\N	\N	\N	1052
2104	\N	\N	\N	\N	\N	\N	1052
2105	89	19	19	23	28	\N	1053
2106	78	19	22	20	17	\N	1053
2107	\N	\N	\N	\N	\N	\N	1054
2108	\N	\N	\N	\N	\N	\N	1054
2109	85	22	29	16	18	\N	1055
2110	83	24	18	20	21	\N	1055
2111	\N	\N	\N	\N	\N	\N	1056
2112	\N	\N	\N	\N	\N	\N	1056
2113	93	18	18	27	30	\N	1057
2114	105	26	25	29	25	\N	1057
2115	\N	\N	\N	\N	\N	\N	1058
2116	\N	\N	\N	\N	\N	\N	1058
2117	104	27	25	30	22	\N	1059
2118	101	22	25	28	26	\N	1059
2119	\N	\N	\N	\N	\N	\N	1060
2120	\N	\N	\N	\N	\N	\N	1060
2121	76	19	15	15	24	3	1061
2122	78	18	18	22	15	5	1061
2123	\N	\N	\N	\N	\N	\N	1062
2124	\N	\N	\N	\N	\N	\N	1062
2125	88	19	22	22	25	\N	1063
2126	92	20	25	26	21	\N	1063
2127	\N	\N	\N	\N	\N	\N	1064
2128	\N	\N	\N	\N	\N	\N	1064
2129	87	19	27	18	23	\N	1065
2130	85	20	17	27	21	\N	1065
2131	\N	\N	\N	\N	\N	\N	1066
2132	\N	\N	\N	\N	\N	\N	1066
2133	82	19	18	17	28	\N	1067
2134	93	21	29	28	15	\N	1067
2135	\N	\N	\N	\N	\N	\N	1068
2136	\N	\N	\N	\N	\N	\N	1068
2137	73	19	16	23	15	\N	1069
2138	93	27	21	28	17	\N	1069
2139	\N	\N	\N	\N	\N	\N	1070
2140	\N	\N	\N	\N	\N	\N	1070
2141	89	26	16	22	25	\N	1071
2142	95	20	24	28	23	\N	1071
2143	\N	\N	\N	\N	\N	\N	1072
2144	\N	\N	\N	\N	\N	\N	1072
2145	81	18	26	15	22	\N	1073
2146	87	18	19	20	30	\N	1073
2147	\N	\N	\N	\N	\N	\N	1074
2148	\N	\N	\N	\N	\N	\N	1074
2149	99	29	17	26	27	\N	1075
2150	87	18	22	24	23	\N	1075
2151	\N	\N	\N	\N	\N	\N	1076
2152	\N	\N	\N	\N	\N	\N	1076
2153	87	16	28	28	15	\N	1077
2154	90	30	18	16	26	\N	1077
2155	\N	\N	\N	\N	\N	\N	1078
2156	\N	\N	\N	\N	\N	\N	1078
2157	76	18	24	18	16	\N	1079
2158	93	27	17	30	19	\N	1079
2159	\N	\N	\N	\N	\N	\N	1080
2160	\N	\N	\N	\N	\N	\N	1080
2161	83	21	16	17	29	\N	1081
2162	89	26	15	18	30	\N	1081
2163	\N	\N	\N	\N	\N	\N	1082
2164	\N	\N	\N	\N	\N	\N	1082
2165	93	30	24	17	22	\N	1083
2166	112	24	30	28	30	\N	1083
2167	\N	\N	\N	\N	\N	\N	1084
2168	\N	\N	\N	\N	\N	\N	1084
2169	81	29	16	20	16	\N	1085
2170	95	19	21	28	27	\N	1085
2171	\N	\N	\N	\N	\N	\N	1086
2172	\N	\N	\N	\N	\N	\N	1086
2173	89	22	17	23	27	\N	1087
2174	92	29	24	23	16	\N	1087
2175	\N	\N	\N	\N	\N	\N	1088
2176	\N	\N	\N	\N	\N	\N	1088
2177	86	23	15	24	24	\N	1089
2178	94	26	21	23	24	\N	1089
2179	\N	\N	\N	\N	\N	\N	1090
2180	\N	\N	\N	\N	\N	\N	1090
2181	85	20	22	28	15	\N	1091
2182	95	30	21	28	16	\N	1091
2183	\N	\N	\N	\N	\N	\N	1092
2184	\N	\N	\N	\N	\N	\N	1092
2185	96	20	23	27	26	\N	1093
2186	87	22	21	19	25	\N	1093
2187	\N	\N	\N	\N	\N	\N	1094
2188	\N	\N	\N	\N	\N	\N	1094
2189	92	18	18	26	30	\N	1095
2190	93	30	15	22	26	\N	1095
2191	\N	\N	\N	\N	\N	\N	1096
2192	\N	\N	\N	\N	\N	\N	1096
2193	96	22	21	30	23	\N	1097
2194	95	23	21	29	22	\N	1097
2195	\N	\N	\N	\N	\N	\N	1098
2196	\N	\N	\N	\N	\N	\N	1098
2197	94	22	23	29	20	\N	1099
2198	92	23	25	22	22	\N	1099
2199	\N	\N	\N	\N	\N	\N	1100
2200	\N	\N	\N	\N	\N	\N	1100
2201	94	16	22	29	27	\N	1101
2202	93	28	20	27	18	\N	1101
2203	\N	\N	\N	\N	\N	\N	1102
2204	\N	\N	\N	\N	\N	\N	1102
2205	94	26	25	26	17	\N	1103
2206	104	27	30	30	17	\N	1103
2207	\N	\N	\N	\N	\N	\N	1104
2208	\N	\N	\N	\N	\N	\N	1104
2209	97	19	23	29	26	\N	1105
2210	84	18	15	21	30	\N	1105
2211	\N	\N	\N	\N	\N	\N	1106
2212	\N	\N	\N	\N	\N	\N	1106
2213	84	30	20	16	18	\N	1107
2214	76	18	25	17	16	\N	1107
2215	\N	\N	\N	\N	\N	\N	1108
2216	\N	\N	\N	\N	\N	\N	1108
2217	102	23	28	23	28	\N	1109
2218	84	20	20	25	19	\N	1109
2219	\N	\N	\N	\N	\N	\N	1110
2220	\N	\N	\N	\N	\N	\N	1110
2221	98	24	29	25	20	\N	1111
2222	83	15	21	30	17	\N	1111
2223	\N	\N	\N	\N	\N	\N	1112
2224	\N	\N	\N	\N	\N	\N	1112
2225	83	16	29	15	23	\N	1113
2226	100	20	28	30	22	\N	1113
2227	\N	\N	\N	\N	\N	\N	1114
2228	\N	\N	\N	\N	\N	\N	1114
2229	96	17	29	21	29	\N	1115
2230	77	24	21	17	15	\N	1115
2231	\N	\N	\N	\N	\N	\N	1116
2232	\N	\N	\N	\N	\N	\N	1116
2233	85	17	28	19	21	\N	1117
2234	88	19	25	22	22	\N	1117
2235	\N	\N	\N	\N	\N	\N	1118
2236	\N	\N	\N	\N	\N	\N	1118
2237	100	18	25	30	27	\N	1119
2238	93	29	21	25	18	\N	1119
2239	\N	\N	\N	\N	\N	\N	1120
2240	\N	\N	\N	\N	\N	\N	1120
2241	86	23	20	15	28	\N	1121
2242	89	29	17	28	15	\N	1121
2243	\N	\N	\N	\N	\N	\N	1122
2244	\N	\N	\N	\N	\N	\N	1122
2245	100	28	15	28	29	\N	1123
2246	91	23	21	26	21	\N	1123
2247	\N	\N	\N	\N	\N	\N	1124
2248	\N	\N	\N	\N	\N	\N	1124
2249	81	25	16	22	18	\N	1125
2250	70	16	16	23	15	\N	1125
2251	\N	\N	\N	\N	\N	\N	1126
2252	\N	\N	\N	\N	\N	\N	1126
2253	101	29	26	22	24	\N	1127
2254	92	27	20	17	28	\N	1127
2255	\N	\N	\N	\N	\N	\N	1128
2256	\N	\N	\N	\N	\N	\N	1128
2257	106	22	30	24	30	\N	1129
2258	96	25	23	27	21	\N	1129
2259	\N	\N	\N	\N	\N	\N	1130
2260	\N	\N	\N	\N	\N	\N	1130
2261	75	20	20	15	20	\N	1131
2262	82	15	18	22	27	\N	1131
2263	\N	\N	\N	\N	\N	\N	1132
2264	\N	\N	\N	\N	\N	\N	1132
2265	93	26	28	22	17	\N	1133
2266	95	23	19	24	29	\N	1133
2267	\N	\N	\N	\N	\N	\N	1134
2268	\N	\N	\N	\N	\N	\N	1134
2269	88	25	17	22	24	\N	1135
2270	82	19	26	22	15	\N	1135
2271	\N	\N	\N	\N	\N	\N	1136
2272	\N	\N	\N	\N	\N	\N	1136
2273	78	21	20	21	16	\N	1137
2274	95	30	22	17	26	\N	1137
2275	\N	\N	\N	\N	\N	\N	1138
2276	\N	\N	\N	\N	\N	\N	1138
2277	95	24	15	28	28	\N	1139
2278	90	20	15	26	29	\N	1139
2279	\N	\N	\N	\N	\N	\N	1140
2280	\N	\N	\N	\N	\N	\N	1140
2281	78	19	22	16	21	\N	1141
2282	96	29	22	16	29	\N	1141
2283	\N	\N	\N	\N	\N	\N	1142
2284	\N	\N	\N	\N	\N	\N	1142
2285	95	28	20	22	25	\N	1143
2286	97	23	16	30	28	\N	1143
2287	\N	\N	\N	\N	\N	\N	1144
2288	\N	\N	\N	\N	\N	\N	1144
2289	95	22	23	20	30	\N	1145
2290	99	25	21	26	27	\N	1145
2291	\N	\N	\N	\N	\N	\N	1146
2292	\N	\N	\N	\N	\N	\N	1146
2293	84	25	22	18	19	\N	1147
2294	82	22	15	25	20	\N	1147
2295	\N	\N	\N	\N	\N	\N	1148
2296	\N	\N	\N	\N	\N	\N	1148
2297	96	22	30	28	16	\N	1149
2298	95	25	29	15	26	\N	1149
2299	\N	\N	\N	\N	\N	\N	1150
2300	\N	\N	\N	\N	\N	\N	1150
2301	107	17	28	28	23	11	1151
2302	104	24	24	28	20	8	1151
2303	\N	\N	\N	\N	\N	\N	1152
2304	\N	\N	\N	\N	\N	\N	1152
2305	97	26	16	30	25	\N	1153
2306	88	17	25	16	30	\N	1153
2307	\N	\N	\N	\N	\N	\N	1154
2308	\N	\N	\N	\N	\N	\N	1154
2309	86	20	25	19	22	\N	1155
2310	114	28	27	30	29	\N	1155
2311	\N	\N	\N	\N	\N	\N	1156
2312	\N	\N	\N	\N	\N	\N	1156
2313	82	27	16	21	18	\N	1157
2314	90	29	19	23	19	\N	1157
2315	\N	\N	\N	\N	\N	\N	1158
2316	\N	\N	\N	\N	\N	\N	1158
2317	94	25	20	28	21	\N	1159
2318	90	21	18	24	27	\N	1159
2319	\N	\N	\N	\N	\N	\N	1160
2320	\N	\N	\N	\N	\N	\N	1160
2321	87	26	18	25	18	\N	1161
2322	91	20	24	19	28	\N	1161
2323	\N	\N	\N	\N	\N	\N	1162
2324	\N	\N	\N	\N	\N	\N	1162
2325	82	19	19	18	26	\N	1163
2326	98	17	24	29	28	\N	1163
2327	\N	\N	\N	\N	\N	\N	1164
2328	\N	\N	\N	\N	\N	\N	1164
2329	99	19	30	27	23	\N	1165
2330	85	15	26	27	17	\N	1165
2331	\N	\N	\N	\N	\N	\N	1166
2332	\N	\N	\N	\N	\N	\N	1166
2333	80	18	16	22	24	\N	1167
2334	88	16	24	24	24	\N	1167
2335	\N	\N	\N	\N	\N	\N	1168
2336	\N	\N	\N	\N	\N	\N	1168
2337	89	21	26	25	17	\N	1169
2338	88	19	17	30	22	\N	1169
2339	\N	\N	\N	\N	\N	\N	1170
2340	\N	\N	\N	\N	\N	\N	1170
2341	97	20	17	30	30	\N	1171
2342	68	16	15	22	15	\N	1171
2343	\N	\N	\N	\N	\N	\N	1172
2344	\N	\N	\N	\N	\N	\N	1172
2345	83	29	16	21	17	\N	1173
2346	91	28	29	15	19	\N	1173
2347	\N	\N	\N	\N	\N	\N	1174
2348	\N	\N	\N	\N	\N	\N	1174
2349	108	29	27	27	25	\N	1175
2350	82	15	28	18	21	\N	1175
2351	\N	\N	\N	\N	\N	\N	1176
2352	\N	\N	\N	\N	\N	\N	1176
2353	88	19	23	20	26	\N	1177
2354	75	23	15	17	20	\N	1177
2355	\N	\N	\N	\N	\N	\N	1178
2356	\N	\N	\N	\N	\N	\N	1178
2357	81	16	29	21	15	\N	1179
2358	94	21	23	24	26	\N	1179
2359	\N	\N	\N	\N	\N	\N	1180
2360	\N	\N	\N	\N	\N	\N	1180
2361	91	27	25	24	15	\N	1181
2362	89	24	22	28	15	\N	1181
2363	\N	\N	\N	\N	\N	\N	1182
2364	\N	\N	\N	\N	\N	\N	1182
2365	89	21	25	19	24	\N	1183
2366	75	20	15	17	23	\N	1183
2367	\N	\N	\N	\N	\N	\N	1184
2368	\N	\N	\N	\N	\N	\N	1184
2369	85	18	26	25	16	\N	1185
2370	96	27	28	22	19	\N	1185
2371	\N	\N	\N	\N	\N	\N	1186
2372	\N	\N	\N	\N	\N	\N	1186
2373	89	20	17	26	26	\N	1187
2374	97	29	28	19	21	\N	1187
2375	\N	\N	\N	\N	\N	\N	1188
2376	\N	\N	\N	\N	\N	\N	1188
2377	90	28	22	15	25	\N	1189
2378	95	27	26	26	16	\N	1189
2379	\N	\N	\N	\N	\N	\N	1190
2380	\N	\N	\N	\N	\N	\N	1190
2381	87	21	19	27	20	\N	1191
2382	89	18	27	15	29	\N	1191
2383	\N	\N	\N	\N	\N	\N	1192
2384	\N	\N	\N	\N	\N	\N	1192
2385	77	26	17	19	15	\N	1193
2386	91	18	27	24	22	\N	1193
2387	\N	\N	\N	\N	\N	\N	1194
2388	\N	\N	\N	\N	\N	\N	1194
2389	92	26	20	27	19	\N	1195
2390	91	20	17	28	26	\N	1195
2391	\N	\N	\N	\N	\N	\N	1196
2392	\N	\N	\N	\N	\N	\N	1196
2393	90	27	15	30	18	\N	1197
2394	98	28	25	18	27	\N	1197
2395	\N	\N	\N	\N	\N	\N	1198
2396	\N	\N	\N	\N	\N	\N	1198
2397	102	30	22	23	27	\N	1199
2398	86	25	24	16	21	\N	1199
2399	\N	\N	\N	\N	\N	\N	1200
2400	\N	\N	\N	\N	\N	\N	1200
2401	88	17	26	27	18	\N	1201
2402	91	20	20	25	26	\N	1201
2403	\N	\N	\N	\N	\N	\N	1202
2404	\N	\N	\N	\N	\N	\N	1202
2405	93	29	19	22	23	\N	1203
2406	84	23	17	22	22	\N	1203
2407	\N	\N	\N	\N	\N	\N	1204
2408	\N	\N	\N	\N	\N	\N	1204
2409	87	28	15	28	16	\N	1205
2410	98	17	22	30	29	\N	1205
2411	\N	\N	\N	\N	\N	\N	1206
2412	\N	\N	\N	\N	\N	\N	1206
2413	85	23	16	28	18	\N	1207
2414	107	24	28	29	26	\N	1207
2415	\N	\N	\N	\N	\N	\N	1208
2416	\N	\N	\N	\N	\N	\N	1208
2417	101	23	23	27	28	\N	1209
2418	76	25	15	20	16	\N	1209
2419	\N	\N	\N	\N	\N	\N	1210
2420	\N	\N	\N	\N	\N	\N	1210
2421	92	20	20	28	24	\N	1211
2422	94	23	27	26	18	\N	1211
2423	\N	\N	\N	\N	\N	\N	1212
2424	\N	\N	\N	\N	\N	\N	1212
2425	108	22	28	30	28	\N	1213
2426	96	23	23	28	22	\N	1213
2427	\N	\N	\N	\N	\N	\N	1214
2428	\N	\N	\N	\N	\N	\N	1214
2429	88	18	24	20	26	\N	1215
2430	78	21	18	15	24	\N	1215
2431	\N	\N	\N	\N	\N	\N	1216
2432	\N	\N	\N	\N	\N	\N	1216
2433	95	17	27	25	26	\N	1217
2434	88	16	26	18	28	\N	1217
2435	\N	\N	\N	\N	\N	\N	1218
2436	\N	\N	\N	\N	\N	\N	1218
2437	90	17	23	30	20	\N	1219
2438	101	22	30	20	29	\N	1219
2439	\N	\N	\N	\N	\N	\N	1220
2440	\N	\N	\N	\N	\N	\N	1220
2441	95	29	21	29	16	\N	1221
2442	85	15	17	28	25	\N	1221
2443	\N	\N	\N	\N	\N	\N	1222
2444	\N	\N	\N	\N	\N	\N	1222
2445	72	25	15	15	17	\N	1223
2446	111	27	24	30	30	\N	1223
2447	\N	\N	\N	\N	\N	\N	1224
2448	\N	\N	\N	\N	\N	\N	1224
2449	78	17	18	23	20	\N	1225
2450	87	17	21	19	30	\N	1225
2451	\N	\N	\N	\N	\N	\N	1226
2452	\N	\N	\N	\N	\N	\N	1226
2453	93	28	19	30	16	\N	1227
2454	87	23	21	18	25	\N	1227
2455	\N	\N	\N	\N	\N	\N	1228
2456	\N	\N	\N	\N	\N	\N	1228
2457	102	25	20	30	27	\N	1229
2458	71	16	22	17	16	\N	1229
2459	\N	\N	\N	\N	\N	\N	1230
2460	\N	\N	\N	\N	\N	\N	1230
2461	100	30	25	27	18	\N	1231
2462	90	28	17	19	26	\N	1231
2463	\N	\N	\N	\N	\N	\N	1232
2464	\N	\N	\N	\N	\N	\N	1232
2465	87	24	24	15	24	\N	1233
2466	92	24	27	23	18	\N	1233
2467	\N	\N	\N	\N	\N	\N	1234
2468	\N	\N	\N	\N	\N	\N	1234
2469	87	22	22	24	19	\N	1235
2470	84	26	15	27	16	\N	1235
2471	\N	\N	\N	\N	\N	\N	1236
2472	\N	\N	\N	\N	\N	\N	1236
2473	94	16	29	22	27	\N	1237
2474	89	26	20	24	19	\N	1237
2475	\N	\N	\N	\N	\N	\N	1238
2476	\N	\N	\N	\N	\N	\N	1238
2477	98	28	28	26	16	\N	1239
2478	89	22	28	18	21	\N	1239
2479	\N	\N	\N	\N	\N	\N	1240
2480	\N	\N	\N	\N	\N	\N	1240
2481	97	25	19	25	28	\N	1241
2482	100	29	23	18	30	\N	1241
2483	\N	\N	\N	\N	\N	\N	1242
2484	\N	\N	\N	\N	\N	\N	1242
2485	106	29	24	29	24	\N	1243
2486	88	20	16	23	29	\N	1243
2487	\N	\N	\N	\N	\N	\N	1244
2488	\N	\N	\N	\N	\N	\N	1244
2489	97	18	27	23	29	\N	1245
2490	88	25	30	15	18	\N	1245
2491	\N	\N	\N	\N	\N	\N	1246
2492	\N	\N	\N	\N	\N	\N	1246
2493	94	17	23	26	28	\N	1247
2494	82	16	28	23	15	\N	1247
2495	\N	\N	\N	\N	\N	\N	1248
2496	\N	\N	\N	\N	\N	\N	1248
2497	88	29	15	21	23	\N	1249
2498	97	25	27	21	24	\N	1249
2499	\N	\N	\N	\N	\N	\N	1250
2500	\N	\N	\N	\N	\N	\N	1250
2501	74	18	18	20	18	\N	1251
2502	102	30	20	26	26	\N	1251
2503	\N	\N	\N	\N	\N	\N	1252
2504	\N	\N	\N	\N	\N	\N	1252
2505	98	27	22	24	25	\N	1253
2506	86	23	17	30	16	\N	1253
2507	\N	\N	\N	\N	\N	\N	1254
2508	\N	\N	\N	\N	\N	\N	1254
2509	109	25	30	26	28	\N	1255
2510	93	18	26	26	23	\N	1255
2511	\N	\N	\N	\N	\N	\N	1256
2512	\N	\N	\N	\N	\N	\N	1256
2513	90	15	23	28	24	\N	1257
2514	94	29	20	15	30	\N	1257
2515	\N	\N	\N	\N	\N	\N	1258
2516	\N	\N	\N	\N	\N	\N	1258
2517	99	23	20	29	21	6	1259
2518	101	22	16	30	25	8	1259
2519	\N	\N	\N	\N	\N	\N	1260
2520	\N	\N	\N	\N	\N	\N	1260
2521	76	18	18	18	22	\N	1261
2522	86	17	28	25	16	\N	1261
2523	\N	\N	\N	\N	\N	\N	1262
2524	\N	\N	\N	\N	\N	\N	1262
2525	94	17	25	26	26	\N	1263
2526	74	16	15	19	24	\N	1263
2527	\N	\N	\N	\N	\N	\N	1264
2528	\N	\N	\N	\N	\N	\N	1264
2529	76	15	18	27	16	\N	1265
2530	98	17	28	25	28	\N	1265
2531	\N	\N	\N	\N	\N	\N	1266
2532	\N	\N	\N	\N	\N	\N	1266
2533	105	26	27	27	25	\N	1267
2534	109	28	28	27	26	\N	1267
2535	\N	\N	\N	\N	\N	\N	1268
2536	\N	\N	\N	\N	\N	\N	1268
2537	77	19	28	15	15	\N	1269
2538	79	26	21	15	17	\N	1269
2539	\N	\N	\N	\N	\N	\N	1270
2540	\N	\N	\N	\N	\N	\N	1270
2541	90	26	17	20	27	\N	1271
2542	93	27	29	20	17	\N	1271
2543	\N	\N	\N	\N	\N	\N	1272
2544	\N	\N	\N	\N	\N	\N	1272
2545	97	24	27	24	22	\N	1273
2546	96	28	19	30	19	\N	1273
2547	\N	\N	\N	\N	\N	\N	1274
2548	\N	\N	\N	\N	\N	\N	1274
2549	93	17	24	30	22	\N	1275
2550	106	29	25	23	29	\N	1275
2551	\N	\N	\N	\N	\N	\N	1276
2552	\N	\N	\N	\N	\N	\N	1276
2553	101	30	23	21	27	\N	1277
2554	90	18	25	19	28	\N	1277
2555	\N	\N	\N	\N	\N	\N	1278
2556	\N	\N	\N	\N	\N	\N	1278
2557	86	17	28	22	19	\N	1279
2558	93	24	27	17	25	\N	1279
2559	\N	\N	\N	\N	\N	\N	1280
2560	\N	\N	\N	\N	\N	\N	1280
2561	82	20	18	27	17	\N	1281
2562	93	24	16	30	23	\N	1281
2563	\N	\N	\N	\N	\N	\N	1282
2564	\N	\N	\N	\N	\N	\N	1282
2565	90	29	27	18	16	\N	1283
2566	105	29	26	26	24	\N	1283
2567	\N	\N	\N	\N	\N	\N	1284
2568	\N	\N	\N	\N	\N	\N	1284
2569	102	23	25	27	27	\N	1285
2570	91	23	26	26	16	\N	1285
2571	\N	\N	\N	\N	\N	\N	1286
2572	\N	\N	\N	\N	\N	\N	1286
2573	105	27	24	24	30	\N	1287
2574	97	30	15	29	23	\N	1287
2575	\N	\N	\N	\N	\N	\N	1288
2576	\N	\N	\N	\N	\N	\N	1288
2577	103	30	22	28	23	\N	1289
2578	94	19	27	21	27	\N	1289
2579	\N	\N	\N	\N	\N	\N	1290
2580	\N	\N	\N	\N	\N	\N	1290
2581	95	26	27	27	15	\N	1291
2582	87	27	18	17	25	\N	1291
2583	\N	\N	\N	\N	\N	\N	1292
2584	\N	\N	\N	\N	\N	\N	1292
2585	91	28	16	28	19	\N	1293
2586	88	28	22	15	23	\N	1293
2587	\N	\N	\N	\N	\N	\N	1294
2588	\N	\N	\N	\N	\N	\N	1294
2589	95	29	25	19	22	\N	1295
2590	86	28	17	23	18	\N	1295
2591	\N	\N	\N	\N	\N	\N	1296
2592	\N	\N	\N	\N	\N	\N	1296
2593	77	16	20	19	22	\N	1297
2594	109	26	30	24	29	\N	1297
2595	\N	\N	\N	\N	\N	\N	1298
2596	\N	\N	\N	\N	\N	\N	1298
2597	87	24	29	15	19	\N	1299
2598	88	30	23	20	15	\N	1299
2599	\N	\N	\N	\N	\N	\N	1300
2600	\N	\N	\N	\N	\N	\N	1300
2601	92	30	18	19	25	\N	1301
2602	97	27	29	26	15	\N	1301
2603	\N	\N	\N	\N	\N	\N	1302
2604	\N	\N	\N	\N	\N	\N	1302
2605	93	23	22	25	23	\N	1303
2606	102	27	24	22	29	\N	1303
2607	\N	\N	\N	\N	\N	\N	1304
2608	\N	\N	\N	\N	\N	\N	1304
2609	88	16	22	21	29	\N	1305
2610	80	18	30	16	16	\N	1305
2611	\N	\N	\N	\N	\N	\N	1306
2612	\N	\N	\N	\N	\N	\N	1306
2613	93	17	24	25	27	\N	1307
2614	98	23	19	26	30	\N	1307
2615	\N	\N	\N	\N	\N	\N	1308
2616	\N	\N	\N	\N	\N	\N	1308
2617	79	21	15	16	27	\N	1309
2618	94	30	24	16	24	\N	1309
2619	\N	\N	\N	\N	\N	\N	1310
2620	\N	\N	\N	\N	\N	\N	1310
2621	89	26	16	18	29	\N	1311
2622	81	25	18	18	20	\N	1311
2623	\N	\N	\N	\N	\N	\N	1312
2624	\N	\N	\N	\N	\N	\N	1312
2625	76	23	16	22	15	\N	1313
2626	99	21	28	28	22	\N	1313
2627	\N	\N	\N	\N	\N	\N	1314
2628	\N	\N	\N	\N	\N	\N	1314
2629	103	29	24	29	21	\N	1315
2630	91	22	16	27	26	\N	1315
2631	\N	\N	\N	\N	\N	\N	1316
2632	\N	\N	\N	\N	\N	\N	1316
2633	82	27	20	17	18	\N	1317
2634	90	23	22	28	17	\N	1317
2635	\N	\N	\N	\N	\N	\N	1318
2636	\N	\N	\N	\N	\N	\N	1318
2637	89	27	15	19	28	\N	1319
2638	92	25	23	21	23	\N	1319
2639	\N	\N	\N	\N	\N	\N	1320
2640	\N	\N	\N	\N	\N	\N	1320
2641	86	17	29	23	17	\N	1321
2642	87	25	16	27	19	\N	1321
2643	\N	\N	\N	\N	\N	\N	1322
2644	\N	\N	\N	\N	\N	\N	1322
2645	84	19	20	17	28	\N	1323
2646	75	22	15	17	21	\N	1323
2647	\N	\N	\N	\N	\N	\N	1324
2648	\N	\N	\N	\N	\N	\N	1324
2649	88	28	17	27	16	\N	1325
2650	73	18	23	17	15	\N	1325
2651	\N	\N	\N	\N	\N	\N	1326
2652	\N	\N	\N	\N	\N	\N	1326
2653	87	17	29	17	24	\N	1327
2654	86	29	16	17	24	\N	1327
2655	\N	\N	\N	\N	\N	\N	1328
2656	\N	\N	\N	\N	\N	\N	1328
2657	89	22	25	16	26	\N	1329
2658	84	29	17	18	20	\N	1329
2659	\N	\N	\N	\N	\N	\N	1330
2660	\N	\N	\N	\N	\N	\N	1330
2661	85	22	30	18	15	\N	1331
2662	98	29	18	22	29	\N	1331
2663	\N	\N	\N	\N	\N	\N	1332
2664	\N	\N	\N	\N	\N	\N	1332
2665	95	26	30	22	17	\N	1333
2666	85	17	18	22	28	\N	1333
2667	\N	\N	\N	\N	\N	\N	1334
2668	\N	\N	\N	\N	\N	\N	1334
2669	84	23	22	18	21	\N	1335
2670	95	19	24	25	27	\N	1335
2671	\N	\N	\N	\N	\N	\N	1336
2672	\N	\N	\N	\N	\N	\N	1336
2673	97	27	17	23	30	\N	1337
2674	92	23	19	29	21	\N	1337
2675	\N	\N	\N	\N	\N	\N	1338
2676	\N	\N	\N	\N	\N	\N	1338
2677	102	20	22	30	30	\N	1339
2678	107	30	24	25	28	\N	1339
2679	\N	\N	\N	\N	\N	\N	1340
2680	\N	\N	\N	\N	\N	\N	1340
2681	107	26	23	30	28	\N	1341
2682	96	27	15	28	26	\N	1341
2683	\N	\N	\N	\N	\N	\N	1342
2684	\N	\N	\N	\N	\N	\N	1342
2685	79	16	22	15	26	\N	1343
2686	92	17	30	15	30	\N	1343
2687	\N	\N	\N	\N	\N	\N	1344
2688	\N	\N	\N	\N	\N	\N	1344
2689	88	26	22	25	15	\N	1345
2690	75	16	22	20	17	\N	1345
2691	\N	\N	\N	\N	\N	\N	1346
2692	\N	\N	\N	\N	\N	\N	1346
2693	86	19	22	15	30	\N	1347
2694	100	20	30	28	22	\N	1347
2695	\N	\N	\N	\N	\N	\N	1348
2696	\N	\N	\N	\N	\N	\N	1348
2697	94	28	24	17	25	\N	1349
2698	82	26	25	16	15	\N	1349
2699	\N	\N	\N	\N	\N	\N	1350
2700	\N	\N	\N	\N	\N	\N	1350
2701	104	21	29	25	29	\N	1351
2702	81	22	16	16	27	\N	1351
2703	\N	\N	\N	\N	\N	\N	1352
2704	\N	\N	\N	\N	\N	\N	1352
2705	77	19	15	28	15	\N	1353
2706	109	26	28	29	26	\N	1353
2707	\N	\N	\N	\N	\N	\N	1354
2708	\N	\N	\N	\N	\N	\N	1354
2709	91	21	26	29	15	\N	1355
2710	109	30	25	26	28	\N	1355
2711	\N	\N	\N	\N	\N	\N	1356
2712	\N	\N	\N	\N	\N	\N	1356
2713	96	30	18	29	19	\N	1357
2714	78	21	19	15	23	\N	1357
2715	\N	\N	\N	\N	\N	\N	1358
2716	\N	\N	\N	\N	\N	\N	1358
2717	84	16	23	16	29	\N	1359
2718	97	30	26	23	18	\N	1359
2719	\N	\N	\N	\N	\N	\N	1360
2720	\N	\N	\N	\N	\N	\N	1360
2721	78	15	16	27	20	\N	1361
2722	92	15	21	30	26	\N	1361
2723	\N	\N	\N	\N	\N	\N	1362
2724	\N	\N	\N	\N	\N	\N	1362
2725	79	15	22	24	18	\N	1363
2726	86	24	22	17	23	\N	1363
2727	\N	\N	\N	\N	\N	\N	1364
2728	\N	\N	\N	\N	\N	\N	1364
2729	99	16	24	29	30	\N	1365
2730	84	17	15	24	28	\N	1365
2731	\N	\N	\N	\N	\N	\N	1366
2732	\N	\N	\N	\N	\N	\N	1366
2733	102	30	30	21	21	\N	1367
2734	86	18	18	30	20	\N	1367
2735	\N	\N	\N	\N	\N	\N	1368
2736	\N	\N	\N	\N	\N	\N	1368
2737	79	23	19	16	21	\N	1369
2738	94	30	20	16	28	\N	1369
2739	\N	\N	\N	\N	\N	\N	1370
2740	\N	\N	\N	\N	\N	\N	1370
2741	75	19	15	25	16	\N	1371
2742	71	17	24	15	15	\N	1371
2743	\N	\N	\N	\N	\N	\N	1372
2744	\N	\N	\N	\N	\N	\N	1372
2745	95	21	22	22	30	\N	1373
2746	75	21	17	22	15	\N	1373
2747	\N	\N	\N	\N	\N	\N	1374
2748	\N	\N	\N	\N	\N	\N	1374
2749	81	17	18	25	21	\N	1375
2750	103	16	29	30	28	\N	1375
2751	\N	\N	\N	\N	\N	\N	1376
2752	\N	\N	\N	\N	\N	\N	1376
2753	90	16	25	20	29	\N	1377
2754	84	18	22	23	21	\N	1377
2755	\N	\N	\N	\N	\N	\N	1378
2756	\N	\N	\N	\N	\N	\N	1378
2757	93	26	19	19	29	\N	1379
2758	91	20	29	22	20	\N	1379
2759	\N	\N	\N	\N	\N	\N	1380
2760	\N	\N	\N	\N	\N	\N	1380
2761	103	27	23	29	24	\N	1381
2762	88	23	18	30	17	\N	1381
2763	\N	\N	\N	\N	\N	\N	1382
2764	\N	\N	\N	\N	\N	\N	1382
2765	105	27	28	23	27	\N	1383
2766	78	16	24	22	16	\N	1383
2767	\N	\N	\N	\N	\N	\N	1384
2768	\N	\N	\N	\N	\N	\N	1384
2769	82	19	19	23	21	\N	1385
2770	89	29	15	30	15	\N	1385
2771	\N	\N	\N	\N	\N	\N	1386
2772	\N	\N	\N	\N	\N	\N	1386
2773	89	21	23	17	28	\N	1387
2774	98	29	15	26	28	\N	1387
2775	\N	\N	\N	\N	\N	\N	1388
2776	\N	\N	\N	\N	\N	\N	1388
2777	87	22	22	18	25	\N	1389
2778	72	18	15	22	17	\N	1389
2779	\N	\N	\N	\N	\N	\N	1390
2780	\N	\N	\N	\N	\N	\N	1390
2781	91	24	30	22	15	\N	1391
2782	77	22	25	15	15	\N	1391
2783	\N	\N	\N	\N	\N	\N	1392
2784	\N	\N	\N	\N	\N	\N	1392
2785	89	25	19	19	26	\N	1393
2786	102	30	19	30	23	\N	1393
2787	\N	\N	\N	\N	\N	\N	1394
2788	\N	\N	\N	\N	\N	\N	1394
2789	78	29	18	16	15	\N	1395
2790	85	27	18	18	22	\N	1395
2791	\N	\N	\N	\N	\N	\N	1396
2792	\N	\N	\N	\N	\N	\N	1396
2793	101	15	27	30	29	\N	1397
2794	99	30	22	17	30	\N	1397
2795	\N	\N	\N	\N	\N	\N	1398
2796	\N	\N	\N	\N	\N	\N	1398
2797	73	17	17	15	24	\N	1399
2798	95	19	21	30	25	\N	1399
2799	\N	\N	\N	\N	\N	\N	1400
2800	\N	\N	\N	\N	\N	\N	1400
2801	89	17	19	30	23	\N	1401
2802	72	18	17	20	17	\N	1401
2803	\N	\N	\N	\N	\N	\N	1402
2804	\N	\N	\N	\N	\N	\N	1402
2805	85	28	19	17	21	\N	1403
2806	98	20	23	30	25	\N	1403
2807	\N	\N	\N	\N	\N	\N	1404
2808	\N	\N	\N	\N	\N	\N	1404
2809	99	28	18	25	28	\N	1405
2810	72	21	15	20	16	\N	1405
2811	\N	\N	\N	\N	\N	\N	1406
2812	\N	\N	\N	\N	\N	\N	1406
2813	84	29	19	17	19	\N	1407
2814	78	16	21	18	23	\N	1407
2815	\N	\N	\N	\N	\N	\N	1408
2816	\N	\N	\N	\N	\N	\N	1408
2817	98	21	30	23	24	\N	1409
2818	76	18	20	17	21	\N	1409
2819	\N	\N	\N	\N	\N	\N	1410
2820	\N	\N	\N	\N	\N	\N	1410
2821	84	22	17	19	26	\N	1411
2822	80	18	29	15	18	\N	1411
2823	\N	\N	\N	\N	\N	\N	1412
2824	\N	\N	\N	\N	\N	\N	1412
2825	88	25	19	22	22	\N	1413
2826	100	30	25	22	23	\N	1413
2827	\N	\N	\N	\N	\N	\N	1414
2828	\N	\N	\N	\N	\N	\N	1414
2829	93	17	25	27	24	\N	1415
2830	84	22	28	18	16	\N	1415
2831	\N	\N	\N	\N	\N	\N	1416
2832	\N	\N	\N	\N	\N	\N	1416
2833	86	16	28	19	23	\N	1417
2834	110	30	30	30	20	\N	1417
2835	\N	\N	\N	\N	\N	\N	1418
2836	\N	\N	\N	\N	\N	\N	1418
2837	90	21	16	25	28	\N	1419
2838	99	27	25	20	27	\N	1419
2839	\N	\N	\N	\N	\N	\N	1420
2840	\N	\N	\N	\N	\N	\N	1420
2841	82	16	26	24	16	\N	1421
2842	103	24	23	29	27	\N	1421
2843	\N	\N	\N	\N	\N	\N	1422
2844	\N	\N	\N	\N	\N	\N	1422
2845	110	28	28	27	27	\N	1423
2846	81	20	22	15	24	\N	1423
2847	\N	\N	\N	\N	\N	\N	1424
2848	\N	\N	\N	\N	\N	\N	1424
2849	81	29	19	16	17	\N	1425
2850	80	17	16	26	21	\N	1425
2851	\N	\N	\N	\N	\N	\N	1426
2852	\N	\N	\N	\N	\N	\N	1426
2853	90	23	17	30	20	\N	1427
2854	98	16	27	30	25	\N	1427
2855	\N	\N	\N	\N	\N	\N	1428
2856	\N	\N	\N	\N	\N	\N	1428
2857	98	18	27	23	30	\N	1429
2858	85	19	24	23	19	\N	1429
2859	\N	\N	\N	\N	\N	\N	1430
2860	\N	\N	\N	\N	\N	\N	1430
2861	98	27	29	22	20	\N	1431
2862	93	25	28	16	24	\N	1431
2863	\N	\N	\N	\N	\N	\N	1432
2864	\N	\N	\N	\N	\N	\N	1432
2865	82	15	26	17	24	\N	1433
2866	101	28	26	23	24	\N	1433
2867	\N	\N	\N	\N	\N	\N	1434
2868	\N	\N	\N	\N	\N	\N	1434
2869	90	19	21	26	24	\N	1435
2870	101	29	29	16	27	\N	1435
2871	\N	\N	\N	\N	\N	\N	1436
2872	\N	\N	\N	\N	\N	\N	1436
2873	90	15	29	23	23	\N	1437
2874	98	25	27	17	29	\N	1437
2875	\N	\N	\N	\N	\N	\N	1438
2876	\N	\N	\N	\N	\N	\N	1438
2877	75	19	26	15	15	\N	1439
2878	85	15	17	25	28	\N	1439
2879	\N	\N	\N	\N	\N	\N	1440
2880	\N	\N	\N	\N	\N	\N	1440
2881	71	17	22	16	16	\N	1441
2882	88	24	22	18	24	\N	1441
2883	\N	\N	\N	\N	\N	\N	1442
2884	\N	\N	\N	\N	\N	\N	1442
2885	106	28	28	27	23	\N	1443
2886	86	27	17	21	21	\N	1443
2887	\N	\N	\N	\N	\N	\N	1444
2888	\N	\N	\N	\N	\N	\N	1444
2889	100	29	24	18	29	\N	1445
2890	87	26	18	19	24	\N	1445
2891	\N	\N	\N	\N	\N	\N	1446
2892	\N	\N	\N	\N	\N	\N	1446
2893	89	28	19	24	18	\N	1447
2894	79	25	17	22	15	\N	1447
2895	\N	\N	\N	\N	\N	\N	1448
2896	\N	\N	\N	\N	\N	\N	1448
2897	81	16	19	29	17	\N	1449
2898	92	29	17	23	23	\N	1449
2899	\N	\N	\N	\N	\N	\N	1450
2900	\N	\N	\N	\N	\N	\N	1450
2901	30	\N	\N	\N	30	\N	1451
2902	28	\N	\N	\N	28	\N	1451
2903	\N	\N	\N	\N	\N	\N	1452
2904	\N	\N	\N	\N	\N	\N	1452
2905	15	\N	\N	\N	15	\N	1453
2906	16	\N	\N	\N	16	\N	1453
2907	\N	\N	\N	\N	\N	\N	1454
2908	\N	\N	\N	\N	\N	\N	1454
2909	15	\N	\N	\N	15	\N	1455
2910	16	\N	\N	\N	16	\N	1455
2911	\N	\N	\N	\N	\N	\N	1456
2912	\N	\N	\N	\N	\N	\N	1456
2913	26	\N	\N	\N	26	\N	1457
2914	22	\N	\N	\N	22	\N	1457
2915	\N	\N	\N	\N	\N	\N	1458
2916	\N	\N	\N	\N	\N	\N	1458
2917	17	\N	\N	\N	17	\N	1459
2918	18	\N	\N	\N	18	\N	1459
2919	\N	\N	\N	\N	\N	\N	1460
2920	\N	\N	\N	\N	\N	\N	1460
2921	16	\N	\N	\N	16	\N	1461
2922	18	\N	\N	\N	18	\N	1461
2923	\N	\N	\N	\N	\N	\N	1462
2924	\N	\N	\N	\N	\N	\N	1462
2925	16	\N	\N	\N	16	\N	1463
2926	28	\N	\N	\N	28	\N	1463
2927	\N	\N	\N	\N	\N	\N	1464
2928	\N	\N	\N	\N	\N	\N	1464
2929	29	\N	\N	\N	29	\N	1465
2930	20	\N	\N	\N	20	\N	1465
2931	\N	\N	\N	\N	\N	\N	1466
2932	\N	\N	\N	\N	\N	\N	1466
2933	22	\N	\N	\N	22	\N	1467
2934	22	\N	\N	\N	22	\N	1467
2935	\N	\N	\N	\N	\N	\N	1468
2936	\N	\N	\N	\N	\N	\N	1468
2937	17	\N	\N	\N	17	\N	1469
2938	20	\N	\N	\N	20	\N	1469
2939	\N	\N	\N	\N	\N	\N	1470
2940	\N	\N	\N	\N	\N	\N	1470
2941	23	\N	\N	\N	23	\N	1471
2942	29	\N	\N	\N	29	\N	1471
2943	\N	\N	\N	\N	\N	\N	1472
2944	\N	\N	\N	\N	\N	\N	1472
2945	20	\N	\N	\N	20	\N	1473
2946	27	\N	\N	\N	27	\N	1473
2947	\N	\N	\N	\N	\N	\N	1474
2948	\N	\N	\N	\N	\N	\N	1474
2949	20	\N	\N	\N	20	\N	1475
2950	30	\N	\N	\N	30	\N	1475
2951	\N	\N	\N	\N	\N	\N	1476
2952	\N	\N	\N	\N	\N	\N	1476
2953	21	\N	\N	\N	21	\N	1477
2954	27	\N	\N	\N	27	\N	1477
2955	\N	\N	\N	\N	\N	\N	1478
2956	\N	\N	\N	\N	\N	\N	1478
2957	19	\N	\N	\N	19	\N	1479
2958	23	\N	\N	\N	23	\N	1479
2959	\N	\N	\N	\N	\N	\N	1480
2960	\N	\N	\N	\N	\N	\N	1480
2961	23	\N	\N	\N	23	\N	1481
2962	15	\N	\N	\N	15	\N	1481
2963	\N	\N	\N	\N	\N	\N	1482
2964	\N	\N	\N	\N	\N	\N	1482
2965	20	\N	\N	\N	20	\N	1483
2966	23	\N	\N	\N	23	\N	1483
2967	\N	\N	\N	\N	\N	\N	1484
2968	\N	\N	\N	\N	\N	\N	1484
2969	27	\N	\N	\N	27	\N	1485
2970	19	\N	\N	\N	19	\N	1485
2971	\N	\N	\N	\N	\N	\N	1486
2972	\N	\N	\N	\N	\N	\N	1486
2973	22	\N	\N	\N	22	\N	1487
2974	26	\N	\N	\N	26	\N	1487
2975	\N	\N	\N	\N	\N	\N	1488
2976	\N	\N	\N	\N	\N	\N	1488
2977	27	\N	\N	\N	27	\N	1489
2978	25	\N	\N	\N	25	\N	1489
2979	\N	\N	\N	\N	\N	\N	1490
2980	\N	\N	\N	\N	\N	\N	1490
2981	30	\N	\N	\N	30	\N	1491
2982	28	\N	\N	\N	28	\N	1491
2983	\N	\N	\N	\N	\N	\N	1492
2984	\N	\N	\N	\N	\N	\N	1492
2985	24	\N	\N	\N	24	\N	1493
2986	18	\N	\N	\N	18	\N	1493
2987	\N	\N	\N	\N	\N	\N	1494
2988	\N	\N	\N	\N	\N	\N	1494
2989	16	\N	\N	\N	16	\N	1495
2990	22	\N	\N	\N	22	\N	1495
2991	\N	\N	\N	\N	\N	\N	1496
2992	\N	\N	\N	\N	\N	\N	1496
2993	18	\N	\N	\N	18	\N	1497
2994	21	\N	\N	\N	21	\N	1497
2995	\N	\N	\N	\N	\N	\N	1498
2996	\N	\N	\N	\N	\N	\N	1498
2997	30	\N	\N	\N	30	\N	1499
2998	28	\N	\N	\N	28	\N	1499
2999	\N	\N	\N	\N	\N	\N	1500
3000	\N	\N	\N	\N	\N	\N	1500
3001	25	\N	\N	\N	25	\N	1501
3002	15	\N	\N	\N	15	\N	1501
3003	\N	\N	\N	\N	\N	\N	1502
3004	\N	\N	\N	\N	\N	\N	1502
3005	24	\N	\N	\N	24	\N	1503
3006	29	\N	\N	\N	29	\N	1503
3007	\N	\N	\N	\N	\N	\N	1504
3008	\N	\N	\N	\N	\N	\N	1504
3009	26	\N	\N	\N	26	\N	1505
3010	25	\N	\N	\N	25	\N	1505
3011	\N	\N	\N	\N	\N	\N	1506
3012	\N	\N	\N	\N	\N	\N	1506
3013	27	\N	\N	\N	27	\N	1507
3014	28	\N	\N	\N	28	\N	1507
3015	\N	\N	\N	\N	\N	\N	1508
3016	\N	\N	\N	\N	\N	\N	1508
3017	17	\N	\N	\N	17	\N	1509
3018	18	\N	\N	\N	18	\N	1509
3019	\N	\N	\N	\N	\N	\N	1510
3020	\N	\N	\N	\N	\N	\N	1510
3021	15	\N	\N	\N	15	\N	1511
3022	21	\N	\N	\N	21	\N	1511
3023	\N	\N	\N	\N	\N	\N	1512
3024	\N	\N	\N	\N	\N	\N	1512
3025	25	\N	\N	\N	25	\N	1513
3026	26	\N	\N	\N	26	\N	1513
3027	\N	\N	\N	\N	\N	\N	1514
3028	\N	\N	\N	\N	\N	\N	1514
3029	17	\N	\N	\N	17	\N	1515
3030	28	\N	\N	\N	28	\N	1515
3031	\N	\N	\N	\N	\N	\N	1516
3032	\N	\N	\N	\N	\N	\N	1516
3033	24	\N	\N	\N	24	\N	1517
3034	19	\N	\N	\N	19	\N	1517
3035	\N	\N	\N	\N	\N	\N	1518
3036	\N	\N	\N	\N	\N	\N	1518
3037	28	\N	\N	\N	28	\N	1519
3038	18	\N	\N	\N	18	\N	1519
3039	\N	\N	\N	\N	\N	\N	1520
3040	\N	\N	\N	\N	\N	\N	1520
3041	30	\N	\N	\N	30	\N	1521
3042	23	\N	\N	\N	23	\N	1521
3043	\N	\N	\N	\N	\N	\N	1522
3044	\N	\N	\N	\N	\N	\N	1522
3045	27	\N	\N	\N	27	\N	1523
3046	26	\N	\N	\N	26	\N	1523
3047	\N	\N	\N	\N	\N	\N	1524
3048	\N	\N	\N	\N	\N	\N	1524
3049	25	\N	\N	\N	25	\N	1525
3050	24	\N	\N	\N	24	\N	1525
3051	\N	\N	\N	\N	\N	\N	1526
3052	\N	\N	\N	\N	\N	\N	1526
3053	15	\N	\N	\N	15	\N	1527
3054	29	\N	\N	\N	29	\N	1527
3055	\N	\N	\N	\N	\N	\N	1528
3056	\N	\N	\N	\N	\N	\N	1528
3057	23	\N	\N	\N	23	\N	1529
3058	25	\N	\N	\N	25	\N	1529
3059	\N	\N	\N	\N	\N	\N	1530
3060	\N	\N	\N	\N	\N	\N	1530
3061	26	\N	\N	\N	26	\N	1531
3062	16	\N	\N	\N	16	\N	1531
3063	\N	\N	\N	\N	\N	\N	1532
3064	\N	\N	\N	\N	\N	\N	1532
3065	22	\N	\N	\N	22	\N	1533
3066	28	\N	\N	\N	28	\N	1533
3067	\N	\N	\N	\N	\N	\N	1534
3068	\N	\N	\N	\N	\N	\N	1534
3069	25	\N	\N	\N	25	\N	1535
3070	23	\N	\N	\N	23	\N	1535
3071	\N	\N	\N	\N	\N	\N	1536
3072	\N	\N	\N	\N	\N	\N	1536
3073	29	\N	\N	\N	29	\N	1537
3074	15	\N	\N	\N	15	\N	1537
3075	\N	\N	\N	\N	\N	\N	1538
3076	\N	\N	\N	\N	\N	\N	1538
3077	26	\N	\N	\N	26	\N	1539
3078	26	\N	\N	\N	26	\N	1539
3079	\N	\N	\N	\N	\N	\N	1540
3080	\N	\N	\N	\N	\N	\N	1540
3081	24	\N	\N	\N	24	\N	1541
3082	29	\N	\N	\N	29	\N	1541
3083	\N	\N	\N	\N	\N	\N	1542
3084	\N	\N	\N	\N	\N	\N	1542
3085	18	\N	\N	\N	18	\N	1543
3086	24	\N	\N	\N	24	\N	1543
3087	\N	\N	\N	\N	\N	\N	1544
3088	\N	\N	\N	\N	\N	\N	1544
3089	21	\N	\N	\N	21	\N	1545
3090	24	\N	\N	\N	24	\N	1545
3091	\N	\N	\N	\N	\N	\N	1546
3092	\N	\N	\N	\N	\N	\N	1546
3093	29	\N	\N	\N	29	\N	1547
3094	30	\N	\N	\N	30	\N	1547
3095	\N	\N	\N	\N	\N	\N	1548
3096	\N	\N	\N	\N	\N	\N	1548
3097	19	\N	\N	\N	19	\N	1549
3098	19	\N	\N	\N	19	\N	1549
3099	\N	\N	\N	\N	\N	\N	1550
3100	\N	\N	\N	\N	\N	\N	1550
3101	16	\N	\N	\N	16	\N	1551
3102	30	\N	\N	\N	30	\N	1551
3103	\N	\N	\N	\N	\N	\N	1552
3104	\N	\N	\N	\N	\N	\N	1552
3105	22	\N	\N	\N	22	\N	1553
3106	20	\N	\N	\N	20	\N	1553
3107	\N	\N	\N	\N	\N	\N	1554
3108	\N	\N	\N	\N	\N	\N	1554
3109	22	\N	\N	\N	22	\N	1555
3110	16	\N	\N	\N	16	\N	1555
3111	\N	\N	\N	\N	\N	\N	1556
3112	\N	\N	\N	\N	\N	\N	1556
3113	26	\N	\N	\N	26	\N	1557
3114	15	\N	\N	\N	15	\N	1557
3115	\N	\N	\N	\N	\N	\N	1558
3116	\N	\N	\N	\N	\N	\N	1558
3117	21	\N	\N	\N	21	\N	1559
3118	22	\N	\N	\N	22	\N	1559
3119	\N	\N	\N	\N	\N	\N	1560
3120	\N	\N	\N	\N	\N	\N	1560
3121	29	\N	\N	\N	29	\N	1561
3122	24	\N	\N	\N	24	\N	1561
3123	\N	\N	\N	\N	\N	\N	1562
3124	\N	\N	\N	\N	\N	\N	1562
3125	23	\N	\N	\N	23	\N	1563
3126	20	\N	\N	\N	20	\N	1563
3127	\N	\N	\N	\N	\N	\N	1564
3128	\N	\N	\N	\N	\N	\N	1564
3129	27	\N	\N	\N	27	\N	1565
3130	30	\N	\N	\N	30	\N	1565
3131	\N	\N	\N	\N	\N	\N	1566
3132	\N	\N	\N	\N	\N	\N	1566
3133	24	\N	\N	\N	24	\N	1567
3134	21	\N	\N	\N	21	\N	1567
3135	\N	\N	\N	\N	\N	\N	1568
3136	\N	\N	\N	\N	\N	\N	1568
3137	26	\N	\N	\N	26	\N	1569
3138	30	\N	\N	\N	30	\N	1569
3139	\N	\N	\N	\N	\N	\N	1570
3140	\N	\N	\N	\N	\N	\N	1570
3141	\N	\N	\N	\N	\N	\N	1571
3142	\N	\N	\N	\N	\N	\N	1571
3143	\N	\N	\N	\N	\N	\N	1572
3144	\N	\N	\N	\N	\N	\N	1572
3145	\N	\N	\N	\N	\N	\N	1573
3146	\N	\N	\N	\N	\N	\N	1573
3147	\N	\N	\N	\N	\N	\N	1574
3148	\N	\N	\N	\N	\N	\N	1574
3149	\N	\N	\N	\N	\N	\N	1575
3150	\N	\N	\N	\N	\N	\N	1575
3151	\N	\N	\N	\N	\N	\N	1576
3152	\N	\N	\N	\N	\N	\N	1576
3153	\N	\N	\N	\N	\N	\N	1577
3154	\N	\N	\N	\N	\N	\N	1577
3155	\N	\N	\N	\N	\N	\N	1578
3156	\N	\N	\N	\N	\N	\N	1578
3157	\N	\N	\N	\N	\N	\N	1579
3158	\N	\N	\N	\N	\N	\N	1579
3159	\N	\N	\N	\N	\N	\N	1580
3160	\N	\N	\N	\N	\N	\N	1580
3161	\N	\N	\N	\N	\N	\N	1581
3162	\N	\N	\N	\N	\N	\N	1581
3163	\N	\N	\N	\N	\N	\N	1582
3164	\N	\N	\N	\N	\N	\N	1582
3165	\N	\N	\N	\N	\N	\N	1583
3166	\N	\N	\N	\N	\N	\N	1583
3167	\N	\N	\N	\N	\N	\N	1584
3168	\N	\N	\N	\N	\N	\N	1584
3169	\N	\N	\N	\N	\N	\N	1585
3170	\N	\N	\N	\N	\N	\N	1585
3171	\N	\N	\N	\N	\N	\N	1586
3172	\N	\N	\N	\N	\N	\N	1586
3173	\N	\N	\N	\N	\N	\N	1587
3174	\N	\N	\N	\N	\N	\N	1587
3175	\N	\N	\N	\N	\N	\N	1588
3176	\N	\N	\N	\N	\N	\N	1588
3177	\N	\N	\N	\N	\N	\N	1589
3178	\N	\N	\N	\N	\N	\N	1589
3179	\N	\N	\N	\N	\N	\N	1590
3180	\N	\N	\N	\N	\N	\N	1590
3181	\N	\N	\N	\N	\N	\N	1591
3182	\N	\N	\N	\N	\N	\N	1591
3183	\N	\N	\N	\N	\N	\N	1592
3184	\N	\N	\N	\N	\N	\N	1592
3185	\N	\N	\N	\N	\N	\N	1593
3186	\N	\N	\N	\N	\N	\N	1593
3187	\N	\N	\N	\N	\N	\N	1594
3188	\N	\N	\N	\N	\N	\N	1594
3189	\N	\N	\N	\N	\N	\N	1595
3190	\N	\N	\N	\N	\N	\N	1595
3191	\N	\N	\N	\N	\N	\N	1596
3192	\N	\N	\N	\N	\N	\N	1596
3193	\N	\N	\N	\N	\N	\N	1597
3194	\N	\N	\N	\N	\N	\N	1597
3195	\N	\N	\N	\N	\N	\N	1598
3196	\N	\N	\N	\N	\N	\N	1598
3197	\N	\N	\N	\N	\N	\N	1599
3198	\N	\N	\N	\N	\N	\N	1599
3199	\N	\N	\N	\N	\N	\N	1600
3200	\N	\N	\N	\N	\N	\N	1600
3201	\N	\N	\N	\N	\N	\N	1601
3202	\N	\N	\N	\N	\N	\N	1601
3203	\N	\N	\N	\N	\N	\N	1602
3204	\N	\N	\N	\N	\N	\N	1602
3205	\N	\N	\N	\N	\N	\N	1603
3206	\N	\N	\N	\N	\N	\N	1603
3207	\N	\N	\N	\N	\N	\N	1604
3208	\N	\N	\N	\N	\N	\N	1604
3209	\N	\N	\N	\N	\N	\N	1605
3210	\N	\N	\N	\N	\N	\N	1605
3211	\N	\N	\N	\N	\N	\N	1606
3212	\N	\N	\N	\N	\N	\N	1606
3213	\N	\N	\N	\N	\N	\N	1607
3214	\N	\N	\N	\N	\N	\N	1607
3215	\N	\N	\N	\N	\N	\N	1608
3216	\N	\N	\N	\N	\N	\N	1608
3217	\N	\N	\N	\N	\N	\N	1609
3218	\N	\N	\N	\N	\N	\N	1609
3219	\N	\N	\N	\N	\N	\N	1610
3220	\N	\N	\N	\N	\N	\N	1610
3221	\N	\N	\N	\N	\N	\N	1611
3222	\N	\N	\N	\N	\N	\N	1611
3223	\N	\N	\N	\N	\N	\N	1612
3224	\N	\N	\N	\N	\N	\N	1612
3225	\N	\N	\N	\N	\N	\N	1613
3226	\N	\N	\N	\N	\N	\N	1613
3227	\N	\N	\N	\N	\N	\N	1614
3228	\N	\N	\N	\N	\N	\N	1614
3229	\N	\N	\N	\N	\N	\N	1615
3230	\N	\N	\N	\N	\N	\N	1615
3231	\N	\N	\N	\N	\N	\N	1616
3232	\N	\N	\N	\N	\N	\N	1616
3233	\N	\N	\N	\N	\N	\N	1617
3234	\N	\N	\N	\N	\N	\N	1617
3235	\N	\N	\N	\N	\N	\N	1618
3236	\N	\N	\N	\N	\N	\N	1618
3237	\N	\N	\N	\N	\N	\N	1619
3238	\N	\N	\N	\N	\N	\N	1619
3239	\N	\N	\N	\N	\N	\N	1620
3240	\N	\N	\N	\N	\N	\N	1620
3241	\N	\N	\N	\N	\N	\N	1621
3242	\N	\N	\N	\N	\N	\N	1621
3243	\N	\N	\N	\N	\N	\N	1622
3244	\N	\N	\N	\N	\N	\N	1622
3245	\N	\N	\N	\N	\N	\N	1623
3246	\N	\N	\N	\N	\N	\N	1623
3247	\N	\N	\N	\N	\N	\N	1624
3248	\N	\N	\N	\N	\N	\N	1624
3249	\N	\N	\N	\N	\N	\N	1625
3250	\N	\N	\N	\N	\N	\N	1625
3251	\N	\N	\N	\N	\N	\N	1626
3252	\N	\N	\N	\N	\N	\N	1626
3253	\N	\N	\N	\N	\N	\N	1627
3254	\N	\N	\N	\N	\N	\N	1627
3255	\N	\N	\N	\N	\N	\N	1628
3256	\N	\N	\N	\N	\N	\N	1628
3257	\N	\N	\N	\N	\N	\N	1629
3258	\N	\N	\N	\N	\N	\N	1629
3259	\N	\N	\N	\N	\N	\N	1630
3260	\N	\N	\N	\N	\N	\N	1630
3261	\N	\N	\N	\N	\N	\N	1631
3262	\N	\N	\N	\N	\N	\N	1631
3263	\N	\N	\N	\N	\N	\N	1632
3264	\N	\N	\N	\N	\N	\N	1632
3265	\N	\N	\N	\N	\N	\N	1633
3266	\N	\N	\N	\N	\N	\N	1633
3267	\N	\N	\N	\N	\N	\N	1634
3268	\N	\N	\N	\N	\N	\N	1634
3269	\N	\N	\N	\N	\N	\N	1635
3270	\N	\N	\N	\N	\N	\N	1635
3271	\N	\N	\N	\N	\N	\N	1636
3272	\N	\N	\N	\N	\N	\N	1636
3273	\N	\N	\N	\N	\N	\N	1637
3274	\N	\N	\N	\N	\N	\N	1637
3275	\N	\N	\N	\N	\N	\N	1638
3276	\N	\N	\N	\N	\N	\N	1638
3277	\N	\N	\N	\N	\N	\N	1639
3278	\N	\N	\N	\N	\N	\N	1639
3279	\N	\N	\N	\N	\N	\N	1640
3280	\N	\N	\N	\N	\N	\N	1640
3281	\N	\N	\N	\N	\N	\N	1641
3282	\N	\N	\N	\N	\N	\N	1641
3283	\N	\N	\N	\N	\N	\N	1642
3284	\N	\N	\N	\N	\N	\N	1642
3285	\N	\N	\N	\N	\N	\N	1643
3286	\N	\N	\N	\N	\N	\N	1643
3287	\N	\N	\N	\N	\N	\N	1644
3288	\N	\N	\N	\N	\N	\N	1644
3289	\N	\N	\N	\N	\N	\N	1645
3290	\N	\N	\N	\N	\N	\N	1645
3291	\N	\N	\N	\N	\N	\N	1646
3292	\N	\N	\N	\N	\N	\N	1646
3293	\N	\N	\N	\N	\N	\N	1647
3294	\N	\N	\N	\N	\N	\N	1647
3295	\N	\N	\N	\N	\N	\N	1648
3296	\N	\N	\N	\N	\N	\N	1648
3297	\N	\N	\N	\N	\N	\N	1649
3298	\N	\N	\N	\N	\N	\N	1649
3299	\N	\N	\N	\N	\N	\N	1650
3300	\N	\N	\N	\N	\N	\N	1650
3301	\N	\N	\N	\N	\N	\N	1651
3302	\N	\N	\N	\N	\N	\N	1651
3303	\N	\N	\N	\N	\N	\N	1652
3304	\N	\N	\N	\N	\N	\N	1652
3305	\N	\N	\N	\N	\N	\N	1653
3306	\N	\N	\N	\N	\N	\N	1653
3307	\N	\N	\N	\N	\N	\N	1654
3308	\N	\N	\N	\N	\N	\N	1654
3309	\N	\N	\N	\N	\N	\N	1655
3310	\N	\N	\N	\N	\N	\N	1655
3311	\N	\N	\N	\N	\N	\N	1656
3312	\N	\N	\N	\N	\N	\N	1656
3313	\N	\N	\N	\N	\N	\N	1657
3314	\N	\N	\N	\N	\N	\N	1657
3315	\N	\N	\N	\N	\N	\N	1658
3316	\N	\N	\N	\N	\N	\N	1658
3317	\N	\N	\N	\N	\N	\N	1659
3318	\N	\N	\N	\N	\N	\N	1659
3319	\N	\N	\N	\N	\N	\N	1660
3320	\N	\N	\N	\N	\N	\N	1660
3321	\N	\N	\N	\N	\N	\N	1661
3322	\N	\N	\N	\N	\N	\N	1661
3323	\N	\N	\N	\N	\N	\N	1662
3324	\N	\N	\N	\N	\N	\N	1662
3325	\N	\N	\N	\N	\N	\N	1663
3326	\N	\N	\N	\N	\N	\N	1663
3327	\N	\N	\N	\N	\N	\N	1664
3328	\N	\N	\N	\N	\N	\N	1664
3329	\N	\N	\N	\N	\N	\N	1665
3330	\N	\N	\N	\N	\N	\N	1665
3331	\N	\N	\N	\N	\N	\N	1666
3332	\N	\N	\N	\N	\N	\N	1666
3333	\N	\N	\N	\N	\N	\N	1667
3334	\N	\N	\N	\N	\N	\N	1667
3335	\N	\N	\N	\N	\N	\N	1668
3336	\N	\N	\N	\N	\N	\N	1668
3337	\N	\N	\N	\N	\N	\N	1669
3338	\N	\N	\N	\N	\N	\N	1669
3339	\N	\N	\N	\N	\N	\N	1670
3340	\N	\N	\N	\N	\N	\N	1670
3341	\N	\N	\N	\N	\N	\N	1671
3342	\N	\N	\N	\N	\N	\N	1671
3343	\N	\N	\N	\N	\N	\N	1672
3344	\N	\N	\N	\N	\N	\N	1672
3345	\N	\N	\N	\N	\N	\N	1673
3346	\N	\N	\N	\N	\N	\N	1673
3347	\N	\N	\N	\N	\N	\N	1674
3348	\N	\N	\N	\N	\N	\N	1674
3349	\N	\N	\N	\N	\N	\N	1675
3350	\N	\N	\N	\N	\N	\N	1675
3351	\N	\N	\N	\N	\N	\N	1676
3352	\N	\N	\N	\N	\N	\N	1676
3353	\N	\N	\N	\N	\N	\N	1677
3354	\N	\N	\N	\N	\N	\N	1677
3355	\N	\N	\N	\N	\N	\N	1678
3356	\N	\N	\N	\N	\N	\N	1678
3357	\N	\N	\N	\N	\N	\N	1679
3358	\N	\N	\N	\N	\N	\N	1679
3359	\N	\N	\N	\N	\N	\N	1680
3360	\N	\N	\N	\N	\N	\N	1680
3361	\N	\N	\N	\N	\N	\N	1681
3362	\N	\N	\N	\N	\N	\N	1681
3363	\N	\N	\N	\N	\N	\N	1682
3364	\N	\N	\N	\N	\N	\N	1682
3365	\N	\N	\N	\N	\N	\N	1683
3366	\N	\N	\N	\N	\N	\N	1683
3367	\N	\N	\N	\N	\N	\N	1684
3368	\N	\N	\N	\N	\N	\N	1684
3369	\N	\N	\N	\N	\N	\N	1685
3370	\N	\N	\N	\N	\N	\N	1685
3371	\N	\N	\N	\N	\N	\N	1686
3372	\N	\N	\N	\N	\N	\N	1686
3373	\N	\N	\N	\N	\N	\N	1687
3374	\N	\N	\N	\N	\N	\N	1687
3375	\N	\N	\N	\N	\N	\N	1688
3376	\N	\N	\N	\N	\N	\N	1688
3377	\N	\N	\N	\N	\N	\N	1689
3378	\N	\N	\N	\N	\N	\N	1689
3379	\N	\N	\N	\N	\N	\N	1690
3380	\N	\N	\N	\N	\N	\N	1690
3381	\N	\N	\N	\N	\N	\N	1691
3382	\N	\N	\N	\N	\N	\N	1691
3383	\N	\N	\N	\N	\N	\N	1692
3384	\N	\N	\N	\N	\N	\N	1692
3385	\N	\N	\N	\N	\N	\N	1693
3386	\N	\N	\N	\N	\N	\N	1693
3387	\N	\N	\N	\N	\N	\N	1694
3388	\N	\N	\N	\N	\N	\N	1694
3389	\N	\N	\N	\N	\N	\N	1695
3390	\N	\N	\N	\N	\N	\N	1695
3391	\N	\N	\N	\N	\N	\N	1696
3392	\N	\N	\N	\N	\N	\N	1696
3393	\N	\N	\N	\N	\N	\N	1697
3394	\N	\N	\N	\N	\N	\N	1697
3395	\N	\N	\N	\N	\N	\N	1698
3396	\N	\N	\N	\N	\N	\N	1698
3397	\N	\N	\N	\N	\N	\N	1699
3398	\N	\N	\N	\N	\N	\N	1699
3399	\N	\N	\N	\N	\N	\N	1700
3400	\N	\N	\N	\N	\N	\N	1700
3401	\N	\N	\N	\N	\N	\N	1701
3402	\N	\N	\N	\N	\N	\N	1701
3403	\N	\N	\N	\N	\N	\N	1702
3404	\N	\N	\N	\N	\N	\N	1702
3405	\N	\N	\N	\N	\N	\N	1703
3406	\N	\N	\N	\N	\N	\N	1703
3407	\N	\N	\N	\N	\N	\N	1704
3408	\N	\N	\N	\N	\N	\N	1704
3409	\N	\N	\N	\N	\N	\N	1705
3410	\N	\N	\N	\N	\N	\N	1705
3411	\N	\N	\N	\N	\N	\N	1706
3412	\N	\N	\N	\N	\N	\N	1706
3413	\N	\N	\N	\N	\N	\N	1707
3414	\N	\N	\N	\N	\N	\N	1707
3415	\N	\N	\N	\N	\N	\N	1708
3416	\N	\N	\N	\N	\N	\N	1708
3417	\N	\N	\N	\N	\N	\N	1709
3418	\N	\N	\N	\N	\N	\N	1709
3419	\N	\N	\N	\N	\N	\N	1710
3420	\N	\N	\N	\N	\N	\N	1710
3421	\N	\N	\N	\N	\N	\N	1711
3422	\N	\N	\N	\N	\N	\N	1711
3423	\N	\N	\N	\N	\N	\N	1712
3424	\N	\N	\N	\N	\N	\N	1712
3425	\N	\N	\N	\N	\N	\N	1713
3426	\N	\N	\N	\N	\N	\N	1713
3427	\N	\N	\N	\N	\N	\N	1714
3428	\N	\N	\N	\N	\N	\N	1714
3429	\N	\N	\N	\N	\N	\N	1715
3430	\N	\N	\N	\N	\N	\N	1715
3431	\N	\N	\N	\N	\N	\N	1716
3432	\N	\N	\N	\N	\N	\N	1716
3433	\N	\N	\N	\N	\N	\N	1717
3434	\N	\N	\N	\N	\N	\N	1717
3435	\N	\N	\N	\N	\N	\N	1718
3436	\N	\N	\N	\N	\N	\N	1718
3437	\N	\N	\N	\N	\N	\N	1719
3438	\N	\N	\N	\N	\N	\N	1719
3439	\N	\N	\N	\N	\N	\N	1720
3440	\N	\N	\N	\N	\N	\N	1720
3441	\N	\N	\N	\N	\N	\N	1721
3442	\N	\N	\N	\N	\N	\N	1721
3443	\N	\N	\N	\N	\N	\N	1722
3444	\N	\N	\N	\N	\N	\N	1722
3445	\N	\N	\N	\N	\N	\N	1723
3446	\N	\N	\N	\N	\N	\N	1723
3447	\N	\N	\N	\N	\N	\N	1724
3448	\N	\N	\N	\N	\N	\N	1724
3449	\N	\N	\N	\N	\N	\N	1725
3450	\N	\N	\N	\N	\N	\N	1725
3451	\N	\N	\N	\N	\N	\N	1726
3452	\N	\N	\N	\N	\N	\N	1726
3453	\N	\N	\N	\N	\N	\N	1727
3454	\N	\N	\N	\N	\N	\N	1727
3455	\N	\N	\N	\N	\N	\N	1728
3456	\N	\N	\N	\N	\N	\N	1728
3457	\N	\N	\N	\N	\N	\N	1729
3458	\N	\N	\N	\N	\N	\N	1729
3459	\N	\N	\N	\N	\N	\N	1730
3460	\N	\N	\N	\N	\N	\N	1730
3461	\N	\N	\N	\N	\N	\N	1731
3462	\N	\N	\N	\N	\N	\N	1731
3463	\N	\N	\N	\N	\N	\N	1732
3464	\N	\N	\N	\N	\N	\N	1732
3465	\N	\N	\N	\N	\N	\N	1733
3466	\N	\N	\N	\N	\N	\N	1733
3467	\N	\N	\N	\N	\N	\N	1734
3468	\N	\N	\N	\N	\N	\N	1734
3469	\N	\N	\N	\N	\N	\N	1735
3470	\N	\N	\N	\N	\N	\N	1735
3471	\N	\N	\N	\N	\N	\N	1736
3472	\N	\N	\N	\N	\N	\N	1736
3473	\N	\N	\N	\N	\N	\N	1737
3474	\N	\N	\N	\N	\N	\N	1737
3475	\N	\N	\N	\N	\N	\N	1738
3476	\N	\N	\N	\N	\N	\N	1738
3477	\N	\N	\N	\N	\N	\N	1739
3478	\N	\N	\N	\N	\N	\N	1739
3479	\N	\N	\N	\N	\N	\N	1740
3480	\N	\N	\N	\N	\N	\N	1740
3481	\N	\N	\N	\N	\N	\N	1741
3482	\N	\N	\N	\N	\N	\N	1741
3483	\N	\N	\N	\N	\N	\N	1742
3484	\N	\N	\N	\N	\N	\N	1742
3485	\N	\N	\N	\N	\N	\N	1743
3486	\N	\N	\N	\N	\N	\N	1743
3487	\N	\N	\N	\N	\N	\N	1744
3488	\N	\N	\N	\N	\N	\N	1744
3489	\N	\N	\N	\N	\N	\N	1745
3490	\N	\N	\N	\N	\N	\N	1745
3491	\N	\N	\N	\N	\N	\N	1746
3492	\N	\N	\N	\N	\N	\N	1746
3493	\N	\N	\N	\N	\N	\N	1747
3494	\N	\N	\N	\N	\N	\N	1747
3495	\N	\N	\N	\N	\N	\N	1748
3496	\N	\N	\N	\N	\N	\N	1748
3497	\N	\N	\N	\N	\N	\N	1749
3498	\N	\N	\N	\N	\N	\N	1749
3499	\N	\N	\N	\N	\N	\N	1750
3500	\N	\N	\N	\N	\N	\N	1750
3501	\N	\N	\N	\N	\N	\N	1751
3502	\N	\N	\N	\N	\N	\N	1751
3503	\N	\N	\N	\N	\N	\N	1752
3504	\N	\N	\N	\N	\N	\N	1752
3505	\N	\N	\N	\N	\N	\N	1753
3506	\N	\N	\N	\N	\N	\N	1753
3507	\N	\N	\N	\N	\N	\N	1754
3508	\N	\N	\N	\N	\N	\N	1754
3509	\N	\N	\N	\N	\N	\N	1755
3510	\N	\N	\N	\N	\N	\N	1755
3511	\N	\N	\N	\N	\N	\N	1756
3512	\N	\N	\N	\N	\N	\N	1756
3513	\N	\N	\N	\N	\N	\N	1757
3514	\N	\N	\N	\N	\N	\N	1757
3515	\N	\N	\N	\N	\N	\N	1758
3516	\N	\N	\N	\N	\N	\N	1758
3517	\N	\N	\N	\N	\N	\N	1759
3518	\N	\N	\N	\N	\N	\N	1759
3519	\N	\N	\N	\N	\N	\N	1760
3520	\N	\N	\N	\N	\N	\N	1760
3521	\N	\N	\N	\N	\N	\N	1761
3522	\N	\N	\N	\N	\N	\N	1761
3523	\N	\N	\N	\N	\N	\N	1762
3524	\N	\N	\N	\N	\N	\N	1762
3525	\N	\N	\N	\N	\N	\N	1763
3526	\N	\N	\N	\N	\N	\N	1763
3527	\N	\N	\N	\N	\N	\N	1764
3528	\N	\N	\N	\N	\N	\N	1764
3529	\N	\N	\N	\N	\N	\N	1765
3530	\N	\N	\N	\N	\N	\N	1765
3531	\N	\N	\N	\N	\N	\N	1766
3532	\N	\N	\N	\N	\N	\N	1766
3533	\N	\N	\N	\N	\N	\N	1767
3534	\N	\N	\N	\N	\N	\N	1767
3535	\N	\N	\N	\N	\N	\N	1768
3536	\N	\N	\N	\N	\N	\N	1768
3537	\N	\N	\N	\N	\N	\N	1769
3538	\N	\N	\N	\N	\N	\N	1769
3539	\N	\N	\N	\N	\N	\N	1770
3540	\N	\N	\N	\N	\N	\N	1770
3541	\N	\N	\N	\N	\N	\N	1771
3542	\N	\N	\N	\N	\N	\N	1771
3543	\N	\N	\N	\N	\N	\N	1772
3544	\N	\N	\N	\N	\N	\N	1772
3545	\N	\N	\N	\N	\N	\N	1773
3546	\N	\N	\N	\N	\N	\N	1773
3547	\N	\N	\N	\N	\N	\N	1774
3548	\N	\N	\N	\N	\N	\N	1774
3549	\N	\N	\N	\N	\N	\N	1775
3550	\N	\N	\N	\N	\N	\N	1775
3551	\N	\N	\N	\N	\N	\N	1776
3552	\N	\N	\N	\N	\N	\N	1776
3553	\N	\N	\N	\N	\N	\N	1777
3554	\N	\N	\N	\N	\N	\N	1777
3555	\N	\N	\N	\N	\N	\N	1778
3556	\N	\N	\N	\N	\N	\N	1778
3557	\N	\N	\N	\N	\N	\N	1779
3558	\N	\N	\N	\N	\N	\N	1779
3559	\N	\N	\N	\N	\N	\N	1780
3560	\N	\N	\N	\N	\N	\N	1780
3561	\N	\N	\N	\N	\N	\N	1781
3562	\N	\N	\N	\N	\N	\N	1781
3563	\N	\N	\N	\N	\N	\N	1782
3564	\N	\N	\N	\N	\N	\N	1782
3565	\N	\N	\N	\N	\N	\N	1783
3566	\N	\N	\N	\N	\N	\N	1783
3567	\N	\N	\N	\N	\N	\N	1784
3568	\N	\N	\N	\N	\N	\N	1784
3569	\N	\N	\N	\N	\N	\N	1785
3570	\N	\N	\N	\N	\N	\N	1785
3571	\N	\N	\N	\N	\N	\N	1786
3572	\N	\N	\N	\N	\N	\N	1786
3573	\N	\N	\N	\N	\N	\N	1787
3574	\N	\N	\N	\N	\N	\N	1787
3575	\N	\N	\N	\N	\N	\N	1788
3576	\N	\N	\N	\N	\N	\N	1788
3577	\N	\N	\N	\N	\N	\N	1789
3578	\N	\N	\N	\N	\N	\N	1789
3579	\N	\N	\N	\N	\N	\N	1790
3580	\N	\N	\N	\N	\N	\N	1790
3581	\N	\N	\N	\N	\N	\N	1791
3582	\N	\N	\N	\N	\N	\N	1791
3583	\N	\N	\N	\N	\N	\N	1792
3584	\N	\N	\N	\N	\N	\N	1792
3585	\N	\N	\N	\N	\N	\N	1793
3586	\N	\N	\N	\N	\N	\N	1793
3587	\N	\N	\N	\N	\N	\N	1794
3588	\N	\N	\N	\N	\N	\N	1794
3589	\N	\N	\N	\N	\N	\N	1795
3590	\N	\N	\N	\N	\N	\N	1795
3591	\N	\N	\N	\N	\N	\N	1796
3592	\N	\N	\N	\N	\N	\N	1796
3593	\N	\N	\N	\N	\N	\N	1797
3594	\N	\N	\N	\N	\N	\N	1797
3595	\N	\N	\N	\N	\N	\N	1798
3596	\N	\N	\N	\N	\N	\N	1798
3597	\N	\N	\N	\N	\N	\N	1799
3598	\N	\N	\N	\N	\N	\N	1799
3599	\N	\N	\N	\N	\N	\N	1800
3600	\N	\N	\N	\N	\N	\N	1800
3601	\N	\N	\N	\N	\N	\N	1801
3602	\N	\N	\N	\N	\N	\N	1801
3603	\N	\N	\N	\N	\N	\N	1802
3604	\N	\N	\N	\N	\N	\N	1802
3605	\N	\N	\N	\N	\N	\N	1803
3606	\N	\N	\N	\N	\N	\N	1803
3607	\N	\N	\N	\N	\N	\N	1804
3608	\N	\N	\N	\N	\N	\N	1804
3609	\N	\N	\N	\N	\N	\N	1805
3610	\N	\N	\N	\N	\N	\N	1805
3611	\N	\N	\N	\N	\N	\N	1806
3612	\N	\N	\N	\N	\N	\N	1806
3613	\N	\N	\N	\N	\N	\N	1807
3614	\N	\N	\N	\N	\N	\N	1807
3615	\N	\N	\N	\N	\N	\N	1808
3616	\N	\N	\N	\N	\N	\N	1808
3617	\N	\N	\N	\N	\N	\N	1809
3618	\N	\N	\N	\N	\N	\N	1809
3619	\N	\N	\N	\N	\N	\N	1810
3620	\N	\N	\N	\N	\N	\N	1810
3621	19	3	1	10	5	\N	1811
3622	45	14	17	13	1	\N	1811
3623	\N	\N	\N	\N	\N	\N	1812
3624	\N	\N	\N	\N	\N	\N	1812
3625	15	4	0	8	3	\N	1813
3626	44	12	15	15	2	\N	1813
3627	\N	\N	\N	\N	\N	\N	1814
3628	\N	\N	\N	\N	\N	\N	1814
3629	23	3	5	14	1	\N	1815
3630	39	16	0	12	11	\N	1815
3631	\N	\N	\N	\N	\N	\N	1816
3632	\N	\N	\N	\N	\N	\N	1816
3633	57	17	17	6	17	\N	1817
3634	33	8	16	6	3	\N	1817
3635	\N	\N	\N	\N	\N	\N	1818
3636	\N	\N	\N	\N	\N	\N	1818
3637	27	3	7	9	8	\N	1819
3638	43	12	17	6	8	\N	1819
3639	\N	\N	\N	\N	\N	\N	1820
3640	\N	\N	\N	\N	\N	\N	1820
3641	35	6	4	12	13	\N	1821
3642	36	10	10	6	10	\N	1821
3643	\N	\N	\N	\N	\N	\N	1822
3644	\N	\N	\N	\N	\N	\N	1822
3645	40	3	16	16	5	\N	1823
3646	34	3	15	4	12	\N	1823
3647	\N	\N	\N	\N	\N	\N	1824
3648	\N	\N	\N	\N	\N	\N	1824
3649	44	17	17	1	9	\N	1825
3650	42	16	2	9	15	\N	1825
3651	\N	\N	\N	\N	\N	\N	1826
3652	\N	\N	\N	\N	\N	\N	1826
3653	23	10	11	1	1	\N	1827
3654	32	10	8	5	9	\N	1827
3655	\N	\N	\N	\N	\N	\N	1828
3656	\N	\N	\N	\N	\N	\N	1828
3657	35	9	0	13	13	\N	1829
3658	43	13	2	13	15	\N	1829
3659	\N	\N	\N	\N	\N	\N	1830
3660	\N	\N	\N	\N	\N	\N	1830
3661	52	13	10	16	13	\N	1831
3662	26	2	15	3	6	\N	1831
3663	\N	\N	\N	\N	\N	\N	1832
3664	\N	\N	\N	\N	\N	\N	1832
3665	47	11	10	12	14	\N	1833
3666	52	16	15	17	4	\N	1833
3667	\N	\N	\N	\N	\N	\N	1834
3668	\N	\N	\N	\N	\N	\N	1834
3669	25	11	3	11	0	\N	1835
3670	19	3	12	0	4	\N	1835
3671	\N	\N	\N	\N	\N	\N	1836
3672	\N	\N	\N	\N	\N	\N	1836
3673	40	11	4	14	11	\N	1837
3674	30	2	9	8	11	\N	1837
3675	\N	\N	\N	\N	\N	\N	1838
3676	\N	\N	\N	\N	\N	\N	1838
3677	46	17	17	1	11	\N	1839
3678	17	0	1	3	13	\N	1839
3679	\N	\N	\N	\N	\N	\N	1840
3680	\N	\N	\N	\N	\N	\N	1840
3681	38	14	9	0	15	\N	1841
3682	32	2	13	8	9	\N	1841
3683	\N	\N	\N	\N	\N	\N	1842
3684	\N	\N	\N	\N	\N	\N	1842
3685	34	7	11	13	3	\N	1843
3686	31	15	3	7	6	\N	1843
3687	\N	\N	\N	\N	\N	\N	1844
3688	\N	\N	\N	\N	\N	\N	1844
3689	45	11	14	15	5	\N	1845
3690	11	0	3	2	6	\N	1845
3691	\N	\N	\N	\N	\N	\N	1846
3692	\N	\N	\N	\N	\N	\N	1846
3693	33	16	8	6	3	\N	1847
3694	37	6	12	8	11	\N	1847
3695	\N	\N	\N	\N	\N	\N	1848
3696	\N	\N	\N	\N	\N	\N	1848
3697	4	0	1	0	3	\N	1849
3698	37	6	13	11	7	\N	1849
3699	\N	\N	\N	\N	\N	\N	1850
3700	\N	\N	\N	\N	\N	\N	1850
3701	25	6	7	8	4	\N	1851
3702	31	10	10	4	7	\N	1851
3703	\N	\N	\N	\N	\N	\N	1852
3704	\N	\N	\N	\N	\N	\N	1852
3705	40	9	14	8	9	\N	1853
3706	26	0	4	6	16	\N	1853
3707	\N	\N	\N	\N	\N	\N	1854
3708	\N	\N	\N	\N	\N	\N	1854
3709	47	16	17	0	14	\N	1855
3710	21	2	9	7	3	\N	1855
3711	\N	\N	\N	\N	\N	\N	1856
3712	\N	\N	\N	\N	\N	\N	1856
5166	\N	\N	\N	\N	\N	\N	2583
3713	41	7	6	17	11	\N	1857
3714	35	3	14	2	16	\N	1857
3715	\N	\N	\N	\N	\N	\N	1858
3716	\N	\N	\N	\N	\N	\N	1858
3717	23	3	0	7	13	\N	1859
3718	16	1	3	12	0	\N	1859
3719	\N	\N	\N	\N	\N	\N	1860
3720	\N	\N	\N	\N	\N	\N	1860
3721	22	5	3	1	13	\N	1861
3722	36	11	12	8	5	\N	1861
3723	\N	\N	\N	\N	\N	\N	1862
3724	\N	\N	\N	\N	\N	\N	1862
3725	54	17	10	17	10	\N	1863
3726	29	9	16	1	3	\N	1863
3727	\N	\N	\N	\N	\N	\N	1864
3728	\N	\N	\N	\N	\N	\N	1864
3729	40	16	12	8	4	\N	1865
3730	52	11	7	17	17	\N	1865
3731	\N	\N	\N	\N	\N	\N	1866
3732	\N	\N	\N	\N	\N	\N	1866
3733	34	5	5	15	9	\N	1867
3734	18	6	2	10	0	\N	1867
3735	\N	\N	\N	\N	\N	\N	1868
3736	\N	\N	\N	\N	\N	\N	1868
3737	56	17	15	14	10	\N	1869
3738	27	14	2	8	3	\N	1869
3739	\N	\N	\N	\N	\N	\N	1870
3740	\N	\N	\N	\N	\N	\N	1870
3741	38	4	7	12	15	\N	1871
3742	34	11	3	14	6	\N	1871
3743	\N	\N	\N	\N	\N	\N	1872
3744	\N	\N	\N	\N	\N	\N	1872
3745	56	17	16	7	16	\N	1873
3746	37	15	4	16	2	\N	1873
3747	\N	\N	\N	\N	\N	\N	1874
3748	\N	\N	\N	\N	\N	\N	1874
3749	19	9	10	0	0	\N	1875
3750	14	3	1	10	0	\N	1875
3751	\N	\N	\N	\N	\N	\N	1876
3752	\N	\N	\N	\N	\N	\N	1876
3753	27	14	0	3	10	\N	1877
3754	14	0	5	8	1	\N	1877
3755	\N	\N	\N	\N	\N	\N	1878
3756	\N	\N	\N	\N	\N	\N	1878
3757	30	8	2	14	6	\N	1879
3758	45	13	15	3	14	\N	1879
3759	\N	\N	\N	\N	\N	\N	1880
3760	\N	\N	\N	\N	\N	\N	1880
3761	58	17	9	16	16	\N	1881
3762	33	10	16	2	5	\N	1881
3763	\N	\N	\N	\N	\N	\N	1882
3764	\N	\N	\N	\N	\N	\N	1882
3765	35	12	6	11	6	\N	1883
3766	44	11	14	4	15	\N	1883
3767	\N	\N	\N	\N	\N	\N	1884
3768	\N	\N	\N	\N	\N	\N	1884
3769	33	5	9	12	7	\N	1885
3770	29	4	9	5	11	\N	1885
3771	\N	\N	\N	\N	\N	\N	1886
3772	\N	\N	\N	\N	\N	\N	1886
3773	20	1	3	5	11	\N	1887
3774	23	12	0	2	9	\N	1887
3775	\N	\N	\N	\N	\N	\N	1888
3776	\N	\N	\N	\N	\N	\N	1888
3777	33	0	8	12	13	\N	1889
3778	29	12	10	2	5	\N	1889
3779	\N	\N	\N	\N	\N	\N	1890
3780	\N	\N	\N	\N	\N	\N	1890
3781	44	16	8	5	15	\N	1891
3782	36	2	8	14	12	\N	1891
3783	\N	\N	\N	\N	\N	\N	1892
3784	\N	\N	\N	\N	\N	\N	1892
3785	27	7	1	15	4	\N	1893
3786	48	3	12	17	16	\N	1893
3787	\N	\N	\N	\N	\N	\N	1894
3788	\N	\N	\N	\N	\N	\N	1894
3789	34	8	8	6	12	\N	1895
3790	27	4	9	13	1	\N	1895
3791	\N	\N	\N	\N	\N	\N	1896
3792	\N	\N	\N	\N	\N	\N	1896
3793	25	6	10	6	3	\N	1897
3794	53	12	16	12	13	\N	1897
3795	\N	\N	\N	\N	\N	\N	1898
3796	\N	\N	\N	\N	\N	\N	1898
3797	15	0	2	7	6	\N	1899
3798	39	10	10	10	9	\N	1899
3799	\N	\N	\N	\N	\N	\N	1900
3800	\N	\N	\N	\N	\N	\N	1900
3801	27	10	6	0	11	\N	1901
3802	37	9	7	12	9	\N	1901
3803	\N	\N	\N	\N	\N	\N	1902
3804	\N	\N	\N	\N	\N	\N	1902
3805	30	11	0	15	4	\N	1903
3806	20	9	8	1	2	\N	1903
3807	\N	\N	\N	\N	\N	\N	1904
3808	\N	\N	\N	\N	\N	\N	1904
3809	39	14	8	8	9	\N	1905
3810	34	0	14	4	16	\N	1905
3811	\N	\N	\N	\N	\N	\N	1906
3812	\N	\N	\N	\N	\N	\N	1906
3813	20	11	3	6	0	\N	1907
3814	43	7	11	17	8	\N	1907
3815	\N	\N	\N	\N	\N	\N	1908
3816	\N	\N	\N	\N	\N	\N	1908
3817	28	7	2	8	11	\N	1909
3818	30	9	4	12	5	\N	1909
3819	\N	\N	\N	\N	\N	\N	1910
3820	\N	\N	\N	\N	\N	\N	1910
3821	16	8	0	1	7	\N	1911
3822	17	2	0	15	0	\N	1911
3823	\N	\N	\N	\N	\N	\N	1912
3824	\N	\N	\N	\N	\N	\N	1912
3825	38	14	4	17	3	\N	1913
3826	22	1	16	0	5	\N	1913
3827	\N	\N	\N	\N	\N	\N	1914
3828	\N	\N	\N	\N	\N	\N	1914
3829	33	5	3	14	11	\N	1915
3830	14	7	2	3	2	\N	1915
3831	\N	\N	\N	\N	\N	\N	1916
3832	\N	\N	\N	\N	\N	\N	1916
3833	24	3	8	4	9	\N	1917
3834	41	8	12	7	14	\N	1917
3835	\N	\N	\N	\N	\N	\N	1918
3836	\N	\N	\N	\N	\N	\N	1918
3837	36	3	12	8	13	\N	1919
3838	35	7	7	6	15	\N	1919
3839	\N	\N	\N	\N	\N	\N	1920
3840	\N	\N	\N	\N	\N	\N	1920
3841	36	1	13	10	12	\N	1921
3842	41	14	8	3	16	\N	1921
3843	\N	\N	\N	\N	\N	\N	1922
3844	\N	\N	\N	\N	\N	\N	1922
3845	34	3	8	6	17	\N	1923
3846	36	3	15	9	9	\N	1923
3847	\N	\N	\N	\N	\N	\N	1924
3848	\N	\N	\N	\N	\N	\N	1924
3849	19	2	13	2	2	\N	1925
3850	39	16	11	1	11	\N	1925
3851	\N	\N	\N	\N	\N	\N	1926
3852	\N	\N	\N	\N	\N	\N	1926
3853	19	4	1	11	3	\N	1927
3854	40	5	14	12	9	\N	1927
3855	\N	\N	\N	\N	\N	\N	1928
3856	\N	\N	\N	\N	\N	\N	1928
3857	32	17	7	6	2	\N	1929
3858	26	1	11	6	8	\N	1929
3859	\N	\N	\N	\N	\N	\N	1930
3860	\N	\N	\N	\N	\N	\N	1930
3861	37	13	5	4	15	\N	1931
3862	36	9	9	4	14	\N	1931
3863	\N	\N	\N	\N	\N	\N	1932
3864	\N	\N	\N	\N	\N	\N	1932
3865	42	4	8	14	16	\N	1933
3866	32	0	13	12	7	\N	1933
3867	\N	\N	\N	\N	\N	\N	1934
3868	\N	\N	\N	\N	\N	\N	1934
3869	50	11	12	17	10	\N	1935
3870	36	13	0	11	12	\N	1935
3871	\N	\N	\N	\N	\N	\N	1936
3872	\N	\N	\N	\N	\N	\N	1936
3873	21	3	8	6	4	\N	1937
3874	54	8	14	17	15	\N	1937
3875	\N	\N	\N	\N	\N	\N	1938
3876	\N	\N	\N	\N	\N	\N	1938
3877	36	5	15	2	14	\N	1939
3878	29	9	7	10	3	\N	1939
3879	\N	\N	\N	\N	\N	\N	1940
3880	\N	\N	\N	\N	\N	\N	1940
3881	42	9	10	17	6	\N	1941
4052	\N	\N	\N	\N	\N	\N	2026
3882	38	11	2	17	8	\N	1941
3883	\N	\N	\N	\N	\N	\N	1942
3884	\N	\N	\N	\N	\N	\N	1942
3885	36	4	6	14	12	\N	1943
3886	44	0	16	11	17	\N	1943
3887	\N	\N	\N	\N	\N	\N	1944
3888	\N	\N	\N	\N	\N	\N	1944
3889	31	5	12	4	10	\N	1945
3890	34	3	15	1	15	\N	1945
3891	\N	\N	\N	\N	\N	\N	1946
3892	\N	\N	\N	\N	\N	\N	1946
3893	36	2	16	10	8	\N	1947
3894	40	9	15	0	16	\N	1947
3895	\N	\N	\N	\N	\N	\N	1948
3896	\N	\N	\N	\N	\N	\N	1948
3897	46	17	10	11	8	\N	1949
3898	48	11	10	15	12	\N	1949
3899	\N	\N	\N	\N	\N	\N	1950
3900	\N	\N	\N	\N	\N	\N	1950
3901	49	16	15	6	12	\N	1951
3902	12	0	1	2	9	\N	1951
3903	\N	\N	\N	\N	\N	\N	1952
3904	\N	\N	\N	\N	\N	\N	1952
3905	36	1	13	11	11	\N	1953
3906	24	7	4	6	7	\N	1953
3907	\N	\N	\N	\N	\N	\N	1954
3908	\N	\N	\N	\N	\N	\N	1954
3909	17	4	6	1	6	\N	1955
3910	37	5	15	13	4	\N	1955
3911	\N	\N	\N	\N	\N	\N	1956
3912	\N	\N	\N	\N	\N	\N	1956
3913	52	17	15	16	4	\N	1957
3914	31	14	11	0	6	\N	1957
3915	\N	\N	\N	\N	\N	\N	1958
3916	\N	\N	\N	\N	\N	\N	1958
3917	36	9	7	9	11	\N	1959
3918	18	8	2	4	4	\N	1959
3919	\N	\N	\N	\N	\N	\N	1960
3920	\N	\N	\N	\N	\N	\N	1960
3921	27	4	10	0	13	\N	1961
3922	36	4	16	12	4	\N	1961
3923	\N	\N	\N	\N	\N	\N	1962
3924	\N	\N	\N	\N	\N	\N	1962
3925	29	6	9	10	4	\N	1963
3926	40	10	13	0	17	\N	1963
3927	\N	\N	\N	\N	\N	\N	1964
3928	\N	\N	\N	\N	\N	\N	1964
3929	38	14	13	6	5	\N	1965
3930	31	9	14	8	0	\N	1965
3931	\N	\N	\N	\N	\N	\N	1966
3932	\N	\N	\N	\N	\N	\N	1966
3933	30	2	13	0	15	\N	1967
3934	44	0	16	12	16	\N	1967
3935	\N	\N	\N	\N	\N	\N	1968
3936	\N	\N	\N	\N	\N	\N	1968
3937	31	7	3	12	9	\N	1969
3938	54	16	9	15	14	\N	1969
3939	\N	\N	\N	\N	\N	\N	1970
3940	\N	\N	\N	\N	\N	\N	1970
3941	24	8	8	0	8	\N	1971
3942	15	10	2	0	3	\N	1971
3943	\N	\N	\N	\N	\N	\N	1972
3944	\N	\N	\N	\N	\N	\N	1972
3945	26	11	2	13	0	\N	1973
3946	44	11	15	12	6	\N	1973
3947	\N	\N	\N	\N	\N	\N	1974
3948	\N	\N	\N	\N	\N	\N	1974
3949	30	3	4	15	8	\N	1975
3950	43	13	17	9	4	\N	1975
3951	\N	\N	\N	\N	\N	\N	1976
3952	\N	\N	\N	\N	\N	\N	1976
3953	32	0	10	17	5	\N	1977
3954	35	7	9	8	11	\N	1977
3955	\N	\N	\N	\N	\N	\N	1978
3956	\N	\N	\N	\N	\N	\N	1978
3957	20	2	10	0	8	\N	1979
3958	32	3	14	0	15	\N	1979
3959	\N	\N	\N	\N	\N	\N	1980
3960	\N	\N	\N	\N	\N	\N	1980
3961	29	9	4	7	9	\N	1981
3962	31	10	17	0	4	\N	1981
3963	\N	\N	\N	\N	\N	\N	1982
3964	\N	\N	\N	\N	\N	\N	1982
3965	50	9	12	12	17	\N	1983
3966	29	4	5	17	3	\N	1983
3967	\N	\N	\N	\N	\N	\N	1984
3968	\N	\N	\N	\N	\N	\N	1984
3969	36	4	9	16	7	\N	1985
3970	17	2	13	1	1	\N	1985
3971	\N	\N	\N	\N	\N	\N	1986
3972	\N	\N	\N	\N	\N	\N	1986
3973	42	9	7	10	13	3	1987
3974	39	1	16	17	5	0	1987
3975	\N	\N	\N	\N	\N	\N	1988
3976	\N	\N	\N	\N	\N	\N	1988
3977	24	1	10	4	9	\N	1989
3978	37	16	10	5	6	\N	1989
3979	\N	\N	\N	\N	\N	\N	1990
3980	\N	\N	\N	\N	\N	\N	1990
3981	44	12	8	9	15	\N	1991
3982	38	4	13	4	17	\N	1991
3983	\N	\N	\N	\N	\N	\N	1992
3984	\N	\N	\N	\N	\N	\N	1992
3985	24	11	2	8	3	\N	1993
3986	20	0	10	10	0	\N	1993
3987	\N	\N	\N	\N	\N	\N	1994
3988	\N	\N	\N	\N	\N	\N	1994
3989	14	0	3	4	7	\N	1995
3990	29	2	4	6	17	\N	1995
3991	\N	\N	\N	\N	\N	\N	1996
3992	\N	\N	\N	\N	\N	\N	1996
3993	31	1	15	2	13	\N	1997
3994	32	17	2	5	8	\N	1997
3995	\N	\N	\N	\N	\N	\N	1998
3996	\N	\N	\N	\N	\N	\N	1998
3997	36	14	11	11	0	\N	1999
3998	34	8	13	12	1	\N	1999
3999	\N	\N	\N	\N	\N	\N	2000
4000	\N	\N	\N	\N	\N	\N	2000
4001	45	17	12	12	4	0	2001
4002	48	14	16	6	9	3	2001
4003	\N	\N	\N	\N	\N	\N	2002
4004	\N	\N	\N	\N	\N	\N	2002
4005	27	10	4	5	8	\N	2003
4006	14	0	4	10	0	\N	2003
4007	\N	\N	\N	\N	\N	\N	2004
4008	\N	\N	\N	\N	\N	\N	2004
4009	45	13	12	14	6	\N	2005
4010	40	7	11	7	15	\N	2005
4011	\N	\N	\N	\N	\N	\N	2006
4012	\N	\N	\N	\N	\N	\N	2006
4013	37	9	10	11	7	\N	2007
4014	29	9	1	12	7	\N	2007
4015	\N	\N	\N	\N	\N	\N	2008
4016	\N	\N	\N	\N	\N	\N	2008
4017	33	6	14	2	11	\N	2009
4018	41	9	14	1	17	\N	2009
4019	\N	\N	\N	\N	\N	\N	2010
4020	\N	\N	\N	\N	\N	\N	2010
4021	37	2	5	14	16	\N	2011
4022	36	7	12	14	3	\N	2011
4023	\N	\N	\N	\N	\N	\N	2012
4024	\N	\N	\N	\N	\N	\N	2012
4025	15	11	0	4	0	\N	2013
4026	35	0	10	11	14	\N	2013
4027	\N	\N	\N	\N	\N	\N	2014
4028	\N	\N	\N	\N	\N	\N	2014
4029	50	16	11	7	16	\N	2015
4030	22	0	3	17	2	\N	2015
4031	\N	\N	\N	\N	\N	\N	2016
4032	\N	\N	\N	\N	\N	\N	2016
4033	40	11	10	16	3	\N	2017
4034	26	8	2	14	2	\N	2017
4035	\N	\N	\N	\N	\N	\N	2018
4036	\N	\N	\N	\N	\N	\N	2018
4037	45	14	15	7	9	\N	2019
4038	39	3	9	14	13	\N	2019
4039	\N	\N	\N	\N	\N	\N	2020
4040	\N	\N	\N	\N	\N	\N	2020
4041	32	10	9	2	11	\N	2021
4042	25	6	13	5	1	\N	2021
4043	\N	\N	\N	\N	\N	\N	2022
4044	\N	\N	\N	\N	\N	\N	2022
4045	42	12	2	12	16	\N	2023
4046	54	10	16	15	13	\N	2023
4047	\N	\N	\N	\N	\N	\N	2024
4048	\N	\N	\N	\N	\N	\N	2024
4049	41	13	12	3	13	\N	2025
4050	33	6	14	11	2	\N	2025
4051	\N	\N	\N	\N	\N	\N	2026
4053	26	3	6	14	3	\N	2027
4054	36	15	8	3	10	\N	2027
4055	\N	\N	\N	\N	\N	\N	2028
4056	\N	\N	\N	\N	\N	\N	2028
4057	27	0	0	16	11	\N	2029
4058	46	14	14	7	11	\N	2029
4059	\N	\N	\N	\N	\N	\N	2030
4060	\N	\N	\N	\N	\N	\N	2030
4061	42	9	7	17	9	\N	2031
4062	44	10	14	9	11	\N	2031
4063	\N	\N	\N	\N	\N	\N	2032
4064	\N	\N	\N	\N	\N	\N	2032
4065	40	9	11	7	13	\N	2033
4066	32	17	3	4	8	\N	2033
4067	\N	\N	\N	\N	\N	\N	2034
4068	\N	\N	\N	\N	\N	\N	2034
4069	43	4	9	16	14	\N	2035
4070	44	16	9	13	6	\N	2035
4071	\N	\N	\N	\N	\N	\N	2036
4072	\N	\N	\N	\N	\N	\N	2036
4073	15	7	7	0	1	\N	2037
4074	27	10	2	11	4	\N	2037
4075	\N	\N	\N	\N	\N	\N	2038
4076	\N	\N	\N	\N	\N	\N	2038
4077	52	14	16	15	7	\N	2039
4078	39	11	12	15	1	\N	2039
4079	\N	\N	\N	\N	\N	\N	2040
4080	\N	\N	\N	\N	\N	\N	2040
4081	27	9	1	2	15	\N	2041
4082	48	13	13	13	9	\N	2041
4083	\N	\N	\N	\N	\N	\N	2042
4084	\N	\N	\N	\N	\N	\N	2042
4085	36	2	12	6	16	\N	2043
4086	35	13	2	16	4	\N	2043
4087	\N	\N	\N	\N	\N	\N	2044
4088	\N	\N	\N	\N	\N	\N	2044
4089	21	15	3	2	1	\N	2045
4090	37	9	13	9	6	\N	2045
4091	\N	\N	\N	\N	\N	\N	2046
4092	\N	\N	\N	\N	\N	\N	2046
4093	37	8	13	0	16	\N	2047
4094	29	16	6	2	5	\N	2047
4095	\N	\N	\N	\N	\N	\N	2048
4096	\N	\N	\N	\N	\N	\N	2048
4097	21	10	6	3	2	\N	2049
4098	19	1	12	3	3	\N	2049
4099	\N	\N	\N	\N	\N	\N	2050
4100	\N	\N	\N	\N	\N	\N	2050
4101	36	3	13	8	12	\N	2051
4102	35	8	10	0	17	\N	2051
4103	\N	\N	\N	\N	\N	\N	2052
4104	\N	\N	\N	\N	\N	\N	2052
4105	28	12	7	2	7	\N	2053
4106	44	12	13	17	2	\N	2053
4107	\N	\N	\N	\N	\N	\N	2054
4108	\N	\N	\N	\N	\N	\N	2054
4109	37	12	10	1	14	\N	2055
4110	32	7	2	9	14	\N	2055
4111	\N	\N	\N	\N	\N	\N	2056
4112	\N	\N	\N	\N	\N	\N	2056
4113	44	4	13	15	12	\N	2057
4114	22	0	13	4	5	\N	2057
4115	\N	\N	\N	\N	\N	\N	2058
4116	\N	\N	\N	\N	\N	\N	2058
4117	41	9	11	14	7	0	2059
4118	47	15	13	2	11	6	2059
4119	\N	\N	\N	\N	\N	\N	2060
4120	\N	\N	\N	\N	\N	\N	2060
4121	38	13	1	11	13	\N	2061
4122	36	15	5	9	7	\N	2061
4123	\N	\N	\N	\N	\N	\N	2062
4124	\N	\N	\N	\N	\N	\N	2062
4125	23	8	3	3	9	\N	2063
4126	36	8	6	17	5	\N	2063
4127	\N	\N	\N	\N	\N	\N	2064
4128	\N	\N	\N	\N	\N	\N	2064
4129	32	2	5	8	17	\N	2065
4130	22	11	8	2	1	\N	2065
4131	\N	\N	\N	\N	\N	\N	2066
4132	\N	\N	\N	\N	\N	\N	2066
4133	28	3	9	0	16	\N	2067
4134	21	0	8	8	5	\N	2067
4135	\N	\N	\N	\N	\N	\N	2068
4136	\N	\N	\N	\N	\N	\N	2068
4137	32	9	1	5	17	\N	2069
4138	12	0	3	0	9	\N	2069
4139	\N	\N	\N	\N	\N	\N	2070
4140	\N	\N	\N	\N	\N	\N	2070
4141	24	3	4	3	14	\N	2071
4142	35	8	11	6	10	\N	2071
4143	\N	\N	\N	\N	\N	\N	2072
4144	\N	\N	\N	\N	\N	\N	2072
4145	41	15	3	6	17	\N	2073
4146	32	5	12	15	0	\N	2073
4147	\N	\N	\N	\N	\N	\N	2074
4148	\N	\N	\N	\N	\N	\N	2074
4149	26	12	6	0	8	\N	2075
4150	35	10	16	7	2	\N	2075
4151	\N	\N	\N	\N	\N	\N	2076
4152	\N	\N	\N	\N	\N	\N	2076
4153	44	13	16	12	3	\N	2077
4154	52	12	16	10	14	\N	2077
4155	\N	\N	\N	\N	\N	\N	2078
4156	\N	\N	\N	\N	\N	\N	2078
4157	41	15	3	12	11	\N	2079
4158	34	5	17	8	4	\N	2079
4159	\N	\N	\N	\N	\N	\N	2080
4160	\N	\N	\N	\N	\N	\N	2080
4161	32	16	10	0	6	\N	2081
4162	41	15	16	2	8	\N	2081
4163	\N	\N	\N	\N	\N	\N	2082
4164	\N	\N	\N	\N	\N	\N	2082
4165	35	13	3	6	13	\N	2083
4166	27	15	2	8	2	\N	2083
4167	\N	\N	\N	\N	\N	\N	2084
4168	\N	\N	\N	\N	\N	\N	2084
4169	36	7	8	15	6	\N	2085
4170	24	5	4	15	0	\N	2085
4171	\N	\N	\N	\N	\N	\N	2086
4172	\N	\N	\N	\N	\N	\N	2086
4173	36	13	12	4	7	\N	2087
4174	22	11	0	3	8	\N	2087
4175	\N	\N	\N	\N	\N	\N	2088
4176	\N	\N	\N	\N	\N	\N	2088
4177	41	7	12	14	8	\N	2089
4178	26	5	4	11	6	\N	2089
4179	\N	\N	\N	\N	\N	\N	2090
4180	\N	\N	\N	\N	\N	\N	2090
4181	28	3	10	6	9	\N	2091
4182	34	9	7	7	11	\N	2091
4183	\N	\N	\N	\N	\N	\N	2092
4184	\N	\N	\N	\N	\N	\N	2092
4185	39	16	0	7	16	\N	2093
4186	58	16	13	16	13	\N	2093
4187	\N	\N	\N	\N	\N	\N	2094
4188	\N	\N	\N	\N	\N	\N	2094
4189	47	17	7	15	8	\N	2095
4190	46	8	17	7	14	\N	2095
4191	\N	\N	\N	\N	\N	\N	2096
4192	\N	\N	\N	\N	\N	\N	2096
4193	45	15	11	8	11	\N	2097
4194	50	17	3	13	17	\N	2097
4195	\N	\N	\N	\N	\N	\N	2098
4196	\N	\N	\N	\N	\N	\N	2098
4197	13	7	6	0	0	\N	2099
4198	45	12	1	17	15	\N	2099
4199	\N	\N	\N	\N	\N	\N	2100
4200	\N	\N	\N	\N	\N	\N	2100
4201	48	5	13	16	14	\N	2101
4202	15	1	7	1	6	\N	2101
4203	\N	\N	\N	\N	\N	\N	2102
4204	\N	\N	\N	\N	\N	\N	2102
4205	23	0	7	15	1	\N	2103
4206	13	6	2	2	3	\N	2103
4207	\N	\N	\N	\N	\N	\N	2104
4208	\N	\N	\N	\N	\N	\N	2104
4209	37	12	4	16	5	\N	2105
4210	44	16	12	2	14	\N	2105
4211	\N	\N	\N	\N	\N	\N	2106
4212	\N	\N	\N	\N	\N	\N	2106
4213	54	11	13	15	15	\N	2107
4214	35	2	9	9	15	\N	2107
4215	\N	\N	\N	\N	\N	\N	2108
4216	\N	\N	\N	\N	\N	\N	2108
4217	26	13	3	0	10	\N	2109
4218	42	12	13	7	10	\N	2109
4219	\N	\N	\N	\N	\N	\N	2110
4220	\N	\N	\N	\N	\N	\N	2110
4221	43	11	13	16	3	\N	2111
4392	\N	\N	\N	\N	\N	\N	2196
4222	19	6	8	4	1	\N	2111
4223	\N	\N	\N	\N	\N	\N	2112
4224	\N	\N	\N	\N	\N	\N	2112
4225	26	10	2	5	9	\N	2113
4226	24	1	13	10	0	\N	2113
4227	\N	\N	\N	\N	\N	\N	2114
4228	\N	\N	\N	\N	\N	\N	2114
4229	36	12	0	16	8	\N	2115
4230	20	0	2	4	14	\N	2115
4231	\N	\N	\N	\N	\N	\N	2116
4232	\N	\N	\N	\N	\N	\N	2116
4233	31	12	11	8	0	\N	2117
4234	37	11	13	1	12	\N	2117
4235	\N	\N	\N	\N	\N	\N	2118
4236	\N	\N	\N	\N	\N	\N	2118
4237	26	2	7	7	10	\N	2119
4238	18	5	5	2	6	\N	2119
4239	\N	\N	\N	\N	\N	\N	2120
4240	\N	\N	\N	\N	\N	\N	2120
4241	42	3	15	16	8	\N	2121
4242	26	3	7	9	7	\N	2121
4243	\N	\N	\N	\N	\N	\N	2122
4244	\N	\N	\N	\N	\N	\N	2122
4245	25	1	10	7	7	\N	2123
4246	42	1	15	9	17	\N	2123
4247	\N	\N	\N	\N	\N	\N	2124
4248	\N	\N	\N	\N	\N	\N	2124
4249	36	8	6	10	12	\N	2125
4250	19	4	10	4	1	\N	2125
4251	\N	\N	\N	\N	\N	\N	2126
4252	\N	\N	\N	\N	\N	\N	2126
4253	11	2	3	3	3	\N	2127
4254	34	17	4	9	4	\N	2127
4255	\N	\N	\N	\N	\N	\N	2128
4256	\N	\N	\N	\N	\N	\N	2128
4257	24	2	15	3	4	\N	2129
4258	55	16	8	14	17	\N	2129
4259	\N	\N	\N	\N	\N	\N	2130
4260	\N	\N	\N	\N	\N	\N	2130
4261	30	13	7	3	7	\N	2131
4262	37	8	17	10	2	\N	2131
4263	\N	\N	\N	\N	\N	\N	2132
4264	\N	\N	\N	\N	\N	\N	2132
4265	29	4	16	8	1	\N	2133
4266	41	0	15	15	11	\N	2133
4267	\N	\N	\N	\N	\N	\N	2134
4268	\N	\N	\N	\N	\N	\N	2134
4269	28	7	11	2	8	\N	2135
4270	38	4	16	3	15	\N	2135
4271	\N	\N	\N	\N	\N	\N	2136
4272	\N	\N	\N	\N	\N	\N	2136
4273	32	17	15	0	0	\N	2137
4274	45	14	3	17	11	\N	2137
4275	\N	\N	\N	\N	\N	\N	2138
4276	\N	\N	\N	\N	\N	\N	2138
4277	44	14	6	14	10	\N	2139
4278	19	6	2	8	3	\N	2139
4279	\N	\N	\N	\N	\N	\N	2140
4280	\N	\N	\N	\N	\N	\N	2140
4281	41	5	16	3	17	\N	2141
4282	23	0	9	2	12	\N	2141
4283	\N	\N	\N	\N	\N	\N	2142
4284	\N	\N	\N	\N	\N	\N	2142
4285	40	14	9	9	8	\N	2143
4286	36	16	11	2	7	\N	2143
4287	\N	\N	\N	\N	\N	\N	2144
4288	\N	\N	\N	\N	\N	\N	2144
4289	43	16	11	0	16	\N	2145
4290	23	16	3	2	2	\N	2145
4291	\N	\N	\N	\N	\N	\N	2146
4292	\N	\N	\N	\N	\N	\N	2146
4293	15	6	2	5	2	\N	2147
4294	28	12	5	2	9	\N	2147
4295	\N	\N	\N	\N	\N	\N	2148
4296	\N	\N	\N	\N	\N	\N	2148
4297	32	4	0	17	11	\N	2149
4298	47	13	10	11	13	\N	2149
4299	\N	\N	\N	\N	\N	\N	2150
4300	\N	\N	\N	\N	\N	\N	2150
4301	27	5	10	5	7	\N	2151
4302	28	0	13	8	7	\N	2151
4303	\N	\N	\N	\N	\N	\N	2152
4304	\N	\N	\N	\N	\N	\N	2152
4305	47	10	6	15	16	\N	2153
4306	19	5	3	8	3	\N	2153
4307	\N	\N	\N	\N	\N	\N	2154
4308	\N	\N	\N	\N	\N	\N	2154
4309	52	16	11	16	9	\N	2155
4310	46	16	9	14	7	\N	2155
4311	\N	\N	\N	\N	\N	\N	2156
4312	\N	\N	\N	\N	\N	\N	2156
4313	34	9	16	7	2	\N	2157
4314	18	6	2	7	3	\N	2157
4315	\N	\N	\N	\N	\N	\N	2158
4316	\N	\N	\N	\N	\N	\N	2158
4317	42	6	5	14	17	\N	2159
4318	31	6	0	11	14	\N	2159
4319	\N	\N	\N	\N	\N	\N	2160
4320	\N	\N	\N	\N	\N	\N	2160
4321	53	15	10	16	12	\N	2161
4322	26	0	10	9	7	\N	2161
4323	\N	\N	\N	\N	\N	\N	2162
4324	\N	\N	\N	\N	\N	\N	2162
4325	25	6	11	3	5	\N	2163
4326	33	13	9	7	4	\N	2163
4327	\N	\N	\N	\N	\N	\N	2164
4328	\N	\N	\N	\N	\N	\N	2164
4329	26	1	11	6	8	\N	2165
4330	48	15	16	16	1	\N	2165
4331	\N	\N	\N	\N	\N	\N	2166
4332	\N	\N	\N	\N	\N	\N	2166
4333	24	1	13	6	4	\N	2167
4334	29	4	5	7	13	\N	2167
4335	\N	\N	\N	\N	\N	\N	2168
4336	\N	\N	\N	\N	\N	\N	2168
4337	35	5	17	12	1	\N	2169
4338	10	6	0	2	2	\N	2169
4339	\N	\N	\N	\N	\N	\N	2170
4340	\N	\N	\N	\N	\N	\N	2170
4341	39	14	8	12	5	\N	2171
4342	35	8	8	13	6	\N	2171
4343	\N	\N	\N	\N	\N	\N	2172
4344	\N	\N	\N	\N	\N	\N	2172
4345	42	15	14	1	12	\N	2173
4346	40	9	10	12	9	\N	2173
4347	\N	\N	\N	\N	\N	\N	2174
4348	\N	\N	\N	\N	\N	\N	2174
4349	38	17	0	7	14	\N	2175
4350	47	17	7	10	13	\N	2175
4351	\N	\N	\N	\N	\N	\N	2176
4352	\N	\N	\N	\N	\N	\N	2176
4353	39	10	7	8	14	\N	2177
4354	38	7	9	5	17	\N	2177
4355	\N	\N	\N	\N	\N	\N	2178
4356	\N	\N	\N	\N	\N	\N	2178
4357	40	9	8	10	13	\N	2179
4358	25	17	1	0	7	\N	2179
4359	\N	\N	\N	\N	\N	\N	2180
4360	\N	\N	\N	\N	\N	\N	2180
4361	46	15	14	6	11	\N	2181
4362	33	0	3	14	16	\N	2181
4363	\N	\N	\N	\N	\N	\N	2182
4364	\N	\N	\N	\N	\N	\N	2182
4365	47	14	6	16	11	\N	2183
4366	44	4	6	17	17	\N	2183
4367	\N	\N	\N	\N	\N	\N	2184
4368	\N	\N	\N	\N	\N	\N	2184
4369	32	15	2	9	6	\N	2185
4370	34	11	6	8	9	\N	2185
4371	\N	\N	\N	\N	\N	\N	2186
4372	\N	\N	\N	\N	\N	\N	2186
4373	46	16	8	8	14	\N	2187
4374	31	6	8	2	15	\N	2187
4375	\N	\N	\N	\N	\N	\N	2188
4376	\N	\N	\N	\N	\N	\N	2188
4377	39	10	7	15	7	\N	2189
4378	26	5	13	6	2	\N	2189
4379	\N	\N	\N	\N	\N	\N	2190
4380	\N	\N	\N	\N	\N	\N	2190
4381	52	6	17	14	15	\N	2191
4382	29	9	4	7	9	\N	2191
4383	\N	\N	\N	\N	\N	\N	2192
4384	\N	\N	\N	\N	\N	\N	2192
4385	20	5	1	12	2	\N	2193
4386	28	7	3	14	4	\N	2193
4387	\N	\N	\N	\N	\N	\N	2194
4388	\N	\N	\N	\N	\N	\N	2194
4389	31	1	0	15	15	\N	2195
4390	20	0	1	8	11	\N	2195
4391	\N	\N	\N	\N	\N	\N	2196
4393	37	15	9	11	2	\N	2197
4394	35	2	15	3	15	\N	2197
4395	\N	\N	\N	\N	\N	\N	2198
4396	\N	\N	\N	\N	\N	\N	2198
4397	30	12	2	16	0	\N	2199
4398	51	11	15	15	10	\N	2199
4399	\N	\N	\N	\N	\N	\N	2200
4400	\N	\N	\N	\N	\N	\N	2200
4401	9	1	1	6	1	\N	2201
4402	35	12	3	7	13	\N	2201
4403	\N	\N	\N	\N	\N	\N	2202
4404	\N	\N	\N	\N	\N	\N	2202
4405	40	1	11	17	11	\N	2203
4406	37	4	7	11	15	\N	2203
4407	\N	\N	\N	\N	\N	\N	2204
4408	\N	\N	\N	\N	\N	\N	2204
4409	25	7	6	6	6	\N	2205
4410	31	3	9	14	5	\N	2205
4411	\N	\N	\N	\N	\N	\N	2206
4412	\N	\N	\N	\N	\N	\N	2206
4413	53	17	16	13	7	\N	2207
4414	25	4	7	5	9	\N	2207
4415	\N	\N	\N	\N	\N	\N	2208
4416	\N	\N	\N	\N	\N	\N	2208
4417	16	7	2	3	4	\N	2209
4418	15	0	2	4	9	\N	2209
4419	\N	\N	\N	\N	\N	\N	2210
4420	\N	\N	\N	\N	\N	\N	2210
4421	15	7	2	4	2	\N	2211
4422	28	0	7	7	14	\N	2211
4423	\N	\N	\N	\N	\N	\N	2212
4424	\N	\N	\N	\N	\N	\N	2212
4425	22	1	12	5	4	\N	2213
4426	48	4	12	15	17	\N	2213
4427	\N	\N	\N	\N	\N	\N	2214
4428	\N	\N	\N	\N	\N	\N	2214
4429	43	2	14	10	17	\N	2215
4430	25	10	15	0	0	\N	2215
4431	\N	\N	\N	\N	\N	\N	2216
4432	\N	\N	\N	\N	\N	\N	2216
4433	28	4	5	8	11	\N	2217
4434	35	11	17	4	3	\N	2217
4435	\N	\N	\N	\N	\N	\N	2218
4436	\N	\N	\N	\N	\N	\N	2218
4437	30	12	11	5	2	\N	2219
4438	35	11	1	8	15	\N	2219
4439	\N	\N	\N	\N	\N	\N	2220
4440	\N	\N	\N	\N	\N	\N	2220
4441	39	3	11	16	9	\N	2221
4442	36	4	5	12	15	\N	2221
4443	\N	\N	\N	\N	\N	\N	2222
4444	\N	\N	\N	\N	\N	\N	2222
4445	30	12	12	6	0	\N	2223
4446	35	4	13	12	6	\N	2223
4447	\N	\N	\N	\N	\N	\N	2224
4448	\N	\N	\N	\N	\N	\N	2224
4449	22	7	1	3	11	\N	2225
4450	33	11	10	9	3	\N	2225
4451	\N	\N	\N	\N	\N	\N	2226
4452	\N	\N	\N	\N	\N	\N	2226
4453	38	17	3	17	1	\N	2227
4454	26	9	15	2	0	\N	2227
4455	\N	\N	\N	\N	\N	\N	2228
4456	\N	\N	\N	\N	\N	\N	2228
4457	38	11	7	12	8	\N	2229
4458	40	2	12	13	13	\N	2229
4459	\N	\N	\N	\N	\N	\N	2230
4460	\N	\N	\N	\N	\N	\N	2230
4461	48	16	14	8	10	\N	2231
4462	13	0	2	4	7	\N	2231
4463	\N	\N	\N	\N	\N	\N	2232
4464	\N	\N	\N	\N	\N	\N	2232
4465	38	8	12	3	15	\N	2233
4466	22	1	14	0	7	\N	2233
4467	\N	\N	\N	\N	\N	\N	2234
4468	\N	\N	\N	\N	\N	\N	2234
4469	35	13	12	5	5	\N	2235
4470	16	4	2	3	7	\N	2235
4471	\N	\N	\N	\N	\N	\N	2236
4472	\N	\N	\N	\N	\N	\N	2236
4473	64	15	16	17	16	\N	2237
4474	38	9	11	13	5	\N	2237
4475	\N	\N	\N	\N	\N	\N	2238
4476	\N	\N	\N	\N	\N	\N	2238
4477	34	10	13	5	6	\N	2239
4478	44	8	17	4	15	\N	2239
4479	\N	\N	\N	\N	\N	\N	2240
4480	\N	\N	\N	\N	\N	\N	2240
4481	13	2	2	4	5	\N	2241
4482	25	7	1	3	14	\N	2241
4483	\N	\N	\N	\N	\N	\N	2242
4484	\N	\N	\N	\N	\N	\N	2242
4485	34	10	3	6	15	\N	2243
4486	47	12	10	17	8	\N	2243
4487	\N	\N	\N	\N	\N	\N	2244
4488	\N	\N	\N	\N	\N	\N	2244
4489	16	1	1	13	1	\N	2245
4490	15	5	7	1	2	\N	2245
4491	\N	\N	\N	\N	\N	\N	2246
4492	\N	\N	\N	\N	\N	\N	2246
4493	33	15	2	3	7	6	2247
4494	27	9	10	4	4	0	2247
4495	\N	\N	\N	\N	\N	\N	2248
4496	\N	\N	\N	\N	\N	\N	2248
4497	27	12	9	5	1	\N	2249
4498	38	12	11	6	9	\N	2249
4499	\N	\N	\N	\N	\N	\N	2250
4500	\N	\N	\N	\N	\N	\N	2250
4501	30	3	14	3	10	\N	2251
4502	23	5	0	5	13	\N	2251
4503	\N	\N	\N	\N	\N	\N	2252
4504	\N	\N	\N	\N	\N	\N	2252
4505	51	12	10	17	12	\N	2253
4506	22	7	10	5	0	\N	2253
4507	\N	\N	\N	\N	\N	\N	2254
4508	\N	\N	\N	\N	\N	\N	2254
4509	43	11	9	12	11	\N	2255
4510	28	8	14	3	3	\N	2255
4511	\N	\N	\N	\N	\N	\N	2256
4512	\N	\N	\N	\N	\N	\N	2256
4513	33	8	7	13	5	\N	2257
4514	35	8	12	5	10	\N	2257
4515	\N	\N	\N	\N	\N	\N	2258
4516	\N	\N	\N	\N	\N	\N	2258
4517	40	10	14	9	7	\N	2259
4518	36	8	15	3	10	\N	2259
4519	\N	\N	\N	\N	\N	\N	2260
4520	\N	\N	\N	\N	\N	\N	2260
4521	32	4	15	6	7	\N	2261
4522	50	17	17	7	9	\N	2261
4523	\N	\N	\N	\N	\N	\N	2262
4524	\N	\N	\N	\N	\N	\N	2262
4525	34	15	3	0	16	\N	2263
4526	29	6	8	14	1	\N	2263
4527	\N	\N	\N	\N	\N	\N	2264
4528	\N	\N	\N	\N	\N	\N	2264
4529	12	6	2	0	4	\N	2265
4530	31	5	9	13	4	\N	2265
4531	\N	\N	\N	\N	\N	\N	2266
4532	\N	\N	\N	\N	\N	\N	2266
4533	31	2	15	9	5	\N	2267
4534	26	6	4	4	12	\N	2267
4535	\N	\N	\N	\N	\N	\N	2268
4536	\N	\N	\N	\N	\N	\N	2268
4537	41	13	1	14	13	\N	2269
4538	21	1	11	8	1	\N	2269
4539	\N	\N	\N	\N	\N	\N	2270
4540	\N	\N	\N	\N	\N	\N	2270
4541	38	2	10	16	10	\N	2271
4542	29	1	9	11	8	\N	2271
4543	\N	\N	\N	\N	\N	\N	2272
4544	\N	\N	\N	\N	\N	\N	2272
4545	49	17	7	11	14	\N	2273
4546	34	8	1	14	11	\N	2273
4547	\N	\N	\N	\N	\N	\N	2274
4548	\N	\N	\N	\N	\N	\N	2274
4549	26	6	13	0	7	\N	2275
4550	24	3	14	0	7	\N	2275
4551	\N	\N	\N	\N	\N	\N	2276
4552	\N	\N	\N	\N	\N	\N	2276
4553	37	3	16	17	1	\N	2277
4554	21	4	0	2	15	\N	2277
4555	\N	\N	\N	\N	\N	\N	2278
4556	\N	\N	\N	\N	\N	\N	2278
4557	31	8	17	6	0	\N	2279
4558	43	15	3	17	8	\N	2279
4559	\N	\N	\N	\N	\N	\N	2280
4560	\N	\N	\N	\N	\N	\N	2280
4561	53	13	17	16	7	\N	2281
5165	\N	\N	\N	\N	\N	\N	2583
4562	32	10	3	2	17	\N	2281
4563	\N	\N	\N	\N	\N	\N	2282
4564	\N	\N	\N	\N	\N	\N	2282
4565	31	9	10	5	7	\N	2283
4566	25	0	14	0	11	\N	2283
4567	\N	\N	\N	\N	\N	\N	2284
4568	\N	\N	\N	\N	\N	\N	2284
4569	25	16	5	4	0	\N	2285
4570	47	17	13	3	14	\N	2285
4571	\N	\N	\N	\N	\N	\N	2286
4572	\N	\N	\N	\N	\N	\N	2286
4573	39	6	15	5	13	\N	2287
4574	38	5	11	9	13	\N	2287
4575	\N	\N	\N	\N	\N	\N	2288
4576	\N	\N	\N	\N	\N	\N	2288
4577	23	2	5	4	12	\N	2289
4578	38	10	4	17	7	\N	2289
4579	\N	\N	\N	\N	\N	\N	2290
4580	\N	\N	\N	\N	\N	\N	2290
4581	37	17	5	6	9	\N	2291
4582	33	8	14	4	7	\N	2291
4583	\N	\N	\N	\N	\N	\N	2292
4584	\N	\N	\N	\N	\N	\N	2292
4585	38	16	4	3	15	\N	2293
4586	22	9	5	8	0	\N	2293
4587	\N	\N	\N	\N	\N	\N	2294
4588	\N	\N	\N	\N	\N	\N	2294
4589	21	1	2	2	16	\N	2295
4590	47	12	13	10	12	\N	2295
4591	\N	\N	\N	\N	\N	\N	2296
4592	\N	\N	\N	\N	\N	\N	2296
4593	36	13	4	15	4	\N	2297
4594	26	12	5	2	7	\N	2297
4595	\N	\N	\N	\N	\N	\N	2298
4596	\N	\N	\N	\N	\N	\N	2298
4597	37	11	12	4	10	\N	2299
4598	39	13	15	6	5	\N	2299
4599	\N	\N	\N	\N	\N	\N	2300
4600	\N	\N	\N	\N	\N	\N	2300
4601	41	12	12	7	10	\N	2301
4602	26	17	2	6	1	\N	2301
4603	\N	\N	\N	\N	\N	\N	2302
4604	\N	\N	\N	\N	\N	\N	2302
4605	26	2	1	11	12	\N	2303
4606	37	7	14	13	3	\N	2303
4607	\N	\N	\N	\N	\N	\N	2304
4608	\N	\N	\N	\N	\N	\N	2304
4609	45	10	9	11	15	\N	2305
4610	39	13	9	9	8	\N	2305
4611	\N	\N	\N	\N	\N	\N	2306
4612	\N	\N	\N	\N	\N	\N	2306
4613	31	7	14	9	1	\N	2307
4614	32	7	8	5	12	\N	2307
4615	\N	\N	\N	\N	\N	\N	2308
4616	\N	\N	\N	\N	\N	\N	2308
4617	42	13	8	4	17	\N	2309
4618	30	1	16	9	4	\N	2309
4619	\N	\N	\N	\N	\N	\N	2310
4620	\N	\N	\N	\N	\N	\N	2310
4621	37	2	13	5	17	\N	2311
4622	23	0	7	6	10	\N	2311
4623	\N	\N	\N	\N	\N	\N	2312
4624	\N	\N	\N	\N	\N	\N	2312
4625	38	1	12	17	8	\N	2313
4626	26	5	14	4	3	\N	2313
4627	\N	\N	\N	\N	\N	\N	2314
4628	\N	\N	\N	\N	\N	\N	2314
4629	41	17	1	10	13	\N	2315
4630	38	15	2	5	16	\N	2315
4631	\N	\N	\N	\N	\N	\N	2316
4632	\N	\N	\N	\N	\N	\N	2316
4633	31	7	7	17	0	\N	2317
4634	22	2	12	4	4	\N	2317
4635	\N	\N	\N	\N	\N	\N	2318
4636	\N	\N	\N	\N	\N	\N	2318
4637	32	14	0	0	12	6	2319
4638	26	8	9	4	5	0	2319
4639	\N	\N	\N	\N	\N	\N	2320
4640	\N	\N	\N	\N	\N	\N	2320
4641	50	12	11	10	17	\N	2321
4642	52	16	9	13	14	\N	2321
4643	\N	\N	\N	\N	\N	\N	2322
4644	\N	\N	\N	\N	\N	\N	2322
4645	27	0	15	12	0	\N	2323
4646	51	15	13	16	7	\N	2323
4647	\N	\N	\N	\N	\N	\N	2324
4648	\N	\N	\N	\N	\N	\N	2324
4649	57	17	14	13	13	\N	2325
4650	29	3	15	10	1	\N	2325
4651	\N	\N	\N	\N	\N	\N	2326
4652	\N	\N	\N	\N	\N	\N	2326
4653	45	12	14	10	9	\N	2327
4654	26	0	6	10	10	\N	2327
4655	\N	\N	\N	\N	\N	\N	2328
4656	\N	\N	\N	\N	\N	\N	2328
4657	34	8	12	2	12	\N	2329
4658	44	15	3	12	14	\N	2329
4659	\N	\N	\N	\N	\N	\N	2330
4660	\N	\N	\N	\N	\N	\N	2330
4661	34	15	6	5	8	\N	2331
4662	26	6	2	17	1	\N	2331
4663	\N	\N	\N	\N	\N	\N	2332
4664	\N	\N	\N	\N	\N	\N	2332
4665	37	4	13	6	14	\N	2333
4666	26	4	3	5	14	\N	2333
4667	\N	\N	\N	\N	\N	\N	2334
4668	\N	\N	\N	\N	\N	\N	2334
4669	40	17	14	0	9	\N	2335
4670	35	6	4	17	8	\N	2335
4671	\N	\N	\N	\N	\N	\N	2336
4672	\N	\N	\N	\N	\N	\N	2336
4673	35	7	5	8	15	\N	2337
4674	28	16	1	1	10	\N	2337
4675	\N	\N	\N	\N	\N	\N	2338
4676	\N	\N	\N	\N	\N	\N	2338
4677	27	2	11	1	13	\N	2339
4678	40	14	14	4	8	\N	2339
4679	\N	\N	\N	\N	\N	\N	2340
4680	\N	\N	\N	\N	\N	\N	2340
4681	42	17	13	1	11	\N	2341
4682	32	14	6	8	4	\N	2341
4683	\N	\N	\N	\N	\N	\N	2342
4684	\N	\N	\N	\N	\N	\N	2342
4685	24	0	5	2	17	\N	2343
4686	38	3	13	10	12	\N	2343
4687	\N	\N	\N	\N	\N	\N	2344
4688	\N	\N	\N	\N	\N	\N	2344
4689	37	16	6	2	13	\N	2345
4690	17	0	1	0	16	\N	2345
4691	\N	\N	\N	\N	\N	\N	2346
4692	\N	\N	\N	\N	\N	\N	2346
4693	40	7	10	16	7	\N	2347
4694	37	13	7	2	15	\N	2347
4695	\N	\N	\N	\N	\N	\N	2348
4696	\N	\N	\N	\N	\N	\N	2348
4697	34	3	16	4	11	\N	2349
4698	23	6	3	5	9	\N	2349
4699	\N	\N	\N	\N	\N	\N	2350
4700	\N	\N	\N	\N	\N	\N	2350
4701	20	0	17	0	3	\N	2351
4702	32	3	17	7	5	\N	2351
4703	\N	\N	\N	\N	\N	\N	2352
4704	\N	\N	\N	\N	\N	\N	2352
4705	24	10	1	4	9	\N	2353
4706	35	5	3	17	10	\N	2353
4707	\N	\N	\N	\N	\N	\N	2354
4708	\N	\N	\N	\N	\N	\N	2354
4709	3	\N	\N	\N	3	\N	2355
4710	16	\N	\N	\N	16	\N	2355
4711	\N	\N	\N	\N	\N	\N	2356
4712	\N	\N	\N	\N	\N	\N	2356
4713	1	\N	\N	\N	1	\N	2357
4714	2	\N	\N	\N	2	\N	2357
4715	\N	\N	\N	\N	\N	\N	2358
4716	\N	\N	\N	\N	\N	\N	2358
4717	5	\N	\N	\N	5	\N	2359
4718	3	\N	\N	\N	3	\N	2359
4719	\N	\N	\N	\N	\N	\N	2360
4720	\N	\N	\N	\N	\N	\N	2360
4721	7	\N	\N	\N	7	\N	2361
4722	2	\N	\N	\N	2	\N	2361
4723	\N	\N	\N	\N	\N	\N	2362
4724	\N	\N	\N	\N	\N	\N	2362
4725	1	\N	\N	\N	1	\N	2363
4726	10	\N	\N	\N	10	\N	2363
4727	\N	\N	\N	\N	\N	\N	2364
4728	\N	\N	\N	\N	\N	\N	2364
4729	12	\N	\N	\N	12	\N	2365
4730	9	\N	\N	\N	9	\N	2365
4731	\N	\N	\N	\N	\N	\N	2366
4732	\N	\N	\N	\N	\N	\N	2366
4733	2	\N	\N	\N	2	\N	2367
4734	9	\N	\N	\N	9	\N	2367
4735	\N	\N	\N	\N	\N	\N	2368
4736	\N	\N	\N	\N	\N	\N	2368
4737	10	\N	\N	\N	10	\N	2369
4738	12	\N	\N	\N	12	\N	2369
4739	\N	\N	\N	\N	\N	\N	2370
4740	\N	\N	\N	\N	\N	\N	2370
4741	1	\N	\N	\N	1	\N	2371
4742	5	\N	\N	\N	5	\N	2371
4743	\N	\N	\N	\N	\N	\N	2372
4744	\N	\N	\N	\N	\N	\N	2372
4745	17	\N	\N	\N	17	\N	2373
4746	16	\N	\N	\N	16	\N	2373
4747	\N	\N	\N	\N	\N	\N	2374
4748	\N	\N	\N	\N	\N	\N	2374
4749	12	\N	\N	\N	12	\N	2375
4750	6	\N	\N	\N	6	\N	2375
4751	\N	\N	\N	\N	\N	\N	2376
4752	\N	\N	\N	\N	\N	\N	2376
4753	12	\N	\N	\N	12	\N	2377
4754	17	\N	\N	\N	17	\N	2377
4755	\N	\N	\N	\N	\N	\N	2378
4756	\N	\N	\N	\N	\N	\N	2378
4757	10	\N	\N	\N	10	\N	2379
4758	10	\N	\N	\N	10	\N	2379
4759	\N	\N	\N	\N	\N	\N	2380
4760	\N	\N	\N	\N	\N	\N	2380
4761	2	\N	\N	\N	2	\N	2381
4762	12	\N	\N	\N	12	\N	2381
4763	\N	\N	\N	\N	\N	\N	2382
4764	\N	\N	\N	\N	\N	\N	2382
4765	2	\N	\N	\N	2	\N	2383
4766	3	\N	\N	\N	3	\N	2383
4767	\N	\N	\N	\N	\N	\N	2384
4768	\N	\N	\N	\N	\N	\N	2384
4769	4	\N	\N	\N	4	\N	2385
4770	4	\N	\N	\N	4	\N	2385
4771	\N	\N	\N	\N	\N	\N	2386
4772	\N	\N	\N	\N	\N	\N	2386
4773	1	\N	\N	\N	1	\N	2387
4774	0	\N	\N	\N	0	\N	2387
4775	\N	\N	\N	\N	\N	\N	2388
4776	\N	\N	\N	\N	\N	\N	2388
4777	10	\N	\N	\N	10	\N	2389
4778	4	\N	\N	\N	4	\N	2389
4779	\N	\N	\N	\N	\N	\N	2390
4780	\N	\N	\N	\N	\N	\N	2390
4781	6	\N	\N	\N	6	\N	2391
4782	4	\N	\N	\N	4	\N	2391
4783	\N	\N	\N	\N	\N	\N	2392
4784	\N	\N	\N	\N	\N	\N	2392
4785	13	\N	\N	\N	13	\N	2393
4786	2	\N	\N	\N	2	\N	2393
4787	\N	\N	\N	\N	\N	\N	2394
4788	\N	\N	\N	\N	\N	\N	2394
4789	6	\N	\N	\N	6	\N	2395
4790	6	\N	\N	\N	6	\N	2395
4791	\N	\N	\N	\N	\N	\N	2396
4792	\N	\N	\N	\N	\N	\N	2396
4793	4	\N	\N	\N	4	\N	2397
4794	0	\N	\N	\N	0	\N	2397
4795	\N	\N	\N	\N	\N	\N	2398
4796	\N	\N	\N	\N	\N	\N	2398
4797	2	\N	\N	\N	2	\N	2399
4798	14	\N	\N	\N	14	\N	2399
4799	\N	\N	\N	\N	\N	\N	2400
4800	\N	\N	\N	\N	\N	\N	2400
4801	10	\N	\N	\N	10	\N	2401
4802	7	\N	\N	\N	7	\N	2401
4803	\N	\N	\N	\N	\N	\N	2402
4804	\N	\N	\N	\N	\N	\N	2402
4805	12	\N	\N	\N	12	\N	2403
4806	9	\N	\N	\N	9	\N	2403
4807	\N	\N	\N	\N	\N	\N	2404
4808	\N	\N	\N	\N	\N	\N	2404
4809	8	\N	\N	\N	8	\N	2405
4810	1	\N	\N	\N	1	\N	2405
4811	\N	\N	\N	\N	\N	\N	2406
4812	\N	\N	\N	\N	\N	\N	2406
4813	16	\N	\N	\N	16	\N	2407
4814	7	\N	\N	\N	7	\N	2407
4815	\N	\N	\N	\N	\N	\N	2408
4816	\N	\N	\N	\N	\N	\N	2408
4817	8	\N	\N	\N	8	\N	2409
4818	7	\N	\N	\N	7	\N	2409
4819	\N	\N	\N	\N	\N	\N	2410
4820	\N	\N	\N	\N	\N	\N	2410
4821	9	\N	\N	\N	9	\N	2411
4822	2	\N	\N	\N	2	\N	2411
4823	\N	\N	\N	\N	\N	\N	2412
4824	\N	\N	\N	\N	\N	\N	2412
4825	6	\N	\N	\N	6	\N	2413
4826	15	\N	\N	\N	15	\N	2413
4827	\N	\N	\N	\N	\N	\N	2414
4828	\N	\N	\N	\N	\N	\N	2414
4829	0	\N	\N	\N	0	\N	2415
4830	9	\N	\N	\N	9	\N	2415
4831	\N	\N	\N	\N	\N	\N	2416
4832	\N	\N	\N	\N	\N	\N	2416
4833	13	\N	\N	\N	13	\N	2417
4834	4	\N	\N	\N	4	\N	2417
4835	\N	\N	\N	\N	\N	\N	2418
4836	\N	\N	\N	\N	\N	\N	2418
4837	3	\N	\N	\N	3	\N	2419
4838	17	\N	\N	\N	17	\N	2419
4839	\N	\N	\N	\N	\N	\N	2420
4840	\N	\N	\N	\N	\N	\N	2420
4841	9	\N	\N	\N	9	\N	2421
4842	0	\N	\N	\N	0	\N	2421
4843	\N	\N	\N	\N	\N	\N	2422
4844	\N	\N	\N	\N	\N	\N	2422
4845	10	\N	\N	\N	10	\N	2423
4846	13	\N	\N	\N	13	\N	2423
4847	\N	\N	\N	\N	\N	\N	2424
4848	\N	\N	\N	\N	\N	\N	2424
4849	2	\N	\N	\N	2	\N	2425
4850	3	\N	\N	\N	3	\N	2425
4851	\N	\N	\N	\N	\N	\N	2426
4852	\N	\N	\N	\N	\N	\N	2426
4853	8	\N	\N	\N	8	\N	2427
4854	12	\N	\N	\N	12	\N	2427
4855	\N	\N	\N	\N	\N	\N	2428
4856	\N	\N	\N	\N	\N	\N	2428
4857	6	\N	\N	\N	6	\N	2429
4858	17	\N	\N	\N	17	\N	2429
4859	\N	\N	\N	\N	\N	\N	2430
4860	\N	\N	\N	\N	\N	\N	2430
4861	6	\N	\N	\N	6	\N	2431
4862	6	\N	\N	\N	6	\N	2431
4863	\N	\N	\N	\N	\N	\N	2432
4864	\N	\N	\N	\N	\N	\N	2432
4865	4	\N	\N	\N	4	\N	2433
4866	0	\N	\N	\N	0	\N	2433
4867	\N	\N	\N	\N	\N	\N	2434
4868	\N	\N	\N	\N	\N	\N	2434
4869	17	\N	\N	\N	17	\N	2435
4870	1	\N	\N	\N	1	\N	2435
4871	\N	\N	\N	\N	\N	\N	2436
4872	\N	\N	\N	\N	\N	\N	2436
4873	9	\N	\N	\N	9	\N	2437
4874	9	\N	\N	\N	9	\N	2437
4875	\N	\N	\N	\N	\N	\N	2438
4876	\N	\N	\N	\N	\N	\N	2438
4877	11	\N	\N	\N	11	\N	2439
4878	7	\N	\N	\N	7	\N	2439
4879	\N	\N	\N	\N	\N	\N	2440
4880	\N	\N	\N	\N	\N	\N	2440
4881	2	\N	\N	\N	2	\N	2441
4882	14	\N	\N	\N	14	\N	2441
4883	\N	\N	\N	\N	\N	\N	2442
4884	\N	\N	\N	\N	\N	\N	2442
4885	15	\N	\N	\N	15	\N	2443
4886	17	\N	\N	\N	17	\N	2443
4887	\N	\N	\N	\N	\N	\N	2444
4888	\N	\N	\N	\N	\N	\N	2444
4889	14	\N	\N	\N	14	\N	2445
4890	8	\N	\N	\N	8	\N	2445
4891	\N	\N	\N	\N	\N	\N	2446
4892	\N	\N	\N	\N	\N	\N	2446
4893	8	\N	\N	\N	8	\N	2447
4894	4	\N	\N	\N	4	\N	2447
4895	\N	\N	\N	\N	\N	\N	2448
4896	\N	\N	\N	\N	\N	\N	2448
4897	12	\N	\N	\N	12	\N	2449
4898	3	\N	\N	\N	3	\N	2449
4899	\N	\N	\N	\N	\N	\N	2450
4900	\N	\N	\N	\N	\N	\N	2450
4901	16	\N	\N	\N	16	\N	2451
4902	4	\N	\N	\N	4	\N	2451
4903	\N	\N	\N	\N	\N	\N	2452
4904	\N	\N	\N	\N	\N	\N	2452
4905	17	\N	\N	\N	17	\N	2453
4906	5	\N	\N	\N	5	\N	2453
4907	\N	\N	\N	\N	\N	\N	2454
4908	\N	\N	\N	\N	\N	\N	2454
4909	1	\N	\N	\N	1	\N	2455
4910	9	\N	\N	\N	9	\N	2455
4911	\N	\N	\N	\N	\N	\N	2456
4912	\N	\N	\N	\N	\N	\N	2456
4913	14	\N	\N	\N	14	\N	2457
4914	2	\N	\N	\N	2	\N	2457
4915	\N	\N	\N	\N	\N	\N	2458
4916	\N	\N	\N	\N	\N	\N	2458
4917	13	\N	\N	\N	13	\N	2459
4918	2	\N	\N	\N	2	\N	2459
4919	\N	\N	\N	\N	\N	\N	2460
4920	\N	\N	\N	\N	\N	\N	2460
4921	9	\N	\N	\N	9	\N	2461
4922	11	\N	\N	\N	11	\N	2461
4923	\N	\N	\N	\N	\N	\N	2462
4924	\N	\N	\N	\N	\N	\N	2462
4925	6	\N	\N	\N	6	\N	2463
4926	14	\N	\N	\N	14	\N	2463
4927	\N	\N	\N	\N	\N	\N	2464
4928	\N	\N	\N	\N	\N	\N	2464
4929	0	\N	\N	\N	0	\N	2465
4930	0	\N	\N	\N	0	\N	2465
4931	\N	\N	\N	\N	\N	\N	2466
4932	\N	\N	\N	\N	\N	\N	2466
4933	14	\N	\N	\N	14	\N	2467
4934	9	\N	\N	\N	9	\N	2467
4935	\N	\N	\N	\N	\N	\N	2468
4936	\N	\N	\N	\N	\N	\N	2468
4937	6	\N	\N	\N	6	\N	2469
4938	16	\N	\N	\N	16	\N	2469
4939	\N	\N	\N	\N	\N	\N	2470
4940	\N	\N	\N	\N	\N	\N	2470
4941	1	\N	\N	\N	1	\N	2471
4942	7	\N	\N	\N	7	\N	2471
4943	\N	\N	\N	\N	\N	\N	2472
4944	\N	\N	\N	\N	\N	\N	2472
4945	17	\N	\N	\N	17	\N	2473
4946	17	\N	\N	\N	17	\N	2473
4947	\N	\N	\N	\N	\N	\N	2474
4948	\N	\N	\N	\N	\N	\N	2474
4949	6	\N	\N	\N	6	\N	2475
4950	0	\N	\N	\N	0	\N	2475
4951	\N	\N	\N	\N	\N	\N	2476
4952	\N	\N	\N	\N	\N	\N	2476
4953	2	\N	\N	\N	2	\N	2477
4954	11	\N	\N	\N	11	\N	2477
4955	\N	\N	\N	\N	\N	\N	2478
4956	\N	\N	\N	\N	\N	\N	2478
4957	3	\N	\N	\N	3	\N	2479
4958	13	\N	\N	\N	13	\N	2479
4959	\N	\N	\N	\N	\N	\N	2480
4960	\N	\N	\N	\N	\N	\N	2480
4961	16	\N	\N	\N	16	\N	2481
4962	2	\N	\N	\N	2	\N	2481
4963	\N	\N	\N	\N	\N	\N	2482
4964	\N	\N	\N	\N	\N	\N	2482
4965	\N	\N	\N	\N	\N	\N	2483
4966	\N	\N	\N	\N	\N	\N	2483
4967	\N	\N	\N	\N	\N	\N	2484
4968	\N	\N	\N	\N	\N	\N	2484
4969	\N	\N	\N	\N	\N	\N	2485
4970	\N	\N	\N	\N	\N	\N	2485
4971	\N	\N	\N	\N	\N	\N	2486
4972	\N	\N	\N	\N	\N	\N	2486
4973	\N	\N	\N	\N	\N	\N	2487
4974	\N	\N	\N	\N	\N	\N	2487
4975	\N	\N	\N	\N	\N	\N	2488
4976	\N	\N	\N	\N	\N	\N	2488
4977	\N	\N	\N	\N	\N	\N	2489
4978	\N	\N	\N	\N	\N	\N	2489
4979	\N	\N	\N	\N	\N	\N	2490
4980	\N	\N	\N	\N	\N	\N	2490
4981	\N	\N	\N	\N	\N	\N	2491
4982	\N	\N	\N	\N	\N	\N	2491
4983	\N	\N	\N	\N	\N	\N	2492
4984	\N	\N	\N	\N	\N	\N	2492
4985	\N	\N	\N	\N	\N	\N	2493
4986	\N	\N	\N	\N	\N	\N	2493
4987	\N	\N	\N	\N	\N	\N	2494
4988	\N	\N	\N	\N	\N	\N	2494
4989	\N	\N	\N	\N	\N	\N	2495
4990	\N	\N	\N	\N	\N	\N	2495
4991	\N	\N	\N	\N	\N	\N	2496
4992	\N	\N	\N	\N	\N	\N	2496
4993	\N	\N	\N	\N	\N	\N	2497
4994	\N	\N	\N	\N	\N	\N	2497
4995	\N	\N	\N	\N	\N	\N	2498
4996	\N	\N	\N	\N	\N	\N	2498
4997	\N	\N	\N	\N	\N	\N	2499
4998	\N	\N	\N	\N	\N	\N	2499
4999	\N	\N	\N	\N	\N	\N	2500
5000	\N	\N	\N	\N	\N	\N	2500
5001	\N	\N	\N	\N	\N	\N	2501
5002	\N	\N	\N	\N	\N	\N	2501
5003	\N	\N	\N	\N	\N	\N	2502
5004	\N	\N	\N	\N	\N	\N	2502
5005	\N	\N	\N	\N	\N	\N	2503
5006	\N	\N	\N	\N	\N	\N	2503
5007	\N	\N	\N	\N	\N	\N	2504
5008	\N	\N	\N	\N	\N	\N	2504
5009	\N	\N	\N	\N	\N	\N	2505
5010	\N	\N	\N	\N	\N	\N	2505
5011	\N	\N	\N	\N	\N	\N	2506
5012	\N	\N	\N	\N	\N	\N	2506
5013	\N	\N	\N	\N	\N	\N	2507
5014	\N	\N	\N	\N	\N	\N	2507
5015	\N	\N	\N	\N	\N	\N	2508
5016	\N	\N	\N	\N	\N	\N	2508
5017	\N	\N	\N	\N	\N	\N	2509
5018	\N	\N	\N	\N	\N	\N	2509
5019	\N	\N	\N	\N	\N	\N	2510
5020	\N	\N	\N	\N	\N	\N	2510
5021	\N	\N	\N	\N	\N	\N	2511
5022	\N	\N	\N	\N	\N	\N	2511
5023	\N	\N	\N	\N	\N	\N	2512
5024	\N	\N	\N	\N	\N	\N	2512
5025	\N	\N	\N	\N	\N	\N	2513
5026	\N	\N	\N	\N	\N	\N	2513
5027	\N	\N	\N	\N	\N	\N	2514
5028	\N	\N	\N	\N	\N	\N	2514
5029	\N	\N	\N	\N	\N	\N	2515
5030	\N	\N	\N	\N	\N	\N	2515
5031	\N	\N	\N	\N	\N	\N	2516
5032	\N	\N	\N	\N	\N	\N	2516
5033	\N	\N	\N	\N	\N	\N	2517
5034	\N	\N	\N	\N	\N	\N	2517
5035	\N	\N	\N	\N	\N	\N	2518
5036	\N	\N	\N	\N	\N	\N	2518
5037	\N	\N	\N	\N	\N	\N	2519
5038	\N	\N	\N	\N	\N	\N	2519
5039	\N	\N	\N	\N	\N	\N	2520
5040	\N	\N	\N	\N	\N	\N	2520
5041	\N	\N	\N	\N	\N	\N	2521
5042	\N	\N	\N	\N	\N	\N	2521
5043	\N	\N	\N	\N	\N	\N	2522
5044	\N	\N	\N	\N	\N	\N	2522
5045	\N	\N	\N	\N	\N	\N	2523
5046	\N	\N	\N	\N	\N	\N	2523
5047	\N	\N	\N	\N	\N	\N	2524
5048	\N	\N	\N	\N	\N	\N	2524
5049	\N	\N	\N	\N	\N	\N	2525
5050	\N	\N	\N	\N	\N	\N	2525
5051	\N	\N	\N	\N	\N	\N	2526
5052	\N	\N	\N	\N	\N	\N	2526
5053	\N	\N	\N	\N	\N	\N	2527
5054	\N	\N	\N	\N	\N	\N	2527
5055	\N	\N	\N	\N	\N	\N	2528
5056	\N	\N	\N	\N	\N	\N	2528
5057	\N	\N	\N	\N	\N	\N	2529
5058	\N	\N	\N	\N	\N	\N	2529
5059	\N	\N	\N	\N	\N	\N	2530
5060	\N	\N	\N	\N	\N	\N	2530
5061	\N	\N	\N	\N	\N	\N	2531
5062	\N	\N	\N	\N	\N	\N	2531
5063	\N	\N	\N	\N	\N	\N	2532
5064	\N	\N	\N	\N	\N	\N	2532
5065	\N	\N	\N	\N	\N	\N	2533
5066	\N	\N	\N	\N	\N	\N	2533
5067	\N	\N	\N	\N	\N	\N	2534
5068	\N	\N	\N	\N	\N	\N	2534
5069	\N	\N	\N	\N	\N	\N	2535
5070	\N	\N	\N	\N	\N	\N	2535
5071	\N	\N	\N	\N	\N	\N	2536
5072	\N	\N	\N	\N	\N	\N	2536
5073	\N	\N	\N	\N	\N	\N	2537
5074	\N	\N	\N	\N	\N	\N	2537
5075	\N	\N	\N	\N	\N	\N	2538
5076	\N	\N	\N	\N	\N	\N	2538
5077	\N	\N	\N	\N	\N	\N	2539
5078	\N	\N	\N	\N	\N	\N	2539
5079	\N	\N	\N	\N	\N	\N	2540
5080	\N	\N	\N	\N	\N	\N	2540
5081	\N	\N	\N	\N	\N	\N	2541
5082	\N	\N	\N	\N	\N	\N	2541
5083	\N	\N	\N	\N	\N	\N	2542
5084	\N	\N	\N	\N	\N	\N	2542
5085	\N	\N	\N	\N	\N	\N	2543
5086	\N	\N	\N	\N	\N	\N	2543
5087	\N	\N	\N	\N	\N	\N	2544
5088	\N	\N	\N	\N	\N	\N	2544
5089	\N	\N	\N	\N	\N	\N	2545
5090	\N	\N	\N	\N	\N	\N	2545
5091	\N	\N	\N	\N	\N	\N	2546
5092	\N	\N	\N	\N	\N	\N	2546
5093	\N	\N	\N	\N	\N	\N	2547
5094	\N	\N	\N	\N	\N	\N	2547
5095	\N	\N	\N	\N	\N	\N	2548
5096	\N	\N	\N	\N	\N	\N	2548
5097	\N	\N	\N	\N	\N	\N	2549
5098	\N	\N	\N	\N	\N	\N	2549
5099	\N	\N	\N	\N	\N	\N	2550
5100	\N	\N	\N	\N	\N	\N	2550
5101	\N	\N	\N	\N	\N	\N	2551
5102	\N	\N	\N	\N	\N	\N	2551
5103	\N	\N	\N	\N	\N	\N	2552
5104	\N	\N	\N	\N	\N	\N	2552
5105	\N	\N	\N	\N	\N	\N	2553
5106	\N	\N	\N	\N	\N	\N	2553
5107	\N	\N	\N	\N	\N	\N	2554
5108	\N	\N	\N	\N	\N	\N	2554
5109	\N	\N	\N	\N	\N	\N	2555
5110	\N	\N	\N	\N	\N	\N	2555
5111	\N	\N	\N	\N	\N	\N	2556
5112	\N	\N	\N	\N	\N	\N	2556
5113	\N	\N	\N	\N	\N	\N	2557
5114	\N	\N	\N	\N	\N	\N	2557
5115	\N	\N	\N	\N	\N	\N	2558
5116	\N	\N	\N	\N	\N	\N	2558
5117	\N	\N	\N	\N	\N	\N	2559
5118	\N	\N	\N	\N	\N	\N	2559
5119	\N	\N	\N	\N	\N	\N	2560
5120	\N	\N	\N	\N	\N	\N	2560
5121	\N	\N	\N	\N	\N	\N	2561
5122	\N	\N	\N	\N	\N	\N	2561
5123	\N	\N	\N	\N	\N	\N	2562
5124	\N	\N	\N	\N	\N	\N	2562
5125	\N	\N	\N	\N	\N	\N	2563
5126	\N	\N	\N	\N	\N	\N	2563
5127	\N	\N	\N	\N	\N	\N	2564
5128	\N	\N	\N	\N	\N	\N	2564
5129	\N	\N	\N	\N	\N	\N	2565
5130	\N	\N	\N	\N	\N	\N	2565
5131	\N	\N	\N	\N	\N	\N	2566
5132	\N	\N	\N	\N	\N	\N	2566
5133	\N	\N	\N	\N	\N	\N	2567
5134	\N	\N	\N	\N	\N	\N	2567
5135	\N	\N	\N	\N	\N	\N	2568
5136	\N	\N	\N	\N	\N	\N	2568
5137	\N	\N	\N	\N	\N	\N	2569
5138	\N	\N	\N	\N	\N	\N	2569
5139	\N	\N	\N	\N	\N	\N	2570
5140	\N	\N	\N	\N	\N	\N	2570
5141	\N	\N	\N	\N	\N	\N	2571
5142	\N	\N	\N	\N	\N	\N	2571
5143	\N	\N	\N	\N	\N	\N	2572
5144	\N	\N	\N	\N	\N	\N	2572
5145	\N	\N	\N	\N	\N	\N	2573
5146	\N	\N	\N	\N	\N	\N	2573
5147	\N	\N	\N	\N	\N	\N	2574
5148	\N	\N	\N	\N	\N	\N	2574
5149	\N	\N	\N	\N	\N	\N	2575
5150	\N	\N	\N	\N	\N	\N	2575
5151	\N	\N	\N	\N	\N	\N	2576
5152	\N	\N	\N	\N	\N	\N	2576
5153	\N	\N	\N	\N	\N	\N	2577
5154	\N	\N	\N	\N	\N	\N	2577
5155	\N	\N	\N	\N	\N	\N	2578
5156	\N	\N	\N	\N	\N	\N	2578
5157	\N	\N	\N	\N	\N	\N	2579
5158	\N	\N	\N	\N	\N	\N	2579
5159	\N	\N	\N	\N	\N	\N	2580
5160	\N	\N	\N	\N	\N	\N	2580
5161	\N	\N	\N	\N	\N	\N	2581
5162	\N	\N	\N	\N	\N	\N	2581
5163	\N	\N	\N	\N	\N	\N	2582
5164	\N	\N	\N	\N	\N	\N	2582
5167	\N	\N	\N	\N	\N	\N	2584
5168	\N	\N	\N	\N	\N	\N	2584
5169	\N	\N	\N	\N	\N	\N	2585
5170	\N	\N	\N	\N	\N	\N	2585
5171	\N	\N	\N	\N	\N	\N	2586
5172	\N	\N	\N	\N	\N	\N	2586
5173	\N	\N	\N	\N	\N	\N	2587
5174	\N	\N	\N	\N	\N	\N	2587
5175	\N	\N	\N	\N	\N	\N	2588
5176	\N	\N	\N	\N	\N	\N	2588
5177	\N	\N	\N	\N	\N	\N	2589
5178	\N	\N	\N	\N	\N	\N	2589
5179	\N	\N	\N	\N	\N	\N	2590
5180	\N	\N	\N	\N	\N	\N	2590
5181	\N	\N	\N	\N	\N	\N	2591
5182	\N	\N	\N	\N	\N	\N	2591
5183	\N	\N	\N	\N	\N	\N	2592
5184	\N	\N	\N	\N	\N	\N	2592
5185	\N	\N	\N	\N	\N	\N	2593
5186	\N	\N	\N	\N	\N	\N	2593
5187	\N	\N	\N	\N	\N	\N	2594
5188	\N	\N	\N	\N	\N	\N	2594
5189	\N	\N	\N	\N	\N	\N	2595
5190	\N	\N	\N	\N	\N	\N	2595
5191	\N	\N	\N	\N	\N	\N	2596
5192	\N	\N	\N	\N	\N	\N	2596
5193	\N	\N	\N	\N	\N	\N	2597
5194	\N	\N	\N	\N	\N	\N	2597
5195	\N	\N	\N	\N	\N	\N	2598
5196	\N	\N	\N	\N	\N	\N	2598
5197	\N	\N	\N	\N	\N	\N	2599
5198	\N	\N	\N	\N	\N	\N	2599
5199	\N	\N	\N	\N	\N	\N	2600
5200	\N	\N	\N	\N	\N	\N	2600
5201	\N	\N	\N	\N	\N	\N	2601
5202	\N	\N	\N	\N	\N	\N	2601
5203	\N	\N	\N	\N	\N	\N	2602
5204	\N	\N	\N	\N	\N	\N	2602
5205	\N	\N	\N	\N	\N	\N	2603
5206	\N	\N	\N	\N	\N	\N	2603
5207	\N	\N	\N	\N	\N	\N	2604
5208	\N	\N	\N	\N	\N	\N	2604
5209	\N	\N	\N	\N	\N	\N	2605
5210	\N	\N	\N	\N	\N	\N	2605
5211	\N	\N	\N	\N	\N	\N	2606
5212	\N	\N	\N	\N	\N	\N	2606
5213	\N	\N	\N	\N	\N	\N	2607
5214	\N	\N	\N	\N	\N	\N	2607
5215	\N	\N	\N	\N	\N	\N	2608
5216	\N	\N	\N	\N	\N	\N	2608
5217	\N	\N	\N	\N	\N	\N	2609
5218	\N	\N	\N	\N	\N	\N	2609
5219	\N	\N	\N	\N	\N	\N	2610
5220	\N	\N	\N	\N	\N	\N	2610
5221	\N	\N	\N	\N	\N	\N	2611
5222	\N	\N	\N	\N	\N	\N	2611
5223	\N	\N	\N	\N	\N	\N	2612
5224	\N	\N	\N	\N	\N	\N	2612
5225	\N	\N	\N	\N	\N	\N	2613
5226	\N	\N	\N	\N	\N	\N	2613
5227	\N	\N	\N	\N	\N	\N	2614
5228	\N	\N	\N	\N	\N	\N	2614
5229	\N	\N	\N	\N	\N	\N	2615
5230	\N	\N	\N	\N	\N	\N	2615
5231	\N	\N	\N	\N	\N	\N	2616
5232	\N	\N	\N	\N	\N	\N	2616
5233	\N	\N	\N	\N	\N	\N	2617
5234	\N	\N	\N	\N	\N	\N	2617
5235	\N	\N	\N	\N	\N	\N	2618
5236	\N	\N	\N	\N	\N	\N	2618
5237	\N	\N	\N	\N	\N	\N	2619
5238	\N	\N	\N	\N	\N	\N	2619
5239	\N	\N	\N	\N	\N	\N	2620
5240	\N	\N	\N	\N	\N	\N	2620
5241	\N	\N	\N	\N	\N	\N	2621
5242	\N	\N	\N	\N	\N	\N	2621
5243	\N	\N	\N	\N	\N	\N	2622
5244	\N	\N	\N	\N	\N	\N	2622
5245	\N	\N	\N	\N	\N	\N	2623
5246	\N	\N	\N	\N	\N	\N	2623
5247	\N	\N	\N	\N	\N	\N	2624
5248	\N	\N	\N	\N	\N	\N	2624
5249	\N	\N	\N	\N	\N	\N	2625
5250	\N	\N	\N	\N	\N	\N	2625
5251	\N	\N	\N	\N	\N	\N	2626
5252	\N	\N	\N	\N	\N	\N	2626
5253	\N	\N	\N	\N	\N	\N	2627
5254	\N	\N	\N	\N	\N	\N	2627
5255	\N	\N	\N	\N	\N	\N	2628
5256	\N	\N	\N	\N	\N	\N	2628
5257	\N	\N	\N	\N	\N	\N	2629
5258	\N	\N	\N	\N	\N	\N	2629
5259	\N	\N	\N	\N	\N	\N	2630
5260	\N	\N	\N	\N	\N	\N	2630
5261	\N	\N	\N	\N	\N	\N	2631
5262	\N	\N	\N	\N	\N	\N	2631
5263	\N	\N	\N	\N	\N	\N	2632
5264	\N	\N	\N	\N	\N	\N	2632
5265	\N	\N	\N	\N	\N	\N	2633
5266	\N	\N	\N	\N	\N	\N	2633
5267	\N	\N	\N	\N	\N	\N	2634
5268	\N	\N	\N	\N	\N	\N	2634
5269	\N	\N	\N	\N	\N	\N	2635
5270	\N	\N	\N	\N	\N	\N	2635
5271	\N	\N	\N	\N	\N	\N	2636
5272	\N	\N	\N	\N	\N	\N	2636
5273	\N	\N	\N	\N	\N	\N	2637
5274	\N	\N	\N	\N	\N	\N	2637
5275	\N	\N	\N	\N	\N	\N	2638
5276	\N	\N	\N	\N	\N	\N	2638
5277	\N	\N	\N	\N	\N	\N	2639
5278	\N	\N	\N	\N	\N	\N	2639
5279	\N	\N	\N	\N	\N	\N	2640
5280	\N	\N	\N	\N	\N	\N	2640
5281	\N	\N	\N	\N	\N	\N	2641
5282	\N	\N	\N	\N	\N	\N	2641
5283	\N	\N	\N	\N	\N	\N	2642
5284	\N	\N	\N	\N	\N	\N	2642
5285	\N	\N	\N	\N	\N	\N	2643
5286	\N	\N	\N	\N	\N	\N	2643
5287	\N	\N	\N	\N	\N	\N	2644
5288	\N	\N	\N	\N	\N	\N	2644
5289	\N	\N	\N	\N	\N	\N	2645
5290	\N	\N	\N	\N	\N	\N	2645
5291	\N	\N	\N	\N	\N	\N	2646
5292	\N	\N	\N	\N	\N	\N	2646
5293	\N	\N	\N	\N	\N	\N	2647
5294	\N	\N	\N	\N	\N	\N	2647
5295	\N	\N	\N	\N	\N	\N	2648
5296	\N	\N	\N	\N	\N	\N	2648
5297	\N	\N	\N	\N	\N	\N	2649
5298	\N	\N	\N	\N	\N	\N	2649
5299	\N	\N	\N	\N	\N	\N	2650
5300	\N	\N	\N	\N	\N	\N	2650
5301	\N	\N	\N	\N	\N	\N	2651
5302	\N	\N	\N	\N	\N	\N	2651
5303	\N	\N	\N	\N	\N	\N	2652
5304	\N	\N	\N	\N	\N	\N	2652
5305	\N	\N	\N	\N	\N	\N	2653
5306	\N	\N	\N	\N	\N	\N	2653
5307	\N	\N	\N	\N	\N	\N	2654
5308	\N	\N	\N	\N	\N	\N	2654
5309	\N	\N	\N	\N	\N	\N	2655
5310	\N	\N	\N	\N	\N	\N	2655
5311	\N	\N	\N	\N	\N	\N	2656
5312	\N	\N	\N	\N	\N	\N	2656
5313	\N	\N	\N	\N	\N	\N	2657
5314	\N	\N	\N	\N	\N	\N	2657
5315	\N	\N	\N	\N	\N	\N	2658
5316	\N	\N	\N	\N	\N	\N	2658
5317	\N	\N	\N	\N	\N	\N	2659
5318	\N	\N	\N	\N	\N	\N	2659
5319	\N	\N	\N	\N	\N	\N	2660
5320	\N	\N	\N	\N	\N	\N	2660
5321	\N	\N	\N	\N	\N	\N	2661
5322	\N	\N	\N	\N	\N	\N	2661
5323	\N	\N	\N	\N	\N	\N	2662
5324	\N	\N	\N	\N	\N	\N	2662
5325	\N	\N	\N	\N	\N	\N	2663
5326	\N	\N	\N	\N	\N	\N	2663
5327	\N	\N	\N	\N	\N	\N	2664
5328	\N	\N	\N	\N	\N	\N	2664
5329	\N	\N	\N	\N	\N	\N	2665
5330	\N	\N	\N	\N	\N	\N	2665
5331	\N	\N	\N	\N	\N	\N	2666
5332	\N	\N	\N	\N	\N	\N	2666
5333	\N	\N	\N	\N	\N	\N	2667
5334	\N	\N	\N	\N	\N	\N	2667
5335	\N	\N	\N	\N	\N	\N	2668
5336	\N	\N	\N	\N	\N	\N	2668
5337	\N	\N	\N	\N	\N	\N	2669
5338	\N	\N	\N	\N	\N	\N	2669
5339	\N	\N	\N	\N	\N	\N	2670
5340	\N	\N	\N	\N	\N	\N	2670
5341	\N	\N	\N	\N	\N	\N	2671
5342	\N	\N	\N	\N	\N	\N	2671
5343	\N	\N	\N	\N	\N	\N	2672
5344	\N	\N	\N	\N	\N	\N	2672
5345	\N	\N	\N	\N	\N	\N	2673
5346	\N	\N	\N	\N	\N	\N	2673
5347	\N	\N	\N	\N	\N	\N	2674
5348	\N	\N	\N	\N	\N	\N	2674
5349	\N	\N	\N	\N	\N	\N	2675
5350	\N	\N	\N	\N	\N	\N	2675
5351	\N	\N	\N	\N	\N	\N	2676
5352	\N	\N	\N	\N	\N	\N	2676
5353	\N	\N	\N	\N	\N	\N	2677
5354	\N	\N	\N	\N	\N	\N	2677
5355	\N	\N	\N	\N	\N	\N	2678
5356	\N	\N	\N	\N	\N	\N	2678
5357	\N	\N	\N	\N	\N	\N	2679
5358	\N	\N	\N	\N	\N	\N	2679
5359	\N	\N	\N	\N	\N	\N	2680
5360	\N	\N	\N	\N	\N	\N	2680
5361	\N	\N	\N	\N	\N	\N	2681
5362	\N	\N	\N	\N	\N	\N	2681
5363	\N	\N	\N	\N	\N	\N	2682
5364	\N	\N	\N	\N	\N	\N	2682
5365	\N	\N	\N	\N	\N	\N	2683
5366	\N	\N	\N	\N	\N	\N	2683
5367	\N	\N	\N	\N	\N	\N	2684
5368	\N	\N	\N	\N	\N	\N	2684
5369	\N	\N	\N	\N	\N	\N	2685
5370	\N	\N	\N	\N	\N	\N	2685
5371	\N	\N	\N	\N	\N	\N	2686
5372	\N	\N	\N	\N	\N	\N	2686
5373	\N	\N	\N	\N	\N	\N	2687
5374	\N	\N	\N	\N	\N	\N	2687
5375	\N	\N	\N	\N	\N	\N	2688
5376	\N	\N	\N	\N	\N	\N	2688
5377	\N	\N	\N	\N	\N	\N	2689
5378	\N	\N	\N	\N	\N	\N	2689
5379	\N	\N	\N	\N	\N	\N	2690
5380	\N	\N	\N	\N	\N	\N	2690
5381	\N	\N	\N	\N	\N	\N	2691
5382	\N	\N	\N	\N	\N	\N	2691
5383	\N	\N	\N	\N	\N	\N	2692
5384	\N	\N	\N	\N	\N	\N	2692
5385	\N	\N	\N	\N	\N	\N	2693
5386	\N	\N	\N	\N	\N	\N	2693
5387	\N	\N	\N	\N	\N	\N	2694
5388	\N	\N	\N	\N	\N	\N	2694
5389	\N	\N	\N	\N	\N	\N	2695
5390	\N	\N	\N	\N	\N	\N	2695
5391	\N	\N	\N	\N	\N	\N	2696
5392	\N	\N	\N	\N	\N	\N	2696
5393	\N	\N	\N	\N	\N	\N	2697
5394	\N	\N	\N	\N	\N	\N	2697
5395	\N	\N	\N	\N	\N	\N	2698
5396	\N	\N	\N	\N	\N	\N	2698
5397	\N	\N	\N	\N	\N	\N	2699
5398	\N	\N	\N	\N	\N	\N	2699
5399	\N	\N	\N	\N	\N	\N	2700
5400	\N	\N	\N	\N	\N	\N	2700
5401	\N	\N	\N	\N	\N	\N	2701
5402	\N	\N	\N	\N	\N	\N	2701
5403	\N	\N	\N	\N	\N	\N	2702
5404	\N	\N	\N	\N	\N	\N	2702
5405	\N	\N	\N	\N	\N	\N	2703
5406	\N	\N	\N	\N	\N	\N	2703
5407	\N	\N	\N	\N	\N	\N	2704
5408	\N	\N	\N	\N	\N	\N	2704
5409	\N	\N	\N	\N	\N	\N	2705
5410	\N	\N	\N	\N	\N	\N	2705
5411	\N	\N	\N	\N	\N	\N	2706
5412	\N	\N	\N	\N	\N	\N	2706
5413	\N	\N	\N	\N	\N	\N	2707
5414	\N	\N	\N	\N	\N	\N	2707
5415	\N	\N	\N	\N	\N	\N	2708
5416	\N	\N	\N	\N	\N	\N	2708
5417	\N	\N	\N	\N	\N	\N	2709
5418	\N	\N	\N	\N	\N	\N	2709
5419	\N	\N	\N	\N	\N	\N	2710
5420	\N	\N	\N	\N	\N	\N	2710
5421	\N	\N	\N	\N	\N	\N	2711
5422	\N	\N	\N	\N	\N	\N	2711
5423	\N	\N	\N	\N	\N	\N	2712
5424	\N	\N	\N	\N	\N	\N	2712
5425	\N	\N	\N	\N	\N	\N	2713
5426	\N	\N	\N	\N	\N	\N	2713
5427	\N	\N	\N	\N	\N	\N	2714
5428	\N	\N	\N	\N	\N	\N	2714
5429	\N	\N	\N	\N	\N	\N	2715
5430	\N	\N	\N	\N	\N	\N	2715
5431	\N	\N	\N	\N	\N	\N	2716
5432	\N	\N	\N	\N	\N	\N	2716
5433	\N	\N	\N	\N	\N	\N	2717
5434	\N	\N	\N	\N	\N	\N	2717
5435	\N	\N	\N	\N	\N	\N	2718
5436	\N	\N	\N	\N	\N	\N	2718
5437	\N	\N	\N	\N	\N	\N	2719
5438	\N	\N	\N	\N	\N	\N	2719
5439	\N	\N	\N	\N	\N	\N	2720
5440	\N	\N	\N	\N	\N	\N	2720
5441	\N	\N	\N	\N	\N	\N	2721
5442	\N	\N	\N	\N	\N	\N	2721
5443	\N	\N	\N	\N	\N	\N	2722
5444	\N	\N	\N	\N	\N	\N	2722
5445	\N	\N	\N	\N	\N	\N	2723
5446	\N	\N	\N	\N	\N	\N	2723
5447	\N	\N	\N	\N	\N	\N	2724
5448	\N	\N	\N	\N	\N	\N	2724
5449	\N	\N	\N	\N	\N	\N	2725
5450	\N	\N	\N	\N	\N	\N	2725
5451	\N	\N	\N	\N	\N	\N	2726
5452	\N	\N	\N	\N	\N	\N	2726
5453	\N	\N	\N	\N	\N	\N	2727
5454	\N	\N	\N	\N	\N	\N	2727
5455	\N	\N	\N	\N	\N	\N	2728
5456	\N	\N	\N	\N	\N	\N	2728
5457	\N	\N	\N	\N	\N	\N	2729
5458	\N	\N	\N	\N	\N	\N	2729
5459	\N	\N	\N	\N	\N	\N	2730
5460	\N	\N	\N	\N	\N	\N	2730
5461	\N	\N	\N	\N	\N	\N	2731
5462	\N	\N	\N	\N	\N	\N	2731
5463	\N	\N	\N	\N	\N	\N	2732
5464	\N	\N	\N	\N	\N	\N	2732
5465	\N	\N	\N	\N	\N	\N	2733
5466	\N	\N	\N	\N	\N	\N	2733
5467	\N	\N	\N	\N	\N	\N	2734
5468	\N	\N	\N	\N	\N	\N	2734
5469	\N	\N	\N	\N	\N	\N	2735
5470	\N	\N	\N	\N	\N	\N	2735
5471	\N	\N	\N	\N	\N	\N	2736
5472	\N	\N	\N	\N	\N	\N	2736
5473	\N	\N	\N	\N	\N	\N	2737
5474	\N	\N	\N	\N	\N	\N	2737
5475	\N	\N	\N	\N	\N	\N	2738
5476	\N	\N	\N	\N	\N	\N	2738
5477	\N	\N	\N	\N	\N	\N	2739
5478	\N	\N	\N	\N	\N	\N	2739
5479	\N	\N	\N	\N	\N	\N	2740
5480	\N	\N	\N	\N	\N	\N	2740
5481	\N	\N	\N	\N	\N	\N	2741
5482	\N	\N	\N	\N	\N	\N	2741
5483	\N	\N	\N	\N	\N	\N	2742
5484	\N	\N	\N	\N	\N	\N	2742
5485	\N	\N	\N	\N	\N	\N	2743
5486	\N	\N	\N	\N	\N	\N	2743
5487	\N	\N	\N	\N	\N	\N	2744
5488	\N	\N	\N	\N	\N	\N	2744
5489	\N	\N	\N	\N	\N	\N	2745
5490	\N	\N	\N	\N	\N	\N	2745
5491	\N	\N	\N	\N	\N	\N	2746
5492	\N	\N	\N	\N	\N	\N	2746
5493	\N	\N	\N	\N	\N	\N	2747
5494	\N	\N	\N	\N	\N	\N	2747
5495	\N	\N	\N	\N	\N	\N	2748
5496	\N	\N	\N	\N	\N	\N	2748
5497	\N	\N	\N	\N	\N	\N	2749
5498	\N	\N	\N	\N	\N	\N	2749
5499	\N	\N	\N	\N	\N	\N	2750
5500	\N	\N	\N	\N	\N	\N	2750
5501	\N	\N	\N	\N	\N	\N	2751
5502	\N	\N	\N	\N	\N	\N	2751
5503	\N	\N	\N	\N	\N	\N	2752
5504	\N	\N	\N	\N	\N	\N	2752
5505	\N	\N	\N	\N	\N	\N	2753
5506	\N	\N	\N	\N	\N	\N	2753
5507	\N	\N	\N	\N	\N	\N	2754
5508	\N	\N	\N	\N	\N	\N	2754
5509	\N	\N	\N	\N	\N	\N	2755
5510	\N	\N	\N	\N	\N	\N	2755
5511	\N	\N	\N	\N	\N	\N	2756
5512	\N	\N	\N	\N	\N	\N	2756
5513	\N	\N	\N	\N	\N	\N	2757
5514	\N	\N	\N	\N	\N	\N	2757
5515	\N	\N	\N	\N	\N	\N	2758
5516	\N	\N	\N	\N	\N	\N	2758
5517	\N	\N	\N	\N	\N	\N	2759
5518	\N	\N	\N	\N	\N	\N	2759
5519	\N	\N	\N	\N	\N	\N	2760
5520	\N	\N	\N	\N	\N	\N	2760
5521	\N	\N	\N	\N	\N	\N	2761
5522	\N	\N	\N	\N	\N	\N	2761
5523	\N	\N	\N	\N	\N	\N	2762
5524	\N	\N	\N	\N	\N	\N	2762
5525	\N	\N	\N	\N	\N	\N	2763
5526	\N	\N	\N	\N	\N	\N	2763
5527	\N	\N	\N	\N	\N	\N	2764
5528	\N	\N	\N	\N	\N	\N	2764
5529	\N	\N	\N	\N	\N	\N	2765
5530	\N	\N	\N	\N	\N	\N	2765
5531	\N	\N	\N	\N	\N	\N	2766
5532	\N	\N	\N	\N	\N	\N	2766
5533	\N	\N	\N	\N	\N	\N	2767
5534	\N	\N	\N	\N	\N	\N	2767
5535	\N	\N	\N	\N	\N	\N	2768
5536	\N	\N	\N	\N	\N	\N	2768
5537	\N	\N	\N	\N	\N	\N	2769
5538	\N	\N	\N	\N	\N	\N	2769
5539	\N	\N	\N	\N	\N	\N	2770
5540	\N	\N	\N	\N	\N	\N	2770
5541	\N	\N	\N	\N	\N	\N	2771
5542	\N	\N	\N	\N	\N	\N	2771
5543	\N	\N	\N	\N	\N	\N	2772
5544	\N	\N	\N	\N	\N	\N	2772
5545	\N	\N	\N	\N	\N	\N	2773
5546	\N	\N	\N	\N	\N	\N	2773
5547	\N	\N	\N	\N	\N	\N	2774
5548	\N	\N	\N	\N	\N	\N	2774
5549	\N	\N	\N	\N	\N	\N	2775
5550	\N	\N	\N	\N	\N	\N	2775
5551	\N	\N	\N	\N	\N	\N	2776
5552	\N	\N	\N	\N	\N	\N	2776
5553	\N	\N	\N	\N	\N	\N	2777
5554	\N	\N	\N	\N	\N	\N	2777
5555	\N	\N	\N	\N	\N	\N	2778
5556	\N	\N	\N	\N	\N	\N	2778
5557	\N	\N	\N	\N	\N	\N	2779
5558	\N	\N	\N	\N	\N	\N	2779
5559	\N	\N	\N	\N	\N	\N	2780
5560	\N	\N	\N	\N	\N	\N	2780
5561	\N	\N	\N	\N	\N	\N	2781
5562	\N	\N	\N	\N	\N	\N	2781
5563	\N	\N	\N	\N	\N	\N	2782
5564	\N	\N	\N	\N	\N	\N	2782
5565	\N	\N	\N	\N	\N	\N	2783
5566	\N	\N	\N	\N	\N	\N	2783
5567	\N	\N	\N	\N	\N	\N	2784
5568	\N	\N	\N	\N	\N	\N	2784
5569	\N	\N	\N	\N	\N	\N	2785
5570	\N	\N	\N	\N	\N	\N	2785
5571	\N	\N	\N	\N	\N	\N	2786
5572	\N	\N	\N	\N	\N	\N	2786
5573	\N	\N	\N	\N	\N	\N	2787
5574	\N	\N	\N	\N	\N	\N	2787
5575	\N	\N	\N	\N	\N	\N	2788
5576	\N	\N	\N	\N	\N	\N	2788
5577	\N	\N	\N	\N	\N	\N	2789
5578	\N	\N	\N	\N	\N	\N	2789
5579	\N	\N	\N	\N	\N	\N	2790
5580	\N	\N	\N	\N	\N	\N	2790
5581	\N	\N	\N	\N	\N	\N	2791
5582	\N	\N	\N	\N	\N	\N	2791
5583	\N	\N	\N	\N	\N	\N	2792
5584	\N	\N	\N	\N	\N	\N	2792
5585	\N	\N	\N	\N	\N	\N	2793
5586	\N	\N	\N	\N	\N	\N	2793
5587	\N	\N	\N	\N	\N	\N	2794
5588	\N	\N	\N	\N	\N	\N	2794
5589	\N	\N	\N	\N	\N	\N	2795
5590	\N	\N	\N	\N	\N	\N	2795
5591	\N	\N	\N	\N	\N	\N	2796
5592	\N	\N	\N	\N	\N	\N	2796
5593	\N	\N	\N	\N	\N	\N	2797
5594	\N	\N	\N	\N	\N	\N	2797
5595	\N	\N	\N	\N	\N	\N	2798
5596	\N	\N	\N	\N	\N	\N	2798
5597	\N	\N	\N	\N	\N	\N	2799
5598	\N	\N	\N	\N	\N	\N	2799
5599	\N	\N	\N	\N	\N	\N	2800
5600	\N	\N	\N	\N	\N	\N	2800
5601	\N	\N	\N	\N	\N	\N	2801
5602	\N	\N	\N	\N	\N	\N	2801
5603	\N	\N	\N	\N	\N	\N	2802
5604	\N	\N	\N	\N	\N	\N	2802
1	1	1	2	\N	\N	\N	1
2	1	2	2	\N	\N	\N	1
\.


--
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.sport (id, name, slug, external_id) FROM stdin;
1	Football	football	1
2	Basketball	basketball	2
3	American Football	american-football	3
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.team (id, country_id, name, manager_name, venue, external_id) FROM stdin;
3	1	Manchester United	\N	\N	1
4	1	Fulham	\N	\N	7
5	1	Everton	\N	\N	11
6	1	Tottenham Hotspur	\N	\N	9
7	1	Tottenham Hotspur	\N	\N	9
8	1	Everton	\N	\N	11
9	1	Burnley	\N	\N	4
10	1	Crystal Palace	\N	\N	15
11	1	Crystal Palace	\N	\N	15
12	1	Burnley	\N	\N	4
13	1	West Ham United	\N	\N	5
14	1	Luton Town	\N	\N	14
15	1	Luton Town	\N	\N	14
16	1	West Ham United	\N	\N	5
17	1	Brighton & Hove 2	\N	\N	2
18	1	Liverpool	\N	\N	17
19	1	Liverpool	\N	\N	17
20	1	Brighton & Hove 2	\N	\N	2
21	1	Chelsea	\N	\N	13
22	1	Sheffield United	\N	\N	8
23	1	Sheffield United	\N	\N	8
24	1	Chelsea	\N	\N	13
25	1	Brentford	\N	\N	18
26	1	Bournemouth	\N	\N	3
27	1	Bournemouth	\N	\N	3
28	1	Brentford	\N	\N	18
29	1	Newcastle United	\N	\N	10
30	1	Arsenal	\N	\N	12
31	1	Arsenal	\N	\N	12
32	1	Newcastle United	\N	\N	10
33	1	Aston Villa	\N	\N	16
34	1	Nottingham Forest	\N	\N	6
35	1	Nottingham Forest	\N	\N	6
36	1	Aston Villa	\N	\N	16
37	1	Wolverhampton	\N	\N	20
38	1	Manchester City	\N	\N	19
39	1	Manchester City	\N	\N	19
40	1	Wolverhampton	\N	\N	20
41	1	Nottingham Forest	\N	\N	6
42	1	Sheffield United	\N	\N	8
43	1	Sheffield United	\N	\N	8
44	1	Nottingham Forest	\N	\N	6
45	1	Liverpool	\N	\N	17
46	1	Manchester United	\N	\N	1
47	1	Manchester United	\N	\N	1
48	1	Liverpool	\N	\N	17
49	1	Wolverhampton	\N	\N	20
50	1	Luton Town	\N	\N	14
51	1	Luton Town	\N	\N	14
52	1	Wolverhampton	\N	\N	20
53	1	Brighton & Hove 2	\N	\N	2
54	1	Newcastle United	\N	\N	10
55	1	Newcastle United	\N	\N	10
56	1	Brighton & Hove 2	\N	\N	2
57	1	Brentford	\N	\N	18
58	1	Fulham	\N	\N	7
59	1	Fulham	\N	\N	7
60	1	Brentford	\N	\N	18
61	1	Aston Villa	\N	\N	16
62	1	West Ham United	\N	\N	5
63	1	West Ham United	\N	\N	5
64	1	Aston Villa	\N	\N	16
65	1	Crystal Palace	\N	\N	15
66	1	Tottenham Hotspur	\N	\N	9
67	1	Tottenham Hotspur	\N	\N	9
68	1	Crystal Palace	\N	\N	15
69	1	Bournemouth	\N	\N	3
70	1	Chelsea	\N	\N	13
71	1	Chelsea	\N	\N	13
72	1	Bournemouth	\N	\N	3
73	1	Burnley	\N	\N	4
74	1	Arsenal	\N	\N	12
75	1	Arsenal	\N	\N	12
76	1	Burnley	\N	\N	4
77	1	Manchester City	\N	\N	19
78	1	Everton	\N	\N	11
79	1	Everton	\N	\N	11
80	1	Manchester City	\N	\N	19
81	1	Brighton & Hove 2	\N	\N	2
82	1	Manchester City	\N	\N	19
83	1	Manchester City	\N	\N	19
84	1	Brighton & Hove 2	\N	\N	2
85	1	Aston Villa	\N	\N	16
86	1	Everton	\N	\N	11
87	1	Everton	\N	\N	11
88	1	Aston Villa	\N	\N	16
89	1	Liverpool	\N	\N	17
90	1	Bournemouth	\N	\N	3
91	1	Bournemouth	\N	\N	3
92	1	Liverpool	\N	\N	17
93	1	Manchester United	\N	\N	1
94	1	Brentford	\N	\N	18
95	1	Brentford	\N	\N	18
96	1	Manchester United	\N	\N	1
97	1	Luton Town	\N	\N	14
98	1	Sheffield United	\N	\N	8
99	1	Sheffield United	\N	\N	8
100	1	Luton Town	\N	\N	14
101	1	Tottenham Hotspur	\N	\N	9
102	1	Burnley	\N	\N	4
103	1	Burnley	\N	\N	4
104	1	Tottenham Hotspur	\N	\N	9
105	1	Nottingham Forest	\N	\N	6
106	1	Chelsea	\N	\N	13
107	1	Chelsea	\N	\N	13
108	1	Nottingham Forest	\N	\N	6
109	1	Crystal Palace	\N	\N	15
110	1	West Ham United	\N	\N	5
111	1	West Ham United	\N	\N	5
112	1	Crystal Palace	\N	\N	15
113	1	Newcastle United	\N	\N	10
114	1	Wolverhampton	\N	\N	20
115	1	Wolverhampton	\N	\N	20
116	1	Newcastle United	\N	\N	10
117	1	Fulham	\N	\N	7
118	1	Arsenal	\N	\N	12
119	1	Arsenal	\N	\N	12
120	1	Fulham	\N	\N	7
121	1	Burnley	\N	\N	4
122	1	Aston Villa	\N	\N	16
123	1	Aston Villa	\N	\N	16
124	1	Burnley	\N	\N	4
125	1	Manchester United	\N	\N	1
126	1	West Ham United	\N	\N	5
127	1	West Ham United	\N	\N	5
128	1	Manchester United	\N	\N	1
129	1	Arsenal	\N	\N	12
130	1	Manchester City	\N	\N	19
131	1	Manchester City	\N	\N	19
132	1	Arsenal	\N	\N	12
133	1	Fulham	\N	\N	7
134	1	Luton Town	\N	\N	14
135	1	Luton Town	\N	\N	14
136	1	Fulham	\N	\N	7
137	1	Tottenham Hotspur	\N	\N	9
138	1	Nottingham Forest	\N	\N	6
139	1	Nottingham Forest	\N	\N	6
140	1	Tottenham Hotspur	\N	\N	9
141	1	Newcastle United	\N	\N	10
142	1	Chelsea	\N	\N	13
143	1	Chelsea	\N	\N	13
144	1	Newcastle United	\N	\N	10
145	1	Bournemouth	\N	\N	3
1	1	Vukasin	\N	\N	7
146	1	Wolverhampton	\N	\N	20
147	1	Wolverhampton	\N	\N	20
148	1	Bournemouth	\N	\N	3
149	1	Everton	\N	\N	11
150	1	Liverpool	\N	\N	17
151	1	Liverpool	\N	\N	17
152	1	Everton	\N	\N	11
153	1	Brighton & Hove 2	\N	\N	2
154	1	Crystal Palace	\N	\N	15
155	1	Crystal Palace	\N	\N	15
156	1	Brighton & Hove 2	\N	\N	2
157	1	Brentford	\N	\N	18
158	1	Sheffield United	\N	\N	8
159	1	Sheffield United	\N	\N	8
160	1	Brentford	\N	\N	18
161	1	Manchester United	\N	\N	1
162	1	Chelsea	\N	\N	13
163	1	Chelsea	\N	\N	13
164	1	Manchester United	\N	\N	1
165	1	Everton	\N	\N	11
166	1	West Ham United	\N	\N	5
167	1	West Ham United	\N	\N	5
168	1	Everton	\N	\N	11
169	1	Newcastle United	\N	\N	10
170	1	Manchester City	\N	\N	19
171	1	Manchester City	\N	\N	19
172	1	Newcastle United	\N	\N	10
173	1	Brentford	\N	\N	18
174	1	Liverpool	\N	\N	17
175	1	Liverpool	\N	\N	17
176	1	Brentford	\N	\N	18
177	1	Arsenal	\N	\N	12
178	1	Sheffield United	\N	\N	8
179	1	Sheffield United	\N	\N	8
180	1	Arsenal	\N	\N	12
181	1	Aston Villa	\N	\N	16
182	1	Tottenham Hotspur	\N	\N	9
183	1	Tottenham Hotspur	\N	\N	9
184	1	Aston Villa	\N	\N	16
185	1	Bournemouth	\N	\N	3
186	1	Burnley	\N	\N	4
187	1	Burnley	\N	\N	4
188	1	Bournemouth	\N	\N	3
189	1	Nottingham Forest	\N	\N	6
190	1	Fulham	\N	\N	7
191	1	Fulham	\N	\N	7
192	1	Nottingham Forest	\N	\N	6
193	1	Brighton & Hove 2	\N	\N	2
194	1	Wolverhampton	\N	\N	20
195	1	Wolverhampton	\N	\N	20
196	1	Brighton & Hove 2	\N	\N	2
197	1	Luton Town	\N	\N	14
198	1	Crystal Palace	\N	\N	15
199	1	Crystal Palace	\N	\N	15
200	1	Luton Town	\N	\N	14
201	1	Brighton & Hove 2	\N	\N	2
202	1	Luton Town	\N	\N	14
203	1	Luton Town	\N	\N	14
204	1	Brighton & Hove 2	\N	\N	2
205	1	West Ham United	\N	\N	5
206	1	Liverpool	\N	\N	17
207	1	Liverpool	\N	\N	17
208	1	West Ham United	\N	\N	5
209	1	Tottenham Hotspur	\N	\N	9
210	1	Wolverhampton	\N	\N	20
211	1	Wolverhampton	\N	\N	20
212	1	Tottenham Hotspur	\N	\N	9
213	1	Newcastle United	\N	\N	10
214	1	Nottingham Forest	\N	\N	6
215	1	Nottingham Forest	\N	\N	6
216	1	Newcastle United	\N	\N	10
217	1	Manchester City	\N	\N	19
218	1	Bournemouth	\N	\N	3
219	1	Bournemouth	\N	\N	3
220	1	Manchester City	\N	\N	19
221	1	Fulham	\N	\N	7
222	1	Crystal Palace	\N	\N	15
223	1	Crystal Palace	\N	\N	15
224	1	Fulham	\N	\N	7
225	1	Aston Villa	\N	\N	16
226	1	Arsenal	\N	\N	12
227	1	Arsenal	\N	\N	12
228	1	Aston Villa	\N	\N	16
229	1	Everton	\N	\N	11
230	1	Burnley	\N	\N	4
231	1	Burnley	\N	\N	4
232	1	Everton	\N	\N	11
233	1	Manchester United	\N	\N	1
234	1	Sheffield United	\N	\N	8
235	1	Sheffield United	\N	\N	8
236	1	Manchester United	\N	\N	1
237	1	Chelsea	\N	\N	13
238	1	Brentford	\N	\N	18
239	1	Brentford	\N	\N	18
240	1	Chelsea	\N	\N	13
241	1	Sheffield United	\N	\N	8
242	1	Aston Villa	\N	\N	16
243	1	Aston Villa	\N	\N	16
244	1	Sheffield United	\N	\N	8
245	1	Arsenal	\N	\N	12
246	1	Crystal Palace	\N	\N	15
247	1	Crystal Palace	\N	\N	15
248	1	Arsenal	\N	\N	12
249	1	Fulham	\N	\N	7
250	1	Newcastle United	\N	\N	10
251	1	Newcastle United	\N	\N	10
252	1	Fulham	\N	\N	7
253	1	Bournemouth	\N	\N	3
254	1	Luton Town	\N	\N	14
255	1	Luton Town	\N	\N	14
256	1	Bournemouth	\N	\N	3
257	1	Nottingham Forest	\N	\N	6
258	1	Manchester City	\N	\N	19
259	1	Manchester City	\N	\N	19
260	1	Nottingham Forest	\N	\N	6
261	1	Everton	\N	\N	11
262	1	Brentford	\N	\N	18
263	1	Brentford	\N	\N	18
264	1	Everton	\N	\N	11
265	1	Chelsea	\N	\N	13
266	1	Brighton & Hove 2	\N	\N	2
267	1	Brighton & Hove 2	\N	\N	2
268	1	Chelsea	\N	\N	13
269	1	West Ham United	\N	\N	5
270	1	Wolverhampton	\N	\N	20
271	1	Wolverhampton	\N	\N	20
272	1	West Ham United	\N	\N	5
273	1	Burnley	\N	\N	4
274	1	Manchester United	\N	\N	1
275	1	Manchester United	\N	\N	1
276	1	Burnley	\N	\N	4
277	1	Tottenham Hotspur	\N	\N	9
278	1	Liverpool	\N	\N	17
279	1	Liverpool	\N	\N	17
280	1	Tottenham Hotspur	\N	\N	9
281	1	Tottenham Hotspur	\N	\N	9
282	1	Luton Town	\N	\N	14
283	1	Luton Town	\N	\N	14
284	1	Tottenham Hotspur	\N	\N	9
285	1	Brighton & Hove 2	\N	\N	2
286	1	Fulham	\N	\N	7
287	1	Fulham	\N	\N	7
288	1	Brighton & Hove 2	\N	\N	2
289	1	Manchester City	\N	\N	19
290	1	Crystal Palace	\N	\N	15
291	1	Crystal Palace	\N	\N	15
292	1	Manchester City	\N	\N	19
293	1	West Ham United	\N	\N	5
294	1	Burnley	\N	\N	4
295	1	Burnley	\N	\N	4
296	1	West Ham United	\N	\N	5
297	1	Wolverhampton	\N	\N	20
298	1	Brentford	\N	\N	18
299	1	Brentford	\N	\N	18
300	1	Wolverhampton	\N	\N	20
301	1	Sheffield United	\N	\N	8
302	1	Everton	\N	\N	11
303	1	Everton	\N	\N	11
304	1	Sheffield United	\N	\N	8
305	1	Nottingham Forest	\N	\N	6
306	1	Arsenal	\N	\N	12
307	1	Arsenal	\N	\N	12
308	1	Nottingham Forest	\N	\N	6
309	1	Aston Villa	\N	\N	16
310	1	Bournemouth	\N	\N	3
311	1	Bournemouth	\N	\N	3
312	1	Aston Villa	\N	\N	16
313	1	Chelsea	\N	\N	13
314	1	Liverpool	\N	\N	17
315	1	Liverpool	\N	\N	17
316	1	Chelsea	\N	\N	13
317	1	Newcastle United	\N	\N	10
318	1	Manchester United	\N	\N	1
319	1	Manchester United	\N	\N	1
320	1	Newcastle United	\N	\N	10
321	1	Burnley	\N	\N	4
322	1	Sheffield United	\N	\N	8
323	1	Sheffield United	\N	\N	8
324	1	Burnley	\N	\N	4
325	1	Nottingham Forest	\N	\N	6
326	1	Everton	\N	\N	11
327	1	Everton	\N	\N	11
328	1	Nottingham Forest	\N	\N	6
329	1	West Ham United	\N	\N	5
330	1	Manchester City	\N	\N	19
331	1	Manchester City	\N	\N	19
332	1	West Ham United	\N	\N	5
333	1	Manchester United	\N	\N	1
334	1	Crystal Palace	\N	\N	15
335	1	Crystal Palace	\N	\N	15
336	1	Manchester United	\N	\N	1
337	1	Bournemouth	\N	\N	3
338	1	Brighton & Hove 2	\N	\N	2
339	1	Brighton & Hove 2	\N	\N	2
340	1	Bournemouth	\N	\N	3
341	1	Tottenham Hotspur	\N	\N	9
342	1	Chelsea	\N	\N	13
343	1	Chelsea	\N	\N	13
344	1	Tottenham Hotspur	\N	\N	9
345	1	Arsenal	\N	\N	12
346	1	Wolverhampton	\N	\N	20
347	1	Wolverhampton	\N	\N	20
348	1	Arsenal	\N	\N	12
349	1	Liverpool	\N	\N	17
350	1	Newcastle United	\N	\N	10
351	1	Newcastle United	\N	\N	10
352	1	Liverpool	\N	\N	17
353	1	Luton Town	\N	\N	14
354	1	Brentford	\N	\N	18
355	1	Brentford	\N	\N	18
356	1	Luton Town	\N	\N	14
357	1	Aston Villa	\N	\N	16
358	1	Fulham	\N	\N	7
359	1	Fulham	\N	\N	7
360	1	Aston Villa	\N	\N	16
361	1	Chelsea	\N	\N	13
362	1	Manchester City	\N	\N	19
363	1	Manchester City	\N	\N	19
364	1	Chelsea	\N	\N	13
365	1	Luton Town	\N	\N	14
366	1	Nottingham Forest	\N	\N	6
367	1	Nottingham Forest	\N	\N	6
368	1	Luton Town	\N	\N	14
369	1	Burnley	\N	\N	4
370	1	Fulham	\N	\N	7
371	1	Fulham	\N	\N	7
372	1	Burnley	\N	\N	4
373	1	Sheffield United	\N	\N	8
374	1	Tottenham Hotspur	\N	\N	9
375	1	Tottenham Hotspur	\N	\N	9
376	1	Sheffield United	\N	\N	8
377	1	Brighton & Hove 2	\N	\N	2
378	1	West Ham United	\N	\N	5
379	1	West Ham United	\N	\N	5
380	1	Brighton & Hove 2	\N	\N	2
381	1	Everton	\N	\N	11
382	1	Wolverhampton	\N	\N	20
383	1	Wolverhampton	\N	\N	20
384	1	Everton	\N	\N	11
385	1	Brentford	\N	\N	18
386	1	Arsenal	\N	\N	12
387	1	Arsenal	\N	\N	12
388	1	Brentford	\N	\N	18
389	1	Liverpool	\N	\N	17
390	1	Aston Villa	\N	\N	16
391	1	Aston Villa	\N	\N	16
392	1	Liverpool	\N	\N	17
393	1	Crystal Palace	\N	\N	15
394	1	Newcastle United	\N	\N	10
395	1	Newcastle United	\N	\N	10
396	1	Crystal Palace	\N	\N	15
397	1	Bournemouth	\N	\N	3
398	1	Manchester United	\N	\N	1
399	1	Manchester United	\N	\N	1
400	1	Bournemouth	\N	\N	3
401	1	Manchester City	\N	\N	19
402	1	Burnley	\N	\N	4
403	1	Burnley	\N	\N	4
404	1	Manchester City	\N	\N	19
405	1	Bournemouth	\N	\N	3
406	1	Arsenal	\N	\N	12
407	1	Arsenal	\N	\N	12
408	1	Bournemouth	\N	\N	3
409	1	Sheffield United	\N	\N	8
410	1	West Ham United	\N	\N	5
411	1	West Ham United	\N	\N	5
412	1	Sheffield United	\N	\N	8
413	1	Newcastle United	\N	\N	10
414	1	Brentford	\N	\N	18
415	1	Brentford	\N	\N	18
416	1	Newcastle United	\N	\N	10
417	1	Aston Villa	\N	\N	16
418	1	Crystal Palace	\N	\N	15
419	1	Crystal Palace	\N	\N	15
420	1	Aston Villa	\N	\N	16
421	1	Wolverhampton	\N	\N	20
422	1	Nottingham Forest	\N	\N	6
423	1	Nottingham Forest	\N	\N	6
424	1	Wolverhampton	\N	\N	20
425	1	Luton Town	\N	\N	14
426	1	Liverpool	\N	\N	17
427	1	Liverpool	\N	\N	17
428	1	Luton Town	\N	\N	14
429	1	Manchester United	\N	\N	1
430	1	Brighton & Hove 2	\N	\N	2
431	1	Brighton & Hove 2	\N	\N	2
432	1	Manchester United	\N	\N	1
433	1	Everton	\N	\N	11
434	1	Chelsea	\N	\N	13
435	1	Chelsea	\N	\N	13
436	1	Everton	\N	\N	11
437	1	Fulham	\N	\N	7
438	1	Tottenham Hotspur	\N	\N	9
439	1	Tottenham Hotspur	\N	\N	9
440	1	Fulham	\N	\N	7
441	1	Newcastle United	\N	\N	10
442	1	Aston Villa	\N	\N	16
443	1	Aston Villa	\N	\N	16
444	1	Newcastle United	\N	\N	10
445	1	Tottenham Hotspur	\N	\N	9
446	1	Manchester City	\N	\N	19
447	1	Manchester City	\N	\N	19
448	1	Tottenham Hotspur	\N	\N	9
449	1	Nottingham Forest	\N	\N	6
450	1	Burnley	\N	\N	4
451	1	Burnley	\N	\N	4
452	1	Nottingham Forest	\N	\N	6
453	1	Brighton & Hove 2	\N	\N	2
454	1	Everton	\N	\N	11
455	1	Everton	\N	\N	11
456	1	Brighton & Hove 2	\N	\N	2
457	1	Liverpool	\N	\N	17
458	1	Fulham	\N	\N	7
459	1	Fulham	\N	\N	7
460	1	Liverpool	\N	\N	17
461	1	Luton Town	\N	\N	14
462	1	Chelsea	\N	\N	13
463	1	Chelsea	\N	\N	13
464	1	Luton Town	\N	\N	14
465	1	Arsenal	\N	\N	12
466	1	Manchester United	\N	\N	1
467	1	Manchester United	\N	\N	1
468	1	Arsenal	\N	\N	12
469	1	Brentford	\N	\N	18
470	1	Crystal Palace	\N	\N	15
471	1	Crystal Palace	\N	\N	15
472	1	Brentford	\N	\N	18
473	1	Wolverhampton	\N	\N	20
474	1	Sheffield United	\N	\N	8
475	1	Sheffield United	\N	\N	8
476	1	Wolverhampton	\N	\N	20
477	1	Bournemouth	\N	\N	3
478	1	West Ham United	\N	\N	5
479	1	West Ham United	\N	\N	5
480	1	Bournemouth	\N	\N	3
481	1	Luton Town	\N	\N	14
482	1	Arsenal	\N	\N	12
483	1	Arsenal	\N	\N	12
484	1	Luton Town	\N	\N	14
485	1	Tottenham Hotspur	\N	\N	9
486	1	West Ham United	\N	\N	5
487	1	West Ham United	\N	\N	5
488	1	Tottenham Hotspur	\N	\N	9
489	1	Bournemouth	\N	\N	3
490	1	Newcastle United	\N	\N	10
491	1	Newcastle United	\N	\N	10
492	1	Bournemouth	\N	\N	3
493	1	Brighton & Hove 2	\N	\N	2
494	1	Aston Villa	\N	\N	16
495	1	Aston Villa	\N	\N	16
496	1	Brighton & Hove 2	\N	\N	2
497	1	Fulham	\N	\N	7
498	1	Wolverhampton	\N	\N	20
499	1	Wolverhampton	\N	\N	20
500	1	Fulham	\N	\N	7
501	1	Manchester United	\N	\N	1
502	1	Everton	\N	\N	11
503	1	Everton	\N	\N	11
504	1	Manchester United	\N	\N	1
505	1	Liverpool	\N	\N	17
506	1	Crystal Palace	\N	\N	15
507	1	Crystal Palace	\N	\N	15
508	1	Liverpool	\N	\N	17
509	1	Burnley	\N	\N	4
510	1	Chelsea	\N	\N	13
511	1	Chelsea	\N	\N	13
512	1	Burnley	\N	\N	4
513	1	Manchester City	\N	\N	19
514	1	Sheffield United	\N	\N	8
515	1	Sheffield United	\N	\N	8
516	1	Manchester City	\N	\N	19
517	1	Brentford	\N	\N	18
518	1	Nottingham Forest	\N	\N	6
519	1	Nottingham Forest	\N	\N	6
520	1	Brentford	\N	\N	18
521	1	Fulham	\N	\N	7
522	1	Manchester City	\N	\N	19
523	1	Manchester City	\N	\N	19
524	1	Fulham	\N	\N	7
525	1	Arsenal	\N	\N	12
526	1	Liverpool	\N	\N	17
527	1	Liverpool	\N	\N	17
528	1	Arsenal	\N	\N	12
529	1	Aston Villa	\N	\N	16
530	1	Wolverhampton	\N	\N	20
531	1	Wolverhampton	\N	\N	20
532	1	Aston Villa	\N	\N	16
533	1	Brentford	\N	\N	18
534	1	Burnley	\N	\N	4
535	1	Burnley	\N	\N	4
536	1	Brentford	\N	\N	18
537	1	Everton	\N	\N	11
538	1	Crystal Palace	\N	\N	15
539	1	Crystal Palace	\N	\N	15
540	1	Everton	\N	\N	11
541	1	Nottingham Forest	\N	\N	6
542	1	Bournemouth	\N	\N	3
543	1	Bournemouth	\N	\N	3
544	1	Nottingham Forest	\N	\N	6
545	1	Manchester United	\N	\N	1
546	1	Tottenham Hotspur	\N	\N	9
547	1	Tottenham Hotspur	\N	\N	9
548	1	Manchester United	\N	\N	1
549	1	Brighton & Hove 2	\N	\N	2
550	1	Sheffield United	\N	\N	8
551	1	Sheffield United	\N	\N	8
552	1	Brighton & Hove 2	\N	\N	2
553	1	Chelsea	\N	\N	13
554	1	West Ham United	\N	\N	5
555	1	West Ham United	\N	\N	5
556	1	Chelsea	\N	\N	13
557	1	Luton Town	\N	\N	14
558	1	Newcastle United	\N	\N	10
559	1	Newcastle United	\N	\N	10
560	1	Luton Town	\N	\N	14
561	1	Chelsea	\N	\N	13
562	1	Aston Villa	\N	\N	16
563	1	Aston Villa	\N	\N	16
564	1	Chelsea	\N	\N	13
565	1	Manchester United	\N	\N	1
566	1	Luton Town	\N	\N	14
567	1	Luton Town	\N	\N	14
568	1	Manchester United	\N	\N	1
569	1	Brentford	\N	\N	18
570	1	Brighton & Hove 2	\N	\N	2
571	1	Brighton & Hove 2	\N	\N	2
572	1	Brentford	\N	\N	18
573	1	West Ham United	\N	\N	5
574	1	Fulham	\N	\N	7
575	1	Fulham	\N	\N	7
576	1	West Ham United	\N	\N	5
577	1	Burnley	\N	\N	4
578	1	Wolverhampton	\N	\N	20
579	1	Wolverhampton	\N	\N	20
580	1	Burnley	\N	\N	4
581	1	Arsenal	\N	\N	12
582	1	Tottenham Hotspur	\N	\N	9
583	1	Tottenham Hotspur	\N	\N	9
584	1	Arsenal	\N	\N	12
585	1	Newcastle United	\N	\N	10
586	1	Sheffield United	\N	\N	8
587	1	Sheffield United	\N	\N	8
588	1	Newcastle United	\N	\N	10
589	1	Liverpool	\N	\N	17
590	1	Manchester City	\N	\N	19
591	1	Manchester City	\N	\N	19
592	1	Liverpool	\N	\N	17
593	1	Everton	\N	\N	11
594	1	Bournemouth	\N	\N	3
595	1	Bournemouth	\N	\N	3
596	1	Everton	\N	\N	11
597	1	Crystal Palace	\N	\N	15
598	1	Nottingham Forest	\N	\N	6
599	1	Nottingham Forest	\N	\N	6
600	1	Crystal Palace	\N	\N	15
601	1	Burnley	\N	\N	4
602	1	Brighton & Hove 2	\N	\N	2
603	1	Brighton & Hove 2	\N	\N	2
604	1	Burnley	\N	\N	4
605	1	Arsenal	\N	\N	12
606	1	Everton	\N	\N	11
607	1	Everton	\N	\N	11
608	1	Arsenal	\N	\N	12
609	1	Brentford	\N	\N	18
610	1	Manchester City	\N	\N	19
611	1	Manchester City	\N	\N	19
612	1	Brentford	\N	\N	18
613	1	Nottingham Forest	\N	\N	6
614	1	Manchester United	\N	\N	1
615	1	Manchester United	\N	\N	1
616	1	Nottingham Forest	\N	\N	6
617	1	Tottenham Hotspur	\N	\N	9
618	1	Bournemouth	\N	\N	3
619	1	Bournemouth	\N	\N	3
620	1	Tottenham Hotspur	\N	\N	9
621	1	West Ham United	\N	\N	5
622	1	Newcastle United	\N	\N	10
623	1	Newcastle United	\N	\N	10
624	1	West Ham United	\N	\N	5
625	1	Liverpool	\N	\N	17
626	1	Wolverhampton	\N	\N	20
627	1	Wolverhampton	\N	\N	20
628	1	Liverpool	\N	\N	17
629	1	Fulham	\N	\N	7
630	1	Chelsea	\N	\N	13
631	1	Chelsea	\N	\N	13
632	1	Fulham	\N	\N	7
633	1	Crystal Palace	\N	\N	15
634	1	Sheffield United	\N	\N	8
635	1	Sheffield United	\N	\N	8
636	1	Crystal Palace	\N	\N	15
637	1	Aston Villa	\N	\N	16
638	1	Luton Town	\N	\N	14
639	1	Luton Town	\N	\N	14
640	1	Aston Villa	\N	\N	16
641	1	Aston Villa	\N	\N	16
642	1	Manchester United	\N	\N	1
643	1	Manchester United	\N	\N	1
644	1	Aston Villa	\N	\N	16
645	1	Brighton & Hove 2	\N	\N	2
646	1	Tottenham Hotspur	\N	\N	9
647	1	Tottenham Hotspur	\N	\N	9
648	1	Brighton & Hove 2	\N	\N	2
649	1	Brentford	\N	\N	18
650	1	West Ham United	\N	\N	5
651	1	West Ham United	\N	\N	5
652	1	Brentford	\N	\N	18
653	1	Crystal Palace	\N	\N	15
654	1	Wolverhampton	\N	\N	20
655	1	Wolverhampton	\N	\N	20
656	1	Crystal Palace	\N	\N	15
657	1	Burnley	\N	\N	4
658	1	Newcastle United	\N	\N	10
659	1	Newcastle United	\N	\N	10
660	1	Burnley	\N	\N	4
661	1	Manchester City	\N	\N	19
662	1	Luton Town	\N	\N	14
663	1	Luton Town	\N	\N	14
664	1	Manchester City	\N	\N	19
665	1	Bournemouth	\N	\N	3
666	1	Sheffield United	\N	\N	8
667	1	Sheffield United	\N	\N	8
668	1	Bournemouth	\N	\N	3
669	1	Arsenal	\N	\N	12
670	1	Chelsea	\N	\N	13
671	1	Chelsea	\N	\N	13
672	1	Arsenal	\N	\N	12
673	1	Liverpool	\N	\N	17
674	1	Nottingham Forest	\N	\N	6
675	1	Nottingham Forest	\N	\N	6
676	1	Liverpool	\N	\N	17
677	1	Fulham	\N	\N	7
678	1	Everton	\N	\N	11
679	1	Everton	\N	\N	11
680	1	Fulham	\N	\N	7
681	1	Crystal Palace	\N	\N	15
682	1	Bournemouth	\N	\N	3
683	1	Bournemouth	\N	\N	3
684	1	Crystal Palace	\N	\N	15
685	1	Tottenham Hotspur	\N	\N	9
686	1	Newcastle United	\N	\N	10
687	1	Newcastle United	\N	\N	10
688	1	Tottenham Hotspur	\N	\N	9
689	1	Arsenal	\N	\N	12
690	1	West Ham United	\N	\N	5
691	1	West Ham United	\N	\N	5
692	1	Arsenal	\N	\N	12
693	1	Fulham	\N	\N	7
694	1	Sheffield United	\N	\N	8
695	1	Sheffield United	\N	\N	8
696	1	Fulham	\N	\N	7
697	1	Everton	\N	\N	11
698	1	Luton Town	\N	\N	14
699	1	Luton Town	\N	\N	14
700	1	Everton	\N	\N	11
701	1	Manchester United	\N	\N	1
702	1	Manchester City	\N	\N	19
703	1	Manchester City	\N	\N	19
704	1	Manchester United	\N	\N	1
705	1	Burnley	\N	\N	4
706	1	Liverpool	\N	\N	17
707	1	Liverpool	\N	\N	17
708	1	Burnley	\N	\N	4
709	1	Wolverhampton	\N	\N	20
710	1	Chelsea	\N	\N	13
711	1	Chelsea	\N	\N	13
712	1	Wolverhampton	\N	\N	20
713	1	Aston Villa	\N	\N	16
714	1	Brentford	\N	\N	18
715	1	Brentford	\N	\N	18
716	1	Aston Villa	\N	\N	16
717	1	Nottingham Forest	\N	\N	6
718	1	Brighton & Hove 2	\N	\N	2
719	1	Brighton & Hove 2	\N	\N	2
720	1	Nottingham Forest	\N	\N	6
721	1	Fulham	\N	\N	7
722	1	Bournemouth	\N	\N	3
723	1	Bournemouth	\N	\N	3
724	1	Fulham	\N	\N	7
725	1	Wolverhampton	\N	\N	20
726	1	Manchester United	\N	\N	1
727	1	Manchester United	\N	\N	1
728	1	Wolverhampton	\N	\N	20
729	1	Brentford	\N	\N	18
730	1	Tottenham Hotspur	\N	\N	9
731	1	Tottenham Hotspur	\N	\N	9
732	1	Brentford	\N	\N	18
733	1	Brighton & Hove 2	\N	\N	2
734	1	Arsenal	\N	\N	12
735	1	Arsenal	\N	\N	12
736	1	Brighton & Hove 2	\N	\N	2
737	1	West Ham United	\N	\N	5
738	1	Nottingham Forest	\N	\N	6
739	1	Nottingham Forest	\N	\N	6
740	1	West Ham United	\N	\N	5
741	1	Crystal Palace	\N	\N	15
742	1	Chelsea	\N	\N	13
743	1	Chelsea	\N	\N	13
744	1	Crystal Palace	\N	\N	15
745	1	Newcastle United	\N	\N	10
746	1	Everton	\N	\N	11
747	1	Everton	\N	\N	11
748	1	Newcastle United	\N	\N	10
749	1	Luton Town	\N	\N	14
750	1	Burnley	\N	\N	4
751	1	Burnley	\N	\N	4
752	1	Luton Town	\N	\N	14
753	1	Aston Villa	\N	\N	16
754	1	Manchester City	\N	\N	19
755	1	Manchester City	\N	\N	19
756	1	Aston Villa	\N	\N	16
757	1	Sheffield United	\N	\N	8
758	1	Liverpool	\N	\N	17
759	1	Liverpool	\N	\N	17
760	1	Sheffield United	\N	\N	8
761	2	NK Varaždin	\N	\N	21
762	2	NK Lokomotiva Zagreb	\N	\N	25
763	2	NK Lokomotiva Zagreb	\N	\N	25
764	2	NK Varaždin	\N	\N	21
765	2	NK Varaždin	\N	\N	21
766	2	NK Lokomotiva Zagreb	\N	\N	25
767	2	NK Lokomotiva Zagreb	\N	\N	25
768	2	NK Varaždin	\N	\N	21
769	2	NK Osijek	\N	\N	30
770	2	NK Rudeš	\N	\N	22
771	2	NK Rudeš	\N	\N	22
772	2	NK Osijek	\N	\N	30
773	2	NK Osijek	\N	\N	30
774	2	NK Rudeš	\N	\N	22
775	2	NK Rudeš	\N	\N	22
776	2	NK Osijek	\N	\N	30
777	2	HNK Gorica	\N	\N	26
778	2	HNK Rijeka	\N	\N	24
779	2	HNK Rijeka	\N	\N	24
780	2	HNK Gorica	\N	\N	26
781	2	HNK Gorica	\N	\N	26
782	2	HNK Rijeka	\N	\N	24
783	2	HNK Rijeka	\N	\N	24
784	2	HNK Gorica	\N	\N	26
785	2	NK Istra 1961	\N	\N	23
786	2	GNK Dinamo Zagreb	\N	\N	28
787	2	GNK Dinamo Zagreb	\N	\N	28
788	2	NK Istra 1961	\N	\N	23
789	2	NK Istra 1961	\N	\N	23
790	2	GNK Dinamo Zagreb	\N	\N	28
791	2	GNK Dinamo Zagreb	\N	\N	28
792	2	NK Istra 1961	\N	\N	23
793	2	NK Slaven Belupo	\N	\N	29
794	2	HNK Hajduk Split	\N	\N	27
795	2	HNK Hajduk Split	\N	\N	27
796	2	NK Slaven Belupo	\N	\N	29
797	2	NK Slaven Belupo	\N	\N	29
798	2	HNK Hajduk Split	\N	\N	27
799	2	HNK Hajduk Split	\N	\N	27
800	2	NK Slaven Belupo	\N	\N	29
801	2	NK Lokomotiva Zagreb	\N	\N	25
802	2	HNK Hajduk Split	\N	\N	27
803	2	HNK Hajduk Split	\N	\N	27
804	2	NK Lokomotiva Zagreb	\N	\N	25
805	2	NK Lokomotiva Zagreb	\N	\N	25
806	2	HNK Hajduk Split	\N	\N	27
807	2	HNK Hajduk Split	\N	\N	27
808	2	NK Lokomotiva Zagreb	\N	\N	25
809	2	GNK Dinamo Zagreb	\N	\N	28
810	2	HNK Rijeka	\N	\N	24
811	2	HNK Rijeka	\N	\N	24
812	2	GNK Dinamo Zagreb	\N	\N	28
813	2	GNK Dinamo Zagreb	\N	\N	28
814	2	HNK Rijeka	\N	\N	24
815	2	HNK Rijeka	\N	\N	24
816	2	GNK Dinamo Zagreb	\N	\N	28
817	2	NK Varaždin	\N	\N	21
818	2	NK Osijek	\N	\N	30
819	2	NK Osijek	\N	\N	30
820	2	NK Varaždin	\N	\N	21
821	2	NK Varaždin	\N	\N	21
822	2	NK Osijek	\N	\N	30
823	2	NK Osijek	\N	\N	30
824	2	NK Varaždin	\N	\N	21
825	2	NK Slaven Belupo	\N	\N	29
826	2	HNK Gorica	\N	\N	26
827	2	HNK Gorica	\N	\N	26
828	2	NK Slaven Belupo	\N	\N	29
829	2	NK Slaven Belupo	\N	\N	29
830	2	HNK Gorica	\N	\N	26
831	2	HNK Gorica	\N	\N	26
832	2	NK Slaven Belupo	\N	\N	29
833	2	NK Rudeš	\N	\N	22
834	2	NK Istra 1961	\N	\N	23
835	2	NK Istra 1961	\N	\N	23
836	2	NK Rudeš	\N	\N	22
837	2	NK Rudeš	\N	\N	22
838	2	NK Istra 1961	\N	\N	23
839	2	NK Istra 1961	\N	\N	23
840	2	NK Rudeš	\N	\N	22
841	2	HNK Rijeka	\N	\N	24
842	2	NK Osijek	\N	\N	30
843	2	NK Osijek	\N	\N	30
844	2	HNK Rijeka	\N	\N	24
845	2	HNK Rijeka	\N	\N	24
846	2	NK Osijek	\N	\N	30
847	2	NK Osijek	\N	\N	30
848	2	HNK Rijeka	\N	\N	24
849	2	NK Slaven Belupo	\N	\N	29
850	2	NK Istra 1961	\N	\N	23
851	2	NK Istra 1961	\N	\N	23
852	2	NK Slaven Belupo	\N	\N	29
853	2	NK Slaven Belupo	\N	\N	29
854	2	NK Istra 1961	\N	\N	23
855	2	NK Istra 1961	\N	\N	23
856	2	NK Slaven Belupo	\N	\N	29
857	2	HNK Hajduk Split	\N	\N	27
858	2	HNK Gorica	\N	\N	26
859	2	HNK Gorica	\N	\N	26
860	2	HNK Hajduk Split	\N	\N	27
861	2	HNK Hajduk Split	\N	\N	27
862	2	HNK Gorica	\N	\N	26
863	2	HNK Gorica	\N	\N	26
864	2	HNK Hajduk Split	\N	\N	27
865	2	NK Varaždin	\N	\N	21
866	2	NK Rudeš	\N	\N	22
867	2	NK Rudeš	\N	\N	22
868	2	NK Varaždin	\N	\N	21
869	2	NK Varaždin	\N	\N	21
870	2	NK Rudeš	\N	\N	22
871	2	NK Rudeš	\N	\N	22
872	2	NK Varaždin	\N	\N	21
873	2	NK Lokomotiva Zagreb	\N	\N	25
874	2	GNK Dinamo Zagreb	\N	\N	28
875	2	GNK Dinamo Zagreb	\N	\N	28
876	2	NK Lokomotiva Zagreb	\N	\N	25
877	2	NK Lokomotiva Zagreb	\N	\N	25
878	2	GNK Dinamo Zagreb	\N	\N	28
879	2	GNK Dinamo Zagreb	\N	\N	28
880	2	NK Lokomotiva Zagreb	\N	\N	25
881	2	NK Slaven Belupo	\N	\N	29
882	2	GNK Dinamo Zagreb	\N	\N	28
883	2	GNK Dinamo Zagreb	\N	\N	28
884	2	NK Slaven Belupo	\N	\N	29
885	2	NK Slaven Belupo	\N	\N	29
886	2	GNK Dinamo Zagreb	\N	\N	28
887	2	GNK Dinamo Zagreb	\N	\N	28
888	2	NK Slaven Belupo	\N	\N	29
889	2	NK Varaždin	\N	\N	21
890	2	NK Istra 1961	\N	\N	23
891	2	NK Istra 1961	\N	\N	23
892	2	NK Varaždin	\N	\N	21
893	2	NK Varaždin	\N	\N	21
894	2	NK Istra 1961	\N	\N	23
895	2	NK Istra 1961	\N	\N	23
896	2	NK Varaždin	\N	\N	21
897	2	NK Rudeš	\N	\N	22
898	2	NK Lokomotiva Zagreb	\N	\N	25
899	2	NK Lokomotiva Zagreb	\N	\N	25
900	2	NK Rudeš	\N	\N	22
901	2	NK Rudeš	\N	\N	22
902	2	NK Lokomotiva Zagreb	\N	\N	25
903	2	NK Lokomotiva Zagreb	\N	\N	25
904	2	NK Rudeš	\N	\N	22
905	2	NK Osijek	\N	\N	30
906	2	HNK Gorica	\N	\N	26
907	2	HNK Gorica	\N	\N	26
908	2	NK Osijek	\N	\N	30
909	2	NK Osijek	\N	\N	30
910	2	HNK Gorica	\N	\N	26
911	2	HNK Gorica	\N	\N	26
912	2	NK Osijek	\N	\N	30
913	2	HNK Rijeka	\N	\N	24
914	2	HNK Hajduk Split	\N	\N	27
915	2	HNK Hajduk Split	\N	\N	27
916	2	HNK Rijeka	\N	\N	24
917	2	HNK Rijeka	\N	\N	24
918	2	HNK Hajduk Split	\N	\N	27
919	2	HNK Hajduk Split	\N	\N	27
920	2	HNK Rijeka	\N	\N	24
921	2	NK Istra 1961	\N	\N	23
922	2	HNK Rijeka	\N	\N	24
923	2	HNK Rijeka	\N	\N	24
924	2	NK Istra 1961	\N	\N	23
925	2	NK Istra 1961	\N	\N	23
926	2	HNK Rijeka	\N	\N	24
927	2	HNK Rijeka	\N	\N	24
928	2	NK Istra 1961	\N	\N	23
929	2	NK Varaždin	\N	\N	21
930	2	GNK Dinamo Zagreb	\N	\N	28
931	2	GNK Dinamo Zagreb	\N	\N	28
932	2	NK Varaždin	\N	\N	21
933	2	NK Varaždin	\N	\N	21
934	2	GNK Dinamo Zagreb	\N	\N	28
935	2	GNK Dinamo Zagreb	\N	\N	28
936	2	NK Varaždin	\N	\N	21
937	2	NK Osijek	\N	\N	30
938	2	NK Slaven Belupo	\N	\N	29
939	2	NK Slaven Belupo	\N	\N	29
940	2	NK Osijek	\N	\N	30
941	2	NK Osijek	\N	\N	30
942	2	NK Slaven Belupo	\N	\N	29
943	2	NK Slaven Belupo	\N	\N	29
944	2	NK Osijek	\N	\N	30
945	2	NK Lokomotiva Zagreb	\N	\N	25
946	2	HNK Gorica	\N	\N	26
947	2	HNK Gorica	\N	\N	26
948	2	NK Lokomotiva Zagreb	\N	\N	25
949	2	NK Lokomotiva Zagreb	\N	\N	25
950	2	HNK Gorica	\N	\N	26
951	2	HNK Gorica	\N	\N	26
952	2	NK Lokomotiva Zagreb	\N	\N	25
953	2	NK Rudeš	\N	\N	22
954	2	HNK Hajduk Split	\N	\N	27
955	2	HNK Hajduk Split	\N	\N	27
956	2	NK Rudeš	\N	\N	22
957	2	NK Rudeš	\N	\N	22
958	2	HNK Hajduk Split	\N	\N	27
959	2	HNK Hajduk Split	\N	\N	27
960	2	NK Rudeš	\N	\N	22
961	2	NK Osijek	\N	\N	30
962	2	NK Lokomotiva Zagreb	\N	\N	25
963	2	NK Lokomotiva Zagreb	\N	\N	25
964	2	NK Osijek	\N	\N	30
965	2	NK Osijek	\N	\N	30
966	2	NK Lokomotiva Zagreb	\N	\N	25
967	2	NK Lokomotiva Zagreb	\N	\N	25
968	2	NK Osijek	\N	\N	30
969	2	NK Rudeš	\N	\N	22
970	2	GNK Dinamo Zagreb	\N	\N	28
971	2	GNK Dinamo Zagreb	\N	\N	28
972	2	NK Rudeš	\N	\N	22
973	2	NK Rudeš	\N	\N	22
974	2	GNK Dinamo Zagreb	\N	\N	28
975	2	GNK Dinamo Zagreb	\N	\N	28
976	2	NK Rudeš	\N	\N	22
977	2	NK Istra 1961	\N	\N	23
978	2	HNK Hajduk Split	\N	\N	27
979	2	HNK Hajduk Split	\N	\N	27
980	2	NK Istra 1961	\N	\N	23
981	2	NK Istra 1961	\N	\N	23
982	2	HNK Hajduk Split	\N	\N	27
983	2	HNK Hajduk Split	\N	\N	27
984	2	NK Istra 1961	\N	\N	23
985	2	NK Slaven Belupo	\N	\N	29
986	2	HNK Rijeka	\N	\N	24
987	2	HNK Rijeka	\N	\N	24
988	2	NK Slaven Belupo	\N	\N	29
989	2	NK Slaven Belupo	\N	\N	29
990	2	HNK Rijeka	\N	\N	24
991	2	HNK Rijeka	\N	\N	24
992	2	NK Slaven Belupo	\N	\N	29
993	2	HNK Gorica	\N	\N	26
994	2	NK Varaždin	\N	\N	21
995	2	NK Varaždin	\N	\N	21
996	2	HNK Gorica	\N	\N	26
997	2	HNK Gorica	\N	\N	26
998	2	NK Varaždin	\N	\N	21
999	2	NK Varaždin	\N	\N	21
1000	2	HNK Gorica	\N	\N	26
1001	2	HNK Rijeka	\N	\N	24
1002	2	NK Lokomotiva Zagreb	\N	\N	25
1003	2	NK Lokomotiva Zagreb	\N	\N	25
1004	2	HNK Rijeka	\N	\N	24
1005	2	HNK Rijeka	\N	\N	24
1006	2	NK Lokomotiva Zagreb	\N	\N	25
1007	2	NK Lokomotiva Zagreb	\N	\N	25
1008	2	HNK Rijeka	\N	\N	24
1009	2	NK Varaždin	\N	\N	21
1010	2	HNK Hajduk Split	\N	\N	27
1011	2	HNK Hajduk Split	\N	\N	27
1012	2	NK Varaždin	\N	\N	21
1013	2	NK Varaždin	\N	\N	21
1014	2	HNK Hajduk Split	\N	\N	27
1015	2	HNK Hajduk Split	\N	\N	27
1016	2	NK Varaždin	\N	\N	21
1017	2	NK Osijek	\N	\N	30
1018	2	GNK Dinamo Zagreb	\N	\N	28
1019	2	GNK Dinamo Zagreb	\N	\N	28
1020	2	NK Osijek	\N	\N	30
1021	2	NK Osijek	\N	\N	30
1022	2	GNK Dinamo Zagreb	\N	\N	28
1023	2	GNK Dinamo Zagreb	\N	\N	28
1024	2	NK Osijek	\N	\N	30
1025	2	HNK Gorica	\N	\N	26
1026	2	NK Istra 1961	\N	\N	23
1027	2	NK Istra 1961	\N	\N	23
1028	2	HNK Gorica	\N	\N	26
1029	2	HNK Gorica	\N	\N	26
1030	2	NK Istra 1961	\N	\N	23
1031	2	NK Istra 1961	\N	\N	23
1032	2	HNK Gorica	\N	\N	26
1033	2	NK Slaven Belupo	\N	\N	29
1034	2	NK Rudeš	\N	\N	22
1035	2	NK Rudeš	\N	\N	22
1036	2	NK Slaven Belupo	\N	\N	29
1037	2	NK Slaven Belupo	\N	\N	29
1038	2	NK Rudeš	\N	\N	22
1039	2	NK Rudeš	\N	\N	22
1040	2	NK Slaven Belupo	\N	\N	29
1041	2	NK Rudeš	\N	\N	22
1042	2	HNK Rijeka	\N	\N	24
1043	2	HNK Rijeka	\N	\N	24
1044	2	NK Rudeš	\N	\N	22
1045	2	NK Rudeš	\N	\N	22
1046	2	HNK Rijeka	\N	\N	24
1047	2	HNK Rijeka	\N	\N	24
1048	2	NK Rudeš	\N	\N	22
1049	2	NK Varaždin	\N	\N	21
1050	2	NK Slaven Belupo	\N	\N	29
1051	2	NK Slaven Belupo	\N	\N	29
1052	2	NK Varaždin	\N	\N	21
1053	2	NK Varaždin	\N	\N	21
1054	2	NK Slaven Belupo	\N	\N	29
1055	2	NK Slaven Belupo	\N	\N	29
1056	2	NK Varaždin	\N	\N	21
1057	2	NK Istra 1961	\N	\N	23
1058	2	NK Lokomotiva Zagreb	\N	\N	25
1059	2	NK Lokomotiva Zagreb	\N	\N	25
1060	2	NK Istra 1961	\N	\N	23
1061	2	NK Istra 1961	\N	\N	23
1062	2	NK Lokomotiva Zagreb	\N	\N	25
1063	2	NK Lokomotiva Zagreb	\N	\N	25
1064	2	NK Istra 1961	\N	\N	23
1065	2	HNK Gorica	\N	\N	26
1066	2	GNK Dinamo Zagreb	\N	\N	28
1067	2	GNK Dinamo Zagreb	\N	\N	28
1068	2	HNK Gorica	\N	\N	26
1069	2	HNK Gorica	\N	\N	26
1070	2	GNK Dinamo Zagreb	\N	\N	28
1071	2	GNK Dinamo Zagreb	\N	\N	28
1072	2	HNK Gorica	\N	\N	26
1073	2	HNK Hajduk Split	\N	\N	27
1074	2	NK Osijek	\N	\N	30
1075	2	NK Osijek	\N	\N	30
1076	2	HNK Hajduk Split	\N	\N	27
1077	2	HNK Hajduk Split	\N	\N	27
1078	2	NK Osijek	\N	\N	30
1079	2	NK Osijek	\N	\N	30
1080	2	HNK Hajduk Split	\N	\N	27
1081	2	NK Lokomotiva Zagreb	\N	\N	25
1082	2	NK Slaven Belupo	\N	\N	29
1083	2	NK Slaven Belupo	\N	\N	29
1084	2	NK Lokomotiva Zagreb	\N	\N	25
1085	2	NK Lokomotiva Zagreb	\N	\N	25
1086	2	NK Slaven Belupo	\N	\N	29
1087	2	NK Slaven Belupo	\N	\N	29
1088	2	NK Lokomotiva Zagreb	\N	\N	25
1089	2	NK Varaždin	\N	\N	21
1090	2	HNK Rijeka	\N	\N	24
1091	2	HNK Rijeka	\N	\N	24
1092	2	NK Varaždin	\N	\N	21
1093	2	NK Varaždin	\N	\N	21
1094	2	HNK Rijeka	\N	\N	24
1095	2	HNK Rijeka	\N	\N	24
1096	2	NK Varaždin	\N	\N	21
1097	2	HNK Hajduk Split	\N	\N	27
1098	2	GNK Dinamo Zagreb	\N	\N	28
1099	2	GNK Dinamo Zagreb	\N	\N	28
1100	2	HNK Hajduk Split	\N	\N	27
1101	2	HNK Hajduk Split	\N	\N	27
1102	2	GNK Dinamo Zagreb	\N	\N	28
1103	2	GNK Dinamo Zagreb	\N	\N	28
1104	2	HNK Hajduk Split	\N	\N	27
1105	2	HNK Gorica	\N	\N	26
1106	2	NK Rudeš	\N	\N	22
1107	2	NK Rudeš	\N	\N	22
1108	2	HNK Gorica	\N	\N	26
1109	2	HNK Gorica	\N	\N	26
1110	2	NK Rudeš	\N	\N	22
1111	2	NK Rudeš	\N	\N	22
1112	2	HNK Gorica	\N	\N	26
1113	2	NK Istra 1961	\N	\N	23
1114	2	NK Osijek	\N	\N	30
1115	2	NK Osijek	\N	\N	30
1116	2	NK Istra 1961	\N	\N	23
1117	2	NK Istra 1961	\N	\N	23
1118	2	NK Osijek	\N	\N	30
1119	2	NK Osijek	\N	\N	30
1120	2	NK Istra 1961	\N	\N	23
1121	3	Villarreal	\N	\N	32
1122	3	Osasuna	\N	\N	34
1123	3	Osasuna	\N	\N	34
1124	3	Villarreal	\N	\N	32
1125	3	Las Palmas	\N	\N	39
1126	3	Getafe	\N	\N	42
1127	3	Getafe	\N	\N	42
1128	3	Las Palmas	\N	\N	39
1129	3	Real Betis	\N	\N	35
1130	3	Granada	\N	\N	31
1131	3	Granada	\N	\N	31
1132	3	Real Betis	\N	\N	35
1133	3	Deportivo Alavés	\N	\N	44
1134	3	Barcelona	\N	\N	37
1135	3	Barcelona	\N	\N	37
1136	3	Deportivo Alavés	\N	\N	44
1137	3	Atlético Madrid	\N	\N	49
1138	3	Mallorca	\N	\N	46
1139	3	Mallorca	\N	\N	46
1140	3	Atlético Madrid	\N	\N	49
1141	3	Valencia	\N	\N	45
1142	3	Celta Vigo	\N	\N	33
1143	3	Celta Vigo	\N	\N	33
1144	3	Valencia	\N	\N	45
1145	3	Sevilla	\N	\N	40
1146	3	Girona FC	\N	\N	38
1147	3	Girona FC	\N	\N	38
1148	3	Sevilla	\N	\N	40
1149	3	Real Sociedad	\N	\N	48
1150	3	Cádiz	\N	\N	50
1151	3	Cádiz	\N	\N	50
1152	3	Real Sociedad	\N	\N	48
1153	3	Athletic Club	\N	\N	36
1154	3	Rayo Vallecano	\N	\N	47
1155	3	Rayo Vallecano	\N	\N	47
1156	3	Athletic Club	\N	\N	36
1157	3	Almería	\N	\N	41
1158	3	Real Madrid	\N	\N	43
1159	3	Real Madrid	\N	\N	43
1160	3	Almería	\N	\N	41
1161	3	Valencia	\N	\N	45
1162	3	Athletic Club	\N	\N	36
1163	3	Athletic Club	\N	\N	36
1164	3	Valencia	\N	\N	45
1165	3	Almería	\N	\N	41
1166	3	Getafe	\N	\N	42
1167	3	Getafe	\N	\N	42
1168	3	Almería	\N	\N	41
1169	3	Rayo Vallecano	\N	\N	47
1170	3	Deportivo Alavés	\N	\N	44
1171	3	Deportivo Alavés	\N	\N	44
1172	3	Rayo Vallecano	\N	\N	47
1173	3	Cádiz	\N	\N	50
1174	3	Las Palmas	\N	\N	39
1175	3	Las Palmas	\N	\N	39
1176	3	Cádiz	\N	\N	50
1177	3	Girona FC	\N	\N	38
1178	3	Atlético Madrid	\N	\N	49
1179	3	Atlético Madrid	\N	\N	49
1180	3	Girona FC	\N	\N	38
1181	3	Granada	\N	\N	31
1182	3	Real Sociedad	\N	\N	48
1183	3	Real Sociedad	\N	\N	48
1184	3	Granada	\N	\N	31
1185	3	Barcelona	\N	\N	37
1186	3	Celta Vigo	\N	\N	33
1187	3	Celta Vigo	\N	\N	33
1188	3	Barcelona	\N	\N	37
1189	3	Sevilla	\N	\N	40
1190	3	Villarreal	\N	\N	32
1191	3	Villarreal	\N	\N	32
1192	3	Sevilla	\N	\N	40
1193	3	Mallorca	\N	\N	46
1194	3	Real Betis	\N	\N	35
1195	3	Real Betis	\N	\N	35
1196	3	Mallorca	\N	\N	46
1197	3	Real Madrid	\N	\N	43
1198	3	Osasuna	\N	\N	34
1199	3	Osasuna	\N	\N	34
1200	3	Real Madrid	\N	\N	43
1201	3	Granada	\N	\N	31
1202	3	Girona FC	\N	\N	38
1203	3	Girona FC	\N	\N	38
1204	3	Granada	\N	\N	31
1205	3	Almería	\N	\N	41
1206	3	Celta Vigo	\N	\N	33
1207	3	Celta Vigo	\N	\N	33
1208	3	Almería	\N	\N	41
1209	3	Real Madrid	\N	\N	43
1210	3	Sevilla	\N	\N	40
1211	3	Sevilla	\N	\N	40
1212	3	Real Madrid	\N	\N	43
1213	3	Villarreal	\N	\N	32
1214	3	Valencia	\N	\N	45
1215	3	Valencia	\N	\N	45
1216	3	Villarreal	\N	\N	32
1217	3	Deportivo Alavés	\N	\N	44
1218	3	Cádiz	\N	\N	50
1219	3	Cádiz	\N	\N	50
1220	3	Deportivo Alavés	\N	\N	44
1221	3	Real Betis	\N	\N	35
1222	3	Real Sociedad	\N	\N	48
1223	3	Real Sociedad	\N	\N	48
1224	3	Real Betis	\N	\N	35
1225	3	Rayo Vallecano	\N	\N	47
1226	3	Atlético Madrid	\N	\N	49
1227	3	Atlético Madrid	\N	\N	49
1228	3	Rayo Vallecano	\N	\N	47
1229	3	Osasuna	\N	\N	34
1230	3	Athletic Club	\N	\N	36
1231	3	Athletic Club	\N	\N	36
1232	3	Osasuna	\N	\N	34
1233	3	Las Palmas	\N	\N	39
1234	3	Mallorca	\N	\N	46
1235	3	Mallorca	\N	\N	46
1236	3	Las Palmas	\N	\N	39
1237	3	Barcelona	\N	\N	37
1238	3	Getafe	\N	\N	42
1239	3	Getafe	\N	\N	42
1240	3	Barcelona	\N	\N	37
1241	3	Mallorca	\N	\N	46
1242	3	Celta Vigo	\N	\N	33
1243	3	Celta Vigo	\N	\N	33
1244	3	Mallorca	\N	\N	46
1245	3	Valencia	\N	\N	45
1246	3	Las Palmas	\N	\N	39
1247	3	Las Palmas	\N	\N	39
1248	3	Valencia	\N	\N	45
1249	3	Rayo Vallecano	\N	\N	47
1250	3	Almería	\N	\N	41
1251	3	Almería	\N	\N	41
1252	3	Rayo Vallecano	\N	\N	47
1253	3	Real Madrid	\N	\N	43
1254	3	Real Sociedad	\N	\N	48
1255	3	Real Sociedad	\N	\N	48
1256	3	Real Madrid	\N	\N	43
1257	3	Villarreal	\N	\N	32
1258	3	Granada	\N	\N	31
1259	3	Granada	\N	\N	31
1260	3	Villarreal	\N	\N	32
1261	3	Atlético Madrid	\N	\N	49
1262	3	Barcelona	\N	\N	37
1263	3	Barcelona	\N	\N	37
1264	3	Atlético Madrid	\N	\N	49
1265	3	Getafe	\N	\N	42
1266	3	Real Betis	\N	\N	35
1267	3	Real Betis	\N	\N	35
1268	3	Getafe	\N	\N	42
1269	3	Deportivo Alavés	\N	\N	44
1270	3	Girona FC	\N	\N	38
1271	3	Girona FC	\N	\N	38
1272	3	Deportivo Alavés	\N	\N	44
1273	3	Cádiz	\N	\N	50
1274	3	Athletic Club	\N	\N	36
1275	3	Athletic Club	\N	\N	36
1276	3	Cádiz	\N	\N	50
1277	3	Sevilla	\N	\N	40
1278	3	Osasuna	\N	\N	34
1279	3	Osasuna	\N	\N	34
1280	3	Sevilla	\N	\N	40
1281	3	Villarreal	\N	\N	32
1282	3	Barcelona	\N	\N	37
1283	3	Barcelona	\N	\N	37
1284	3	Villarreal	\N	\N	32
1285	3	Real Sociedad	\N	\N	48
1286	3	Valencia	\N	\N	45
1287	3	Valencia	\N	\N	45
1288	3	Real Sociedad	\N	\N	48
1289	3	Girona FC	\N	\N	38
1290	3	Almería	\N	\N	41
1291	3	Almería	\N	\N	41
1292	3	Girona FC	\N	\N	38
1293	3	Deportivo Alavés	\N	\N	44
1294	3	Las Palmas	\N	\N	39
1295	3	Las Palmas	\N	\N	39
1296	3	Deportivo Alavés	\N	\N	44
1297	3	Osasuna	\N	\N	34
1298	3	Rayo Vallecano	\N	\N	47
1299	3	Rayo Vallecano	\N	\N	47
1300	3	Osasuna	\N	\N	34
1301	3	Real Betis	\N	\N	35
1302	3	Atlético Madrid	\N	\N	49
1303	3	Atlético Madrid	\N	\N	49
1304	3	Real Betis	\N	\N	35
1305	3	Getafe	\N	\N	42
1306	3	Athletic Club	\N	\N	36
1307	3	Athletic Club	\N	\N	36
1308	3	Getafe	\N	\N	42
1309	3	Mallorca	\N	\N	46
1310	3	Cádiz	\N	\N	50
1311	3	Cádiz	\N	\N	50
1312	3	Mallorca	\N	\N	46
1313	3	Sevilla	\N	\N	40
1314	3	Celta Vigo	\N	\N	33
1315	3	Celta Vigo	\N	\N	33
1316	3	Sevilla	\N	\N	40
1317	3	Granada	\N	\N	31
1318	3	Real Madrid	\N	\N	43
1319	3	Real Madrid	\N	\N	43
1320	3	Granada	\N	\N	31
1321	3	Real Madrid	\N	\N	43
1322	3	Cádiz	\N	\N	50
1323	3	Cádiz	\N	\N	50
1324	3	Real Madrid	\N	\N	43
1325	3	Almería	\N	\N	41
1326	3	Granada	\N	\N	31
1327	3	Granada	\N	\N	31
1328	3	Almería	\N	\N	41
1329	3	Sevilla	\N	\N	40
1330	3	Real Sociedad	\N	\N	48
1331	3	Real Sociedad	\N	\N	48
1332	3	Sevilla	\N	\N	40
1333	3	Valencia	\N	\N	45
1334	3	Real Betis	\N	\N	35
1335	3	Real Betis	\N	\N	35
1336	3	Valencia	\N	\N	45
1337	3	Mallorca	\N	\N	46
1338	3	Villarreal	\N	\N	32
1339	3	Villarreal	\N	\N	32
1340	3	Mallorca	\N	\N	46
1341	3	Deportivo Alavés	\N	\N	44
1342	3	Getafe	\N	\N	42
1343	3	Getafe	\N	\N	42
1344	3	Deportivo Alavés	\N	\N	44
1345	3	Athletic Club	\N	\N	36
1346	3	Barcelona	\N	\N	37
1347	3	Barcelona	\N	\N	37
1348	3	Athletic Club	\N	\N	36
1349	3	Osasuna	\N	\N	34
1350	3	Atlético Madrid	\N	\N	49
1351	3	Atlético Madrid	\N	\N	49
1352	3	Osasuna	\N	\N	34
1353	3	Girona FC	\N	\N	38
1354	3	Rayo Vallecano	\N	\N	47
1355	3	Rayo Vallecano	\N	\N	47
1356	3	Girona FC	\N	\N	38
1357	3	Celta Vigo	\N	\N	33
1358	3	Las Palmas	\N	\N	39
1359	3	Las Palmas	\N	\N	39
1360	3	Celta Vigo	\N	\N	33
1361	3	Real Sociedad	\N	\N	48
1362	3	Girona FC	\N	\N	38
1363	3	Girona FC	\N	\N	38
1364	3	Real Sociedad	\N	\N	48
1365	3	Granada	\N	\N	31
1366	3	Rayo Vallecano	\N	\N	47
1367	3	Rayo Vallecano	\N	\N	47
1368	3	Granada	\N	\N	31
1369	3	Getafe	\N	\N	42
1370	3	Mallorca	\N	\N	46
1371	3	Mallorca	\N	\N	46
1372	3	Getafe	\N	\N	42
1373	3	Valencia	\N	\N	45
1374	3	Almería	\N	\N	41
1375	3	Almería	\N	\N	41
1376	3	Valencia	\N	\N	45
1377	3	Sevilla	\N	\N	40
1378	3	Athletic Club	\N	\N	36
1379	3	Athletic Club	\N	\N	36
1380	3	Sevilla	\N	\N	40
1381	3	Las Palmas	\N	\N	39
1382	3	Real Madrid	\N	\N	43
1383	3	Real Madrid	\N	\N	43
1384	3	Las Palmas	\N	\N	39
1385	3	Deportivo Alavés	\N	\N	44
1386	3	Atlético Madrid	\N	\N	49
1387	3	Atlético Madrid	\N	\N	49
1388	3	Deportivo Alavés	\N	\N	44
1389	3	Villarreal	\N	\N	32
1390	3	Cádiz	\N	\N	50
1391	3	Cádiz	\N	\N	50
1392	3	Villarreal	\N	\N	32
1393	3	Celta Vigo	\N	\N	33
1394	3	Real Betis	\N	\N	35
1395	3	Real Betis	\N	\N	35
1396	3	Celta Vigo	\N	\N	33
1397	3	Osasuna	\N	\N	34
1398	3	Barcelona	\N	\N	37
1399	3	Barcelona	\N	\N	37
1400	3	Osasuna	\N	\N	34
1401	3	Real Madrid	\N	\N	43
1402	3	Valencia	\N	\N	45
1403	3	Valencia	\N	\N	45
1404	3	Real Madrid	\N	\N	43
1405	3	Real Betis	\N	\N	35
1406	3	Sevilla	\N	\N	40
1407	3	Sevilla	\N	\N	40
1408	3	Real Betis	\N	\N	35
1409	3	Girona FC	\N	\N	38
1410	3	Osasuna	\N	\N	34
1411	3	Osasuna	\N	\N	34
1412	3	Girona FC	\N	\N	38
1413	3	Mallorca	\N	\N	46
1414	3	Granada	\N	\N	31
1415	3	Granada	\N	\N	31
1416	3	Mallorca	\N	\N	46
1417	3	Celta Vigo	\N	\N	33
1418	3	Atlético Madrid	\N	\N	49
1419	3	Atlético Madrid	\N	\N	49
1420	3	Celta Vigo	\N	\N	33
1421	3	Athletic Club	\N	\N	36
1422	3	Villarreal	\N	\N	32
1423	3	Villarreal	\N	\N	32
1424	3	Athletic Club	\N	\N	36
1425	3	Getafe	\N	\N	42
1426	3	Rayo Vallecano	\N	\N	47
1427	3	Rayo Vallecano	\N	\N	47
1428	3	Getafe	\N	\N	42
1429	3	Deportivo Alavés	\N	\N	44
1430	3	Real Sociedad	\N	\N	48
1431	3	Real Sociedad	\N	\N	48
1432	3	Deportivo Alavés	\N	\N	44
1433	3	Almería	\N	\N	41
1434	3	Las Palmas	\N	\N	39
1435	3	Las Palmas	\N	\N	39
1436	3	Almería	\N	\N	41
1437	3	Cádiz	\N	\N	50
1438	3	Barcelona	\N	\N	37
1439	3	Barcelona	\N	\N	37
1440	3	Cádiz	\N	\N	50
1441	3	Las Palmas	\N	\N	39
1442	3	Athletic Club	\N	\N	36
1443	3	Athletic Club	\N	\N	36
1444	3	Las Palmas	\N	\N	39
1445	3	Getafe	\N	\N	42
1446	3	Real Madrid	\N	\N	43
1447	3	Real Madrid	\N	\N	43
1448	3	Getafe	\N	\N	42
1449	3	Atlético Madrid	\N	\N	49
1450	3	Granada	\N	\N	31
1451	3	Granada	\N	\N	31
1452	3	Atlético Madrid	\N	\N	49
1453	3	Barcelona	\N	\N	37
1454	3	Real Betis	\N	\N	35
1455	3	Real Betis	\N	\N	35
1456	3	Barcelona	\N	\N	37
1457	3	Sevilla	\N	\N	40
1458	3	Valencia	\N	\N	45
1459	3	Valencia	\N	\N	45
1460	3	Sevilla	\N	\N	40
1461	3	Real Sociedad	\N	\N	48
1462	3	Villarreal	\N	\N	32
1463	3	Villarreal	\N	\N	32
1464	3	Real Sociedad	\N	\N	48
1465	3	Almería	\N	\N	41
1466	3	Mallorca	\N	\N	46
1467	3	Mallorca	\N	\N	46
1468	3	Almería	\N	\N	41
1469	3	Rayo Vallecano	\N	\N	47
1470	3	Celta Vigo	\N	\N	33
1471	3	Celta Vigo	\N	\N	33
1472	3	Rayo Vallecano	\N	\N	47
1473	3	Cádiz	\N	\N	50
1474	3	Girona FC	\N	\N	38
1475	3	Girona FC	\N	\N	38
1476	3	Cádiz	\N	\N	50
1477	3	Osasuna	\N	\N	34
1478	3	Deportivo Alavés	\N	\N	44
1479	3	Deportivo Alavés	\N	\N	44
1480	3	Osasuna	\N	\N	34
1481	3	Almería	\N	\N	41
1482	3	Real Sociedad	\N	\N	48
1483	3	Real Sociedad	\N	\N	48
1484	3	Almería	\N	\N	41
1485	3	Girona FC	\N	\N	38
1486	3	Barcelona	\N	\N	37
1487	3	Barcelona	\N	\N	37
1488	3	Girona FC	\N	\N	38
1489	3	Celta Vigo	\N	\N	33
1490	3	Villarreal	\N	\N	32
1491	3	Villarreal	\N	\N	32
1492	3	Celta Vigo	\N	\N	33
1493	3	Real Madrid	\N	\N	43
1494	3	Mallorca	\N	\N	46
1495	3	Mallorca	\N	\N	46
1496	3	Real Madrid	\N	\N	43
1497	3	Las Palmas	\N	\N	39
1498	3	Osasuna	\N	\N	34
1499	3	Osasuna	\N	\N	34
1500	3	Las Palmas	\N	\N	39
1501	3	Sevilla	\N	\N	40
1502	3	Rayo Vallecano	\N	\N	47
1503	3	Rayo Vallecano	\N	\N	47
1504	3	Sevilla	\N	\N	40
1505	3	Valencia	\N	\N	45
1506	3	Getafe	\N	\N	42
1507	3	Getafe	\N	\N	42
1508	3	Valencia	\N	\N	45
1509	3	Deportivo Alavés	\N	\N	44
1510	3	Real Betis	\N	\N	35
1511	3	Real Betis	\N	\N	35
1512	3	Deportivo Alavés	\N	\N	44
1513	3	Granada	\N	\N	31
1514	3	Cádiz	\N	\N	50
1515	3	Cádiz	\N	\N	50
1516	3	Granada	\N	\N	31
1517	3	Atlético Madrid	\N	\N	49
1518	3	Athletic Club	\N	\N	36
1519	3	Athletic Club	\N	\N	36
1520	3	Atlético Madrid	\N	\N	49
1521	3	Barcelona	\N	\N	37
1522	3	Real Sociedad	\N	\N	48
1523	3	Real Sociedad	\N	\N	48
1524	3	Barcelona	\N	\N	37
1525	3	Getafe	\N	\N	42
1526	3	Celta Vigo	\N	\N	33
1527	3	Celta Vigo	\N	\N	33
1528	3	Getafe	\N	\N	42
1529	3	Real Madrid	\N	\N	43
1530	3	Real Betis	\N	\N	35
1531	3	Real Betis	\N	\N	35
1532	3	Real Madrid	\N	\N	43
1533	3	Osasuna	\N	\N	34
1534	3	Cádiz	\N	\N	50
1535	3	Cádiz	\N	\N	50
1536	3	Osasuna	\N	\N	34
1537	3	Mallorca	\N	\N	46
1538	3	Sevilla	\N	\N	40
1539	3	Sevilla	\N	\N	40
1540	3	Mallorca	\N	\N	46
1541	3	Villarreal	\N	\N	32
1542	3	Rayo Vallecano	\N	\N	47
1543	3	Rayo Vallecano	\N	\N	47
1544	3	Villarreal	\N	\N	32
1545	3	Atlético Madrid	\N	\N	49
1546	3	Las Palmas	\N	\N	39
1547	3	Las Palmas	\N	\N	39
1548	3	Atlético Madrid	\N	\N	49
1549	3	Deportivo Alavés	\N	\N	44
1550	3	Granada	\N	\N	31
1551	3	Granada	\N	\N	31
1552	3	Deportivo Alavés	\N	\N	44
1553	3	Almería	\N	\N	41
1554	3	Athletic Club	\N	\N	36
1555	3	Athletic Club	\N	\N	36
1556	3	Almería	\N	\N	41
1557	3	Girona FC	\N	\N	38
1558	3	Valencia	\N	\N	45
1559	3	Valencia	\N	\N	45
1560	3	Girona FC	\N	\N	38
1561	3	Atlético Madrid	\N	\N	49
1562	3	Almería	\N	\N	41
1563	3	Almería	\N	\N	41
1564	3	Atlético Madrid	\N	\N	49
1565	3	Deportivo Alavés	\N	\N	44
1566	3	Valencia	\N	\N	45
1567	3	Valencia	\N	\N	45
1568	3	Deportivo Alavés	\N	\N	44
1569	3	Real Sociedad	\N	\N	48
1570	3	Osasuna	\N	\N	34
1571	3	Osasuna	\N	\N	34
1572	3	Real Sociedad	\N	\N	48
1573	3	Granada	\N	\N	31
1574	3	Las Palmas	\N	\N	39
1575	3	Las Palmas	\N	\N	39
1576	3	Granada	\N	\N	31
1577	3	Villarreal	\N	\N	32
1578	3	Real Betis	\N	\N	35
1579	3	Real Betis	\N	\N	35
1580	3	Villarreal	\N	\N	32
1581	3	Athletic Club	\N	\N	36
1582	3	Mallorca	\N	\N	46
1583	3	Mallorca	\N	\N	46
1584	3	Athletic Club	\N	\N	36
1585	3	Rayo Vallecano	\N	\N	47
1586	3	Barcelona	\N	\N	37
1587	3	Barcelona	\N	\N	37
1588	3	Rayo Vallecano	\N	\N	47
1589	3	Celta Vigo	\N	\N	33
1590	3	Cádiz	\N	\N	50
1591	3	Cádiz	\N	\N	50
1592	3	Celta Vigo	\N	\N	33
1593	3	Sevilla	\N	\N	40
1594	3	Getafe	\N	\N	42
1595	3	Getafe	\N	\N	42
1596	3	Sevilla	\N	\N	40
1597	3	Real Madrid	\N	\N	43
1598	3	Girona FC	\N	\N	38
1599	3	Girona FC	\N	\N	38
1600	3	Real Madrid	\N	\N	43
1601	3	Getafe	\N	\N	42
1602	3	Granada	\N	\N	31
1603	3	Granada	\N	\N	31
1604	3	Getafe	\N	\N	42
1605	3	Las Palmas	\N	\N	39
1606	3	Rayo Vallecano	\N	\N	47
1607	3	Rayo Vallecano	\N	\N	47
1608	3	Las Palmas	\N	\N	39
1609	3	Real Madrid	\N	\N	43
1610	3	Celta Vigo	\N	\N	33
1611	3	Celta Vigo	\N	\N	33
1612	3	Real Madrid	\N	\N	43
1613	3	Villarreal	\N	\N	32
1614	3	Deportivo Alavés	\N	\N	44
1615	3	Deportivo Alavés	\N	\N	44
1616	3	Villarreal	\N	\N	32
1617	3	Mallorca	\N	\N	46
1618	3	Valencia	\N	\N	45
1619	3	Valencia	\N	\N	45
1620	3	Mallorca	\N	\N	46
1621	3	Osasuna	\N	\N	34
1622	3	Almería	\N	\N	41
1623	3	Almería	\N	\N	41
1624	3	Osasuna	\N	\N	34
1625	3	Cádiz	\N	\N	50
1626	3	Real Betis	\N	\N	35
1627	3	Real Betis	\N	\N	35
1628	3	Cádiz	\N	\N	50
1629	3	Athletic Club	\N	\N	36
1630	3	Girona FC	\N	\N	38
1631	3	Girona FC	\N	\N	38
1632	3	Athletic Club	\N	\N	36
1633	3	Barcelona	\N	\N	37
1634	3	Sevilla	\N	\N	40
1635	3	Sevilla	\N	\N	40
1636	3	Barcelona	\N	\N	37
1637	3	Real Sociedad	\N	\N	48
1638	3	Atlético Madrid	\N	\N	49
1639	3	Atlético Madrid	\N	\N	49
1640	3	Real Sociedad	\N	\N	48
1641	3	Real Sociedad	\N	\N	48
1642	3	Celta Vigo	\N	\N	33
1643	3	Celta Vigo	\N	\N	33
1644	3	Real Sociedad	\N	\N	48
1645	3	Real Betis	\N	\N	35
1646	3	Girona FC	\N	\N	38
1647	3	Girona FC	\N	\N	38
1648	3	Real Betis	\N	\N	35
1649	3	Villarreal	\N	\N	32
1650	3	Getafe	\N	\N	42
1651	3	Getafe	\N	\N	42
1652	3	Villarreal	\N	\N	32
1653	3	Barcelona	\N	\N	37
1654	3	Mallorca	\N	\N	46
1655	3	Mallorca	\N	\N	46
1656	3	Barcelona	\N	\N	37
1657	3	Las Palmas	\N	\N	39
1658	3	Sevilla	\N	\N	40
1659	3	Sevilla	\N	\N	40
1660	3	Las Palmas	\N	\N	39
1661	3	Real Madrid	\N	\N	43
1662	3	Rayo Vallecano	\N	\N	47
1663	3	Rayo Vallecano	\N	\N	47
1664	3	Real Madrid	\N	\N	43
1665	3	Atlético Madrid	\N	\N	49
1666	3	Valencia	\N	\N	45
1667	3	Valencia	\N	\N	45
1668	3	Atlético Madrid	\N	\N	49
1669	3	Granada	\N	\N	31
1670	3	Osasuna	\N	\N	34
1671	3	Osasuna	\N	\N	34
1672	3	Granada	\N	\N	31
1673	3	Cádiz	\N	\N	50
1674	3	Almería	\N	\N	41
1675	3	Almería	\N	\N	41
1676	3	Cádiz	\N	\N	50
1677	3	Deportivo Alavés	\N	\N	44
1678	3	Athletic Club	\N	\N	36
1679	3	Athletic Club	\N	\N	36
1680	3	Deportivo Alavés	\N	\N	44
1681	3	Cádiz	\N	\N	50
1682	3	Valencia	\N	\N	45
1683	3	Valencia	\N	\N	45
1684	3	Cádiz	\N	\N	50
1685	3	Almería	\N	\N	41
1686	3	Barcelona	\N	\N	37
1687	3	Barcelona	\N	\N	37
1688	3	Almería	\N	\N	41
1689	3	Mallorca	\N	\N	46
1690	3	Rayo Vallecano	\N	\N	47
1691	3	Rayo Vallecano	\N	\N	47
1692	3	Mallorca	\N	\N	46
1693	3	Villarreal	\N	\N	32
1694	3	Las Palmas	\N	\N	39
1695	3	Las Palmas	\N	\N	39
1696	3	Villarreal	\N	\N	32
1697	3	Atlético Madrid	\N	\N	49
1698	3	Real Madrid	\N	\N	43
1699	3	Real Madrid	\N	\N	43
1700	3	Atlético Madrid	\N	\N	49
1701	3	Real Sociedad	\N	\N	48
1702	3	Athletic Club	\N	\N	36
1703	3	Athletic Club	\N	\N	36
1704	3	Real Sociedad	\N	\N	48
1705	3	Deportivo Alavés	\N	\N	44
1706	3	Sevilla	\N	\N	40
1707	3	Sevilla	\N	\N	40
1708	3	Deportivo Alavés	\N	\N	44
1709	3	Real Betis	\N	\N	35
1710	3	Osasuna	\N	\N	34
1711	3	Osasuna	\N	\N	34
1712	3	Real Betis	\N	\N	35
1713	3	Getafe	\N	\N	42
1714	3	Girona FC	\N	\N	38
1715	3	Girona FC	\N	\N	38
1716	3	Getafe	\N	\N	42
1717	3	Granada	\N	\N	31
1718	3	Celta Vigo	\N	\N	33
1719	3	Celta Vigo	\N	\N	33
1720	3	Granada	\N	\N	31
1721	3	Granada	\N	\N	31
1722	3	Barcelona	\N	\N	37
1723	3	Barcelona	\N	\N	37
1724	3	Granada	\N	\N	31
1725	3	Real Madrid	\N	\N	43
1726	3	Villarreal	\N	\N	32
1727	3	Villarreal	\N	\N	32
1728	3	Real Madrid	\N	\N	43
1729	3	Almería	\N	\N	41
1730	3	Real Betis	\N	\N	35
1731	3	Real Betis	\N	\N	35
1732	3	Almería	\N	\N	41
1733	3	Girona FC	\N	\N	38
1734	3	Las Palmas	\N	\N	39
1735	3	Las Palmas	\N	\N	39
1736	3	Girona FC	\N	\N	38
1737	3	Valencia	\N	\N	45
1738	3	Osasuna	\N	\N	34
1739	3	Osasuna	\N	\N	34
1740	3	Valencia	\N	\N	45
1741	3	Sevilla	\N	\N	40
1742	3	Atlético Madrid	\N	\N	49
1743	3	Atlético Madrid	\N	\N	49
1744	3	Sevilla	\N	\N	40
1745	3	Deportivo Alavés	\N	\N	44
1746	3	Mallorca	\N	\N	46
1747	3	Mallorca	\N	\N	46
1748	3	Deportivo Alavés	\N	\N	44
1749	3	Real Sociedad	\N	\N	48
1750	3	Getafe	\N	\N	42
1751	3	Getafe	\N	\N	42
1752	3	Real Sociedad	\N	\N	48
1753	3	Celta Vigo	\N	\N	33
1754	3	Athletic Club	\N	\N	36
1755	3	Athletic Club	\N	\N	36
1756	3	Celta Vigo	\N	\N	33
1757	3	Cádiz	\N	\N	50
1758	3	Rayo Vallecano	\N	\N	47
1759	3	Rayo Vallecano	\N	\N	47
1760	3	Cádiz	\N	\N	50
1761	3	Real Sociedad	\N	\N	48
1762	3	Mallorca	\N	\N	46
1763	3	Mallorca	\N	\N	46
1764	3	Real Sociedad	\N	\N	48
1765	3	Barcelona	\N	\N	37
1766	3	Real Madrid	\N	\N	43
1767	3	Real Madrid	\N	\N	43
1768	3	Barcelona	\N	\N	37
1769	3	Las Palmas	\N	\N	39
1770	3	Real Betis	\N	\N	35
1771	3	Real Betis	\N	\N	35
1772	3	Las Palmas	\N	\N	39
1773	3	Rayo Vallecano	\N	\N	47
1774	3	Valencia	\N	\N	45
1775	3	Valencia	\N	\N	45
1776	3	Rayo Vallecano	\N	\N	47
1777	3	Granada	\N	\N	31
1778	3	Athletic Club	\N	\N	36
1779	3	Athletic Club	\N	\N	36
1780	3	Granada	\N	\N	31
1781	3	Cádiz	\N	\N	50
1782	3	Sevilla	\N	\N	40
1783	3	Sevilla	\N	\N	40
1784	3	Cádiz	\N	\N	50
1785	3	Atlético Madrid	\N	\N	49
1786	3	Getafe	\N	\N	42
1787	3	Getafe	\N	\N	42
1788	3	Atlético Madrid	\N	\N	49
1789	3	Almería	\N	\N	41
1790	3	Deportivo Alavés	\N	\N	44
1791	3	Deportivo Alavés	\N	\N	44
1792	3	Almería	\N	\N	41
1793	3	Villarreal	\N	\N	32
1794	3	Girona FC	\N	\N	38
1795	3	Girona FC	\N	\N	38
1796	3	Villarreal	\N	\N	32
1797	3	Osasuna	\N	\N	34
1798	3	Celta Vigo	\N	\N	33
1799	3	Celta Vigo	\N	\N	33
1800	3	Osasuna	\N	\N	34
1801	3	Girona FC	\N	\N	38
1802	3	Mallorca	\N	\N	46
1803	3	Mallorca	\N	\N	46
1804	3	Girona FC	\N	\N	38
1805	3	Las Palmas	\N	\N	39
1806	3	Real Sociedad	\N	\N	48
1807	3	Real Sociedad	\N	\N	48
1808	3	Las Palmas	\N	\N	39
1809	3	Barcelona	\N	\N	37
1810	3	Valencia	\N	\N	45
1811	3	Valencia	\N	\N	45
1812	3	Barcelona	\N	\N	37
1813	3	Almería	\N	\N	41
1814	3	Villarreal	\N	\N	32
1815	3	Villarreal	\N	\N	32
1816	3	Almería	\N	\N	41
1817	3	Osasuna	\N	\N	34
1818	3	Getafe	\N	\N	42
1819	3	Getafe	\N	\N	42
1820	3	Osasuna	\N	\N	34
1821	3	Real Betis	\N	\N	35
1822	3	Rayo Vallecano	\N	\N	47
1823	3	Rayo Vallecano	\N	\N	47
1824	3	Real Betis	\N	\N	35
1825	3	Sevilla	\N	\N	40
1826	3	Granada	\N	\N	31
1827	3	Granada	\N	\N	31
1828	3	Sevilla	\N	\N	40
1829	3	Athletic Club	\N	\N	36
1830	3	Real Madrid	\N	\N	43
1831	3	Real Madrid	\N	\N	43
1832	3	Athletic Club	\N	\N	36
1833	3	Cádiz	\N	\N	50
1834	3	Atlético Madrid	\N	\N	49
1835	3	Atlético Madrid	\N	\N	49
1836	3	Cádiz	\N	\N	50
1837	3	Celta Vigo	\N	\N	33
1838	3	Deportivo Alavés	\N	\N	44
1839	3	Deportivo Alavés	\N	\N	44
1840	3	Celta Vigo	\N	\N	33
1841	3	Atlético Madrid	\N	\N	49
1842	3	Villarreal	\N	\N	32
1843	3	Villarreal	\N	\N	32
1844	3	Atlético Madrid	\N	\N	49
1845	3	Celta Vigo	\N	\N	33
1846	3	Girona FC	\N	\N	38
1847	3	Girona FC	\N	\N	38
1848	3	Celta Vigo	\N	\N	33
1849	3	Barcelona	\N	\N	37
1850	3	Las Palmas	\N	\N	39
1851	3	Las Palmas	\N	\N	39
1852	3	Barcelona	\N	\N	37
1853	3	Sevilla	\N	\N	40
1854	3	Almería	\N	\N	41
1855	3	Almería	\N	\N	41
1856	3	Sevilla	\N	\N	40
1857	3	Rayo Vallecano	\N	\N	47
1858	3	Real Sociedad	\N	\N	48
1859	3	Real Sociedad	\N	\N	48
1860	3	Rayo Vallecano	\N	\N	47
1861	3	Real Betis	\N	\N	35
1862	3	Athletic Club	\N	\N	36
1863	3	Athletic Club	\N	\N	36
1864	3	Real Betis	\N	\N	35
1865	3	Mallorca	\N	\N	46
1866	3	Osasuna	\N	\N	34
1867	3	Osasuna	\N	\N	34
1868	3	Mallorca	\N	\N	46
1869	3	Deportivo Alavés	\N	\N	44
1870	3	Real Madrid	\N	\N	43
1871	3	Real Madrid	\N	\N	43
1872	3	Deportivo Alavés	\N	\N	44
1873	3	Valencia	\N	\N	45
1874	3	Granada	\N	\N	31
1875	3	Granada	\N	\N	31
1876	3	Valencia	\N	\N	45
1877	3	Cádiz	\N	\N	50
1878	3	Getafe	\N	\N	42
1879	3	Getafe	\N	\N	42
1880	3	Cádiz	\N	\N	50
1881	4	Minnesota Timberwolves	\N	\N	78
1882	4	New Orleans Pelicans	\N	\N	62
1883	4	New Orleans Pelicans	\N	\N	62
1884	4	Minnesota Timberwolves	\N	\N	78
1885	4	Dallas Mavericks	\N	\N	66
1886	4	Atlanta Hawks	\N	\N	51
1887	4	Atlanta Hawks	\N	\N	51
1888	4	Dallas Mavericks	\N	\N	66
1889	4	Orlando Magic	\N	\N	73
1890	4	Brooklyn Nets	\N	\N	68
1891	4	Brooklyn Nets	\N	\N	68
1892	4	Orlando Magic	\N	\N	73
1893	4	Los Angeles Lakers	\N	\N	70
1894	4	New York Knicks	\N	\N	67
1895	4	New York Knicks	\N	\N	67
1896	4	Los Angeles Lakers	\N	\N	70
1897	4	Oklahoma City Thunder	\N	\N	55
1898	4	Washington Wizards	\N	\N	79
1899	4	Washington Wizards	\N	\N	79
1900	4	Oklahoma City Thunder	\N	\N	55
1901	5	Toronto Raptors	\N	\N	59
1902	4	Boston Celtics	\N	\N	60
1903	4	Boston Celtics	\N	\N	60
1904	6	Toronto Raptors	\N	\N	59
1905	4	Utah Jazz	\N	\N	56
1906	4	Houston Rockets	\N	\N	69
1907	4	Houston Rockets	\N	\N	69
1908	4	Utah Jazz	\N	\N	56
1909	4	Phoenix Suns	\N	\N	52
1910	4	Detroit Pistons	\N	\N	64
1911	4	Detroit Pistons	\N	\N	64
1912	4	Phoenix Suns	\N	\N	52
1913	4	San Antonio Spurs	\N	\N	75
1914	4	Sacramento Kings	\N	\N	58
1915	4	Sacramento Kings	\N	\N	58
1916	4	San Antonio Spurs	\N	\N	75
1917	4	Denver Nuggets	\N	\N	80
1918	4	Miami Heat	\N	\N	71
1919	4	Miami Heat	\N	\N	71
1920	4	Denver Nuggets	\N	\N	80
1921	4	Indiana Pacers	\N	\N	54
1922	4	Golden State Warriors	\N	\N	53
1923	4	Golden State Warriors	\N	\N	53
1924	4	Indiana Pacers	\N	\N	54
1925	4	Charlotte Hornets	\N	\N	76
1926	4	Cleveland Cavaliers	\N	\N	72
1927	4	Cleveland Cavaliers	\N	\N	72
1928	4	Charlotte Hornets	\N	\N	76
1929	4	Milwaukee Bucks	\N	\N	57
1930	4	Philadelphia 76ers	\N	\N	63
1931	4	Philadelphia 76ers	\N	\N	63
1932	4	Milwaukee Bucks	\N	\N	57
1933	4	Chicago Bulls	\N	\N	61
1934	4	Memphis Grizzlies	\N	\N	74
1935	4	Memphis Grizzlies	\N	\N	74
1936	4	Chicago Bulls	\N	\N	61
1937	4	Portland Trail Blazers	\N	\N	65
1938	4	Los Angeles Clippers	\N	\N	77
1939	4	Los Angeles Clippers	\N	\N	77
1940	4	Portland Trail Blazers	\N	\N	65
1941	4	New York Knicks	\N	\N	67
1942	7	Toronto Raptors	\N	\N	59
1943	8	Toronto Raptors	\N	\N	59
1944	4	New York Knicks	\N	\N	67
1945	4	Portland Trail Blazers	\N	\N	65
1946	4	Brooklyn Nets	\N	\N	68
1947	4	Brooklyn Nets	\N	\N	68
1948	4	Portland Trail Blazers	\N	\N	65
1949	4	Atlanta Hawks	\N	\N	51
1950	4	Los Angeles Lakers	\N	\N	70
1951	4	Los Angeles Lakers	\N	\N	70
1952	4	Atlanta Hawks	\N	\N	51
1953	4	Indiana Pacers	\N	\N	54
1954	4	Philadelphia 76ers	\N	\N	63
1955	4	Philadelphia 76ers	\N	\N	63
1956	4	Indiana Pacers	\N	\N	54
1957	4	Sacramento Kings	\N	\N	58
1958	4	Oklahoma City Thunder	\N	\N	55
1959	4	Oklahoma City Thunder	\N	\N	55
1960	4	Sacramento Kings	\N	\N	58
1961	4	Detroit Pistons	\N	\N	64
1962	4	Washington Wizards	\N	\N	79
1963	4	Washington Wizards	\N	\N	79
1964	4	Detroit Pistons	\N	\N	64
1965	4	Charlotte Hornets	\N	\N	76
1966	4	Phoenix Suns	\N	\N	52
1967	4	Phoenix Suns	\N	\N	52
1968	4	Charlotte Hornets	\N	\N	76
1969	4	Denver Nuggets	\N	\N	80
1970	4	Los Angeles Clippers	\N	\N	77
1971	4	Los Angeles Clippers	\N	\N	77
1972	4	Denver Nuggets	\N	\N	80
1973	4	Utah Jazz	\N	\N	56
1974	4	Minnesota Timberwolves	\N	\N	78
1975	4	Minnesota Timberwolves	\N	\N	78
1976	4	Utah Jazz	\N	\N	56
1977	4	Boston Celtics	\N	\N	60
1978	4	Houston Rockets	\N	\N	69
1979	4	Houston Rockets	\N	\N	69
1980	4	Boston Celtics	\N	\N	60
1981	4	New Orleans Pelicans	\N	\N	62
1982	4	Orlando Magic	\N	\N	73
1983	4	Orlando Magic	\N	\N	73
1984	4	New Orleans Pelicans	\N	\N	62
1985	4	Memphis Grizzlies	\N	\N	74
1986	4	Dallas Mavericks	\N	\N	66
1987	4	Dallas Mavericks	\N	\N	66
1988	4	Memphis Grizzlies	\N	\N	74
1989	4	Golden State Warriors	\N	\N	53
1990	4	Milwaukee Bucks	\N	\N	57
1991	4	Milwaukee Bucks	\N	\N	57
1992	4	Golden State Warriors	\N	\N	53
1993	4	Chicago Bulls	\N	\N	61
1994	4	Cleveland Cavaliers	\N	\N	72
1995	4	Cleveland Cavaliers	\N	\N	72
1996	4	Chicago Bulls	\N	\N	61
1997	4	San Antonio Spurs	\N	\N	75
1998	4	Miami Heat	\N	\N	71
1999	4	Miami Heat	\N	\N	71
2000	4	San Antonio Spurs	\N	\N	75
2001	4	Oklahoma City Thunder	\N	\N	55
2002	9	Toronto Raptors	\N	\N	59
2003	10	Toronto Raptors	\N	\N	59
2004	4	Oklahoma City Thunder	\N	\N	55
2005	4	Los Angeles Clippers	\N	\N	77
2006	4	Charlotte Hornets	\N	\N	76
2007	4	Charlotte Hornets	\N	\N	76
2008	4	Los Angeles Clippers	\N	\N	77
2009	4	Portland Trail Blazers	\N	\N	65
2010	4	Sacramento Kings	\N	\N	58
2011	4	Sacramento Kings	\N	\N	58
2012	4	Portland Trail Blazers	\N	\N	65
2013	4	Los Angeles Lakers	\N	\N	70
2014	4	Minnesota Timberwolves	\N	\N	78
2015	4	Minnesota Timberwolves	\N	\N	78
2016	4	Los Angeles Lakers	\N	\N	70
2017	4	Utah Jazz	\N	\N	56
2018	4	New Orleans Pelicans	\N	\N	62
2019	4	New Orleans Pelicans	\N	\N	62
2020	4	Utah Jazz	\N	\N	56
2021	4	Boston Celtics	\N	\N	60
2022	4	Atlanta Hawks	\N	\N	51
2023	4	Atlanta Hawks	\N	\N	51
2024	4	Boston Celtics	\N	\N	60
2025	4	Cleveland Cavaliers	\N	\N	72
2026	4	Dallas Mavericks	\N	\N	66
2027	4	Dallas Mavericks	\N	\N	66
2028	4	Cleveland Cavaliers	\N	\N	72
2029	4	Chicago Bulls	\N	\N	61
2030	4	Denver Nuggets	\N	\N	80
2031	4	Denver Nuggets	\N	\N	80
2032	4	Chicago Bulls	\N	\N	61
2033	4	Houston Rockets	\N	\N	69
2034	4	Philadelphia 76ers	\N	\N	63
2035	4	Philadelphia 76ers	\N	\N	63
2036	4	Houston Rockets	\N	\N	69
2037	4	New York Knicks	\N	\N	67
2038	4	Brooklyn Nets	\N	\N	68
2039	4	Brooklyn Nets	\N	\N	68
2040	4	New York Knicks	\N	\N	67
2041	4	Miami Heat	\N	\N	71
2042	4	Indiana Pacers	\N	\N	54
2043	4	Indiana Pacers	\N	\N	54
2044	4	Miami Heat	\N	\N	71
2045	4	San Antonio Spurs	\N	\N	75
2046	4	Golden State Warriors	\N	\N	53
2047	4	Golden State Warriors	\N	\N	53
2048	4	San Antonio Spurs	\N	\N	75
2049	4	Detroit Pistons	\N	\N	64
2050	4	Memphis Grizzlies	\N	\N	74
2051	4	Memphis Grizzlies	\N	\N	74
2052	4	Detroit Pistons	\N	\N	64
2053	4	Orlando Magic	\N	\N	73
2054	4	Washington Wizards	\N	\N	79
2055	4	Washington Wizards	\N	\N	79
2056	4	Orlando Magic	\N	\N	73
2057	4	Milwaukee Bucks	\N	\N	57
2058	4	Phoenix Suns	\N	\N	52
2059	4	Phoenix Suns	\N	\N	52
2060	4	Milwaukee Bucks	\N	\N	57
2061	4	Dallas Mavericks	\N	\N	66
2062	4	Golden State Warriors	\N	\N	53
2063	4	Golden State Warriors	\N	\N	53
2064	4	Dallas Mavericks	\N	\N	66
2065	4	Brooklyn Nets	\N	\N	68
2066	4	Philadelphia 76ers	\N	\N	63
2067	4	Philadelphia 76ers	\N	\N	63
2068	4	Brooklyn Nets	\N	\N	68
2069	4	Minnesota Timberwolves	\N	\N	78
2070	4	Portland Trail Blazers	\N	\N	65
2071	4	Portland Trail Blazers	\N	\N	65
2072	4	Minnesota Timberwolves	\N	\N	78
2073	4	Miami Heat	\N	\N	71
2074	4	Orlando Magic	\N	\N	73
2075	4	Orlando Magic	\N	\N	73
2076	4	Miami Heat	\N	\N	71
2077	4	Cleveland Cavaliers	\N	\N	72
2078	11	Toronto Raptors	\N	\N	59
2079	12	Toronto Raptors	\N	\N	59
2080	4	Cleveland Cavaliers	\N	\N	72
2081	4	Washington Wizards	\N	\N	79
2082	4	New York Knicks	\N	\N	67
2083	4	New York Knicks	\N	\N	67
2084	4	Washington Wizards	\N	\N	79
2085	4	Utah Jazz	\N	\N	56
2086	4	Charlotte Hornets	\N	\N	76
2087	4	Charlotte Hornets	\N	\N	76
2088	4	Utah Jazz	\N	\N	56
2089	4	Oklahoma City Thunder	\N	\N	55
2090	4	Phoenix Suns	\N	\N	52
2091	4	Phoenix Suns	\N	\N	52
2092	4	Oklahoma City Thunder	\N	\N	55
2093	4	New Orleans Pelicans	\N	\N	62
2094	4	Memphis Grizzlies	\N	\N	74
2095	4	Memphis Grizzlies	\N	\N	74
2096	4	New Orleans Pelicans	\N	\N	62
2097	4	Indiana Pacers	\N	\N	54
2098	4	Houston Rockets	\N	\N	69
2099	4	Houston Rockets	\N	\N	69
2100	4	Indiana Pacers	\N	\N	54
2101	4	Chicago Bulls	\N	\N	61
2102	4	Los Angeles Lakers	\N	\N	70
2103	4	Los Angeles Lakers	\N	\N	70
2104	4	Chicago Bulls	\N	\N	61
2105	4	Atlanta Hawks	\N	\N	51
2106	4	Denver Nuggets	\N	\N	80
2107	4	Denver Nuggets	\N	\N	80
2108	4	Atlanta Hawks	\N	\N	51
2109	4	Detroit Pistons	\N	\N	64
2110	4	Sacramento Kings	\N	\N	58
2111	4	Sacramento Kings	\N	\N	58
2112	4	Detroit Pistons	\N	\N	64
2113	4	Milwaukee Bucks	\N	\N	57
2114	4	Los Angeles Clippers	\N	\N	77
2115	4	Los Angeles Clippers	\N	\N	77
2116	4	Milwaukee Bucks	\N	\N	57
2117	4	Boston Celtics	\N	\N	60
2118	4	San Antonio Spurs	\N	\N	75
2119	4	San Antonio Spurs	\N	\N	75
2120	4	Boston Celtics	\N	\N	60
2121	4	Washington Wizards	\N	\N	79
2122	4	Denver Nuggets	\N	\N	80
2123	4	Denver Nuggets	\N	\N	80
2124	4	Washington Wizards	\N	\N	79
2125	4	Cleveland Cavaliers	\N	\N	72
2126	4	Detroit Pistons	\N	\N	64
2127	4	Detroit Pistons	\N	\N	64
2128	4	Cleveland Cavaliers	\N	\N	72
2129	4	Miami Heat	\N	\N	71
2130	4	New York Knicks	\N	\N	67
2131	4	New York Knicks	\N	\N	67
2132	4	Miami Heat	\N	\N	71
2133	4	Philadelphia 76ers	\N	\N	63
2134	4	Orlando Magic	\N	\N	73
2135	4	Orlando Magic	\N	\N	73
2136	4	Philadelphia 76ers	\N	\N	63
2137	4	Atlanta Hawks	\N	\N	51
2138	4	Indiana Pacers	\N	\N	54
2139	4	Indiana Pacers	\N	\N	54
2140	4	Atlanta Hawks	\N	\N	51
2141	4	Phoenix Suns	\N	\N	52
2142	4	New Orleans Pelicans	\N	\N	62
2143	4	New Orleans Pelicans	\N	\N	62
2144	4	Phoenix Suns	\N	\N	52
2145	4	Houston Rockets	\N	\N	69
2146	4	Milwaukee Bucks	\N	\N	57
2147	4	Milwaukee Bucks	\N	\N	57
2148	4	Houston Rockets	\N	\N	69
2149	4	Sacramento Kings	\N	\N	58
2150	13	Toronto Raptors	\N	\N	59
2151	14	Toronto Raptors	\N	\N	59
2152	4	Sacramento Kings	\N	\N	58
2153	4	Los Angeles Lakers	\N	\N	70
2154	4	Utah Jazz	\N	\N	56
2155	4	Utah Jazz	\N	\N	56
2156	4	Los Angeles Lakers	\N	\N	70
2157	4	Los Angeles Clippers	\N	\N	77
2158	4	Oklahoma City Thunder	\N	\N	55
2159	4	Oklahoma City Thunder	\N	\N	55
2160	4	Los Angeles Clippers	\N	\N	77
2161	4	Dallas Mavericks	\N	\N	66
2162	4	Minnesota Timberwolves	\N	\N	78
2163	4	Minnesota Timberwolves	\N	\N	78
2164	4	Dallas Mavericks	\N	\N	66
2165	4	Golden State Warriors	\N	\N	53
2166	4	Memphis Grizzlies	\N	\N	74
2167	4	Memphis Grizzlies	\N	\N	74
2168	4	Golden State Warriors	\N	\N	53
2169	4	Boston Celtics	\N	\N	60
2170	4	Brooklyn Nets	\N	\N	68
2171	4	Brooklyn Nets	\N	\N	68
2172	4	Boston Celtics	\N	\N	60
2173	4	San Antonio Spurs	\N	\N	75
2174	4	Portland Trail Blazers	\N	\N	65
2175	4	Portland Trail Blazers	\N	\N	65
2176	4	San Antonio Spurs	\N	\N	75
2177	4	Charlotte Hornets	\N	\N	76
2178	4	Chicago Bulls	\N	\N	61
2179	4	Chicago Bulls	\N	\N	61
2180	4	Charlotte Hornets	\N	\N	76
2181	4	Indiana Pacers	\N	\N	54
2182	4	New York Knicks	\N	\N	67
2183	4	New York Knicks	\N	\N	67
2184	4	Indiana Pacers	\N	\N	54
2185	4	Portland Trail Blazers	\N	\N	65
2186	4	New Orleans Pelicans	\N	\N	62
2187	4	New Orleans Pelicans	\N	\N	62
2188	4	Portland Trail Blazers	\N	\N	65
2189	4	San Antonio Spurs	\N	\N	75
2190	4	Oklahoma City Thunder	\N	\N	55
2191	4	Oklahoma City Thunder	\N	\N	55
2192	4	San Antonio Spurs	\N	\N	75
2193	4	Miami Heat	\N	\N	71
2194	4	Los Angeles Clippers	\N	\N	77
2195	4	Los Angeles Clippers	\N	\N	77
2196	4	Miami Heat	\N	\N	71
2197	4	Houston Rockets	\N	\N	69
2198	4	Charlotte Hornets	\N	\N	76
2199	4	Charlotte Hornets	\N	\N	76
2200	4	Houston Rockets	\N	\N	69
2201	4	Minnesota Timberwolves	\N	\N	78
2202	4	Milwaukee Bucks	\N	\N	57
2203	4	Milwaukee Bucks	\N	\N	57
2204	4	Minnesota Timberwolves	\N	\N	78
2205	4	Los Angeles Lakers	\N	\N	70
2206	4	Cleveland Cavaliers	\N	\N	72
2207	4	Cleveland Cavaliers	\N	\N	72
2208	4	Los Angeles Lakers	\N	\N	70
2209	4	Detroit Pistons	\N	\N	64
2210	4	Philadelphia 76ers	\N	\N	63
2211	4	Philadelphia 76ers	\N	\N	63
2212	4	Detroit Pistons	\N	\N	64
2213	4	Phoenix Suns	\N	\N	52
2214	4	Atlanta Hawks	\N	\N	51
2215	4	Atlanta Hawks	\N	\N	51
2216	4	Phoenix Suns	\N	\N	52
2217	4	Utah Jazz	\N	\N	56
2218	4	Boston Celtics	\N	\N	60
2219	4	Boston Celtics	\N	\N	60
2220	4	Utah Jazz	\N	\N	56
2221	4	Denver Nuggets	\N	\N	80
2222	4	Memphis Grizzlies	\N	\N	74
2223	4	Memphis Grizzlies	\N	\N	74
2224	4	Denver Nuggets	\N	\N	80
2225	4	Chicago Bulls	\N	\N	61
2226	4	Washington Wizards	\N	\N	79
2227	4	Washington Wizards	\N	\N	79
2228	4	Chicago Bulls	\N	\N	61
2229	4	Golden State Warriors	\N	\N	53
2230	4	Brooklyn Nets	\N	\N	68
2231	4	Brooklyn Nets	\N	\N	68
2232	4	Golden State Warriors	\N	\N	53
2233	4	Dallas Mavericks	\N	\N	66
2234	15	Toronto Raptors	\N	\N	59
2235	16	Toronto Raptors	\N	\N	59
2236	4	Dallas Mavericks	\N	\N	66
2237	4	Sacramento Kings	\N	\N	58
2238	4	Orlando Magic	\N	\N	73
2239	4	Orlando Magic	\N	\N	73
2240	4	Sacramento Kings	\N	\N	58
2241	4	Minnesota Timberwolves	\N	\N	78
2242	4	Miami Heat	\N	\N	71
2243	4	Miami Heat	\N	\N	71
2244	4	Minnesota Timberwolves	\N	\N	78
2245	4	Portland Trail Blazers	\N	\N	65
2246	4	Dallas Mavericks	\N	\N	66
2247	4	Dallas Mavericks	\N	\N	66
2248	4	Portland Trail Blazers	\N	\N	65
2249	4	Chicago Bulls	\N	\N	61
2250	4	Houston Rockets	\N	\N	69
2251	4	Houston Rockets	\N	\N	69
2252	4	Chicago Bulls	\N	\N	61
2253	4	Atlanta Hawks	\N	\N	51
2254	4	New York Knicks	\N	\N	67
2255	4	New York Knicks	\N	\N	67
2256	4	Atlanta Hawks	\N	\N	51
2257	4	Boston Celtics	\N	\N	60
2258	4	Phoenix Suns	\N	\N	52
2259	4	Phoenix Suns	\N	\N	52
2260	4	Boston Celtics	\N	\N	60
2261	4	Memphis Grizzlies	\N	\N	74
2262	4	Cleveland Cavaliers	\N	\N	72
2263	4	Cleveland Cavaliers	\N	\N	72
2264	4	Memphis Grizzlies	\N	\N	74
2265	4	Charlotte Hornets	\N	\N	76
2266	4	Golden State Warriors	\N	\N	53
2267	4	Golden State Warriors	\N	\N	53
2268	4	Charlotte Hornets	\N	\N	76
2269	4	Milwaukee Bucks	\N	\N	57
2270	4	Utah Jazz	\N	\N	56
2271	4	Utah Jazz	\N	\N	56
2272	4	Milwaukee Bucks	\N	\N	57
2273	4	Indiana Pacers	\N	\N	54
2274	4	Denver Nuggets	\N	\N	80
2275	4	Denver Nuggets	\N	\N	80
2276	4	Indiana Pacers	\N	\N	54
2277	4	Los Angeles Clippers	\N	\N	77
2278	4	Detroit Pistons	\N	\N	64
2279	4	Detroit Pistons	\N	\N	64
2280	4	Los Angeles Clippers	\N	\N	77
2281	4	New Orleans Pelicans	\N	\N	62
2282	4	Philadelphia 76ers	\N	\N	63
2283	4	Philadelphia 76ers	\N	\N	63
2284	4	New Orleans Pelicans	\N	\N	62
2285	4	Washington Wizards	\N	\N	79
2286	4	Sacramento Kings	\N	\N	58
2287	4	Sacramento Kings	\N	\N	58
2288	4	Washington Wizards	\N	\N	79
2289	4	Oklahoma City Thunder	\N	\N	55
2290	4	Orlando Magic	\N	\N	73
2291	4	Orlando Magic	\N	\N	73
2292	4	Oklahoma City Thunder	\N	\N	55
2293	17	Toronto Raptors	\N	\N	59
2294	4	San Antonio Spurs	\N	\N	75
2295	4	San Antonio Spurs	\N	\N	75
2296	18	Toronto Raptors	\N	\N	59
2297	4	Brooklyn Nets	\N	\N	68
2298	4	Los Angeles Lakers	\N	\N	70
2299	4	Los Angeles Lakers	\N	\N	70
2300	4	Brooklyn Nets	\N	\N	68
2301	4	Orlando Magic	\N	\N	73
2302	4	Phoenix Suns	\N	\N	52
2303	4	Phoenix Suns	\N	\N	52
2304	4	Orlando Magic	\N	\N	73
2305	4	Charlotte Hornets	\N	\N	76
2306	4	Oklahoma City Thunder	\N	\N	55
2307	4	Oklahoma City Thunder	\N	\N	55
2308	4	Charlotte Hornets	\N	\N	76
2309	4	Cleveland Cavaliers	\N	\N	72
2310	4	Philadelphia 76ers	\N	\N	63
2311	4	Philadelphia 76ers	\N	\N	63
2312	4	Cleveland Cavaliers	\N	\N	72
2313	19	Toronto Raptors	\N	\N	59
2314	4	New Orleans Pelicans	\N	\N	62
2315	4	New Orleans Pelicans	\N	\N	62
2316	20	Toronto Raptors	\N	\N	59
2317	4	Los Angeles Clippers	\N	\N	77
2318	4	New York Knicks	\N	\N	67
2319	4	New York Knicks	\N	\N	67
2320	4	Los Angeles Clippers	\N	\N	77
2321	4	Indiana Pacers	\N	\N	54
2322	4	Milwaukee Bucks	\N	\N	57
2323	4	Milwaukee Bucks	\N	\N	57
2324	4	Indiana Pacers	\N	\N	54
2325	4	Utah Jazz	\N	\N	56
2326	4	Denver Nuggets	\N	\N	80
2327	4	Denver Nuggets	\N	\N	80
2328	4	Utah Jazz	\N	\N	56
2329	4	Detroit Pistons	\N	\N	64
2330	4	Golden State Warriors	\N	\N	53
2331	4	Golden State Warriors	\N	\N	53
2332	4	Detroit Pistons	\N	\N	64
2333	4	Memphis Grizzlies	\N	\N	74
2334	4	Washington Wizards	\N	\N	79
2335	4	Washington Wizards	\N	\N	79
2336	4	Memphis Grizzlies	\N	\N	74
2337	4	Minnesota Timberwolves	\N	\N	78
2338	4	Brooklyn Nets	\N	\N	68
2339	4	Brooklyn Nets	\N	\N	68
2340	4	Minnesota Timberwolves	\N	\N	78
2341	4	Houston Rockets	\N	\N	69
2342	4	San Antonio Spurs	\N	\N	75
2343	4	San Antonio Spurs	\N	\N	75
2344	4	Houston Rockets	\N	\N	69
2345	4	Portland Trail Blazers	\N	\N	65
2346	4	Chicago Bulls	\N	\N	61
2347	4	Chicago Bulls	\N	\N	61
2348	4	Portland Trail Blazers	\N	\N	65
2349	4	Sacramento Kings	\N	\N	58
2350	4	Atlanta Hawks	\N	\N	51
2351	4	Atlanta Hawks	\N	\N	51
2352	4	Sacramento Kings	\N	\N	58
2353	4	Miami Heat	\N	\N	71
2354	4	Los Angeles Lakers	\N	\N	70
2355	4	Los Angeles Lakers	\N	\N	70
2356	4	Miami Heat	\N	\N	71
2357	4	Boston Celtics	\N	\N	60
2358	4	Dallas Mavericks	\N	\N	66
2359	4	Dallas Mavericks	\N	\N	66
2360	4	Boston Celtics	\N	\N	60
2361	4	Charlotte Hornets	\N	\N	76
2362	4	Milwaukee Bucks	\N	\N	57
2363	4	Milwaukee Bucks	\N	\N	57
2364	4	Charlotte Hornets	\N	\N	76
2365	4	Los Angeles Clippers	\N	\N	77
2366	4	Houston Rockets	\N	\N	69
2367	4	Houston Rockets	\N	\N	69
2368	4	Los Angeles Clippers	\N	\N	77
2369	4	Portland Trail Blazers	\N	\N	65
2370	4	Washington Wizards	\N	\N	79
2371	4	Washington Wizards	\N	\N	79
2372	4	Portland Trail Blazers	\N	\N	65
2373	4	Philadelphia 76ers	\N	\N	63
2374	4	Sacramento Kings	\N	\N	58
2375	4	Sacramento Kings	\N	\N	58
2376	4	Philadelphia 76ers	\N	\N	63
2377	4	Phoenix Suns	\N	\N	52
2378	4	Brooklyn Nets	\N	\N	68
2379	4	Brooklyn Nets	\N	\N	68
2380	4	Phoenix Suns	\N	\N	52
2381	4	Memphis Grizzlies	\N	\N	74
2382	21	Toronto Raptors	\N	\N	59
2383	22	Toronto Raptors	\N	\N	59
2384	4	Memphis Grizzlies	\N	\N	74
2385	4	Orlando Magic	\N	\N	73
2386	4	Golden State Warriors	\N	\N	53
2387	4	Golden State Warriors	\N	\N	53
2388	4	Orlando Magic	\N	\N	73
2389	4	Dallas Mavericks	\N	\N	66
2390	4	Chicago Bulls	\N	\N	61
2391	4	Chicago Bulls	\N	\N	61
2392	4	Dallas Mavericks	\N	\N	66
2393	4	Los Angeles Lakers	\N	\N	70
2394	4	Detroit Pistons	\N	\N	64
2395	4	Detroit Pistons	\N	\N	64
2396	4	Los Angeles Lakers	\N	\N	70
2397	4	New York Knicks	\N	\N	67
2398	4	Cleveland Cavaliers	\N	\N	72
2399	4	Cleveland Cavaliers	\N	\N	72
2400	4	New York Knicks	\N	\N	67
2401	4	San Antonio Spurs	\N	\N	75
2402	4	Atlanta Hawks	\N	\N	51
2403	4	Atlanta Hawks	\N	\N	51
2404	4	San Antonio Spurs	\N	\N	75
2405	4	Utah Jazz	\N	\N	56
2406	4	Indiana Pacers	\N	\N	54
2407	4	Indiana Pacers	\N	\N	54
2408	4	Utah Jazz	\N	\N	56
2409	4	New Orleans Pelicans	\N	\N	62
2410	4	Oklahoma City Thunder	\N	\N	55
2411	4	Oklahoma City Thunder	\N	\N	55
2412	4	New Orleans Pelicans	\N	\N	62
2413	4	Denver Nuggets	\N	\N	80
2414	4	Minnesota Timberwolves	\N	\N	78
2415	4	Minnesota Timberwolves	\N	\N	78
2416	4	Denver Nuggets	\N	\N	80
2417	4	Boston Celtics	\N	\N	60
2418	4	Miami Heat	\N	\N	71
2419	4	Miami Heat	\N	\N	71
2420	4	Boston Celtics	\N	\N	60
2421	4	Dallas Mavericks	\N	\N	66
2422	4	Charlotte Hornets	\N	\N	76
2423	4	Charlotte Hornets	\N	\N	76
2424	4	Dallas Mavericks	\N	\N	66
2425	4	Minnesota Timberwolves	\N	\N	78
2426	4	Detroit Pistons	\N	\N	64
2427	4	Detroit Pistons	\N	\N	64
2428	4	Minnesota Timberwolves	\N	\N	78
2429	4	Philadelphia 76ers	\N	\N	63
2430	4	Portland Trail Blazers	\N	\N	65
2431	4	Portland Trail Blazers	\N	\N	65
2432	4	Philadelphia 76ers	\N	\N	63
2433	4	Miami Heat	\N	\N	71
2434	4	Milwaukee Bucks	\N	\N	57
2435	4	Milwaukee Bucks	\N	\N	57
2436	4	Miami Heat	\N	\N	71
2437	23	Toronto Raptors	\N	\N	59
2438	4	Los Angeles Lakers	\N	\N	70
2439	4	Los Angeles Lakers	\N	\N	70
2440	24	Toronto Raptors	\N	\N	59
2441	4	Chicago Bulls	\N	\N	61
2442	4	New York Knicks	\N	\N	67
2443	4	New York Knicks	\N	\N	67
2444	4	Chicago Bulls	\N	\N	61
2445	4	San Antonio Spurs	\N	\N	75
2446	4	Cleveland Cavaliers	\N	\N	72
2447	4	Cleveland Cavaliers	\N	\N	72
2448	4	San Antonio Spurs	\N	\N	75
2449	4	Washington Wizards	\N	\N	79
2450	4	Houston Rockets	\N	\N	69
2451	4	Houston Rockets	\N	\N	69
2452	4	Washington Wizards	\N	\N	79
2453	4	Orlando Magic	\N	\N	73
2454	4	Denver Nuggets	\N	\N	80
2455	4	Denver Nuggets	\N	\N	80
2456	4	Orlando Magic	\N	\N	73
2457	4	New Orleans Pelicans	\N	\N	62
2458	4	Brooklyn Nets	\N	\N	68
2459	4	Brooklyn Nets	\N	\N	68
2460	4	New Orleans Pelicans	\N	\N	62
2461	4	Sacramento Kings	\N	\N	58
2462	4	Memphis Grizzlies	\N	\N	74
2463	4	Memphis Grizzlies	\N	\N	74
2464	4	Sacramento Kings	\N	\N	58
2465	4	Atlanta Hawks	\N	\N	51
2466	4	Golden State Warriors	\N	\N	53
2467	4	Golden State Warriors	\N	\N	53
2468	4	Atlanta Hawks	\N	\N	51
2469	4	Boston Celtics	\N	\N	60
2470	4	Indiana Pacers	\N	\N	54
2471	4	Indiana Pacers	\N	\N	54
2472	4	Boston Celtics	\N	\N	60
2473	4	Utah Jazz	\N	\N	56
2474	4	Oklahoma City Thunder	\N	\N	55
2475	4	Oklahoma City Thunder	\N	\N	55
2476	4	Utah Jazz	\N	\N	56
2477	4	Phoenix Suns	\N	\N	52
2478	4	Los Angeles Clippers	\N	\N	77
2479	4	Los Angeles Clippers	\N	\N	77
2480	4	Phoenix Suns	\N	\N	52
2481	4	Miami Heat	\N	\N	71
2482	25	Toronto Raptors	\N	\N	59
2483	26	Toronto Raptors	\N	\N	59
2484	4	Miami Heat	\N	\N	71
2485	4	Memphis Grizzlies	\N	\N	74
2486	4	Phoenix Suns	\N	\N	52
2487	4	Phoenix Suns	\N	\N	52
2488	4	Memphis Grizzlies	\N	\N	74
2489	4	New York Knicks	\N	\N	67
2490	4	Portland Trail Blazers	\N	\N	65
2491	4	Portland Trail Blazers	\N	\N	65
2492	4	New York Knicks	\N	\N	67
2493	4	Sacramento Kings	\N	\N	58
2494	4	Milwaukee Bucks	\N	\N	57
2495	4	Milwaukee Bucks	\N	\N	57
2496	4	Sacramento Kings	\N	\N	58
2497	4	Dallas Mavericks	\N	\N	66
2498	4	Detroit Pistons	\N	\N	64
2499	4	Detroit Pistons	\N	\N	64
2500	4	Dallas Mavericks	\N	\N	66
2501	4	Utah Jazz	\N	\N	56
2502	4	Los Angeles Clippers	\N	\N	77
2503	4	Los Angeles Clippers	\N	\N	77
2504	4	Utah Jazz	\N	\N	56
2505	4	Washington Wizards	\N	\N	79
2506	4	Golden State Warriors	\N	\N	53
2507	4	Golden State Warriors	\N	\N	53
2508	4	Washington Wizards	\N	\N	79
2509	4	Los Angeles Lakers	\N	\N	70
2510	4	Oklahoma City Thunder	\N	\N	55
2511	4	Oklahoma City Thunder	\N	\N	55
2512	4	Los Angeles Lakers	\N	\N	70
2513	4	Charlotte Hornets	\N	\N	76
2514	4	Indiana Pacers	\N	\N	54
2515	4	Indiana Pacers	\N	\N	54
2516	4	Charlotte Hornets	\N	\N	76
2517	4	Cleveland Cavaliers	\N	\N	72
2518	4	Boston Celtics	\N	\N	60
2519	4	Boston Celtics	\N	\N	60
2520	4	Cleveland Cavaliers	\N	\N	72
2521	4	Atlanta Hawks	\N	\N	51
2522	4	Minnesota Timberwolves	\N	\N	78
2523	4	Minnesota Timberwolves	\N	\N	78
2524	4	Atlanta Hawks	\N	\N	51
2525	4	New Orleans Pelicans	\N	\N	62
2526	4	San Antonio Spurs	\N	\N	75
2527	4	San Antonio Spurs	\N	\N	75
2528	4	New Orleans Pelicans	\N	\N	62
2529	4	Denver Nuggets	\N	\N	80
2530	4	Brooklyn Nets	\N	\N	68
2531	4	Brooklyn Nets	\N	\N	68
2532	4	Denver Nuggets	\N	\N	80
2533	4	Philadelphia 76ers	\N	\N	63
2534	4	Chicago Bulls	\N	\N	61
2535	4	Chicago Bulls	\N	\N	61
2536	4	Philadelphia 76ers	\N	\N	63
2537	4	Orlando Magic	\N	\N	73
2538	4	Houston Rockets	\N	\N	69
2539	4	Houston Rockets	\N	\N	69
2540	4	Orlando Magic	\N	\N	73
2541	4	Dallas Mavericks	\N	\N	66
2542	4	Los Angeles Lakers	\N	\N	70
2543	4	Los Angeles Lakers	\N	\N	70
2544	4	Dallas Mavericks	\N	\N	66
2545	4	Washington Wizards	\N	\N	79
2546	4	Cleveland Cavaliers	\N	\N	72
2547	4	Cleveland Cavaliers	\N	\N	72
2548	4	Washington Wizards	\N	\N	79
2549	4	Milwaukee Bucks	\N	\N	57
2550	4	Chicago Bulls	\N	\N	61
2551	4	Chicago Bulls	\N	\N	61
2552	4	Milwaukee Bucks	\N	\N	57
2553	27	Toronto Raptors	\N	\N	59
2554	4	Golden State Warriors	\N	\N	53
2555	4	Golden State Warriors	\N	\N	53
2556	28	Toronto Raptors	\N	\N	59
2557	4	Phoenix Suns	\N	\N	52
2558	4	Houston Rockets	\N	\N	69
2559	4	Houston Rockets	\N	\N	69
2560	4	Phoenix Suns	\N	\N	52
2561	4	Portland Trail Blazers	\N	\N	65
2562	4	Memphis Grizzlies	\N	\N	74
2563	4	Memphis Grizzlies	\N	\N	74
2564	4	Portland Trail Blazers	\N	\N	65
2565	4	Atlanta Hawks	\N	\N	51
2566	4	Los Angeles Clippers	\N	\N	77
2567	4	Los Angeles Clippers	\N	\N	77
2568	4	Atlanta Hawks	\N	\N	51
2569	4	New York Knicks	\N	\N	67
2570	4	Minnesota Timberwolves	\N	\N	78
2571	4	Minnesota Timberwolves	\N	\N	78
2572	4	New York Knicks	\N	\N	67
2573	4	Brooklyn Nets	\N	\N	68
2574	4	Miami Heat	\N	\N	71
2575	4	Miami Heat	\N	\N	71
2576	4	Brooklyn Nets	\N	\N	68
2577	4	Orlando Magic	\N	\N	73
2578	4	San Antonio Spurs	\N	\N	75
2579	4	San Antonio Spurs	\N	\N	75
2580	4	Orlando Magic	\N	\N	73
2581	4	Philadelphia 76ers	\N	\N	63
2582	4	Denver Nuggets	\N	\N	80
2583	4	Denver Nuggets	\N	\N	80
2584	4	Philadelphia 76ers	\N	\N	63
2585	4	Detroit Pistons	\N	\N	64
2586	4	Boston Celtics	\N	\N	60
2587	4	Boston Celtics	\N	\N	60
2588	4	Detroit Pistons	\N	\N	64
2589	4	Sacramento Kings	\N	\N	58
2590	4	Utah Jazz	\N	\N	56
2591	4	Utah Jazz	\N	\N	56
2592	4	Sacramento Kings	\N	\N	58
2593	4	Charlotte Hornets	\N	\N	76
2594	4	New Orleans Pelicans	\N	\N	62
2595	4	New Orleans Pelicans	\N	\N	62
2596	4	Charlotte Hornets	\N	\N	76
2597	4	Indiana Pacers	\N	\N	54
2598	4	Oklahoma City Thunder	\N	\N	55
2599	4	Oklahoma City Thunder	\N	\N	55
2600	4	Indiana Pacers	\N	\N	54
2601	4	Utah Jazz	\N	\N	56
2602	4	Cleveland Cavaliers	\N	\N	72
2603	4	Cleveland Cavaliers	\N	\N	72
2604	4	Utah Jazz	\N	\N	56
2605	4	Los Angeles Lakers	\N	\N	70
2606	4	Indiana Pacers	\N	\N	54
2607	4	Indiana Pacers	\N	\N	54
2608	4	Los Angeles Lakers	\N	\N	70
2609	4	Washington Wizards	\N	\N	79
2610	4	Brooklyn Nets	\N	\N	68
2611	4	Brooklyn Nets	\N	\N	68
2612	4	Washington Wizards	\N	\N	79
2613	4	Philadelphia 76ers	\N	\N	63
2614	4	Oklahoma City Thunder	\N	\N	55
2615	4	Oklahoma City Thunder	\N	\N	55
2616	4	Philadelphia 76ers	\N	\N	63
2617	4	Sacramento Kings	\N	\N	58
2618	4	Chicago Bulls	\N	\N	61
2619	4	Chicago Bulls	\N	\N	61
2620	4	Sacramento Kings	\N	\N	58
2621	4	Golden State Warriors	\N	\N	53
2622	4	New Orleans Pelicans	\N	\N	62
2623	4	New Orleans Pelicans	\N	\N	62
2624	4	Golden State Warriors	\N	\N	53
2625	4	Atlanta Hawks	\N	\N	51
2626	4	Detroit Pistons	\N	\N	64
2627	4	Detroit Pistons	\N	\N	64
2628	4	Atlanta Hawks	\N	\N	51
2629	4	Miami Heat	\N	\N	71
2630	4	Dallas Mavericks	\N	\N	66
2631	4	Dallas Mavericks	\N	\N	66
2632	4	Miami Heat	\N	\N	71
2633	4	Charlotte Hornets	\N	\N	76
2634	29	Toronto Raptors	\N	\N	59
2635	30	Toronto Raptors	\N	\N	59
2636	4	Charlotte Hornets	\N	\N	76
2637	4	Minnesota Timberwolves	\N	\N	78
2638	4	San Antonio Spurs	\N	\N	75
2639	4	San Antonio Spurs	\N	\N	75
2640	4	Minnesota Timberwolves	\N	\N	78
2641	4	Portland Trail Blazers	\N	\N	65
2642	4	Boston Celtics	\N	\N	60
2643	4	Boston Celtics	\N	\N	60
2644	4	Portland Trail Blazers	\N	\N	65
2645	4	Los Angeles Clippers	\N	\N	77
2646	4	Memphis Grizzlies	\N	\N	74
2647	4	Memphis Grizzlies	\N	\N	74
2648	4	Los Angeles Clippers	\N	\N	77
2649	4	Houston Rockets	\N	\N	69
2650	4	New York Knicks	\N	\N	67
2651	4	New York Knicks	\N	\N	67
2652	4	Houston Rockets	\N	\N	69
2653	4	Orlando Magic	\N	\N	73
2654	4	Milwaukee Bucks	\N	\N	57
2655	4	Milwaukee Bucks	\N	\N	57
2656	4	Orlando Magic	\N	\N	73
2657	4	Denver Nuggets	\N	\N	80
2658	4	Phoenix Suns	\N	\N	52
2659	4	Phoenix Suns	\N	\N	52
2660	4	Denver Nuggets	\N	\N	80
2661	31	Toronto Raptors	\N	\N	59
2662	4	Washington Wizards	\N	\N	79
2663	4	Washington Wizards	\N	\N	79
2664	32	Toronto Raptors	\N	\N	59
2665	4	Sacramento Kings	\N	\N	58
2666	4	Denver Nuggets	\N	\N	80
2667	4	Denver Nuggets	\N	\N	80
2668	4	Sacramento Kings	\N	\N	58
2669	4	Houston Rockets	\N	\N	69
2670	4	Atlanta Hawks	\N	\N	51
2671	4	Atlanta Hawks	\N	\N	51
2672	4	Houston Rockets	\N	\N	69
2673	4	Orlando Magic	\N	\N	73
2674	4	Chicago Bulls	\N	\N	61
2675	4	Chicago Bulls	\N	\N	61
2676	4	Orlando Magic	\N	\N	73
2677	4	Charlotte Hornets	\N	\N	76
2678	4	Brooklyn Nets	\N	\N	68
2679	4	Brooklyn Nets	\N	\N	68
2680	4	Charlotte Hornets	\N	\N	76
2681	4	Indiana Pacers	\N	\N	54
2682	4	Minnesota Timberwolves	\N	\N	78
2683	4	Minnesota Timberwolves	\N	\N	78
2684	4	Indiana Pacers	\N	\N	54
2685	4	Philadelphia 76ers	\N	\N	63
2686	4	Golden State Warriors	\N	\N	53
2687	4	Golden State Warriors	\N	\N	53
2688	4	Philadelphia 76ers	\N	\N	63
2689	4	New Orleans Pelicans	\N	\N	62
2690	4	Cleveland Cavaliers	\N	\N	72
2691	4	Cleveland Cavaliers	\N	\N	72
2692	4	New Orleans Pelicans	\N	\N	62
2693	4	Dallas Mavericks	\N	\N	66
2694	4	Los Angeles Clippers	\N	\N	77
2695	4	Los Angeles Clippers	\N	\N	77
2696	4	Dallas Mavericks	\N	\N	66
2697	4	Miami Heat	\N	\N	71
2698	4	Memphis Grizzlies	\N	\N	74
2699	4	Memphis Grizzlies	\N	\N	74
2700	4	Miami Heat	\N	\N	71
2701	4	Portland Trail Blazers	\N	\N	65
2702	4	Detroit Pistons	\N	\N	64
2703	4	Detroit Pistons	\N	\N	64
2704	4	Portland Trail Blazers	\N	\N	65
2705	4	Los Angeles Lakers	\N	\N	70
2706	4	Boston Celtics	\N	\N	60
2707	4	Boston Celtics	\N	\N	60
2708	4	Los Angeles Lakers	\N	\N	70
2709	4	Phoenix Suns	\N	\N	52
2710	4	San Antonio Spurs	\N	\N	75
2711	4	San Antonio Spurs	\N	\N	75
2712	4	Phoenix Suns	\N	\N	52
2713	4	Utah Jazz	\N	\N	56
2714	4	New York Knicks	\N	\N	67
2715	4	New York Knicks	\N	\N	67
2716	4	Utah Jazz	\N	\N	56
2717	4	Milwaukee Bucks	\N	\N	57
2718	4	Oklahoma City Thunder	\N	\N	55
2719	4	Oklahoma City Thunder	\N	\N	55
2720	4	Milwaukee Bucks	\N	\N	57
2721	4	Philadelphia 76ers	\N	\N	63
2722	33	Toronto Raptors	\N	\N	59
2723	34	Toronto Raptors	\N	\N	59
2724	4	Philadelphia 76ers	\N	\N	63
2725	4	Boston Celtics	\N	\N	60
2726	4	Chicago Bulls	\N	\N	61
2727	4	Chicago Bulls	\N	\N	61
2728	4	Boston Celtics	\N	\N	60
2729	4	Orlando Magic	\N	\N	73
2730	4	Los Angeles Clippers	\N	\N	77
2731	4	Los Angeles Clippers	\N	\N	77
2732	4	Orlando Magic	\N	\N	73
2733	4	Los Angeles Lakers	\N	\N	70
2734	4	Sacramento Kings	\N	\N	58
2735	4	Sacramento Kings	\N	\N	58
2736	4	Los Angeles Lakers	\N	\N	70
2737	4	Memphis Grizzlies	\N	\N	74
2738	4	New York Knicks	\N	\N	67
2739	4	New York Knicks	\N	\N	67
2740	4	Memphis Grizzlies	\N	\N	74
2741	4	Oklahoma City Thunder	\N	\N	55
2742	4	Cleveland Cavaliers	\N	\N	72
2743	4	Cleveland Cavaliers	\N	\N	72
2744	4	Oklahoma City Thunder	\N	\N	55
2745	4	San Antonio Spurs	\N	\N	75
2746	4	Brooklyn Nets	\N	\N	68
2747	4	Brooklyn Nets	\N	\N	68
2748	4	San Antonio Spurs	\N	\N	75
2749	4	Charlotte Hornets	\N	\N	76
2750	4	Minnesota Timberwolves	\N	\N	78
2751	4	Minnesota Timberwolves	\N	\N	78
2752	4	Charlotte Hornets	\N	\N	76
2753	4	Denver Nuggets	\N	\N	80
2754	4	Detroit Pistons	\N	\N	64
2755	4	Detroit Pistons	\N	\N	64
2756	4	Denver Nuggets	\N	\N	80
2757	4	Portland Trail Blazers	\N	\N	65
2758	4	Indiana Pacers	\N	\N	54
2759	4	Indiana Pacers	\N	\N	54
2760	4	Portland Trail Blazers	\N	\N	65
2761	4	Houston Rockets	\N	\N	69
2762	4	Miami Heat	\N	\N	71
2763	4	Miami Heat	\N	\N	71
2764	4	Houston Rockets	\N	\N	69
2765	4	Washington Wizards	\N	\N	79
2766	4	Atlanta Hawks	\N	\N	51
2767	4	Atlanta Hawks	\N	\N	51
2768	4	Washington Wizards	\N	\N	79
2769	4	Milwaukee Bucks	\N	\N	57
2770	4	New Orleans Pelicans	\N	\N	62
2771	4	New Orleans Pelicans	\N	\N	62
2772	4	Milwaukee Bucks	\N	\N	57
2773	4	Utah Jazz	\N	\N	56
2774	4	Golden State Warriors	\N	\N	53
2775	4	Golden State Warriors	\N	\N	53
2776	4	Utah Jazz	\N	\N	56
2777	4	Phoenix Suns	\N	\N	52
2778	4	Dallas Mavericks	\N	\N	66
2779	4	Dallas Mavericks	\N	\N	66
2780	4	Phoenix Suns	\N	\N	52
2781	4	Sacramento Kings	\N	\N	58
2782	4	Indiana Pacers	\N	\N	54
2783	4	Indiana Pacers	\N	\N	54
2784	4	Sacramento Kings	\N	\N	58
2785	4	Golden State Warriors	\N	\N	53
2786	4	Minnesota Timberwolves	\N	\N	78
2787	4	Minnesota Timberwolves	\N	\N	78
2788	4	Golden State Warriors	\N	\N	53
2789	4	Cleveland Cavaliers	\N	\N	72
2790	4	Atlanta Hawks	\N	\N	51
2791	4	Atlanta Hawks	\N	\N	51
2792	4	Cleveland Cavaliers	\N	\N	72
2793	4	Chicago Bulls	\N	\N	61
2794	4	San Antonio Spurs	\N	\N	75
2795	4	San Antonio Spurs	\N	\N	75
2796	4	Chicago Bulls	\N	\N	61
2797	4	Los Angeles Lakers	\N	\N	70
2798	4	Houston Rockets	\N	\N	69
2799	4	Houston Rockets	\N	\N	69
2800	4	Los Angeles Lakers	\N	\N	70
2801	4	Oklahoma City Thunder	\N	\N	55
2802	4	Boston Celtics	\N	\N	60
2803	4	Boston Celtics	\N	\N	60
2804	4	Oklahoma City Thunder	\N	\N	55
2805	4	Washington Wizards	\N	\N	79
2806	4	Milwaukee Bucks	\N	\N	57
2807	4	Milwaukee Bucks	\N	\N	57
2808	4	Washington Wizards	\N	\N	79
2809	4	New Orleans Pelicans	\N	\N	62
2810	4	Los Angeles Clippers	\N	\N	77
2811	4	Los Angeles Clippers	\N	\N	77
2812	4	New Orleans Pelicans	\N	\N	62
2813	35	Toronto Raptors	\N	\N	59
2814	4	Brooklyn Nets	\N	\N	68
2815	4	Brooklyn Nets	\N	\N	68
2816	36	Toronto Raptors	\N	\N	59
2817	4	Phoenix Suns	\N	\N	52
2818	4	Philadelphia 76ers	\N	\N	63
2819	4	Philadelphia 76ers	\N	\N	63
2820	4	Phoenix Suns	\N	\N	52
2821	4	Charlotte Hornets	\N	\N	76
2822	4	New York Knicks	\N	\N	67
2823	4	New York Knicks	\N	\N	67
2824	4	Charlotte Hornets	\N	\N	76
2825	4	Denver Nuggets	\N	\N	80
2826	4	Portland Trail Blazers	\N	\N	65
2827	4	Portland Trail Blazers	\N	\N	65
2828	4	Denver Nuggets	\N	\N	80
2829	4	Dallas Mavericks	\N	\N	66
2830	4	Utah Jazz	\N	\N	56
2831	4	Utah Jazz	\N	\N	56
2832	4	Dallas Mavericks	\N	\N	66
2833	4	Orlando Magic	\N	\N	73
2834	4	Memphis Grizzlies	\N	\N	74
2835	4	Memphis Grizzlies	\N	\N	74
2836	4	Orlando Magic	\N	\N	73
2837	4	Miami Heat	\N	\N	71
2838	4	Detroit Pistons	\N	\N	64
2839	4	Detroit Pistons	\N	\N	64
2840	4	Miami Heat	\N	\N	71
2841	4	Dallas Mavericks	\N	\N	66
2842	4	San Antonio Spurs	\N	\N	75
2843	4	San Antonio Spurs	\N	\N	75
2844	4	Dallas Mavericks	\N	\N	66
2845	4	Washington Wizards	\N	\N	79
2846	4	Boston Celtics	\N	\N	60
2847	4	Boston Celtics	\N	\N	60
2848	4	Washington Wizards	\N	\N	79
2849	4	Charlotte Hornets	\N	\N	76
2850	4	Los Angeles Lakers	\N	\N	70
2851	4	Los Angeles Lakers	\N	\N	70
2852	4	Charlotte Hornets	\N	\N	76
2853	4	Brooklyn Nets	\N	\N	68
2854	4	Detroit Pistons	\N	\N	64
2855	4	Detroit Pistons	\N	\N	64
2856	4	Brooklyn Nets	\N	\N	68
2857	4	Milwaukee Bucks	\N	\N	57
2858	37	Toronto Raptors	\N	\N	59
2859	38	Toronto Raptors	\N	\N	59
2860	4	Milwaukee Bucks	\N	\N	57
2861	4	Chicago Bulls	\N	\N	61
2862	4	Miami Heat	\N	\N	71
2863	4	Miami Heat	\N	\N	71
2864	4	Chicago Bulls	\N	\N	61
2865	4	Portland Trail Blazers	\N	\N	65
2866	4	Phoenix Suns	\N	\N	52
2867	4	Phoenix Suns	\N	\N	52
2868	4	Portland Trail Blazers	\N	\N	65
2869	4	Atlanta Hawks	\N	\N	51
2870	4	Utah Jazz	\N	\N	56
2871	4	Utah Jazz	\N	\N	56
2872	4	Atlanta Hawks	\N	\N	51
2873	4	New York Knicks	\N	\N	67
2874	4	Denver Nuggets	\N	\N	80
2875	4	Denver Nuggets	\N	\N	80
2876	4	New York Knicks	\N	\N	67
2877	4	Philadelphia 76ers	\N	\N	63
2878	4	Los Angeles Clippers	\N	\N	77
2879	4	Los Angeles Clippers	\N	\N	77
2880	4	Philadelphia 76ers	\N	\N	63
2881	4	Memphis Grizzlies	\N	\N	74
2882	4	Houston Rockets	\N	\N	69
2883	4	Houston Rockets	\N	\N	69
2884	4	Memphis Grizzlies	\N	\N	74
2885	4	Golden State Warriors	\N	\N	53
2886	4	Oklahoma City Thunder	\N	\N	55
2887	4	Oklahoma City Thunder	\N	\N	55
2888	4	Golden State Warriors	\N	\N	53
2889	4	New Orleans Pelicans	\N	\N	62
2890	4	Sacramento Kings	\N	\N	58
2891	4	Sacramento Kings	\N	\N	58
2892	4	New Orleans Pelicans	\N	\N	62
2893	4	Indiana Pacers	\N	\N	54
2894	4	Orlando Magic	\N	\N	73
2895	4	Orlando Magic	\N	\N	73
2896	4	Indiana Pacers	\N	\N	54
2897	4	Cleveland Cavaliers	\N	\N	72
2898	4	Minnesota Timberwolves	\N	\N	78
2899	4	Minnesota Timberwolves	\N	\N	78
2900	4	Cleveland Cavaliers	\N	\N	72
2901	4	Detroit Pistons	\N	\N	64
2902	4	Chicago Bulls	\N	\N	61
2903	4	Chicago Bulls	\N	\N	61
2904	4	Detroit Pistons	\N	\N	64
2905	4	Washington Wizards	\N	\N	79
2906	4	Phoenix Suns	\N	\N	52
2907	4	Phoenix Suns	\N	\N	52
2908	4	Washington Wizards	\N	\N	79
2909	4	Sacramento Kings	\N	\N	58
2910	4	Charlotte Hornets	\N	\N	76
2911	4	Charlotte Hornets	\N	\N	76
2912	4	Sacramento Kings	\N	\N	58
2913	4	Orlando Magic	\N	\N	73
2914	4	Utah Jazz	\N	\N	56
2915	4	Utah Jazz	\N	\N	56
2916	4	Orlando Magic	\N	\N	73
2917	4	New York Knicks	\N	\N	67
2918	4	Philadelphia 76ers	\N	\N	63
2919	4	Philadelphia 76ers	\N	\N	63
2920	4	New York Knicks	\N	\N	67
2921	4	Miami Heat	\N	\N	71
2922	4	New Orleans Pelicans	\N	\N	62
2923	4	New Orleans Pelicans	\N	\N	62
2924	4	Miami Heat	\N	\N	71
2925	4	Dallas Mavericks	\N	\N	66
2926	4	Milwaukee Bucks	\N	\N	57
2927	4	Milwaukee Bucks	\N	\N	57
2928	4	Dallas Mavericks	\N	\N	66
2929	4	San Antonio Spurs	\N	\N	75
2930	4	Denver Nuggets	\N	\N	80
2931	4	Denver Nuggets	\N	\N	80
2932	4	San Antonio Spurs	\N	\N	75
2933	4	Oklahoma City Thunder	\N	\N	55
2934	4	Brooklyn Nets	\N	\N	68
2935	4	Brooklyn Nets	\N	\N	68
2936	4	Oklahoma City Thunder	\N	\N	55
2937	39	Toronto Raptors	\N	\N	59
2938	4	Atlanta Hawks	\N	\N	51
2939	4	Atlanta Hawks	\N	\N	51
2940	40	Toronto Raptors	\N	\N	59
2941	4	Los Angeles Lakers	\N	\N	70
2942	4	Golden State Warriors	\N	\N	53
2943	4	Golden State Warriors	\N	\N	53
2944	4	Los Angeles Lakers	\N	\N	70
2945	4	Cleveland Cavaliers	\N	\N	72
2946	4	Portland Trail Blazers	\N	\N	65
2947	4	Portland Trail Blazers	\N	\N	65
2948	4	Cleveland Cavaliers	\N	\N	72
2949	4	Los Angeles Clippers	\N	\N	77
2950	4	Boston Celtics	\N	\N	60
2951	4	Boston Celtics	\N	\N	60
2952	4	Los Angeles Clippers	\N	\N	77
2953	4	Memphis Grizzlies	\N	\N	74
2954	4	Indiana Pacers	\N	\N	54
2955	4	Indiana Pacers	\N	\N	54
2956	4	Memphis Grizzlies	\N	\N	74
2957	4	Houston Rockets	\N	\N	69
2958	4	Minnesota Timberwolves	\N	\N	78
2959	4	Minnesota Timberwolves	\N	\N	78
2960	4	Houston Rockets	\N	\N	69
2961	4	Indiana Pacers	\N	\N	54
2962	4	Chicago Bulls	\N	\N	61
2963	4	Chicago Bulls	\N	\N	61
2964	4	Indiana Pacers	\N	\N	54
2965	4	Detroit Pistons	\N	\N	64
2966	4	New York Knicks	\N	\N	67
2967	4	New York Knicks	\N	\N	67
2968	4	Detroit Pistons	\N	\N	64
2969	4	Cleveland Cavaliers	\N	\N	72
2970	4	Los Angeles Clippers	\N	\N	77
2971	4	Los Angeles Clippers	\N	\N	77
2972	4	Cleveland Cavaliers	\N	\N	72
2973	4	Denver Nuggets	\N	\N	80
2974	4	Oklahoma City Thunder	\N	\N	55
2975	4	Oklahoma City Thunder	\N	\N	55
2976	4	Denver Nuggets	\N	\N	80
2977	41	Toronto Raptors	\N	\N	59
2978	4	Phoenix Suns	\N	\N	52
2979	4	Phoenix Suns	\N	\N	52
2980	42	Toronto Raptors	\N	\N	59
2981	4	Orlando Magic	\N	\N	73
2982	4	Boston Celtics	\N	\N	60
2983	4	Boston Celtics	\N	\N	60
2984	4	Orlando Magic	\N	\N	73
2985	4	Portland Trail Blazers	\N	\N	65
2986	4	Milwaukee Bucks	\N	\N	57
2987	4	Milwaukee Bucks	\N	\N	57
2988	4	Portland Trail Blazers	\N	\N	65
2989	4	Golden State Warriors	\N	\N	53
2990	4	Miami Heat	\N	\N	71
2991	4	Miami Heat	\N	\N	71
2992	4	Golden State Warriors	\N	\N	53
2993	4	Minnesota Timberwolves	\N	\N	78
2994	4	Washington Wizards	\N	\N	79
2995	4	Washington Wizards	\N	\N	79
2996	4	Minnesota Timberwolves	\N	\N	78
2997	4	Brooklyn Nets	\N	\N	68
2998	4	Houston Rockets	\N	\N	69
2999	4	Houston Rockets	\N	\N	69
3000	4	Brooklyn Nets	\N	\N	68
3001	4	Sacramento Kings	\N	\N	58
3002	4	Dallas Mavericks	\N	\N	66
3003	4	Dallas Mavericks	\N	\N	66
3004	4	Sacramento Kings	\N	\N	58
3005	4	Utah Jazz	\N	\N	56
3006	4	San Antonio Spurs	\N	\N	75
3007	4	San Antonio Spurs	\N	\N	75
3008	4	Utah Jazz	\N	\N	56
3009	4	Memphis Grizzlies	\N	\N	74
3010	4	Philadelphia 76ers	\N	\N	63
3011	4	Philadelphia 76ers	\N	\N	63
3012	4	Memphis Grizzlies	\N	\N	74
3013	4	Charlotte Hornets	\N	\N	76
3014	4	Atlanta Hawks	\N	\N	51
3015	4	Atlanta Hawks	\N	\N	51
3016	4	Charlotte Hornets	\N	\N	76
3017	4	New Orleans Pelicans	\N	\N	62
3018	4	Los Angeles Lakers	\N	\N	70
3019	4	Los Angeles Lakers	\N	\N	70
3020	4	New Orleans Pelicans	\N	\N	62
3021	4	Boston Celtics	\N	\N	60
3022	4	Charlotte Hornets	\N	\N	76
3023	4	Charlotte Hornets	\N	\N	76
3024	4	Boston Celtics	\N	\N	60
3025	4	Utah Jazz	\N	\N	56
3026	4	Miami Heat	\N	\N	71
3027	4	Miami Heat	\N	\N	71
3028	4	Utah Jazz	\N	\N	56
3029	4	Brooklyn Nets	\N	\N	68
3030	4	Sacramento Kings	\N	\N	58
3031	4	Sacramento Kings	\N	\N	58
3032	4	Brooklyn Nets	\N	\N	68
3033	43	Toronto Raptors	\N	\N	59
3034	4	Orlando Magic	\N	\N	73
3035	4	Orlando Magic	\N	\N	73
3036	44	Toronto Raptors	\N	\N	59
3037	4	Minnesota Timberwolves	\N	\N	78
3038	4	Oklahoma City Thunder	\N	\N	55
3039	4	Oklahoma City Thunder	\N	\N	55
3040	4	Minnesota Timberwolves	\N	\N	78
3041	4	Washington Wizards	\N	\N	79
3042	4	Los Angeles Lakers	\N	\N	70
3043	4	Los Angeles Lakers	\N	\N	70
3044	4	Washington Wizards	\N	\N	79
3045	4	Milwaukee Bucks	\N	\N	57
3046	4	New York Knicks	\N	\N	67
3047	4	New York Knicks	\N	\N	67
3048	4	Milwaukee Bucks	\N	\N	57
3049	4	Denver Nuggets	\N	\N	80
3050	4	Houston Rockets	\N	\N	69
3051	4	Houston Rockets	\N	\N	69
3052	4	Denver Nuggets	\N	\N	80
3053	4	San Antonio Spurs	\N	\N	75
3054	4	Memphis Grizzlies	\N	\N	74
3055	4	Memphis Grizzlies	\N	\N	74
3056	4	San Antonio Spurs	\N	\N	75
3057	4	Cleveland Cavaliers	\N	\N	72
3058	4	Phoenix Suns	\N	\N	52
3059	4	Phoenix Suns	\N	\N	52
3060	4	Cleveland Cavaliers	\N	\N	72
3061	4	Golden State Warriors	\N	\N	53
3062	4	Portland Trail Blazers	\N	\N	65
3063	4	Portland Trail Blazers	\N	\N	65
3064	4	Golden State Warriors	\N	\N	53
3065	4	Indiana Pacers	\N	\N	54
3066	4	Dallas Mavericks	\N	\N	66
3067	4	Dallas Mavericks	\N	\N	66
3068	4	Indiana Pacers	\N	\N	54
3069	4	Detroit Pistons	\N	\N	64
3070	4	New Orleans Pelicans	\N	\N	62
3071	4	New Orleans Pelicans	\N	\N	62
3072	4	Detroit Pistons	\N	\N	64
3073	4	Chicago Bulls	\N	\N	61
3074	4	Los Angeles Clippers	\N	\N	77
3075	4	Los Angeles Clippers	\N	\N	77
3076	4	Chicago Bulls	\N	\N	61
3077	4	Atlanta Hawks	\N	\N	51
3078	4	Philadelphia 76ers	\N	\N	63
3079	4	Philadelphia 76ers	\N	\N	63
3080	4	Atlanta Hawks	\N	\N	51
3081	4	Phoenix Suns	\N	\N	52
3082	4	Chicago Bulls	\N	\N	61
3083	4	Chicago Bulls	\N	\N	61
3084	4	Phoenix Suns	\N	\N	52
3085	4	San Antonio Spurs	\N	\N	75
3086	4	Los Angeles Lakers	\N	\N	70
3087	4	Los Angeles Lakers	\N	\N	70
3088	4	San Antonio Spurs	\N	\N	75
3089	4	Orlando Magic	\N	\N	73
3090	4	Dallas Mavericks	\N	\N	66
3091	4	Dallas Mavericks	\N	\N	66
3092	4	Orlando Magic	\N	\N	73
3093	4	Cleveland Cavaliers	\N	\N	72
3094	4	Miami Heat	\N	\N	71
3095	4	Miami Heat	\N	\N	71
3096	4	Cleveland Cavaliers	\N	\N	72
3097	4	Boston Celtics	\N	\N	60
3098	4	Denver Nuggets	\N	\N	80
3099	4	Denver Nuggets	\N	\N	80
3100	4	Boston Celtics	\N	\N	60
3101	4	Washington Wizards	\N	\N	79
3102	4	New Orleans Pelicans	\N	\N	62
3103	4	New Orleans Pelicans	\N	\N	62
3104	4	Washington Wizards	\N	\N	79
3105	4	Minnesota Timberwolves	\N	\N	78
3106	4	Memphis Grizzlies	\N	\N	74
3107	4	Memphis Grizzlies	\N	\N	74
3108	4	Minnesota Timberwolves	\N	\N	78
3109	4	Oklahoma City Thunder	\N	\N	55
3110	4	Houston Rockets	\N	\N	69
3111	4	Houston Rockets	\N	\N	69
3112	4	Oklahoma City Thunder	\N	\N	55
3113	4	Milwaukee Bucks	\N	\N	57
3114	4	Atlanta Hawks	\N	\N	51
3115	4	Atlanta Hawks	\N	\N	51
3116	4	Milwaukee Bucks	\N	\N	57
3117	4	Portland Trail Blazers	\N	\N	65
3118	4	Utah Jazz	\N	\N	56
3119	4	Utah Jazz	\N	\N	56
3120	4	Portland Trail Blazers	\N	\N	65
3121	4	Brooklyn Nets	\N	\N	68
3122	4	Indiana Pacers	\N	\N	54
3123	4	Indiana Pacers	\N	\N	54
3124	4	Brooklyn Nets	\N	\N	68
3125	45	Toronto Raptors	\N	\N	59
3126	4	Detroit Pistons	\N	\N	64
3127	4	Detroit Pistons	\N	\N	64
3128	46	Toronto Raptors	\N	\N	59
3129	4	New York Knicks	\N	\N	67
3130	4	Golden State Warriors	\N	\N	53
3131	4	Golden State Warriors	\N	\N	53
3132	4	New York Knicks	\N	\N	67
3133	4	Los Angeles Clippers	\N	\N	77
3134	4	Sacramento Kings	\N	\N	58
3135	4	Sacramento Kings	\N	\N	58
3136	4	Los Angeles Clippers	\N	\N	77
3137	4	Philadelphia 76ers	\N	\N	63
3138	4	Charlotte Hornets	\N	\N	76
3139	4	Charlotte Hornets	\N	\N	76
3140	4	Philadelphia 76ers	\N	\N	63
3141	4	Los Angeles Lakers	\N	\N	70
3142	4	Phoenix Suns	\N	\N	52
3143	4	Phoenix Suns	\N	\N	52
3144	4	Los Angeles Lakers	\N	\N	70
3145	4	Minnesota Timberwolves	\N	\N	78
3146	47	Toronto Raptors	\N	\N	59
3147	48	Toronto Raptors	\N	\N	59
3148	4	Minnesota Timberwolves	\N	\N	78
3149	4	Memphis Grizzlies	\N	\N	74
3150	4	Brooklyn Nets	\N	\N	68
3151	4	Brooklyn Nets	\N	\N	68
3152	4	Memphis Grizzlies	\N	\N	74
3153	4	Detroit Pistons	\N	\N	64
3154	4	Utah Jazz	\N	\N	56
3155	4	Utah Jazz	\N	\N	56
3156	4	Detroit Pistons	\N	\N	64
3157	4	Los Angeles Clippers	\N	\N	77
3158	4	Washington Wizards	\N	\N	79
3159	4	Washington Wizards	\N	\N	79
3160	4	Los Angeles Clippers	\N	\N	77
3161	4	Denver Nuggets	\N	\N	80
3162	4	Dallas Mavericks	\N	\N	66
3163	4	Dallas Mavericks	\N	\N	66
3164	4	Denver Nuggets	\N	\N	80
3165	4	Portland Trail Blazers	\N	\N	65
3166	4	Atlanta Hawks	\N	\N	51
3167	4	Atlanta Hawks	\N	\N	51
3168	4	Portland Trail Blazers	\N	\N	65
3169	4	Milwaukee Bucks	\N	\N	57
3170	4	Boston Celtics	\N	\N	60
3171	4	Boston Celtics	\N	\N	60
3172	4	Milwaukee Bucks	\N	\N	57
3173	4	Charlotte Hornets	\N	\N	76
3174	4	Orlando Magic	\N	\N	73
3175	4	Orlando Magic	\N	\N	73
3176	4	Charlotte Hornets	\N	\N	76
3177	4	Golden State Warriors	\N	\N	53
3178	4	Chicago Bulls	\N	\N	61
3179	4	Chicago Bulls	\N	\N	61
3180	4	Golden State Warriors	\N	\N	53
3181	4	Sacramento Kings	\N	\N	58
3182	4	New York Knicks	\N	\N	67
3183	4	New York Knicks	\N	\N	67
3184	4	Sacramento Kings	\N	\N	58
3185	4	Cleveland Cavaliers	\N	\N	72
3186	4	Indiana Pacers	\N	\N	54
3187	4	Indiana Pacers	\N	\N	54
3188	4	Cleveland Cavaliers	\N	\N	72
3189	4	Oklahoma City Thunder	\N	\N	55
3190	4	Miami Heat	\N	\N	71
3191	4	Miami Heat	\N	\N	71
3192	4	Oklahoma City Thunder	\N	\N	55
3193	4	Houston Rockets	\N	\N	69
3194	4	New Orleans Pelicans	\N	\N	62
3195	4	New Orleans Pelicans	\N	\N	62
3196	4	Houston Rockets	\N	\N	69
3197	4	Philadelphia 76ers	\N	\N	63
3198	4	San Antonio Spurs	\N	\N	75
3199	4	San Antonio Spurs	\N	\N	75
3200	4	Philadelphia 76ers	\N	\N	63
3201	4	Denver Nuggets	\N	\N	80
3202	49	Toronto Raptors	\N	\N	59
3203	50	Toronto Raptors	\N	\N	59
3204	4	Denver Nuggets	\N	\N	80
3205	4	Miami Heat	\N	\N	71
3206	4	Phoenix Suns	\N	\N	52
3207	4	Phoenix Suns	\N	\N	52
3208	4	Miami Heat	\N	\N	71
3209	4	San Antonio Spurs	\N	\N	75
3210	4	Los Angeles Clippers	\N	\N	77
3211	4	Los Angeles Clippers	\N	\N	77
3212	4	San Antonio Spurs	\N	\N	75
3213	4	Cleveland Cavaliers	\N	\N	72
3214	4	Sacramento Kings	\N	\N	58
3215	4	Sacramento Kings	\N	\N	58
3216	4	Cleveland Cavaliers	\N	\N	72
3217	4	Boston Celtics	\N	\N	60
3218	4	Minnesota Timberwolves	\N	\N	78
3219	4	Minnesota Timberwolves	\N	\N	78
3220	4	Boston Celtics	\N	\N	60
3221	4	Indiana Pacers	\N	\N	54
3222	4	Detroit Pistons	\N	\N	64
3223	4	Detroit Pistons	\N	\N	64
3224	4	Indiana Pacers	\N	\N	54
3225	4	Charlotte Hornets	\N	\N	76
3226	4	Washington Wizards	\N	\N	79
3227	4	Washington Wizards	\N	\N	79
3228	4	Charlotte Hornets	\N	\N	76
3229	4	Dallas Mavericks	\N	\N	66
3230	4	New York Knicks	\N	\N	67
3231	4	New York Knicks	\N	\N	67
3232	4	Dallas Mavericks	\N	\N	66
3233	4	Philadelphia 76ers	\N	\N	63
3234	4	Los Angeles Lakers	\N	\N	70
3235	4	Los Angeles Lakers	\N	\N	70
3236	4	Philadelphia 76ers	\N	\N	63
3237	4	Oklahoma City Thunder	\N	\N	55
3238	4	Chicago Bulls	\N	\N	61
3239	4	Chicago Bulls	\N	\N	61
3240	4	Oklahoma City Thunder	\N	\N	55
3241	4	Brooklyn Nets	\N	\N	68
3242	4	Milwaukee Bucks	\N	\N	57
3243	4	Milwaukee Bucks	\N	\N	57
3244	4	Brooklyn Nets	\N	\N	68
3245	4	Memphis Grizzlies	\N	\N	74
3246	4	Utah Jazz	\N	\N	56
3247	4	Utah Jazz	\N	\N	56
3248	4	Memphis Grizzlies	\N	\N	74
3249	4	Houston Rockets	\N	\N	69
3250	4	Golden State Warriors	\N	\N	53
3251	4	Golden State Warriors	\N	\N	53
3252	4	Houston Rockets	\N	\N	69
3253	4	Portland Trail Blazers	\N	\N	65
3254	4	Orlando Magic	\N	\N	73
3255	4	Orlando Magic	\N	\N	73
3256	4	Portland Trail Blazers	\N	\N	65
3257	4	New Orleans Pelicans	\N	\N	62
3258	4	Atlanta Hawks	\N	\N	51
3259	4	Atlanta Hawks	\N	\N	51
3260	4	New Orleans Pelicans	\N	\N	62
3261	4	Atlanta Hawks	\N	\N	51
3262	4	Chicago Bulls	\N	\N	61
3263	4	Chicago Bulls	\N	\N	61
3264	4	Atlanta Hawks	\N	\N	51
3265	4	Washington Wizards	\N	\N	79
3266	4	Philadelphia 76ers	\N	\N	63
3267	4	Philadelphia 76ers	\N	\N	63
3268	4	Washington Wizards	\N	\N	79
3269	4	Brooklyn Nets	\N	\N	68
3270	4	Cleveland Cavaliers	\N	\N	72
3271	4	Cleveland Cavaliers	\N	\N	72
3272	4	Brooklyn Nets	\N	\N	68
3273	4	Denver Nuggets	\N	\N	80
3274	4	Charlotte Hornets	\N	\N	76
3275	4	Charlotte Hornets	\N	\N	76
3276	4	Denver Nuggets	\N	\N	80
3277	4	Milwaukee Bucks	\N	\N	57
3278	4	Detroit Pistons	\N	\N	64
3279	4	Detroit Pistons	\N	\N	64
3280	4	Milwaukee Bucks	\N	\N	57
3281	4	Indiana Pacers	\N	\N	54
3282	51	Toronto Raptors	\N	\N	59
3283	52	Toronto Raptors	\N	\N	59
3284	4	Indiana Pacers	\N	\N	54
3285	4	Dallas Mavericks	\N	\N	66
3286	4	Houston Rockets	\N	\N	69
3287	4	Houston Rockets	\N	\N	69
3288	4	Dallas Mavericks	\N	\N	66
3289	4	Utah Jazz	\N	\N	56
3290	4	Phoenix Suns	\N	\N	52
3291	4	Phoenix Suns	\N	\N	52
3292	4	Utah Jazz	\N	\N	56
3293	4	Los Angeles Lakers	\N	\N	70
3294	4	Portland Trail Blazers	\N	\N	65
3295	4	Portland Trail Blazers	\N	\N	65
3296	4	Los Angeles Lakers	\N	\N	70
3297	4	Orlando Magic	\N	\N	73
3298	4	Minnesota Timberwolves	\N	\N	78
3299	4	Minnesota Timberwolves	\N	\N	78
3300	4	Orlando Magic	\N	\N	73
3301	4	San Antonio Spurs	\N	\N	75
3302	4	New York Knicks	\N	\N	67
3303	4	New York Knicks	\N	\N	67
3304	4	San Antonio Spurs	\N	\N	75
3305	4	Los Angeles Clippers	\N	\N	77
3306	4	Golden State Warriors	\N	\N	53
3307	4	Golden State Warriors	\N	\N	53
3308	4	Los Angeles Clippers	\N	\N	77
3309	4	New Orleans Pelicans	\N	\N	62
3310	4	Boston Celtics	\N	\N	60
3311	4	Boston Celtics	\N	\N	60
3312	4	New Orleans Pelicans	\N	\N	62
3313	4	Miami Heat	\N	\N	71
3314	4	Sacramento Kings	\N	\N	58
3315	4	Sacramento Kings	\N	\N	58
3316	4	Miami Heat	\N	\N	71
3317	4	Oklahoma City Thunder	\N	\N	55
3318	4	Memphis Grizzlies	\N	\N	74
3319	4	Memphis Grizzlies	\N	\N	74
3320	4	Oklahoma City Thunder	\N	\N	55
3321	4	Dallas Mavericks	\N	\N	66
3322	4	Brooklyn Nets	\N	\N	68
3323	4	Brooklyn Nets	\N	\N	68
3324	4	Dallas Mavericks	\N	\N	66
3325	4	Atlanta Hawks	\N	\N	51
3326	4	Miami Heat	\N	\N	71
3327	4	Miami Heat	\N	\N	71
3328	4	Atlanta Hawks	\N	\N	51
3329	4	Washington Wizards	\N	\N	79
3330	4	San Antonio Spurs	\N	\N	75
3331	4	San Antonio Spurs	\N	\N	75
3332	4	Washington Wizards	\N	\N	79
3333	4	Memphis Grizzlies	\N	\N	74
3334	4	Los Angeles Lakers	\N	\N	70
3335	4	Los Angeles Lakers	\N	\N	70
3336	4	Memphis Grizzlies	\N	\N	74
3337	4	Chicago Bulls	\N	\N	61
3338	4	Minnesota Timberwolves	\N	\N	78
3339	4	Minnesota Timberwolves	\N	\N	78
3340	4	Chicago Bulls	\N	\N	61
3341	4	Golden State Warriors	\N	\N	53
3342	4	Boston Celtics	\N	\N	60
3343	4	Boston Celtics	\N	\N	60
3344	4	Golden State Warriors	\N	\N	53
3345	4	Orlando Magic	\N	\N	73
3346	4	New York Knicks	\N	\N	67
3347	4	New York Knicks	\N	\N	67
3348	4	Orlando Magic	\N	\N	73
3349	4	Utah Jazz	\N	\N	56
3350	4	Philadelphia 76ers	\N	\N	63
3351	4	Philadelphia 76ers	\N	\N	63
3352	4	Utah Jazz	\N	\N	56
3353	4	Portland Trail Blazers	\N	\N	65
3354	4	Charlotte Hornets	\N	\N	76
3355	4	Charlotte Hornets	\N	\N	76
3356	4	Portland Trail Blazers	\N	\N	65
3357	4	Los Angeles Clippers	\N	\N	77
3358	4	Indiana Pacers	\N	\N	54
3359	4	Indiana Pacers	\N	\N	54
3360	4	Los Angeles Clippers	\N	\N	77
3361	4	New Orleans Pelicans	\N	\N	62
3362	4	Denver Nuggets	\N	\N	80
3363	4	Denver Nuggets	\N	\N	80
3364	4	New Orleans Pelicans	\N	\N	62
3365	4	Phoenix Suns	\N	\N	52
3366	4	Sacramento Kings	\N	\N	58
3367	4	Sacramento Kings	\N	\N	58
3368	4	Phoenix Suns	\N	\N	52
3369	4	Cleveland Cavaliers	\N	\N	72
3370	4	Milwaukee Bucks	\N	\N	57
3371	4	Milwaukee Bucks	\N	\N	57
3372	4	Cleveland Cavaliers	\N	\N	72
3373	4	Houston Rockets	\N	\N	69
3374	53	Toronto Raptors	\N	\N	59
3375	54	Toronto Raptors	\N	\N	59
3376	4	Houston Rockets	\N	\N	69
3377	4	Detroit Pistons	\N	\N	64
3378	4	Oklahoma City Thunder	\N	\N	55
3379	4	Oklahoma City Thunder	\N	\N	55
3380	4	Detroit Pistons	\N	\N	64
3381	55	Toronto Raptors	\N	\N	59
3382	4	Chicago Bulls	\N	\N	61
3383	4	Chicago Bulls	\N	\N	61
3384	56	Toronto Raptors	\N	\N	59
3385	4	Charlotte Hornets	\N	\N	76
3386	4	Miami Heat	\N	\N	71
3387	4	Miami Heat	\N	\N	71
3388	4	Charlotte Hornets	\N	\N	76
3389	4	Detroit Pistons	\N	\N	64
3390	4	Orlando Magic	\N	\N	73
3391	4	Orlando Magic	\N	\N	73
3392	4	Detroit Pistons	\N	\N	64
3393	4	Atlanta Hawks	\N	\N	51
3394	4	Oklahoma City Thunder	\N	\N	55
3395	4	Oklahoma City Thunder	\N	\N	55
3396	4	Atlanta Hawks	\N	\N	51
3397	4	Phoenix Suns	\N	\N	52
3398	4	Indiana Pacers	\N	\N	54
3399	4	Indiana Pacers	\N	\N	54
3400	4	Phoenix Suns	\N	\N	52
3401	4	San Antonio Spurs	\N	\N	75
3402	4	Milwaukee Bucks	\N	\N	57
3403	4	Milwaukee Bucks	\N	\N	57
3404	4	San Antonio Spurs	\N	\N	75
3405	4	Los Angeles Lakers	\N	\N	70
3406	4	Denver Nuggets	\N	\N	80
3407	4	Denver Nuggets	\N	\N	80
3408	4	Los Angeles Lakers	\N	\N	70
3409	4	Utah Jazz	\N	\N	56
3410	4	Washington Wizards	\N	\N	79
3411	4	Washington Wizards	\N	\N	79
3412	4	Utah Jazz	\N	\N	56
3413	4	New Orleans Pelicans	\N	\N	62
3414	4	New York Knicks	\N	\N	67
3415	4	New York Knicks	\N	\N	67
3416	4	New Orleans Pelicans	\N	\N	62
3417	4	Cleveland Cavaliers	\N	\N	72
3418	4	Golden State Warriors	\N	\N	53
3419	4	Golden State Warriors	\N	\N	53
3420	4	Cleveland Cavaliers	\N	\N	72
3421	4	Brooklyn Nets	\N	\N	68
3422	4	Los Angeles Clippers	\N	\N	77
3423	4	Los Angeles Clippers	\N	\N	77
3424	4	Brooklyn Nets	\N	\N	68
3425	4	Houston Rockets	\N	\N	69
3426	4	Portland Trail Blazers	\N	\N	65
3427	4	Portland Trail Blazers	\N	\N	65
3428	4	Houston Rockets	\N	\N	69
3429	4	Minnesota Timberwolves	\N	\N	78
3430	4	Sacramento Kings	\N	\N	58
3431	4	Sacramento Kings	\N	\N	58
3432	4	Minnesota Timberwolves	\N	\N	78
3433	4	Dallas Mavericks	\N	\N	66
3434	4	Philadelphia 76ers	\N	\N	63
3435	4	Philadelphia 76ers	\N	\N	63
3436	4	Dallas Mavericks	\N	\N	66
3437	4	Boston Celtics	\N	\N	60
3438	4	Memphis Grizzlies	\N	\N	74
3439	4	Memphis Grizzlies	\N	\N	74
3440	4	Boston Celtics	\N	\N	60
3441	4	Boston Celtics	\N	\N	60
3442	4	Philadelphia 76ers	\N	\N	63
3443	4	Philadelphia 76ers	\N	\N	63
3444	4	Boston Celtics	\N	\N	60
3445	4	Sacramento Kings	\N	\N	58
3446	4	Golden State Warriors	\N	\N	53
3447	4	Golden State Warriors	\N	\N	53
3448	4	Sacramento Kings	\N	\N	58
3449	4	Phoenix Suns	\N	\N	52
3450	4	Minnesota Timberwolves	\N	\N	78
3451	4	Minnesota Timberwolves	\N	\N	78
3452	4	Phoenix Suns	\N	\N	52
3453	4	Chicago Bulls	\N	\N	61
3454	4	Brooklyn Nets	\N	\N	68
3455	4	Brooklyn Nets	\N	\N	68
3456	4	Chicago Bulls	\N	\N	61
3457	4	Miami Heat	\N	\N	71
3458	4	Portland Trail Blazers	\N	\N	65
3459	4	Portland Trail Blazers	\N	\N	65
3460	4	Miami Heat	\N	\N	71
3461	4	Detroit Pistons	\N	\N	64
3462	4	San Antonio Spurs	\N	\N	75
3463	4	San Antonio Spurs	\N	\N	75
3464	4	Detroit Pistons	\N	\N	64
3465	4	Atlanta Hawks	\N	\N	51
3466	4	Orlando Magic	\N	\N	73
3467	4	Orlando Magic	\N	\N	73
3468	4	Atlanta Hawks	\N	\N	51
3469	4	Milwaukee Bucks	\N	\N	57
3470	4	Denver Nuggets	\N	\N	80
3471	4	Denver Nuggets	\N	\N	80
3472	4	Milwaukee Bucks	\N	\N	57
3473	4	Memphis Grizzlies	\N	\N	74
3474	4	Charlotte Hornets	\N	\N	76
3475	4	Charlotte Hornets	\N	\N	76
3476	4	Memphis Grizzlies	\N	\N	74
3477	4	Los Angeles Lakers	\N	\N	70
3478	4	Los Angeles Clippers	\N	\N	77
3479	4	Los Angeles Clippers	\N	\N	77
3480	4	Los Angeles Lakers	\N	\N	70
3481	4	Indiana Pacers	\N	\N	54
3482	4	New Orleans Pelicans	\N	\N	62
3483	4	New Orleans Pelicans	\N	\N	62
3484	4	Indiana Pacers	\N	\N	54
3485	4	Houston Rockets	\N	\N	69
3486	4	Cleveland Cavaliers	\N	\N	72
3487	4	Cleveland Cavaliers	\N	\N	72
3488	4	Houston Rockets	\N	\N	69
3489	4	Utah Jazz	\N	\N	56
3490	57	Toronto Raptors	\N	\N	59
3491	58	Toronto Raptors	\N	\N	59
3492	4	Utah Jazz	\N	\N	56
3493	4	New York Knicks	\N	\N	67
3494	4	Oklahoma City Thunder	\N	\N	55
3495	4	Oklahoma City Thunder	\N	\N	55
3496	4	New York Knicks	\N	\N	67
3497	4	Dallas Mavericks	\N	\N	66
3498	4	Washington Wizards	\N	\N	79
3499	4	Washington Wizards	\N	\N	79
3500	4	Dallas Mavericks	\N	\N	66
3501	4	Memphis Grizzlies	\N	\N	74
3502	4	Atlanta Hawks	\N	\N	51
3503	4	Atlanta Hawks	\N	\N	51
3504	4	Memphis Grizzlies	\N	\N	74
3505	4	Detroit Pistons	\N	\N	64
3506	4	Houston Rockets	\N	\N	69
3507	4	Houston Rockets	\N	\N	69
3508	4	Detroit Pistons	\N	\N	64
3509	59	Toronto Raptors	\N	\N	59
3510	4	Portland Trail Blazers	\N	\N	65
3511	4	Portland Trail Blazers	\N	\N	65
3512	60	Toronto Raptors	\N	\N	59
3513	4	New York Knicks	\N	\N	67
3514	4	Phoenix Suns	\N	\N	52
3515	4	Phoenix Suns	\N	\N	52
3516	4	New York Knicks	\N	\N	67
3517	4	New Orleans Pelicans	\N	\N	62
3518	4	Chicago Bulls	\N	\N	61
3519	4	Chicago Bulls	\N	\N	61
3520	4	New Orleans Pelicans	\N	\N	62
3521	4	Charlotte Hornets	\N	\N	76
3522	4	San Antonio Spurs	\N	\N	75
3523	4	San Antonio Spurs	\N	\N	75
3524	4	Charlotte Hornets	\N	\N	76
3525	4	Indiana Pacers	\N	\N	54
3526	4	Washington Wizards	\N	\N	79
3527	4	Washington Wizards	\N	\N	79
3528	4	Indiana Pacers	\N	\N	54
3529	4	Golden State Warriors	\N	\N	53
3530	4	Denver Nuggets	\N	\N	80
3531	4	Denver Nuggets	\N	\N	80
3532	4	Golden State Warriors	\N	\N	53
3533	4	Brooklyn Nets	\N	\N	68
3534	4	Utah Jazz	\N	\N	56
3535	4	Utah Jazz	\N	\N	56
3536	4	Brooklyn Nets	\N	\N	68
3537	4	Cleveland Cavaliers	\N	\N	72
3538	4	Orlando Magic	\N	\N	73
3539	4	Orlando Magic	\N	\N	73
3540	4	Cleveland Cavaliers	\N	\N	72
3541	4	Milwaukee Bucks	\N	\N	57
3542	4	Los Angeles Lakers	\N	\N	70
3543	4	Los Angeles Lakers	\N	\N	70
3544	4	Milwaukee Bucks	\N	\N	57
3545	4	Miami Heat	\N	\N	71
3546	4	Philadelphia 76ers	\N	\N	63
3547	4	Philadelphia 76ers	\N	\N	63
3548	4	Miami Heat	\N	\N	71
3549	4	Boston Celtics	\N	\N	60
3550	4	Sacramento Kings	\N	\N	58
3551	4	Sacramento Kings	\N	\N	58
3552	4	Boston Celtics	\N	\N	60
3553	4	Oklahoma City Thunder	\N	\N	55
3554	4	Dallas Mavericks	\N	\N	66
3555	4	Dallas Mavericks	\N	\N	66
3556	4	Oklahoma City Thunder	\N	\N	55
3557	4	Minnesota Timberwolves	\N	\N	78
3558	4	Los Angeles Clippers	\N	\N	77
3559	4	Los Angeles Clippers	\N	\N	77
3560	4	Minnesota Timberwolves	\N	\N	78
3561	4	Charlotte Hornets	\N	\N	76
3562	4	Detroit Pistons	\N	\N	64
3563	4	Detroit Pistons	\N	\N	64
3564	4	Charlotte Hornets	\N	\N	76
3565	4	Orlando Magic	\N	\N	73
3566	4	Los Angeles Lakers	\N	\N	70
3567	4	Los Angeles Lakers	\N	\N	70
3568	4	Orlando Magic	\N	\N	73
3569	4	Indiana Pacers	\N	\N	54
3570	4	San Antonio Spurs	\N	\N	75
3571	4	San Antonio Spurs	\N	\N	75
3572	4	Indiana Pacers	\N	\N	54
3573	4	Oklahoma City Thunder	\N	\N	55
3574	4	Portland Trail Blazers	\N	\N	65
3575	4	Portland Trail Blazers	\N	\N	65
3576	4	Oklahoma City Thunder	\N	\N	55
3577	4	Chicago Bulls	\N	\N	61
3578	4	Utah Jazz	\N	\N	56
3579	4	Utah Jazz	\N	\N	56
3580	4	Chicago Bulls	\N	\N	61
3581	4	Milwaukee Bucks	\N	\N	57
3582	4	Memphis Grizzlies	\N	\N	74
3583	4	Memphis Grizzlies	\N	\N	74
3584	4	Milwaukee Bucks	\N	\N	57
3585	4	Minnesota Timberwolves	\N	\N	78
3586	4	Philadelphia 76ers	\N	\N	63
3587	4	Philadelphia 76ers	\N	\N	63
3588	4	Minnesota Timberwolves	\N	\N	78
3589	4	Houston Rockets	\N	\N	69
3590	4	Sacramento Kings	\N	\N	58
3591	4	Sacramento Kings	\N	\N	58
3592	4	Houston Rockets	\N	\N	69
3593	4	Brooklyn Nets	\N	\N	68
3594	4	Atlanta Hawks	\N	\N	51
3595	4	Atlanta Hawks	\N	\N	51
3596	4	Brooklyn Nets	\N	\N	68
3597	4	Dallas Mavericks	\N	\N	66
3598	4	New Orleans Pelicans	\N	\N	62
3599	4	New Orleans Pelicans	\N	\N	62
3600	4	Dallas Mavericks	\N	\N	66
3601	4	Cleveland Cavaliers	\N	\N	72
3602	4	Denver Nuggets	\N	\N	80
3603	4	Denver Nuggets	\N	\N	80
3604	4	Cleveland Cavaliers	\N	\N	72
3605	4	Los Angeles Clippers	\N	\N	77
3606	61	Toronto Raptors	\N	\N	59
3607	62	Toronto Raptors	\N	\N	59
3608	4	Los Angeles Clippers	\N	\N	77
3609	4	Washington Wizards	\N	\N	79
3610	4	Miami Heat	\N	\N	71
3611	4	Miami Heat	\N	\N	71
3612	4	Washington Wizards	\N	\N	79
3613	4	Boston Celtics	\N	\N	60
3614	4	New York Knicks	\N	\N	67
3615	4	New York Knicks	\N	\N	67
3616	4	Boston Celtics	\N	\N	60
3617	4	Phoenix Suns	\N	\N	52
3618	4	Golden State Warriors	\N	\N	53
3619	4	Golden State Warriors	\N	\N	53
3620	4	Phoenix Suns	\N	\N	52
3621	4	Buffalo Bills	\N	\N	86
3622	4	Minnesota Vikings	\N	\N	111
3623	4	Minnesota Vikings	\N	\N	111
3624	4	Buffalo Bills	\N	\N	86
3625	4	New York Jets	\N	\N	93
3626	4	Denver Broncos	\N	\N	97
3627	4	Denver Broncos	\N	\N	97
3628	4	New York Jets	\N	\N	93
3629	4	Washington Commanders	\N	\N	85
3630	4	Indianapolis Colts	\N	\N	104
3631	4	Indianapolis Colts	\N	\N	104
3632	4	Washington Commanders	\N	\N	85
3633	4	Atlanta Falcons	\N	\N	88
3634	4	Cleveland Browns	\N	\N	107
3635	4	Cleveland Browns	\N	\N	107
3636	4	Atlanta Falcons	\N	\N	88
3637	4	Tampa Bay Buccaneers	\N	\N	99
3638	4	Detroit Lions	\N	\N	95
3639	4	Detroit Lions	\N	\N	95
3640	4	Tampa Bay Buccaneers	\N	\N	99
3641	4	Jacksonville Jaguars	\N	\N	100
3642	4	Carolina Panthers	\N	\N	82
3643	4	Carolina Panthers	\N	\N	82
3644	4	Jacksonville Jaguars	\N	\N	100
3645	4	Green Bay Packers	\N	\N	94
3646	4	New York Giants	\N	\N	92
3647	4	New York Giants	\N	\N	92
3648	4	Green Bay Packers	\N	\N	94
3649	4	Chicago Bears	\N	\N	101
3650	4	Los Angeles Rams	\N	\N	81
3651	4	Los Angeles Rams	\N	\N	81
3652	4	Chicago Bears	\N	\N	101
3653	4	Houston Texans	\N	\N	105
3654	4	New Orleans Saints	\N	\N	90
3655	4	New Orleans Saints	\N	\N	90
3656	4	Houston Texans	\N	\N	105
3657	4	Las Vegas Raiders	\N	\N	110
3658	4	Dallas Cowboys	\N	\N	89
3659	4	Dallas Cowboys	\N	\N	89
3660	4	Las Vegas Raiders	\N	\N	110
3661	4	Pittsburgh Steelers	\N	\N	108
3662	4	Tennessee Titans	\N	\N	91
3663	4	Tennessee Titans	\N	\N	91
3664	4	Pittsburgh Steelers	\N	\N	108
3665	4	Los Angeles Chargers	\N	\N	83
3666	4	Seattle Seahawks	\N	\N	96
3667	4	Seattle Seahawks	\N	\N	96
3668	4	Los Angeles Chargers	\N	\N	83
3669	4	Arizona Cardinals	\N	\N	112
3670	4	Cincinnati Bengals	\N	\N	98
3671	4	Cincinnati Bengals	\N	\N	98
3672	4	Arizona Cardinals	\N	\N	112
3673	4	San Francisco 49ers	\N	\N	87
3674	4	Kansas City Chiefs	\N	\N	103
3675	4	Kansas City Chiefs	\N	\N	103
3676	4	San Francisco 49ers	\N	\N	87
3677	4	New England Patriots	\N	\N	84
3678	4	Philadelphia Eagles	\N	\N	106
3679	4	Philadelphia Eagles	\N	\N	106
3680	4	New England Patriots	\N	\N	84
3681	4	Baltimore Ravens	\N	\N	102
3682	4	Miami Dolphins	\N	\N	109
3683	4	Miami Dolphins	\N	\N	109
3684	4	Baltimore Ravens	\N	\N	102
3685	4	Buffalo Bills	\N	\N	86
3686	4	Denver Broncos	\N	\N	97
3687	4	Denver Broncos	\N	\N	97
3688	4	Buffalo Bills	\N	\N	86
3689	4	San Francisco 49ers	\N	\N	87
3690	4	Los Angeles Rams	\N	\N	81
3691	4	Los Angeles Rams	\N	\N	81
3692	4	San Francisco 49ers	\N	\N	87
3693	4	Kansas City Chiefs	\N	\N	103
3694	4	Houston Texans	\N	\N	105
3695	4	Houston Texans	\N	\N	105
3696	4	Kansas City Chiefs	\N	\N	103
3697	4	New York Jets	\N	\N	93
3698	4	Pittsburgh Steelers	\N	\N	108
3699	4	Pittsburgh Steelers	\N	\N	108
3700	4	New York Jets	\N	\N	93
3701	4	Atlanta Falcons	\N	\N	88
3702	4	New Orleans Saints	\N	\N	90
3703	4	New Orleans Saints	\N	\N	90
3704	4	Atlanta Falcons	\N	\N	88
3705	4	Philadelphia Eagles	\N	\N	106
3706	4	New York Giants	\N	\N	92
3707	4	New York Giants	\N	\N	92
3708	4	Philadelphia Eagles	\N	\N	106
3709	4	Baltimore Ravens	\N	\N	102
3710	4	Arizona Cardinals	\N	\N	112
3711	4	Arizona Cardinals	\N	\N	112
3712	4	Baltimore Ravens	\N	\N	102
3713	4	Indianapolis Colts	\N	\N	104
3714	4	Chicago Bears	\N	\N	101
3715	4	Chicago Bears	\N	\N	101
3716	4	Indianapolis Colts	\N	\N	104
3717	4	Detroit Lions	\N	\N	95
3718	4	Jacksonville Jaguars	\N	\N	100
3719	4	Jacksonville Jaguars	\N	\N	100
3720	4	Detroit Lions	\N	\N	95
3721	4	Miami Dolphins	\N	\N	109
3722	4	Las Vegas Raiders	\N	\N	110
3723	4	Las Vegas Raiders	\N	\N	110
3724	4	Miami Dolphins	\N	\N	109
3725	4	Dallas Cowboys	\N	\N	89
3726	4	Los Angeles Chargers	\N	\N	83
3727	4	Los Angeles Chargers	\N	\N	83
3728	4	Dallas Cowboys	\N	\N	89
3729	4	Green Bay Packers	\N	\N	94
3730	4	Minnesota Vikings	\N	\N	111
3731	4	Minnesota Vikings	\N	\N	111
3732	4	Green Bay Packers	\N	\N	94
3733	4	Tennessee Titans	\N	\N	91
3734	4	New England Patriots	\N	\N	84
3735	4	New England Patriots	\N	\N	84
3736	4	Tennessee Titans	\N	\N	91
3737	4	Cincinnati Bengals	\N	\N	98
3738	4	Washington Commanders	\N	\N	85
3739	4	Washington Commanders	\N	\N	85
3740	4	Cincinnati Bengals	\N	\N	98
3741	4	Cleveland Browns	\N	\N	107
3742	4	Carolina Panthers	\N	\N	82
3743	4	Carolina Panthers	\N	\N	82
3744	4	Cleveland Browns	\N	\N	107
3745	4	Tampa Bay Buccaneers	\N	\N	99
3746	4	Seattle Seahawks	\N	\N	96
3747	4	Seattle Seahawks	\N	\N	96
3748	4	Tampa Bay Buccaneers	\N	\N	99
3749	4	Tennessee Titans	\N	\N	91
3750	4	New York Jets	\N	\N	93
3751	4	New York Jets	\N	\N	93
3752	4	Tennessee Titans	\N	\N	91
3753	4	Tampa Bay Buccaneers	\N	\N	99
3754	4	New York Giants	\N	\N	92
3755	4	New York Giants	\N	\N	92
3756	4	Tampa Bay Buccaneers	\N	\N	99
3757	4	Jacksonville Jaguars	\N	\N	100
3758	4	Pittsburgh Steelers	\N	\N	108
3759	4	Pittsburgh Steelers	\N	\N	108
3760	4	Jacksonville Jaguars	\N	\N	100
3761	4	Minnesota Vikings	\N	\N	111
3762	4	Seattle Seahawks	\N	\N	96
3763	4	Seattle Seahawks	\N	\N	96
3764	4	Minnesota Vikings	\N	\N	111
3765	4	Washington Commanders	\N	\N	85
3766	4	Chicago Bears	\N	\N	101
3767	4	Chicago Bears	\N	\N	101
3768	4	Washington Commanders	\N	\N	85
3769	4	Green Bay Packers	\N	\N	94
3770	4	Los Angeles Rams	\N	\N	81
3771	4	Los Angeles Rams	\N	\N	81
3772	4	Green Bay Packers	\N	\N	94
3773	4	Detroit Lions	\N	\N	95
3774	4	San Francisco 49ers	\N	\N	87
3775	4	San Francisco 49ers	\N	\N	87
3776	4	Detroit Lions	\N	\N	95
3777	4	Arizona Cardinals	\N	\N	112
3778	4	Los Angeles Chargers	\N	\N	83
3779	4	Los Angeles Chargers	\N	\N	83
3780	4	Arizona Cardinals	\N	\N	112
3781	4	Buffalo Bills	\N	\N	86
3782	4	Atlanta Falcons	\N	\N	88
3783	4	Atlanta Falcons	\N	\N	88
3784	4	Buffalo Bills	\N	\N	86
3785	4	Baltimore Ravens	\N	\N	102
3786	4	Kansas City Chiefs	\N	\N	103
3787	4	Kansas City Chiefs	\N	\N	103
3788	4	Baltimore Ravens	\N	\N	102
3789	4	Carolina Panthers	\N	\N	82
3790	4	Cincinnati Bengals	\N	\N	98
3791	4	Cincinnati Bengals	\N	\N	98
3792	4	Carolina Panthers	\N	\N	82
3793	4	New Orleans Saints	\N	\N	90
3794	4	Cleveland Browns	\N	\N	107
3795	4	Cleveland Browns	\N	\N	107
3796	4	New Orleans Saints	\N	\N	90
3797	4	Las Vegas Raiders	\N	\N	110
3798	4	Indianapolis Colts	\N	\N	104
3799	4	Indianapolis Colts	\N	\N	104
3800	4	Las Vegas Raiders	\N	\N	110
3801	4	Philadelphia Eagles	\N	\N	106
3802	4	Miami Dolphins	\N	\N	109
3803	4	Miami Dolphins	\N	\N	109
3804	4	Philadelphia Eagles	\N	\N	106
3805	4	New England Patriots	\N	\N	84
3806	4	Denver Broncos	\N	\N	97
3807	4	Denver Broncos	\N	\N	97
3808	4	New England Patriots	\N	\N	84
3809	4	Houston Texans	\N	\N	105
3810	4	Dallas Cowboys	\N	\N	89
3811	4	Dallas Cowboys	\N	\N	89
3812	4	Houston Texans	\N	\N	105
3813	4	Kansas City Chiefs	\N	\N	103
3814	4	Los Angeles Chargers	\N	\N	83
3815	4	Los Angeles Chargers	\N	\N	83
3816	4	Kansas City Chiefs	\N	\N	103
3817	4	Denver Broncos	\N	\N	97
3818	4	Arizona Cardinals	\N	\N	112
3819	4	Arizona Cardinals	\N	\N	112
3820	4	Denver Broncos	\N	\N	97
3821	4	Baltimore Ravens	\N	\N	102
3822	4	New England Patriots	\N	\N	84
3823	4	New England Patriots	\N	\N	84
3824	4	Baltimore Ravens	\N	\N	102
3825	4	Miami Dolphins	\N	\N	109
3826	4	Los Angeles Rams	\N	\N	81
3827	4	Los Angeles Rams	\N	\N	81
3828	4	Miami Dolphins	\N	\N	109
3829	4	Houston Texans	\N	\N	105
3830	4	Cincinnati Bengals	\N	\N	98
3831	4	Cincinnati Bengals	\N	\N	98
3832	4	Houston Texans	\N	\N	105
3833	4	Chicago Bears	\N	\N	101
3834	4	New Orleans Saints	\N	\N	90
3835	4	New Orleans Saints	\N	\N	90
3836	4	Chicago Bears	\N	\N	101
3837	4	Seattle Seahawks	\N	\N	96
3838	4	Carolina Panthers	\N	\N	82
3839	4	Carolina Panthers	\N	\N	82
3840	4	Seattle Seahawks	\N	\N	96
3841	4	New York Jets	\N	\N	93
3842	4	Atlanta Falcons	\N	\N	88
3843	4	Atlanta Falcons	\N	\N	88
3844	4	New York Jets	\N	\N	93
3845	4	New York Giants	\N	\N	92
3846	4	Buffalo Bills	\N	\N	86
3847	4	Buffalo Bills	\N	\N	86
3848	4	New York Giants	\N	\N	92
3849	4	Washington Commanders	\N	\N	85
3850	4	Jacksonville Jaguars	\N	\N	100
3851	4	Jacksonville Jaguars	\N	\N	100
3852	4	Washington Commanders	\N	\N	85
3853	4	Cleveland Browns	\N	\N	107
3854	4	Green Bay Packers	\N	\N	94
3855	4	Green Bay Packers	\N	\N	94
3856	4	Cleveland Browns	\N	\N	107
3857	4	Minnesota Vikings	\N	\N	111
3858	4	Philadelphia Eagles	\N	\N	106
3859	4	Philadelphia Eagles	\N	\N	106
3860	4	Minnesota Vikings	\N	\N	111
3861	4	Tennessee Titans	\N	\N	91
3862	4	Las Vegas Raiders	\N	\N	110
3863	4	Las Vegas Raiders	\N	\N	110
3864	4	Tennessee Titans	\N	\N	91
3865	4	Pittsburgh Steelers	\N	\N	108
3866	4	Indianapolis Colts	\N	\N	104
3867	4	Indianapolis Colts	\N	\N	104
3868	4	Pittsburgh Steelers	\N	\N	108
3869	4	San Francisco 49ers	\N	\N	87
3870	4	Tampa Bay Buccaneers	\N	\N	99
3871	4	Tampa Bay Buccaneers	\N	\N	99
3872	4	San Francisco 49ers	\N	\N	87
3873	4	Dallas Cowboys	\N	\N	89
3874	4	Detroit Lions	\N	\N	95
3875	4	Detroit Lions	\N	\N	95
3876	4	Dallas Cowboys	\N	\N	89
3877	4	New Orleans Saints	\N	\N	90
3878	4	Cincinnati Bengals	\N	\N	98
3879	4	Cincinnati Bengals	\N	\N	98
3880	4	New Orleans Saints	\N	\N	90
3881	4	Atlanta Falcons	\N	\N	88
3882	4	Jacksonville Jaguars	\N	\N	100
3883	4	Jacksonville Jaguars	\N	\N	100
3884	4	Atlanta Falcons	\N	\N	88
3885	4	New England Patriots	\N	\N	84
3886	4	New York Jets	\N	\N	93
3887	4	New York Jets	\N	\N	93
3888	4	New England Patriots	\N	\N	84
3889	4	Philadelphia Eagles	\N	\N	106
3890	4	Seattle Seahawks	\N	\N	96
3891	4	Seattle Seahawks	\N	\N	96
3892	4	Philadelphia Eagles	\N	\N	106
3893	4	Houston Texans	\N	\N	105
3894	4	Washington Commanders	\N	\N	85
3895	4	Washington Commanders	\N	\N	85
3896	4	Houston Texans	\N	\N	105
3897	4	Pittsburgh Steelers	\N	\N	108
3898	4	Chicago Bears	\N	\N	101
3899	4	Chicago Bears	\N	\N	101
3900	4	Pittsburgh Steelers	\N	\N	108
3901	4	New York Giants	\N	\N	92
3902	4	Detroit Lions	\N	\N	95
3903	4	Detroit Lions	\N	\N	95
3904	4	New York Giants	\N	\N	92
3905	4	Tampa Bay Buccaneers	\N	\N	99
3906	4	Tennessee Titans	\N	\N	91
3907	4	Tennessee Titans	\N	\N	91
3908	4	Tampa Bay Buccaneers	\N	\N	99
3909	4	Buffalo Bills	\N	\N	86
3910	4	Dallas Cowboys	\N	\N	89
3911	4	Dallas Cowboys	\N	\N	89
3912	4	Buffalo Bills	\N	\N	86
3913	4	Kansas City Chiefs	\N	\N	103
3914	4	Green Bay Packers	\N	\N	94
3915	4	Green Bay Packers	\N	\N	94
3916	4	Kansas City Chiefs	\N	\N	103
3917	4	Cleveland Browns	\N	\N	107
3918	4	Las Vegas Raiders	\N	\N	110
3919	4	Las Vegas Raiders	\N	\N	110
3920	4	Cleveland Browns	\N	\N	107
3921	4	Los Angeles Chargers	\N	\N	83
3922	4	Carolina Panthers	\N	\N	82
3923	4	Carolina Panthers	\N	\N	82
3924	4	Los Angeles Chargers	\N	\N	83
3925	4	Denver Broncos	\N	\N	97
3926	4	Los Angeles Rams	\N	\N	81
3927	4	Los Angeles Rams	\N	\N	81
3928	4	Denver Broncos	\N	\N	97
3929	4	Miami Dolphins	\N	\N	109
3930	4	Arizona Cardinals	\N	\N	112
3931	4	Arizona Cardinals	\N	\N	112
3932	4	Miami Dolphins	\N	\N	109
3933	4	San Francisco 49ers	\N	\N	87
3934	4	Indianapolis Colts	\N	\N	104
3935	4	Indianapolis Colts	\N	\N	104
3936	4	San Francisco 49ers	\N	\N	87
3937	4	Baltimore Ravens	\N	\N	102
3938	4	Minnesota Vikings	\N	\N	111
3939	4	Minnesota Vikings	\N	\N	111
3940	4	Baltimore Ravens	\N	\N	102
3941	4	Buffalo Bills	\N	\N	86
3942	4	Carolina Panthers	\N	\N	82
3943	4	Carolina Panthers	\N	\N	82
3944	4	Buffalo Bills	\N	\N	86
3945	4	Los Angeles Chargers	\N	\N	83
3946	4	San Francisco 49ers	\N	\N	87
3947	4	San Francisco 49ers	\N	\N	87
3948	4	Los Angeles Chargers	\N	\N	83
3949	4	Washington Commanders	\N	\N	85
3950	4	Miami Dolphins	\N	\N	109
3951	4	Miami Dolphins	\N	\N	109
3952	4	Washington Commanders	\N	\N	85
3953	4	New York Giants	\N	\N	92
3954	4	New York Jets	\N	\N	93
3955	4	New York Jets	\N	\N	93
3956	4	New York Giants	\N	\N	92
3957	4	Tennessee Titans	\N	\N	91
3958	4	Atlanta Falcons	\N	\N	88
3959	4	Atlanta Falcons	\N	\N	88
3960	4	Tennessee Titans	\N	\N	91
3961	4	Baltimore Ravens	\N	\N	102
3962	4	Detroit Lions	\N	\N	95
3963	4	Detroit Lions	\N	\N	95
3964	4	Baltimore Ravens	\N	\N	102
3965	4	Houston Texans	\N	\N	105
3966	4	New England Patriots	\N	\N	84
3967	4	New England Patriots	\N	\N	84
3968	4	Houston Texans	\N	\N	105
3969	4	New Orleans Saints	\N	\N	90
3970	4	Los Angeles Rams	\N	\N	81
3971	4	Los Angeles Rams	\N	\N	81
3972	4	New Orleans Saints	\N	\N	90
3973	4	Cincinnati Bengals	\N	\N	98
3974	4	Seattle Seahawks	\N	\N	96
3975	4	Seattle Seahawks	\N	\N	96
3976	4	Cincinnati Bengals	\N	\N	98
3977	4	Dallas Cowboys	\N	\N	89
3978	4	Chicago Bears	\N	\N	101
3979	4	Chicago Bears	\N	\N	101
3980	4	Dallas Cowboys	\N	\N	89
3981	4	Arizona Cardinals	\N	\N	112
3982	4	Jacksonville Jaguars	\N	\N	100
3983	4	Jacksonville Jaguars	\N	\N	100
3984	4	Arizona Cardinals	\N	\N	112
3985	4	Pittsburgh Steelers	\N	\N	108
3986	4	Minnesota Vikings	\N	\N	111
3987	4	Minnesota Vikings	\N	\N	111
3988	4	Pittsburgh Steelers	\N	\N	108
3989	4	Cleveland Browns	\N	\N	107
3990	4	Denver Broncos	\N	\N	97
3991	4	Denver Broncos	\N	\N	97
3992	4	Cleveland Browns	\N	\N	107
3993	4	Green Bay Packers	\N	\N	94
3994	4	Tampa Bay Buccaneers	\N	\N	99
3995	4	Tampa Bay Buccaneers	\N	\N	99
3996	4	Green Bay Packers	\N	\N	94
3997	4	Las Vegas Raiders	\N	\N	110
3998	4	Kansas City Chiefs	\N	\N	103
3999	4	Kansas City Chiefs	\N	\N	103
4000	4	Las Vegas Raiders	\N	\N	110
4001	4	Philadelphia Eagles	\N	\N	106
4002	4	Indianapolis Colts	\N	\N	104
4003	4	Indianapolis Colts	\N	\N	104
4004	4	Philadelphia Eagles	\N	\N	106
4005	4	Philadelphia Eagles	\N	\N	106
4006	4	Dallas Cowboys	\N	\N	89
4007	4	Dallas Cowboys	\N	\N	89
4008	4	Philadelphia Eagles	\N	\N	106
4009	4	San Francisco 49ers	\N	\N	87
4010	4	Tennessee Titans	\N	\N	91
4011	4	Tennessee Titans	\N	\N	91
4012	4	San Francisco 49ers	\N	\N	87
4013	4	New England Patriots	\N	\N	84
4014	4	Los Angeles Rams	\N	\N	81
4015	4	Los Angeles Rams	\N	\N	81
4016	4	New England Patriots	\N	\N	84
4017	4	Cincinnati Bengals	\N	\N	98
4018	4	Kansas City Chiefs	\N	\N	103
4019	4	Kansas City Chiefs	\N	\N	103
4020	4	Cincinnati Bengals	\N	\N	98
4021	4	Tampa Bay Buccaneers	\N	\N	99
4022	4	Arizona Cardinals	\N	\N	112
4023	4	Arizona Cardinals	\N	\N	112
4024	4	Tampa Bay Buccaneers	\N	\N	99
4025	4	Carolina Panthers	\N	\N	82
4026	4	New York Jets	\N	\N	93
4027	4	New York Jets	\N	\N	93
4028	4	Carolina Panthers	\N	\N	82
4029	4	Minnesota Vikings	\N	\N	111
4030	4	Cleveland Browns	\N	\N	107
4031	4	Cleveland Browns	\N	\N	107
4032	4	Minnesota Vikings	\N	\N	111
4033	4	Jacksonville Jaguars	\N	\N	100
4034	4	Baltimore Ravens	\N	\N	102
4035	4	Baltimore Ravens	\N	\N	102
4036	4	Jacksonville Jaguars	\N	\N	100
4037	4	Buffalo Bills	\N	\N	86
4038	4	Indianapolis Colts	\N	\N	104
4039	4	Indianapolis Colts	\N	\N	104
4040	4	Buffalo Bills	\N	\N	86
4041	4	Green Bay Packers	\N	\N	94
4042	4	Detroit Lions	\N	\N	95
4043	4	Detroit Lions	\N	\N	95
4044	4	Green Bay Packers	\N	\N	94
4045	4	Washington Commanders	\N	\N	85
4046	4	New York Giants	\N	\N	92
4047	4	New York Giants	\N	\N	92
4048	4	Washington Commanders	\N	\N	85
4049	4	Chicago Bears	\N	\N	101
4050	4	Atlanta Falcons	\N	\N	88
4051	4	Atlanta Falcons	\N	\N	88
4052	4	Chicago Bears	\N	\N	101
4053	4	Pittsburgh Steelers	\N	\N	108
4054	4	New Orleans Saints	\N	\N	90
4055	4	New Orleans Saints	\N	\N	90
4056	4	Pittsburgh Steelers	\N	\N	108
4057	4	Seattle Seahawks	\N	\N	96
4058	4	Denver Broncos	\N	\N	97
4059	4	Denver Broncos	\N	\N	97
4060	4	Seattle Seahawks	\N	\N	96
4061	4	Los Angeles Chargers	\N	\N	83
4062	4	Miami Dolphins	\N	\N	109
4063	4	Miami Dolphins	\N	\N	109
4064	4	Los Angeles Chargers	\N	\N	83
4065	4	Las Vegas Raiders	\N	\N	110
4066	4	Houston Texans	\N	\N	105
4067	4	Houston Texans	\N	\N	105
4068	4	Las Vegas Raiders	\N	\N	110
4069	4	Miami Dolphins	\N	\N	109
4070	4	Carolina Panthers	\N	\N	82
4071	4	Carolina Panthers	\N	\N	82
4072	4	Miami Dolphins	\N	\N	109
4073	4	Philadelphia Eagles	\N	\N	106
4074	4	Los Angeles Chargers	\N	\N	83
4075	4	Los Angeles Chargers	\N	\N	83
4076	4	Philadelphia Eagles	\N	\N	106
4077	4	Denver Broncos	\N	\N	97
4078	4	Cincinnati Bengals	\N	\N	98
4079	4	Cincinnati Bengals	\N	\N	98
4080	4	Denver Broncos	\N	\N	97
4081	4	Houston Texans	\N	\N	105
4082	4	Seattle Seahawks	\N	\N	96
4083	4	Seattle Seahawks	\N	\N	96
4084	4	Houston Texans	\N	\N	105
4085	4	Dallas Cowboys	\N	\N	89
4086	4	Atlanta Falcons	\N	\N	88
4087	4	Atlanta Falcons	\N	\N	88
4088	4	Dallas Cowboys	\N	\N	89
4089	4	New England Patriots	\N	\N	84
4090	4	Washington Commanders	\N	\N	85
4091	4	Washington Commanders	\N	\N	85
4092	4	New England Patriots	\N	\N	84
4093	4	Tennessee Titans	\N	\N	91
4094	4	Jacksonville Jaguars	\N	\N	100
4095	4	Jacksonville Jaguars	\N	\N	100
4096	4	Tennessee Titans	\N	\N	91
4097	4	Buffalo Bills	\N	\N	86
4098	4	New York Jets	\N	\N	93
4099	4	New York Jets	\N	\N	93
4100	4	Buffalo Bills	\N	\N	86
4101	4	San Francisco 49ers	\N	\N	87
4102	4	Las Vegas Raiders	\N	\N	110
4103	4	Las Vegas Raiders	\N	\N	110
4104	4	San Francisco 49ers	\N	\N	87
4105	4	Minnesota Vikings	\N	\N	111
4106	4	Los Angeles Rams	\N	\N	81
4107	4	Los Angeles Rams	\N	\N	81
4108	4	Minnesota Vikings	\N	\N	111
4109	4	Detroit Lions	\N	\N	95
4110	4	Arizona Cardinals	\N	\N	112
4111	4	Arizona Cardinals	\N	\N	112
4112	4	Detroit Lions	\N	\N	95
4113	4	Cleveland Browns	\N	\N	107
4114	4	Pittsburgh Steelers	\N	\N	108
4115	4	Pittsburgh Steelers	\N	\N	108
4116	4	Cleveland Browns	\N	\N	107
4117	4	New Orleans Saints	\N	\N	90
4118	4	Kansas City Chiefs	\N	\N	103
4119	4	Kansas City Chiefs	\N	\N	103
4120	4	New Orleans Saints	\N	\N	90
4121	4	Chicago Bears	\N	\N	101
4122	4	Green Bay Packers	\N	\N	94
4123	4	Green Bay Packers	\N	\N	94
4124	4	Chicago Bears	\N	\N	101
4125	4	Tampa Bay Buccaneers	\N	\N	99
4126	4	Indianapolis Colts	\N	\N	104
4127	4	Indianapolis Colts	\N	\N	104
4128	4	Tampa Bay Buccaneers	\N	\N	99
4129	4	Baltimore Ravens	\N	\N	102
4130	4	New York Giants	\N	\N	92
4131	4	New York Giants	\N	\N	92
4132	4	Baltimore Ravens	\N	\N	102
4133	4	Atlanta Falcons	\N	\N	88
4134	4	Washington Commanders	\N	\N	85
4135	4	Washington Commanders	\N	\N	85
4136	4	Atlanta Falcons	\N	\N	88
4137	4	Chicago Bears	\N	\N	101
4138	4	New York Jets	\N	\N	93
4139	4	New York Jets	\N	\N	93
4140	4	Chicago Bears	\N	\N	101
4141	4	Carolina Panthers	\N	\N	82
4142	4	Baltimore Ravens	\N	\N	102
4143	4	Baltimore Ravens	\N	\N	102
4144	4	Carolina Panthers	\N	\N	82
4145	4	San Francisco 49ers	\N	\N	87
4146	4	Arizona Cardinals	\N	\N	112
4147	4	Arizona Cardinals	\N	\N	112
4148	4	San Francisco 49ers	\N	\N	87
4149	4	Miami Dolphins	\N	\N	109
4150	4	Indianapolis Colts	\N	\N	104
4151	4	Indianapolis Colts	\N	\N	104
4152	4	Miami Dolphins	\N	\N	109
4153	4	New Orleans Saints	\N	\N	90
4154	4	Minnesota Vikings	\N	\N	111
4155	4	Minnesota Vikings	\N	\N	111
4156	4	New Orleans Saints	\N	\N	90
4157	4	Los Angeles Chargers	\N	\N	83
4158	4	Tampa Bay Buccaneers	\N	\N	99
4159	4	Tampa Bay Buccaneers	\N	\N	99
4160	4	Los Angeles Chargers	\N	\N	83
4161	4	Pittsburgh Steelers	\N	\N	108
4162	4	Detroit Lions	\N	\N	95
4163	4	Detroit Lions	\N	\N	95
4164	4	Pittsburgh Steelers	\N	\N	108
4165	4	Los Angeles Rams	\N	\N	81
4166	4	Cincinnati Bengals	\N	\N	98
4167	4	Cincinnati Bengals	\N	\N	98
4168	4	Los Angeles Rams	\N	\N	81
4169	4	Houston Texans	\N	\N	105
4170	4	Green Bay Packers	\N	\N	94
4171	4	Green Bay Packers	\N	\N	94
4172	4	Houston Texans	\N	\N	105
4173	4	Kansas City Chiefs	\N	\N	103
4174	4	Denver Broncos	\N	\N	97
4175	4	Denver Broncos	\N	\N	97
4176	4	Kansas City Chiefs	\N	\N	103
4177	4	New York Giants	\N	\N	92
4178	4	Seattle Seahawks	\N	\N	96
4179	4	Seattle Seahawks	\N	\N	96
4180	4	New York Giants	\N	\N	92
4181	4	Dallas Cowboys	\N	\N	89
4182	4	Tennessee Titans	\N	\N	91
4183	4	Tennessee Titans	\N	\N	91
4184	4	Dallas Cowboys	\N	\N	89
4185	4	Philadelphia Eagles	\N	\N	106
4186	4	Las Vegas Raiders	\N	\N	110
4187	4	Las Vegas Raiders	\N	\N	110
4188	4	Philadelphia Eagles	\N	\N	106
4189	4	Jacksonville Jaguars	\N	\N	100
4190	4	New England Patriots	\N	\N	84
4191	4	New England Patriots	\N	\N	84
4192	4	Jacksonville Jaguars	\N	\N	100
4193	4	Buffalo Bills	\N	\N	86
4194	4	Cleveland Browns	\N	\N	107
4195	4	Cleveland Browns	\N	\N	107
4196	4	Buffalo Bills	\N	\N	86
4197	4	Indianapolis Colts	\N	\N	104
4198	4	Los Angeles Chargers	\N	\N	83
4199	4	Los Angeles Chargers	\N	\N	83
4200	4	Indianapolis Colts	\N	\N	104
4201	4	Los Angeles Rams	\N	\N	81
4202	4	Buffalo Bills	\N	\N	86
4203	4	Buffalo Bills	\N	\N	86
4204	4	Los Angeles Rams	\N	\N	81
4205	4	Cleveland Browns	\N	\N	107
4206	4	Chicago Bears	\N	\N	101
4207	4	Chicago Bears	\N	\N	101
4208	4	Cleveland Browns	\N	\N	107
4209	4	New York Giants	\N	\N	92
4210	4	Miami Dolphins	\N	\N	109
4211	4	Miami Dolphins	\N	\N	109
4212	4	New York Giants	\N	\N	92
4213	4	Carolina Panthers	\N	\N	82
4214	4	Detroit Lions	\N	\N	95
4215	4	Detroit Lions	\N	\N	95
4216	4	Carolina Panthers	\N	\N	82
4217	4	Philadelphia Eagles	\N	\N	106
4218	4	New York Jets	\N	\N	93
4219	4	New York Jets	\N	\N	93
4220	4	Philadelphia Eagles	\N	\N	106
4221	4	Pittsburgh Steelers	\N	\N	108
4222	4	Atlanta Falcons	\N	\N	88
4223	4	Atlanta Falcons	\N	\N	88
4224	4	Pittsburgh Steelers	\N	\N	108
4225	4	Tampa Bay Buccaneers	\N	\N	99
4226	4	New Orleans Saints	\N	\N	90
4227	4	New Orleans Saints	\N	\N	90
4228	4	Tampa Bay Buccaneers	\N	\N	99
4229	4	Denver Broncos	\N	\N	97
4230	4	Baltimore Ravens	\N	\N	102
4231	4	Baltimore Ravens	\N	\N	102
4232	4	Denver Broncos	\N	\N	97
4233	4	Minnesota Vikings	\N	\N	111
4234	4	Las Vegas Raiders	\N	\N	110
4235	4	Las Vegas Raiders	\N	\N	110
4236	4	Minnesota Vikings	\N	\N	111
4237	4	Kansas City Chiefs	\N	\N	103
4238	4	Jacksonville Jaguars	\N	\N	100
4239	4	Jacksonville Jaguars	\N	\N	100
4240	4	Kansas City Chiefs	\N	\N	103
4241	4	Dallas Cowboys	\N	\N	89
4242	4	New England Patriots	\N	\N	84
4243	4	New England Patriots	\N	\N	84
4244	4	Dallas Cowboys	\N	\N	89
4245	4	Cincinnati Bengals	\N	\N	98
4246	4	Tennessee Titans	\N	\N	91
4247	4	Tennessee Titans	\N	\N	91
4248	4	Cincinnati Bengals	\N	\N	98
4249	4	Green Bay Packers	\N	\N	94
4250	4	Washington Commanders	\N	\N	85
4251	4	Washington Commanders	\N	\N	85
4252	4	Green Bay Packers	\N	\N	94
4253	4	Houston Texans	\N	\N	105
4254	4	Arizona Cardinals	\N	\N	112
4255	4	Arizona Cardinals	\N	\N	112
4256	4	Houston Texans	\N	\N	105
4257	4	Seattle Seahawks	\N	\N	96
4258	4	San Francisco 49ers	\N	\N	87
4259	4	San Francisco 49ers	\N	\N	87
4260	4	Seattle Seahawks	\N	\N	96
4261	4	Kansas City Chiefs	\N	\N	103
4262	4	Carolina Panthers	\N	\N	82
4263	4	Carolina Panthers	\N	\N	82
4264	4	Kansas City Chiefs	\N	\N	103
4265	4	Tampa Bay Buccaneers	\N	\N	99
4266	4	Las Vegas Raiders	\N	\N	110
4267	4	Las Vegas Raiders	\N	\N	110
4268	4	Tampa Bay Buccaneers	\N	\N	99
4269	4	Seattle Seahawks	\N	\N	96
4270	4	New Orleans Saints	\N	\N	90
4271	4	New Orleans Saints	\N	\N	90
4272	4	Seattle Seahawks	\N	\N	96
4273	4	Miami Dolphins	\N	\N	109
4274	4	Tennessee Titans	\N	\N	91
4275	4	Tennessee Titans	\N	\N	91
4276	4	Miami Dolphins	\N	\N	109
4277	4	New England Patriots	\N	\N	84
4278	4	Indianapolis Colts	\N	\N	104
4279	4	Indianapolis Colts	\N	\N	104
4280	4	New England Patriots	\N	\N	84
4281	4	San Francisco 49ers	\N	\N	87
4282	4	New York Giants	\N	\N	92
4283	4	New York Giants	\N	\N	92
4284	4	San Francisco 49ers	\N	\N	87
4285	4	Chicago Bears	\N	\N	101
4286	4	Los Angeles Chargers	\N	\N	83
4287	4	Los Angeles Chargers	\N	\N	83
4288	4	Chicago Bears	\N	\N	101
4289	4	Atlanta Falcons	\N	\N	88
4290	4	Arizona Cardinals	\N	\N	112
4291	4	Arizona Cardinals	\N	\N	112
4292	4	Atlanta Falcons	\N	\N	88
4293	4	Washington Commanders	\N	\N	85
4294	4	Detroit Lions	\N	\N	95
4295	4	Detroit Lions	\N	\N	95
4296	4	Washington Commanders	\N	\N	85
4297	4	Jacksonville Jaguars	\N	\N	100
4298	4	Cleveland Browns	\N	\N	107
4299	4	Cleveland Browns	\N	\N	107
4300	4	Jacksonville Jaguars	\N	\N	100
4301	4	Baltimore Ravens	\N	\N	102
4302	4	Dallas Cowboys	\N	\N	89
4303	4	Dallas Cowboys	\N	\N	89
4304	4	Baltimore Ravens	\N	\N	102
4305	4	Minnesota Vikings	\N	\N	111
4306	4	Houston Texans	\N	\N	105
4307	4	Houston Texans	\N	\N	105
4308	4	Minnesota Vikings	\N	\N	111
4309	4	Philadelphia Eagles	\N	\N	106
4310	4	Pittsburgh Steelers	\N	\N	108
4311	4	Pittsburgh Steelers	\N	\N	108
4312	4	Philadelphia Eagles	\N	\N	106
4313	4	Los Angeles Rams	\N	\N	81
4314	4	New York Jets	\N	\N	93
4315	4	New York Jets	\N	\N	93
4316	4	Los Angeles Rams	\N	\N	81
4317	4	Denver Broncos	\N	\N	97
4318	4	Green Bay Packers	\N	\N	94
4319	4	Green Bay Packers	\N	\N	94
4320	4	Denver Broncos	\N	\N	97
4321	4	Buffalo Bills	\N	\N	86
4322	4	Cincinnati Bengals	\N	\N	98
4323	4	Cincinnati Bengals	\N	\N	98
4324	4	Buffalo Bills	\N	\N	86
4325	4	New York Giants	\N	\N	92
4326	4	Dallas Cowboys	\N	\N	89
4327	4	Dallas Cowboys	\N	\N	89
4328	4	New York Giants	\N	\N	92
4329	4	Arizona Cardinals	\N	\N	112
4330	4	Carolina Panthers	\N	\N	82
4331	4	Carolina Panthers	\N	\N	82
4332	4	Arizona Cardinals	\N	\N	112
4333	4	San Francisco 49ers	\N	\N	87
4334	4	Atlanta Falcons	\N	\N	88
4335	4	Atlanta Falcons	\N	\N	88
4336	4	San Francisco 49ers	\N	\N	87
4337	4	Las Vegas Raiders	\N	\N	110
4338	4	Detroit Lions	\N	\N	95
4339	4	Detroit Lions	\N	\N	95
4340	4	Las Vegas Raiders	\N	\N	110
4341	4	Cincinnati Bengals	\N	\N	98
4342	4	Indianapolis Colts	\N	\N	104
4343	4	Indianapolis Colts	\N	\N	104
4344	4	Cincinnati Bengals	\N	\N	98
4345	4	Denver Broncos	\N	\N	97
4346	4	Miami Dolphins	\N	\N	109
4347	4	Miami Dolphins	\N	\N	109
4348	4	Denver Broncos	\N	\N	97
4349	4	Jacksonville Jaguars	\N	\N	100
4350	4	Seattle Seahawks	\N	\N	96
4351	4	Seattle Seahawks	\N	\N	96
4352	4	Jacksonville Jaguars	\N	\N	100
4353	4	Washington Commanders	\N	\N	85
4354	4	Los Angeles Rams	\N	\N	81
4355	4	Los Angeles Rams	\N	\N	81
4356	4	Washington Commanders	\N	\N	85
4357	4	Baltimore Ravens	\N	\N	102
4358	4	Tampa Bay Buccaneers	\N	\N	99
4359	4	Tampa Bay Buccaneers	\N	\N	99
4360	4	Baltimore Ravens	\N	\N	102
4361	4	New York Jets	\N	\N	93
4362	4	New Orleans Saints	\N	\N	90
4363	4	New Orleans Saints	\N	\N	90
4364	4	New York Jets	\N	\N	93
4365	4	Philadelphia Eagles	\N	\N	106
4366	4	Buffalo Bills	\N	\N	86
4367	4	Buffalo Bills	\N	\N	86
4368	4	Philadelphia Eagles	\N	\N	106
4369	4	New England Patriots	\N	\N	84
4370	4	Minnesota Vikings	\N	\N	111
4371	4	Minnesota Vikings	\N	\N	111
4372	4	New England Patriots	\N	\N	84
4373	4	Los Angeles Chargers	\N	\N	83
4374	4	Tennessee Titans	\N	\N	91
4375	4	Tennessee Titans	\N	\N	91
4376	4	Los Angeles Chargers	\N	\N	83
4377	4	Houston Texans	\N	\N	105
4378	4	Chicago Bears	\N	\N	101
4379	4	Chicago Bears	\N	\N	101
4380	4	Houston Texans	\N	\N	105
4381	4	Cleveland Browns	\N	\N	107
4382	4	Kansas City Chiefs	\N	\N	103
4383	4	Kansas City Chiefs	\N	\N	103
4384	4	Cleveland Browns	\N	\N	107
4385	4	Pittsburgh Steelers	\N	\N	108
4386	4	Green Bay Packers	\N	\N	94
4387	4	Green Bay Packers	\N	\N	94
4388	4	Pittsburgh Steelers	\N	\N	108
4389	4	New Orleans Saints	\N	\N	90
4390	4	Jacksonville Jaguars	\N	\N	100
4391	4	Jacksonville Jaguars	\N	\N	100
4392	4	New Orleans Saints	\N	\N	90
4393	4	Pittsburgh Steelers	\N	\N	108
4394	4	Houston Texans	\N	\N	105
4395	4	Houston Texans	\N	\N	105
4396	4	Pittsburgh Steelers	\N	\N	108
4397	4	Green Bay Packers	\N	\N	94
4398	4	Miami Dolphins	\N	\N	109
4399	4	Miami Dolphins	\N	\N	109
4400	4	Green Bay Packers	\N	\N	94
4401	4	Washington Commanders	\N	\N	85
4402	4	Cleveland Browns	\N	\N	107
4403	4	Cleveland Browns	\N	\N	107
4404	4	Washington Commanders	\N	\N	85
4405	4	Atlanta Falcons	\N	\N	88
4406	4	Tampa Bay Buccaneers	\N	\N	99
4407	4	Tampa Bay Buccaneers	\N	\N	99
4408	4	Atlanta Falcons	\N	\N	88
4409	4	Minnesota Vikings	\N	\N	111
4410	4	New York Giants	\N	\N	92
4411	4	New York Giants	\N	\N	92
4412	4	Minnesota Vikings	\N	\N	111
4413	4	Arizona Cardinals	\N	\N	112
4414	4	New York Jets	\N	\N	93
4415	4	New York Jets	\N	\N	93
4416	4	Arizona Cardinals	\N	\N	112
4417	4	Carolina Panthers	\N	\N	82
4418	4	Philadelphia Eagles	\N	\N	106
4419	4	Philadelphia Eagles	\N	\N	106
4420	4	Carolina Panthers	\N	\N	82
4421	4	Detroit Lions	\N	\N	95
4422	4	Cincinnati Bengals	\N	\N	98
4423	4	Cincinnati Bengals	\N	\N	98
4424	4	Detroit Lions	\N	\N	95
4425	4	Indianapolis Colts	\N	\N	104
4426	4	Baltimore Ravens	\N	\N	102
4427	4	Baltimore Ravens	\N	\N	102
4428	4	Indianapolis Colts	\N	\N	104
4429	4	Kansas City Chiefs	\N	\N	103
4430	4	Buffalo Bills	\N	\N	86
4431	4	Buffalo Bills	\N	\N	86
4432	4	Kansas City Chiefs	\N	\N	103
4433	4	Los Angeles Chargers	\N	\N	83
4434	4	Los Angeles Rams	\N	\N	81
4435	4	Los Angeles Rams	\N	\N	81
4436	4	Los Angeles Chargers	\N	\N	83
4437	4	Tennessee Titans	\N	\N	91
4438	4	Denver Broncos	\N	\N	97
4439	4	Denver Broncos	\N	\N	97
4440	4	Tennessee Titans	\N	\N	91
4441	4	New England Patriots	\N	\N	84
4442	4	Las Vegas Raiders	\N	\N	110
4443	4	Las Vegas Raiders	\N	\N	110
4444	4	New England Patriots	\N	\N	84
4445	4	Chicago Bears	\N	\N	101
4446	4	Seattle Seahawks	\N	\N	96
4447	4	Seattle Seahawks	\N	\N	96
4448	4	Chicago Bears	\N	\N	101
4449	4	Dallas Cowboys	\N	\N	89
4450	4	San Francisco 49ers	\N	\N	87
4451	4	San Francisco 49ers	\N	\N	87
4452	4	Dallas Cowboys	\N	\N	89
4453	4	New York Jets	\N	\N	93
4454	4	Seattle Seahawks	\N	\N	96
4455	4	Seattle Seahawks	\N	\N	96
4456	4	New York Jets	\N	\N	93
4457	4	Cleveland Browns	\N	\N	107
4458	4	Los Angeles Rams	\N	\N	81
4459	4	Los Angeles Rams	\N	\N	81
4460	4	Cleveland Browns	\N	\N	107
4461	4	Las Vegas Raiders	\N	\N	110
4462	4	Arizona Cardinals	\N	\N	112
4463	4	Arizona Cardinals	\N	\N	112
4464	4	Las Vegas Raiders	\N	\N	110
4465	4	New Orleans Saints	\N	\N	90
4466	4	Green Bay Packers	\N	\N	94
4467	4	Green Bay Packers	\N	\N	94
4468	4	New Orleans Saints	\N	\N	90
4469	4	Dallas Cowboys	\N	\N	89
4470	4	Pittsburgh Steelers	\N	\N	108
4471	4	Pittsburgh Steelers	\N	\N	108
4472	4	Dallas Cowboys	\N	\N	89
4473	4	Denver Broncos	\N	\N	97
4474	4	Chicago Bears	\N	\N	101
4475	4	Chicago Bears	\N	\N	101
4476	4	Denver Broncos	\N	\N	97
4477	4	Detroit Lions	\N	\N	95
4478	4	Houston Texans	\N	\N	105
4479	4	Houston Texans	\N	\N	105
4480	4	Detroit Lions	\N	\N	95
4481	4	San Francisco 49ers	\N	\N	87
4482	4	Minnesota Vikings	\N	\N	111
4483	4	Minnesota Vikings	\N	\N	111
4484	4	San Francisco 49ers	\N	\N	87
4485	4	Buffalo Bills	\N	\N	86
4486	4	Tampa Bay Buccaneers	\N	\N	99
4487	4	Tampa Bay Buccaneers	\N	\N	99
4488	4	Buffalo Bills	\N	\N	86
4489	4	Carolina Panthers	\N	\N	82
4490	4	Atlanta Falcons	\N	\N	88
4491	4	Atlanta Falcons	\N	\N	88
4492	4	Carolina Panthers	\N	\N	82
4493	4	Washington Commanders	\N	\N	85
4494	4	Philadelphia Eagles	\N	\N	106
4495	4	Philadelphia Eagles	\N	\N	106
4496	4	Washington Commanders	\N	\N	85
4497	4	New York Giants	\N	\N	92
4498	4	Jacksonville Jaguars	\N	\N	100
4499	4	Jacksonville Jaguars	\N	\N	100
4500	4	New York Giants	\N	\N	92
4501	4	Tennessee Titans	\N	\N	91
4502	4	Baltimore Ravens	\N	\N	102
4503	4	Baltimore Ravens	\N	\N	102
4504	4	Tennessee Titans	\N	\N	91
4505	4	New England Patriots	\N	\N	84
4506	4	Miami Dolphins	\N	\N	109
4507	4	Miami Dolphins	\N	\N	109
4508	4	New England Patriots	\N	\N	84
4509	4	Los Angeles Chargers	\N	\N	83
4510	4	Cincinnati Bengals	\N	\N	98
4511	4	Cincinnati Bengals	\N	\N	98
4512	4	Los Angeles Chargers	\N	\N	83
4513	4	Indianapolis Colts	\N	\N	104
4514	4	Kansas City Chiefs	\N	\N	103
4515	4	Kansas City Chiefs	\N	\N	103
4516	4	Indianapolis Colts	\N	\N	104
4517	4	Dallas Cowboys	\N	\N	89
4518	4	New York Jets	\N	\N	93
4519	4	New York Jets	\N	\N	93
4520	4	Dallas Cowboys	\N	\N	89
4521	4	Baltimore Ravens	\N	\N	102
4522	4	Los Angeles Chargers	\N	\N	83
4523	4	Los Angeles Chargers	\N	\N	83
4524	4	Baltimore Ravens	\N	\N	102
4525	4	Las Vegas Raiders	\N	\N	110
4526	4	Chicago Bears	\N	\N	101
4527	4	Chicago Bears	\N	\N	101
4528	4	Las Vegas Raiders	\N	\N	110
4529	4	Carolina Panthers	\N	\N	82
4530	4	Tennessee Titans	\N	\N	91
4531	4	Tennessee Titans	\N	\N	91
4532	4	Carolina Panthers	\N	\N	82
4533	4	New York Giants	\N	\N	92
4534	4	Indianapolis Colts	\N	\N	104
4535	4	Indianapolis Colts	\N	\N	104
4536	4	New York Giants	\N	\N	92
4537	4	Buffalo Bills	\N	\N	86
4538	4	Miami Dolphins	\N	\N	109
4539	4	Miami Dolphins	\N	\N	109
4540	4	Buffalo Bills	\N	\N	86
4541	4	Kansas City Chiefs	\N	\N	103
4542	4	Tampa Bay Buccaneers	\N	\N	99
4543	4	Tampa Bay Buccaneers	\N	\N	99
4544	4	Kansas City Chiefs	\N	\N	103
4545	4	Cleveland Browns	\N	\N	107
4546	4	Houston Texans	\N	\N	105
4547	4	Houston Texans	\N	\N	105
4548	4	Cleveland Browns	\N	\N	107
4549	4	Arizona Cardinals	\N	\N	112
4550	4	Philadelphia Eagles	\N	\N	106
4551	4	Philadelphia Eagles	\N	\N	106
4552	4	Arizona Cardinals	\N	\N	112
4553	4	Denver Broncos	\N	\N	97
4554	4	Jacksonville Jaguars	\N	\N	100
4555	4	Jacksonville Jaguars	\N	\N	100
4556	4	Denver Broncos	\N	\N	97
4557	4	Washington Commanders	\N	\N	85
4558	4	Minnesota Vikings	\N	\N	111
4559	4	Minnesota Vikings	\N	\N	111
4560	4	Washington Commanders	\N	\N	85
4561	4	Atlanta Falcons	\N	\N	88
4562	4	Cincinnati Bengals	\N	\N	98
4563	4	Cincinnati Bengals	\N	\N	98
4564	4	Atlanta Falcons	\N	\N	88
4565	4	San Francisco 49ers	\N	\N	87
4566	4	Green Bay Packers	\N	\N	94
4567	4	Green Bay Packers	\N	\N	94
4568	4	San Francisco 49ers	\N	\N	87
4569	4	Los Angeles Rams	\N	\N	81
4570	4	Detroit Lions	\N	\N	95
4571	4	Detroit Lions	\N	\N	95
4572	4	Los Angeles Rams	\N	\N	81
4573	4	New Orleans Saints	\N	\N	90
4574	4	New England Patriots	\N	\N	84
4575	4	New England Patriots	\N	\N	84
4576	4	New Orleans Saints	\N	\N	90
4577	4	Pittsburgh Steelers	\N	\N	108
4578	4	Seattle Seahawks	\N	\N	96
4579	4	Seattle Seahawks	\N	\N	96
4580	4	Pittsburgh Steelers	\N	\N	108
4581	4	Chicago Bears	\N	\N	101
4582	4	Arizona Cardinals	\N	\N	112
4583	4	Arizona Cardinals	\N	\N	112
4584	4	Chicago Bears	\N	\N	101
4585	4	Philadelphia Eagles	\N	\N	106
4586	4	New Orleans Saints	\N	\N	90
4587	4	New Orleans Saints	\N	\N	90
4588	4	Philadelphia Eagles	\N	\N	106
4589	4	Buffalo Bills	\N	\N	86
4590	4	Los Angeles Chargers	\N	\N	83
4591	4	Los Angeles Chargers	\N	\N	83
4592	4	Buffalo Bills	\N	\N	86
4593	4	Seattle Seahawks	\N	\N	96
4594	4	Indianapolis Colts	\N	\N	104
4595	4	Indianapolis Colts	\N	\N	104
4596	4	Seattle Seahawks	\N	\N	96
4597	4	Pittsburgh Steelers	\N	\N	108
4598	4	Kansas City Chiefs	\N	\N	103
4599	4	Kansas City Chiefs	\N	\N	103
4600	4	Pittsburgh Steelers	\N	\N	108
4601	4	Jacksonville Jaguars	\N	\N	100
4602	4	Houston Texans	\N	\N	105
4603	4	Houston Texans	\N	\N	105
4604	4	Jacksonville Jaguars	\N	\N	100
4605	4	Green Bay Packers	\N	\N	94
4606	4	Carolina Panthers	\N	\N	82
4607	4	Carolina Panthers	\N	\N	82
4608	4	Green Bay Packers	\N	\N	94
4609	4	Dallas Cowboys	\N	\N	89
4610	4	Miami Dolphins	\N	\N	109
4611	4	Miami Dolphins	\N	\N	109
4612	4	Dallas Cowboys	\N	\N	89
4613	4	Las Vegas Raiders	\N	\N	110
4614	4	New York Jets	\N	\N	93
4615	4	New York Jets	\N	\N	93
4616	4	Las Vegas Raiders	\N	\N	110
4617	4	Denver Broncos	\N	\N	97
4618	4	Detroit Lions	\N	\N	95
4619	4	Detroit Lions	\N	\N	95
4620	4	Denver Broncos	\N	\N	97
4621	4	Cincinnati Bengals	\N	\N	98
4622	4	New England Patriots	\N	\N	84
4623	4	New England Patriots	\N	\N	84
4624	4	Cincinnati Bengals	\N	\N	98
4625	4	Cleveland Browns	\N	\N	107
4626	4	San Francisco 49ers	\N	\N	87
4627	4	San Francisco 49ers	\N	\N	87
4628	4	Cleveland Browns	\N	\N	107
4629	4	Washington Commanders	\N	\N	85
4630	4	Tennessee Titans	\N	\N	91
4631	4	Tennessee Titans	\N	\N	91
4632	4	Washington Commanders	\N	\N	85
4633	4	New York Giants	\N	\N	92
4634	4	Los Angeles Rams	\N	\N	81
4635	4	Los Angeles Rams	\N	\N	81
4636	4	New York Giants	\N	\N	92
4637	4	Tampa Bay Buccaneers	\N	\N	99
4638	4	Minnesota Vikings	\N	\N	111
4639	4	Minnesota Vikings	\N	\N	111
4640	4	Tampa Bay Buccaneers	\N	\N	99
4641	4	Atlanta Falcons	\N	\N	88
4642	4	Baltimore Ravens	\N	\N	102
4643	4	Baltimore Ravens	\N	\N	102
4644	4	Atlanta Falcons	\N	\N	88
4645	4	New England Patriots	\N	\N	84
4646	4	New York Giants	\N	\N	92
4647	4	New York Giants	\N	\N	92
4648	4	New England Patriots	\N	\N	84
4649	4	Tennessee Titans	\N	\N	91
4650	4	Houston Texans	\N	\N	105
4651	4	Houston Texans	\N	\N	105
4652	4	Tennessee Titans	\N	\N	91
4653	4	Kansas City Chiefs	\N	\N	103
4654	4	Minnesota Vikings	\N	\N	111
4655	4	Minnesota Vikings	\N	\N	111
4656	4	Kansas City Chiefs	\N	\N	103
4657	4	San Francisco 49ers	\N	\N	87
4658	4	Cincinnati Bengals	\N	\N	98
4659	4	Cincinnati Bengals	\N	\N	98
4660	4	San Francisco 49ers	\N	\N	87
4661	4	Los Angeles Chargers	\N	\N	83
4662	4	Las Vegas Raiders	\N	\N	110
4663	4	Las Vegas Raiders	\N	\N	110
4664	4	Los Angeles Chargers	\N	\N	83
4665	4	Buffalo Bills	\N	\N	86
4666	4	Arizona Cardinals	\N	\N	112
4667	4	Arizona Cardinals	\N	\N	112
4668	4	Buffalo Bills	\N	\N	86
4669	4	Miami Dolphins	\N	\N	109
4670	4	Tampa Bay Buccaneers	\N	\N	99
4671	4	Tampa Bay Buccaneers	\N	\N	99
4672	4	Miami Dolphins	\N	\N	109
4673	4	Los Angeles Rams	\N	\N	81
4674	4	Carolina Panthers	\N	\N	82
4675	4	Carolina Panthers	\N	\N	82
4676	4	Los Angeles Rams	\N	\N	81
4677	4	New York Jets	\N	\N	93
4678	4	Cleveland Browns	\N	\N	107
4679	4	Cleveland Browns	\N	\N	107
4680	4	New York Jets	\N	\N	93
4681	4	Denver Broncos	\N	\N	97
4682	4	Indianapolis Colts	\N	\N	104
4683	4	Indianapolis Colts	\N	\N	104
4684	4	Denver Broncos	\N	\N	97
4685	4	Baltimore Ravens	\N	\N	102
4686	4	Seattle Seahawks	\N	\N	96
4687	4	Seattle Seahawks	\N	\N	96
4688	4	Baltimore Ravens	\N	\N	102
4689	4	Pittsburgh Steelers	\N	\N	108
4690	4	Washington Commanders	\N	\N	85
4691	4	Washington Commanders	\N	\N	85
4692	4	Pittsburgh Steelers	\N	\N	108
4693	4	Philadelphia Eagles	\N	\N	106
4694	4	Jacksonville Jaguars	\N	\N	100
4695	4	Jacksonville Jaguars	\N	\N	100
4696	4	Philadelphia Eagles	\N	\N	106
4697	4	New Orleans Saints	\N	\N	90
4698	4	Dallas Cowboys	\N	\N	89
4699	4	Dallas Cowboys	\N	\N	89
4700	4	New Orleans Saints	\N	\N	90
4701	4	Green Bay Packers	\N	\N	94
4702	4	Atlanta Falcons	\N	\N	88
4703	4	Atlanta Falcons	\N	\N	88
4704	4	Green Bay Packers	\N	\N	94
4705	4	Detroit Lions	\N	\N	95
4706	4	Chicago Bears	\N	\N	101
4707	4	Chicago Bears	\N	\N	101
4708	4	Detroit Lions	\N	\N	95
4709	4	Denver Broncos	\N	\N	97
4710	4	New York Giants	\N	\N	92
4711	4	New York Giants	\N	\N	92
4712	4	Denver Broncos	\N	\N	97
4713	4	Pittsburgh Steelers	\N	\N	108
4714	4	Buffalo Bills	\N	\N	86
4715	4	Buffalo Bills	\N	\N	86
4716	4	Pittsburgh Steelers	\N	\N	108
4717	4	New England Patriots	\N	\N	84
4718	4	Green Bay Packers	\N	\N	94
4719	4	Green Bay Packers	\N	\N	94
4720	4	New England Patriots	\N	\N	84
4721	4	Arizona Cardinals	\N	\N	112
4722	4	Los Angeles Rams	\N	\N	81
4723	4	Los Angeles Rams	\N	\N	81
4724	4	Arizona Cardinals	\N	\N	112
4725	4	Tennessee Titans	\N	\N	91
4726	4	Cleveland Browns	\N	\N	107
4727	4	Cleveland Browns	\N	\N	107
4728	4	Tennessee Titans	\N	\N	91
4729	4	Miami Dolphins	\N	\N	109
4730	4	Cincinnati Bengals	\N	\N	98
4731	4	Cincinnati Bengals	\N	\N	98
4732	4	Miami Dolphins	\N	\N	109
4733	4	Detroit Lions	\N	\N	95
4734	4	Kansas City Chiefs	\N	\N	103
4735	4	Kansas City Chiefs	\N	\N	103
4736	4	Detroit Lions	\N	\N	95
4737	4	Indianapolis Colts	\N	\N	104
4738	4	Houston Texans	\N	\N	105
4739	4	Houston Texans	\N	\N	105
4740	4	Indianapolis Colts	\N	\N	104
4741	4	New York Jets	\N	\N	93
4742	4	Baltimore Ravens	\N	\N	102
4743	4	Baltimore Ravens	\N	\N	102
4744	4	New York Jets	\N	\N	93
4745	4	Jacksonville Jaguars	\N	\N	100
4746	4	Los Angeles Chargers	\N	\N	83
4747	4	Los Angeles Chargers	\N	\N	83
4748	4	Jacksonville Jaguars	\N	\N	100
4749	4	San Francisco 49ers	\N	\N	87
4750	4	Chicago Bears	\N	\N	101
4751	4	Chicago Bears	\N	\N	101
4752	4	San Francisco 49ers	\N	\N	87
4753	4	Dallas Cowboys	\N	\N	89
4754	4	Washington Commanders	\N	\N	85
4755	4	Washington Commanders	\N	\N	85
4756	4	Dallas Cowboys	\N	\N	89
4757	4	Las Vegas Raiders	\N	\N	110
4758	4	New Orleans Saints	\N	\N	90
4759	4	New Orleans Saints	\N	\N	90
4760	4	Las Vegas Raiders	\N	\N	110
4761	4	Philadelphia Eagles	\N	\N	106
4762	4	Tampa Bay Buccaneers	\N	\N	99
4763	4	Tampa Bay Buccaneers	\N	\N	99
4764	4	Philadelphia Eagles	\N	\N	106
4765	4	Atlanta Falcons	\N	\N	88
4766	4	Seattle Seahawks	\N	\N	96
4767	4	Seattle Seahawks	\N	\N	96
4768	4	Atlanta Falcons	\N	\N	88
4769	4	Minnesota Vikings	\N	\N	111
4770	4	Carolina Panthers	\N	\N	82
4771	4	Carolina Panthers	\N	\N	82
4772	4	Minnesota Vikings	\N	\N	111
4773	4	Houston Texans	\N	\N	105
4774	4	Buffalo Bills	\N	\N	86
4775	4	Buffalo Bills	\N	\N	86
4776	4	Houston Texans	\N	\N	105
4777	4	Green Bay Packers	\N	\N	94
4778	4	Jacksonville Jaguars	\N	\N	100
4779	4	Jacksonville Jaguars	\N	\N	100
4780	4	Green Bay Packers	\N	\N	94
4781	4	Cincinnati Bengals	\N	\N	98
4782	4	Pittsburgh Steelers	\N	\N	108
4783	4	Pittsburgh Steelers	\N	\N	108
4784	4	Cincinnati Bengals	\N	\N	98
4785	4	Atlanta Falcons	\N	\N	88
4786	4	Kansas City Chiefs	\N	\N	103
4787	4	Kansas City Chiefs	\N	\N	103
4788	4	Atlanta Falcons	\N	\N	88
4789	4	Denver Broncos	\N	\N	97
4790	4	Washington Commanders	\N	\N	85
4791	4	Washington Commanders	\N	\N	85
4792	4	Denver Broncos	\N	\N	97
4793	4	Indianapolis Colts	\N	\N	104
4794	4	Tennessee Titans	\N	\N	91
4795	4	Tennessee Titans	\N	\N	91
4796	4	Indianapolis Colts	\N	\N	104
4797	4	Arizona Cardinals	\N	\N	112
4798	4	Minnesota Vikings	\N	\N	111
4799	4	Minnesota Vikings	\N	\N	111
4800	4	Arizona Cardinals	\N	\N	112
4801	4	New York Giants	\N	\N	92
4802	4	Chicago Bears	\N	\N	101
4803	4	Chicago Bears	\N	\N	101
4804	4	New York Giants	\N	\N	92
4805	4	Los Angeles Rams	\N	\N	81
4806	4	Tampa Bay Buccaneers	\N	\N	99
4807	4	Tampa Bay Buccaneers	\N	\N	99
4808	4	Los Angeles Rams	\N	\N	81
4809	4	Las Vegas Raiders	\N	\N	110
4810	4	Baltimore Ravens	\N	\N	102
4811	4	Baltimore Ravens	\N	\N	102
4812	4	Las Vegas Raiders	\N	\N	110
4813	4	Philadelphia Eagles	\N	\N	106
4814	4	San Francisco 49ers	\N	\N	87
4815	4	San Francisco 49ers	\N	\N	87
4816	4	Philadelphia Eagles	\N	\N	106
4817	4	Dallas Cowboys	\N	\N	89
4818	4	Carolina Panthers	\N	\N	82
4819	4	Carolina Panthers	\N	\N	82
4820	4	Dallas Cowboys	\N	\N	89
4821	4	Seattle Seahawks	\N	\N	96
4822	4	Miami Dolphins	\N	\N	109
4823	4	Miami Dolphins	\N	\N	109
4824	4	Seattle Seahawks	\N	\N	96
4825	4	New York Jets	\N	\N	93
4826	4	Detroit Lions	\N	\N	95
4827	4	Detroit Lions	\N	\N	95
4828	4	New York Jets	\N	\N	93
4829	4	New England Patriots	\N	\N	84
4830	4	Cleveland Browns	\N	\N	107
4831	4	Cleveland Browns	\N	\N	107
4832	4	New England Patriots	\N	\N	84
4833	4	Los Angeles Chargers	\N	\N	83
4834	4	New Orleans Saints	\N	\N	90
4835	4	New Orleans Saints	\N	\N	90
4836	4	Los Angeles Chargers	\N	\N	83
4837	4	Baltimore Ravens	\N	\N	102
4838	4	Cleveland Browns	\N	\N	107
4839	4	Cleveland Browns	\N	\N	107
4840	4	Baltimore Ravens	\N	\N	102
4841	4	Las Vegas Raiders	\N	\N	110
4842	4	Denver Broncos	\N	\N	97
4843	4	Denver Broncos	\N	\N	97
4844	4	Las Vegas Raiders	\N	\N	110
4845	4	Tampa Bay Buccaneers	\N	\N	99
4846	4	Houston Texans	\N	\N	105
4847	4	Houston Texans	\N	\N	105
4848	4	Tampa Bay Buccaneers	\N	\N	99
4849	4	Kansas City Chiefs	\N	\N	103
4850	4	Arizona Cardinals	\N	\N	112
4851	4	Arizona Cardinals	\N	\N	112
4852	4	Kansas City Chiefs	\N	\N	103
4853	4	Minnesota Vikings	\N	\N	111
4854	4	Indianapolis Colts	\N	\N	104
4855	4	Indianapolis Colts	\N	\N	104
4856	4	Minnesota Vikings	\N	\N	111
4857	4	Buffalo Bills	\N	\N	86
4858	4	New Orleans Saints	\N	\N	90
4859	4	New Orleans Saints	\N	\N	90
4860	4	Buffalo Bills	\N	\N	86
4861	4	New England Patriots	\N	\N	84
4862	4	San Francisco 49ers	\N	\N	87
4863	4	San Francisco 49ers	\N	\N	87
4864	4	New England Patriots	\N	\N	84
4865	4	New York Jets	\N	\N	93
4866	4	Jacksonville Jaguars	\N	\N	100
4867	4	Jacksonville Jaguars	\N	\N	100
4868	4	New York Jets	\N	\N	93
4869	4	Cincinnati Bengals	\N	\N	98
4870	4	Chicago Bears	\N	\N	101
4871	4	Chicago Bears	\N	\N	101
4872	4	Cincinnati Bengals	\N	\N	98
4873	4	Pittsburgh Steelers	\N	\N	108
4874	4	Los Angeles Rams	\N	\N	81
4875	4	Los Angeles Rams	\N	\N	81
4876	4	Pittsburgh Steelers	\N	\N	108
4877	4	Dallas Cowboys	\N	\N	89
4878	4	Seattle Seahawks	\N	\N	96
4879	4	Seattle Seahawks	\N	\N	96
4880	4	Dallas Cowboys	\N	\N	89
4881	4	Atlanta Falcons	\N	\N	88
4882	4	New York Giants	\N	\N	92
4883	4	New York Giants	\N	\N	92
4884	4	Atlanta Falcons	\N	\N	88
4885	4	Los Angeles Chargers	\N	\N	83
4886	4	Green Bay Packers	\N	\N	94
4887	4	Green Bay Packers	\N	\N	94
4888	4	Los Angeles Chargers	\N	\N	83
4889	4	Tennessee Titans	\N	\N	91
4890	4	Philadelphia Eagles	\N	\N	106
4891	4	Philadelphia Eagles	\N	\N	106
4892	4	Tennessee Titans	\N	\N	91
4893	4	Carolina Panthers	\N	\N	82
4894	4	Washington Commanders	\N	\N	85
4895	4	Washington Commanders	\N	\N	85
4896	4	Carolina Panthers	\N	\N	82
4897	4	Detroit Lions	\N	\N	95
4898	4	Miami Dolphins	\N	\N	109
4899	4	Miami Dolphins	\N	\N	109
4900	4	Detroit Lions	\N	\N	95
4901	4	San Francisco 49ers	\N	\N	87
4902	4	Buffalo Bills	\N	\N	86
4903	4	Buffalo Bills	\N	\N	86
4904	4	San Francisco 49ers	\N	\N	87
4905	4	Pittsburgh Steelers	\N	\N	108
4906	4	New York Giants	\N	\N	92
4907	4	New York Giants	\N	\N	92
4908	4	Pittsburgh Steelers	\N	\N	108
4909	4	Philadelphia Eagles	\N	\N	106
4910	4	Chicago Bears	\N	\N	101
4911	4	Chicago Bears	\N	\N	101
4912	4	Philadelphia Eagles	\N	\N	106
4913	4	Atlanta Falcons	\N	\N	88
4914	4	Indianapolis Colts	\N	\N	104
4915	4	Indianapolis Colts	\N	\N	104
4916	4	Atlanta Falcons	\N	\N	88
4917	4	Miami Dolphins	\N	\N	109
4918	4	Cleveland Browns	\N	\N	107
4919	4	Cleveland Browns	\N	\N	107
4920	4	Miami Dolphins	\N	\N	109
4921	4	Carolina Panthers	\N	\N	82
4922	4	Tampa Bay Buccaneers	\N	\N	99
4923	4	Tampa Bay Buccaneers	\N	\N	99
4924	4	Carolina Panthers	\N	\N	82
4925	4	Dallas Cowboys	\N	\N	89
4926	4	Arizona Cardinals	\N	\N	112
4927	4	Arizona Cardinals	\N	\N	112
4928	4	Dallas Cowboys	\N	\N	89
4929	4	Houston Texans	\N	\N	105
4930	4	Los Angeles Rams	\N	\N	81
4931	4	Los Angeles Rams	\N	\N	81
4932	4	Houston Texans	\N	\N	105
4933	4	New England Patriots	\N	\N	84
4934	4	Kansas City Chiefs	\N	\N	103
4935	4	Kansas City Chiefs	\N	\N	103
4936	4	New England Patriots	\N	\N	84
4937	4	Green Bay Packers	\N	\N	94
4938	4	Cincinnati Bengals	\N	\N	98
4939	4	Cincinnati Bengals	\N	\N	98
4940	4	Green Bay Packers	\N	\N	94
4941	4	Baltimore Ravens	\N	\N	102
4942	4	Washington Commanders	\N	\N	85
4943	4	Washington Commanders	\N	\N	85
4944	4	Baltimore Ravens	\N	\N	102
4945	4	Minnesota Vikings	\N	\N	111
4946	4	New York Jets	\N	\N	93
4947	4	New York Jets	\N	\N	93
4948	4	Minnesota Vikings	\N	\N	111
4949	4	Jacksonville Jaguars	\N	\N	100
4950	4	Las Vegas Raiders	\N	\N	110
4951	4	Las Vegas Raiders	\N	\N	110
4952	4	Jacksonville Jaguars	\N	\N	100
4953	4	Seattle Seahawks	\N	\N	96
4954	4	Detroit Lions	\N	\N	95
4955	4	Detroit Lions	\N	\N	95
4956	4	Seattle Seahawks	\N	\N	96
4957	4	Los Angeles Chargers	\N	\N	83
4958	4	Denver Broncos	\N	\N	97
4959	4	Denver Broncos	\N	\N	97
4960	4	Los Angeles Chargers	\N	\N	83
4961	4	New Orleans Saints	\N	\N	90
4962	4	Tennessee Titans	\N	\N	91
4963	4	Tennessee Titans	\N	\N	91
4964	4	New Orleans Saints	\N	\N	90
4965	4	Baltimore Ravens	\N	\N	102
4966	4	Pittsburgh Steelers	\N	\N	108
4967	4	Pittsburgh Steelers	\N	\N	108
4968	4	Baltimore Ravens	\N	\N	102
4969	4	Jacksonville Jaguars	\N	\N	100
4970	4	Miami Dolphins	\N	\N	109
4971	4	Miami Dolphins	\N	\N	109
4972	4	Jacksonville Jaguars	\N	\N	100
4973	4	Tennessee Titans	\N	\N	91
4974	4	Detroit Lions	\N	\N	95
4975	4	Detroit Lions	\N	\N	95
4976	4	Tennessee Titans	\N	\N	91
4977	4	Kansas City Chiefs	\N	\N	103
4978	4	Washington Commanders	\N	\N	85
4979	4	Washington Commanders	\N	\N	85
4980	4	Kansas City Chiefs	\N	\N	103
4981	4	Houston Texans	\N	\N	105
4982	4	Los Angeles Chargers	\N	\N	83
4983	4	Los Angeles Chargers	\N	\N	83
4984	4	Houston Texans	\N	\N	105
4985	4	Minnesota Vikings	\N	\N	111
4986	4	Atlanta Falcons	\N	\N	88
4987	4	Atlanta Falcons	\N	\N	88
4988	4	Minnesota Vikings	\N	\N	111
4989	4	New York Jets	\N	\N	93
4990	4	Tampa Bay Buccaneers	\N	\N	99
4991	4	Tampa Bay Buccaneers	\N	\N	99
4992	4	New York Jets	\N	\N	93
4993	4	San Francisco 49ers	\N	\N	87
4994	4	New Orleans Saints	\N	\N	90
4995	4	New Orleans Saints	\N	\N	90
4996	4	San Francisco 49ers	\N	\N	87
4997	4	Seattle Seahawks	\N	\N	96
4998	4	New England Patriots	\N	\N	84
4999	4	New England Patriots	\N	\N	84
5000	4	Seattle Seahawks	\N	\N	96
5001	4	Los Angeles Rams	\N	\N	81
5002	4	Las Vegas Raiders	\N	\N	110
5003	4	Las Vegas Raiders	\N	\N	110
5004	4	Los Angeles Rams	\N	\N	81
5005	4	Cleveland Browns	\N	\N	107
5006	4	New York Giants	\N	\N	92
5007	4	New York Giants	\N	\N	92
5008	4	Cleveland Browns	\N	\N	107
5009	4	Cincinnati Bengals	\N	\N	98
5010	4	Philadelphia Eagles	\N	\N	106
5011	4	Philadelphia Eagles	\N	\N	106
5012	4	Cincinnati Bengals	\N	\N	98
5013	4	Buffalo Bills	\N	\N	86
5014	4	Chicago Bears	\N	\N	101
5015	4	Chicago Bears	\N	\N	101
5016	4	Buffalo Bills	\N	\N	86
5017	4	Dallas Cowboys	\N	\N	89
5018	4	Denver Broncos	\N	\N	97
5019	4	Denver Broncos	\N	\N	97
5020	4	Dallas Cowboys	\N	\N	89
5021	4	Green Bay Packers	\N	\N	94
5022	4	Arizona Cardinals	\N	\N	112
5023	4	Arizona Cardinals	\N	\N	112
5024	4	Green Bay Packers	\N	\N	94
5025	4	Indianapolis Colts	\N	\N	104
5026	4	Carolina Panthers	\N	\N	82
5027	4	Carolina Panthers	\N	\N	82
5028	4	Indianapolis Colts	\N	\N	104
5029	4	New Orleans Saints	\N	\N	90
5030	4	Miami Dolphins	\N	\N	109
5031	4	Miami Dolphins	\N	\N	109
5032	4	New Orleans Saints	\N	\N	90
5033	4	Pittsburgh Steelers	\N	\N	108
5034	4	New England Patriots	\N	\N	84
5035	4	New England Patriots	\N	\N	84
5036	4	Pittsburgh Steelers	\N	\N	108
5037	4	Las Vegas Raiders	\N	\N	110
5038	4	Seattle Seahawks	\N	\N	96
5039	4	Seattle Seahawks	\N	\N	96
5040	4	Las Vegas Raiders	\N	\N	110
5041	4	Los Angeles Rams	\N	\N	81
5042	4	Tennessee Titans	\N	\N	91
5043	4	Tennessee Titans	\N	\N	91
5044	4	Los Angeles Rams	\N	\N	81
5045	4	Arizona Cardinals	\N	\N	112
5046	4	New York Giants	\N	\N	92
5047	4	New York Giants	\N	\N	92
5048	4	Arizona Cardinals	\N	\N	112
5049	4	Indianapolis Colts	\N	\N	104
5050	4	Detroit Lions	\N	\N	95
5051	4	Detroit Lions	\N	\N	95
5052	4	Indianapolis Colts	\N	\N	104
5053	4	Dallas Cowboys	\N	\N	89
5054	4	Minnesota Vikings	\N	\N	111
5055	4	Minnesota Vikings	\N	\N	111
5056	4	Dallas Cowboys	\N	\N	89
5057	4	Philadelphia Eagles	\N	\N	106
5058	4	Baltimore Ravens	\N	\N	102
5059	4	Baltimore Ravens	\N	\N	102
5060	4	Philadelphia Eagles	\N	\N	106
5061	4	Cleveland Browns	\N	\N	107
5062	4	Cincinnati Bengals	\N	\N	98
5063	4	Cincinnati Bengals	\N	\N	98
5064	4	Cleveland Browns	\N	\N	107
5065	4	Jacksonville Jaguars	\N	\N	100
5066	4	Buffalo Bills	\N	\N	86
5067	4	Buffalo Bills	\N	\N	86
5068	4	Jacksonville Jaguars	\N	\N	100
5069	4	Washington Commanders	\N	\N	85
5070	4	Tampa Bay Buccaneers	\N	\N	99
5071	4	Tampa Bay Buccaneers	\N	\N	99
5072	4	Washington Commanders	\N	\N	85
5073	4	San Francisco 49ers	\N	\N	87
5074	4	Denver Broncos	\N	\N	97
5075	4	Denver Broncos	\N	\N	97
5076	4	San Francisco 49ers	\N	\N	87
5077	4	Chicago Bears	\N	\N	101
5078	4	Kansas City Chiefs	\N	\N	103
5079	4	Kansas City Chiefs	\N	\N	103
5080	4	Chicago Bears	\N	\N	101
5081	4	Carolina Panthers	\N	\N	82
5082	4	Houston Texans	\N	\N	105
5083	4	Houston Texans	\N	\N	105
5084	4	Carolina Panthers	\N	\N	82
5085	4	Atlanta Falcons	\N	\N	88
5086	4	Los Angeles Chargers	\N	\N	83
5087	4	Los Angeles Chargers	\N	\N	83
5088	4	Atlanta Falcons	\N	\N	88
5089	4	New York Jets	\N	\N	93
5090	4	Green Bay Packers	\N	\N	94
5091	4	Green Bay Packers	\N	\N	94
5092	4	New York Jets	\N	\N	93
5093	4	Las Vegas Raiders	\N	\N	110
5094	4	Pittsburgh Steelers	\N	\N	108
5095	4	Pittsburgh Steelers	\N	\N	108
5096	4	Las Vegas Raiders	\N	\N	110
5097	4	Indianapolis Colts	\N	\N	104
5098	4	Dallas Cowboys	\N	\N	89
5099	4	Dallas Cowboys	\N	\N	89
5100	4	Indianapolis Colts	\N	\N	104
5101	4	Jacksonville Jaguars	\N	\N	100
5102	4	Minnesota Vikings	\N	\N	111
5103	4	Minnesota Vikings	\N	\N	111
5104	4	Jacksonville Jaguars	\N	\N	100
5105	4	Philadelphia Eagles	\N	\N	106
5106	4	Cleveland Browns	\N	\N	107
5107	4	Cleveland Browns	\N	\N	107
5108	4	Philadelphia Eagles	\N	\N	106
5109	4	Los Angeles Rams	\N	\N	81
5110	4	Kansas City Chiefs	\N	\N	103
5111	4	Kansas City Chiefs	\N	\N	103
5112	4	Los Angeles Rams	\N	\N	81
5113	4	San Francisco 49ers	\N	\N	87
5114	4	Houston Texans	\N	\N	105
5115	4	Houston Texans	\N	\N	105
5116	4	San Francisco 49ers	\N	\N	87
5117	4	Miami Dolphins	\N	\N	109
5118	4	Atlanta Falcons	\N	\N	88
5119	4	Atlanta Falcons	\N	\N	88
5120	4	Miami Dolphins	\N	\N	109
5121	4	Chicago Bears	\N	\N	101
5122	4	New England Patriots	\N	\N	84
5123	4	New England Patriots	\N	\N	84
5124	4	Chicago Bears	\N	\N	101
5125	4	Detroit Lions	\N	\N	95
5126	4	Los Angeles Chargers	\N	\N	83
5127	4	Los Angeles Chargers	\N	\N	83
5128	4	Detroit Lions	\N	\N	95
5129	4	Carolina Panthers	\N	\N	82
5130	4	New Orleans Saints	\N	\N	90
5131	4	New Orleans Saints	\N	\N	90
5132	4	Carolina Panthers	\N	\N	82
5133	4	Seattle Seahawks	\N	\N	96
5134	4	Green Bay Packers	\N	\N	94
5135	4	Green Bay Packers	\N	\N	94
5136	4	Seattle Seahawks	\N	\N	96
5137	4	New York Jets	\N	\N	93
5138	4	Washington Commanders	\N	\N	85
5139	4	Washington Commanders	\N	\N	85
5140	4	New York Jets	\N	\N	93
5141	4	Buffalo Bills	\N	\N	86
5142	4	Baltimore Ravens	\N	\N	102
5143	4	Baltimore Ravens	\N	\N	102
5144	4	Buffalo Bills	\N	\N	86
5145	4	Denver Broncos	\N	\N	97
5146	4	Tampa Bay Buccaneers	\N	\N	99
5147	4	Tampa Bay Buccaneers	\N	\N	99
5148	4	Denver Broncos	\N	\N	97
5149	4	New York Giants	\N	\N	92
5150	4	Cincinnati Bengals	\N	\N	98
5151	4	Cincinnati Bengals	\N	\N	98
5152	4	New York Giants	\N	\N	92
5153	4	Arizona Cardinals	\N	\N	112
5154	4	Tennessee Titans	\N	\N	91
5155	4	Tennessee Titans	\N	\N	91
5156	4	Arizona Cardinals	\N	\N	112
5157	4	Buffalo Bills	\N	\N	86
5158	4	Tennessee Titans	\N	\N	91
5159	4	Tennessee Titans	\N	\N	91
5160	4	Buffalo Bills	\N	\N	86
5161	4	Kansas City Chiefs	\N	\N	103
5162	4	Miami Dolphins	\N	\N	109
5163	4	Miami Dolphins	\N	\N	109
5164	4	Kansas City Chiefs	\N	\N	103
5165	4	Houston Texans	\N	\N	105
5166	4	Philadelphia Eagles	\N	\N	106
5167	4	Philadelphia Eagles	\N	\N	106
5168	4	Houston Texans	\N	\N	105
5169	4	New York Giants	\N	\N	92
5170	4	Las Vegas Raiders	\N	\N	110
5171	4	Las Vegas Raiders	\N	\N	110
5172	4	New York Giants	\N	\N	92
5173	4	Denver Broncos	\N	\N	97
5174	4	Minnesota Vikings	\N	\N	111
5175	4	Minnesota Vikings	\N	\N	111
5176	4	Denver Broncos	\N	\N	97
5177	4	Green Bay Packers	\N	\N	94
5178	4	Indianapolis Colts	\N	\N	104
5179	4	Indianapolis Colts	\N	\N	104
5180	4	Green Bay Packers	\N	\N	94
5181	4	Carolina Panthers	\N	\N	82
5182	4	New England Patriots	\N	\N	84
5183	4	New England Patriots	\N	\N	84
5184	4	Carolina Panthers	\N	\N	82
5185	4	Cincinnati Bengals	\N	\N	98
5186	4	Tampa Bay Buccaneers	\N	\N	99
5187	4	Tampa Bay Buccaneers	\N	\N	99
5188	4	Cincinnati Bengals	\N	\N	98
5189	4	New Orleans Saints	\N	\N	90
5190	4	Washington Commanders	\N	\N	85
5191	4	Washington Commanders	\N	\N	85
5192	4	New Orleans Saints	\N	\N	90
5193	4	Arizona Cardinals	\N	\N	112
5194	4	Pittsburgh Steelers	\N	\N	108
5195	4	Pittsburgh Steelers	\N	\N	108
5196	4	Arizona Cardinals	\N	\N	112
5197	4	Chicago Bears	\N	\N	101
5198	4	Baltimore Ravens	\N	\N	102
5199	4	Baltimore Ravens	\N	\N	102
5200	4	Chicago Bears	\N	\N	101
5201	4	San Francisco 49ers	\N	\N	87
5202	4	Jacksonville Jaguars	\N	\N	100
5203	4	Jacksonville Jaguars	\N	\N	100
5204	4	San Francisco 49ers	\N	\N	87
5205	4	Los Angeles Rams	\N	\N	81
5206	4	Dallas Cowboys	\N	\N	89
5207	4	Dallas Cowboys	\N	\N	89
5208	4	Los Angeles Rams	\N	\N	81
5209	4	Detroit Lions	\N	\N	95
5210	4	Atlanta Falcons	\N	\N	88
5211	4	Atlanta Falcons	\N	\N	88
5212	4	Detroit Lions	\N	\N	95
5213	4	Seattle Seahawks	\N	\N	96
5214	4	Cleveland Browns	\N	\N	107
5215	4	Cleveland Browns	\N	\N	107
5216	4	Seattle Seahawks	\N	\N	96
5217	4	New York Jets	\N	\N	93
5218	4	Los Angeles Chargers	\N	\N	83
5219	4	Los Angeles Chargers	\N	\N	83
5220	4	New York Jets	\N	\N	93
5221	4	Denver Broncos	\N	\N	97
5222	4	Carolina Panthers	\N	\N	82
5223	4	Carolina Panthers	\N	\N	82
5224	4	Denver Broncos	\N	\N	97
5225	4	Philadelphia Eagles	\N	\N	106
5226	4	Los Angeles Rams	\N	\N	81
5227	4	Los Angeles Rams	\N	\N	81
5228	4	Philadelphia Eagles	\N	\N	106
5229	4	New Orleans Saints	\N	\N	90
5230	4	Indianapolis Colts	\N	\N	104
5231	4	Indianapolis Colts	\N	\N	104
5232	4	New Orleans Saints	\N	\N	90
5233	4	San Francisco 49ers	\N	\N	87
5234	4	Baltimore Ravens	\N	\N	102
5235	4	Baltimore Ravens	\N	\N	102
5236	4	San Francisco 49ers	\N	\N	87
5237	4	Atlanta Falcons	\N	\N	88
5238	4	Las Vegas Raiders	\N	\N	110
5239	4	Las Vegas Raiders	\N	\N	110
5240	4	Atlanta Falcons	\N	\N	88
5241	4	Green Bay Packers	\N	\N	94
5242	4	Buffalo Bills	\N	\N	86
5243	4	Buffalo Bills	\N	\N	86
5244	4	Green Bay Packers	\N	\N	94
5245	4	Tampa Bay Buccaneers	\N	\N	99
5246	4	Cleveland Browns	\N	\N	107
5247	4	Cleveland Browns	\N	\N	107
5248	4	Tampa Bay Buccaneers	\N	\N	99
5249	4	Minnesota Vikings	\N	\N	111
5250	4	Chicago Bears	\N	\N	101
5251	4	Chicago Bears	\N	\N	101
5252	4	Minnesota Vikings	\N	\N	111
5253	4	Detroit Lions	\N	\N	95
5254	4	New England Patriots	\N	\N	84
5255	4	New England Patriots	\N	\N	84
5256	4	Detroit Lions	\N	\N	95
5257	4	Tennessee Titans	\N	\N	91
5258	4	New York Giants	\N	\N	92
5259	4	New York Giants	\N	\N	92
5260	4	Tennessee Titans	\N	\N	91
5261	4	Arizona Cardinals	\N	\N	112
5262	4	Washington Commanders	\N	\N	85
5263	4	Washington Commanders	\N	\N	85
5264	4	Arizona Cardinals	\N	\N	112
5265	4	Dallas Cowboys	\N	\N	89
5266	4	Jacksonville Jaguars	\N	\N	100
5267	4	Jacksonville Jaguars	\N	\N	100
5268	4	Dallas Cowboys	\N	\N	89
5269	4	Houston Texans	\N	\N	105
5270	4	Miami Dolphins	\N	\N	109
5271	4	Miami Dolphins	\N	\N	109
5272	4	Houston Texans	\N	\N	105
5273	4	Seattle Seahawks	\N	\N	96
5274	4	Kansas City Chiefs	\N	\N	103
5275	4	Kansas City Chiefs	\N	\N	103
5276	4	Seattle Seahawks	\N	\N	96
5277	4	Pittsburgh Steelers	\N	\N	108
5278	4	Los Angeles Chargers	\N	\N	83
5279	4	Los Angeles Chargers	\N	\N	83
5280	4	Pittsburgh Steelers	\N	\N	108
5281	4	New York Jets	\N	\N	93
5282	4	Cincinnati Bengals	\N	\N	98
5283	4	Cincinnati Bengals	\N	\N	98
5284	4	New York Jets	\N	\N	93
5285	4	Kansas City Chiefs	\N	\N	103
5286	4	New York Giants	\N	\N	92
5287	4	New York Giants	\N	\N	92
5288	4	Kansas City Chiefs	\N	\N	103
5289	4	Baltimore Ravens	\N	\N	102
5290	4	Los Angeles Rams	\N	\N	81
5291	4	Los Angeles Rams	\N	\N	81
5292	4	Baltimore Ravens	\N	\N	102
5293	4	New Orleans Saints	\N	\N	90
5294	4	Denver Broncos	\N	\N	97
5295	4	Denver Broncos	\N	\N	97
5296	4	New Orleans Saints	\N	\N	90
5297	4	Miami Dolphins	\N	\N	109
5298	4	Pittsburgh Steelers	\N	\N	108
5299	4	Pittsburgh Steelers	\N	\N	108
5300	4	Miami Dolphins	\N	\N	109
5301	4	Atlanta Falcons	\N	\N	88
5302	4	New England Patriots	\N	\N	84
5303	4	New England Patriots	\N	\N	84
5304	4	Atlanta Falcons	\N	\N	88
5305	4	Indianapolis Colts	\N	\N	104
5306	4	Jacksonville Jaguars	\N	\N	100
5307	4	Jacksonville Jaguars	\N	\N	100
5308	4	Indianapolis Colts	\N	\N	104
5309	4	Philadelphia Eagles	\N	\N	106
5310	4	Green Bay Packers	\N	\N	94
5311	4	Green Bay Packers	\N	\N	94
5312	4	Philadelphia Eagles	\N	\N	106
5313	4	Dallas Cowboys	\N	\N	89
5314	4	Cincinnati Bengals	\N	\N	98
5315	4	Cincinnati Bengals	\N	\N	98
5316	4	Dallas Cowboys	\N	\N	89
5317	4	Los Angeles Chargers	\N	\N	83
5318	4	Washington Commanders	\N	\N	85
5319	4	Washington Commanders	\N	\N	85
5320	4	Los Angeles Chargers	\N	\N	83
5321	4	Tampa Bay Buccaneers	\N	\N	99
5322	4	Chicago Bears	\N	\N	101
5323	4	Chicago Bears	\N	\N	101
5324	4	Tampa Bay Buccaneers	\N	\N	99
5325	4	San Francisco 49ers	\N	\N	87
5326	4	Carolina Panthers	\N	\N	82
5327	4	Carolina Panthers	\N	\N	82
5328	4	San Francisco 49ers	\N	\N	87
5329	4	Seattle Seahawks	\N	\N	96
5330	4	Arizona Cardinals	\N	\N	112
5331	4	Arizona Cardinals	\N	\N	112
5332	4	Seattle Seahawks	\N	\N	96
5333	4	Cleveland Browns	\N	\N	107
5334	4	Detroit Lions	\N	\N	95
5335	4	Detroit Lions	\N	\N	95
5336	4	Cleveland Browns	\N	\N	107
5337	4	Buffalo Bills	\N	\N	86
5338	4	Las Vegas Raiders	\N	\N	110
5339	4	Las Vegas Raiders	\N	\N	110
5340	4	Buffalo Bills	\N	\N	86
5341	4	New York Jets	\N	\N	93
5342	4	Houston Texans	\N	\N	105
5343	4	Houston Texans	\N	\N	105
5344	4	New York Jets	\N	\N	93
5345	4	Tennessee Titans	\N	\N	91
5346	4	Minnesota Vikings	\N	\N	111
5347	4	Minnesota Vikings	\N	\N	111
5348	4	Tennessee Titans	\N	\N	91
5349	4	Tampa Bay Buccaneers	\N	\N	99
5350	4	New England Patriots	\N	\N	84
5351	4	New England Patriots	\N	\N	84
5352	4	Tampa Bay Buccaneers	\N	\N	99
5353	4	Baltimore Ravens	\N	\N	102
5354	4	Houston Texans	\N	\N	105
5355	4	Houston Texans	\N	\N	105
5356	4	Baltimore Ravens	\N	\N	102
5357	4	Atlanta Falcons	\N	\N	88
5358	4	Los Angeles Rams	\N	\N	81
5359	4	Los Angeles Rams	\N	\N	81
5360	4	Atlanta Falcons	\N	\N	88
5361	4	Los Angeles Chargers	\N	\N	83
5362	4	Cleveland Browns	\N	\N	107
5363	4	Cleveland Browns	\N	\N	107
5364	4	Los Angeles Chargers	\N	\N	83
5365	4	Seattle Seahawks	\N	\N	96
5366	4	Tennessee Titans	\N	\N	91
5367	4	Tennessee Titans	\N	\N	91
5368	4	Seattle Seahawks	\N	\N	96
5369	4	Minnesota Vikings	\N	\N	111
5370	4	Cincinnati Bengals	\N	\N	98
5371	4	Cincinnati Bengals	\N	\N	98
5372	4	Minnesota Vikings	\N	\N	111
5373	4	New York Giants	\N	\N	92
5374	4	Carolina Panthers	\N	\N	82
5375	4	Carolina Panthers	\N	\N	82
5376	4	New York Giants	\N	\N	92
5377	4	Pittsburgh Steelers	\N	\N	108
5378	4	San Francisco 49ers	\N	\N	87
5379	4	San Francisco 49ers	\N	\N	87
5380	4	Pittsburgh Steelers	\N	\N	108
5381	4	Chicago Bears	\N	\N	101
5382	4	Jacksonville Jaguars	\N	\N	100
5383	4	Jacksonville Jaguars	\N	\N	100
5384	4	Chicago Bears	\N	\N	101
5385	4	Indianapolis Colts	\N	\N	104
5386	4	Arizona Cardinals	\N	\N	112
5387	4	Arizona Cardinals	\N	\N	112
5388	4	Indianapolis Colts	\N	\N	104
5389	4	Washington Commanders	\N	\N	85
5390	4	Buffalo Bills	\N	\N	86
5391	4	Buffalo Bills	\N	\N	86
5392	4	Washington Commanders	\N	\N	85
5393	4	Las Vegas Raiders	\N	\N	110
5394	4	Green Bay Packers	\N	\N	94
5395	4	Green Bay Packers	\N	\N	94
5396	4	Las Vegas Raiders	\N	\N	110
5397	4	Dallas Cowboys	\N	\N	89
5398	4	Kansas City Chiefs	\N	\N	103
5399	4	Kansas City Chiefs	\N	\N	103
5400	4	Dallas Cowboys	\N	\N	89
5401	4	New Orleans Saints	\N	\N	90
5402	4	Detroit Lions	\N	\N	95
5403	4	Detroit Lions	\N	\N	95
5404	4	New Orleans Saints	\N	\N	90
5405	4	New York Jets	\N	\N	93
5406	4	Miami Dolphins	\N	\N	109
5407	4	Miami Dolphins	\N	\N	109
5408	4	New York Jets	\N	\N	93
5409	4	Philadelphia Eagles	\N	\N	106
5410	4	Denver Broncos	\N	\N	97
5411	4	Denver Broncos	\N	\N	97
5412	4	Philadelphia Eagles	\N	\N	106
5413	4	Tampa Bay Buccaneers	\N	\N	99
5414	4	Jacksonville Jaguars	\N	\N	100
5415	4	Jacksonville Jaguars	\N	\N	100
5416	4	Tampa Bay Buccaneers	\N	\N	99
5417	4	Las Vegas Raiders	\N	\N	110
5418	4	Cincinnati Bengals	\N	\N	98
5419	4	Cincinnati Bengals	\N	\N	98
5420	4	Las Vegas Raiders	\N	\N	110
5421	4	Carolina Panthers	\N	\N	82
5422	4	Pittsburgh Steelers	\N	\N	108
5423	4	Pittsburgh Steelers	\N	\N	108
5424	4	Carolina Panthers	\N	\N	82
5425	4	Miami Dolphins	\N	\N	109
5426	4	San Francisco 49ers	\N	\N	87
5427	4	San Francisco 49ers	\N	\N	87
5428	4	Miami Dolphins	\N	\N	109
5429	4	Washington Commanders	\N	\N	85
5430	4	Seattle Seahawks	\N	\N	96
5431	4	Seattle Seahawks	\N	\N	96
5432	4	Washington Commanders	\N	\N	85
5433	4	Buffalo Bills	\N	\N	86
5434	4	Detroit Lions	\N	\N	95
5435	4	Detroit Lions	\N	\N	95
5436	4	Buffalo Bills	\N	\N	86
5437	4	Philadelphia Eagles	\N	\N	106
5438	4	Atlanta Falcons	\N	\N	88
5439	4	Atlanta Falcons	\N	\N	88
5440	4	Philadelphia Eagles	\N	\N	106
5441	4	Los Angeles Rams	\N	\N	81
5442	4	Indianapolis Colts	\N	\N	104
5443	4	Indianapolis Colts	\N	\N	104
5444	4	Los Angeles Rams	\N	\N	81
5445	4	Minnesota Vikings	\N	\N	111
5446	4	Los Angeles Chargers	\N	\N	83
5447	4	Los Angeles Chargers	\N	\N	83
5448	4	Minnesota Vikings	\N	\N	111
5449	4	Green Bay Packers	\N	\N	94
5450	4	Baltimore Ravens	\N	\N	102
5451	4	Baltimore Ravens	\N	\N	102
5452	4	Green Bay Packers	\N	\N	94
5453	4	New York Giants	\N	\N	92
5454	4	New Orleans Saints	\N	\N	90
5455	4	New Orleans Saints	\N	\N	90
5456	4	New York Giants	\N	\N	92
5457	4	New England Patriots	\N	\N	84
5458	4	Arizona Cardinals	\N	\N	112
5459	4	Arizona Cardinals	\N	\N	112
5460	4	New England Patriots	\N	\N	84
5461	4	Tennessee Titans	\N	\N	91
5462	4	Chicago Bears	\N	\N	101
5463	4	Chicago Bears	\N	\N	101
5464	4	Tennessee Titans	\N	\N	91
5465	4	Cleveland Browns	\N	\N	107
5466	4	Dallas Cowboys	\N	\N	89
5467	4	Dallas Cowboys	\N	\N	89
5468	4	Cleveland Browns	\N	\N	107
5469	4	Denver Broncos	\N	\N	97
5470	4	Houston Texans	\N	\N	105
5471	4	Houston Texans	\N	\N	105
5472	4	Denver Broncos	\N	\N	97
5473	4	New York Jets	\N	\N	93
5474	4	Kansas City Chiefs	\N	\N	103
5475	4	Kansas City Chiefs	\N	\N	103
5476	4	New York Jets	\N	\N	93
5477	4	New Orleans Saints	\N	\N	90
5478	4	Arizona Cardinals	\N	\N	112
5479	4	Arizona Cardinals	\N	\N	112
5480	4	New Orleans Saints	\N	\N	90
5481	4	New York Jets	\N	\N	93
5482	4	San Francisco 49ers	\N	\N	87
5483	4	San Francisco 49ers	\N	\N	87
5484	4	New York Jets	\N	\N	93
5485	4	Los Angeles Chargers	\N	\N	83
5486	4	New England Patriots	\N	\N	84
5487	4	New England Patriots	\N	\N	84
5488	4	Los Angeles Chargers	\N	\N	83
5489	4	Cleveland Browns	\N	\N	107
5490	4	Indianapolis Colts	\N	\N	104
5491	4	Indianapolis Colts	\N	\N	104
5492	4	Cleveland Browns	\N	\N	107
5493	4	Kansas City Chiefs	\N	\N	103
5494	4	Tennessee Titans	\N	\N	91
5495	4	Tennessee Titans	\N	\N	91
5496	4	Kansas City Chiefs	\N	\N	103
5497	4	Washington Commanders	\N	\N	85
5498	4	Las Vegas Raiders	\N	\N	110
5499	4	Las Vegas Raiders	\N	\N	110
5500	4	Washington Commanders	\N	\N	85
5501	4	Carolina Panthers	\N	\N	82
5502	4	Chicago Bears	\N	\N	101
5503	4	Chicago Bears	\N	\N	101
5504	4	Carolina Panthers	\N	\N	82
5505	4	Baltimore Ravens	\N	\N	102
5506	4	Cincinnati Bengals	\N	\N	98
5507	4	Cincinnati Bengals	\N	\N	98
5508	4	Baltimore Ravens	\N	\N	102
5509	4	Denver Broncos	\N	\N	97
5510	4	Atlanta Falcons	\N	\N	88
5511	4	Atlanta Falcons	\N	\N	88
5512	4	Denver Broncos	\N	\N	97
5513	4	Tampa Bay Buccaneers	\N	\N	99
5514	4	Pittsburgh Steelers	\N	\N	108
5515	4	Pittsburgh Steelers	\N	\N	108
5516	4	Tampa Bay Buccaneers	\N	\N	99
5517	4	Jacksonville Jaguars	\N	\N	100
5518	4	Los Angeles Rams	\N	\N	81
5519	4	Los Angeles Rams	\N	\N	81
5520	4	Jacksonville Jaguars	\N	\N	100
5521	4	New York Giants	\N	\N	92
5522	4	Houston Texans	\N	\N	105
5523	4	Houston Texans	\N	\N	105
5524	4	New York Giants	\N	\N	92
5525	4	Miami Dolphins	\N	\N	109
5526	4	Minnesota Vikings	\N	\N	111
5527	4	Minnesota Vikings	\N	\N	111
5528	4	Miami Dolphins	\N	\N	109
5529	4	Philadelphia Eagles	\N	\N	106
5530	4	Detroit Lions	\N	\N	95
5531	4	Detroit Lions	\N	\N	95
5532	4	Philadelphia Eagles	\N	\N	106
5533	4	Buffalo Bills	\N	\N	86
5534	4	Seattle Seahawks	\N	\N	96
5535	4	Seattle Seahawks	\N	\N	96
5536	4	Buffalo Bills	\N	\N	86
5537	4	Green Bay Packers	\N	\N	94
5538	4	Dallas Cowboys	\N	\N	89
5539	4	Dallas Cowboys	\N	\N	89
5540	4	Green Bay Packers	\N	\N	94
5541	4	Las Vegas Raiders	\N	\N	110
5542	4	Carolina Panthers	\N	\N	82
5543	4	Carolina Panthers	\N	\N	82
5544	4	Las Vegas Raiders	\N	\N	110
5545	4	Denver Broncos	\N	\N	97
5546	4	Pittsburgh Steelers	\N	\N	108
5547	4	Pittsburgh Steelers	\N	\N	108
5548	4	Denver Broncos	\N	\N	97
5549	4	New York Giants	\N	\N	92
5550	4	Los Angeles Chargers	\N	\N	83
5551	4	Los Angeles Chargers	\N	\N	83
5552	4	New York Giants	\N	\N	92
5553	4	Arizona Cardinals	\N	\N	112
5554	4	Cleveland Browns	\N	\N	107
5555	4	Cleveland Browns	\N	\N	107
5556	4	Arizona Cardinals	\N	\N	112
5557	4	Dallas Cowboys	\N	\N	89
5558	4	Tampa Bay Buccaneers	\N	\N	99
5559	4	Tampa Bay Buccaneers	\N	\N	99
5560	4	Dallas Cowboys	\N	\N	89
5561	4	Cincinnati Bengals	\N	\N	98
5562	4	Jacksonville Jaguars	\N	\N	100
5563	4	Jacksonville Jaguars	\N	\N	100
5564	4	Cincinnati Bengals	\N	\N	98
5565	4	Atlanta Falcons	\N	\N	88
5566	4	Houston Texans	\N	\N	105
5567	4	Houston Texans	\N	\N	105
5568	4	Atlanta Falcons	\N	\N	88
5569	4	Seattle Seahawks	\N	\N	96
5570	4	Los Angeles Rams	\N	\N	81
5571	4	Los Angeles Rams	\N	\N	81
5572	4	Seattle Seahawks	\N	\N	96
5573	4	New York Jets	\N	\N	93
5574	4	Indianapolis Colts	\N	\N	104
5575	4	Indianapolis Colts	\N	\N	104
5576	4	New York Jets	\N	\N	93
5577	4	Minnesota Vikings	\N	\N	111
5578	4	Detroit Lions	\N	\N	95
5579	4	Detroit Lions	\N	\N	95
5580	4	Minnesota Vikings	\N	\N	111
5581	4	Philadelphia Eagles	\N	\N	106
5582	4	Kansas City Chiefs	\N	\N	103
5583	4	Kansas City Chiefs	\N	\N	103
5584	4	Philadelphia Eagles	\N	\N	106
5585	4	Washington Commanders	\N	\N	85
5586	4	San Francisco 49ers	\N	\N	87
5587	4	San Francisco 49ers	\N	\N	87
5588	4	Washington Commanders	\N	\N	85
5589	4	Tennessee Titans	\N	\N	91
5590	4	Green Bay Packers	\N	\N	94
5591	4	Green Bay Packers	\N	\N	94
5592	4	Tennessee Titans	\N	\N	91
5593	4	Chicago Bears	\N	\N	101
5594	4	Miami Dolphins	\N	\N	109
5595	4	Miami Dolphins	\N	\N	109
5596	4	Chicago Bears	\N	\N	101
5597	4	Buffalo Bills	\N	\N	86
5598	4	New England Patriots	\N	\N	84
5599	4	New England Patriots	\N	\N	84
5600	4	Buffalo Bills	\N	\N	86
5601	4	New Orleans Saints	\N	\N	90
5602	4	Baltimore Ravens	\N	\N	102
5603	4	Baltimore Ravens	\N	\N	102
5604	4	New Orleans Saints	\N	\N	90
2	1	Milorad	\N	\N	1
\.


--
-- Data for Name: tournament; Type: TABLE DATA; Schema: public; Owner: sofa
--

COPY public.tournament (id, sport_id, country_id, name, slug, external_id) FROM stdin;
1	1	1	Premier League	premier-league	1
2	1	2	HNL	hnl	2
3	1	3	LaLiga	laliga	3
4	2	4	NBA	nba	4
5	3	4	NFL	nfl	5
\.


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.country_id_seq', 62, true);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.event_id_seq', 2802, true);


--
-- Name: incident_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.incident_id_seq', 1, false);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.player_id_seq', 1, false);


--
-- Name: score_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.score_id_seq', 5604, true);


--
-- Name: sport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.sport_id_seq', 3, true);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.team_id_seq', 5604, true);


--
-- Name: tournament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sofa
--

SELECT pg_catalog.setval('public.tournament_id_seq', 5, true);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: incident incident_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- Name: score score_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT score_pkey PRIMARY KEY (id);


--
-- Name: sport sport_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: tournament tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pkey PRIMARY KEY (id);


--
-- Name: idx_3bae0aa733d1a3e7; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_3bae0aa733d1a3e7 ON public.event USING btree (tournament_id);


--
-- Name: idx_3bae0aa745185d02; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_3bae0aa745185d02 ON public.event USING btree (away_team_id);


--
-- Name: idx_3bae0aa777eef35c; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_3bae0aa777eef35c ON public.event USING btree (home_score_id);


--
-- Name: idx_3bae0aa79c4c13f6; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_3bae0aa79c4c13f6 ON public.event USING btree (home_team_id);


--
-- Name: idx_3bae0aa7cde79117; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_3bae0aa7cde79117 ON public.event USING btree (away_score_id);


--
-- Name: idx_3d03a11a99e6f5df; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_3d03a11a99e6f5df ON public.incident USING btree (player_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_98197a65f92f3e70; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_98197a65f92f3e70 ON public.player USING btree (country_id);


--
-- Name: idx_bd5fb8d9ac78bcf8; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_bd5fb8d9ac78bcf8 ON public.tournament USING btree (sport_id);


--
-- Name: idx_bd5fb8d9f92f3e70; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_bd5fb8d9f92f3e70 ON public.tournament USING btree (country_id);


--
-- Name: idx_c4e0a61ff92f3e70; Type: INDEX; Schema: public; Owner: sofa
--

CREATE INDEX idx_c4e0a61ff92f3e70 ON public.team USING btree (country_id);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: sofa
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: event fk_3bae0aa733d1a3e7; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_3bae0aa733d1a3e7 FOREIGN KEY (tournament_id) REFERENCES public.tournament(id);


--
-- Name: event fk_3bae0aa745185d02; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_3bae0aa745185d02 FOREIGN KEY (away_team_id) REFERENCES public.team(id);


--
-- Name: event fk_3bae0aa777eef35c; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_3bae0aa777eef35c FOREIGN KEY (home_score_id) REFERENCES public.score(id);


--
-- Name: event fk_3bae0aa79c4c13f6; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_3bae0aa79c4c13f6 FOREIGN KEY (home_team_id) REFERENCES public.team(id);


--
-- Name: event fk_3bae0aa7cde79117; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_3bae0aa7cde79117 FOREIGN KEY (away_score_id) REFERENCES public.score(id);


--
-- Name: incident fk_3d03a11a99e6f5df; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT fk_3d03a11a99e6f5df FOREIGN KEY (player_id) REFERENCES public.player(id);


--
-- Name: player fk_98197a65f92f3e70; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT fk_98197a65f92f3e70 FOREIGN KEY (country_id) REFERENCES public.country(id);


--
-- Name: tournament fk_bd5fb8d9ac78bcf8; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT fk_bd5fb8d9ac78bcf8 FOREIGN KEY (sport_id) REFERENCES public.sport(id);


--
-- Name: tournament fk_bd5fb8d9f92f3e70; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT fk_bd5fb8d9f92f3e70 FOREIGN KEY (country_id) REFERENCES public.country(id);


--
-- Name: team fk_c4e0a61ff92f3e70; Type: FK CONSTRAINT; Schema: public; Owner: sofa
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT fk_c4e0a61ff92f3e70 FOREIGN KEY (country_id) REFERENCES public.country(id);


--
-- PostgreSQL database dump complete
--

