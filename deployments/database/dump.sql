--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.3

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

DROP DATABASE IF EXISTS go_ads_server;
--
-- Name: go_ads_server; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE go_ads_server WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE go_ads_server OWNER TO postgres;

\connect go_ads_server

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
-- Name: campaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaigns (
    id integer NOT NULL,
    price double precision,
    redirect_url text
);


ALTER TABLE public.campaigns OWNER TO postgres;

--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campaigns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaigns_id_seq OWNER TO postgres;

--
-- Name: campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campaigns_id_seq OWNED BY public.campaigns.id;


--
-- Name: campaigns_targetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaigns_targetings (
    campaign_id integer,
    targeting_id integer
);


ALTER TABLE public.campaigns_targetings OWNER TO postgres;

--
-- Name: targetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.targetings (
    id integer NOT NULL,
    country_code character(2),
    browser text
);


ALTER TABLE public.targetings OWNER TO postgres;

--
-- Name: targetings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.targetings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.targetings_id_seq OWNER TO postgres;

--
-- Name: targetings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.targetings_id_seq OWNED BY public.targetings.id;


--
-- Name: campaigns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN id SET DEFAULT nextval('public.campaigns_id_seq'::regclass);


--
-- Name: targetings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.targetings ALTER COLUMN id SET DEFAULT nextval('public.targetings_id_seq'::regclass);


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.campaigns (id, price, redirect_url) VALUES (8, 234, 'https://telegram.com');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (2, 412, 'https://yandex.ru');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (4, 134, 'https://hh.ru');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (6, 687, 'https://example.com');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (5, 2345, 'https://github.com/bobisdacool1');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (7, 76, 'https://vk.com');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (1, 12, 'https://google.com');
INSERT INTO public.campaigns (id, price, redirect_url) VALUES (3, 543, 'https://vimmy.com');


--
-- Data for Name: campaigns_targetings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (1, 2);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (2, 1);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (3, 2);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (4, 1);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (1, 1);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (1, 3);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (1, 2);
INSERT INTO public.campaigns_targetings (campaign_id, targeting_id) VALUES (3, 1);


--
-- Data for Name: targetings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.targetings (id, country_code, browser) VALUES (1, 'ru', 'Chrome');
INSERT INTO public.targetings (id, country_code, browser) VALUES (2, 'en', 'Firefox');
INSERT INTO public.targetings (id, country_code, browser) VALUES (3, 'kz', NULL);


--
-- Name: campaigns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaigns_id_seq', 1, false);


--
-- Name: targetings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.targetings_id_seq', 3, true);


--
-- Name: campaigns campaigns_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pk PRIMARY KEY (id);


--
-- Name: targetings targetings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.targetings
    ADD CONSTRAINT targetings_pk PRIMARY KEY (id);


--
-- Name: campaigns_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX campaigns_id_uindex ON public.campaigns USING btree (id);


--
-- Name: targetings_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX targetings_id_uindex ON public.targetings USING btree (id);


--
-- Name: campaigns_targetings fk_campaign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns_targetings
    ADD CONSTRAINT fk_campaign FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id) ON DELETE CASCADE;


--
-- Name: campaigns_targetings fk_targeting; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns_targetings
    ADD CONSTRAINT fk_targeting FOREIGN KEY (targeting_id) REFERENCES public.targetings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

