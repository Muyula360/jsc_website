--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Homebrew)
-- Dumped by pg_dump version 14.18 (Homebrew)

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
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO userdb;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.announcements (
    "announcementID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "announcementTitle" character varying(225) NOT NULL,
    "announcementDesc" text NOT NULL,
    "hasAttachment" integer DEFAULT 0 NOT NULL,
    "attachmentPath" character varying(225) DEFAULT 'N/A'::character varying NOT NULL,
    "postedAt" timestamp with time zone
);


ALTER TABLE public.announcements OWNER TO userdb;

--
-- Name: user; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."user" (
    "userID" bigint NOT NULL,
    "UUID" uuid,
    "worktStation" character varying(225) NOT NULL,
    "userEmail" character varying(225) NOT NULL,
    userfname character varying(225) NOT NULL,
    "userMidname" character varying(225) NOT NULL,
    "userSurname" character varying(225) NOT NULL,
    "userPassword" character varying(225) NOT NULL,
    "userRole" character varying(30) NOT NULL,
    "userVerfication" integer DEFAULT 0 NOT NULL,
    "userStatus" character varying(30) DEFAULT 'Active'::character varying NOT NULL,
    "userCreatedAt" timestamp with time zone,
    "userProfilePicPath" character varying(225) DEFAULT NULL::character varying
);


ALTER TABLE public."user" OWNER TO userdb;

--
-- Name: annoncements_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.annoncements_vw AS
 SELECT an."announcementID",
    an."announcementTitle",
    an."announcementDesc",
    an."hasAttachment",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    an."postedAt",
    an."attachmentPath"
   FROM (public.announcements an
     JOIN public."user" usr ON ((usr."userID" = an."userID")));


ALTER TABLE public.annoncements_vw OWNER TO userdb;

--
-- Name: announcements_announcementID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."announcements_announcementID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."announcements_announcementID_seq" OWNER TO userdb;

--
-- Name: announcements_announcementID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."announcements_announcementID_seq" OWNED BY public.announcements."announcementID";


--
-- Name: billboards; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.billboards (
    "billboardID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "billboardTitle" character varying(225) NOT NULL,
    "billboardBody" text NOT NULL,
    "showOnCarouselDisplay" boolean DEFAULT true NOT NULL,
    "billboardPhotoPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    "postedAt" timestamp with time zone
);


ALTER TABLE public.billboards OWNER TO userdb;

--
-- Name: billboards_billboardID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."billboards_billboardID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."billboards_billboardID_seq" OWNER TO userdb;

--
-- Name: billboards_billboardID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."billboards_billboardID_seq" OWNED BY public.billboards."billboardID";


--
-- Name: billboards_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.billboards_vw AS
 SELECT bl."billboardID",
    bl."billboardTitle",
    bl."billboardBody",
    bl."showOnCarouselDisplay",
    bl."billboardPhotoPath",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    bl."postedAt"
   FROM (public.billboards bl
     JOIN public."user" usr ON ((usr."userID" = bl."userID")));


ALTER TABLE public.billboards_vw OWNER TO userdb;

--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.feedbacks (
    "feedbackID" bigint NOT NULL,
    "UUID" uuid,
    "submitterEmail" character varying(225) NOT NULL,
    "submitterName" character varying(225) NOT NULL,
    "feedbackSubject" character varying(225) NOT NULL,
    "feedbackBody" text NOT NULL,
    "createdAt" timestamp with time zone
);


ALTER TABLE public.feedbacks OWNER TO userdb;

--
-- Name: newsletter; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.newsletter (
    "newsletterID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "newsletterNo" integer NOT NULL,
    "newsletterYear" integer NOT NULL,
    "newsletterMonth" character varying(60) NOT NULL,
    "newsletterCoverPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    "newsletterPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    reads integer DEFAULT 0 NOT NULL,
    "postedAt" timestamp with time zone
);


ALTER TABLE public.newsletter OWNER TO userdb;

--
-- Name: newsupdates; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.newsupdates (
    "newsupdatesID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "newsTitle" character varying(225) NOT NULL,
    "newsDesc" text NOT NULL,
    "showOnCarouselDisplay" boolean DEFAULT false NOT NULL,
    "coverPhotoPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    "supportingPhotosPaths" character varying(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
    "postedAt" timestamp with time zone
);


ALTER TABLE public.newsupdates OWNER TO userdb;

--
-- Name: tenders; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.tenders (
    "tenderID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "tenderNum" character varying(225) NOT NULL,
    "tenderTitle" character varying(225) NOT NULL,
    "tenderDesc" text DEFAULT 'N/A'::text NOT NULL,
    tenderer character varying(225) NOT NULL,
    "openDate" timestamp with time zone NOT NULL,
    "closeDate" timestamp with time zone NOT NULL,
    "hasAttachment" integer DEFAULT 0 NOT NULL,
    "attachmentPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    link character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    "postedAt" timestamp with time zone
);


ALTER TABLE public.tenders OWNER TO userdb;

--
-- Name: vacancies; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.vacancies (
    "vacancyID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "vacancyTitle" character varying(225) NOT NULL,
    "vacancyDesc" text NOT NULL,
    "vacantPositions" integer NOT NULL,
    "openDate" timestamp with time zone NOT NULL,
    "closeDate" timestamp with time zone NOT NULL,
    "hasAttachment" integer DEFAULT 0 NOT NULL,
    "attachmentPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    link character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    "postedAt" timestamp with time zone
);


ALTER TABLE public.vacancies OWNER TO userdb;

--
-- Name: contenthighlights_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.contenthighlights_vw AS
 SELECT ( SELECT count(*) AS count
           FROM public.newsupdates) AS news,
    ( SELECT count(*) AS count
           FROM public.announcements) AS announcements,
    ( SELECT count(*) AS count
           FROM public.newsletter) AS newsletters,
    ( SELECT count(*) AS count
           FROM public.tenders) AS tenders,
    ( SELECT count(*) AS count
           FROM public.vacancies) AS vacancies,
    ( SELECT count(*) AS count
           FROM public.feedbacks) AS feedbacks;


ALTER TABLE public.contenthighlights_vw OWNER TO userdb;

--
-- Name: feedbackReads; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."feedbackReads" (
    "feedbackReadID" bigint NOT NULL,
    "UUID" uuid,
    "feedbackID" integer NOT NULL,
    "userID" integer NOT NULL,
    "readAt" timestamp with time zone
);


ALTER TABLE public."feedbackReads" OWNER TO userdb;

--
-- Name: feedbackReads_feedbackReadID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."feedbackReads_feedbackReadID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."feedbackReads_feedbackReadID_seq" OWNER TO userdb;

--
-- Name: feedbackReads_feedbackReadID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."feedbackReads_feedbackReadID_seq" OWNED BY public."feedbackReads"."feedbackReadID";


--
-- Name: feedbacksReview; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."feedbacksReview" (
    "feedbackReviewID" bigint NOT NULL,
    "UUID" uuid,
    "feedbackID" integer NOT NULL,
    "userID" integer NOT NULL,
    comments text DEFAULT 'Nill'::text NOT NULL,
    "createdAt" timestamp with time zone
);


ALTER TABLE public."feedbacksReview" OWNER TO userdb;

--
-- Name: feedbacksReview_feedbackReviewID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."feedbacksReview_feedbackReviewID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."feedbacksReview_feedbackReviewID_seq" OWNER TO userdb;

--
-- Name: feedbacksReview_feedbackReviewID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."feedbacksReview_feedbackReviewID_seq" OWNED BY public."feedbacksReview"."feedbackReviewID";


--
-- Name: feedbacks_feedbackID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."feedbacks_feedbackID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."feedbacks_feedbackID_seq" OWNER TO userdb;

--
-- Name: feedbacks_feedbackID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."feedbacks_feedbackID_seq" OWNED BY public.feedbacks."feedbackID";


--
-- Name: gallery; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.gallery (
    "galleryID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "albumTitle" character varying(225) NOT NULL,
    "albumPhotoCount" integer DEFAULT 0 NOT NULL,
    "albumCoverPhotoPath" character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    "albumPhotosPaths" character varying(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
    "postedAt" timestamp with time zone
);


ALTER TABLE public.gallery OWNER TO userdb;

--
-- Name: gallery_galleryID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."gallery_galleryID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."gallery_galleryID_seq" OWNER TO userdb;

--
-- Name: gallery_galleryID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."gallery_galleryID_seq" OWNED BY public.gallery."galleryID";


--
-- Name: gallery_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.gallery_vw AS
 SELECT gl."galleryID",
    gl."albumTitle",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    gl."albumPhotoCount",
    gl."albumCoverPhotoPath",
    gl."albumPhotosPaths",
    gl."postedAt"
   FROM (public.gallery gl
     JOIN public."user" usr ON ((usr."userID" = gl."userID")));


ALTER TABLE public.gallery_vw OWNER TO userdb;

--
-- Name: leaders; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.leaders (
    "leaderID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "leadersTitleID" integer NOT NULL,
    fname character varying(225) NOT NULL,
    "midName" character varying(225) NOT NULL,
    surname character varying(225) NOT NULL,
    prefix character varying(50) DEFAULT 'Not Attached'::character varying NOT NULL,
    email character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    profession character varying(225) NOT NULL,
    "experienceYears" integer DEFAULT 0 NOT NULL,
    phone character varying(50) DEFAULT 'Not Attached'::character varying NOT NULL,
    profile_pic_path character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    bio text DEFAULT 'Not Attached'::text NOT NULL,
    linkedin_acc character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    fb_acc character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    twitter_acc character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    instagram_acc character varying(225) DEFAULT 'Not Attached'::character varying NOT NULL,
    status character varying(30) DEFAULT 'Active'::character varying NOT NULL,
    "createdAt" timestamp with time zone
);


ALTER TABLE public.leaders OWNER TO userdb;

--
-- Name: leadersTitle; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."leadersTitle" (
    "leadersTitleID" bigint NOT NULL,
    "UUID" uuid,
    title character varying(255) NOT NULL,
    level integer NOT NULL,
    "titleDesc" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public."leadersTitle" OWNER TO userdb;

--
-- Name: leadersTitle_leadersTitleID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."leadersTitle_leadersTitleID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."leadersTitle_leadersTitleID_seq" OWNER TO userdb;

--
-- Name: leadersTitle_leadersTitleID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."leadersTitle_leadersTitleID_seq" OWNED BY public."leadersTitle"."leadersTitleID";


--
-- Name: leaders_leaderID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."leaders_leaderID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."leaders_leaderID_seq" OWNER TO userdb;

--
-- Name: leaders_leaderID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."leaders_leaderID_seq" OWNED BY public.leaders."leaderID";


--
-- Name: leaders_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.leaders_vw AS
 SELECT ldt.level,
    ldt."leadersTitleID",
    ldt.title,
    ldt."titleDesc",
    ld."leaderID",
    ld.prefix,
    ld.fname,
    ld."midName",
    ld.surname,
    concat(ld.fname, ' ', ld."midName", ' ', ld.surname) AS fullname,
    ld.email,
    ld.phone,
    ld.profession,
    ld."experienceYears",
    ld.bio,
    ld.status,
    ld.profile_pic_path,
    ld.linkedin_acc,
    ld.fb_acc,
    ld.twitter_acc,
    ld.instagram_acc,
    ld."createdAt"
   FROM (public.leaders ld
     RIGHT JOIN public."leadersTitle" ldt ON ((ldt."leadersTitleID" = ld."leadersTitleID")));


ALTER TABLE public.leaders_vw OWNER TO userdb;

--
-- Name: newsletter_newsletterID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."newsletter_newsletterID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."newsletter_newsletterID_seq" OWNER TO userdb;

--
-- Name: newsletter_newsletterID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."newsletter_newsletterID_seq" OWNED BY public.newsletter."newsletterID";


--
-- Name: newsletter_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.newsletter_vw AS
 SELECT nl."newsletterID",
    nl."newsletterNo",
    nl."newsletterYear",
    nl."newsletterMonth",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    nl."newsletterCoverPath",
    nl."newsletterPath",
    nl.downloads,
    nl.reads,
    nl."postedAt"
   FROM (public.newsletter nl
     JOIN public."user" usr ON ((usr."userID" = nl."userID")));


ALTER TABLE public.newsletter_vw OWNER TO userdb;

--
-- Name: newsupdates_newsupdatesID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."newsupdates_newsupdatesID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."newsupdates_newsupdatesID_seq" OWNER TO userdb;

--
-- Name: newsupdates_newsupdatesID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."newsupdates_newsupdatesID_seq" OWNED BY public.newsupdates."newsupdatesID";


--
-- Name: newsupdates_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.newsupdates_vw AS
 SELECT nw."newsupdatesID",
    nw."newsTitle",
    nw."newsDesc",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    nw."postedAt",
    nw."coverPhotoPath",
    nw."supportingPhotosPaths"
   FROM (public.newsupdates nw
     JOIN public."user" usr ON ((usr."userID" = nw."userID")));


ALTER TABLE public.newsupdates_vw OWNER TO userdb;

--
-- Name: notificationReads; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."notificationReads" (
    "notificationReadID" bigint NOT NULL,
    "UUID" uuid,
    "notificationID" integer NOT NULL,
    "userID" integer NOT NULL,
    "readAt" timestamp with time zone
);


ALTER TABLE public."notificationReads" OWNER TO userdb;

--
-- Name: notificationReads_notificationReadID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."notificationReads_notificationReadID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."notificationReads_notificationReadID_seq" OWNER TO userdb;

--
-- Name: notificationReads_notificationReadID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."notificationReads_notificationReadID_seq" OWNED BY public."notificationReads"."notificationReadID";


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.notifications (
    "notificationID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    "notificationSource" character varying(225) NOT NULL,
    "notificationTitle" character varying(225) NOT NULL,
    "notificationDesc" text NOT NULL,
    "broadcastScope" character varying(225) NOT NULL,
    "createdAt" timestamp with time zone
);


ALTER TABLE public.notifications OWNER TO userdb;

--
-- Name: notifications_notificationID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."notifications_notificationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."notifications_notificationID_seq" OWNER TO userdb;

--
-- Name: notifications_notificationID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."notifications_notificationID_seq" OWNED BY public.notifications."notificationID";


--
-- Name: publications; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public.publications (
    "publicationsID" bigint NOT NULL,
    "UUID" uuid,
    "userID" integer NOT NULL,
    category character varying(30) NOT NULL,
    title character varying(225) NOT NULL,
    "contentType" character varying(30),
    "contentSize" integer,
    "contentPath" character varying(225),
    "createdAt" timestamp with time zone
);


ALTER TABLE public.publications OWNER TO userdb;

--
-- Name: publications_publicationsID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."publications_publicationsID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."publications_publicationsID_seq" OWNER TO userdb;

--
-- Name: publications_publicationsID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."publications_publicationsID_seq" OWNED BY public.publications."publicationsID";


--
-- Name: publications_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.publications_vw AS
 SELECT pb."publicationsID",
    pb.category,
    pb.title,
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    pb."contentType",
    pb."contentSize",
    pb."contentPath",
    pb."createdAt"
   FROM (public.publications pb
     JOIN public."user" usr ON ((usr."userID" = pb."userID")));


ALTER TABLE public.publications_vw OWNER TO userdb;

--
-- Name: tenders_tenderID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."tenders_tenderID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tenders_tenderID_seq" OWNER TO userdb;

--
-- Name: tenders_tenderID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."tenders_tenderID_seq" OWNED BY public.tenders."tenderID";


--
-- Name: tenders_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.tenders_vw AS
 SELECT td."tenderID",
    td."userID",
    td."tenderNum",
    td."tenderTitle",
    td."tenderDesc",
    td.tenderer,
    td."openDate",
    td."closeDate",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    td."hasAttachment",
    td."attachmentPath",
    td.link,
    td."postedAt"
   FROM (public.tenders td
     JOIN public."user" usr ON ((usr."userID" = td."userID")));


ALTER TABLE public.tenders_vw OWNER TO userdb;

--
-- Name: user_userID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."user_userID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."user_userID_seq" OWNER TO userdb;

--
-- Name: user_userID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."user_userID_seq" OWNED BY public."user"."userID";


--
-- Name: vacancies_vacancyID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."vacancies_vacancyID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."vacancies_vacancyID_seq" OWNER TO userdb;

--
-- Name: vacancies_vacancyID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."vacancies_vacancyID_seq" OWNED BY public.vacancies."vacancyID";


--
-- Name: vacancies_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.vacancies_vw AS
 SELECT vc."vacancyID",
    vc."vacancyTitle",
    vc."vacancyDesc",
    vc."vacantPositions",
    vc."openDate",
    vc."closeDate",
    concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
    usr."worktStation",
    vc."hasAttachment",
    vc."attachmentPath",
    vc.link,
    vc."postedAt"
   FROM (public.vacancies vc
     JOIN public."user" usr ON ((usr."userID" = vc."userID")));


ALTER TABLE public.vacancies_vw OWNER TO userdb;

--
-- Name: websiteVisit; Type: TABLE; Schema: public; Owner: userdb
--

CREATE TABLE public."websiteVisit" (
    "visitID" bigint NOT NULL,
    "UUID" uuid,
    ip_address character varying(255),
    user_agent character varying(255),
    referrer character varying(500),
    page_url character varying(255),
    session_id character varying(255),
    device_type character varying(225),
    browser character varying(225) DEFAULT 'unknown'::character varying,
    os character varying(225) DEFAULT 'unknown'::character varying,
    screen_resolution character varying(225) DEFAULT '0x0'::character varying,
    country character varying(225) DEFAULT 'unknown'::character varying,
    city character varying(255) DEFAULT 'unknown'::character varying,
    language character varying(255) DEFAULT 'unknown'::character varying,
    is_bot character varying(255),
    "visitedAt" timestamp with time zone
);


ALTER TABLE public."websiteVisit" OWNER TO userdb;

--
-- Name: websiteVisit_visitID_seq; Type: SEQUENCE; Schema: public; Owner: userdb
--

CREATE SEQUENCE public."websiteVisit_visitID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."websiteVisit_visitID_seq" OWNER TO userdb;

--
-- Name: websiteVisit_visitID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE public."websiteVisit_visitID_seq" OWNED BY public."websiteVisit"."visitID";


--
-- Name: website_visits_summary_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.website_visits_summary_vw AS
 SELECT count(*) FILTER (WHERE (("websiteVisit"."visitedAt")::date = CURRENT_DATE)) AS today_visits,
    count(*) FILTER (WHERE ("websiteVisit"."visitedAt" >= date_trunc('week'::text, (CURRENT_DATE)::timestamp with time zone))) AS this_week_visits,
    count(*) FILTER (WHERE ("websiteVisit"."visitedAt" >= date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone))) AS this_month_visits,
    count(*) FILTER (WHERE ("websiteVisit"."visitedAt" >= date_trunc('year'::text, (CURRENT_DATE)::timestamp with time zone))) AS this_year_visits
   FROM public."websiteVisit";


ALTER TABLE public.website_visits_summary_vw OWNER TO userdb;

--
-- Name: weeklyvisittrend_vw; Type: VIEW; Schema: public; Owner: userdb
--

CREATE VIEW public.weeklyvisittrend_vw AS
 SELECT date("websiteVisit"."visitedAt") AS visit_date,
    count(*) AS total_visits
   FROM public."websiteVisit"
  WHERE ("websiteVisit"."visitedAt" >= (CURRENT_DATE - '9 days'::interval))
  GROUP BY (date("websiteVisit"."visitedAt"))
  ORDER BY (date("websiteVisit"."visitedAt"));


ALTER TABLE public.weeklyvisittrend_vw OWNER TO userdb;

--
-- Name: announcements announcementID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.announcements ALTER COLUMN "announcementID" SET DEFAULT nextval('public."announcements_announcementID_seq"'::regclass);


--
-- Name: billboards billboardID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.billboards ALTER COLUMN "billboardID" SET DEFAULT nextval('public."billboards_billboardID_seq"'::regclass);


--
-- Name: feedbackReads feedbackReadID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."feedbackReads" ALTER COLUMN "feedbackReadID" SET DEFAULT nextval('public."feedbackReads_feedbackReadID_seq"'::regclass);


--
-- Name: feedbacks feedbackID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN "feedbackID" SET DEFAULT nextval('public."feedbacks_feedbackID_seq"'::regclass);


--
-- Name: feedbacksReview feedbackReviewID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."feedbacksReview" ALTER COLUMN "feedbackReviewID" SET DEFAULT nextval('public."feedbacksReview_feedbackReviewID_seq"'::regclass);


--
-- Name: gallery galleryID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.gallery ALTER COLUMN "galleryID" SET DEFAULT nextval('public."gallery_galleryID_seq"'::regclass);


--
-- Name: leaders leaderID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.leaders ALTER COLUMN "leaderID" SET DEFAULT nextval('public."leaders_leaderID_seq"'::regclass);


--
-- Name: leadersTitle leadersTitleID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."leadersTitle" ALTER COLUMN "leadersTitleID" SET DEFAULT nextval('public."leadersTitle_leadersTitleID_seq"'::regclass);


--
-- Name: newsletter newsletterID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.newsletter ALTER COLUMN "newsletterID" SET DEFAULT nextval('public."newsletter_newsletterID_seq"'::regclass);


--
-- Name: newsupdates newsupdatesID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.newsupdates ALTER COLUMN "newsupdatesID" SET DEFAULT nextval('public."newsupdates_newsupdatesID_seq"'::regclass);


--
-- Name: notificationReads notificationReadID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."notificationReads" ALTER COLUMN "notificationReadID" SET DEFAULT nextval('public."notificationReads_notificationReadID_seq"'::regclass);


--
-- Name: notifications notificationID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.notifications ALTER COLUMN "notificationID" SET DEFAULT nextval('public."notifications_notificationID_seq"'::regclass);


--
-- Name: publications publicationsID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.publications ALTER COLUMN "publicationsID" SET DEFAULT nextval('public."publications_publicationsID_seq"'::regclass);


--
-- Name: tenders tenderID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.tenders ALTER COLUMN "tenderID" SET DEFAULT nextval('public."tenders_tenderID_seq"'::regclass);


--
-- Name: user userID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."user" ALTER COLUMN "userID" SET DEFAULT nextval('public."user_userID_seq"'::regclass);


--
-- Name: vacancies vacancyID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.vacancies ALTER COLUMN "vacancyID" SET DEFAULT nextval('public."vacancies_vacancyID_seq"'::regclass);


--
-- Name: websiteVisit visitID; Type: DEFAULT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."websiteVisit" ALTER COLUMN "visitID" SET DEFAULT nextval('public."websiteVisit_visitID_seq"'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."SequelizeMeta" (name) FROM stdin;
20250627090523-create-database-views.cjs
\.


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.announcements ("announcementID", "UUID", "userID", "announcementTitle", "announcementDesc", "hasAttachment", "attachmentPath", "postedAt") FROM stdin;
1	a685e296-1778-43a2-91f9-af4f7a85ba6b	1	ISSUES RAISED IN THE COURT USER SATISFACTION SURVEY	N/A	1	website-repository/announcements/2025/1/announcement-1752056956235-933789197.pdf	2025-07-09 13:29:16.238+03
2	ed7e3770-6d91-4e1d-9658-43c92603e8bb	1	ONLINE PETITION FOR MID YEAR ADMISSION AND ENROLME	N/A	1	website-repository/announcements/2025/2/announcement-1752144324714-802058763.pdf	2025-06-18 13:45:24.725+03
3	4d203ffa-4fdb-4e51-97c4-0b8b6dfaf9a2	1	ORODHA YA MADALALI NA WASAMBAZA NYARAKA WA MAHAKAMA KWA MWAKA 2025/2026	N/A	1	website-repository/announcements/2025/3/announcement-1752146633350-596404509.pdf	2025-07-10 14:23:53.357+03
\.


--
-- Data for Name: billboards; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.billboards ("billboardID", "UUID", "userID", "billboardTitle", "billboardBody", "showOnCarouselDisplay", "billboardPhotoPath", "postedAt") FROM stdin;
1	743248a5-6423-469d-ba4a-6a8481d2be4e	1	JUDICIARY MOBILE TZ APP	<p>The <strong>Judiciary Mobile Tz</strong> app is an official Android application developed by the Judiciary of Tanzania to make legal information more accessible to the public.</p><p><strong>Case Details Lookup</strong>: Users can retrieve information about specific court cases by entering required details like case number or court name.</p><p><strong>Cause List Access</strong>: You can view daily cause lists (schedules of cases to be heard) by filling in relevant fields.</p><p><strong>PDF Reports</strong>: The app now includes updated cause-list reports in PDF format for easier viewing and sharing.</p><p><strong>User-Friendly Interface</strong>: Designed for everyone, with no ads and a simple layout that supports quick access to justice-related data.</p><p><br></p><p>Free to download from <a href="https://play.google.com/store/apps/details?id=com.jot.judiciarymobiletz&amp;hl=en-US&amp;pli=1" rel="noopener noreferrer" target="_blank">Judiciary Mobile Tz - Apps on Google Play</a></p>	t	website-repository/billboards/2025/1/billboard-1751619234111-819928468.png	2025-07-04 10:51:28.915+03
\.


--
-- Data for Name: feedbackReads; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."feedbackReads" ("feedbackReadID", "UUID", "feedbackID", "userID", "readAt") FROM stdin;
1	de64e683-de1d-40b0-8b5f-a05a49242f52	1	1	2025-07-19 23:39:17.704+03
2	f2d977b9-d0ad-432b-9fc1-32b86fa7f6b2	5	1	2025-07-23 19:45:01.162+03
3	d43b3b40-2d0b-4325-9d17-2a9ca54ec135	6	1	2025-07-24 10:17:44.905+03
4	0a49c8c4-cd6a-466a-9687-7be0b6d6b12f	4	1	2025-07-24 11:21:39.381+03
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.feedbacks ("feedbackID", "UUID", "submitterEmail", "submitterName", "feedbackSubject", "feedbackBody", "createdAt") FROM stdin;
1	225cca2b-6463-451b-aa4d-981393ca9df8	elysonmushi@gmail.com	Elyson Godson Mushi	Feedback Subject	Feedback body here ...	2025-07-19 23:08:08.416+03
2	e8682068-250e-4469-947c-3652208e0ac7	elysonmushi92@gmail.com	Elyson Godson Mushi	Malalamiko	Feedback body here ...	2025-07-20 00:42:15.001+03
3	dc76a815-d0c4-4cc4-b534-6009e73ab1ba	elyson@gmail.com	Elyson Mushi	Malalamiko ya kufungua kesi	Malalamiko ya kufungua kesi, kesi namba 145/34534 nataka kujua status na progress	2025-07-23 17:47:13.208+03
4	712c1c26-78a0-42f8-9453-2e8956b8613a	elysonmushi92@gmail.com	Elyson Mushi	Majaribio Subject	message ya majaribio	2025-07-23 18:14:48.48+03
5	b30ae107-10e4-46b9-af4a-252c847189c3	elysonmushi92@gmail.com	Elyson Mushi	Malalamiko ya kufungua kesi	Malalamiko ya kufungua kesi namba 2323/43	2025-07-23 18:30:05.721+03
6	126ab124-a85a-491c-afc4-cee094cec1a7	emmanuelmuyula@gmail.com	Emmanuel Muyula	Maoni kuhusu website mpya	Habari, haya ni maoni yangu kuhusu website mpya. Nashauri maboresho kwenye website mpya ya mahakama, ili kurahisisha upatikanaji wa taarifa muhimu kwa watumiaji wa website hii. Pia wahusika wajitahidi kufanya update mara kwa mara ili kuimarisha ulinzi dhidi ya cyber attacks. Asante, naomba kuwasilisha	2025-07-24 10:16:52.316+03
\.


--
-- Data for Name: feedbacksReview; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."feedbacksReview" ("feedbackReviewID", "UUID", "feedbackID", "userID", comments, "createdAt") FROM stdin;
\.


--
-- Data for Name: gallery; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.gallery ("galleryID", "UUID", "userID", "albumTitle", "albumPhotoCount", "albumCoverPhotoPath", "albumPhotosPaths", "postedAt") FROM stdin;
1	fd3e25fe-f4c2-4c2a-b470-f5875ba84012	1	Law Week 2025	4	website-repository/gallery/2025/1/galleryPhoto-1751995402810-230590543.jpg	{website-repository/gallery/2025/1/galleryPhoto-1751995402817-519349997.jpg,website-repository/gallery/2025/1/galleryPhoto-1751995402834-813058309.jpg,website-repository/gallery/2025/1/galleryPhoto-1751995402837-291317119.jpg}	2025-07-08 20:23:22.842+03
2	0ba26f27-d86f-4422-890e-fb0040b9703d	1	Worker's Day	3	website-repository/gallery/2025/2/galleryPhoto-1751995445481-364586327.jpg	{website-repository/gallery/2025/2/galleryPhoto-1751995445488-425496159.jpg,website-repository/gallery/2025/2/galleryPhoto-1751995445489-445709856.jpg}	2025-07-08 20:24:05.491+03
3	46cb89f7-50a9-49b8-87ee-219691116fa3	1	Judiciary Situation Room	3	website-repository/gallery/2025/3/galleryPhoto-1751995787197-408417899.jpg	{website-repository/gallery/2025/3/galleryPhoto-1751995787201-466732810.jpg,website-repository/gallery/2025/3/galleryPhoto-1751995787207-232951777.jpg}	2025-07-08 20:29:47.211+03
4	e195463f-56d2-4773-a5d0-4048049e4b8d	1	Worker's Day 2023	3	website-repository/gallery/2025/4/galleryPhoto-1751995889146-88988823.jpg	{website-repository/gallery/2025/4/galleryPhoto-1751995889150-800101981.jpg,website-repository/gallery/2025/4/galleryPhoto-1751995889155-614121709.jpg}	2025-07-08 20:31:29.158+03
\.


--
-- Data for Name: leaders; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.leaders ("leaderID", "UUID", "userID", "leadersTitleID", fname, "midName", surname, prefix, email, profession, "experienceYears", phone, profile_pic_path, bio, linkedin_acc, fb_acc, twitter_acc, instagram_acc, status, "createdAt") FROM stdin;
2	350367d1-2551-494f-b327-3d30af55e480	1	3	Eva	Kiaki	Nkya	Not Attached	Not Attached	Lawyer	35	Not Attached	website-repository/leadersprofilepictures/2025/3/leaderProfilePic-1751859710404-632507422.jpg	<p>Hon. Eva Kiaki Nkya was appointed Chief Registrar of the Judiciary of Tanzania in April 2024. In this critical leadership role, she oversees the judiciary’s administrative operations, including efficient case management, court services, and the implementation of judicial policies. Her stewardship ensures that the courts operate smoothly, supporting the timely dispensation of justice across the country.</p><p><br></p><p>She holds a Bachelor of Laws (LL.B) degree from the University of Dar es Salaam and a Postgraduate Diploma in Legal Practice from the Law School of Tanzania. Throughout her career, Hon. Nkya has gained extensive experience in public service administration and legal advisory roles. Prior to her appointment, she served as Director of the Legal Services Unit at the Ministry of Livestock and Fisheries, where she played a key role in shaping policy and legal reforms.</p><p><br></p><p>Committed to modernizing the judiciary, Hon. Nkya is actively involved in integrating Information and Communication Technology (ICT) into court processes to enhance efficiency and accessibility. She also fosters collaboration with regional and international judicial bodies to promote best practices and support continuous improvements in the Tanzanian judicial system.</p>	Not Attached	Not Attached	Not Attached	Not Attached	Active	2025-07-07 06:41:50.425+03
1	5f027eb0-f8d9-4c2d-9fbe-be6c6332631a	1	4	Elisante	Ole	Gabriel	Not Attached	Not Attached	Economist	40	Not Attached	website-repository/leadersprofilepictures/2025/4/leaderProfilePic-1751859863188-275951989.jpg	<p>Prof. Elisante Ole Gabriel serves as the Chief Court Administrator of the Judiciary of Tanzania, responsible for managing court administration, finance, human resources, and strategic reforms across the judiciary. Appointed by the President through the Judicial Service Commission, he works closely with the Chief Justice to ensure efficient and accessible justice delivery.</p><p><br></p><p>Prof. Ole Gabriel brings extensive experience in public administration and judicial leadership. As Chair of the Southern and Eastern Judicial Administrators Association (SEAJAA), he promotes regional collaboration and innovation. Under his leadership, the Judiciary of Tanzania has achieved over 99% digital automation and continues to roll out transformative technologies and mobile court services to enhance access to justice.</p>	Not Attached	Not Attached	Not Attached	Not Attached	Active	2025-07-07 06:27:21.209+03
3	9d1dccff-66cc-43d5-a37e-d717d5dc2807	1	2	Mustapher	Mohamed	Siyan	Not Attached	Not Attached	Lawyer	30	Not Attached	website-repository/leadersprofilepictures/2025/2/leaderProfilePic-1752147137574-871748059.jpg	<p>Hon. Dr. Mustapher Mohamed Siyani serves as the Principal Judge of the Judiciary of Tanzania, a position he assumed in 2023. As the Principal Judge, he oversees the High Court and all subordinate courts, including District and Resident Magistrates’ Courts. He plays a crucial role in ensuring the efficient administration of justice, maintaining judicial discipline, and promoting uniformity in the application of the law throughout the country.</p><p><br></p><p>Dr. Siyani holds a distinguished academic record, including a doctorate in law, and has extensive experience both as a legal scholar and a judicial officer. His deep knowledge of legal principles and commitment to justice underpin his efforts to strengthen the judiciary’s capacity and uphold the rule of law in Tanzania.</p><p><br></p><p>In his tenure, Hon. Dr. Siyani has prioritized judicial reforms aimed at expanding access to justice, enhancing case management efficiency, and fostering the use of technology in court processes. He is actively involved in regional and international judicial networks, promoting collaboration and best practices to enhance the effectiveness and integrity of Tanzania’s judicial system.</p>	Not Attached	Not Attached	Not Attached	Not Attached	Active	2025-07-10 14:32:17.589+03
4	5f602ac6-879e-4a6f-994e-410e40308e09	1	1	George	Mcheche	Masaju	Not Attached	Not Attached	Lawyer	32	Not Attached	website-repository/leadersprofilepictures/2025/1/leaderProfilePic-1752333347067-790580562.png	<p>Hon. George Mcheche Masaju was appointed Chief Justice of the United Republic of Tanzania on <strong>June 13, 2025</strong></p><p>by President Samia Suluhu Hassan and sworn in on <strong>June 15, 2025 </strong>at Chamwino State House in Dodoma. As chief Justice, he leads the country’s judicial system and serves as Chairperson of the Judicial Service Commission, succeeding Prof. Ibrahim Hamis Juma.</p><p><br></p><p>Chief Justice Masaju is a seasoned legal expert with a strong educational foundation. He holds a <strong>Bachelor of Laws (LL.B) </strong>from the <strong>University of Dar es Salaam</strong>, a <strong>Master of Laws (LL.M) </strong>from the same institution, and has undergone advanced legal training both locally and internationally. His academic background has equipped him with deep knowledge in constitutional, administrative, and public law.</p><p><br></p><p>Throughout his distinguished career, Hon. Masaju has held several key positions, including <strong>Government Legal Officer</strong>, <strong>Deputy Attorney General</strong>, <strong>Attorney General of Tanzania (2015–2018)</strong>, <strong>High Court Judge</strong>, and <strong>Advisor to the President on Legal Affairs</strong>. Prior to becoming Chief Justice, he served as a <strong>Judge of the Court of Appeal</strong>. He is committed to strengthening judicial independence, transparency, and access to justice, and has prioritized electoral integrity and digital reform during his leadership.</p>	Not Attached	Not Attached	Not Attached	Not Attached	Active	2025-07-11 03:20:56.597+03
\.


--
-- Data for Name: leadersTitle; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."leadersTitle" ("leadersTitleID", "UUID", title, level, "titleDesc", "createdAt", "updatedAt") FROM stdin;
1	6e275790-824b-40eb-b6d0-de3f064d23b0	Chief Justice of Tanzania	1	Description of Chief Justice of Tanzania	2025-07-02 11:56:44.471+03	\N
2	529bbfa0-13db-4fb9-8d04-9a968949b788	Principal Judge of High Court	2	Description of Principal Judge of High Court	2025-07-02 11:56:44.471+03	\N
3	3397a5f7-7cd6-49e5-9e05-2a901b78b08b	Chief Court Registrar	3	Description of Chief Court Registrar	2025-07-02 11:56:44.471+03	\N
4	45e0b393-67bd-4853-8184-f3ea292d3f9d	Chief Court Administrator	4	Description of Chief Court Administrator	2025-07-02 11:56:44.471+03	\N
\.


--
-- Data for Name: newsletter; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.newsletter ("newsletterID", "UUID", "userID", "newsletterNo", "newsletterYear", "newsletterMonth", "newsletterCoverPath", "newsletterPath", downloads, reads, "postedAt") FROM stdin;
1	c4abf7fa-5606-4eaf-8865-d3d86d30d943	1	24	2024	October - December	website-repository/newsupdates/2025/1/newsletterCover-1752147710551-938171796.jpg	website-repository/newsupdates/2025/1/newsletter-1752147710570-470111807.pdf	0	0	2025-07-10 14:41:50.576+03
2	db46fe74-79ea-4001-94c9-b831b42d9551	12	4	2018	October - December	website-repository/newsupdates/2025/2/newsletterCover-1752197017986-415125170.jpg	website-repository/newsupdates/2025/2/newsletter-1752197017986-140026927.pdf	0	0	2025-07-11 04:23:37.996+03
3	8a0cd72a-d41c-4529-88c1-6eb9bad2b9cb	12	14	2018	October - December	website-repository/newsupdates/2025/3/newsletterCover-1752197646973-354685042.jpg	website-repository/newsupdates/2025/3/newsletter-1752197646985-33537845.pdf	0	0	2025-07-11 04:34:06.99+03
\.


--
-- Data for Name: newsupdates; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.newsupdates ("newsupdatesID", "UUID", "userID", "newsTitle", "newsDesc", "showOnCarouselDisplay", "coverPhotoPath", "supportingPhotosPaths", "postedAt") FROM stdin;
1	31de8aa9-a58a-4b3c-aafd-08467bb63cfb	1	MAFUNZO YALETA TIJA YA UANDISHI MZURI WA HUKUMU ZA MAHAKIMU KIGOMA; JAJI NKWABI	<p class="ql-align-justify"><strong>Na AIDAN ROBERT, Mahakama-Kigoma</strong></p><p>Jaji wa Mahakama Kuu ya Tanzania Kanda ya Kigoma, Mhe. John Nkwabi amekiri kufurahishwa na mabadiliko makubwa ya uandishi wa hukumu za Mahakimu wa Kanda hiyo hatua iliyofikiwa kutokana na mafunzo kadhaa yaliyotolewa kwa Mahakimu hao.</p><p class="ql-align-justify">Mhe. Nkwabi aliyasema hayo kwa niaba ya Jaji Mfawidhi wa Kanda ya Kigoma kwa nyakati tofauti akiwa kwenye ziara ya ukaguzi wa Mahakama za Wilaya za Kanda hiyo uliofanyika kati ya tarehe 30, Juni mpaka 04, Julai 2025.</p><p>“Nimeona tija kubwa ya uwepo wa mafunzo mbalimbali ya kuwajengea uwezo Mahakimu na watumishi wengine, na tusiishie hapo tu, bali tuwafikie na wadau wetu, hii itaboresha mpango mkakati wetu wa kumaliza mashauri na kutoa haki kwa wakati,” alisema Mhe. Nkwabi.</p><p class="ql-align-justify">Katika hatua nyingine, Jaji Nkwabi aliwapongeza watumishi na watendaji wa Mahakama za Wilaya sita (6) za Kanda hiyo kwa ushirikiano wanaouonesha katika vituo vyao wa kumaliza mashauri zaidi ya 300 katika robo ya nne ya mwaka&nbsp;wa fedha 2024/2025, ambapo imefanya Kanda kuvuka mwaka bila kuwa&nbsp;na mashauri ya mlundikano.</p><p class="ql-align-justify">Kwa upande wake, Naibu Msajili wa Mahakama Kuu ya Tanzania Kanda ya Kigoma, Mhe. Fadhili Mbelwa alibainisha kuwa, Mahakama Kanda ya Kigoma itaendelea kudumisha utamaduni wake wa kufanya kazi kwa ushirikiano mkubwa na weledi katika kutatua changamoto kwa haraka&nbsp;kwa watumishi na wananchi wanaohudumiwa na Mahakama zote zilizopo ndani ya Kanda hiyo.</p><p class="ql-align-justify">Naye, &nbsp;Mtendaji wa Mahakama Kuu ya Tanzania Kanda ya Kigoma, Bw. Filbert Matotay, alimhakikishia Jaji Nkwabi, kuwa Kanda ya Kigoma itaendelea kuboresha miundombinu ya majengo, Teknolojia ya Habari na Mawasiliano (TEHAMA) pamoja na kuendelea kuratibu mafunzo ya ndani kwa watumishi ili kuongeza weledi na kuwajengea uwezo zaidi katika kutekeleza majukumu mbalimbali.</p><p class="ql-align-justify">Bw. Matotay aliongeza kuwa, pamoja na hayo Kanda itaendelea kuwapatia wadau uelewa wa matumizi sahihi ya mifumo ya uratibu na usimamizi wa mashauri mahakamani (e-CMS).</p><p class="ql-align-justify">Mahakama za Wilaya zilizokaguliwa ni Kigoma, Kasulu, Kibondo, Uvinza, Buhigwe, Kakonko, pamoja na Magereza ya Wilaya Kigoma na Kasulu. Katika ziara hiyo, Mhe. Nkwabi aliambatana na Naibu Msajili wa Mahakama Kuu Kanda ya Kigoma, Mhe. Fadhili mbelwa pamoja na Mtendaji wa Mahakama Kuu ya Tanzania Kanda ya Kigoma, Bw. Filbert Matotay.</p><p class="ql-align-justify">Ziara hiyo imekuwa ya mafanikio makubwa ikiwa ni pamoja na kuwatia moyo na kutoa pongezi kwa watumishi wa Mahakama hizo kwa utunzaji bora wa mazingira ya Mahakama hizo.</p><p><br></p>	f	website-repository/newsupdates/2025/1/newsPhoto-1751693335990-253811160.JPG	{website-repository/newsupdates/2025/1/newsPhoto-1751693335990-253811160.JPG,website-repository/newsupdates/2025/1/newsPhoto-1751693335991-138458501.JPG}	2025-07-05 08:28:55.994+03
2	f8bcaee3-1f60-43ef-ab5f-a25be33dbd6b	1	JAJI MKUU ASISITIZA MAMBO SITA KWA CHAMA CHA MAWAKILI WA SERIKALI	<p><strong>Na FAUSTINE KAPAMA na ARAFA RUSHEKE-Mahakama, Dodoma</strong></p><p class="ql-align-justify">Jaji Mkuu wa Tanzania, Mhe. George Mcheche Masaju leo tarehe 4 Julai, 2025 amekutana na Viongozi wa Chama cha Mawakili wa Serikali na kuhimiza Wanachama kuzingatia mambo sita wanapotekeleza majukumu yao, ikiwemo kuisaidia Mahakama katika kufikia uamuzi wa haki.</p><p class="ql-align-justify">Mambo hayo yaliyosisitizwa na Mhe. Masaju alipokutana na Viongozi hao ofisini kwake kwenye Jengo la Makao Makuu ya Mahakama ya Tanzania jijini Dodoma ni umahiri (competence), uadilifu (integrity), umakini (proactive), ubunifu (creativity), uzalendo wa kitaifa (national patriotism) na kujali haki (sensitive to justice). </p><p class="ql-align-justify">Viongozi hao ni Bavoo Junus (Rais), Debora Mcharo (Makamu wa Rais), Addo November (Mwenyekiti), Selestina Kunambi (Makamu Mwenyekiti) na Rashid Mohamed Said (Katibu).</p><p class="ql-align-justify">Akizungumzia na Viongozi hao, Mhe. Masaju amesema kuwa ili Wanachama wa Chama cha Mawakili wa Serikali waweze kutekeleza majukumu yao kwa mafanikio makubwa wanatakiwa kuzingatia na kuyaishi mambo hayo sita. </p><p class="ql-align-justify">Kuhusu suala ya umahiri, Jaji Mkuu ameeleza kuwa hilo limekuwa changamoto kubwa katika utumishi wa umma na kwamba watu wengine wanaamini ili kuwa mahiri lazima uwe na shahada nyingi. </p><p class="ql-align-justify">‘Hapa ndipo tunapopotea, watu tutalazimika kusoma shahada hizi, lakini shahada yenyewe haikuletei umahiri. Tumejichanganya sana kwenye eneo hili, wakati fulani tunaenda kusoma kwa sababu ya vyeo. Tusome ili tuwe na hizi shahada, lakini zituwezeshe basi kuwa mahiri kwenye hilo eneo,’ amesema.</p><p class="ql-align-justify">Mhe. Masaju amewaeleza Viongozi hao kuwa umahiri wa hali ya juu unahitajika kwa Wanasheria waliopo kwenye sekta ya umma katika kushiriki kwenye majukumu ya kusimamia utawala wa sheria, mikataba, kuendesha mashauri na kuishauri Serikali katika masuala mbalimbali.</p><p class="ql-align-justify">Jaji Mkuu ameeleza pia kuwa<strong> </strong>suala la uadilifu ni jambo la msingi katika utumishi wa umma, hivyo amewasihi Wanachama wa Chama hicho kwenda kuwatumikia wananchi kwa kufuata misingi hiyo. </p><p class="ql-align-justify">Akizungumzia suala la umakini, Mhe. Masaju amesema kuwa jambo hilo nalo limekuwa changamoto kwenye sekta ya sheria, hivyo Wanasheria wanatakiwa kujiongeza kwani mtu anaweza kujua majukumu yake na changamoto zilizopo, lakini hawezi kuchukua hatua mpaka asubiri mtu mwingine.</p><p class="ql-align-justify">‘Kuna mambo mengi yanayotukabili, tusipokuwa makini tutakwama. Siku hizi kila kitu mpaka tusukumwe, tunapaswa kuwa wabunifu kwani changamoto ni nyingi. Lazima tuwe wabunifu kushughulikia hizi changamoto ili utumishi wetu ufanikiwe,’ Jaji Mkuu amesema.</p><p class="ql-align-justify">Jambo jingine ambalo Wanachama wa Chama cha Mawakili wa Serikali wanatakiwa kuzingatia ni uzalendo kwa Taifa kwani wanabeba maslahi ya nchi. Mhe. Masaju amesema kuwa haitoshi kuwa mwadilifu, lazima pia Mwanachma aweke mbele maslahi ya umma.</p><p class="ql-align-justify">Jaji Mkuu pia aliwaeleza Viongozi hao kuwa Wanachama wa Chama cha Mawakili wa Serikali wanatakiwa kujua wanajiandaa namna gani wanapoenda mahakamani, wanatoa ushauri gani wa kisheria kwenye maeneo mbalimbali, wanaguswa namna gani kwa watu wanaoonewa, wanafanya nini na nafasi yao ni ipi.</p><p class="ql-align-justify">Akizungumza wakati wa ugeni huu, Jaji Kiongozi wa Mahakama Kuu ya Tanzania, Mhe. Dkt. Mustapher Mohamed Siyani amewahimiza Wanachama wa Chama hicho kuendeleza utamaduni na mahusiano mazuri yaliyopo kati ya Mawakili wa Serikali na Mahakimu.</p><p class="ql-align-justify">Naye Rais wa Chama hicho, kwa niaba ya Viongozi wenzake, alimshukuru Jaji Mkuu kwa kuwapa fursa ya kukutana naye kwa madhumuni ya kujitambulisha na kumpongeza kwa kuteuliwa na Rais wa Jamhuri ya Muungano wa Tanzania kushika wadhifa huo.</p><p class="ql-align-justify">Kiongozi huyo alitumia fursa hiyo kukitambulisha Chama kwa Jaji Mkuu kwani bado nikichanga na mdau mkubwa kwa Mahakama. Aliomba ushirikiano wa Mahakama ya Tanzania kwenye maeneo mbalimbali, ikiwemo mafunzo.</p><p><br></p>	f	website-repository/newsupdates/2025/2/newsPhoto-1751693596102-699837252.JPG	{website-repository/newsupdates/2025/2/newsPhoto-1751693596102-699837252.JPG,website-repository/newsupdates/2025/2/newsPhoto-1751693596102-410697520.JPG,website-repository/newsupdates/2025/2/newsPhoto-1751693596102-661224419.JPG}	2025-07-05 08:33:16.105+03
3	7f766447-1f43-4a59-b1ab-60c41e27cba6	1	JAJI MFAWIDHI KANDA IRINGA AFANYA ZIARA YA UKAGUZI MKOANI NJOMBE	<ul><li><strong>Atembelea Mradi wa Ujenzi wa Mahakama ya Mwanzo Lupembe&nbsp;</strong></li><li><strong>Atembelea pia Jengo la zamani la kihistoria Mahakama ya Mwanzo Mdandu</strong></li></ul><p class="ql-align-justify"><strong>Na ABDALLAH SALUM, Mahakama-Njombe</strong></p><p class="ql-align-justify">Jaji Mfawidhi wa Mahakama Kuu ya Tanzania Kanda ya Iringa, Mhe. Dunstan Ndunguru ameanza ziara ya ukaguzi wa Mahakama za Mkoa wa Njombe kwa kufanya ukaguzi wa Mahakama za Wilaya za Njombe na Wanging’ombe.</p><p class="ql-align-justify">Mbali na Mahakama hizo, Mhe. Ndunguru alifanya pia ziara ya ukaguzi katika Mahakama za Mwanzo Wilaya kuanzia tarehe 01 Julai, 2025.</p><p class="ql-align-justify">Akiwa katika Mahakama ya Hakimu Mkazi Njombe, Mhe.Ndunguru alipokea taarifa ya jumla ya Mkoa mzima juu ya uendeshaji wa mashauri pamoja na miundombinu ya&nbsp;&nbsp;Mahakama ya Mkoa Njombe pamoja na&nbsp;Mahakama zake za Mwanzo za Wilaya zilizopo katika Mkoa huo.</p><p class="ql-align-justify">Akiwasilisha taarifa ya Mahakama katika Mkoa huo, Hakimu Mkazi Mfawidhi wa Mahakama ya Hakimu Mkazi Njombe, Mhe. Liadi Chamshama alidokeza kuhusu hali ya usikilizwaji wa mashauri kwa Mkoa mzima pamoja&nbsp;na&nbsp;&nbsp;utekelezaji wa Nguzo namba moja (1) katika Mpango Mkakati wa Mahakama utawala bora uwajibikaji na usimamizi wa rasilimali.</p><p class="ql-align-justify">Mhe. Chamshama alibainisha mafanikio mbalimbali&nbsp;yaliyopatikana katika Mahakama hiyo kuwa, ni pamoja na&nbsp;&nbsp;kufanya marekebisho ya jengo la Mahakama ya Mwanzo Makambako Mjini ambalo lilikuwa halipo kwenye hali nzuri licha ya ufinyu wa bajeti.</p><p class="ql-align-justify">Aidha, baada ya kupokea taarifa hiyo Mhe.Ndunguru alijibu hoja mbalimbli zilizojitokeza kwenye taarifa hiyo huku akisisitiza kuhusu matumizi ya Teknolojia ya Habari na Mawasiliano (TEHAMA) kwa kupandisha vielelezo na hati za mashtaka&nbsp;&nbsp;kwenye mfumo wa usimamizi wa mashauri Mahakamani (<em>e-CMS</em>) hasa kwa mashauri yaliyokatiwa rufaa kwenda Mahakama ya juu.</p><p class="ql-align-justify">Sanjari na hilo Mhe. Ndunguru alizungumza na watumishi wa Mahakama ya Wilaya Wanging’ombe ambapo alitoa&nbsp;pongezi juu ya utendaji kazi wa Mahakama hiyo.</p><p class="ql-align-justify">Baada ya hapo Mhe,Ndunguru alienda kukagua jengo la Mahakama ya mwanzo Mdandu ambalo lipo chini ya Mahakama ya Wilaya Wangingombe ambalo kulikuwa na jengo la zamani la kihistoria lillilojengwa na wakoloni kwa shunghuli za kiMahakama</p><p class="ql-align-justify">Mhe. Ndunguru alitembelea pia jengo la kale la Mahakama ya Mwanzo Mdandu lililojengwa na wakoloni na kujionea majalada ya zamani waliokuwa wanatumia machifu kuhamua mashauri pamoja na kuona makabati yaliyokuwa yanatunza majalada hayo.</p><p class="ql-align-justify">Kadhalika Mhe.Ndunguru alifanya ukaguzi Mahakama ya Mwanzo Njombe Mjini ambapo alizungumza na watumishi na kusomewa taarifa fupi ya&nbsp;Mahakama hiyo.</p><p class="ql-align-justify">Kwa upande wake, Naibu Msajili wa Mahakama Kuu Kanda ya Iringa, Mhe.Bernazitha Maziku alisisitiza juu ya kusajiLi mashauri yote yanayoingia mahakamani ili kuweka sawa kumbukumbu pamoja na&nbsp;kuhuhisha mashauri hayo kwa kila Hakimu na kuwa rafiki na mifumo inayosimamia haki kwa wananchi&nbsp;kwani bila kufanya hivyo ni ukiukwaji wa misingi ya haki.</p><p class="ql-align-justify">Aidha, Jaji Mfawidhi huyo pamoja na alioambatana nao walifanya ukaguzi katika Mradi wa Ujenzi wa Mahakama ya Mwanzo Lupembe ambayo&nbsp;&nbsp;inaendelea kujengwa na sasa umefikia asilimia 90 ili ukamilike. Hata hivyo, Mhe. Ndunguru amemtaka Mkandarasi wa Mradi huo kukamilisha ujenzi huo ndani ya muda aliomba kuongezewa.</p><p class="ql-align-justify">Katika ziara hiyo Jaji Mfawidhi huyo ameambatana na&nbsp;Naibu Msajili wa Mahakama Kuu Kanda ya Iringa, Mhe. Bernazitha Maziku, Mtendaji wa Mahakama Kuu Kanda ya Iringa, Bi.Melea Mkogwa, Hakimu Mkazi Mfawidhi Mkoa wa Njombe, Mhe. Liadi Chamshama pamoja na Hakimu Mkazi Mfawidhi Mahakama ya Wilaya.</p>	f	website-repository/newsupdates/NaN/3/newsPhoto-1751694128429-518781954.JPG	{website-repository/newsupdates/NaN/3/newsPhoto-1751694128429-518781954.JPG,website-repository/newsupdates/NaN/3/newsPhoto-1751694128430-456008540.JPG,website-repository/newsupdates/NaN/3/newsPhoto-1751694128430-800657420.JPG,website-repository/newsupdates/NaN/3/newsPhoto-1751694128430-994542870.JPG,website-repository/newsupdates/NaN/3/newsPhoto-1751694128430-575642542.JPG}	2025-07-05 08:38:12.479+03
4	5a0a2103-6cbc-4eed-a0af-68107b3f0a07	1	JAJI MKUU WA SABA MZALENDO AAPISHWA	<ul><li>Ni wa tisa katika historia ya Mahakama tangu kupata uhuru wa Tanzania</li><li>Aahidi kuendelea kusimamia utoaji haki</li></ul><p>&nbsp;</p><p><strong>&nbsp;Na MARY GWERA, Mahakama- Dodoma</strong></p><p>Leo tarehe 15 Juni, 2025 majira ya saa 4:10 asubuhi kwa mara nyingine historia ya Mahakama ya Tanzania imeandikwa kufuatia kuapishwa kwa Jaji Mkuu wa saba Mzalendo na wa tisa tangu kupata uhuru wa Tanzania ambaye ni Mhe. George Mcheche Masaju anayechukua nafasi ya mtangulizi wake, Mhe. Prof. Ibrahim Hamis Juma aliyestaafu utumishi wa umma.</p><p>Mhe. Masaju ameapishwa na Rais wa Jamhuri ya Muungano wa Tanzania, Mhe. Dkt. Samia Suluhu Hassan katika hafla ya uapisho iliyofanyika Ikulu- Chamwino jijini Dodoma.</p><p>Akizungumza mara baada ya kumuapisha Jaji Mkuu mpya, Mhe. Dkt. Samia amesema kuwa, matarajio ya Watanzania ni kuona kuwa Mahakama inaendelea zaidi ya ilipo kwa sasa.</p><p>“Majengo, watenda kazi, mifumo na yote yaliyopo mahakamani yanahitaji kuendelezwa na Jaji Mkuu Mstaafu amesema vizuri kwamba, bado kuna miradi inaendelea, mingine fedha zake zipo, mingine fedha zake za kutafutwa lakini nikuhakikishie ushirikiano wa Serikali kwenye kukamilisha miradi hii,” amesema Rais Samia.</p><p>Mhe. Dkt. Samia ameeleza kuwa, matarajio ya Watanzania pia ni kuona Mahakama inaendelea kusimamia haki ndani ya nchi na nje ya nchi, hivyo anatarajia kuwa jukumu hilo kubwa litasimamiwa vyema na Jaji Mkuu huyo.</p><p>“Katika kusimamia haki, Siku ya Sheria ya mwaka huu nilisema kuwa kazi yenu ni kusimamia haki. Kazi ya kutoa haki ni kazi ya Mungu lakini kwa duniani kazi ya haki ni kazi ya Majaji, hivyo ni muhimu kusimamia haki kwa misingi tuliyojiwekea,” amesisitiza Rais Samia.</p><p>Ameongeza kuwa, Serikali itafanya kila linalowezekana kuendeleza ufanyaji kazi wa Mahakama kama alivyoahidi wakati analihutubia Bunge kwa mara ya kwanza tarehe 22 Aprili, 2021 ambapo alisisitiza kuwa, Serikali itaendelea kufanya hivyo ili Mahakama ya Tanzania isimame vizuri na iwe ni moja katika Mihimili yenye hadhi duniani.</p><p>Kadhalika, Mhe. Dkt. Samia ametoa rai kwa Jaji Mkuu mpya kuendelea na utekelezaji wa mapendekezo yaliyotolewa na Tume ya Haki Jinai ili kuendelea na maboresho ya sekta ya sheria nchini.</p><p>“Nenda kaangalie ni maeneo gani tumetekeleza na ambayo bado hatujatekeleza na tuone jinsi tutakavyoendelea kuyatekeleza ili haki isimame vyema ndani ya nchi yetu,” amesema Rais Samia huku akiongeza kwa kumpongeza Jaji Mkuu Mstaafu kwa kuhitimisha kazi hiyo bila makandokando.</p><p>Akizungumza baada ya uapisho, Jaji Mkuu wa Tanzania, Mhe. George Mcheche Masaju amemshukuru Rais Samia kwa kumuamini na kumuona anafaa kushika nafasi hiyo ya kuongoza Mhimili wa Mahakama ya Tanzania.</p><p>“Ninachoweza kusema tu mbele yako Mheshimiwa ni kwamba, sisi kazi yetu Mhimili wa Mahakama ni kutoa haki na Katiba katika Ibara ya 107A na B imetueleza kanuni zinazotuongoza na sheria zote zinazotungwa huwa zina mambo matatu zinazungumza maslahi ya haki, maslahi ya umma na maslahi ya Taifa,” amesema Mhe. Masaju.</p><p>&nbsp;Jaji Mkuu amesema kuwa, katika kutoa haki kuna kanuni ambazo ni mwongozo na mojawapo ya kanuni hizo ni kutenda haki kwa watu wote bila kujali hali ya mtu kiuchumi na kijamii lakini pia kuharakisha utoaji haki isipokuwa kama kuna sababu ya msingi lakini pia kutofungwa na masharti ya kiufundi yanayoweza kusababisha haki kutotendeka kwa wakati.</p><p>Mhe. Masaju ameeleza kuwa, ataenda kushauriana na viongozi wenzake wa Mahakama ili kuona ni namna gani zaidi ya kuwafikia wananchi kwa kuwa Mahakama imelenga kuwasaidia wananchi (Citizen Centric Justice Service Delivery).</p><p>Amesema kuwa, ili kuendelea kutoa huduma kwa wananchi, atajadiliana na wenzake kuona uwezekano wa kuwa na huduma za Mahakama ya Rufani kwa kila mkoa ili kurahisisha upatikanaji wa haki.</p><p>Hafla hiyo imehudhuriwa na Spika wa Bunge la Jamhuri ya Muungano wa Tanzania na Rais wa Umoja wa Mabunge Duniani (IPU), Mhe. Dkt. Tulia Ackson, Waziri Mkuu wa Jamhuri ya Muungano wa Tanzania, Mhe. Kassim Majaliwa Majaliwa, Majaji wa Mahakama ya Rufani, Katibu Mkuu Kiongozi, Mhe. Dkt. Moses Kusiluka, Waziri wa Katiba na Sheria, Mhe. Dkt. Damas Ndumbaro.</p><p>Wengine waliohudhuria ni pamoja na Jaji Kiongozi wa Mahakama Kuu ya Tanzania, Mhe. Mustapher Mohamed Siyani, Jaji Mkuu wa Zanzibar, Mhe. Khamis Ramadhan Abdallah, Mawaziri, Mtendaji Mkuu wa Mahakama ya Tanzania, Prof. Elisante ole Gabriel, Msajili Mkuu wa Mahakama, Mhe. Eva Kiaki Nkya pamoja na Viongozi wengine wa Mahakama na Serikali.</p><p>Aidha, baada ya hafla ya uapisho, Jaji Mkuu mpya aliambatana na Jaji Mkuu Mstaafu hadi Makao Makuu ya Mahakama ya Tanzania iliyopo Mtaa wa Tambukareli jijini Dodoma ambapo alikaribishwa na watumishi wa Mahakama wakiongozwa na Mtendaji Mkuu na Msajili Mkuu wa Mahakama.</p><p>Kadhalika, Jaji Mkuu Mstaafu, Mhe. Prof. Ibrahim Hamis Juma amemkabidhi rasmi Ofisi Jaji Mkuu mpya ambapo ameahidi kumpatia ushirikiano katika utekelezaji wa majukumu yake.</p>	f	website-repository/newsupdates/2025/4/newsPhoto-1751701906125-963036247.jpg	{website-repository/newsupdates/2025/4/newsPhoto-1751701906125-963036247.jpg}	2025-07-05 10:51:46.128+03
8	0a30ba91-8cba-4f12-b3b9-9c8ff587cd03	1	TUSIVUKE MWAKA NA MASHAURI YA MLUNDIKANO; JAJI NDUNGURU	<p><strong>Na ABDALLAH SALUM, Mahakama-Iringa</strong></p><p class="ql-align-justify">Jaji Mfawidhi wa Mahakama Kuu ya Tanzania Kanda ya Iringa, Mhe. Dunstan Ndunguru ameongoza Kikao cha Menejimenti ya Kanda hiyo&nbsp;na kutoa rai kwa Mahakimu wa Kanda hiyo kutovuka mwaka huu na mashauri ya mlundikano kwenye vituo vyao &nbsp;hasa Mahakama za Mwanzo.</p><p class="ql-align-justify">Akizungumza katika Kikao cha Menejimenti cha robo ya nne ya mwaka wa fedha 2024/2025 kilichofanyika jana tarehe 08 Julai, 2025 katika ukumbi wa mikutano wa Mahakama ya Hakimu Mkazi Iringa, Mhe. Ndunguru ambaye alikuwa Mwenyekiti wa Kikao hicho alisema uwepo wa mashauri ya mlundikano hauleti tija kwa Mahakama hizo.</p><p class="ql-align-justify">Aidha, Mhe. Ndunguru aliwataka wajumbe wa kikao hicho kufanya kazi kwa bidii na uadilifu pamoja na kuwatia moyo watumishi walio chini yao wanaofanya kazi ndani ya Mikoa ya Iringa na Njombe.</p><p class="ql-align-justify">“Ni vema kuwasimamia watumishi na kuwaongoza katika utendaji wa majukumu ya kila siku pamoja kuwakumbuka watumishi ambao wapo chini yenu kwa mambo mazuri ili waweze kufanya kazi kwa bidii na kwa uadilifu,” alisema Jaji Ndunguru.</p><p class="ql-align-justify">Vilevile, Mhe.Ndunguru aliwataka wajumbe hao kufanya kazi kwa ubunifu ili waweze kukabiliana na changamoto mbalimbali zinazojitokeza katika utendaji wao wa kazi na kuhakikisha chochote kinachokwamisha utendaji kazi kinatatuliwa kwa kubuni mbinu mbadala.</p><p class="ql-align-justify">Lengo la kufanyika kwa kikao hicho ni kutathmini&nbsp;utendaji kazi wa Mahakama za Mikoa ya Iringa na Njombe inayounda Kanda ya Iringa.</p><p class="ql-align-justify">Wajumbe wa kikao hicho walipokea taarifa za utekelezaji wa shughuli za kimahakama&nbsp;na utawala ambazo maazimio mbalimbali yaliwekwa&nbsp;kwa ngazi zote za Mahakama za Mkoa wa Iringa na Njombe ili kuhakikisha huduma za haki zinawafikia wananchi kwa wakati.</p><p><br></p>	f	website-repository/newsupdates/2025/8/newsPhoto-1752147449048-146427703.jpg	{website-repository/newsupdates/2025/8/newsPhoto-1752147449048-146427703.jpg,website-repository/newsupdates/2025/8/newsPhoto-1752147449049-564165199.jpg,website-repository/newsupdates/2025/8/newsPhoto-1752147449049-794666826.jpg,website-repository/newsupdates/2025/8/newsPhoto-1752147449050-742544042.jpg,website-repository/newsupdates/2025/8/newsPhoto-1752147449050-131260792.jpg}	2025-07-10 14:37:29.054+03
7	ead19fb5-6ece-4adf-8c29-03a3109be140	1	WATUMISHI MAHAKAMA SONGWE WATEMBELEA MAKAO MAKUU, KITUO JUMUISHI DODOMA	<p>Watumishi wa Mahakama Mkoa wa Songwe hivi karibuni walitembelea Makao Makuu ya Mahakama ya Tanzania pamoja na Kituo Jumuishi cha Utoaji Haki (IJC) Dodoma, kujifunza mambo mbalimbali ya kimahakama.</p><p>Baada ya kuwasili katika jengo hilo, watumishi hao walipata fursa ya kuonana na kufanya mazungumzo na Mtendaji Mahakama Kuu Kanda, Bw Leonard Magacha.</p><p>Akizungumza na watumishi hao katika Makao Makuu ya Mahakama yaliyopo Tambuka Reli Dodoma, Bw. Magacha aliwafahamisha miundombinu ya Mahakama pamoja mambo mengine ambayo yanafanyika katika jengo hilo.&nbsp;&nbsp;</p><p>Ziara hiyo ililenga kujifunza kuhusu utekelezaji wa majukumu ya kimahakama, mifumo ya Teknolojia ya Habari na Mawasiliano-TEHAMA, maboresho mbalimbali ya huduma kwa wananchi pamoja na kubadilishana uzoefu katika utendaji kazi wa kila siku.</p><p>Watumishi hao walitembelea ofisi mbalimbali ikiwemo chumba cha kunyonyeshea watoto, ukumbi wa mikutano, chumba cha Watoto cha kusubilia, chumba cha mifumo ya TEHAMA pamoja na kituo cha huduma kwa mteja.</p><p>Baada ya ziara yao, watumishi hao walionesha kufurahishwa na uboreshaji wa miundombinu ya Mahakama na kuipongeza Serikali ya Jamhuri ya Muungano wa Tanzania pamoja na Uongozi wa Mahakama ya Tanzania kwa kufanikisha kazi hiyo pamoja na maboresho hayo.</p><p>Waliahidi kutumia maarifa waliyoyapata kuboresha huduma kwa wananchi wa Songwe kupitia Mahakama zao.</p>	f	website-repository/newsupdates/2025/7/newsPhoto-1752056199888-949359802.JPG	{website-repository/newsupdates/2025/7/newsPhoto-1752056199888-949359802.JPG,website-repository/newsupdates/2025/7/newsPhoto-1752056199888-510084337.JPG,website-repository/newsupdates/2025/7/newsPhoto-1752056199888-913111400.JPG,website-repository/newsupdates/2025/7/newsPhoto-1752056199892-862377967.JPG}	2025-07-09 13:16:39.899+03
10	454d0033-c0e9-4492-b3ab-6db42daf9c55	1	JAJI MKUU AAHIDI KUSHUGHULIKIA CHANGAMOTO ZA KIMAHAKAMA ZINAZOWAKABILI MAHABUSU, WAFUNGWA 	<ul><li class="ql-align-justify"><strong>Atoa ahadi hiyo alipotembelea Gereza la Isanga Dodoma</strong></li><li class="ql-align-justify"><strong>Apongeza uboreshaji huduma za magereza nchini</strong></li></ul><p><strong>Na MARY GWERA, Mahakama-Dodoma</strong></p><p class="ql-align-justify">Jaji Mkuu wa Tanzania, Mhe. George Mcheche Masaju ameahidi kushughulikia changamoto za kimahakama zinazowakabili mahabusu na wafungwa waliopo gerezani lengo likiwa ni kurahisisha upatikanaji wa haki kwa wakati.</p><p class="ql-align-justify">Mhe. Masaju amebainisha hayo leo tarehe 10 Julai, 2025 wakati akizungumza na Mahabusu na Wafungwa alipotembelea Gereza Kuu la Isanga mkoani Dodoma kwa lengo la kusikiliza changamoto mbalimbali zinazowakabili wafungwa na mahabusu waliopo kwenye gereza hilo.</p><p class="ql-align-justify">“Kwetu sisi hizi taarifa ambazo tumezipata hapa, malalamiko haya yatatusaidia kutambua tatizo liko wapi, hivyo yatatusaidia kubuni mikakati ya namna ya kushughulikia changamoto hizi ipasavyo na kwa ufanisi,” amesema Mhe. Masaju.</p><p class="ql-align-justify">Jaji Mkuu amesema kuwa, moja ya malengo ya kutembelea Gereza hilo ni pamoja na kutekeleza maelekezo yaliyotolewa na Rais wa Jamhuri ya Muungano wa Tanzania, Mhe. Dkt. Samia Suluhu Hassan wakati alipomuapisha Mhe. Masaju kushika nafasi hiyo ambapo alimuelekeza kufanyia kazi maoni na mapendekezo ya Tume ya Haki Jinai ikiwa ni pamoja na kuangalia eneo la Magereza.</p><p class="ql-align-justify">“Pamoja na kwamba ninapenda kutembelea Magereza mara kwa mara, lakini hii ziara imekuja nikiwa na sababu mahsusi, nilipoapishwa siku ile moja ya maelekezo ambayo Rais aliniambia ni kwamba niyafanyie kazi mapendekezo ya Tume ya Haki Jinai,” ameeleza Mhe. Masaju.</p><p class="ql-align-justify">Ameongeza kuwa, pamoja na kwamba taarifa za Tume hiyo zipo ofisini ni muhimu kuzungumza na wahusika kwakuwa wanatoa picha halisi ya wapi pa kuanzia na kujua ni mikakati gani ya kuweka katika kushughulikia mapendekezo yaliyoainishwa na Tume ya Haki Jinai.</p><p class="ql-align-justify">Akizungumzia kuhusu baadhi ya hoja, malalamiko na changamoto zilizotolewa na Mahabusu, wafungwa, Mhe. Masaju amewaahidi kuwa, yatafanyiwa kazi na matokeo yake watayaona. Amewataka pia, Mahabusu na wafungwa hao waendelee kuwa raia wema.</p><p class="ql-align-justify">Baadhi ya changamoto zilizowasilishwa na mahabusu na wafungwa kupitia taarifa zao walizowasilisha mbele ya Jaji Mkuu na ujumbe alioambatana nao ni pamoja na ucheleweshaji wa vitabu vya rufani, kukosa nakala za nia, unyanyasaji katika vituo vya Polisi ikiwemo vipigo, mashahidi kutofika mahakamani kwa wakati na kadhalika.</p><p class="ql-align-justify">Aidha, Jaji Mkuu amempongeza Kamishna Jenerali wa Magereza Tanzania, Jeremiah Yoram Katungu kwa kuendelea kuboresha huduma za magereza nchini.</p><p class="ql-align-justify">“Nalipongeza Jeshi la Magereza kwa hatua kubwa za uboreshaji wa huduma kwa kuwa hali haikuwa hivi siku za nyuma, mimi nimekuwa nikitembelea magereza mara kwa mara, nimetembelea sehemu wanapolala wafungwa wenye adhabu za kunyongwa pameboreshwa sana tofauti na ilivyokuwa awali, vilevile nawapongeza kwa kutumia nishati safi kupikia,” amesema Mhe. Masaju.</p><p class="ql-align-justify">Kwa upande wake, Kamishna Jenerali wa Magereza Tanzania, Jeremiah Yoram Katungu akitoa taarifa ya hali ya magereza mbele ya Jaji Mkuu amesema, kwa sasa kumekuwa na upungufu wa wahalifu huku akiishukuru Mahakama ya Tanzania kwa ushirikiano inaotoa pamoja na wadau wengine wa haki jinai.</p><p class="ql-align-justify">"Jeshi la Magereza lina jumla ya Magereza 129 nchini, na Magereza haya yana uwezo wa kuhifadhi wahalifu 29,902, kwa tarehe 10 Julai, 2025 tumekuwa na wahalifu pungufu ya nafasi zilizopo, tunahifadhi wahalifu takribani 27,000 kwa siku na nafasi zilizopo ni 29,902 tafsiri yake ni kwamba tumekuwa na upungufu wa wahalifu kulingana na nafasi zilizopo," amesema Kamishna Jenerali Katungu.</p><p class="ql-align-justify">Kadhalika, Kamishna huyo, amemshukuru Rais Samia kwa kuunda Tume ya Haki Jinai kwakuwa wamefanyika kazi mapendekezo yaliyotolewa na Tume hiyo kuhusu Magereza na manufaa yake yameanza kuonekana kwakuwa kumekuwa na upungufu wa wahalifu.&nbsp;</p><p class="ql-align-justify">Ameongeza kwa kuushukuru Mhimili wa Mahakama kwa kuendelea kushirikiana na Jeshi hilo hususani katika usikilizwaji wa mashauri ya mahabusu na wafungwa hususani katika matumizi ya Teknolojia ya Habari na Mawasiliano sambasamba na kaguzi za mara kwa mara zinazofanywa na Majaji.&nbsp;</p><p class="ql-align-justify">Mhe. Masaju amepata fursa ya kukagua maeneo kadhaa katika gereza hilo ikiwa ni pamoja na vyumba wanapolala wafungwa wa kunyongwa, jikoni na sehemu nyingine kadhaa.</p><p class="ql-align-justify">Gereza la Isanga limekuwa ni Gereza la kwanza kutembelewa tangu Jaji Mkuu, Mhe. Masaju alipoteuliwa kushika nafasi hiyo. Jaji Mkuu ameambatana na Jaji Kiongozi wa Mahakama Kuu ya Tanzania, Mhe. Dkt. Mustapher Mohamed Siyani, Jaji Mfawidhi wa Mahakama Kuu ya Tanzania Kanda ya Dodoma, Mhe. Dkt. Juliana Masabo,&nbsp;Mkurugenzi wa Mashtaka (DPP), Bw. Sylvester Mwakitalu,&nbsp;Msajili Mkuu wa Mahakama ya Tanzania, Mhe. Eva Kiaki Nkya, Naibu Msajili Mwandamizi wa Mahakama ya Rufani (T), Mhe. Emmanuel Mrangu, Msajili wa Mahakama Kuu ya Tanzania, Mhe. Chiganga Tengwa, Mwakilishi wa Uhamiaji, Watumishi wengine wa Mahakama na wadau.</p><p><br></p>	f	website-repository/newsupdates/2025/10/newsPhoto-1752328363269-823145844.jpg	{website-repository/newsupdates/2025/10/newsPhoto-1752328363269-823145844.jpg,website-repository/newsupdates/2025/10/newsPhoto-1752328363270-978494282.JPG,website-repository/newsupdates/2025/10/newsPhoto-1752328363270-198238147.JPG}	2025-07-12 16:52:43.272+03
11	2048ab6b-ca22-40ac-b06c-f99f1eea940e	1	TMJA NA NSSF WAKUTANA SINGIDA; USHIRIKIANO WATAJWA KUWA CHACHU YA MAFANIKIO KATIKA HIFADHI YA JAMII	<p><strong>Na Mwandishi Wetu, SINGIDA</strong></p><p class="ql-align-justify">Chama cha Mahakimu na Majaji Tanzania (TMJA) kwa kushirikiana na Shirika la Taifa la Hifadhi ya Jamii (NSSF) wameandaa na kuendesha kikao kazi cha siku mbili kwa wanachama wa Chama hicho tawi la Mahakama ya Rufani. </p><p class="ql-align-justify">Akizungumza leo tarehe 15 Julai, 2025 mkoani Singida na Wajumbe wa kikao kazi hicho kwa niaba ya Jaji Mkuu, Jaji wa Mahakama ya Rufani, Mhe. Augustine Mwarija amesisitiza ushirikiano imara kati ya NSSF na wadau hasa Chama cha Mahakimu na Majaji Tanzania (TMJA) umekuwa kichocheo kikubwa cha mafanikio ya Mfuko huo na wanachama wa TMJA.</p><p class="ql-align-justify">“Ushirikiano huu unatoa nafasi ya kujadili changamoto kwa pamoja, kubadilishana uzoefu na kubuni njia bora za kuimarisha huduma kwa wanachama,” amesema Mhe. Mwarija.</p><p class="ql-align-justify">Mhe. Mwarija amepongeza waandaaji wa kikao kazi hicho kilichoandaliwa na&nbsp;Chama cha Mahakimu na Majaji Tanzania (TMJA)&nbsp;kwa kushirikiana na NSSF, na kusema kuwa, kufanyika kwa kikao hicho ni utekelezaji wa Mpango Mkakati wa Mahakama ya Tanzania (2020/2021–2024/2025), hususani nguzo ya tatu inayolenga ushirikishwaji wa wadau katika utoaji wa haki.&nbsp;</p><p class="ql-align-justify">Ameongeza kuwa, changamoto kama za mirathi zinahitaji kushughulikiwa kwa pamoja kwa kuweka mifumo ya pamoja inayotambua wategemezi na kuharakisha utoaji wa haki.</p><p class="ql-align-justify">Kwa upande wake, Rais wa Chama cha Mahakimu na Majaji Tanzania, Mhe. Elimo Massawe ameishukuru NSSF kwa ushirikiano mkubwa walioutoa kwa TMJA uliowezesha kufanyika kwa kikao kazi hicho.</p><p class="ql-align-justify">Mhe. Massawe amesisitiza kuwa, Chama hicho kitaendelea kushirikiana na wadau kuhakikisha weledi na ufanisi wa wanachama wake unakua kila uchao.</p><p class="ql-align-justify">Kadhalika, amewajuza wajumbe wa mkutano huo kuwa, mkutano wa Baraza Tendaji uliofanyika jana tarehe 13 Julai, 2025 mkoani Singida umeazimia pamoja na mambo mengine kuwa,&nbsp;Jina la Chama limebabilishwa kutoka Chama cha Majaji na Mahakimu Tanzania (JMAT) kuwa Chama cha Mahakimu na Majaji Tanzania (TMJA).&nbsp;</p><p class="ql-align-justify">Mhe. Massawe ameeleza kwamba, sababu kubwa ya kubadili jina hilo ni kupisha matumizi ya ufupisho wa awali kwa JMAT kwa Jumuiya ya Maridhiano na Amani Tanzania ambao wakati wanasajili Taasisi yao hii walisajili na ufupisho huo wakati TMJA iliposajili haikusajili na ufupisho huo.</p><p class="ql-align-justify">Azimio la pili ni kuundwa kwa tawi jipya la Divisheni litakalojumuisha Divisheni za Mahakama Kuu, Kituo cha Usuluhishi na Kituo Jumuishi cha mashauri ya Ndoa na familia Temeke. Hatua hiyo ni kutokana na sababu kuwa kabla ya Mahakama kuhamia Dodoma Divisheni zote na Kituo cha usuluhishi vilikuwa ni sehemu ya tawi la Masjala Kuu.&nbsp;</p><p class="ql-align-justify">Mhe. Massawe amesema kuwa, kutokana na masjala kuu kuhamia Dodoma iliazimiwa na mkutano mkuu kuwa liundwe tawi jipya la Divisheni na kuboresha muundo wa Tawi la Masjala kuu na Tawi la Mahakama ya Rufani. </p><p class="ql-align-justify">"Kwa muundo mpya sasa imeazimiwa kuwa Tawi la Mahakama ya Rufani litawajumuisha Majaji wa Mahakama ya Rufani, Msajili Mkuu, Msajili na Naibu Wasajili wa Mahakama ya Rufani pamoja na Wasaidizi wa Sheria wa Mahakama ya Rufani," amesema Mhe. Massawe.</p><p class="ql-align-justify">Ameongeza kwamba, Naibu Wasajili na Mahakimu walioko kwenye Kurugenzi mfano ya Usimamizi wa Mashauri, Idara ya Ukaguzi na Maadili, Maktaba, Wizara ya Katiba na Sheria, Kitengo cha Maboresho cha Mahakama, na kadhalika watakuwa wanachama wa tawi la Masjala Kuu.</p><p class="ql-align-justify">Amewapongeza wanachama wote waliojiunga na mfuko wa FARAJA JMAT FUND na kuwahimiza wale ambao bado hawajajiunga wajiunge kwani dhumuni kubwa ni kuwa na TMJA moja yenye umoja. </p><p class="ql-align-justify">Amebainisha kuwa, mkutano mkuu ujao utakuwa wa wanachama wote badala ya uwakilishi na unatarajiwa kufanyika ifikapo tarehe 13 hadi 15 Januari,&nbsp;2026.</p><p class="ql-align-justify">Kwa upande wake, Mkurugenzi Mkuu wa NSSF, Bw. Masha Mshomba ameeleza kuwa tangu mwaka 2018 Serikali ilipofanya uboreshaji mkubwa wa sheria, NSSF imekuwa chombo pekee kinachotoa huduma za hifadhi ya jamii kwa sekta binafsi na waliojiajiri.&nbsp;</p><p class="ql-align-justify">"Mwaka 2024, kupitia mabadiliko ya Sheria ya NSSF (Sura ya 50), wanachama sasa wanaweza kuchangiwa na zaidi ya mwajiri mmoja, vipindi vya uchangiaji vya zaidi ya miaka 60 vinazingatiwa, adhabu ya kuchelewesha michango imepunguzwa kutoka asilimia tano hadi 2.5, na waliojiajiri sasa wanaweza kujiunga kupitia mpango wa lazima (mandatory)," amesema Bw. Mshomba.</p><p class="ql-align-justify">Bw. Mshomba ameeleza kuwa, thamani ya Mfuko imeongezeka kwa kiasi kikubwa kutoka Shilingi trilioni 4.8 mwaka 2021 hadi kufikia Shilingi trilioni 9.6 hadi kufikia Juni 2025, ikiwa ni ongezeko la asilimia 98. Aidha, michango ya wanachama imeongezeka kutoka trilioni 1 hadi trilioni 2.16 huku mapato ya uwekezaji yakipanda kutoka Shilingi bilioni 527.1 hadi bilioni 543.5.</p><p class="ql-align-justify">Mafanikio mengine yaliyoelezwa ni pamoja na ongezeko la thamani ya vitega uchumi vya Mfuko kufikia trilioni 8.2 kutoka trilioni 7.4. Vilevile, mafao ya wanachama yaliyolipwa yamefikia Shilingi bilioni 947.2 kwa mwaka wa fedha 2024/2025 ikilinganishwa na Shilingi bilioni 884.8 mwaka uliotangulia, ongezeko la asilimia 7.</p><p class="ql-align-justify">Ameongeza kuwa, NSSF pia inalenga kulipa mafao ndani ya saa 24 pindi mwanachama anapostaafu, hatua inayowezekana kupitia uboreshaji wa matumizi ya Teknolojia ya Habari na Mawasiliano&nbsp;(TEHAMA) ambapo kwa sasa huduma za Mfuko zinatekelezwa kwa asilimia 90 kwa njia ya kidijitali.</p><p class="ql-align-justify">Katika mwaka wa fedha ulioishia Juni 2025, NSSF imefikisha wanachama wachangiaji 1,816,026 kutoka 1,358,882 mwaka uliotangulia, ongezeko la asilimia 19. Ongezeko hili limetokana na mabadiliko ya sheria ambayo sasa yanamruhusu kila Mtanzania analiye katika shughuli za kujiajiri kujiunga na hifadhi ya jamii, hivyo kuimarisha uhakika wa kipato kwa Watanzania wote kwa kuwa na akiba ya uhakika na kuwa mnufaika wa hifadhi ya jamii muda utakapofika.&nbsp;</p><p class="ql-align-justify">Bw. Mshomba amesema pamoja na mambo mengine, mazingira mazuri ya kisera yaliyoanzishwa na Serikali ya Awamu ya Sita chini ya Rais Dkt. Samia Suluhu Hassan yamechangia mafanikio ya Mfuko.</p><p class="ql-align-justify">Pamoja na mafanikio hayo, changamoto bado zipo. Bw. Mshomba alibainisha kuwa, baadhi ya waajiri hawawasilishi michango kwa wakati au huwasilisha kwa kiwango kidogo tofauti na kiasi halisi wanachowalipa wafanyakazi wao. Hata hivyo, elimu inaendelea kutolewa kwa waajiri na wafanyakazi kuhusu umuhimu wa hifadhi ya jamii, kuwasilisha michango sahihi na kwa wakati.</p><p class="ql-align-justify">Naye, Mwenyekiti wa TMJA Tawi la Mahakama ya Rufani, Mhe. Shaabani Ally Lila ambaye pia ni Jaji wa Mahakama ya Rufani, aliishukuru NSSF kwa kuandaa kikao kazi hicho ambacho kimelenga kushirikisha wadau muhimu katika kuhakikisha haki za wanachama zinalindwa. Ameongeza kuwa, kikao kazi hicho ni jukwaa muhimu la kuimarisha ushirikiano na kuhakikisha mafao ya wastaafu yanalipwa kwa wakati na haki.</p><p class="ql-align-justify">Kwa upande wake,&nbsp;Hakimu Mkazi na Msaidizi wa Sheria wa Jaji Mahakama ya Rufani,&nbsp;Mhe. Bupe Abonike Kibona amesema kuwa, kikao kazi hicho kimewapa maarifa ya kina kuhusu taratibu za NSSF, jambo litakalosaidia&nbsp;kushughulikia mashauri ya hifadhi ya jamii kwa haraka na kwa usahihi zaidi. Aliongeza kuwa mpango wa Hifadhi Scheme wa NSSF ni hatua chanya inayowawezesha Watanzania wote kujiunga na kunufaika na mafao mbalimbali ya hifadhi ya jamii.</p><p class="ql-align-justify">Kikao kazi kati ya TMJA na NSSF kinachofanyika mkoani Singida, kimehudhuriwa na Majaji wa Mahakama ya Rufani, Wasajili, Mahakimu, pamoja na watendaji wa NSSF, kikiongozwa na kaulimbiu isemayo “Utoaji Haki kwa Wakati kwa Ustawi wa Hifadhi ya Jamii.”</p><p><br></p>	f	website-repository/newsupdates/2025/11/newsPhoto-1752666409994-539360155.jpg	{website-repository/newsupdates/2025/11/newsPhoto-1752666409994-539360155.jpg,website-repository/newsupdates/2025/11/newsPhoto-1752666409995-493896462.jpg,website-repository/newsupdates/2025/11/newsPhoto-1752666409996-949375156.jpg,website-repository/newsupdates/2025/11/newsPhoto-1752666409997-210900154.jpg,website-repository/newsupdates/2025/11/newsPhoto-1752666409997-241827843.jpg}	2025-07-16 14:46:50.001+03
\.


--
-- Data for Name: notificationReads; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."notificationReads" ("notificationReadID", "UUID", "notificationID", "userID", "readAt") FROM stdin;
1	fb50223f-4f62-45d8-b410-37c8d5847ff7	5	1	2025-07-19 12:06:14.431+03
2	14c1e2c5-c440-4b62-8d3d-f50ced419d81	15	1	2025-07-19 15:06:26.085+03
3	c2406798-b0c2-4a88-b4d9-d3c9ceeded44	13	1	2025-07-19 15:09:06.256+03
4	d2aee19b-2ddd-4a93-942f-5d5de08ccd0a	16	1	2025-07-19 20:58:53.158+03
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.notifications ("notificationID", "UUID", "userID", "notificationSource", "notificationTitle", "notificationDesc", "broadcastScope", "createdAt") FROM stdin;
1	957bb409-9936-4f25-8568-c607783f2fed	1	News Updates	News Post Alert	News post has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-09 13:16:39.907+03
2	00645fe7-7f5d-4a45-8e56-4c30a32e9e33	1	News Updates	News Post Deleted	News post titled "WATUMISHI MAHAKAMA SONGWE WATEMBELEA MAKAO MAKUU, KITUO JUMUISHI DODOMA" has been deleted from the website.	global	2025-07-09 13:17:29.057+03
3	1405fce4-5059-4a4a-9eb9-7462a7d77c84	1	News Updates	News Post Deleted	News post titled "WATUMISHI MAHAKAMA SONGWE WATEMBELEA MAKAO MAKUU, KITUO JUMUISHI DODOMA" has been deleted from the website.	global	2025-07-09 13:17:39.931+03
4	5ed4c883-1c71-4097-8ac8-4d960b6dcfca	1	Announcement	New Announcement Alert	A new announcement has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-09 13:29:16.244+03
5	4995964e-219b-4c23-9856-22521810264d	1	Announcement	New Announcement Alert	A new announcement has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-10 13:45:24.735+03
6	72a9e335-3eb8-4cfe-aad8-d51f5ed5bf2c	1	Announcement	New Announcement Alert	A new announcement has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-10 14:23:53.364+03
7	f6d966c0-152f-458b-9eaf-fefb2157e4b0	1	News Updates	News Post Alert	News post has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-10 14:37:29.065+03
8	66ebf4d0-bc91-43e9-8704-141b7c414872	8	User Management	User Account Alert	We’ve set up your website account. Your temporary password is: OTqrEmh3. Please remember to change your password.	personal	2025-07-11 03:43:28.58+03
9	3a1e525e-47d3-4caf-bab2-0101c3080a92	9	User Management	User Account Alert	We’ve set up your website account. Your temporary password is: MDDXNG1l. Please remember to change your password.	personal	2025-07-11 03:52:33.852+03
10	3351ad42-3b81-4435-8358-7de9d46bc65a	10	User Management	User Account Alert	We’ve set up your website account. Your temporary password is: QGPgcE9b. Please remember to change your password.	personal	2025-07-11 03:57:26.588+03
11	df14966f-4c62-4882-9625-0f16a12d5e9b	11	User Management	User Account Alert	We’ve set up your website account. Your temporary password is: I7KUzfhS. Please remember to change your password.	personal	2025-07-11 04:05:12.523+03
12	caa9e207-7c0f-430c-a4d8-09131ca60936	12	User Management	User Account Alert	We’ve set up your website account. Your temporary password is: nIWz87bx. Please remember to change your password.	personal	2025-07-11 04:06:07.633+03
13	152d4ec8-a19e-41ae-ac6a-f1578650d814	1	News Updates	News Post Alert	News post has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-12 16:49:48.604+03
14	a1ccaf5a-da23-4616-99ad-9f884a695270	1	News Updates	News Post Deleted	News post titled " JAJI MKUU AAHIDI KUSHUGHULIKIA CHANGAMOTO ZA KIMAHAKAMA ZINAZOWAKABILI MAHABUSU, WAFUNGWA" has been deleted from the website.	global	2025-07-12 16:50:46.388+03
15	7edddeca-cf07-4627-b10f-cd58d4921817	1	News Updates	News Post Alert	News post has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-12 16:52:43.278+03
16	99c902c7-a98e-45d4-bcb0-ab739d9a9938	1	News Updates	News Post Alert	News post has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.	global	2025-07-16 14:46:50.015+03
\.


--
-- Data for Name: publications; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.publications ("publicationsID", "UUID", "userID", category, title, "contentType", "contentSize", "contentPath", "createdAt") FROM stdin;
1	0f3ef058-6dd1-4c0a-ad26-422a78501ffe	1	Form	Fomu ya kufungua kesi	application/pdf	448087	website-repository/publications/Form/2025/1/vacancy-1752565168613-329137792.pdf	2025-07-15 10:39:28.62+03
2	eb5a56bd-4388-4d25-989f-9305a1548574	1	Form	Fomu ya udalali wa mahakama	application/pdf	448087	website-repository/publications/Form/2025/2/vacancy-1752566036245-949060969.pdf	2025-07-15 10:53:56.251+03
3	81513aaa-bebf-44ac-8ba0-c527d152a12d	1	Report	Judiciary Report for FY 2024/25	application/pdf	1772636	website-repository/publications/Report/2025/3/vacancy-1752925453212-780650326.pdf	2025-07-19 14:44:13.22+03
\.


--
-- Data for Name: tenders; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.tenders ("tenderID", "UUID", "userID", "tenderNum", "tenderTitle", "tenderDesc", tenderer, "openDate", "closeDate", "hasAttachment", "attachmentPath", link, "postedAt") FROM stdin;
1	8d3da2d7-6b5e-4c5b-8ca2-7f228a021ec1	1	IE.007/CCP/67572/2018/19/G/39	Supply, Installation and Commissioning of Furniture for High and Subordinates Courts for Judiciary of Tanzania	N/A	Judiciary of Tanzania Headquarters	2019-02-28 03:00:00+03	2019-03-31 03:00:00+03	0	Not Attached	http://localhost:3001/webcontentsmgr/tenders	2025-07-05 10:58:02.809+03
2	b9b12bc2-0043-4f1d-a5b1-0c1146b5913e	1	IE.007/CCP/67572/2018/19/G/39	Addendum No. 1 to the Bidding Documents: Bid No IE/007/CCP/118965/W/2019/2020/02 For Construction of Integrated Justice Centres (IJCS) in Six Selected Locations of Mwanza, Morogoro, Arusha, Dodoma and Dar Es Salaam	N/A	Judiciary of Tanzania Headquarter	2020-02-18 03:00:00+03	2020-03-30 03:00:00+03	0	Not Attached	http://localhost:3001/tenders	2025-07-05 11:15:04.548+03
3	590a14a7-7c3b-4fb5-9191-3631f8451b8e	1	IE/007/CCP/118965/W/2019/2020/02	Construction of Integrated Justice Centres (IJCs) in Six Selected Locations of Mwanza, Morogoro, Arusha, Dodoma and Dar es Salaam	N/A	Judiciary of Tanzania HQ	2025-07-19 03:00:00+03	2025-08-31 03:00:00+03	0	Not Attached	http://localhost:3001/tenders	2025-07-19 15:17:04.846+03
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."user" ("userID", "UUID", "worktStation", "userEmail", userfname, "userMidname", "userSurname", "userPassword", "userRole", "userVerfication", "userStatus", "userCreatedAt", "userProfilePicPath") FROM stdin;
1	cb79948a-f4f4-449d-b533-b47a9f908911	Headquarters	elyson.mushi@judiciary.go.tz	Super	Admin	Admin	$2b$10$1VHv.8S/dlU17tZE95WLt.UmIbkyfHAThmrqIr.DrlEa/IGj/mNH6	Admin	1	Active	2025-07-02 11:56:44.479+03	\N
12	37e59c53-0f74-4d9b-a96f-76e25c449fc8	Headquarters	elysonmushi92@gmail.com	Elyson	Godson	Mushi	$2b$10$d5JbYGXZ1BhzQ37roUV3bebU1kuEJmP00FOMCcfBFfqFpLOJy8Kbu	Content Manager	0	Active	2025-07-11 04:06:07.545+03	Not Attached
\.


--
-- Data for Name: vacancies; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public.vacancies ("vacancyID", "UUID", "userID", "vacancyTitle", "vacancyDesc", "vacantPositions", "openDate", "closeDate", "hasAttachment", "attachmentPath", link, "postedAt") FROM stdin;
\.


--
-- Data for Name: websiteVisit; Type: TABLE DATA; Schema: public; Owner: userdb
--

COPY public."websiteVisit" ("visitID", "UUID", ip_address, user_agent, referrer, page_url, session_id, device_type, browser, os, screen_resolution, country, city, language, is_bot, "visitedAt") FROM stdin;
1	a7c4a381-b186-4245-8995-24e0f43f67b8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:36:37.152+03
2	124ad139-24c0-4e25-827c-dc0e4d4384c1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:36:37.157+03
3	310f5d60-e673-4b13-afd6-c196293e13f6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:41:13.792+03
4	da21f53e-c06c-403c-9acc-9dce8a5c45f4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:41:13.798+03
5	6c01d903-98cf-463b-ad32-85149afdac1d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/corevalues	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:41:56.135+03
6	31e12302-6e5a-4e32-9a9d-ff7fa5f64e1b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/corevalues	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:41:56.137+03
7	b1c4a5d7-2a3e-4cb7-b57d-f2722c3d6e6c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 12:54:21.7+03
8	87260e3b-8d28-49ec-8290-61462e42476e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:04:32.949+03
9	d6bb716e-aaba-4d19-a89d-0b9c22f2e5b6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:10:11.187+03
10	c74f6d75-0e82-4f32-ba6f-7edbd0c9786e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:10:25.488+03
11	7476ed23-592c-496b-8bfb-ab80108f2fd5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:12:52.02+03
12	afcf727d-1997-430b-b70f-549f6ab785f8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:12:52.033+03
13	02516e70-00f3-438b-9906-f6f2392c83a0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:24:22.967+03
14	96f04874-281a-47b5-9bb9-64596d3b509a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:24:22.975+03
15	8c04c507-0d0e-441a-81d4-065e4adf5a3f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:39:18.028+03
16	eae5451b-81e2-4a37-af17-e59b655adc3b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-02 13:39:18.03+03
17	c9f6db9b-202a-4f48-b020-e821c7bb42aa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:13:28.756+03
18	164121cc-2370-407e-896f-6ecfa4fea3eb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:13:28.77+03
19	0875a3e8-aeb4-450c-911c-46e182331abe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:15:06.596+03
20	7d92cbf8-a9d3-4ed3-8e66-819b297897da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:15:06.6+03
21	20a4989f-3386-4d49-bf83-4afd47a998ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:16:10.75+03
22	e2c5ff88-f881-4d6a-94f3-07ace0310e25	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:16:10.756+03
23	ec259178-0507-4c36-9595-da1d4d985b5a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:16:17.458+03
24	8a99424b-be08-4b36-8936-1bac1b9bf9c3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:16:17.468+03
25	799f1b76-0f84-4e29-bbb2-c0caadde81f9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:16:34.681+03
26	4a6fdf87-86a2-4dcb-a267-b5ea4ccede49	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:16:34.691+03
27	daada529-c587-444e-a4cc-d737866b5f89	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:23:39.198+03
28	2f1fd23b-3acd-4b41-a7fc-dd9cfbb25069	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:23:39.206+03
29	c337d0ab-dcac-49d7-a223-c1c01e81a44d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:38:03.582+03
30	84e21d2d-eb8e-4320-b0ee-3eae84cd7254	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:38:03.593+03
31	2aa71a3a-58c2-4035-a403-14e72953cb9b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:38:09.873+03
32	741c0f6d-6b07-495c-ab33-b2526b494faa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:38:09.881+03
33	78d7f266-b038-4cc7-9893-2060ed806ce8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:39:46.543+03
34	1a3e01d5-32ba-4399-af12-2b49662b4e66	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:39:46.553+03
35	5b5b414d-52e0-4105-8f24-64d3149e9996	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:42:48.559+03
36	49e2a016-b5cf-4784-8878-6e9692ee34ea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:42:48.573+03
37	0c5d34a2-1ef6-4d36-bc4c-ae3351190710	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:45:14.951+03
38	4cc4f07b-e22b-4d22-b1ae-e09171bd1867	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:45:14.963+03
39	277a627c-2a7c-428f-8413-50ec40428c53	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:45:38.726+03
40	1a8f37d4-84d1-4c37-8ef7-c4091037d27c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:45:38.735+03
41	8156af2e-d8a8-471e-8565-4798f54e1224	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:46:16.235+03
42	a663d6a4-5ba2-41d6-a801-d8f1cf634c5a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:46:16.244+03
43	281302e8-00d2-48ab-9a63-98712f9b481a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:46:22.467+03
44	22f52aa4-7f42-49ae-95dd-ae6e22bf9f3a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:46:22.478+03
45	06bf3589-2083-4d8b-923e-a6ca7a9a9fdc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:05.255+03
46	69ff909e-4a9c-4224-aec9-f770e889f362	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:05.264+03
47	5e0ae5eb-cd96-4013-b391-f155835e78ff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:08.022+03
48	2d20167b-7ca6-433e-9f0e-b4f77bbd995d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:08.03+03
49	f504771e-cde7-4597-ae34-815f68cfeb5a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:12.335+03
50	5db52e24-f3f4-4069-a92f-cf3cf6336320	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:12.352+03
51	8c076a54-e6dd-42c7-af04-cf853f31b233	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:16.749+03
52	29c28043-4cde-4f82-9d10-669cfaa195ea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:48:16.756+03
53	1447783c-82ce-43f4-b00c-5553c3ba1850	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:49:30.39+03
54	f74b092d-268a-4c2d-8be9-957515423d38	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:49:30.398+03
55	f71e6bcf-1b88-4e35-a584-985b0640d259	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:49:53.752+03
56	b188961c-bb7d-4e58-a6ca-3a13c59bf1db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:49:53.763+03
57	cca0c97d-49d4-47e9-a390-65cb8b4a2fa2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:49:56.426+03
58	9db36dfe-004a-460f-aea5-e05f1849409e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:49:56.435+03
59	304a3569-9cfd-4474-b5b2-0ff5a99bdac6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:49.961+03
60	58b36a58-b3c2-492e-8f3e-bbb27379e7f7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:49.968+03
61	63eb3ef6-8edb-42e2-afa3-25ddc1da225f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:52.293+03
62	e464c814-f9ca-4420-9a5b-aa5319f02a8b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:52.308+03
67	904b3aa2-93ea-4dfe-ab20-93dc83a66631	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:51:01.246+03
68	bea07a78-059f-477e-ae59-28430bb1174d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:51:01.255+03
1224	f3db7eb0-5c93-49db-99d0-9071f1ff1a61	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 00:24:43.995+03
1225	e28fc394-6f2a-488c-9fc9-8c72a88571bc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 00:24:44.003+03
1266	292e2299-7eda-4e1e-9d3b-997277768020	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:08:54.144+03
1308	ea760074-24c7-4592-b27c-069690908099	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:44:19.865+03
1347	b6ea5a9c-da98-402c-9d0d-1b1715143a3d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:24:56.947+03
1382	792d7e2b-a3a0-4582-96bd-5aac7031751b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:24:47.18+03
1383	0a4b4b69-8b45-4aa1-8e75-5b22c030fdd3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:24:47.203+03
1384	453224db-8fd1-401a-92d8-5576b48e5fe0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:24:47.25+03
1385	e704345e-9c56-41d3-b3eb-959c369f786d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:24:47.254+03
1408	d820640f-488a-4afd-8ad6-2c456b2f729c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 22:08:35.474+03
1427	f95b2322-1b38-4c4f-b206-9aa6dade121c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:50.2+03
1435	c6bed31e-b80e-424c-b6f8-1b80badff790	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:10:58.461+03
1436	b5111b6e-9736-4a12-925f-c661bc802555	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:10:58.467+03
1443	bfc9cc01-bd0e-48c4-9a59-411a5926c9bd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:37.472+03
1444	ad70cef8-2acf-438c-9569-c3ee7dc46feb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:37.475+03
1445	76f27684-c431-4f5f-a8a3-4303f2e028e7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:44.451+03
1446	98f2bf0e-01b4-4edc-8160-6f741386403b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:44.454+03
1447	457f1b3f-38f2-43e7-a553-272a4d7d4876	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:46.014+03
1448	92e20437-769c-4775-8798-7c30b7dbcd2e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:46.019+03
1453	cc07e401-6bb8-4551-81dd-004fc52ce120	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:06:04.859+03
1454	c1bb2957-cb42-4ba7-98b5-b73c8f2b98aa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:06:04.865+03
1459	9bcb6b4b-fbfa-4919-a7b8-675d45ca6826	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:15:23.434+03
1460	295aa9f2-8373-407f-8682-49d99b447326	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:15:23.439+03
1461	aec2f479-e4b0-4024-8d86-9d86accba681	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:15:25.373+03
1462	8fd11a40-4929-4b9e-8b07-3a6c4119bc9d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:15:25.378+03
63	da884592-ad38-4dd1-a78c-3dd36d0ae64c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:54.208+03
64	7cb63044-90b1-4cf8-bf91-c33465d0c6c5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:54.217+03
65	fb5f1490-e109-4d8c-b23d-54d609203cbc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:57.269+03
66	f571e37a-58dc-46f9-9963-a1dbb229af3a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:50:57.287+03
69	d55c825a-ece2-4007-9530-80ba7c2e52ee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:51:03.628+03
70	0e8447b6-a32c-4cd2-aed2-f96d1befda08	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:51:03.636+03
71	dce16f78-3e00-41bb-b18a-5055486d43e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:01.737+03
72	ee0987f7-ef74-4e53-b977-08c94503c95c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:01.744+03
73	ba11f331-6449-431d-b46f-5d19122d9f75	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:04.262+03
74	54d20d00-8d02-43ed-a226-21102387fd7c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:04.269+03
75	0fe8a4c8-4ec0-4766-8581-2d398cd9a41b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:06.683+03
76	fadc6764-be8d-4921-8b7e-8a2e94876b67	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:06.691+03
77	a0aa7e7e-eae4-487d-a8e8-481644385ba0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:10.725+03
78	88f7eb9b-0661-42d9-aaea-0c0fe0eea659	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:10.735+03
79	2202828a-f019-444b-80a9-77cfe1661c66	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:12.889+03
80	651ec69e-cf3a-46ca-990a-0e7d6d1754c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:12.897+03
81	19b57c38-0d24-4950-b9a7-bd4d0c579ba3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:15.267+03
82	4f96ed05-e9e0-4e0d-b113-022fcd0357c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:15.277+03
83	e8f35821-f2a5-468e-8ad9-b934af2ba900	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:21.711+03
84	22c4fc6d-c6b1-41ef-83e0-b03ae8086cbf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:21.719+03
85	43beea68-3a56-4a8d-b1b6-af7554b7f053	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:24.776+03
86	85bf4c8e-af0b-419a-a9f0-befc90cedb5f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 10:52:24.786+03
87	efbdc969-2b0f-4c14-94cf-020f54f1b180	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:02:50.48+03
88	fc1c9872-e0c1-4161-96d6-5ddedb965f22	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:02:50.491+03
89	08f4240c-4b56-48b7-a086-485ed684b311	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:02:50.535+03
90	5e70d5e7-1bd7-4ad7-a3de-40fe6f15946c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:02:50.539+03
91	8d134c70-d6a6-42b1-8737-8b23a5bc4001	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:02:57.199+03
92	285315d8-6ef1-46b0-89fd-d9eee091fb62	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:02:57.206+03
93	09d83aaa-6871-4ca9-aa94-125f4278124f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:09.432+03
94	78ef5bea-e21d-4fd7-a1b6-c8ba3a3bd09a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:09.439+03
95	10826d1c-5256-4659-9ac5-3153a6794316	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:11.81+03
96	807955c7-6215-48c8-8820-83e70a4b0a01	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:11.817+03
97	4dacfde1-8b00-46ed-8357-6cee7ecaa3bd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:14.791+03
98	235256ce-a0cc-41b8-b8fd-0a09be8910a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:14.799+03
99	313b5f53-cc3e-4c38-b85d-de607ba15ae6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:17.114+03
100	cdab109f-503c-4fdf-b3b8-657f71f06fdd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:17.122+03
101	0e1c6bba-eaf6-4015-88cb-07c60900ebb0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:20.949+03
102	e72fa175-1e5a-4e74-9474-c3239ed9f26c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:20.967+03
103	28ce41b5-6bd2-4411-82f8-4aa9073c51f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:23.626+03
104	88bcbf6c-29d6-4e82-b4ce-dd302f57e2f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:23.633+03
105	efe0c4f2-0a72-4a07-8ca7-41044891a9dd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:26.026+03
106	8c958cdf-eb50-4b4b-8bc0-136952597e81	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:26.034+03
107	a0e40a8e-ed3a-41ff-b5c5-7f3f90dd0e42	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:29.854+03
108	fe2292c3-fb23-4f83-8712-abb1d47f86df	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:03:29.862+03
109	dcd799b8-a6aa-4e01-90f0-da20ae3a68fe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:05:33.159+03
110	a6020ba0-2050-48bf-8ba5-22b7d08f79f6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:05:33.166+03
111	bf84a7cb-c7b5-4456-b8da-ae9839e415a9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:05:37.511+03
112	fb541e7c-f401-4a21-b7a0-01cf85222cd1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:05:37.52+03
113	45cff1ed-5cc4-41ac-bf78-a553b86ed6fd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:05:42.952+03
114	b8722144-6050-40a3-a1e7-01410bed136a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:05:42.961+03
115	60ab66fc-e7b6-46dc-b3b5-ea983b396ddf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:08:30.936+03
116	58ba8a77-cda5-4b1a-80d8-057a83de0df0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:08:30.944+03
117	2933cd33-2cba-4429-8e6b-6a6e863793cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:08:35.05+03
118	d2bd2889-4770-4d83-88dc-e4217f135187	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:08:35.059+03
119	2664c2a7-5a54-4eb1-b6b3-ae7320bdec33	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:08:49.406+03
120	e6aa37e4-8c57-477a-84a3-a7a9879e309f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:08:49.414+03
121	bddbd8e2-9a82-4589-8511-57dd789af4fe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:09:02.564+03
122	22d6bbe4-56b1-48b6-9fd4-ec0d79185064	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:09:02.573+03
123	c094b0b5-e72f-485e-b98e-e6245c5d7b93	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:10:01.305+03
124	c32ec05c-4ed6-41af-9f69-ace006f8352b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:10:01.313+03
125	d3a4744b-1cb1-4781-9b30-5e3a2410835b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:10:47.723+03
126	806a7f24-0896-4173-acba-ec7b6bf1b1de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:10:47.733+03
127	2b663d4d-e47c-4cc8-b1cf-616eb37a87cf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:11:00.733+03
128	05d87cd1-164b-4d47-8550-816bc25b017b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:11:00.741+03
129	538e016d-fc33-4874-ac65-74c88f90bea3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:26.639+03
130	985cc092-a0e7-43ee-aef1-2610200019a0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:26.65+03
131	e9ef9a29-e10e-4dd9-92a4-83e5cf94b67c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:29.721+03
132	8cd719c9-ed91-4398-a5ce-ea5ab3845d5c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:29.729+03
133	00d58951-13a8-4daa-9ac3-d04f110e23cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:32.288+03
134	f247518a-1cea-4f35-8924-aae700d21b82	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:32.297+03
135	ce653b3d-a916-456e-92b5-b89647f20307	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:45.463+03
136	406e08bb-fee9-4d69-b40b-cd9e2f8c181d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:45.471+03
137	236816e6-a7e6-4f16-8d37-4d0bbb5caa2f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:48.882+03
138	1c8a2ab2-7446-4c90-8d85-1d197c2a744b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:12:48.891+03
139	03154dd4-f016-4454-ac28-e1812de961f6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:13:07.733+03
140	7dca4be0-fcad-41c5-9c5b-86bef2a00b1e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:13:07.741+03
141	53f54da6-7c1f-4de8-abb7-26c74c429d69	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:14:36.006+03
142	551925ac-d889-4159-a3bb-54a2acb01995	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:14:36.015+03
143	9c58afdd-ee36-4cba-b68f-deae189f5d77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:14:38.57+03
144	75801436-e298-44cb-addb-46fdd0d3be39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:14:38.578+03
145	6944054b-2997-4d0d-9834-5ec5fb0eedba	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:15:14.137+03
146	ef5c927c-bf9a-4f66-9768-a2e6e8df871e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:15:14.146+03
147	e6e92da9-7480-4e1c-bfb3-5419129174df	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:24:59.692+03
148	f928604f-21e3-424b-bd40-2f905d74a251	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:24:59.702+03
149	83949f93-99f3-4c2c-bbb5-79d787c89c0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:25:00.291+03
150	be249b00-4746-4a7b-9cc9-f74e0dfb99cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:25:00.294+03
151	3f942057-6959-4000-b402-fec5f16b96de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:27:23.673+03
152	0be743d5-9924-4a70-af7d-6e89d135372c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 11:27:23.683+03
153	54f35e31-f108-41da-a913-200ff5ffcb6a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:02:36.549+03
154	c6053cd6-97b5-4cd9-8a27-6531ad717337	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:02:36.56+03
155	c0c72eb1-5da9-4af2-b4c3-260d2759ea23	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:02:39.333+03
156	cf4b2993-09c3-400f-9538-90ac07c2d4e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:02:39.345+03
157	f76a4931-d979-4035-b080-e2a710b20ae8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:03:01.554+03
158	e3951c45-8f95-410f-ae10-b9ba770f84cd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:03:01.561+03
159	70c10b4d-d7d0-4cb0-82ef-1ea5b4e58197	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:09:04.928+03
160	c0e5184f-bf01-4927-8f6a-ff96d2e4f7ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:09:04.941+03
161	cbbf27d2-c5e7-4456-aa7b-fc59f2774ff2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:28:09.555+03
162	e9ad3181-6456-418d-9c00-b1651c5d75fa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:28:09.569+03
163	04747eeb-b4c2-4300-9bc0-ba88c74307dd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:30:13.311+03
164	71e848c6-7171-4ae4-b3b4-1533c5716303	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:30:13.323+03
165	d43ac104-e71c-47cd-8047-64d9d87729e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:30:19.124+03
166	687a204c-237e-4b1a-b4c3-704a90f01326	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:30:19.133+03
167	ec8f4dc1-e534-4983-a7c7-b056e3c32fb4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:32:03.439+03
168	fb748c19-0fe1-4a42-a633-2d9808c81334	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 12:32:03.451+03
169	74ef2124-a4ae-414c-932b-1a200b35ae6a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 13:04:31.092+03
170	aff4b058-d2dc-4a10-ba3a-f52cd12fbaa4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 13:04:31.102+03
171	479442be-6aeb-4aac-89e5-91edbe9cce0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 15:37:54.18+03
172	536fcf76-d3e3-4627-baac-80ef8f1e258b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 15:37:54.189+03
173	0363baa3-9a4e-4e0b-b537-1bfedf4df0ee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 15:43:25.619+03
174	70026445-34c8-400b-a258-6c9b9f83cdfd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 15:43:25.628+03
175	eaa8dba4-28cb-4562-b078-5dc9922544cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 15:44:33.792+03
176	b1e754a5-4129-4f13-a898-0160dc33ae4f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 15:44:33.807+03
177	cc264e98-56ac-47b9-8ee9-88474dce2c80	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:09:23.52+03
178	318cc045-7276-401f-8b20-976258555095	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:09:23.529+03
179	fb64d76a-e567-4974-ac96-230c2ecef053	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:13:45.945+03
180	34aa70dd-a501-4bf2-a748-1d337b4d00da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:13:45.953+03
181	45df093b-9f17-4538-8071-2011fbb5252e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:15:12.405+03
182	d0eb7237-dc72-4f70-8975-79f46f9e0049	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:15:12.415+03
183	a07f57ea-ed41-4c8d-bef4-c6be974e3f7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:21:48.103+03
184	e7f79b5c-83e3-4432-88f8-f65b3e409cb2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:21:48.105+03
185	ffa63acb-8d2a-41e3-b31d-e87e48fb0221	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:53:44.257+03
186	491eaaf8-6288-46fb-855b-2594ff6efe7e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:53:44.262+03
187	f169b4c3-429f-4ff2-8efe-2bac3e2ca076	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:55:28.9+03
188	6ccf51c3-803f-4470-9b3a-8b605f5a6ca6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:55:28.905+03
189	7bb018d9-b6e9-4d34-a288-5e7a39c3f3ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:56:19.154+03
190	b852d990-d0cc-4ac2-bb65-1ac6ef414204	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:56:19.157+03
191	dd1b990e-2ad4-4f31-b40b-2c150c8f25c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:56:20.179+03
192	5e76d595-2c53-4d6d-9ded-707d64fdd869	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 17:56:20.182+03
194	ac2af386-b24a-434d-9c3b-ba045c959b1d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:09:09.366+03
193	4b95bedf-9b0d-4904-9e20-e94b8301d5e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:09:09.365+03
195	d083477e-b8c1-495e-8317-29c8e3e02163	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:21:03.532+03
196	0c223b24-9f60-4c05-8d56-14c819525f4b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:21:03.54+03
197	a2bfdc23-6e55-4611-98ee-143e092dabde	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:21:09.633+03
198	7ace980e-e5c7-4981-90b1-7b922af0d710	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:21:09.638+03
199	3120b4c9-9637-4329-ac2f-2f37c8a1ca15	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:21:43.229+03
200	093a3500-5c40-4177-9daf-f8b227a94f68	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 18:21:43.233+03
201	01cd9c60-c332-42b2-81c5-7f8227b9e479	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:01:23.65+03
202	b2345ecf-3e21-47f8-bfc9-74089df4e9f9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:01:23.657+03
203	63e1ff13-8912-4de9-9fad-4f495b069194	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:20:26.429+03
204	62a50b2c-391d-4991-b0a8-6d6edf5d038d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:20:26.442+03
205	a38559b3-6bb8-4b17-be9e-7fa85be8d13a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:24:48.198+03
206	fbbb3414-7dd5-4382-8f4d-8c63f768b7fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:24:48.207+03
207	a206f35f-5028-4bb6-8fd7-e214ca2bde71	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:25:10.043+03
208	927a8793-e82d-4ee3-8352-274949a303f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:25:10.051+03
209	d8755af7-cb2f-4787-9615-4897c570b733	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:25:13.905+03
210	0a0b0340-41c4-4193-a804-67ddedd1ecce	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:25:13.912+03
211	a8fba6c8-d1af-40d7-b655-31a640fd37a2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:26:40.701+03
212	03d74e51-1dcb-4083-8d2b-e0c84d2b011f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:26:40.711+03
213	2737d434-b053-44c9-b31d-7912d6df0911	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:26:46.317+03
214	9da94908-2c02-4635-8325-310ebc1c37b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:26:46.326+03
215	de7e8d60-de6a-4e5c-8dd1-d99a09dfb6aa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:27:34.908+03
216	c7264a02-2d56-40f3-b1d9-84bb6b3252fe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:27:34.915+03
217	b54ce18b-37e9-4f33-a4f7-d9a74204fba4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:14.458+03
218	db0fb71d-dc14-466a-a2b1-b3c616770dab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:14.468+03
219	46bfdd70-54d0-4b66-a9db-2253145c45ff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:17.778+03
220	029b5bd9-bdb8-411a-a706-3c343e7f1a3a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:17.787+03
221	463238e4-13c4-476c-8d34-89e1e5de8088	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:20.905+03
222	8172926c-dd09-4319-95c4-0d45103ceaf9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:20.914+03
223	d4ac44e0-97c4-4eaa-a68a-70d76da7f2c0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:22.743+03
224	02cb61f8-62f2-4dff-acda-ffc05d7f25f4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:22.751+03
225	73140aee-cc2c-4d2a-9a63-07e9eb245790	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:27.399+03
226	d8afd9de-be6a-4663-a3bb-ed56893eca0b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:27.407+03
227	e2ea7e8e-c5f3-42c2-a018-3d485e79ebea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:41.127+03
228	2decb4bf-6484-45bc-b27a-b44821e9b440	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:41.135+03
229	1c7c1f6b-610a-4fd2-a4ce-d7e0367d6c5c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:43.684+03
230	a0a493a7-c803-4fb6-953e-e8459e73711e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:28:43.691+03
231	96eacc90-0d7c-4687-bafd-d2d7a5571971	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:29:14.359+03
232	c2f3a7dd-1ae5-490d-b68c-cccda55a9c8a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:29:14.368+03
233	b6938cd1-7154-4102-87b0-22359864b3a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:29:38.686+03
234	b604f0fb-de60-496f-99ef-b61f7dacfd2a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:29:38.695+03
235	e3742d94-26e3-46e9-b61f-1f59f6f5c685	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:29:43.406+03
236	596bf144-4e7a-4bb5-943f-70e2de589bfb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:29:43.415+03
237	26f4c14f-02af-443c-8fe5-4c69b2b60292	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:09.578+03
238	eb00d094-d788-4655-aef5-2b4cc948cf77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:09.585+03
239	cd9d1a60-ee7b-44c9-a120-3433d73d44d8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:22.736+03
240	8eab90cb-027a-40e5-90d3-e1d9209f76d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:22.744+03
241	3b02dcdd-6d7c-4e9b-a3cb-252624419e7b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:52.595+03
242	658bd8e4-2740-482b-af9c-d8ab71756a40	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:52.603+03
243	fb5a4d0b-63aa-412f-ac34-4b7d59fe33e7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:56.558+03
244	c5d88a46-6900-45b5-8bde-45c2cf44cb18	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:32:56.566+03
245	223167f4-ff68-4843-99d2-02163fa89d39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:33:38.874+03
246	f254a3b1-a2a9-4327-bc71-e37ecd9ae23f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:33:38.887+03
247	9ec5fe0d-742d-45d3-8ccf-ed970f7349a6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:33:42.71+03
248	f2afb1b8-1b3f-464e-b222-92324ce5c2f0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:33:42.718+03
249	b3541616-dc68-4ada-9be1-d9f472e8b2b4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:33:55.376+03
250	4b86c2d6-188e-499f-92fe-05d3d1444d51	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:33:55.385+03
251	6da013d6-3a7e-4af7-8354-0f9e6749eb77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:36:31.798+03
252	01d7d8a1-4069-498a-9ba5-f9a6808c9863	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:36:31.808+03
253	ecf5b231-216f-41e0-89e8-255a842e8145	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:37:38.928+03
254	b4c909d9-be66-4554-90bd-2a2a08468259	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:37:38.937+03
255	a819e2f0-989e-4a98-ab3a-678aa693fffe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:37:43.188+03
256	abce16e5-680a-4ca4-a7a7-83d13035a50d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:37:43.197+03
257	45a57a57-c39b-4d4b-9485-5c009aec5923	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:37:51.06+03
258	dc242cd7-4c4f-41d6-b126-2f1b46f18cbd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:37:51.069+03
259	2dec2727-7793-4e65-b099-8409525856d8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:38:13.023+03
260	975b8e16-17e7-4ddf-9fc5-e8e10197cfdf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:38:13.038+03
261	042cd284-6922-4a10-b901-a303776c4482	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:41:43.823+03
262	617d3a6a-74a4-42cb-9510-ed78a3611dc2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:41:43.833+03
263	4a8c410a-78a7-4bbe-b390-c8e519fdd7eb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:42:57.798+03
264	3d3c3a9c-4b24-4925-8ec3-23242120d8ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:42:57.809+03
265	e96ecbec-d6fe-4ab5-85a6-c771cd15f403	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:43:40.232+03
266	407c5d24-7faa-426e-80be-5df705a34ce6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:43:40.247+03
267	8074a51f-d635-4b0b-a95a-202af69ab161	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:43:44.104+03
268	3154f3af-cff9-4794-a582-02a5e864b228	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:43:44.113+03
269	11473fde-c908-4c59-b666-f22689680a7d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:43:49.235+03
270	fa313974-90f2-4960-802d-bfdcc6219c89	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:43:49.244+03
271	e8c281c2-f302-43a3-b9da-b5b15356eb81	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:15.539+03
272	2d403020-4485-4fbe-b6c0-a72bc0d875d3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:15.549+03
273	c77fe837-eaaa-4e2c-a03d-963fd2d278c2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:20.187+03
274	477e97e9-3f3a-4cb8-bdc1-23d30b0b9470	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:20.194+03
275	1b70e3de-8b9a-4ae3-830f-76d346d238d0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:31.403+03
276	6eb92f73-7678-4214-9d36-cc5cab316a7b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:31.41+03
277	84d5bab4-854c-45d8-959d-1f83886f6da7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:54.991+03
278	acd887d5-988b-4f9b-8240-8debb0b44698	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-03 19:44:54.999+03
279	ab8e2c8d-093d-4ad8-934a-1db651e400a3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:08:22.461+03
280	13fd050d-651f-4956-b37d-0d6b04eab1ac	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:08:22.469+03
281	0fc0beeb-5861-4ca8-b52e-c604f5f36f7e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:13:40.656+03
282	747992f3-3126-42d2-ba3f-84775784c65e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:13:40.672+03
283	4b9d8646-0f60-41aa-ab74-33817bb720a2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:14:48.589+03
284	c96f04aa-a5cc-4828-8ef0-64d19e5bdc7a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:14:48.611+03
285	5c8620f4-6592-4863-84c6-423cd6d0413e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:21:35.693+03
286	7b31b400-8d99-4299-8a7d-fc2fcb7f01c0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:21:35.698+03
287	7e71e48c-7387-4cf3-92a2-746ad687d961	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:21:50.99+03
288	f3f8fb12-16f4-4308-b4e7-73318be2f4ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:21:51.009+03
289	9462bc10-8652-49db-b341-c9bb78a74419	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:22:15.295+03
290	36277400-6320-4bdd-b10d-c9a99d42b2e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:22:15.296+03
291	7bdd599d-1ae6-4f5e-a380-6254cef34946	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:25:05.138+03
292	a71fd412-ac4d-4c00-bfe5-ba5a2237b183	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:25:05.143+03
293	e8a06da8-bc61-43ff-bc8a-2a1b96f0789a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:25:17.533+03
294	4576dca3-ebca-4b79-8ac5-e13afc5f6632	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:25:17.537+03
295	08c1d545-4e15-475a-af8b-186fc9ed5d34	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:25:21.869+03
296	83603dde-4b21-4869-9887-146005948eff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:25:21.871+03
297	874def3e-5216-45d1-9ca9-2a842aa231ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:27:37.229+03
298	d082ea5f-6f8a-499a-99c6-133303145604	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:27:37.236+03
299	c6f27ec6-289c-43bb-9017-551af378a1f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:37:16.072+03
300	5c3fdbca-6e6b-4957-8a6d-67af21c34ec7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:37:16.078+03
301	f9262c06-552e-4f88-b83a-50ced11eec9a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:44:02.768+03
302	30d36148-5bd9-4d7c-b1d4-64bfa2fa8b34	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:44:02.771+03
303	cb5fcf2c-d7f9-4a06-b536-bf8d0a5eed17	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:45:18.744+03
304	cb1e6e63-ee22-4758-bd11-f059019f4ea1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:45:18.746+03
305	e379a84d-af9f-471f-80c4-6b94cb37c03a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:46:23.957+03
306	697ca04e-31bd-4e6d-93cc-eec809d644f7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:46:23.96+03
307	6d66444f-86de-4429-91ee-12b6980b9022	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:52:46.438+03
308	dcc3b8f5-127d-4de2-a150-ed52c9146566	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:52:46.455+03
309	4a0c25c0-4303-45b2-8378-2b5dccfbdbf5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:55:07.654+03
310	9316458d-7a74-4112-8dfe-8c3789febe6d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 00:55:07.657+03
311	9f6e6bd4-b151-4632-ac12-4f32c14d6092	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:21:42.059+03
312	0a917343-35ad-40e6-adc9-6b88bc38c5c8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:21:42.065+03
313	6dc39a1e-76ab-4bf2-9908-6d9131e56213	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:34:24.963+03
314	2c0537e5-40b8-4140-91ca-4bae9449c222	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:34:24.966+03
315	7e05a884-f263-46cd-ad78-8cddd8093971	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:37:03.017+03
316	727c27c9-6bb5-4339-a59f-a04efd4d5446	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:37:03.024+03
317	6b0a8872-cff1-4f82-859c-25a15376a0bf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:01.477+03
318	989deaa2-41c0-4b4b-a03d-72831b277a24	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:01.483+03
319	f2ef0512-8acc-424d-9b0c-ffd121e105d1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:17.883+03
320	a7a0a461-87a2-450e-8393-cda387e88017	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:17.888+03
321	f66ac7ae-300a-4189-a019-82799de11475	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:29.633+03
322	924a01a3-70e9-4917-9dbd-6b4d38ad5173	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:29.639+03
323	c5358884-ab21-48cf-8e53-d7a982a33ed2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:32.518+03
324	e1460b22-0d02-4a1a-9eeb-b5031865db78	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 01:38:32.522+03
325	b32c485d-24f7-46d4-bcca-512086979f51	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:02:25.163+03
326	8c8625fc-fcc7-40b7-a666-04db786596d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:02:25.168+03
327	c570134b-dbb0-4dea-9699-3857dccbd8ea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:02:45.721+03
328	037ebd20-25d6-4df2-91bc-46c51b29cd8a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:02:45.724+03
329	9a7f9f8d-5f62-4c7d-b950-5c23895a29f5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:11:27.086+03
330	00e19080-24da-49b7-be9d-77813d92a8ad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:11:27.09+03
331	35ad901c-5849-46a2-b461-0319e6922f37	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:17:02.284+03
332	6d576994-440f-4c9d-b820-7b612c1abb38	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:17:02.302+03
333	c0573227-3954-429c-85ac-fa800645180f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:17:34.159+03
334	888fd207-5ea1-4eee-b507-b212693520f2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:17:34.162+03
335	fb9cc387-ec60-4389-a926-1d383f5fd1c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:25:09.87+03
336	94a5c1b1-f320-4112-82e8-fc80971cb335	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:25:09.871+03
337	582c19bc-5674-463a-b40e-46a53cf435b4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:29:44.873+03
338	c6327b86-d510-40e7-b497-0239047eaebf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:29:44.874+03
339	fd243628-99f7-463f-8857-189abb861265	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:30:06.132+03
340	43d87d29-cc86-4720-9203-0d2c8276bea9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:30:06.135+03
341	192ea503-1d37-4236-af2e-111e189e0f85	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:35:16.541+03
342	4de3f1e5-ab3a-400c-b021-db9b95b9f030	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:35:16.543+03
343	61b4921b-41b7-446b-982d-186314145663	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:38:37.4+03
344	14c1d9a9-dc69-417b-ab9e-0662dee149ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:38:37.405+03
345	708a5c8a-ee61-4ea9-b9fe-c6ab8a90204c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:38:42.592+03
346	716e29b2-b561-45ae-ae2e-b722e2cfb0be	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:38:42.612+03
347	9a0297aa-37fc-4968-b25f-804a9f8777a4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:52:27.181+03
348	c596c5fd-68c3-47d5-80a8-b5bb455791d1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:52:27.187+03
349	b8765abc-872b-47ac-9936-74f46a81a4b8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:55:00.785+03
350	e38a1ade-8bcd-440b-aeeb-ee579f9c50a7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:55:00.787+03
351	4348cf54-aa14-48bb-90c4-da1f9f065f66	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:58:01.318+03
352	3decaff6-12b2-44d8-b156-7a56f6c2c372	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 02:58:01.32+03
353	44038b87-e4a8-4f0f-a69b-6c9f4c6cfdad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:01:59.055+03
354	e333ec81-6e06-4ddb-8d1e-ba441821f719	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:01:59.058+03
355	e56f6e30-f5cd-49ce-ab72-0ce2007aa6a4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:02:09.809+03
356	6f95fddc-3345-468b-b095-1d0c758998da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:02:09.814+03
357	17feb4a8-bdf4-4b42-b630-f0df02816f07	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:03:05.592+03
358	0d3bba11-21ae-4864-a7d6-7aebd96df258	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:03:05.588+03
359	0c03256c-fda6-4e59-b577-bea1b2d8acab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:03:05.6+03
360	ffb18dba-a3da-460c-b0e2-a88f3a98c9e5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:03:05.602+03
361	4143c4e4-16e1-4e92-b41b-f3d0f2813a9d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:03:47.812+03
362	ec9f1a6e-5269-42c8-8bd1-779d45fa20c9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:03:47.824+03
363	836212e4-9f88-4987-ae90-c40a3317e556	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:17:55.837+03
364	5617e786-4656-49f6-836b-2ead558b2e39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:17:55.849+03
365	6cd2b09b-2d0d-4601-8c63-8f3971a163cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:19:03.656+03
366	2c9e8831-5ae3-4ef7-abf1-211bfb617f44	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:19:03.665+03
367	d39951cc-c8a7-4192-a959-4d7082408674	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:19:35.337+03
368	cb5202b1-3339-4e16-bda1-edfd1b454b7a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:19:35.346+03
369	ea28c14f-8556-42dd-8409-0d1bb3646c25	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:21:00.526+03
370	7c954fd4-3bdb-4049-8e00-f8c0c07228cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:21:00.538+03
371	50d26171-badc-4f0d-9444-c5abd5e28d41	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:21:10.293+03
372	db8b116a-d8df-4c5e-a1aa-3d12b1d58d09	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 03:21:10.304+03
373	a8c0fe37-8f4f-4919-ab01-bc133e8c6a4e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:06:27.477+03
374	8f585c8a-a448-44bd-a5cd-697dc70d4f82	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:06:27.582+03
375	4d59b432-0a99-4339-8447-48d1a3ca5e4b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:06:45.866+03
376	ba0e1d2d-9abf-43ba-a7ac-827b23cfcb85	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:06:45.916+03
377	0559371a-675c-4a80-8385-6f42281bd372	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:07:40.162+03
378	c1abdc1c-7ad0-4e01-a664-ed92b2736079	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:07:40.203+03
379	81fbf79b-2968-4a5f-b4d5-ee3c796866f2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:07:45.468+03
380	040d02c8-976f-4480-850a-84e8094bb6ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:07:45.49+03
381	9b9999ce-7c45-4dea-a1cf-5ad69b490d39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:08:10.473+03
382	27c28c8b-c265-49fd-9db0-d70b9d9e8a35	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 05:08:10.483+03
383	6cf1a8ef-2cd5-4bc6-a731-8a39948dee54	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 08:12:37.416+03
384	c22dd8a2-e710-49a2-a73d-3b3365139fe7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 08:12:37.426+03
385	6fdc836a-a569-4ad4-8968-a1acd76bad9e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 08:15:03.512+03
386	5591a2bd-e00d-4544-a64c-a596efd6ff0f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 08:15:03.523+03
387	6a3a5c76-35a8-480a-878c-736a310e0086	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 09:53:44.198+03
388	5075158f-426e-415d-b478-1ce562f38a39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 09:53:44.208+03
389	83fda699-2f4b-479e-a0f5-7998f34c3fdb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:04:40.035+03
390	ec593c6f-473f-465f-8618-dac62d732b4c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:04:40.038+03
391	cf8ca20e-e4a5-498a-a914-830cff9065ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:04:43.107+03
392	beb52680-a619-49a3-a974-9dc288676217	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:04:43.11+03
393	5cc91979-c1b5-485d-9e93-b2f718f8c4b1	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:10:01.203+03
394	69ed6d3b-8b39-4054-a289-3389afaa61eb	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:13:07.615+03
395	19d1e63b-2d62-49dc-b500-0550d583ad71	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:13:07.733+03
396	f31522f1-0cba-46b8-9a12-2451b8309906	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:13:27.792+03
397	eb61395f-5b60-49f8-90cc-b38d311231f4	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:13:27.91+03
398	16785dd6-e503-4e20-8399-c2552654ff95	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:22:55.469+03
399	75bb7315-11f9-44f2-8354-07dc58273e72	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:22:58.092+03
400	33f77cf5-45d5-4ab1-9bd0-1e48f676cc62	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:23:11.934+03
401	500ed917-633a-487f-a23c-adc771bb7898	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:23:11.937+03
402	852ba099-4e66-4699-b07f-35e7a952a9a8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:23:14.608+03
403	7dca8297-5212-4b18-b778-0d6373945874	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:23:14.619+03
404	54cdf8df-0174-453e-9ef4-c7784b76b6e5	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:27:34.14+03
405	56843939-a0f7-4485-8b92-e8532581c419	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:27:34.515+03
406	58e23876-7d60-4884-bcc7-5e744197ce82	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:43:29.419+03
407	26b4e409-2ec4-4085-b4ae-ef748b64118c	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:48:09.967+03
408	d519cef2-214d-41c3-b721-5a2d310effa9	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:48:10.224+03
409	ee33ffd3-7816-4a8b-98e9-90425b6f042e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:49:21.668+03
410	fbeed9b6-2688-4ecb-beb1-e218687fc12d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 10:49:21.67+03
411	1c18612a-7303-4e8d-a7e0-0792e19946b9	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:52:11.203+03
412	043e1ca3-e1af-476b-8fed-35fdee8c69e4	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:52:11.207+03
413	cdeb6fdd-36a9-4934-81fc-a15ccaeff300	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:52:34.011+03
414	7fecdd48-23b0-4603-b4f8-4f2379433245	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:52:34.024+03
415	bb4f6ab7-2132-45e1-bf6e-355845b2bd72	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:53:04.034+03
416	f11aefdc-ded9-4bed-8400-1d85c823efde	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:53:04.075+03
417	5ccc9b72-cca8-40f0-95c8-242b79ca6573	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:57:53.43+03
418	f1326553-f930-46d2-84a5-54d02eb84c91	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Edge	Windows	0x0	unknown	unknown	en-US	false	2025-07-04 10:57:53.481+03
419	9f8040da-adcc-497e-96e0-7a1c15f1b619	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 11:21:41.814+03
420	85149bf3-3997-4e21-8b1b-17079f041cc1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 11:21:41.824+03
421	92eefd51-ed6b-4468-9b76-c40659af4602	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 11:24:31.378+03
422	0b921dda-bf14-47e3-83b7-ab9c7300ea1f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 11:24:31.393+03
423	4675912f-767d-431b-8f75-50bf353b154f	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 11:53:11.901+03
424	986a0d69-fc6d-41a8-a74c-217431e74ae8	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 11:53:11.908+03
425	77ce7b6a-d103-4e32-bdcd-9525347e10a3	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 11:54:00.956+03
426	bcaf084e-8c50-4d37-a4e6-e79025c6bb09	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 11:54:01.007+03
427	1ba5dc05-26cd-4f43-924a-699f54b5f238	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 11:55:08.052+03
428	9961e162-79e6-4285-a828-d405a703ab12	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 11:55:08.065+03
429	559d0d09-fb37-4f88-9f47-fb7b0f344aee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:12:10.149+03
430	8eb62a4d-e409-4951-8697-55acbbb9f43d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:12:10.159+03
431	76996b24-d974-40e9-adc0-04472e4fa3fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:16:14.606+03
432	1f644d2a-91e5-4109-afb3-e7a98e2e5f07	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:16:14.614+03
433	2232d014-f89c-4e0d-a029-cceae8969307	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 12:18:41.394+03
434	81720ed1-1691-4786-9009-0689d8ba197b	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 12:18:41.45+03
435	83c95639-4ca7-41ef-9f32-3798660aa7e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:30:46.305+03
436	c06c04c2-7405-413b-8d32-e53fa4473a5c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:35:52.533+03
437	89897500-7d55-44b6-a237-f8dcb634c324	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:35:52.554+03
438	05bc520f-09ad-47fd-b464-486247e43437	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:36:29.196+03
439	bb5b0f78-7d45-4be2-b558-27bfe956ccc8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:36:29.204+03
440	538daf08-e14b-462c-b764-2bb81cbba88f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:40:12.636+03
441	be31023e-9de2-462d-bdae-75f1e420f037	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:40:12.645+03
442	7eacbe94-0f5d-409f-975f-531cd80e4375	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 12:48:39.561+03
443	dff969b3-a546-4503-87a1-721a23a8003c	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 12:48:39.581+03
444	73289155-de3f-4bab-96f8-248f9a26e13b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:48:40.203+03
445	cd970903-6253-48f5-aabb-276937d0e99c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:48:40.227+03
446	c9c8d4de-f9b1-4463-a413-7ed16f5cd9d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:57:14.699+03
447	b48a0267-6d38-496f-af12-fc70ab5ffaf1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:57:14.706+03
448	66a5a692-7505-4384-a33f-33314e4358e5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:57:20.122+03
449	8b4c7b8d-d2bc-4ae2-869f-583644dd2f20	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:57:20.129+03
450	171e89f1-2e40-472a-b536-7e0b425d4704	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:59:18.731+03
451	200f68fc-f69a-42c6-82c4-0ffa8a6b4cc6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 12:59:18.74+03
452	69941121-2c33-441c-8bd5-68a04d9dca29	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:11:13.362+03
453	8f9d3dfb-edf0-4e87-9d5c-7cbc83c9fa00	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:11:13.432+03
454	014e4f80-89cc-43a2-bc79-434c155a0442	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:11:14.45+03
455	c03f18bb-428f-4a1f-9e23-f1561a35c0ca	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:12:06.388+03
456	ce3029e1-0863-4cec-a44c-92863b50fb98	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:12:06.414+03
457	2b645a68-2384-4508-a8ec-7840e7a2bf3c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:12:06.735+03
458	37a03f15-b66e-4ba6-942b-8c59520a2627	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:27:10.344+03
459	eb6a2eef-6ac6-4057-ad87-4d80a5bb5e0e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:27:10.361+03
460	f2fd2ac7-0a50-4b7f-8e33-7b80180ec408	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:29:56.054+03
461	ef5cf5ce-3fa0-4855-a89c-3cbba64f7c70	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:29:56.075+03
462	7f706fac-98c2-4158-bbb1-9afcaccbe5a1	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:30:13.414+03
463	73829a09-9735-4f63-b092-be724d4d8f01	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:30:13.433+03
464	9bd4ef39-ac01-4673-92f0-1876fee8e157	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:30:34.228+03
465	b516fc7b-ceaf-44db-a995-5ccde63b10c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:30:34.232+03
466	719398bd-c3be-4d3c-b52e-d31d8613b8fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:30:39.607+03
467	8a64f9d7-ed2d-4098-8e44-b4d1d793bf48	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:30:39.609+03
468	0524c80e-7985-4919-8388-b299a3ef5fd2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:30:51.662+03
469	706ee249-b45b-4b44-8360-3e52b6db862d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:30:51.67+03
470	a7498b5c-ac84-4554-aafa-16d0b8e757c5	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/billboard/2	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:30:53.213+03
471	9c59651a-6af9-411f-8aef-ec054efbee14	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/billboard/2	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:30:53.256+03
472	d323fbe4-afd4-492e-8493-f1c20f2db91c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:31:58.202+03
473	a0c95ef1-11f5-4648-8696-3c3bd51abcf9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:31:58.214+03
474	0c0bfa5f-5b73-4b54-862d-29a80aee962a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:41:33.427+03
475	d5a2384f-a1b3-4c09-955e-2a3149a208ba	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:41:33.431+03
476	109e8ddc-8859-47dc-99de-f6f4fc073288	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:41:49.685+03
477	438a1a9b-34ca-4c09-96d4-0fab6ca49023	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:41:49.687+03
478	c1202665-d560-4c52-ada6-b3690d85157c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:42:33.279+03
479	81e8e143-0f89-45f7-97ac-dfccb2dd45f1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:42:33.281+03
480	c2309b12-496f-4da6-93e3-9a7c33d0bcaf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:42:43.179+03
481	80102541-bc8e-468c-b9c0-624a02e67dbe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:42:43.182+03
482	217df8e8-d438-49cb-abc6-ca8560fffb28	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:32.249+03
483	f35d286e-1888-46e1-bb51-dab50def8d0a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:32.252+03
484	66c495d6-e50a-4d53-8678-81727bdb82b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:35.878+03
485	b39b0788-385a-4765-ba66-ef3d9d67023f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:35.884+03
486	a8e0ed86-d474-4759-acda-e17c43a38b53	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:41.949+03
487	3239ca52-00db-4233-9446-6b941ea02a43	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:41.951+03
488	0a2b2053-c058-42b0-b89f-0e1ffcc28d15	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:45.443+03
489	d6b81e1a-2dc5-4185-a44f-9456b911b1df	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:45.446+03
490	a124898c-b63c-494d-9f5e-18f1442570be	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:49.503+03
491	a97b175a-d377-470c-95d9-3618ccf805c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:43:49.507+03
492	9e3d0f7b-8569-40be-a5e9-bbef849346c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:44:18.087+03
493	ba5fd2ea-a1c0-4cac-abda-ccbb0247967e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:44:18.09+03
494	d7410a04-7114-44d2-86ec-ae8539ab2eec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:44:20.911+03
495	c395dd33-25fa-4cb5-88eb-9a6d7d138e2c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:44:20.916+03
496	139bd79d-f0e9-4e2e-b96b-0dc963692b29	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:44:55.884+03
497	a67ee1e5-0f7d-4906-bdfa-c9c9350fdf54	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:44:55.888+03
498	1136234b-1fe4-48d7-a600-a65b9bf91740	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:46:20.488+03
499	f1e6af8f-33a4-44be-a12d-1fb8579eb269	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:46:20.491+03
500	bab06b21-a2a0-4b36-a64e-23ea285ba1ce	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:46:23.33+03
501	ed8a35c4-7a69-4c9f-9363-006abd7062d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:46:23.334+03
502	d63273db-e19f-4adf-b487-c91e343ccc3e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:46:58.629+03
503	e7b2b26f-5dd7-4cba-8df4-33f65d871e4f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:46:58.63+03
504	8592612c-354f-412c-be55-aa2506ceb4f4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:47:13.744+03
505	9ede4aaa-c5fd-45c9-af1f-d0793a9bda26	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:47:13.748+03
506	8b6f6171-ca80-4b59-b7af-d7f5f9cb7f99	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:47:38.811+03
507	713f4c1f-36fd-44f1-ae4f-a7286b4b2af7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:47:38.813+03
508	cb776823-37fc-4f37-9384-5fb93a4af68c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:48:39.247+03
509	6e419c10-20cd-469c-b794-af1e0957c483	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:48:39.25+03
510	7d130f1c-14d5-4842-bcfb-8420f3ad75ab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:48:44.235+03
511	365d01ef-392e-4bfa-8f9d-3d8d8021e248	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:48:44.24+03
512	0b63d639-afee-4fcd-8d5a-c028162f93a4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:49:09.581+03
513	07a32b81-8e81-463f-892a-62b7f1900f98	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:49:09.584+03
514	1b541085-06db-45bb-bc69-bd3b78a88f54	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:49:46.406+03
515	78f00ec0-f907-4271-955c-0d237f48522e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:49:46.408+03
516	f81739f4-fdd7-436b-936b-526860d57b57	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:03.056+03
517	a4790c81-42a4-49e2-8378-ba639a4f7405	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:03.059+03
518	dd1361b0-c062-4935-a73a-f772d38efd46	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:08.287+03
519	a6881476-e026-4602-95cb-16b5acd1857c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:08.29+03
520	c30f564f-3d05-4605-a1c6-2a24068907e2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:20.06+03
521	7ade477a-16d0-44e0-965a-3454f03c6408	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:20.063+03
522	ff515e89-d582-458b-84aa-dafec378c429	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:46.403+03
523	00e0771c-2d68-4a64-8e05-16d61d46f1ba	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:50:46.408+03
524	7114f0c6-ebb8-4a5e-aba2-e3bdc7deb74c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:06.455+03
525	2d93db69-45a2-4186-a3f7-5fa42ba72107	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:06.458+03
526	9d579d75-d17c-42b6-9f4d-f5e806525ac4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:15.006+03
527	cd46ef7d-2bbb-4093-a7cb-af5aee26ba67	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:15.01+03
528	0a03ec87-cc6e-4a63-9198-b690a4b90780	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:29.564+03
529	4bd20ba6-d483-4fb9-86de-27ec1f4d4731	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:29.568+03
530	9c00c8e1-2a4a-4872-a1f8-22dc829df55c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:36.928+03
531	d660d809-e267-437a-8a44-4ec69f0e320d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:51:36.93+03
532	6d5cb8cb-e0b7-44f6-af68-b496042fdc43	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:52:33.805+03
533	9b3702f2-8d0f-46a7-b409-5564988ebe9d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:52:33.809+03
534	5dea3634-570e-4915-956f-918af2beac77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:57:08.3+03
535	eaf7f298-cd1e-42e3-896c-efd76d54f510	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:57:08.303+03
536	b11fcab4-38d7-4dc6-a23c-0505110d9889	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:57:54.785+03
537	ceb92d55-a25c-4a42-9eea-1f73bbed6ae7	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:57:55.358+03
538	d80b302d-d0a8-4174-982b-1f9a93b1e0fd	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:57:55.393+03
539	6abc16ed-a7b2-42da-87cb-22710080cf61	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:57:55.499+03
540	81317c3f-a8a2-48b4-adfd-ea670378fc08	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:58:25.902+03
541	2cb2831f-dd4f-49a2-ac47-7acc9abd96e0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:58:25.924+03
542	826fbf78-f5d4-4acf-be2f-968f0d6229e6	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:58:26.319+03
543	d2fc0dd9-e36d-47fc-abd7-ddadb0a73f2f	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 13:58:26.338+03
544	90d9f4b5-9df8-422c-b9d6-98377daa60e3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:58:27.103+03
545	56ab24ce-9393-4320-a50d-8dfc1fb0a426	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:58:27.119+03
546	fd7e04ff-08ce-4df0-b8fd-71739504157e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:58:40.826+03
547	4e010417-1537-4721-a58a-1d6fef5f84cf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 13:58:40.83+03
548	940cce14-f8ad-4360-9435-809944acaa0a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:42:01.891+03
549	0131cdbb-d36d-47b6-9fe7-ddd110904865	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:42:01.894+03
550	b19d9c2c-6f97-4d97-8efe-e4a198225cfa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:42:34.042+03
551	90dd861f-e74c-4f0c-bf90-b3d6d946a36b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:42:34.045+03
552	f1a90b33-982a-46e2-8fa5-24211045d487	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:42:41.684+03
553	02efdea5-9ec9-40f7-876a-759c4cd874e2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:42:41.688+03
554	03f0720b-490d-46c9-bc16-5935c0eea77b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:45:10.503+03
555	9c85fd6f-1534-43d2-bc01-82cef28bdd7d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:45:10.505+03
556	da9636eb-1ff5-4755-920a-c5dba65f5bdc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:30.529+03
557	c30d20c7-153e-4a58-b271-5cfe65a1cbc2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:30.533+03
558	6c519a13-db36-40d4-8683-942a7a9c2373	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:49.908+03
559	d44d8cc2-a86c-4f19-bd20-be335e98f539	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:49.912+03
560	90fe0815-6fcc-49bc-a0a0-9e6ad4b0d8f6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:55.37+03
561	864324b6-026a-4e26-b6ab-e0c1b745e696	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:55.374+03
562	630ae254-f760-4742-89e9-16c1c42df53e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:58.9+03
563	da10acf0-e5e2-40d2-8ee0-3474cbd1e54e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:46:58.903+03
564	f904a2a0-7885-4bf4-8ce6-43ee43c4f139	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:47:03.976+03
565	fbd2ebdd-7c1d-48c7-a32e-9638fc1543de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:47:03.98+03
566	aa76da02-241a-477a-8715-48741019b5d8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:49:59.737+03
567	7f9df1ef-c851-4ed5-bd2d-2c936232d31d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:49:59.741+03
568	8fb6e557-1e33-4aae-998e-f7140f62b2fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:24.435+03
569	c522e7b3-9e3e-434c-b4fe-681808d00277	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:24.44+03
570	ed4ab300-a506-4ed0-ac45-e69f0732538b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:52.165+03
571	e30f96fb-f296-4134-a7b4-96d4bc898848	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:52.171+03
572	4aec25be-eeb3-4e65-b836-12c62db79abd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:55.482+03
573	4bfd336f-1c2f-428c-9be6-6cb03e335e13	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:55.49+03
574	8a445de2-0232-412c-9411-04df9c59cdf4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:59.657+03
575	0826e2b1-84bf-4f00-a0a7-790087dc7bf0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:50:59.661+03
576	e1be809c-1986-4753-bef1-b5e244f757d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:51:03.494+03
577	126bd042-9f66-408c-af0e-925bdb1f09e0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:51:03.499+03
578	ffab762c-7ed1-4021-80e5-912c1efc96e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:51:07.24+03
579	b5c280af-19a9-47bd-a00e-a7b2d6244e75	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:51:07.252+03
580	6499e4d9-6b75-4a51-8819-6ab95231084e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:51:49.331+03
581	976d2b39-13bb-435b-9ab4-aa6466414390	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:51:49.335+03
582	c40b38dc-7c10-4a90-8973-c854b810d08d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:52:22.544+03
583	327c92e3-252b-404a-bc64-88ef1aa7d137	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:52:22.547+03
584	52093942-816e-4d43-86b9-bc6c0b1471b8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:52:53.548+03
585	9bf6e9d9-f877-4e77-b761-a947e9803a1c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:52:53.553+03
586	dc9699db-bbbd-40c4-bed8-4bb102dd655f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:52:57.177+03
587	a4061694-706c-49f3-b31f-170f9ae9e785	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:52:57.181+03
588	02be76da-39e5-4a31-a0fb-2634e838a85c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:53:58.188+03
589	93f45e9e-b1fe-484d-bc4a-7958fa876589	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:53:58.193+03
590	8874a786-c6fa-4a65-9f4d-2323f77e7832	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:54:02.066+03
591	b6644fb1-c29d-43e8-94dd-30b5a613bdaf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:54:02.07+03
592	f80ef43e-5fa7-4280-a73e-bbc783a1e798	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:55:43.077+03
593	d492e7cb-1ff5-4d07-8ba7-dcdd016487c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:55:43.082+03
594	b290639d-b48c-4930-a94b-06650a719181	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:56:29.578+03
595	b5d50c3e-86b1-446e-9510-aba99af0947f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:56:29.583+03
596	8b98d073-ae8e-4bf4-8c46-b27a122bba09	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:57:01.216+03
597	0959a86f-d7ac-471b-ba06-aa7b5a431a59	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:57:01.221+03
598	86923c79-060d-4891-a098-8833b7c350a9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:57:07.866+03
599	ab1a8b8a-4907-4d6a-8a05-b0c826e00f52	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:57:07.871+03
600	ddb80c29-6991-479c-ac8d-b29c01cc9e8f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:58:40.09+03
601	b9249a00-f6ae-4552-9114-497bff36455b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:58:40.094+03
602	438ea045-6249-40d4-941a-77cbb20aafba	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:58:43.021+03
603	3786b2a3-6416-487b-a64e-995262b9fccd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:58:43.027+03
604	24b49889-eca1-4383-b6cc-7d5512aba10f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:59:07.398+03
605	20f117ab-6047-435d-a28e-05ee83d15a51	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 14:59:07.403+03
606	9fc7ed42-46ce-438a-829a-17b9df3c871d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:00:10.239+03
607	ba826cc4-d5ed-46bb-8f05-8426428755e0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:00:10.243+03
608	5cdce8bb-62bc-4c4e-b3e6-2608d06f1d69	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:00:37.524+03
609	7cd419bf-a199-4235-b3c5-4dc989b2dd24	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:00:37.528+03
610	de2909cb-350c-4ba5-a0d5-92600ed87e3c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:01:10.052+03
611	b6ca347b-d03b-4425-be5d-25de183cbe5b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:01:10.056+03
612	f2989079-ef0f-4b93-a78f-a24760144b80	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:01:24.958+03
613	026ef59d-0ab2-4395-acb6-d1526271eed0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:01:24.964+03
614	831d83c7-a3c0-4f42-ab6e-bc1c69b56013	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:02:39.457+03
615	f49b5961-776b-4600-aae8-df004349ca88	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:02:39.461+03
616	6e73f4c5-9570-4935-bada-740feccc39a2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:02:52.932+03
617	a5120ef9-257f-4490-85e9-5625af94c717	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:02:52.937+03
618	0671f0f4-298c-471d-bf8b-6949fdf42191	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:03:13.895+03
619	12c77c1e-9b50-4bb3-ac78-6222a770eb97	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:03:13.899+03
620	4527df2f-66c3-420d-937e-e5c3e1e60681	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:04:02.138+03
621	16564309-d82a-448a-8e0a-eea121d18675	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:04:02.144+03
622	f79e0492-a08a-44c5-af3b-ca72eef7de4a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:04:56.302+03
623	c41b30b4-0748-4ed6-90c4-ac78738b198b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:04:56.307+03
624	a6e90bb5-f5e7-4206-94e0-8286ca79477c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:05:04.358+03
625	de4ed622-8bae-49e0-9bbb-307290604013	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:05:04.364+03
626	5715da48-8d83-4910-a2e1-134367c49f67	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:05:11.885+03
627	fe379976-8b0b-417f-9523-143cb0dec81b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:05:11.889+03
628	6a03d441-7728-4e92-b3d5-d27e12dd5bbb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:05:17.506+03
629	d50a50d1-24d1-4aa8-b5d3-52d891e1e832	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:05:17.51+03
630	56132552-39b2-4c17-8e53-99fff6101523	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:02.909+03
631	cd36f248-ee69-48f2-8cee-19b65b7788fd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:02.913+03
632	62ce67dd-d9e0-4b75-a999-ff32a102c0c0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:07.118+03
633	a1cfc40a-853b-4f48-91b8-1c6fc84f52dc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:07.122+03
634	595df72c-5110-48f6-a794-78400ade696e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:11.288+03
635	97c5881b-4f63-4ea0-8f10-ca95ca3f3d32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:11.291+03
636	86ec8c8f-43d3-4ecb-95a0-1cc1b8ffaf99	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:17.195+03
637	f13e9d58-d29e-4d6d-83f9-44664f6fc5f1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:06:17.2+03
638	cf57d5c4-81e6-4cef-8664-5d80f0f1100c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:09:06.284+03
639	b3c41b70-76d5-4eda-9f11-bc7f28f4d9c9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:09:06.289+03
640	a4d77120-4fd3-4e86-8beb-74c3b49949b5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:09:47.217+03
641	79bc4ba4-47a4-4b29-a6eb-a9c6b6655f14	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:09:47.222+03
642	32e6d2d8-634e-4709-a138-2eea70e73ac8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:08.13+03
643	1bb222d3-0ad0-4bff-90d4-ffccacacd8e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:08.134+03
644	26b00a32-109d-4c49-bb52-f61564f899b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:15.589+03
645	ce6a6081-cc16-4d06-930e-12da3c7fc194	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:15.601+03
646	5335ae5d-df41-4066-8bc0-d339e3ed9ad2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:30.809+03
647	cbf701ab-d567-4cf9-8073-9c4306aea36c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:30.816+03
648	4ca8bc02-d984-4dac-983f-629a1547ddd9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:36.446+03
649	98b3ed8d-dd4a-46e5-a46f-f41ea270e00b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:36.453+03
650	77ef731c-86b5-44a0-bc5f-10e1fd149720	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:59.728+03
651	ecae28d7-d282-4cfc-98d3-37fe730ca399	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:10:59.732+03
652	98d00217-1ff7-439c-aa27-8418d16981c4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:05.635+03
653	765f3043-9103-460f-a479-97f9ea5bcec1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:05.648+03
654	7c3e0e1c-8f5a-4044-8c14-d314c2fa6af1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:11.445+03
655	e9207a88-9a21-4583-aea6-c37c9ee5d8f7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:11.449+03
656	c7e5e026-7f64-4840-8e09-f30e786ad1e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:35.251+03
657	edcd6c37-d6cb-4b05-b832-1d3c42453d55	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:35.261+03
658	3b70857a-422c-484f-897e-870f49b1b0e3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:42.736+03
659	35404f3a-a005-418c-aa63-59f77c4a99e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:11:42.743+03
660	a5c3a5be-6208-414f-a253-e232b861baff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:13:44.993+03
661	2b5a320a-4411-40f9-bf70-50cc0cd0dcf0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:13:45+03
662	f2a0aabd-121e-4644-ace0-398bab2e2033	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:14:40.434+03
663	59413658-842f-4c89-a21a-bf47c428ef99	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:14:40.441+03
664	24f71ad8-2978-476a-9fac-63fcdd3ac92e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:14:43.65+03
665	eb9dd4c5-3e30-4144-a3e1-09325e7e6361	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:14:43.659+03
666	ea824b37-cd4e-475e-88e2-c7285b1704cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:15:46.011+03
667	29a940a8-69f1-4964-91a3-21edd0ce1710	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:15:46.019+03
668	02f86cfb-177d-4a3a-b738-95ec10ef6919	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:15:50.041+03
669	39e00326-6bdb-4ee7-a2a9-8565cc67aa1a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:15:50.052+03
670	54990366-f700-486c-bb29-88f7b27d0509	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:16:03.097+03
671	c8848823-3bec-449f-b373-d22acd15fa1d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:16:03.143+03
672	a449e6b1-bc0d-4b86-93a6-2fbb45d3093b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:18:44.128+03
673	912b0610-77cf-4bb0-a669-78f4056e3b24	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:18:44.132+03
674	e93da0ec-c8ea-44db-924f-da84f4c40500	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:19:08.577+03
675	7dac9524-ddec-4c5c-904f-e8ee09add89b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:19:08.579+03
676	abfd5f46-ce49-4793-8bec-46024dafae67	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:23:50.218+03
677	a74a8985-4b6a-453c-9fd8-85751c244024	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:23:50.221+03
678	92bfb237-2751-4b13-9429-362550926b21	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:23:54.631+03
679	eebd77c4-bc94-44e4-a161-eb34ae5e39f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:23:54.636+03
680	80043478-65b3-4e01-9b13-609ec83c0316	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:23:58.14+03
681	35d62dee-4f51-48a1-aab8-e5cd65fd0e50	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:23:58.151+03
682	7bd86664-478b-4160-afbf-18f609b21627	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:24:02.167+03
683	c6a863a9-32d9-4666-a5bb-f41789a19b40	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 15:24:02.171+03
684	9de60d95-0dda-4421-9632-891636d8c05d	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 15:24:36.415+03
685	2ace788c-a4a2-4a2a-9835-b804dc5c0e70	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.8.152:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-04 15:24:36.496+03
686	32d79b35-7684-4598-90d3-362293dfebf0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:48:05.96+03
687	480063e1-ecff-4bbf-91dd-1b40830c7856	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:48:05.983+03
688	bfe6bd71-05b4-4f4a-9926-7752432b3441	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:48:21.538+03
689	a28040f6-790e-4433-b7d1-377727b2658c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:48:21.562+03
690	674bedb8-9d63-4fb9-a203-25d1405a42b0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:55:47.07+03
691	766a0168-66c9-4c1e-99a6-a64e0576caf2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/highcourt	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:55:47.076+03
692	152abbf7-b062-44b6-88c0-28fe83a7c12e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:59:28.341+03
693	ae0174b0-6a74-4b1a-8774-cfd27e3c6855	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 18:59:28.35+03
694	ec8b2545-3e80-43de-8122-3adf78fee5fa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:00:49.531+03
695	182ba33e-535f-43d3-ab34-d6760b994812	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:00:49.545+03
696	69b05a72-bcbc-4e5f-a2a1-2854996f49f0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:02:10.68+03
697	0bce6bd8-3a2a-475f-8171-21508a196757	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:02:10.683+03
698	21a5609b-2d3c-4172-9d6c-d5bdde1473e4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:02:10.691+03
699	cce29a8a-3387-4026-8a5c-1cfd5cb9f32a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:02:10.692+03
700	83cea1dc-5667-4c88-9cf3-b8320ccad893	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:05:47.638+03
701	9bafcdde-63f5-40a9-b59e-f6d0340f6647	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:05:47.642+03
702	4fb2d945-badb-4dad-acb9-9e8a7a79b5e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:06:33.086+03
703	16b955a0-a249-4376-aaed-d5132628b55e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 19:06:33.092+03
704	99b1c4a9-c2cb-4d67-8235-ff78d3c0f712	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 20:05:06.699+03
705	0267887f-d32e-4dd7-a59a-1bf3a5a876e3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 20:05:06.701+03
706	b5da34eb-8088-4721-94a2-bea1d9e6a967	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 21:42:49.689+03
707	5dded0e3-694f-40be-b4a2-599d1190bbaa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 21:42:49.692+03
708	7d275461-0924-43bf-ba0a-bab25731cd6d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 21:50:37.225+03
709	0b1d8fe2-ad13-4e19-a391-023a4d39f04b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 21:50:37.228+03
710	6accdfca-a1f9-4ed1-b465-843007f0fb9b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 21:52:55.207+03
711	3e9c99af-ed89-4539-a07d-0b717e017499	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 21:52:55.21+03
712	a9523852-5046-4fc1-9a20-119b5db73214	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:02:06.913+03
713	90a0732e-3909-4de0-baac-bc19fb701dc4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:02:06.918+03
714	fc5b256e-fa61-44a4-8ceb-2c44806ad5a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:02:10.17+03
715	f269c5b1-aa8b-453a-bb8f-18c91fab63a4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:02:10.173+03
716	4437a69e-30e9-4a02-90e0-d78d8ed6756c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:07:21.335+03
717	eacc61ad-21ad-4093-83da-0206d82a3708	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:07:21.34+03
718	94d98737-dc66-4fec-af4a-48cd167d9b15	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:09:14.807+03
719	41aa0f36-0420-42e5-8f4f-2a061e845f69	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-04 22:09:14.81+03
720	ec2e85d7-5597-4abd-9a5a-0e15a6937733	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 00:13:17.614+03
721	242f75f9-6ae3-484b-91ab-eff3a2624289	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 00:13:17.622+03
722	db377c69-d96b-4cf1-b3f6-2711aa430c0d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:42:39.353+03
723	7fb17f8d-34b7-43b7-9e87-dce7cd184301	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:42:39.355+03
724	657d8703-d5ba-440b-971d-06a3be060f62	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:42:46.939+03
725	f0ad625a-a48f-4976-bb35-f823f35fff7e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:42:46.941+03
726	962fdaa6-da69-438c-8083-bd1bdbcd7e63	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:43:17.048+03
727	eb7617ff-032d-4cbc-9dff-f5ee99a72c8a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:43:17.07+03
728	7bab2159-6d08-4acd-9214-737299465e10	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:48:51.219+03
729	984374b4-0c4a-4593-9104-74d9f052d6bf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 07:48:51.221+03
730	c673dd97-ceb4-444c-839d-737a62209507	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:03:33.236+03
731	84a5ece9-53dc-4efc-ba28-5403aaa1ad5f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:03:33.238+03
732	6aabc4a8-9845-490c-93a5-19d9f82a6032	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:14:49.949+03
733	8f42fdd3-8254-489d-943e-b853e734680b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:14:49.951+03
734	4c91cd6e-644a-4fd4-a8bb-c082b0c2cb5f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:22:24.411+03
735	7d84df56-2413-495a-b6e0-95c15be9fe91	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:22:24.415+03
736	56777178-ddce-41dd-8256-bd5ab0a89c56	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:22:39.434+03
737	28844a18-3199-4bf9-928d-fad2d9b3c5b5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:22:39.436+03
738	2907aa37-bef6-46b6-ba58-8bab77eba605	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:27:48.519+03
739	611cc763-f656-40aa-acfa-c01fe0221a70	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:27:48.527+03
740	c1591718-edab-4623-80f4-e703a53440b7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:29:27.897+03
741	31e436da-a3e9-448e-b94c-2ffd28bcec08	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:29:27.904+03
742	c3b47898-a92d-46ca-b4a8-4d2b7af28158	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:30:10.406+03
743	3957026c-aea1-495d-8337-64fa04d4c665	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:30:10.417+03
744	238607fd-a8dc-4ff0-aa09-002f3f2c9183	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:33:36.031+03
745	4113eb33-ead7-4d76-be5b-448749d08120	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:33:36.039+03
746	8885afca-e4bd-4e11-8423-5df315dcd316	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:38:33.758+03
747	f2983256-0cc5-4cef-87ac-f4e5b3a8fa51	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:38:33.78+03
748	a6551ebc-68aa-4005-9ec6-6f07ef092799	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:38:41.21+03
749	cbd08b5d-9307-4f46-9b88-a3fdda16428c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:38:41.22+03
750	f30394c4-fba9-45fe-bd52-190c564a27c1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:42:22.233+03
751	1727858e-e990-4fc7-9173-df1c68b80590	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:42:22.246+03
752	405b642b-0285-4782-b3a5-b53c2e4e5b3b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:46:28.263+03
753	8319169d-48d4-46d7-b2fe-0a7bd00f556d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:46:28.267+03
754	99b656ee-cdbe-4760-b7bc-caf38a41574a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:54:37.76+03
755	ddccff86-f027-4a7a-a193-473164078fdf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:54:37.763+03
756	b7c7f64d-6def-400e-b1be-7cac366cb173	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:54:44.106+03
757	efafa9b5-e52e-4752-978b-0687e378ea56	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 08:54:44.11+03
758	a860bf3b-6544-48f4-b5ae-33e3adfd581e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:15:47.716+03
759	dab0aecf-0de2-4b1f-b232-fa0925d93398	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:15:47.722+03
760	b71f5996-e6e0-4693-b537-8c712f94d5d4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:17:13.197+03
761	86af41a6-fe93-404c-8202-435095d4b43c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:17:13.202+03
762	2d6c90d5-8ffb-49e4-90c2-6ff1e302f73c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:17:41.425+03
763	052e6f3b-4403-4968-97e9-d36e325dd5ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:17:41.43+03
764	d29779e8-7f4b-4908-8ed5-dd04086f2483	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:45:50.841+03
765	49e283dc-7c1b-4a82-9783-aff4a1f525fd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:45:50.849+03
766	55baa8bc-e72a-41d5-a3b6-76f04892b686	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:46:01.198+03
767	a0350b7d-ae97-4c9d-a7cb-ddbd2491b7e2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 10:46:01.209+03
768	d07f9a4c-cdda-4aaf-85e3-28c8ef5a0377	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:03:02.348+03
769	0fa06d77-e75f-42cf-b9e1-41f3df80c27b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:03:02.351+03
770	972a7f26-6fe3-4e97-a518-37a5a4e39117	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:15:36.003+03
771	1026d196-dbe0-4e72-b837-ea3a97969502	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:15:36.008+03
772	5af5e3e4-a91a-4978-b887-3c57ce30e644	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:17:31.602+03
773	4f258048-3d93-4274-a845-31faa1bc478c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:17:31.605+03
774	7e6d3b18-643c-4e2a-8e53-8b2551f56259	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:22:49.895+03
775	2679ae4f-3c05-4c96-bee7-e0056705d66d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:22:49.897+03
776	997168e0-1e5f-4606-a9e9-96b5e556da44	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:24:27.878+03
777	e04d3240-58c7-4c8b-a106-5b87fa5ec64c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:24:27.888+03
778	dd6a698d-ce8e-4ea2-8e35-2185b4a2931c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:25:11.684+03
779	6a3ecfcc-4f2f-41bf-adee-f438e166748b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:25:11.693+03
780	3354f80e-2571-4921-b076-68b347c30d7c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:34:59.197+03
781	ef272647-affd-4071-a849-c651d928b5db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:34:59.221+03
782	fa095099-41e1-48c9-ab6d-d5ca0ba3eedd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:39:53.178+03
783	4ff56f1c-b1ce-4361-82f2-fb5f039dcea7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:39:53.205+03
784	ef062261-b723-4996-b91d-e26a352dd3fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:50:18.038+03
785	cfaab89e-cddc-43b3-9a69-359d1b538fd5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:50:18.047+03
786	1d9d4341-9eca-4fae-8015-a80a6f7948f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:50:27.1+03
787	5af0a490-8309-45b9-93b6-d0bc2a712ad2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:50:27.109+03
788	c4d5f9d5-9fb5-4caa-8aac-60375bcfe462	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:53:16.388+03
789	aa238311-3198-4d43-bdb8-c60580dd604f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 11:53:16.4+03
790	928dc573-0491-4df4-910c-4f1ef7161d91	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 12:01:15.282+03
791	8a84a817-b8b8-4399-abd6-1c3511c8e359	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 12:01:15.311+03
792	a24fd95a-b6a8-4d56-ae54-bd5977b1029f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 12:49:21.534+03
793	f71b2111-86a6-435f-8c35-ec2a0e16172b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 12:49:21.554+03
794	3167e62a-26a1-4fc3-96b1-935fd24ecf7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:08:37.802+03
795	d3c4b981-0541-4a48-9c53-5ef193348e65	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:08:37.808+03
796	9c4d028c-a998-4e04-a51b-39a91e43fd80	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:14:07.301+03
797	1c9dd9d8-87b8-4f99-9c9c-0fa23f031ed7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:14:07.308+03
798	2245357e-0dfa-47ec-96bd-e5ca823ce8db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:20:32.171+03
799	55e5c941-13d6-41aa-97d6-d8cf2386f21f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:20:32.18+03
800	293369bf-9d46-45ed-96ad-57ad81a0b243	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:31.053+03
801	87859926-df81-49f9-9144-23bb7c2e5e0f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:31.064+03
802	c2e3c293-5aa0-4cb1-ac1c-19a316a95343	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:38.397+03
803	b041cab6-3137-4104-a4ae-4fd27b8af5b7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:38.406+03
804	d00ecbd3-7422-47de-b359-9c35e4dea702	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:42.676+03
805	f0bab97c-28b4-4cca-ad6c-d3d8e5fd96f2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:42.686+03
806	18182aa7-539d-4654-88c7-d4556d472c68	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:51.432+03
807	f2d4241b-16ea-45d1-8b56-49372ebb6530	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:22:51.441+03
808	f3a821cb-4e8b-4653-bc56-e667bac31d6b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:23:34.838+03
809	9091608b-540f-4f71-aee7-fd79bd6dcd11	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:23:34.86+03
810	9ed3dccd-c865-471b-a16e-3a876e138637	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:23:41.153+03
811	917da0ac-fcf0-4b15-a515-db1e0aacd035	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:23:41.162+03
812	df6052b3-6bb7-4127-9883-25b5d61246c8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:24:01.459+03
813	2a54ccc8-ca6f-4964-aa32-8cf2b4deb0d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:24:01.467+03
814	6c264b5e-81fa-48a7-b744-028ae6484b1a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:24:23.884+03
815	bd534254-a114-4294-8d00-b8adfcc42dd8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:24:23.908+03
816	5139e1cf-2990-4890-95ce-8cf09a1179b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:24:45.09+03
817	cb313d41-e0a0-46dd-91f5-99f4802c5a13	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:24:45.1+03
818	72761f55-a793-4a9b-9fbf-9d9b8158e88d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:26:22.724+03
819	72d4c367-7d97-400c-87fb-b033a2b0feaf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:26:22.726+03
820	e802c37e-8fd8-48e4-9aac-27fceabf6b8c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:26:29.519+03
821	32525709-3015-43f4-8236-d7f64db72ee4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:26:29.521+03
822	3f2a6fa5-188e-42e7-a1b4-3a3a3090e22d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:36:01.638+03
823	65421c4b-eab2-4a76-acb9-5237a220a99d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:36:01.642+03
824	b147ebb3-bdbe-4272-ba9f-976815a670d0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:36:06.897+03
1227	ac9838bc-c331-47a0-8f7b-7ceb03eeb7a3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 02:37:21.317+03
1226	50358077-2681-4139-925d-b6b44c8fb224	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 02:37:21.31+03
1267	7249efc3-586d-45c5-adc8-36deea24a3fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:10:41.959+03
1309	19923b9b-582c-41ef-b683-d9497387809f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:44:39.597+03
1310	c3253e46-5c80-40d1-b4a5-5a96ddcbf60e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:44:39.603+03
1348	75675c41-1a27-41a7-8e66-061963cc220d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:24:56.952+03
1386	e78123e5-6c69-452b-867b-6807831c3068	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:46:58.836+03
1387	fb42be7a-529a-4d19-a31d-50fc230e3928	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:46:58.833+03
1409	0e570002-030f-4369-987c-634869d85563	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 22:09:32.583+03
1410	851fc95c-47e8-4925-92c3-9d88b96b302c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 22:09:32.598+03
1428	4c6233db-9f63-43a2-9fda-cdaad47a229f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:50.199+03
1437	e46b0e67-cb7d-4e75-a37b-cd29a0e84344	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:31:43.545+03
1438	059690b9-b96f-471c-8533-3f2ea019f77c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:31:43.549+03
1449	ed2a55ab-1b54-47d5-8aa7-681f40b1571a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:47:06.6+03
1450	0cfe9fdd-7541-4cc4-ba64-8c1a5079402c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:47:06.605+03
1455	b8e02b19-951f-423d-83e6-f6a1af16dcd6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:07:49.718+03
1463	2c89e0aa-f630-4a95-a965-bbfae58ffcea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:17:54.866+03
1464	610f2bea-6dc6-438b-a428-1e073f6c9502	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:17:54.871+03
1465	05a79133-7248-44b9-9edc-22654e78eddd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:18:00.463+03
1466	8394b78a-85eb-4923-9c03-987166053940	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:18:00.468+03
1469	8ae94dff-96fd-47df-bd34-33a474151150	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:18:43.019+03
1470	af2a94e4-f83e-4f93-8857-421694f77945	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:18:43.023+03
1475	25e30f1a-f3b3-40d1-8f73-2bfa6991df2e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:14.783+03
1476	29770108-dea7-4612-9fa0-9996c4e15289	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:14.79+03
1479	f264a3ab-d5fa-4c6b-99f9-3abbc35412aa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:44.575+03
1480	38305c2b-d6df-4b93-902a-04992c20c578	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:44.588+03
1483	1f34999f-3cd5-496c-b632-46d46a28090a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:20:59.123+03
1484	f40cfca3-ccc7-46c0-9c7e-91bb710c5e4d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:20:59.128+03
826	17e75de8-dbf1-4c1a-85f8-c7c8aef0db1d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:57:52.228+03
827	fbcb767c-de12-49c4-9f71-f3962f58a507	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:57:52.237+03
862	982c214f-e913-431d-b939-4691453873e6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:07:24.615+03
863	e0b1deff-1462-4d7e-9d3c-9f443a9056ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:07:24.639+03
902	e1d5e152-1257-4af1-82aa-e188ad66023f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:00:46.357+03
903	d2d68af3-aedc-479c-ba88-411266a4c8a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:00:46.381+03
944	e49168de-d6e7-4718-817b-0f8d6a2d67dd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:09:54.55+03
975	fc884b5c-4aed-4fe6-8f55-03500b009eb1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:04:08.244+03
1004	727a0cbc-f007-467d-9fc1-5820cd60bb39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:09:10.847+03
1044	f42dfeeb-986f-45d2-99d4-be9d6f318f32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:10:45.123+03
1045	9003e4ea-1b0a-4b9b-90a4-ae7af05a4ed7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:10:51.273+03
1046	ca7c6ca5-139d-408f-8f01-e43c89632d76	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:10:51.279+03
1077	76b18614-f9fd-4737-bdd6-2b9d8e777864	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:24:29.88+03
1078	12c781f0-0d51-4306-ac15-9f60d35d8fcf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:24:29.884+03
1123	4b68fe0e-fe02-4d34-971d-b3085a159203	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:02:52.814+03
1124	f42a5b47-a523-4515-9467-f27ba673609a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:02:52.83+03
1169	b337dee4-5926-46b3-a73f-d2a2992b7789	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:38:34.831+03
1170	32147691-c1d2-4012-bc2e-0566d29fd974	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:38:34.835+03
1198	cc49808c-5239-4671-8632-b2d661c23d61	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:33:36.002+03
1199	44235490-8095-45af-8a25-6187ddb1a3f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:33:36.037+03
1228	56f068c6-1db9-40b4-86e2-80e3f3ebfe11	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 11:59:22.883+03
1229	18768447-f662-4773-8d78-d1835cd27634	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 11:59:22.908+03
1268	c0eafdff-ca13-48b8-b916-5f27e812ffb0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:10:41.96+03
1311	14c5dbc9-cc62-4288-b4f6-8b5e5b89eb58	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:47:02.093+03
1349	d6c17bf1-68d4-4896-91a4-43b58c07573a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:25:52.698+03
1350	fbdb5563-9b4d-4bab-a66e-8eb4b011b9ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:25:52.714+03
1353	92350200-ade3-4f74-8252-f2a8681249b1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:12.539+03
1354	13146ff7-2c57-4dc5-bd5a-41ee5895478c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:12.55+03
1388	8205a63d-413c-4be3-b87a-d47203cc95f4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:09.283+03
1411	60785571-65e3-4bd1-a530-0ebfd52c796e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 10:52:26.321+03
828	027c09a1-1fe7-4b14-a979-426a5402cc94	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:58:31.08+03
829	7db4d4f7-52fc-420c-bff5-a3e7d54c0276	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:58:31.091+03
864	63872365-6091-4167-a00f-4a30a8d3b015	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:09:14.674+03
865	40766df0-2113-49d4-b5e8-a21953332707	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:09:14.7+03
904	fa7af24c-2299-4f37-b53e-67f7db678485	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:01:13.287+03
905	1092f97a-8f05-4fa4-9859-6d4c470fc5d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:01:13.296+03
945	381b911f-4109-40ab-8a9c-6680ba402f16	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:09:54.554+03
976	80a10fb7-74f5-428b-9d85-5f6712f91716	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:04:14.407+03
977	804131c5-832e-48c0-b024-c68d6f8e3b48	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:04:14.413+03
1005	6fb03274-6627-4708-82a3-386de3133095	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:09:10.851+03
1047	713e1eaf-6af4-4ab9-871d-a78fd38ba945	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:11:03.464+03
1048	12536e97-7e1d-4b80-b65f-89bd43de3458	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:11:03.468+03
1079	04d07499-7cd3-465c-8e12-404d5254788b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:25:07.019+03
1080	e154931c-1f1c-4f15-8ebb-e39d47e2c05e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:25:07.023+03
1125	7ffcd3fd-9f8f-4a20-a9ba-28290c03cfe1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:03:27.037+03
1126	82e6f19c-45fe-416d-9484-39a14520ae77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:03:27.069+03
1171	1024fb6a-00ac-43b2-ae1d-4b2a8c207a8a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:39:08.022+03
1172	82b69c3d-fc92-459b-ba50-a557215ec79d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:39:08.027+03
1200	75c1c6bf-8a57-46c8-9cac-f4ecab04ab2f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:33:43.347+03
1201	fd763a99-f72e-4e35-8717-11c7dd3b36cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:33:43.359+03
1230	fcccfdcd-3db9-49a8-a2be-577a9535224a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 13:02:39.161+03
1231	ce013bc3-e2aa-4c3f-8b0d-3a7bbea500d0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 13:02:39.187+03
1269	35f5541b-3d61-4478-ae29-11d5879548b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:11:30.035+03
1270	364373ef-0fd2-4b31-a02b-eb957060d596	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:11:30.038+03
1312	dceefb98-40d7-4fa7-9e71-898ce5690747	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:47:02.096+03
1313	a72e517e-eba5-472b-8f10-a563991c922a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:47:07.516+03
1314	a5185ec9-626d-462d-a533-1a8b59c6fa4f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:47:07.523+03
1351	9734ff08-d970-46cc-9e7c-415001d2def3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:02.314+03
1352	927cafc7-a56d-464f-a0b2-351366bdc4a2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:02.328+03
830	2b9d570c-40ee-4e90-9f18-a22322f670fa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:09:41.418+03
831	807c7363-1d4a-4724-82f9-149ce07edbf4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:09:41.425+03
866	9f053da3-da41-4e83-8c05-58c91bfc60fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:20:34.589+03
867	89420fb5-b728-4595-80a2-4219ffe78687	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:20:34.601+03
906	ed51470a-6234-4316-b02e-91325b1904ab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:01:57.144+03
907	91039c79-1c15-4eed-a4f5-d81513415ef1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:01:57.166+03
946	bea46a68-aabf-4700-8899-c97d4938f902	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:12:27.944+03
947	c7556e84-be2f-46b5-ba93-546f566dd81d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:12:27.976+03
978	b2f19b79-8c3e-4b33-8701-5b0904b0ec58	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:24:04.341+03
979	980b8f4e-af36-4868-8793-2f368b17f675	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:24:04.345+03
1006	d48bff00-06d3-4711-9fe3-9356711acb03	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:09:45.61+03
1007	0cb1fd5c-b3ca-4602-b90c-5b49e7b362a5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:09:45.614+03
1049	f856534f-4172-4b98-a68f-69cca0b98e76	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:24:30.87+03
1050	0fa227b9-d5da-4654-a332-a11513641a5e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:24:30.871+03
1051	a6eb2604-2303-40c6-a30e-cf447e2bb62a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:24:36.322+03
1052	15e1e3a8-ec68-4930-ba0f-3079ffd09441	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:24:36.329+03
1081	717072f5-c676-47d7-bf99-f1ecd0bf209f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:25:38.664+03
1082	98712f2a-0006-4bbc-90ae-c76541bcf93b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:25:38.672+03
1083	dafae391-f751-4bfd-9f6d-ce72c05da4b3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:25:57.663+03
1084	e91de2bb-e7a7-42ea-b779-c547824ff35a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:25:57.674+03
1127	0008440b-c946-4900-bd69-2fe99a42c996	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:10.339+03
1128	035ec73e-62a0-4cf1-abb0-936f1d4dd393	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:10.351+03
1173	99c753cc-12f0-486d-be7c-4496560c8566	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:42:01.842+03
1202	0e1224c9-c7a8-4fba-9454-b784b1ca3768	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:34:32.011+03
1203	84dcf014-b93f-40d0-b793-4396650e0718	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:34:32.026+03
1232	d5c239ae-bac3-4af8-8bee-d7c63b091d59	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 13:03:13.377+03
1233	42b6817b-2e78-4fed-8a29-a3b1e6a02245	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 13:03:13.381+03
1271	fdb205d5-240c-4ac7-8e48-7ac357152b79	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:20:45.364+03
1272	2a704d95-39e0-4328-a03f-c1828bf96a5e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:20:45.4+03
1315	66fdb481-d0d1-481e-bf05-a8b2db01a228	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 09:45:08.27+03
832	2e232a34-fafc-4c8c-8174-82b423e4cd4a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:24:10.749+03
833	83bd6b4e-d673-48a2-b925-942262e475ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:24:10.756+03
868	631b177b-babb-4ae1-8b24-c75f001539c3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:20:40.163+03
869	18a4e5c2-9fcb-4e15-8ae0-791c014b7073	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:20:40.176+03
908	82c81c67-cd4c-4f2b-84ca-cfab8bffff99	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:02:13.905+03
909	b9c6e6bb-4519-404e-a0be-ab12e149bc53	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:02:13.918+03
948	dfdc8880-e2af-4232-b330-73b62c001d3e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:12:54.15+03
981	dd3abdd1-02c9-4947-aa9e-19a673554941	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 16:46:30.506+03
1008	54afeb0f-1496-4154-96a4-9a35ad626b03	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:10:40.239+03
1009	0672c6bf-c5cb-4f7e-b903-7894c606c331	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:10:40.244+03
1053	77d250a3-ea75-4faf-998e-8cf37779d82e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:25:39.663+03
1085	e6c6861b-581e-4866-a258-2964ceebd3b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:26:44.974+03
1086	58008eb7-c5c2-4ce7-9017-47e21d7e1804	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:26:44.981+03
1129	bae2a99d-5e2b-450d-b93d-d025e411e4cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:19.431+03
1130	32043806-c219-46bb-b9eb-409e86f3e90e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:19.448+03
1174	c0328366-104e-4ad4-9439-b6bc6a7f4485	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:42:01.846+03
1204	86640fc3-c1a1-41e4-a99d-63295a9d04ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:35:29.999+03
1205	6a3665a1-b8fc-438d-8f06-13f7266d0eea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:35:30.004+03
1234	a80b4b26-ea67-4d6c-83e9-711b627a2d6d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 14:16:08.465+03
1235	63e96b8d-1b8b-4f8f-9903-3fa6512f316a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 14:16:08.474+03
1273	b976c350-3846-42e8-8264-1c04931e3be3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:20:47.471+03
1274	ed4e44e2-66c7-48c1-9e13-103cd3ddb2a2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:20:47.479+03
1316	29e836f8-f1d6-4c20-8920-101c44f75cf0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 09:45:08.275+03
1355	3ddc43c3-23d0-4bf6-989d-cf925d67c5a9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:22.544+03
1356	f213e464-cc06-4eff-8f95-7c406aa323af	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:22.555+03
1389	19231c8c-bb04-4cb9-99ee-5b2e159d1f21	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:09.288+03
1390	c4c6b1e9-6b58-4166-9348-bc7190d02a7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:15.931+03
1412	775d232b-a5c3-472e-a33c-5d9033fba64a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 10:52:26.366+03
1429	985c4b17-a8c2-4e97-80ea-f7f868046aa7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:53.656+03
1439	482ca27f-5803-4320-aa3c-5c972fc4392f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:35:54.433+03
834	29354000-3cc3-44e0-8763-a9b08f4e9f48	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:24:20.744+03
835	916ecf2c-d81e-44f2-9740-c5f7032e5147	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:24:20.755+03
870	7a69c9be-b131-4280-b533-d331c467347b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:21:17.197+03
871	ef148a4e-b0a8-4ad2-9152-1b871cea8bd3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:21:17.223+03
910	f16b2688-0065-41b3-aa2d-e1d7ae14b73d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:02:34.068+03
911	6366c71a-8c99-46eb-bab3-f73a5c06534f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:02:34.076+03
949	9655308e-0453-4719-8ab2-142702f55540	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:12:54.152+03
980	cfeaef9d-1a66-4348-a574-ad01ed9dcff7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 16:46:30.504+03
1010	ebe8f2d4-1116-4872-a686-d2dba958f140	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:12:43.995+03
1011	52d92edf-48e5-44f0-a95f-5de10d36a6f9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:12:44+03
1054	e7357981-ba14-4a6b-b24a-a72ed2fd4f2d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:25:39.667+03
1087	1d58e8aa-c9d9-41ef-a388-fcaaef7a044f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:26:56.994+03
1088	f93f2e26-550a-40d5-ae1c-030dbfe7be54	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:26:56.997+03
1131	587305a1-33dc-4308-94ba-4527af43ba24	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:30.175+03
1132	f3556233-95b6-4bc3-a3fb-dab24f50a9ff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:30.187+03
1175	48a1882e-0045-449f-92ab-7102f57147a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:42:52.572+03
1176	ca62bf8d-2815-4299-b4da-df68f5265a2e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:42:52.576+03
1206	b84551be-a6b4-4f49-9dbb-fb7674c479f0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:47:33.828+03
1236	d1099d1c-732d-4b6f-acad-d4868edcfb89	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:33:34.117+03
1237	b065698b-efe5-4fee-8858-d363f19a621c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:33:34.129+03
1275	c1a2535a-05cb-4008-8ae9-3347fe9628a8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/gallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:25:53.734+03
1276	5f9fde63-922d-4cb6-9e2e-0bc1d622f9fa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/gallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:25:53.737+03
1317	764bcbc8-933b-46ea-a869-202c9308e494	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 09:45:14.107+03
1318	314d77eb-6a51-4f46-a315-6b041adff8a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 09:45:14.123+03
1357	c6867d1b-fd98-47e6-8cf5-e3cdfb64ff52	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:52.633+03
1358	a1761b4c-59d9-466c-bee2-8c60662863d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:52.651+03
1391	bfd5e0b9-c6a4-4b07-996e-aa7c750815fe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:15.933+03
1413	2ebdfecd-a302-456f-8be2-ba1f872b7b2c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:21:34.873+03
1415	c771b7ae-b91c-4db1-9481-207e9daba029	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:21:34.882+03
836	9e24801b-1ef7-4ddb-a9b6-771bf24ad4c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:41:36.551+03
837	d1aff3be-0f03-4a6d-9254-0659c2787e4e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:41:36.561+03
872	80416952-dac0-4e1b-9d18-d9c6634789d1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:24:31.74+03
873	0e2ecba9-22a1-42db-be4d-77b5bc20be85	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:24:31.753+03
912	5f455287-b637-45db-ba7a-7bdffd2a0af3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:11:05.731+03
913	8d0c2aa1-4efb-4176-a60f-d8aa074c9a7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:11:05.745+03
950	f4e16f2e-343b-4485-b023-b9f6c7cc22e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:23:15.85+03
951	8f7d03e3-aeb5-40cb-b8a8-5200fdee0869	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:23:15.881+03
982	6e8af467-3c74-48ba-9b04-fd66b82f2d80	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 16:47:05.846+03
983	d11af2b2-3654-4b1b-b50b-9367c83ef649	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 16:47:05.848+03
1012	cea2fcfb-60b2-45a8-a9d1-19192dddd819	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/20	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:12:56.978+03
1013	5918b370-32a7-489f-ab74-cc3ba9063669	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/20	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:12:56.982+03
1055	a9d61a84-4b72-4d87-a97e-38db07025993	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:31:23.579+03
1089	457c2dc4-d448-48d6-babb-882dcfe8edc0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:27:23.209+03
1090	23c96e1d-7b1a-43df-bebd-8d6131b03c93	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:27:23.213+03
1133	ad49d8e8-bfed-4dbb-92cf-2137a3ded11a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:38.73+03
1134	e4c8c2a8-3c98-44ab-b977-5c1fdf1bad28	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:04:38.744+03
1177	d7751a3c-4b44-4fee-a489-26636482ef5c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:48:01.056+03
1207	b309322f-9a71-48d0-9f0f-e91f69b7c2e7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 14:47:33.83+03
1238	3fe6f83c-6237-4e8c-8f90-47f778b6dc9e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:41:32.5+03
1277	b5a5b8c3-cc01-4a55-bfd7-a1f6debcc0d4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:31:43.366+03
1278	18681f44-9185-4232-816f-f1a90f3a0947	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:31:43.372+03
1319	69c64480-6a63-4301-8597-a2575b674acf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:02:24.754+03
1320	e536a998-50f5-4b62-8d52-6f66ec93142e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:02:24.756+03
1359	350178f2-3d74-42e1-9b57-e4ee65b4dd02	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:56.299+03
1360	ecf259d1-3b39-42f8-86da-f245c65a78ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:26:56.313+03
1393	f54f1f0a-f4f4-433f-961c-aceb18097625	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:38.061+03
1394	c7e5dd72-796e-4aba-9103-8dce1dd7ac7a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:39.368+03
1395	6e135a9b-196e-421f-86e8-5aa1c30798e9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:39.372+03
838	3fd662c3-767b-42d6-8c2b-a95f5eb9fc98	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:55:51.265+03
839	444b2a09-429b-476a-9e33-03d444543a95	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:55:51.273+03
874	cce8bd87-327e-4c66-b79e-c3a8a39480a8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:31:10.206+03
875	e9284003-ff13-4dca-b043-bc3e3a2f9ed3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:31:10.221+03
914	2f08a0c7-bb05-4ada-83c3-ce49cc9da191	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:11:46.379+03
915	f8afedf0-9356-4187-903c-75ff30d0a66c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:11:46.401+03
916	85b7beb5-98aa-4735-8612-5ce280e71a8b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:11:49.828+03
917	e231740b-a39c-4536-a39a-2ff7fed17b40	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:11:49.839+03
952	d5368ba2-b00c-497f-a432-d9f88311989a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:24:12.42+03
953	76d55318-ae8c-4c9d-aae3-ef9ae4490e1d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:24:12.43+03
984	5046bb14-158d-4048-8991-4a3c688dbdd8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 17:14:30.784+03
1014	bd35888e-101d-461d-a724-839b0909fb2f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:02.067+03
1015	902d8115-b914-48ef-a506-3b5f2ba8eed7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:02.072+03
1016	487121b3-b09a-4b78-aff1-ff8c57813ca9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:12.735+03
1017	266d220b-ede3-4840-9818-d7d03d2da881	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:12.739+03
1056	6616b52c-c0ad-40e9-a085-df316ede233a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:31:24.081+03
1057	ea46cfac-0dd1-4fb8-943e-196130d9fce8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:31:30.209+03
1091	7aa519b8-d424-423a-a0ec-d3ec1aee49c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:27:40.952+03
1092	e5be0c9e-b792-4aae-b458-efffec81e45c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:27:40.956+03
1135	8b431123-1b67-4eb0-9939-b775094eaaae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:00.751+03
1136	f00b2a48-1ee5-4807-8a92-b0817783f690	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:00.77+03
1178	6965b151-1b78-435f-a79c-3792ad444c5a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:48:01.058+03
1208	7a1af4dd-5894-4137-a460-a88cfacf2685	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 18:44:41.534+03
1209	8b8e64dd-d359-4d26-b5f1-8dc1044b102b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 18:44:41.54+03
1239	2ae5b5fd-4f48-4129-8722-af656fd32bb0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:41:32.502+03
1279	ffe6aac3-b862-4230-9bcf-73551e4b6a85	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:43:03.532+03
1280	85a20250-9ae0-4ff1-9f3f-75dff80dbeda	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:43:03.536+03
1281	b8eeb804-f857-4504-9672-5441014c88ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:43:06.587+03
1282	593a6a20-b446-4823-b0cf-735f69b30b07	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:43:06.591+03
840	ab32392f-74fa-49f6-8b23-b3cde01cc6d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:56:21.119+03
876	9eb3e7e6-a3ed-4deb-b9b4-135a0b749213	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:33:47.95+03
877	fc02c63d-3159-46d1-9325-2f6f18e49f92	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:33:47.978+03
918	f17f9442-7598-4308-89c0-cf31782552a8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:13:30.175+03
919	86991e06-dfa0-4d23-a6d1-de75afa86ae6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:13:30.185+03
954	b549d7e0-c5d1-457a-8a20-03d38b8c9500	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:24:22.773+03
955	ecc6fa79-eeed-416f-a45b-214a9e816ea6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:24:22.786+03
985	4fed179a-1ea4-4826-a68b-bd2f63aa4f48	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 17:14:30.786+03
1018	64c913d2-11f0-4114-9a9c-41b9d573b85e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/20	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:32.445+03
1058	d6674671-65b9-4044-8f24-a4bb1c75604f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:31:30.211+03
1093	b5a8ae5a-531e-4fb0-a224-e63ced1fdd3d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:30:03.499+03
1094	0ab3afeb-3f8c-474f-9448-1c4e833b33d3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:30:03.504+03
1137	dc386e0a-7fda-4d01-a895-8f8cde5e6c0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:26.796+03
1138	a5ba4fd5-033a-47d1-9b6b-1b4b4ec21d3a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:26.81+03
1179	38e4ae68-a103-4e5e-ad87-3b1bbdd7c606	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:48:42.822+03
1210	b51cad95-2aa9-4008-9d55-c7bb336c4f88	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 18:49:30.926+03
1211	4b50c74f-e2c1-4285-886b-5864b6ff5808	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 18:49:30.931+03
1240	743e9906-14d8-44b3-a634-5821b3b57a8d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:46:22.331+03
1241	bce79baa-8629-4cc9-8387-8a85ffa681b4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:46:22.333+03
1283	975c91fe-e82e-4503-a49c-b78bba91eda1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:13:23.138+03
1284	d61d5fc6-92c6-45cf-ac0f-d0c3dcc9ea95	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:13:23.152+03
1321	8be79cb5-69dc-459a-b7a0-00ce05fc4be9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:04:30.471+03
1322	5674b5eb-8440-4dbc-862d-56e03c66d315	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:04:30.472+03
1323	6270a294-f288-4065-a770-711cdf271205	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:04:33.958+03
1324	de8be2f0-c6e0-423e-9b2e-0c958d581e27	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:04:33.961+03
1361	1517d21e-6d1e-4252-8b5c-61a3e340f01a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:27:05.751+03
1362	1afb693b-5b80-4969-aab7-2122f09416b3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:27:05.772+03
1392	be99126b-cb76-40c5-9ad1-0073038fb694	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:48:38.059+03
1414	62275250-4fc5-4b96-a574-7138854e2b3f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:21:34.875+03
841	18ee73d4-2206-4263-be4b-8dbb7cc32174	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 14:56:21.122+03
878	d2d61c62-0399-4491-92b9-cbeabd0c6a6f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:35:23.887+03
879	36c3d7ff-db9e-47ee-be68-bea0cabc3a24	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:35:23.898+03
920	f77df50a-9b22-4ab1-b527-39fefeb78fbe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:15:19.033+03
921	38317aba-87b3-4bf0-bb7d-7472be35d0ad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:15:19.041+03
956	f23dd236-6eac-42c5-82de-39e266c35bde	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:30:51.257+03
986	88e1e7b5-e954-43fe-b0fb-2d1b53504a2c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 17:47:52.653+03
1019	da82f4db-8398-44a2-97a5-a3e9724aec4b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/20	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:32.447+03
1020	bc1e8d43-d549-476e-94f7-c1c7ba2cc6ca	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:37.431+03
1021	759eef4a-80b7-4cd3-adff-e995d1306952	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:37.434+03
1022	a9879090-8772-4b57-ba86-a4dd9c4c9495	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:47.214+03
1023	5e2f9825-cae4-4c67-809f-5ea9ea904752	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:47.218+03
1024	8e1da5f6-3c5a-480e-b4f9-6b8b469c1623	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:54.812+03
1025	90283ce2-bfee-482b-8715-0e3ac7637ebc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:13:54.817+03
1059	c4fdbe49-b7bd-4c1c-a99b-774a745e8bd0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:43:53.039+03
1060	1f2ed783-bc24-40bc-929f-2db341f65cb1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:43:53.069+03
1095	3461902a-7168-474c-a796-25de1fe804f2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:30:48.237+03
1096	703c279a-60d0-4aa2-881d-001a1f7874a5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:30:48.241+03
1097	02018d5d-9998-4655-8152-36fad37d54da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:30:58.607+03
1098	ba877a7d-b9dd-44d2-9764-5677852a302f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:30:58.613+03
1139	ef12f8f5-e971-470c-aee0-caf60febf696	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:30.178+03
1140	ad00b7db-b2b2-46e6-b8fb-7a3a23766bf2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:30.201+03
1141	12a610f5-6957-4d1d-93fb-ef1f2747ba79	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:41.119+03
1142	b3a42c7c-a045-4d1e-add6-09f76155130e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:05:41.135+03
1180	4efab324-ede6-417a-91e1-88aeae2595c4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:48:42.838+03
1212	16227698-26e7-4eac-9964-e7fabaae827c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 18:49:52.958+03
1213	937a65ee-c07c-4609-9eb0-bd1b76a25b9f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 18:49:52.963+03
1242	5893d42c-b6bb-4792-bfae-05db34c8a539	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:51:38.155+03
1285	301bcb6a-7bd4-4b32-b6f3-477d2e2f65ae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/gallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:13:52.481+03
842	f87a4824-b77d-4a67-be94-e3e547bed03e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:02:39.536+03
843	fcfb8c2f-56e4-4638-8ee7-d8426d87bebd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:02:39.543+03
880	15f3aafc-3e3b-4bfd-9016-d9b1547c8050	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:36:39.465+03
881	b59e34c0-dcd8-4fbf-ac43-cbdee88c6478	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:36:39.489+03
922	1a56add6-3f6d-4f88-81f1-99e15bc0baf6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:16:25.782+03
923	97a197f8-be17-4956-a3b7-c55bef7c516b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:16:25.813+03
957	7ddc3f18-ed8d-49ee-8b58-5d35705bb3e9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:30:51.26+03
987	f8597896-6a37-4f4a-8c68-d091b0944903	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 17:47:52.655+03
1026	d6e6aa61-fbdf-4779-829f-4ea21f2fb813	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:14:34.906+03
1027	1b0e8e21-afed-4643-9966-1a6de15d8be6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:14:34.91+03
1028	8f88f9eb-1e9f-4bed-9182-e93e42e0e04a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:14:45.328+03
1029	b14f4306-6e8e-41ac-9e4f-e3e5bf56e2f8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:14:45.33+03
1061	df6e06d4-c560-4c37-a2ec-dfd05177ccfa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:44:28.578+03
1062	080b135d-5b32-487a-a7d9-15f14afd6a84	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 06:44:28.595+03
1099	c5c19d12-69bf-450b-ac36-e1503d8e482a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:31:40.056+03
1100	fb9fbe44-a9a6-43d0-9945-6052c9f7a4d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:31:40.06+03
1101	bc142fbb-b5f3-4e34-a328-266d1b22485a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:31:43.655+03
1102	eae292bd-cd03-4e9c-92eb-e6bf6fb33471	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:31:43.66+03
1143	a5e25118-3150-406e-ae0f-cf770f90245d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:06:00.421+03
1144	f3ec52ee-4897-410d-83de-bdf0c8f4818d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:06:00.444+03
1181	db0cdfc8-71de-447e-a8af-c5742fe6853d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:04:25.252+03
1214	b5e52077-4d66-44e5-95d2-2784cd909e7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:00:27.985+03
1215	40e6d92e-31e9-4cc8-8a77-c352ac0a344d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:00:28.014+03
1243	8fcf2326-87a2-46ba-84c1-7ec572f3ecfe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:51:38.159+03
1286	69dbf8e6-745c-4535-95e3-f3d20b568e0b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/gallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:13:52.482+03
1325	40927361-1302-4045-8e15-160fdc3e630a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:08:43.171+03
1326	2ac10952-0fad-4b1b-b157-68cc15913a4e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:08:43.173+03
1363	0a3b2806-62eb-4fdb-bce8-567b0c7b3186	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/newsupdates/7	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:30:43.1+03
1364	d7106316-0795-4107-b69d-345cce94290e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://10.18.1.127:3001/newsupdates/7	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 13:30:43.105+03
844	ee3c32f1-481a-41e0-b5ef-3cf3fba0ce27	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:02.332+03
882	9f671914-b42e-43e7-a4b6-5f09efdbb0da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:40:26.903+03
883	b0ce20b2-33eb-40dc-906c-9a229a371cf3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:40:26.913+03
924	89ae0018-b5cd-41a6-a432-694afcbdcbff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:17:14.185+03
925	1d989a03-9a16-4845-ae2c-512b36ea507b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:17:14.204+03
958	07e1e875-d328-46b0-90bc-4d7cf599b0d5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:36:38.19+03
988	8194a7d7-e3a0-44ab-9deb-463035990c14	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 17:53:17.985+03
989	75ad0e3f-36ce-44dc-9c3a-f62897d9ffa3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 17:53:17.999+03
1030	7604ff8e-ccf8-4d76-8264-cef6d2285e01	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:14:57.631+03
1031	254cc21a-bccd-43de-8873-93a420dcccd1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:14:57.635+03
1063	8106a4ba-8ddc-4a8d-bc85-56bf5f4cb6a6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:19:29.691+03
1103	9cfa3439-add4-4537-a853-3d2bedb546a0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:32:15.444+03
1104	81d1928f-5cfe-4fde-b01c-84317f820b36	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:32:15.449+03
1145	ba9616d8-d595-4b72-ac46-b795b52126c0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:06:11.6+03
1146	b6b418f9-3067-4076-8fe6-afc8b7660e77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:06:11.63+03
1182	d2953934-5f05-4b1b-b8fc-878a79cc4a5f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:04:25.254+03
1216	e72d9a03-5f19-496e-b2cb-dd675559db52	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:00:50.7+03
1217	91956952-86d9-4651-806f-86077ada8a39	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:00:50.725+03
1244	f27ae2fe-20d5-4167-b1b8-28444e15b37c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:52:10.707+03
1245	c47ff992-ad37-4bd2-bb44-888bf15d2d4e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:52:10.711+03
1287	35378f53-3fdc-4c7a-94df-983fba42df96	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:20:26.441+03
1327	64149946-2333-483d-90f0-4dda3627d98a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:31:23.297+03
1328	cf27b096-18d1-456f-be4a-c70db6dfa330	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:31:23.316+03
1365	75ceeff6-3cb1-4a63-9359-6ff2cd7a2ada	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:50:45.285+03
1366	7ac8c6d3-99e9-4a74-9431-3ecd6148d550	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:50:45.321+03
1367	bf37a79a-1b25-4925-b821-b362a49b4c15	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:50:51.971+03
1368	7718b781-44ae-49ca-951d-25cf39e6e658	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:50:52.014+03
1396	47a39711-897f-49eb-8463-ec710c525923	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 17:20:49.403+03
1397	7e15bd4b-5585-4488-9c26-a9fde4401579	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 17:20:49.418+03
845	a497e253-a80e-4b15-a092-20882ad84677	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:02.335+03
846	8ffc6b5f-a7da-4491-8c37-c7364c7f6310	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:05.497+03
847	3275bc93-75ed-437d-9352-631a84db8ab8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:05.5+03
884	3224ef1a-05b7-481b-a1f1-de44219c9116	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:40:38.156+03
885	fa1fde1e-a6c2-4a63-b319-99e4b43973f1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:40:38.181+03
926	71245a41-7081-413c-b86b-f1eb73fbd656	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:17:27.44+03
927	dedc8094-694e-4f7e-9a79-aa4390f52a68	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:17:27.46+03
959	d82f272e-d393-4adc-96b4-a8986c4947e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:36:38.193+03
990	57171e03-038a-46c2-abf7-ebfe4447cc19	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 18:16:09.54+03
991	0f17e55c-e5f3-4a14-89fd-5f2d00bd19b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 18:16:09.572+03
1032	2a256553-ea1d-4deb-92f5-78e6e6a16ff7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:15:41.489+03
1064	bdb3def4-ec17-4cfa-a0a2-b24e7bd26a30	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:19:29.696+03
1105	cbafded8-ca08-47ba-acaf-f4f1f1793980	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:32:43.12+03
1106	0674e72c-a41c-409a-beee-24fc3134b0d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:32:43.125+03
1147	aa1517a2-29fe-4199-98f1-0ef593a6eb32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:12:08.227+03
1148	a67e4efc-7828-4aa2-af08-16a80df04288	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:12:08.23+03
1183	6a5bcb4d-15fd-4504-ae47-091d792be27f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:07:44.011+03
1218	2a27bdc1-44d5-4f88-a9f8-cc843537ca89	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:02:12.913+03
1219	65f9bdae-1b0b-45ef-a733-b8562d2c236f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/4	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:02:12.918+03
1246	6f0ecba9-e7d7-4fa6-8524-527a03de4b73	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:52:44.94+03
1247	7f7a1658-cabe-4d6b-a22d-84bc8a68cc40	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:52:44.951+03
1288	94a16179-a6c9-49d1-a59d-fcfc5473ebbb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/courtofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:20:26.444+03
1329	d115f43b-55a9-455d-87d8-3fc9856884bd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:33:37.335+03
1369	1923e256-cf5e-4a89-b53a-0232dc1bb889	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:23:47.612+03
1398	978f4d29-d7e4-4624-9669-bac4b8fe02ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:03:49.554+03
1416	05e2869d-267b-4d09-9797-b3fed012f49b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:21:34.887+03
1417	2e0bc731-9496-452a-ad7e-b043856e9544	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:21:34.894+03
1418	eee33355-9f8d-41d8-88a4-81204a4aa2b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:21:34.898+03
1430	45d63c2a-db23-4af8-a269-a6cde025ea54	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:53.658+03
848	e445b6cf-7424-4c04-8ffb-d867419d1d63	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:27.707+03
849	ee283916-c643-45bc-8997-ac319a32c8ac	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:27.711+03
886	cf469dfb-a649-494b-b71c-bdfa92407bb1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:40:51.517+03
887	4382d301-e56a-4a08-9a61-25fe0c39f8b8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:40:51.54+03
928	530435a7-4701-49f9-a456-de88cce2f99b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:21.577+03
929	7e806219-af0f-4159-a42f-6f640e29b3de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:21.588+03
960	52f64dae-71cb-4ce1-9ee0-af2edd9646ea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:55:26.864+03
961	654ce2f4-a955-4645-a18e-297e78db5d3c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:55:26.884+03
992	0b1e8f1f-49ba-4840-aea5-8c8847726ea5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 18:17:07.675+03
993	61465a7c-aa7c-4ce0-b891-fb7f279f6738	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 18:17:07.701+03
1033	253f2ce5-ffb4-45ef-8522-cb2683df1372	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:45:21.886+03
1034	ca590cf7-fd11-435a-af70-c9d9e56aa8ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:45:21.892+03
1065	adbf3d21-2b84-4276-aa05-4e472688e688	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:20:02.138+03
1107	4f4b28a1-0eef-47b7-b20c-ec0582125133	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:46:07.78+03
1108	e6f7ee24-9607-4991-a695-5b4e359e0e4b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:46:07.793+03
1149	ff92b968-7070-40be-8a44-8de4975b9e83	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:24:23.131+03
1150	c4381c87-6e99-4b3c-a967-e95463b2b254	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:24:23.134+03
1184	05adb988-79a0-45f7-92f3-168caf64791f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:07:44.012+03
1220	402827c5-a6a6-4e82-b1e5-3aea5a5cccc0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:04:30.323+03
1221	256cb1de-b088-4e23-bbf8-d5cc05441480	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 19:04:30.328+03
1248	99191a8f-fc86-40ec-9c82-614bc3d7aa47	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:53:36.615+03
1249	1a976095-ab6d-45c8-b87b-8bc3d91ed197	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:53:36.619+03
1289	f04f11f9-2ad1-458f-bd10-e64a2c234fb1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:24:27.781+03
1290	7614088c-ab17-4e0d-93fe-73561c495be6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:24:27.785+03
1330	debea0ad-3cfc-4636-8d7e-cb8bb6aa7b69	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:33:37.353+03
1370	d927f0a8-4cbe-4bfb-839f-c9bb419a8a0e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:42:08.403+03
1371	cf0337e9-9324-4f27-9183-216372d38d27	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:42:08.484+03
1399	7eb2973b-f908-49fc-a016-093c5cee8bf4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:46:41.969+03
1419	c3ea04ee-1af5-439a-a0aa-5249bbf50fec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:22:51.034+03
1420	2721864d-b679-4e75-993b-5cfd7170b5bc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:22:51.058+03
850	9e76363d-024f-45fa-b878-d6a0f4ceeb6f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:33.648+03
851	398a2aec-3696-4878-9f2d-2c85c1d7bc31	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:03:33.652+03
888	dc4cda1c-8d9b-485b-831b-985f124d6b14	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:41:16.41+03
889	4034a90e-ea42-4f75-86aa-0af294b79a6b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:41:16.438+03
930	3374b3d6-7484-4848-a001-ed95bafa5fc8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:24.886+03
931	356ddf5b-30b5-405d-9e56-800a592c633b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:24.898+03
962	10dfde64-2d78-40d3-ad78-284791c296f6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:59:27.402+03
963	a429b768-90a2-4215-858e-76f167ab0c01	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:59:27.416+03
994	0d877d90-c5bf-473a-adcc-ac295f9a4cca	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 19:08:55.177+03
1035	f45059b7-72e7-4bac-8cd8-49626af9e256	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:56:54.395+03
1036	85b15700-c1fa-4437-8c2d-9e160af78a18	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:56:54.398+03
1066	65c86a71-bd1c-4019-ba7b-dbe503a01a0e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:20:02.14+03
1109	4f7b3a96-d9ea-4d3d-b519-a58c62066ebe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:49:47.799+03
1110	79b8acd9-be6b-4238-88f9-cb57366df580	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:49:47.815+03
1151	ad72d1e5-208c-48b2-bcd9-cf17c9dd6457	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:25:44.935+03
1152	fc230272-ac5c-40a6-bd29-7a96f8695134	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:25:44.942+03
1185	cd6d89e1-d8f8-41c1-b91e-373ea7daa3ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:23:51.375+03
1186	f318f519-f4bb-4407-9496-1d46aad11f04	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:23:51.379+03
1222	cae4c8aa-01b6-4795-9b87-621d2be77150	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 00:23:16.862+03
1223	8cb93b30-2a3d-4027-a1d5-66728c155a8d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 00:23:16.868+03
1250	de8e970f-8f65-4df9-b617-486c63faaa78	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:53:51.456+03
1251	0cfd30fd-c5cc-4e5a-9a04-492fdea5ffb7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:53:51.462+03
1291	81a2b9b6-6c3a-41db-9b48-545394c6277f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:25:00.481+03
1292	a859501c-1ee3-4ec6-90c3-f7370b2d99d4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 21:25:00.485+03
1331	9ee4b7f9-445f-4b3b-8a1e-de368bbf8afb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:45:09.216+03
1332	59212a91-ec4e-4194-8dfc-cad8bbcf6a77	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 10:45:09.218+03
1372	2b8ea0da-9c43-4457-a72e-7456ec7cd29b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:43:33.505+03
1400	e1e99d91-28cf-4502-a3ff-f25f884d92dd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:46:41.971+03
1401	6573b520-5ecb-4e7b-a104-26834fe34826	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:46:45.448+03
852	064c6228-3f47-4d2b-a00a-2abda2922937	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:06:36.03+03
853	02ed7fb2-b3c0-4928-bd30-1d042b2b63fd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 15:06:36.037+03
890	83685149-a339-4b2c-8321-ce075f42cd66	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:41:29.943+03
891	b7942983-da05-48b8-80bb-98636f513b6d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:41:29.962+03
932	70e814c5-edb6-419c-9225-1fbd1a705bd8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:28.101+03
933	d8feb3cf-0214-490b-bf73-3bd04ce1e60c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:28.111+03
964	890b00c0-eea2-4645-a735-656fb187afb3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 21:30:39.788+03
965	1bba3fda-7300-49f8-aa74-fecfe33e894e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 21:30:39.791+03
995	35b8f63f-9471-4c9a-9cda-4256074c51db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 19:08:55.181+03
1037	c6e2b1f1-b315-4e0d-b493-c49fd2e07c19	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:05:19.812+03
1038	450bfca6-38de-4381-8409-effb365b98e4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:05:19.841+03
1067	227cb93e-15e0-45b0-bd3a-bf24358e595f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:21:06.167+03
1111	485107e9-a8c6-4c8a-8eb0-23a5ab18ddf3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:50:10.816+03
1112	ba6d86dd-6206-4e2d-b7b6-64062499cd82	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:50:10.836+03
1153	a01043b1-5550-4303-a842-9388e6808b2e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:18.359+03
1155	d9c20e11-9b68-4a4b-bc45-ca206d5a5c80	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:22.056+03
1156	ff22f88b-1e12-4282-bebb-b59a76f7752b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:22.063+03
1157	bc3713cf-4b5e-446d-90da-ee9bb3e313dc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:25.342+03
1158	8d7aa4eb-0ed0-474f-8e93-bac7fb6fac36	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:25.346+03
1159	b67ab91e-b453-4fdd-94a5-fdc5b7ddcd19	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:31.464+03
1160	8986dfbb-052e-4fb0-aa43-17ab37b52e5c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:31.468+03
1187	2f52a1ad-ac54-40ae-9b5f-412baababe5e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:38:54.887+03
1188	bc5179e0-2921-4048-b2d6-f71b19f70e32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:38:54.921+03
1252	22cf17e9-ef0e-488a-ab67-e77b92f584e9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:56:00.471+03
1293	8073ef84-2067-4205-ad7c-afb512e7f8bc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 06:32:10.069+03
1294	9088de03-e976-4f9d-b07e-656b805f8127	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 06:32:10.097+03
1295	c2c9ddd6-1d94-4982-9857-cef5d1df00d1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 06:32:12.448+03
1333	66abbc3b-fde9-4556-9042-fe3578500c68	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:03:29.589+03
1334	b127494b-d133-4fd6-ad77-03cc2b06ce2b	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/login	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:03:29.599+03
854	d3fe89c1-ff2e-4961-b8d7-1991fa0e5e20	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 16:07:08.399+03
892	903c2dfb-28fd-4ec8-a8a1-f73e84a4a4c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:52:08.226+03
893	0e87f5e6-e5d1-445b-af16-f555b8bc971b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:52:08.236+03
934	b8ed76b0-4a54-43ec-ad8f-5c20e5badeeb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:32.737+03
935	05af4577-77d7-4c76-8b29-5247f79df2a9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:19:32.758+03
966	d88bcb62-c25c-4f90-ba91-344df21d028d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 21:33:24.728+03
967	da0aab30-3fd4-4ac4-8800-e52ca988346d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 21:33:24.733+03
996	f2cf65b9-9649-4ce3-8513-1a51fc3e933f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:01:51.119+03
1039	a8c4aea0-1c9f-49b0-8caf-905c805f33c2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:08:51.334+03
1068	c5ee0d50-2564-40b0-bbba-cd27d10f48a4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:21:06.171+03
1113	7a846497-b99a-40cb-9d5d-9e17889b1994	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:50:21.477+03
1114	c0eed185-0b54-4634-afc8-6a5de6738bc0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:50:21.49+03
1154	dd156fd9-4533-4a08-9add-5e8c68924df1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:18.361+03
1189	3124bbb8-f413-462b-a437-9667fb7d3fe3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:42:42.6+03
1190	08044fcc-218d-443c-aa08-1f36d05fac71	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:42:42.615+03
1253	fdca89c0-a383-4af2-bfab-d92e6968e979	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 19:56:00.473+03
1296	921abdbd-d7f1-44b4-bbc9-1b63d16e5149	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 06:32:12.45+03
1335	eff465ac-fa3d-44e8-b1e7-129a2d45c8db	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:18:49.498+03
1336	6485074f-e404-4920-8bd6-c505b6ad3c25	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:18:49.506+03
1373	8e0b46c2-c0c4-4474-a21d-43cf6793e73b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:43:33.509+03
1402	9c81ce10-a7f5-4442-9e1c-801f2f985598	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:46:45.451+03
1421	59e516cc-1995-4807-8fbe-ca7a3b02b3e7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:22:54.882+03
1422	fe2d6ce5-54d7-45ba-8714-b12c52a87820	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:22:54.892+03
1431	129b37fb-4eaf-46fe-b500-915fe3bd611c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:39:19.546+03
1432	27e639aa-a033-4c36-bc78-9eb90d186ad2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:39:19.552+03
1440	368e6f18-6015-445b-8d8d-79e0cf5012e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:35:54.469+03
1451	d38469d6-0fcf-4226-9fcf-2cd2ed512aea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:00:30.206+03
1456	d166f17c-9284-40ff-851e-7cc6b21881cf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:07:49.72+03
1467	35d9d45b-08ff-444b-a85a-97a91af45c1a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:18:17.626+03
855	3d15bae2-83a8-41f9-a9ec-7523d99d1a04	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 16:07:08.401+03
894	49fdf47c-4cbe-47d4-b729-d9b145e6f3a3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:52:10.652+03
895	a3f04996-20af-4281-a6d2-6067cadea904	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:52:10.663+03
936	d2501942-f60c-4a5a-b712-00bea280157a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:38:59.959+03
937	ae2a5fab-ab5f-4231-8a37-76b269ac5b92	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:38:59.988+03
968	6b047ab0-5ed8-4ef5-b446-b91c30fd8a04	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 21:41:32.747+03
969	2eb118c2-e69c-4c0e-b716-65345f505777	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 21:41:32.751+03
997	cb72eef4-2a80-4d97-9bcc-70ba65f62467	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:01:51.123+03
1040	a29d46b2-2444-43c4-99be-86ddee75c9a0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:08:51.336+03
1069	aa2c3ec9-bfff-4c44-a7c6-8ce99a93cb29	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:21:30.606+03
1070	ca7504ca-9317-4bba-9b55-71e93509aff1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:21:30.612+03
1115	ff6c0a56-f11d-4233-a109-495ffce19487	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:50:39.987+03
1116	cd9ffa16-d776-458a-a67f-47f4a65b050d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:50:40.006+03
1161	3ae2cb62-3586-4ade-939b-ee1545f82393	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:36.306+03
1162	7811cf9d-bd6a-4cb8-a019-d900d2e131eb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:27:36.311+03
1191	40b05e76-e7f1-4e57-9867-326da3d649d9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:57:50.001+03
1254	8d9138c2-5cb1-41c2-8b45-c82a2c3b6774	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:00:56.842+03
1255	6b91bc61-b813-47f2-bd08-3e6ae2e5b370	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:00:56.846+03
1297	6067b6d9-d56e-437d-bdec-f4476f23bb33	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:13:48.252+03
1298	cc021066-e25c-4624-a22f-487fe245dc37	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:13:48.259+03
1299	b1f8da0e-b80e-4e86-b854-703229c7c132	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:14:00.092+03
1300	b18d1558-20a8-4176-b5b5-38b35a53640a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:14:00.124+03
1337	5baddc14-56c1-4788-8086-b1ae7471bac6	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:18:58.864+03
1338	e30efb2a-f1d5-4022-a134-579b3fbd640a	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:18:58.886+03
1374	2351d8d7-03b3-4252-8f58-fe7803199cc6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:45:01.72+03
1403	11c0f1fd-39e3-4f37-9878-04134e050c0d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:47:16.137+03
1404	2e209a8e-7685-48b1-814d-bdd9d5192178	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 21:47:16.152+03
1423	af887be8-59ed-4ec5-b989-653cb02a28c3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:06.438+03
1424	6988ea6f-84fe-475a-b3e1-41dd826f8d2f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:06.442+03
856	23819b69-2df8-4df7-8c38-0216f9274aaa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:05:39.368+03
857	88dc6f3b-e276-449e-9a48-f3fcd1fdbf4b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:05:39.381+03
896	79936746-44b2-405c-b81a-cf0c050d313b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:52:49.025+03
897	c697ee09-d8f8-4604-8c4c-5d44d605c96b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:52:49.048+03
938	4fa456d7-aa64-4ff5-9791-0ba1e2d0339f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:52:59.11+03
939	cd0156d9-814b-4cc4-bfef-2e252bbc7a4a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:52:59.121+03
970	612519bb-ad94-4b19-81fd-a87cda350820	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:03:02.16+03
973	8b2e1e56-0ed8-4ba2-a846-0ebab2d1c91e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:03:12.277+03
998	c12c346d-78d9-49c8-afb2-3eeb62cd21ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:03:18.136+03
999	c70b2b98-d057-4346-9f71-0502842646bf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/2	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:03:18.141+03
1041	33c68978-2064-45b4-97ae-0758906104f4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:10:15.984+03
1071	a9f4f66d-1d50-4bb1-aa45-37af0022caf5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:22:09.766+03
1072	5b934949-0951-4d20-8697-e6fcf263edaa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:22:09.771+03
1117	0dff80b8-89a9-411e-90c3-2b806a110d1a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:51:25.708+03
1118	7aff67cb-7eb4-4703-8bf9-c63687db8274	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:51:25.723+03
1163	bb19aba1-1b80-46eb-99b1-090616bbcf34	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:28:19.16+03
1164	cf0f6bff-adac-4cf2-88c4-e8596cb4293d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:28:19.163+03
1165	1711870b-14cf-417e-b328-06035e008553	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:28:23.414+03
1166	29e275bf-644f-454b-9194-6e77f8f14d4e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:28:23.418+03
1192	fbb48c04-f084-4fe2-a9dc-4efe73d15037	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:58:26.109+03
1193	c08e150e-7bdf-4c99-97be-8f958e890611	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:58:26.17+03
1256	048b3f12-ca47-48a0-a4e6-30a0b03a40ee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:04:58.253+03
1257	de1e6de6-671e-4f5c-94f6-922834a4f109	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:04:58.258+03
1301	39a8a35d-cac8-4a91-9785-c20fb21124de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:14:10.337+03
1302	1655ee09-0c36-4607-96c6-b354225730fd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:14:10.352+03
1339	4d0b03e1-c18f-4f7e-9222-afe06355f258	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:19:15.975+03
1340	0e345946-b56f-4d8f-8959-31e89836ebbe	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:19:16.045+03
1375	ac9e686f-f4b9-483d-94fc-387abe0185c4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:45:01.724+03
1405	e809bd9d-e227-4745-96e9-1bfce51b2253	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 22:06:32.115+03
858	5cb54b98-64ff-4d3c-9be1-af9f379f648c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:06:36.414+03
859	15a6b2d5-781c-41fa-ba50-9cc1746ad53b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:06:36.439+03
898	4ade1993-b8a5-4210-880a-6d1ae45d9ba1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:53:52.982+03
899	556d971c-2170-4af6-823d-eedf256204ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:53:52.994+03
940	7d1ab4fc-edfc-4de4-be6b-d77b81c1c02f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:58:45.139+03
941	a5a0515d-c373-430d-91cc-6f56529bdbeb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:58:45.166+03
971	4b7c3a71-52f4-4099-8792-826b5a399e8e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:03:02.164+03
972	d589b6cb-66bf-4ec8-9cf1-6e1ceb94e090	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:03:12.275+03
1000	77852c81-22d6-4e53-878f-c78adaa682d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:04:08.633+03
1001	87c26bce-5025-4b8f-819d-f48dc6f72224	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:04:08.636+03
1042	ba9d5074-f293-499a-b74d-42b8e26389c1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:10:15.989+03
1073	bb93ad4d-df1e-433f-b439-06e451130b70	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:22:15.666+03
1074	a2f182bd-d2dc-42ea-8ada-9a7b20e0c06b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:22:15.67+03
1119	022d9b78-8f47-4a2c-94c4-f428937e1940	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:00:33.253+03
1120	6f966d42-73d3-4ed0-9e8f-a5574a1bd4f7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:00:33.287+03
1167	793bf8ff-04a4-4389-9039-24d3b49a193a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:37:45.88+03
1194	0dcc1f25-8d73-40cd-ae95-5ca2f06c39ea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:58:49.653+03
1195	cd46fbc5-e2aa-4b1d-9cb6-61874c363dbd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 09:58:49.669+03
1258	6276d0a8-72f4-478e-8a31-7ba7f85de38d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:04:59.28+03
1259	7f1a23c0-ef78-46ed-8f55-fcc013def9fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:04:59.288+03
1260	67a74a45-9744-45e9-8888-a51a2824f561	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:04:59.32+03
1261	08f142a3-3eb8-4b2e-afa8-9056d1e0d460	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:04:59.332+03
1262	2a6f4bc1-f357-46b0-9da9-60623c04250e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:05:03.257+03
1303	5590f296-1269-48f0-9865-b05c3c480aba	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:15:07.442+03
1304	71b8a31c-b8a4-4647-b2a2-8c7225578010	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:15:07.459+03
1341	618824b3-b6bd-4bdd-bb8c-6e3c6b3436b9	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:23:01.68+03
1342	f4fdcc41-bb38-46ad-af3c-f8355b5704cc	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:23:01.692+03
1376	1be5251d-8793-4d05-9562-c58de049fd1e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:45:33.292+03
1377	e96b1964-8e2e-4e57-9989-0b5215097dc8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:45:33.296+03
860	b21e82b7-6aef-4b53-bb92-e72dec0a1b9e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:07:13.076+03
861	84c5d3d8-c80f-4494-97df-796bc36f1110	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 17:07:13.097+03
900	8ad792bc-8749-471e-8d1e-30de0281c599	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:00:01.874+03
901	d1f20f5f-9c5b-4295-8614-c993d26c21e9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 18:00:01.881+03
942	d2ef70a3-15a8-42dc-a072-2fb706218fe2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:05:42.273+03
943	772613f4-9d6d-4846-bed9-c0ebcb760705	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 19:05:42.283+03
974	1e0d54cc-342a-47fc-ad53-8c9fc21e5c66	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 22:04:08.243+03
1002	7d402083-ee83-4c07-a23d-662ffb746654	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:04:41.007+03
1003	1194a7fc-71b6-4fa7-a095-0649e7af9d65	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 20:04:41.01+03
1043	d3dda9a6-3a22-4a13-a818-7d22c61958ea	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-06 21:10:45.119+03
1075	4efe208e-892c-4da5-8ed9-5a31537c291c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:23:07.286+03
1076	2c407c14-a61a-4778-9a59-c84c2447c8de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/biography/3	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 07:23:07.291+03
1121	dc838412-5b0f-448d-8025-7e6e61a32188	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:00:56.964+03
1122	abea4ad7-a4cd-40ee-9ef8-139c66f60ce3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:00:56.976+03
1168	4ea75a9b-38ea-447d-8c51-8f3de4e3a70b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/billboard/1	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 08:37:45.884+03
1196	12a0d086-6430-407f-bf47-82b9849ad87b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 10:08:15.663+03
1197	8e57a57c-6ceb-4b01-b4a6-b4fdbe31e8b7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-07 10:08:15.677+03
1263	16b34879-d87d-4c23-b9a1-2ee05552fcaf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:05:34.81+03
1264	3668f873-f885-4475-9aea-c34aa9f3ae0d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:05:34.815+03
1305	ffe439b2-d786-4e3e-9405-d916ed2fd4f1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:43:39.294+03
1306	394ce9ed-8198-41eb-ab59-c2cb41b9fd85	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:43:39.3+03
1343	410f7183-aac3-41cb-8594-5f104a389c20	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:23:08.146+03
1344	58ce593f-65c9-42d6-8cc0-3ccc4ffa7a03	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:23:08.329+03
1378	fbd9371f-fe5b-4b3a-bafb-b9b132aab173	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:48:21.223+03
1379	bf07a6d9-f438-4950-b208-d43a91eb7a7c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 15:48:21.236+03
1406	87176d39-737b-4736-a54c-3bbd9f21c45c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 22:06:32.139+03
1425	68aa1cfd-48dc-4288-a1ab-73bfbd97405a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:08.532+03
1433	f61e77a9-c977-47b2-9f03-8a85006a7743	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:50:39.312+03
1441	29a275a8-2f24-4ec1-94aa-686fbe641edb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:33.124+03
825	ce77e4d6-3d82-43dd-a6d1-ccc8675ce343	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-05 13:36:06.898+03
1265	6fa8e0f3-7f9f-4786-a7c1-1fd44a1a2a29	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-08 20:08:54.142+03
1307	38938b0b-c7bd-401e-896a-9238fbb0ada0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 07:44:19.862+03
1345	5507e75b-0622-47b5-89b6-0b50666c72ef	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/newsupdates/7	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:24:31.228+03
1346	103f25cb-76fe-425f-bafc-4f8dea74246f	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	http://10.18.1.127:3001/newsupdates/7	/api/websiteVisit/postVisit	\N	desktop	Chrome	Windows	0x0	unknown	unknown	en-GB	false	2025-07-09 13:24:31.249+03
1380	2f6fefdc-bdf6-4bac-b144-3fb640916ebf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:24:16.817+03
1381	9f9f76ec-4342-4784-be88-f307a2305271	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 16:24:16.935+03
1407	a4869fe1-fddb-497f-9802-54011503b97e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-09 22:08:35.472+03
1426	15e9e0d1-a748-4589-a21e-8a19511a931b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:25:08.535+03
1434	d4f06488-9a1d-4642-bb43-42d628001708	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 12:50:39.315+03
1442	887a928a-8a53-4e9c-bafa-4c2fdc456dae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 13:44:33.131+03
1452	c36e4a74-be32-40cd-a9a2-ca1e48cb1f28	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:00:30.21+03
1457	8a5811e1-38f6-4c6d-a0db-8eaa435276fa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:08:19.317+03
1458	bc0f1eed-5da8-4e08-b1b0-442e5bc112f5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:08:19.322+03
1468	ee2b831e-4812-41b0-b075-ee5d339425d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:18:17.633+03
1471	3d7a8e6f-8ec7-42c8-bebf-f42173e3a429	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:07.131+03
1472	b1db4eca-f157-4e02-9111-139315792482	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:07.135+03
1473	c23c7bdc-604b-4ad3-8afb-d9923a7a1e94	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:11.836+03
1474	458581a7-b67b-4845-b2ce-a5f5bd5e85ab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:11.841+03
1477	7c313ee8-732a-46b3-bce3-f01a12f7d8c1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:41.015+03
1478	c7f8473e-42e6-4f76-8320-0b2fb5f00512	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:19:41.018+03
1481	021228c9-09af-4d24-884c-c17ff02a5fa2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:20:06.495+03
1482	e104ca52-a266-48bb-989a-4b1a37c79c37	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:20:06.498+03
1485	b28a527c-c9ff-46fa-8c86-275845595a55	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:22:22.309+03
1486	8a030257-84f6-4d2c-9300-4daf6f8661a3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:22:22.313+03
1487	f29fa358-ccdb-4d32-b894-0116e2ceeff2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:23:22.808+03
1488	85348401-3e6e-44e2-9bd2-db69dd9105d0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:23:22.812+03
1489	b0949c99-9cd2-4450-9899-14da55ddf611	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:24:03.132+03
1490	2f725f12-e0c6-40e8-ac31-7621dd748166	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:24:03.137+03
1491	e119e552-c422-4d96-9d92-5d38d716c227	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:32:49.099+03
1492	126b9ebe-ad7e-4341-8d7f-d7139a4249ab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:32:49.13+03
1493	54bca9d0-708f-400b-ab56-af563635f7f2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:42:07.466+03
1494	5114f17b-ee0a-4c7a-8e0a-a8dee5042cef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:42:07.498+03
1495	b7ddfe87-0a94-4d7d-b83c-bd851b8d3872	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:50:02.157+03
1496	49465e4a-d1d1-4764-9b4c-76efe85e5825	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:50:02.193+03
1497	50410730-456b-40d9-a102-3d10e6839586	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:52:52.566+03
1498	c8d9ab20-c20d-46ff-8ddd-4adcac1b7762	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:52:52.595+03
1499	a9c6742a-34ff-4e9a-aeb6-2cc1667265cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:54:09.643+03
1500	3b61451a-417c-4ef8-9433-db988cb9a905	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:54:09.664+03
1501	bbd7f714-3be3-4dda-8525-5f311f6a2d99	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:55:21.665+03
1502	073c209a-9077-42bd-b674-430b5198dcf0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 14:55:21.671+03
1503	16e67c5d-6940-4cff-93a6-4212935e848b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:04:23.963+03
1504	b593f486-c473-4075-a8a8-ce3a6eed8977	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/announcements	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:04:23.968+03
1505	0ca7777c-fb7c-4a5a-9128-e2a2e7f711db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:12:03.238+03
1506	689dbbcb-7285-48b7-b6d7-015ee02de013	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:12:03.242+03
1507	9e52fafd-0d4e-4a37-a913-8f5c58f20485	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:48:13.42+03
1508	a0b8fe0f-2deb-483f-a910-b5c7e66068f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:48:13.44+03
1509	8d2fb4ae-24de-4a84-825b-d104809d9861	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:48:19.575+03
1510	e9b3a604-cb09-4bb3-a7dd-dc471ee1bdc8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:48:19.579+03
1511	4f33e2bc-90ed-41d8-ac99-49c0fe895a7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:48:20.957+03
1512	2b99fcb9-99d6-40ad-9014-098323ccc594	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-10 15:48:20.983+03
1513	a6e521f7-570b-4fdb-b8c6-ab14084e5728	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:38:50.059+03
1514	a8266393-0f08-4328-90dd-e1f3feb96557	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:38:50.062+03
1515	f476311a-2cfe-42af-87a6-e0ea06930b25	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:38:58.827+03
1516	512fa7ce-edfb-4fba-a589-5fd576109f87	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:38:58.845+03
1517	397d5558-fb31-44d8-b8b3-50f37c2b79b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:47:57.572+03
1518	6771f505-b5f3-4b94-b897-c52490be0d9a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:47:57.593+03
1519	45f471e5-b299-4a63-b652-adab383133ee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:48:27.501+03
1520	7815b9c8-9dd1-4c54-acbf-a6b906d1025b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 02:48:27.522+03
1521	0858e47c-8929-4313-998d-2461b92dcc63	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:02:39.391+03
1522	51c798b9-dc02-425c-847f-6b8c528fe1dc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:02:39.41+03
1523	0b8203a7-7585-4b85-8744-aeb0648dd79c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:02:50.772+03
1524	9ba27795-6cbc-4958-9d52-f9e840706ef8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:02:50.776+03
1525	5ec66077-3e4c-45bc-8e8e-d3b84cb9b98c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:04:02.844+03
1526	4e660318-ed8f-4be1-8f14-51f4e7c55e09	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:04:02.859+03
1527	ca49fd7c-f005-4c5c-8a8c-9bc820e8c6ad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:04:52.67+03
1528	0b387cb6-e8d5-4b8a-8f3d-a89d6d16af8d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:04:52.672+03
1529	99529170-f656-4689-a931-47d180a0dee7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:06:00.803+03
1530	921ba51b-cd54-48cf-b60a-15b5683dec8f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:06:00.805+03
1531	95151e57-4fbd-4346-be9e-daa4a410cb5c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:07:30.312+03
1532	d4b2d1f5-806b-4179-a84b-ecd259dd3336	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:07:30.334+03
1533	61ae30e6-6527-43f6-9ff7-1886d98e4357	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:07:39.148+03
1534	7c3b49ce-63f9-418c-a455-1e5e59a69a75	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:07:39.15+03
1535	4d35c55c-8af0-496b-b056-caaa02ad43a2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/%3Canonymous%20code%3E	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:07:57.18+03
1536	6b483408-fcb7-464e-bbd1-2824e1167b1c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/%3Canonymous%20code%3E	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:07:57.183+03
1537	5ea1bafe-4265-4090-a86d-746b7de12cc7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:09:34.443+03
1538	0b1085d8-7d50-45de-af23-ef2507a75150	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:09:34.459+03
1539	1cc55fb0-99c2-43ec-b3a5-c9c17514b043	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:10:16.797+03
1540	6d4a2ac3-2f29-4480-b682-ef115464a376	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:10:16.8+03
1541	ea1b6b9a-3de1-4fc3-868c-46f768726386	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:21:11.087+03
1542	697bd5d9-cada-415f-9a9d-2dfa6af9c2d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:21:11.105+03
1543	7f40989f-f701-4163-8c7f-2580712d4d5f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:22:01.513+03
1544	9dc32382-da9d-4968-aaab-df7bf7c789ec	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:22:01.547+03
1545	88c30265-0684-41e1-9e0f-fbe0708d5659	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:22:52.175+03
1546	97ac05c7-c8b7-4e52-93d1-57a4961fd93c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:22:52.195+03
1547	ef9e3905-8882-45a0-9637-c39c3a77af53	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:33:51.818+03
1548	121c25b1-e1d1-4132-86ae-635c4fadca42	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/managementLeaders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:33:51.83+03
1549	5fe2acb5-9f32-41c9-9127-27852934ce55	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:42:04.305+03
1550	8c20906b-0f74-4256-8916-19366ff8b3a0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:42:04.311+03
1551	efdd6fc8-595b-4343-bb0b-e617c04d2aee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:42:10+03
1552	a7d70567-4c1f-43f5-93d3-0c7a3e82c746	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:42:10.004+03
1553	761180d7-ed31-4e40-910c-cff37d59cb5a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:42:17.38+03
1554	19cf63fd-cf81-4b27-a4bb-4fa84ac10797	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:42:17.384+03
1555	9cf54fbb-3d56-41fa-a06e-a6915f1dc6df	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:52:04.911+03
1556	0e0e2631-0b69-4f2a-a21c-12c8f1c27402	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:52:04.917+03
1557	52620ff6-d63d-4411-9092-466ccba1c114	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:57:14.212+03
1558	8053c8a9-5801-4ec0-9e64-799de5f4b1d8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 03:57:14.218+03
1559	772f461c-37da-408c-9352-4e5c3db27657	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:04:32.447+03
1560	3714df1b-91f6-4f1a-9ee8-0c2ff521e48e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:04:32.454+03
1561	0952ccc1-5c7c-4f34-a6c6-ac7d24425e94	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:04:41.839+03
1562	7ba2e0c5-51af-49c4-9421-33bb0d653431	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:04:41.861+03
1563	3ead1d69-fcc0-48af-a41f-f8829171e7d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:05:53.677+03
1564	bffb3c25-231e-4699-a6e2-f4594f036468	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/users	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:05:53.683+03
1565	fe060205-7fd3-491d-bad8-5552e68513ae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:07:52.158+03
1566	b68dc8aa-d440-43fd-81b4-c7853fe5caee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:07:52.161+03
1567	f82a28b8-2748-4d5a-a718-e19b23e4c9c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:09:38.993+03
1568	2f0438c8-d688-41a4-ad21-5af2c8ca99b6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:09:39.011+03
1569	9f905745-03c3-44a8-8efd-1ba15fbe2e72	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:32:05.107+03
1570	b6338d18-aac0-4167-8a2a-15a6918387c3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:32:05.109+03
1571	59a9426a-9416-45da-8be2-90242a844039	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:34:32.219+03
1572	ef8f3a47-f2bb-4c16-a43b-97c8009d05a7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 04:34:32.223+03
1573	d70fcb7d-3d78-49c3-bc8b-67d8b0e97c1c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 09:33:18.72+03
1574	59627d52-326f-4e79-aa75-e02d156bbccb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 09:33:18.722+03
1575	615b8f92-ba23-436d-8eca-aaeec080dff1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 10:31:43.804+03
1576	407497ed-9679-4e3e-b551-f6323083a769	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 10:31:43.811+03
1577	5ba51224-1c69-4bc9-b13d-1f1cd9d0eb8c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 10:34:12.213+03
1578	f8cca397-ffb9-4f66-87d2-5e5d7b5c1f9a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 10:34:12.221+03
1579	03fb1599-5f09-4168-9d2a-15379eb4bb3b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 10:37:05.523+03
1580	d3a81ef2-583d-455c-8cd4-1484a9e38adb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 10:37:05.53+03
1582	6a5f98ae-3749-4c46-8645-092e6c3480e7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:02:38.211+03
1581	eb633729-6a94-4fcd-bb2f-05e1421a0349	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:02:38.214+03
1583	9b515f35-65fd-419a-9c2e-0d87bf38a12c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:31:09.52+03
1584	4ecd71be-1e2e-4f5d-96a5-8acae72ebee1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:31:09.538+03
1585	3f73cbfb-19c9-459d-8a05-d13d7f87c11d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:49:20.694+03
1586	a180b0c1-a3fd-40af-811e-0c0e5707cedc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:49:20.698+03
1587	3e3a90b6-c40b-4722-ae12-fdf5743418c0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:49:26.487+03
1588	0f54a031-ef30-45fd-9300-be3dd14cbd37	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 11:49:26.492+03
1589	803fcd38-6b5c-4161-a3c7-4f569b42f41f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:04:08.138+03
1590	238b7c98-88d2-409e-b496-360583d7e133	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:04:08.142+03
1591	adaecf31-076e-4ad2-962d-fd50a1ea052e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:05:23.184+03
1592	db13c88b-db5f-4b83-a25c-a2bb9be9f39e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:05:23.188+03
1593	b038090d-e0ad-4a77-8c17-1d57cbf0cca8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:24:34.841+03
1594	923f7a49-ab54-40e6-9026-37d46210c07e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:24:34.87+03
1595	c60f3f68-bc4f-4472-850f-5df9521cdee6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:25:30.693+03
1596	923ea236-10fc-496c-aaeb-a0a42cf3af95	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:25:30.696+03
1597	7f27013e-81ce-461b-a3b0-ffbfcf26bff4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:26:34.797+03
1598	389db645-e444-4f0b-93d4-412107c06672	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:26:34.798+03
1599	b3d17664-3ab4-4752-a0dc-f2a81ae1f00b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:31:36.652+03
1600	9bd2863a-ea21-43b9-9282-37a28bf50a1e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 12:31:36.682+03
1601	3653abbd-833b-4942-bf47-1d73ecd199f1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 13:26:53.223+03
1602	625c45af-bee1-4be7-b4e6-3ce0f1b84f70	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 13:26:53.259+03
1603	ceb0ca4d-1fc9-423c-a70e-713ec394ef35	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 14:39:19.04+03
1604	caed67f6-c872-4b6d-8d2d-a3fc45be2a03	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 14:39:19.046+03
1605	80d3dfa4-57fb-4222-b403-aaa15423b8fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 14:39:20.532+03
1606	d6e6a928-4a44-458d-b316-b3d3ecfb5f2c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 14:39:20.564+03
1607	2ebe8d8a-8e9c-44fe-a38b-e3c727efc2e6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 18:45:24.049+03
1608	0f28aae2-613e-45dd-9071-10df774496fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 18:45:24.092+03
1609	d49a2745-d34d-44b6-a1dc-6031825baf8c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 20:03:51.068+03
1610	8b9af962-9dae-4df9-8f1a-49c3584f4713	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-11 20:03:51.108+03
1611	8cb59e20-7b5f-43a0-a480-3c45931dd156	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:33:27.492+03
1612	9b4c605a-251d-486c-afcb-2592ce773412	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:33:27.513+03
1613	56ada10c-7fe4-443a-9e9a-64257b85e096	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:33:33.788+03
1614	88547f56-3315-4515-b814-5d1a0410af93	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:33:33.804+03
1615	829dabe7-596c-4111-a068-dff629c0efdf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:33:42.072+03
1616	800c78e7-e151-47a9-a391-26b522472c1b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:33:42.08+03
1617	7e09e98f-a68c-4266-8bb4-a604224647a9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:44:26.838+03
1618	8ea84916-1415-4c45-b313-79295e8ecb19	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:44:26.864+03
1619	7d6d5ed2-8a11-42d5-92be-34d3c658b6dd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:49:56.405+03
1620	96c98241-37b2-4c41-a5cd-1eee6bb6b616	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:49:56.439+03
1621	9bb66a43-2d6f-4ae1-ba0f-e317f5ff9ff1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:50:53.487+03
1622	03a4692a-763a-4199-9f3e-de85850e60e2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:50:53.512+03
1623	0277d373-3707-43c0-bbc2-76adeece9b80	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:52:56.165+03
1624	e84122f9-b41f-4d4b-9801-14b7507af8cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:52:56.178+03
1625	9e9bf3a4-2fe1-4784-834f-0610e9fcaeaf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:53:37.787+03
1626	226932fb-c71d-4daf-b86e-aecaff3f6e5e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:53:37.792+03
1627	aca0a5fa-7366-400c-9b69-b9c4c4a11934	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:54:29.66+03
1628	9faf8ac7-4256-4fe4-bdab-3ccbb58ea244	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:54:29.674+03
1629	7e291e00-fd3e-40e3-98f5-f8de637b1cdd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:58:03.533+03
1630	e2414720-c66b-47f7-b13e-69e9d239ada7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 16:58:03.538+03
1631	c8754e87-c0ba-4f25-91fc-ff2022e1a6fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:04:13.85+03
1632	7e93f763-02c7-427f-966d-aba2fd470a74	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:04:13.858+03
1633	fe2266a4-b998-477d-9d62-ec8289a3075b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:15:14.916+03
1634	4f45210f-48e1-4384-ad83-da3a0a6926c8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:15:14.918+03
1635	1a0cbeba-966a-4869-b44e-f0bac1f39fcb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:15:21.132+03
1636	23695e9c-1444-425b-b6a4-dbb0652de736	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:15:21.136+03
1637	0ed4c79e-1e2a-43b8-a7b5-145fcbcdb663	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:15:55.026+03
1638	9cc17661-a75c-455a-92b6-b5e79c549198	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:15:55.046+03
1639	a443fe04-a9b7-4fd5-95e8-7c15c07b0222	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:17:45.71+03
1640	f5fbd4b7-927c-4941-bbe2-ce5a95e662d3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-12 18:17:45.727+03
1641	667f2889-49f1-4e45-837d-1b301781bdfb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 09:49:56.617+03
1642	191ec47b-d15c-4823-821c-b0d95e10abc0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 09:49:56.615+03
1643	f393f71c-35ec-47fd-bb66-90f10dc12136	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 10:37:57.155+03
1644	bbdc562d-45d1-43d5-b248-bcd68d2cdf62	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 10:37:57.175+03
1645	d1480c22-a539-4cec-8312-38e40a202fad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:03:15.024+03
1646	375d1b3a-68e8-4953-900a-753b2573463b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:03:15.03+03
1647	58abdda9-5ae5-4a19-be09-81cfd4985a7e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:03:15.59+03
1648	b498a046-7e1d-4b4f-af5d-29159c33fe9c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:03:15.596+03
1649	e78831ed-9d42-43cd-af61-0aa47aaced00	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:03:16.31+03
1650	b297d8be-975d-4a20-8fba-67d8bb38e4f8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:03:16.328+03
1651	1b3d2c9e-27ff-49c0-ad9e-be6f607ef95e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:13:26.631+03
1652	f918532c-398b-4182-a9e5-08df154b3534	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:13:26.664+03
1653	ea9d795b-3c3e-46b0-beed-1e2c3ab52861	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:14:34.58+03
1654	1f78ea71-5156-492d-bc52-f228dec74264	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:14:34.598+03
1655	c91f98d2-8cc4-4fd5-9d12-20ba16a95819	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:15:29.695+03
1656	52be8108-f2ff-42b2-a1d6-67677dee922b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:15:29.713+03
1657	905a5972-a3eb-4584-9069-ae99b17eea68	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:16:08.507+03
1658	563c98eb-1647-441d-ad7c-c08e966a9621	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:16:08.525+03
1659	6c8f9d80-b9a9-4ece-85af-785812fe2397	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:16:23.708+03
1660	e4627ead-1ca8-499e-a206-c23c1f409c57	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:16:23.725+03
1661	5f9524ef-512c-44b1-943a-f3a7f6f74760	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:16:45.256+03
1662	e912354d-f06d-44e2-be91-f614b685e34a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:16:45.277+03
1663	0c6eb483-03fb-4858-b2a0-f6925c20122f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:17:32.37+03
1664	487f2fca-5d6c-4cec-a800-59cb101f1e1e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:17:32.377+03
1665	ce3bee80-a925-4f04-b758-92868130b91f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:24:17.866+03
1666	4b0e64fb-fc5d-4e31-b7e1-e9ea56bde17e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:24:17.873+03
1667	5ad4f8fa-a8f1-4fa7-afbc-b5fc19649c00	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:24:31.181+03
1668	7b7acad8-435c-4200-8a3a-fd7cbe03b24f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:24:31.197+03
1669	43793be2-cb35-402a-8185-003e02b7a42f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:24:54.295+03
1670	fdca95e1-b8b4-45b3-a429-b4b171a9edcf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:24:54.321+03
1671	b25a8e90-5758-4fdb-a14f-0686cc00e673	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:39:19.566+03
1672	cbc34982-c84f-45d5-b38c-fdd4c36e338a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:39:19.582+03
1673	bf06c287-46ce-45c0-860c-f3a76ef41a38	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:41:19.537+03
1674	68d98e97-8e38-46c0-9959-8b7afc4c13ae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 11:41:19.569+03
1675	293e3f20-3c00-481b-9c5f-3693e82f4a87	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:07:37.945+03
1676	212e9879-7f28-40d4-9746-ef97d1b7f595	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:07:37.95+03
1677	9d465d41-5fe6-41ec-8045-e010e47e6d3f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:07:38.845+03
1678	fe17e372-1cba-4bdc-964b-a31eeedbb499	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:07:38.935+03
1679	785f2b5f-3a23-410b-9a3d-966a3b77b2af	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:15.861+03
1680	b64e453e-43bc-4944-8761-331035598feb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:15.953+03
1681	e83a09fe-e40f-426d-9d39-c51f40d9d7d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:16.405+03
1682	cf1c450b-083b-41ae-b86c-ab68ba4eec83	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:16.422+03
1683	283b3485-291e-42d1-ab6c-8974e5b84c6d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:23.356+03
1684	26df66b9-e6f8-4dfd-a206-457eb1f16c10	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:23.368+03
1685	b385d595-cc24-4680-9fa9-589f3c66fe45	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:33.29+03
1686	0b01df18-a8b7-47fa-b6ba-c0915af9e3e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:33.294+03
1687	e48087e2-64f4-49a1-b68e-72d6ce8e393b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:34.151+03
1688	efd5bfbe-df2d-4ca9-8866-c1eedb9e8f21	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:34.176+03
1689	189b6a2c-65b7-4fce-be94-6169acf8c655	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:44.468+03
1690	2bb53b6d-d1fa-4498-bccf-c5d3904c3dd5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:44.472+03
1691	9df2a37f-d42b-4bc8-8da7-97b7b6d27718	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:45.807+03
1692	23748dde-17c8-4277-a087-4a0d9b05bf08	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:45.83+03
1693	774afd9c-496f-42e3-b05f-45762f62d143	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:48.164+03
1694	f246d05f-f34b-48fe-a090-8f0847fb656b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:48.167+03
1695	6befd418-119c-43f5-885e-47749e0e80e5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:54.98+03
1696	8e6e4c10-0425-4717-bfa4-d32c0323a03c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:08:54.997+03
1697	9a4f27f4-fada-478b-ba16-3c444f738f35	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:11:35.684+03
1698	19d721c9-b19f-4101-bdd9-94af94b96377	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/judiciarygallery	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:11:35.686+03
1699	fe59319b-0be1-4034-9c8b-aecc6a4ca0d8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:11:36.371+03
1700	5d35e1b8-b8f8-4343-a12c-5b0bd953805e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:11:36.387+03
1701	7107f773-697a-44a0-872f-1f3bc0860acf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:36:24.634+03
1702	8ee6e62a-abb9-4c90-875b-280670118a97	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 12:36:24.65+03
1703	02ec76a1-f2e1-403c-991a-cb60512b2bdc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 13:32:25.143+03
1704	2256ccb6-4226-4569-bdbd-e8c93e0b9239	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 13:32:25.63+03
1705	96e09702-8911-4d80-b0cb-d39f008ee086	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 13:47:05.422+03
1706	ef029db1-3c37-4dab-a80a-103e90de537e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-13 13:47:05.427+03
1707	2bf3ce92-013b-4221-9f30-a5141604d345	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 19:41:44.465+03
1708	fa3b14ee-4ea3-4401-abfa-21e517cbcc4e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 19:41:44.471+03
1709	afef2cae-c754-4d15-a13e-9511ad640465	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 19:41:47.093+03
1710	8c03712f-7bc6-4566-b263-5dbac4665c6c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 19:41:47.1+03
1711	14e644e0-9ae9-477b-837b-fdc3d1d717ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:39:29.853+03
1712	32864b35-74b7-4a92-98ac-bf98e2e6398e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:40:00.283+03
1713	e684a66a-dfc7-437d-b4f0-b52817153dae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:40:53.788+03
1714	29259506-3848-4717-9b7a-a839a99be048	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:40:53.81+03
1715	91e29e08-213f-4a8f-965e-53540a7df9da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:41:28.275+03
1716	2f3d2025-92f3-41e3-95f6-621718eb4d3f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:41:28.292+03
1717	a2b1b633-c68e-485c-bf60-31682ca2decc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:41:59.943+03
1718	6e09f0f0-058a-4a71-a61e-c32bb30061c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:41:59.954+03
1719	a185e797-413b-4152-9843-5a69384969da	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:42:42.333+03
1720	6d924691-9c3e-47a3-bd86-fe9d3481be01	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:42:42.344+03
1721	2f86166a-b7b8-4313-8215-438d34c3c61b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:43:10.626+03
1722	0f9b362c-a1db-4966-9d4d-c4f9d535696f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:43:10.641+03
1723	3c358d65-14f4-406f-8aab-579135a8ab04	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:43:11.887+03
1724	aaa5e76c-048a-470c-8c7d-4aa29f51f94b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:43:11.91+03
1725	88319eef-38b2-4878-863a-9deb8b096ed3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:43:22.171+03
1726	50627d82-b530-4635-a7bf-8865d83d85a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:43:22.182+03
1727	f5f58fb4-266d-43a9-876c-b4da4816349f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:49:59.593+03
1728	185e5e75-58e5-4678-9bc1-ea3a3d44b11a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:49:59.605+03
1729	02d16311-6000-4227-8f9b-421214bdda98	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:50:01.66+03
1730	8ccf3cde-eb46-4603-943b-ce53fb2f1940	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 20:50:01.666+03
1731	50450983-2da6-42e2-978a-e259aefa6b72	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:11:48.68+03
1732	4d5cb8cb-0dd4-49a1-8022-a961d40f10b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:11:48.683+03
1733	bb59b1c5-f3f4-45ef-b85e-624087d28d11	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:34:59.353+03
1734	139d91ad-a0da-4e39-aa3b-ac02f2282209	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:34:59.352+03
1735	42e063c1-1258-4b6b-8268-3047ee2bf56e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:34:59.369+03
1736	ed23d725-a403-49a4-a818-dee56e50f6a8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:34:59.37+03
1737	564ff6e5-22be-44db-acc0-c4988b99ed98	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:35:05.466+03
1738	ec578c4e-3e38-44ac-8f7c-0fdb3be11096	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:35:05.469+03
1739	82043a83-2d53-407e-a945-42ec5507341d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:35:05.493+03
1740	1224c1a3-feb5-4e66-85dc-c56b8689a278	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:35:05.494+03
1741	c5f3bff6-6aec-45e9-9962-0745e7ada905	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:36:05.87+03
1742	f2d1455f-ae32-45d3-88c7-7a6083688f46	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:36:05.872+03
1743	b8ad3af1-0170-4a04-a497-20b873dd7199	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:36:05.889+03
1744	b4545c42-69cf-4cfc-9c76-d9733e2c7e0b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:36:05.89+03
1745	314a02e1-c501-481d-be27-7f80bd598abc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:53:55.943+03
1746	90c2b08c-634e-44fa-98d4-0a5b7441c879	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:53:55.946+03
1747	47d6c670-9bcd-4c16-84f7-7759673712b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:54:34.858+03
1748	2520ecfa-a107-4336-b5fe-05e9d80076ab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-14 21:54:34.862+03
1749	3e2f479b-451e-4029-8916-e83f850c5101	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 09:40:25.057+03
1750	f971a853-875d-43a6-98ef-f1e7af6ab087	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 09:40:25.077+03
1751	408cbd06-eece-4aca-950d-7fbd2df2dcf6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:14:16.49+03
1752	f3c2e9c8-cba1-4db2-8943-fc021f1ffd0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:14:16.493+03
1753	17951d8b-d3a5-48a7-9b5d-18da90de975c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:38:42.297+03
1754	657a1386-50d8-4719-8287-3f6dcc6c0ba0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:38:42.298+03
1755	e4526dff-b408-4ef9-a4c4-8f299d6ba94c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:12.76+03
1756	3223b519-b186-4ca6-a09e-f9278afd1050	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:13.636+03
1757	9d852efc-8ea5-4e8e-9546-5c0b96819adf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:33.878+03
1758	cc666a47-bbab-4c5e-8d84-456714a25506	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:33.882+03
1759	00266780-aa60-4cc1-8cae-339585b2fadd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:33.884+03
1760	2395c36d-212b-4e9e-abd4-8380d8a11775	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:36.39+03
1761	5bbdb975-fb47-4d80-bfe9-35d59d0a9b6c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:41:36.392+03
1762	174a529d-bab5-478f-9c7a-a3e76a39df98	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:42:08.468+03
1763	8a93e5b4-866f-4f55-b8df-9d54ab657316	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:42:08.471+03
1764	469b6636-18fc-478e-852a-7dfec1e3f0db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:44:05.239+03
1765	8701cd0b-c70a-46bb-abd6-94cdec38e573	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:44:05.242+03
1766	0da8ca90-e6ac-4e3d-ba6e-09c069a36b56	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:44:11.459+03
1767	8db96cdd-fd27-47f1-926e-506b77ebcae5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:44:11.464+03
1768	a688538a-606a-4d06-b557-739e98e7bbdc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:45:53.711+03
1769	731b2c54-0140-4601-854f-7735bed0d95e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:45:53.713+03
1770	8fd5c255-5c38-4d6c-ac64-b0c051934146	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:46:07.601+03
1771	b1c0269c-7945-4c16-87c0-c532982f2c6d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:46:07.608+03
1772	4ed9a8e5-2f2b-4ec1-8982-2b92c8eec3db	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:53:14.854+03
1773	832b6ef5-a618-4638-b38f-961dacbd6cd5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:53:14.856+03
1774	a51ad06c-58f6-437b-b4b6-89a7d638ac28	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:54:02.811+03
1775	29b6945a-0497-4c90-93cb-3d333393436e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:54:02.816+03
1776	bb9fbdc2-c63f-4ee3-b2e7-2404b1e24c32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:57:47.05+03
1777	b5cde7af-18b7-439e-898e-6b53d1c37593	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:57:47.054+03
1778	e4295413-f388-46e5-98f6-22f8cc82e039	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:58:49.901+03
1779	03d74f48-83d6-4993-85dd-c5395588e1d0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:58:49.904+03
1780	26a3ab8b-afb6-498f-a551-9e9cebe30db6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:59:35.713+03
1781	05e41273-813d-4adc-b779-f4d1a3eb86ce	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:59:35.715+03
1782	ccbc5db5-c6bb-48c2-845b-f6ff04634618	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:59:58.921+03
1783	63258b90-8c6e-4684-9e8d-2a8dd129c8be	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 10:59:58.926+03
1784	624bafe0-b3a9-4678-9208-aae0d3070b01	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 11:11:13.164+03
1785	cd9798ba-b955-4476-a5fc-82fb0571a1b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 11:11:13.181+03
1786	349335ac-7f75-417b-95d0-199666e43ad7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:10:44.723+03
1787	c7f96a53-19c8-4847-9d83-d25d3e144d9a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:10:44.726+03
1788	83dff257-cb2f-4bd6-8c76-6836026313a0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:11:49.331+03
1789	2afa4d9b-a016-45a5-b0ff-4d0a819e6a5d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:11:49.335+03
1790	72b03da9-44e5-413d-be4d-1c3444b7a5fd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:12:14.79+03
1791	19ff5b5b-bcb9-4e8e-b921-cadc6909a4d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:12:14.794+03
1792	9559d6db-16eb-4116-84a4-c0b281ef4638	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:12:48.771+03
1793	aaa61cb8-58cf-42e9-9695-7924d07b27f0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:12:48.775+03
1794	070c4c77-1cc0-4cf5-b00e-137c5fba9bd6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:40:46.634+03
1795	04a893ae-9c40-42f8-81d1-fa1ec6f9deb2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 12:40:46.637+03
1796	d2d6e753-3d0e-4cfd-ad17-ede9e8581bf2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 14:39:28.422+03
1797	9d891cf0-cdb9-423b-ad87-d88c2810c789	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 14:39:28.425+03
1798	25dc514f-edd5-480a-b32e-f5e085dfda7e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 14:41:13.257+03
1799	586aeb0f-6067-46e3-bdf2-c0c827b91440	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 14:41:13.282+03
1800	d72cd059-4539-408e-91c4-6a843ceb064e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 14:49:47.127+03
1801	c3c9a38a-f9ff-4beb-a27c-fe0c3a9d0c75	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 14:49:47.142+03
1802	bb6b1934-2c24-466d-a6aa-9f92a87b4535	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:11:21.39+03
1803	69587ab7-5a33-4407-8d6f-d118264a0bcd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:11:21.395+03
1804	276270a1-0aca-44cc-bd74-cf96ff0c01cf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:15:35.585+03
1805	878af2ab-b580-466c-a9dd-a191874c40cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:15:35.587+03
1806	01d89700-d9de-4bb1-84c7-d88550ce8d29	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:21:04.751+03
1807	d108bdc2-7ade-4d9c-8920-47372496c477	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:21:04.753+03
1808	33c193a3-c579-4acf-bdfb-95f1ccb9fc96	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:23:51.969+03
1809	9128256d-0c32-4372-970c-bb756e11fed5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-15 15:23:51.972+03
1810	c36c3ac4-0e0a-4ffd-9568-0d96be6778e4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 10:56:33.019+03
1811	b38b8580-1b2f-4c08-8cce-dc2cd8f78402	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 10:56:33.05+03
1812	88b5c93a-a7cb-4896-998a-14d8e4cf4497	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:11:15.06+03
1813	0fce8b6a-fc9e-4cf5-b3ff-a24252e1dbbd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:11:15.083+03
1814	fc837d1d-74ba-404d-9b27-3ded25487776	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:11:16.708+03
1815	5593a1a8-4b1f-456f-ba9a-e4e9409d5ffd	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:11:16.715+03
1816	195b9150-8909-43c5-87c2-cce6117fc84b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:17:08.346+03
1817	afde9d00-367a-4bec-8648-41e72b9474c6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:17:08.364+03
1818	0581a529-d568-474d-b023-8128fc740677	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:22:52.756+03
1819	e38ba1e0-a814-48c0-99c5-89ba4b0dd633	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:22:52.762+03
1820	75cacede-afdb-464d-98d7-0038805c490d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:07.002+03
1821	7b3a41c8-b0ef-4c2c-a674-f8def04c3f44	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:07.005+03
1822	79641903-0a62-44ed-b8b5-f41e94fd8e2e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:15.592+03
1823	ad6869f7-db73-4c50-9781-e58260393443	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:15.6+03
1824	e17c659a-2a2a-439d-a549-b13b6f5cbea3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:19.088+03
1825	c0534444-d10b-45fd-afec-e91ee0950598	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:19.099+03
1826	d9ee7370-6cc3-4879-aac4-44a96e2630fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:31.25+03
1827	c398cf4c-db06-462b-9b63-cb9acf660221	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:31.255+03
1828	31d034ef-a87a-493a-810e-e0e31d8a5769	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:37.199+03
1829	c62a6c46-55e4-463b-b40d-c76bb1d18fdb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:45:37.203+03
1830	4574b341-8fd0-4a52-9cae-49307a072d0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:57:59.838+03
1831	2580898b-d484-475a-b114-a17a3817d97f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:57:59.842+03
1832	e047d11c-0af2-4f8f-a480-e4029c20c84d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:58:57.798+03
1833	d84eed51-85db-47c6-a2ed-2f3f207e2076	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 11:58:57.801+03
1834	33f212e5-41c1-4e39-a883-b66d30a0b5d3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:01:10.22+03
1835	1aa69d3a-dc8a-4ca9-9c4e-a91f2861e854	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:01:10.223+03
1836	de3a4d15-1327-489a-bbcd-050d963a9c14	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:05:51.084+03
1837	35be1545-be4a-420e-a0a4-d0b4b816cab2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:05:51.086+03
1838	fef96c15-ead7-4970-903c-609977b307aa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:06:49.723+03
1839	65f5fb6d-fb49-4363-b23a-dda325f9e647	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/mission&vision	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:06:49.727+03
1840	3a55a1f0-d1c8-453c-a541-8e49afe3de3c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:08:27.235+03
1841	12d87308-67b9-4462-a7bb-684a8ca289d4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/history	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:08:27.24+03
1842	8e7f03d3-0d2a-4281-86af-a8997b0d52e9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:10:04.327+03
1843	1820f56e-2732-4cdb-9f47-1682c8d95e13	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/organizationstructure	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:10:04.331+03
1844	92ee5301-33fa-495a-8d64-669472ed1633	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:20:42.521+03
1845	7b35d362-3dd3-48b0-bdc5-95bdc806d79b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:20:42.524+03
1846	52c530fb-57cd-4b0d-a41b-9cc635b9971d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:21:25.94+03
1847	9b0d1ce1-14ae-4fa5-b742-48d213fe8488	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:21:26.566+03
1848	1d390c11-ee91-4c49-aa6c-90f315d25535	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:22:09.428+03
1849	3646c4e7-cf4b-4340-8cb3-b583a45728b2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:22:09.454+03
1850	c2eb1be0-a570-4a11-9840-740639c1de7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:25:30.539+03
1851	a0c81060-a82e-4923-aa23-c391790e8aa0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:25:31.069+03
1852	cf109568-24c4-4a3e-917d-f2e23ce98fe4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:42:31.905+03
1853	b73d02b0-c43d-49b7-8f4d-1a761b485de2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:42:32.931+03
1854	8efe27b8-0271-4fde-8b9d-b266be8fc56d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:42:32.936+03
1855	6a3afcec-085b-4bb3-945a-748e80508b05	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:42:36.945+03
1856	9c72b310-bfc3-4a58-b398-54b2208ea7d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 12:42:36.95+03
1857	b7c72d78-7063-4231-83ef-ba12419e22cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:08:45.422+03
1858	30fd891e-9923-40e0-993b-d639a128b45d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:08:52.789+03
1859	b059e291-5161-4372-8e67-b5e94147d5e5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:08:52.792+03
1860	fa210e02-6991-4c08-a01c-15cc96d7b8cf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:09:19.94+03
1861	30acc5d8-8b25-45d2-a92e-58c27c766d85	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:10:12.824+03
1862	c52ea1fa-6f5d-4d24-8ac0-12107073df30	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:11:28.527+03
1863	64bec3a1-daf0-486f-87eb-17050b6b46c7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:11:28.529+03
1864	ac7ccdaa-b8cb-4f62-8992-a5c0643ca076	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:11:33.14+03
1865	4ab5a5c3-73f0-4fc8-94e6-fa12808ed7d5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:11:33.146+03
1866	e51467a3-3baa-4f79-a848-ff075fcb0abc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:32:23.014+03
1867	1db170d9-84d5-4a00-a59c-a0d129ebb0ee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/projects	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:32:23.017+03
1868	88ef1e25-6fe3-4fad-8f67-b358359037d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:57:56.689+03
1869	c2320510-54e9-4037-b480-3cbd71b69620	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:57:56.693+03
1870	aaea1588-d324-44d7-a429-3ab06b68480b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:58:53.332+03
1871	abe97d18-214f-4d3c-9f17-030361018ac7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:58:53.338+03
1872	c9498bef-c395-4616-a9f0-69686aa0ceda	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:59:12.952+03
1873	469f56d5-67db-4390-8aac-26eb9f9192d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:59:12.958+03
1874	7b3c24b6-6526-4580-8b1f-1a5a25e55523	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:59:46.345+03
1875	626e0962-bcbd-48f9-ac43-3a72176607ab	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:59:46.349+03
1876	463bd11f-d62a-4cff-a138-ac8ae036e9e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:59:49.954+03
1877	e512e377-44bc-4d68-bdfe-5ecbd2ea809c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 13:59:49.957+03
1878	1983d3f0-c1be-4618-8e79-bbc85182832b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:19.614+03
1879	2a35657c-b56c-48f4-bce4-fc07e36407df	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:19.618+03
1880	43115d62-d484-4de8-bf91-18e3044e6387	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:24.204+03
1881	effcfdd9-aa01-4a92-87fa-b7351fbfc8dc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:24.208+03
1882	ce56e639-1402-4433-adf4-fa87fe2ffaae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:29.15+03
1883	8e9ba9b4-f94c-4f70-aaf4-f266ca5206d2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:29.155+03
1884	a8e34151-6db7-41f0-a7df-288d408e8e1e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:39.206+03
1885	fdb4c36c-a0eb-4004-a505-1fdd0ff1a20c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:39.21+03
1886	0af892b9-483d-44a7-9feb-d5f9ab8a8b33	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:43.059+03
1887	7602ff74-678b-4b5d-9a67-d997597fd048	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:43.063+03
1888	9cc63925-c8a9-475f-8870-ffae03a4e827	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:45.782+03
1889	1f1dffbf-ca1c-4f22-b035-d320923dc4c9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:00:45.787+03
1890	457e5269-7c23-422d-b413-19e2e1f4c69c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicreports	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:02:20.238+03
1891	f68c46c2-398c-4909-adb5-c7ac69482d8f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicreports	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:02:20.242+03
1892	14550002-b581-4907-9b7a-15950510db2b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicreports	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:02:54.574+03
1893	c79aaa91-b27d-47a3-8537-68150655691a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicreports	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:02:54.579+03
1894	1932f334-2292-4e43-aaed-b74f1b044318	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:05:14.081+03
1895	1a8631a3-3659-48eb-8e85-d867de008ae9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:05:14.118+03
1896	42239228-35e1-47e1-9693-67c6b64d170b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:05:19.385+03
1897	ecef96f3-698a-4453-9c19-6a04534e2ef5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:05:19.399+03
1898	6323831c-78c4-4c3f-b7ba-0f68d526360a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:05:33.235+03
1899	bc53e5b7-d9dc-42cf-b5e6-fd681bc8b3ad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:05:33.24+03
1900	80996558-d56a-4ff4-9fc2-1eaa38a3e260	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:43:44.3+03
1901	4952dde4-22a8-43db-8edb-9204969c45a8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsupdates	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 14:43:44.304+03
1902	40f13c0b-e406-429c-abf9-1c64694d4a44	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 21:57:41.396+03
1903	ce9b5c6c-7591-4137-be00-7757decd63ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 21:57:41.398+03
1904	3b2367ef-33c9-45f7-9ad8-3cda54ad3827	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 21:57:47.473+03
1905	32d731f7-06de-4cf7-bcec-2dd83ce0045e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-16 21:57:47.476+03
1906	8f86810f-9845-44fd-be30-196ee1e4e53a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-17 10:39:09.374+03
1907	c5f269e7-ee9f-4e4d-82c2-f22cc6bb08aa	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/newsletter	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-17 10:39:09.38+03
1908	604cd1da-9605-4f5e-bdc4-b6319cf06297	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-17 10:39:16.384+03
1909	0b5a9831-317c-4fe1-96cc-8ac49d9ce47f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-17 10:39:16.387+03
1910	75d0e160-e193-4aa6-8cb5-7285872b9673	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-17 10:45:49.972+03
1911	519986c1-b023-43f2-afb2-ba40bc49321b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-17 10:45:49.976+03
1912	54a5ed90-d751-4b5f-beb6-29a478947791	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:30:37.687+03
1913	d0e1299e-5d26-45d8-9efe-1d990518e70d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:30:37.701+03
1914	e404cb1b-dd3d-4788-a46b-32ad4384392f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:53:40.026+03
1915	3fe546ab-5395-49ab-a5b8-aa5822656504	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:53:40.043+03
1916	c3c20755-8c81-4901-8c4d-b3c2d8d6534b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:53:56.447+03
1917	e56abd82-bb8b-47dd-b423-cffbf306dc2d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:53:56.466+03
1918	867a4aaf-4fe1-43a1-a1b4-57c1dc35ac5e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:54:59.42+03
1919	58b63cfc-64c7-4339-8e7a-33234b6738f4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-18 20:54:59.449+03
1920	5a3372ac-9479-471e-a0d5-ce98bd6bf7b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 00:00:47.925+03
1921	5706e61a-2122-41a8-9251-3f33f9864f40	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 00:00:47.942+03
1922	1c32ec9f-495a-4dab-9cba-eefaa20d1492	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:25:44.91+03
1923	bc0abd9a-c57a-40ee-b9ef-c3369203c32f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:25:44.916+03
1924	2eaa5d2d-bd07-4ec5-b3b7-8a24d8e2d939	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:35:39.962+03
1925	875a56fc-e5db-4940-8ed6-0fcf3124f1ad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:37:48.137+03
1926	eaa1b6df-7a4e-4e98-9491-42b833402c69	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:40:21.352+03
1927	5f780d88-c71b-4541-bbad-15ecae13e0cc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:40:21.355+03
1928	fdca9de2-2fab-4b78-a1fd-cc96993ad718	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:44:03.915+03
1929	44aba715-b106-4875-b59c-4ce0e2d42c3a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:44:03.921+03
1930	5d70bcba-aa0a-4b7d-8738-87cad349d12c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:57:28.292+03
1931	6345cee4-790e-4775-81f5-dc6f3aee4872	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 13:57:28.296+03
1932	a28694db-4e2a-4d47-bd3c-4495a2dc2441	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:14:54.636+03
1933	7f338f23-bddb-485e-8c12-dc9ed58c5f6c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:14:54.639+03
1934	0478bed0-583b-4c45-b16e-cf92d30e6634	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:27:52.131+03
1935	cf2cb985-3c47-4922-8a94-e00b40370866	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:28:07.37+03
1936	04129ec0-ccdd-4ffc-b1e6-ded4ba47e7c2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:31:02.437+03
1937	b8b5e8c4-ab0d-4947-940b-f0ed8fe0bfbe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:35:38.581+03
1938	f1b6bff7-4069-40d9-8b11-3051d4d94277	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:39:59.726+03
1939	2e05eebf-4c3b-4538-adb9-14f9f96b020d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:39:59.727+03
1940	fd373cd2-5d94-437f-a684-b511aee91379	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:40:05.678+03
1941	05aadab9-b991-4471-982e-817cf7f8bae4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:40:05.681+03
1942	7bda77b3-fa4e-4bed-bdf2-e2ff2d95ebed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:40:55.113+03
1943	ecdc5304-ab07-45ca-8b40-382227647a48	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:40:55.117+03
1944	46fcb052-0d6a-48b1-ac7b-8f93337e0643	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:41:55.992+03
1945	e430b1f1-4323-451f-a09e-0c4068022276	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:41:56.007+03
1946	6b333b5f-e92d-41d6-ad2d-a46eb8bd948b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:41:57.841+03
1947	b447b4ed-31ec-4fbb-bdfd-936a5adb0c8e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:41:57.865+03
1948	7e0fa03a-bdeb-40bf-a2c0-d3368b972465	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:42:01.756+03
1949	f1b8e7c2-183f-4acd-b334-2b2b071e298c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:42:01.769+03
1950	5ab66602-5488-433a-8027-0350f6d96aca	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:45:09.238+03
1951	e4464994-f0a7-4aea-8fcf-2ea1d0b41fe2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:45:10.267+03
1952	27aa740e-7cde-4be8-b5e9-feeac7a47d64	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:48:23.359+03
1953	4c91c6eb-9688-44ca-aa0b-dfaace9bcf7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:48:23.361+03
1954	f1b5819e-4735-4657-b670-497dc8f580cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:51:39.491+03
1955	b24cc3f5-ad50-4092-a11c-e21d92ff4b1b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:51:39.495+03
1956	12fd0152-73a1-468c-bb6c-4461834fe62c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:56:05.436+03
1957	43a62aca-3a00-4e32-b4bb-d58d36e16f58	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:56:05.44+03
1958	a88d5a50-e055-4f16-863f-a6d5e6e8e78a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:59:35.336+03
1959	b6d8e161-8c9d-479f-bbfb-86ffaee8bb37	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 14:59:35.354+03
1960	2710f666-620b-4168-bbd3-1b17726074f8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:05:55.583+03
1961	39111355-0ff2-44bf-a96c-2fabaef30810	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:05:56.071+03
1962	efd5396f-b9a7-41a4-88e4-2bd0ac05a2f5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:06:23.01+03
1963	af254feb-866d-4cc6-b73d-5f927f3c72d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:06:23.015+03
1964	81a973c2-23a0-462c-b02f-db88b999fcb9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:13:36.433+03
1965	3637de46-d417-438e-a441-8ce8de648fe1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:13:36.45+03
1966	9ef8dee9-1315-475b-948f-d8aaff1a73e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:17:14.896+03
1967	696aa7ed-2884-426e-aeb0-14fa0a0ea5e4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/tenders	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:17:14.899+03
1968	452cc2be-8e3c-440e-b8f5-0accdf1b87a3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicreports	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:23:50.752+03
1969	fb015002-958d-444f-ae19-7347d48a3f78	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicreports	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:23:50.757+03
1970	ada9b439-bf5f-4f63-b9c9-79b0522a6df7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:52:27.158+03
1971	9b52b8c6-feb5-40bd-9fa8-d620f873e71b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 15:52:27.172+03
1972	c4c93c37-e13f-4c68-bbb8-15c896d8b5ee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 20:55:15.204+03
1973	51e2e0cb-f192-4fa1-937b-090c748df596	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 20:55:15.221+03
1974	88a1e205-8c74-460c-8a0c-f4d53d54d8c2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:16:15.829+03
1975	c25007ce-035e-446b-b9cd-64a7583ebbc3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:17:22.163+03
1976	b739ddc1-d6d5-47e5-8b03-f2e8e5fe593b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:19:39.096+03
1977	9f5586ca-5825-4611-addc-9d705f1065b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/notifications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:19:39.102+03
1978	230b9e72-6d52-4008-b20f-dbecb8a2c106	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:23:33.961+03
1979	20ac2bf7-cca8-416c-9008-d7a35e0e9439	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:23:33.964+03
1980	110f910f-a1b9-4d5b-b69d-506c1faa6f10	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:45:20.054+03
1981	5cb7c092-f5b7-4ab3-b356-b13829ac8c25	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:46:12.311+03
1982	d63230d3-d7a3-4faf-90b0-f37ec292cbf3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:47:48.312+03
1983	358063c7-b75e-4d34-88ee-0a655a5b0d2f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:48:39.632+03
1984	dfcaf53b-4ab7-41ec-910c-496fb94609f1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:50:13.546+03
1985	da2021df-442f-467d-99a2-ab876def1c32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:51:33.966+03
1986	688bfdcc-4228-4a15-8ce9-d816a3fbb042	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 21:52:23.161+03
1988	f013b620-ee0c-4dd6-b123-38e4ef00d2ae	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:18:32.097+03
1987	bebb680d-94da-455e-a100-a43d4caa2536	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:18:32.091+03
1989	2771b92a-2b16-4761-9420-0db0d1f9d01c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:27:47.68+03
1990	2b494e1a-585b-408b-8464-7eeee619d48e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:27:47.684+03
1991	aeed9350-b6b5-4e34-8c42-ebf79b4f9d02	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:27:55.022+03
1992	620f055a-75f5-40b7-a200-b3ed65abf29d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:27:55.034+03
1993	e01eb0ca-b26d-4ac2-9fad-5923e8b8dc41	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:28:31.356+03
1994	5db4be8f-2884-4958-9beb-a03afcaac5ef	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:28:31.358+03
1995	86a5e548-c435-46d5-8968-499b8d2abeb0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:49:10.159+03
1996	4b8cafb8-a1d9-4dd2-950c-4eedc1940a31	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:49:10.164+03
1997	27ffd220-32eb-4aee-9e4f-af85b27b5c42	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:49:21.733+03
1998	b065e137-264b-48f6-9b79-c5302d486d86	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:49:21.746+03
1999	b25e2249-c68a-4cde-b278-924ad87e14f7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:49:30.671+03
2000	5aab0193-7e88-47a4-983e-434028a21729	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:49:30.673+03
2001	d8d66c5e-3d36-4b87-bc38-b1357f6dde04	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:59:03.949+03
2002	d295828e-6db1-451c-83fd-a6a01e082167	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-19 23:59:03.951+03
2003	65c2b950-3eeb-42d3-b80b-2f6ac07b16ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:30:58.156+03
2004	3cb6033a-d94a-46ba-bade-9f93e7a95213	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:30:58.165+03
2005	4c018674-5118-4133-9672-40ad3c8edd42	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:31:02.184+03
2006	2d1a4e1d-101d-4146-886e-e0357202c411	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:31:02.189+03
2007	492662a2-b86d-4db0-8884-d3c72dce4e35	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:36:47.846+03
2008	479c58bc-b74d-46a6-9836-c56fae9c0d0f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:36:51.342+03
2009	e0975c9b-cb1c-4ebc-ba9b-ea53d5a1dee2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:36:51.344+03
2010	685821ca-1408-4bba-91e3-4ec84379c64a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:42:23.411+03
2011	d18b0988-e322-4172-8c96-85016adb8f3c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:42:23.413+03
2012	f30f3925-4b46-4345-9383-70d57ed78530	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:43:52.663+03
2013	fe170a03-858b-4c88-99ff-5b9f31e38d41	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:43:52.676+03
2014	831a1824-2bc7-44c4-bda9-971838b3c445	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:56:12.879+03
2015	2d6054af-c3c2-4066-95f4-0022816608a9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 00:56:12.903+03
2016	0072b30c-69a3-41ee-b3df-b3612acfa79c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:06:31.104+03
2017	abd17a75-259c-4569-85d1-48a623c63fe3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:06:31.119+03
2018	6f3e2206-9a5d-40b7-a03d-c6f11d87daca	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:06:33.706+03
2019	98eb5f98-3943-4c03-894a-5e571991e451	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:06:33.725+03
2020	3c65a7ec-41b3-4855-9a8d-4b2b8c582997	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:06:36.492+03
2021	0d389887-ba60-463b-a10b-c0d1306ac98f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:06:36.494+03
2022	67050fc8-99ad-44d1-bec1-a52bb7787d44	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:15:48.904+03
2023	a1b3b8a1-9f8e-4b57-8010-d25c65ec6e18	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:15:48.932+03
2024	e7811928-664e-46df-8588-e5696c0484a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:16:15.233+03
2025	d88510f7-1ef3-44f0-ae9d-851a7eaf2211	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-20 01:16:15.249+03
2026	930b3b4d-ac0f-41df-b417-cdf07e5bc7d7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-21 22:52:42.266+03
2027	f180b15a-e504-4655-884f-5abca059ddd4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-21 22:53:13.091+03
2028	894e20f8-2091-4fb8-a4d5-d554d5ff0c03	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-21 22:53:13.105+03
2029	c9915a95-1b9d-4c22-b2e2-e03c45329b52	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 09:02:03.687+03
2030	7207611b-d721-4ed0-a6a2-d06a92db6b9a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 09:02:03.705+03
2031	0842cf08-df7d-44cc-9f8f-df5162162d79	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 09:02:14.253+03
2032	62ffc27a-edc0-4de3-97d2-023b289aca16	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 09:02:14.271+03
2033	b0df793d-d912-429d-ba63-19efd7a3c488	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 09:02:33.613+03
2034	2b8a4e1f-cd72-4ea4-93ba-84ecfd0a867e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 09:02:33.63+03
2035	4a1a5895-37c8-4a10-9042-d26ebdd659fb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 15:15:58.911+03
2036	e990db53-d336-421e-937a-fdb4efba5b56	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-22 15:15:58.915+03
2037	0c8911f5-e170-4d6f-8c5e-d62f3474ea89	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 13:18:58.125+03
2038	9d68f288-8a9c-4f52-8797-a77560152015	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 13:19:23.28+03
2039	b7c9d259-3323-4be4-adc1-cbfd4c9caf57	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 13:19:23.297+03
2040	ef313b93-c757-4794-a05e-23425252dde5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:56:22.875+03
2042	13f32e96-fa52-4daa-84b1-bd4f0ee00b07	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:57:08.015+03
2043	9bf33935-a443-448d-90a9-632c0db26e78	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:57:08.022+03
2073	b31aa22b-6889-44fd-893d-f2b20e3bbab8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 18:40:28.51+03
2111	6d9d93db-545d-4bba-b2b1-0b7426b49487	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:38:26.083+03
2151	8c5642df-70f2-4991-8ae0-decaa7d21e75	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 09:34:45.324+03
2152	4cd0ac0a-0ddc-4697-b272-7a6f18bee62a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 09:34:45.344+03
2044	f3bcc364-bcaf-4e0f-97bc-0862b122db32	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:57:41.614+03
2074	50f3f80e-61c4-432c-8b44-3486235cc580	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 18:50:32.012+03
2075	0ca284a9-9928-4e71-967f-f34be4dc9f8b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 18:50:32.015+03
2112	b5118612-bc39-4fd5-a223-9895628a7250	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:40:53.012+03
2113	d0cb1d7b-149e-4c67-a400-d20109e44338	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:40:53.031+03
2153	eb12ec77-5789-4085-9639-c25704732cf4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 09:35:10.82+03
2154	056ec8fa-7686-4f90-9830-707f5b8a58d6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 09:35:10.838+03
2045	b5c6116e-39c6-4fbe-b7e6-1379d681e52b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:57:41.616+03
2077	026d88dd-71b0-4d0a-a67a-d68795d60c1f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:06.434+03
2076	d5e5cda1-d14d-4d4a-9e1e-a0679f993669	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:06.437+03
2078	3f3f00b5-6e28-45c3-8aa5-2ae94f882223	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:10.745+03
2079	1db35af9-03a0-4c28-a3ce-aaec299aadc1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:10.747+03
2080	4f1fc9ea-d717-4f07-9b63-2b0915c6dd43	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:15.845+03
2081	6b34d1de-280f-4a4f-aa9b-3d9354f60f5f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:15.848+03
2082	48b899e5-43c7-4229-ae77-b2d92d52f3ed	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:21.058+03
2083	1841b9f0-dae2-4288-9c07-bb8f50fdb320	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:21.061+03
2084	3ca9a4c5-d4b0-4e09-9e5b-fa301c8fc923	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:24.488+03
2085	823f760a-97fb-44bd-8fe6-0df36ddc4aad	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:31:24.492+03
2114	9241f77a-b716-4bdd-b7fb-6bc7fc80a6ff	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:41:30.366+03
2115	3a994c3f-64ee-413d-9f2c-349c5a7cd840	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:41:30.385+03
2156	90336b5e-2b89-45c0-a182-dcac323d8422	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 13:21:46.295+03
2155	710a6e7e-d18e-4139-9279-e42c073888c9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 13:21:46.299+03
2046	1f7112b2-0a5e-4e76-8bc6-a3c149fdebc7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:58:15.425+03
2086	694e6b1a-9e11-4c53-88c0-73648fc67412	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:44:50.715+03
2087	2b5836d0-4155-4930-8a8f-180181b12773	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:44:50.718+03
2116	7638db38-921d-4894-a25e-2bfd4146a77d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:56:50.905+03
2117	094bcc30-2299-41c2-9f4d-c9dd6b370f0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/vacancies	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:56:50.908+03
2158	9cbff75f-d51d-45a3-9beb-5d7074577ca2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/laws&regulations	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:16:54.381+03
2157	d8a9b47e-c57e-49a8-a7b6-77deca75da7f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/laws&regulations	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:16:54.379+03
2047	155bdae8-7dbc-4b4e-8037-795bb1fa3f27	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:58:15.429+03
2048	2679bba9-fa4f-4196-a0b1-a6c97fe2372f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:58:24.227+03
2049	a621935b-95d1-4683-ba78-814ccb9b32f3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:58:24.233+03
2088	3675080f-5f74-4f61-8c62-0eb63ea86d63	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:53:28.656+03
2118	03f508b8-be6a-47ff-8f79-f3744c7d7cb7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 22:10:21.03+03
2119	e31ed93e-b4cf-4468-ba18-9b952234b513	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/billboard	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 22:10:21.035+03
2159	5eb77225-86db-4dad-9d49-e73694048ba0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/guidelines	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:20:14.809+03
2050	584d70a5-054b-4879-8866-34fcfad89148	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:59:04.858+03
2089	39abede8-7216-44cf-8ef1-a947987fcfee	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:53:28.659+03
2120	a8f45d66-b433-4c61-abe2-6d25dfbe797c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 08:56:14.54+03
2121	7e9a7e66-5c23-4168-a3d4-a7437014d8e0	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 08:56:14.582+03
2122	cbfba5f3-9a8b-49e2-9067-fd853ba5fa19	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 08:56:17.838+03
2125	3c61df42-7283-4e81-a6ce-13a23e78daac	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 08:56:19.867+03
2160	94ebc018-6fc4-4318-8fe9-e8d09b75292d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/guidelines	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:20:14.813+03
2051	73e17ef3-421a-4fa6-976d-5147abd102e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:59:04.862+03
2090	9097e6b5-854f-4ab7-b80c-207e0641c96b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:53:37.807+03
2091	59122921-adbf-4f7d-80f2-8ed7d2ce89fc	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 19:53:37.824+03
2123	2284e227-6e0f-4d56-9468-dc7717b1c34a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 08:56:17.839+03
2124	67c4ad88-f684-45c5-9104-407e19fd3af5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 08:56:19.865+03
2161	ac45973b-c284-4aa5-bc9d-c1bc0ba175d3	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:28:44.046+03
2163	a66efa3f-588b-47cf-85cc-caf5a8258739	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/guidelines	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:28:45.511+03
2164	bdd5d771-9c30-457b-a8e2-50dc20f0e594	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/guidelines	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:28:45.515+03
2052	4ab7e5dd-acb0-441d-a8c7-da18566a39a6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:59:15.761+03
2053	d383c307-e25c-4d6c-96d7-ac42a612942d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:59:15.767+03
2092	75877b0e-6a78-41f9-9623-09b927bfe4e8	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 20:03:53.855+03
2126	c40d57cd-e4c9-4886-8e6a-1de876c971de	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:04:44.949+03
2127	e592708a-6fff-4e0d-b8e9-155288aae00a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:04:44.954+03
2162	6a9e083e-bdd8-47d7-be22-2e02983f9cca	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:28:44.05+03
2054	f3a16429-2337-46e1-b752-6dbe8830b291	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:59:32.598+03
2093	87987f95-03b9-4098-abbc-e34a2bc0e901	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 20:03:53.86+03
2128	21b45954-3d3f-4d86-bdc9-26c4ebd68d7d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:05:39.276+03
2129	14061386-6cbc-4c7a-bcff-e5bd601fc84a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:05:39.28+03
2165	1d336646-bbd7-4c94-9d3b-6d7e82663942	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:36:32.69+03
2166	55955a68-0e86-44e6-b348-632ee6da2bb1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/laws&regulations	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:36:32.713+03
2055	0ea98837-451a-45ad-a8bf-b4d82447891a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:59:32.6+03
2094	e0960d36-48fd-4abf-aa2e-0655ccd5e359	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 20:36:45.646+03
2095	e0aeba96-37da-4440-8e37-cd337e1417b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 20:36:45.663+03
2130	fbd66a6c-2962-4fe9-a9f9-2bbd17f1e91b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:06:47.369+03
2167	e0762301-264e-4922-b355-6dcc0d570324	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/laws&regulations	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:37:37.368+03
2168	48d74c1b-11b9-435c-a53c-a84d91411451	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:37:38.348+03
2056	7c55007a-6a30-45b8-a28b-21b91f414ab4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:00:32.103+03
2057	bd2e4ab9-67e9-4551-b668-74d80b540f1a	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:00:32.109+03
2096	bd7b57ab-1050-4cc6-819a-49a39ef7c08d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 20:48:17.239+03
2097	04be15a6-91be-441b-886c-fb06ccac900c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 20:48:17.257+03
2131	8e49671e-00d0-49c4-9658-72c125448385	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:06:47.386+03
2132	e571ba92-d0df-400c-bafd-2107a87e568c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:06:56.79+03
2169	944c762c-b117-4e30-b89f-4194b6a1faf7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/laws&regulations	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:37:49.374+03
2059	3a822ab0-a12f-4fd3-93b0-e183a2c3b19b	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:29:28.277+03
2058	ba61a724-12ad-4697-90ec-91c12882194e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:29:28.273+03
2098	6b229ea9-0049-401c-b26b-c5d836e9005c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:08:26.431+03
2099	315d2daf-2088-4dda-8d54-1f1255248ec4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:08:26.451+03
2133	e83fe7b9-3ab4-4eb2-81c4-527cef70fb52	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:06:56.792+03
2170	9fcaebf0-c3d1-4971-9f5a-561e75327f37	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/publications	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:37:49.407+03
2060	c2a1147a-7a31-4fec-845f-f8a514e8312c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:43:59.338+03
2100	1ad63bd1-5d66-40e1-9301-9ff171e1af53	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:16:30.897+03
2134	659a307e-1d31-4532-8ca5-e0b446112658	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:21:01.625+03
2137	68f422b6-d0ad-401a-8568-16db02721ce9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:21:10.74+03
2171	28703022-98a8-4f6a-ac03-34a099be87a6	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/guidelines	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:39:42.491+03
2061	4e787a41-6b9e-4d92-9a44-8c9a49626833	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:43:59.341+03
2101	2c572424-3c85-4488-a386-028b9b718670	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:16:30.933+03
2135	f25e550d-3bc7-4dcb-afa0-09e1f7007dd5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:21:01.636+03
2136	d7d8fcc4-5661-418c-82e9-afab3b38e984	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:21:10.737+03
2172	8dd864ec-75b2-4188-9c95-07293e381e0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/guidelines	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:39:42.494+03
2062	ddcf7e2c-fc51-40ef-ab2e-18a34e601681	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:44:55.799+03
2063	e5479b99-5966-45f7-8352-e99e646e565c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:44:55.815+03
2102	02c8e543-943c-4129-8e56-bfc82a4709eb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:22:11.773+03
2103	8a82243d-2915-4c79-bc94-c5a353735ea9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:22:11.803+03
2138	51f87305-8ec7-416f-91c4-6caeead8ee87	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:36:20.866+03
2139	e28b2fed-fdb4-48c4-b042-070b18fcdc5e	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:36:20.883+03
2173	e8e231d3-c5e5-4a9f-9990-2dbd4cc9fa28	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:40:58.3+03
2174	28efb92b-3238-4dd5-8a93-dc86e2467009	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/publicforms	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-25 23:40:58.305+03
2064	59bcd8fd-c926-4508-be14-6dabf3c2cef1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:45:37.92+03
2065	28310063-ba3e-469a-8708-129f22803bfe	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:45:37.929+03
2104	8fbf3d16-2008-4108-b625-39e93a884773	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:23:08.929+03
2105	4b5342b5-56ef-439a-82d6-50d42ee9c3cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:23:08.95+03
2140	3a0ac2bb-7e96-401f-8053-8d9b7d20cfb4	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:44:18.612+03
2141	3ce45343-0deb-489f-891b-325ff8c9bde7	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:44:18.616+03
2142	935ff35a-80bf-4880-9e22-a49a358520d9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:44:28.517+03
2143	762a438f-d351-4712-8074-2e345c4c318f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 11:44:28.521+03
2175	7962a94d-1896-4a56-b591-8d019801e337	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-26 00:00:40.366+03
2176	f14a02f8-8014-47b2-b164-9a3822150611	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-26 00:00:40.377+03
2066	d23e208a-effb-4878-948e-d620bc0c3584	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:45:45.675+03
2067	94a92784-8962-4228-9d49-bcc2ece17cc1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:45:45.686+03
2068	49c713a3-043e-471c-bcd8-811474fb3edf	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:45:51.038+03
2069	0d58af4a-caf2-4a6e-a4ba-92f2f72c73cb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 17:45:51.054+03
2106	4d2a859d-0ead-4b43-b0e6-ec85b30de7e5	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:33:53.447+03
2107	152ed333-2b11-48f1-9d5d-d5649cf168a1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:33:53.451+03
2144	64806ab7-a192-4732-ab8f-03ccff014e1f	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 13:55:43.146+03
2177	23f70783-0f64-42ea-b0d2-a1c30b529815	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-26 15:53:39.975+03
2071	d8365f31-1b37-4dbc-9bf7-05216ef2cf2d	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 18:29:22.56+03
2108	d990ab85-894b-414b-8b77-d47386e96f18	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:35:54.645+03
2145	4a5e29b6-674e-4d2d-ad69-80f20c3be098	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 13:56:28.351+03
2146	baa10c27-c8c5-4645-acf7-ded0420566eb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 13:56:28.367+03
2178	9435f8fd-945c-44cc-a023-5b7a441e8695	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-26 15:53:39.988+03
2070	8f764590-b404-42df-be92-4bd6f6b118eb	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 18:29:22.556+03
2109	c17b2065-d19a-442b-97c1-20212afbd35c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:35:54.652+03
2147	9ae9d8d0-1596-42f9-90a4-cf2ce8feea0c	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 14:44:52.877+03
2148	b0cf0537-38cd-4948-9cec-539436e94077	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 14:44:52.892+03
2072	dcca8924-b1bd-479e-8a48-4715b17d31b9	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/webcontentsmgr/feedbacks	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 18:40:28.487+03
2110	db2a8aa2-3325-417b-aab2-452ab269f5e1	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/justiceofappeal	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 21:38:26.078+03
2150	b2bb1621-a55e-480f-b75e-957648d17ce2	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 15:27:43.41+03
2149	0e216071-2042-42ff-a478-f214f434d953	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/login	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-24 15:27:43.408+03
2041	d5fd7b79-5ebb-461e-9598-77031ea7c332	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0	http://localhost:3001/contactus	/api/websiteVisit/postVisit	\N	desktop	Firefox	macOS	0x0	unknown	unknown	en-US	false	2025-07-23 16:56:22.869+03
\.


--
-- Name: announcements_announcementID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."announcements_announcementID_seq"', 3, true);


--
-- Name: billboards_billboardID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."billboards_billboardID_seq"', 2, true);


--
-- Name: feedbackReads_feedbackReadID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."feedbackReads_feedbackReadID_seq"', 4, true);


--
-- Name: feedbacksReview_feedbackReviewID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."feedbacksReview_feedbackReviewID_seq"', 1, false);


--
-- Name: feedbacks_feedbackID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."feedbacks_feedbackID_seq"', 6, true);


--
-- Name: gallery_galleryID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."gallery_galleryID_seq"', 4, true);


--
-- Name: leadersTitle_leadersTitleID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."leadersTitle_leadersTitleID_seq"', 4, true);


--
-- Name: leaders_leaderID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."leaders_leaderID_seq"', 4, true);


--
-- Name: newsletter_newsletterID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."newsletter_newsletterID_seq"', 3, true);


--
-- Name: newsupdates_newsupdatesID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."newsupdates_newsupdatesID_seq"', 11, true);


--
-- Name: notificationReads_notificationReadID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."notificationReads_notificationReadID_seq"', 4, true);


--
-- Name: notifications_notificationID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."notifications_notificationID_seq"', 16, true);


--
-- Name: publications_publicationsID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."publications_publicationsID_seq"', 3, true);


--
-- Name: tenders_tenderID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."tenders_tenderID_seq"', 3, true);


--
-- Name: user_userID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."user_userID_seq"', 12, true);


--
-- Name: vacancies_vacancyID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."vacancies_vacancyID_seq"', 1, false);


--
-- Name: websiteVisit_visitID_seq; Type: SEQUENCE SET; Schema: public; Owner: userdb
--

SELECT pg_catalog.setval('public."websiteVisit_visitID_seq"', 2178, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY ("announcementID");


--
-- Name: billboards billboards_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.billboards
    ADD CONSTRAINT billboards_pkey PRIMARY KEY ("billboardID");


--
-- Name: feedbackReads feedbackReads_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."feedbackReads"
    ADD CONSTRAINT "feedbackReads_pkey" PRIMARY KEY ("feedbackReadID");


--
-- Name: feedbacksReview feedbacksReview_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."feedbacksReview"
    ADD CONSTRAINT "feedbacksReview_pkey" PRIMARY KEY ("feedbackReviewID");


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY ("feedbackID");


--
-- Name: gallery gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.gallery
    ADD CONSTRAINT gallery_pkey PRIMARY KEY ("galleryID");


--
-- Name: leadersTitle leadersTitle_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."leadersTitle"
    ADD CONSTRAINT "leadersTitle_pkey" PRIMARY KEY ("leadersTitleID");


--
-- Name: leadersTitle leadersTitle_title_key; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."leadersTitle"
    ADD CONSTRAINT "leadersTitle_title_key" UNIQUE (title);


--
-- Name: leaders leaders_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.leaders
    ADD CONSTRAINT leaders_pkey PRIMARY KEY ("leaderID");


--
-- Name: newsletter newsletter_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.newsletter
    ADD CONSTRAINT newsletter_pkey PRIMARY KEY ("newsletterID");


--
-- Name: newsupdates newsupdates_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.newsupdates
    ADD CONSTRAINT newsupdates_pkey PRIMARY KEY ("newsupdatesID");


--
-- Name: notificationReads notificationReads_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."notificationReads"
    ADD CONSTRAINT "notificationReads_pkey" PRIMARY KEY ("notificationReadID");


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY ("notificationID");


--
-- Name: publications publications_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY ("publicationsID");


--
-- Name: tenders tenders_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.tenders
    ADD CONSTRAINT tenders_pkey PRIMARY KEY ("tenderID");


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY ("userID");


--
-- Name: user user_userEmail_key; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "user_userEmail_key" UNIQUE ("userEmail");


--
-- Name: user user_userEmail_key1; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "user_userEmail_key1" UNIQUE ("userEmail");


--
-- Name: vacancies vacancies_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.vacancies
    ADD CONSTRAINT vacancies_pkey PRIMARY KEY ("vacancyID");


--
-- Name: websiteVisit websiteVisit_pkey; Type: CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."websiteVisit"
    ADD CONSTRAINT "websiteVisit_pkey" PRIMARY KEY ("visitID");


--
-- Name: announcements announcements_userID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT "announcements_userID_fkey" FOREIGN KEY ("userID") REFERENCES public."user"("userID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedbackReads feedbackReads_feedbackID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."feedbackReads"
    ADD CONSTRAINT "feedbackReads_feedbackID_fkey" FOREIGN KEY ("feedbackID") REFERENCES public.feedbacks("feedbackID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedbacksReview feedbacksReview_feedbackID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."feedbacksReview"
    ADD CONSTRAINT "feedbacksReview_feedbackID_fkey" FOREIGN KEY ("feedbackID") REFERENCES public.feedbacks("feedbackID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: leaders leaders_userID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.leaders
    ADD CONSTRAINT "leaders_userID_fkey" FOREIGN KEY ("userID") REFERENCES public."user"("userID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: newsletter newsletter_userID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.newsletter
    ADD CONSTRAINT "newsletter_userID_fkey" FOREIGN KEY ("userID") REFERENCES public."user"("userID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: newsupdates newsupdates_userID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public.newsupdates
    ADD CONSTRAINT "newsupdates_userID_fkey" FOREIGN KEY ("userID") REFERENCES public."user"("userID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notificationReads notificationReads_notificationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userdb
--

ALTER TABLE ONLY public."notificationReads"
    ADD CONSTRAINT "notificationReads_notificationID_fkey" FOREIGN KEY ("notificationID") REFERENCES public.notifications("notificationID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

