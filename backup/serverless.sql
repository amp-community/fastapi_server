--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: update_letter_boxes_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_letter_boxes_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
          BEGIN
              UPDATE "letter_boxes"
              SET "updatedAt" = current_timestamp
              WHERE id = NEW."letterBoxId";
              RETURN NEW;
          END;
          $$;


ALTER FUNCTION public.update_letter_boxes_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id uuid NOT NULL,
    "firstName" character varying(255),
    "lastName" character varying(255),
    email character varying(255),
    "imageUrl" character varying(255),
    "accountType" character varying(255),
    "profileUrl" character varying(255),
    about character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    origin character varying(255),
    "externalId" character varying(255),
    discover character varying(255),
    phone character varying(255),
    "utmSource" character varying(255),
    "utmCampaign" character varying(255),
    "utmMedium" character varying(255),
    "referralPartner" character varying(255),
    "acceptedSmsAt" timestamp with time zone,
    "utmContent" character varying(255),
    "utmCampaignId" character varying(255)
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: admin_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_fields (
    id integer NOT NULL,
    name character varying(255),
    value text,
    "relatedEntityId" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "user" character varying(255),
    "deletedAt" timestamp with time zone,
    category character varying(255),
    "relatedEntity" character varying(255) DEFAULT 'Business'::character varying NOT NULL
);


ALTER TABLE public.admin_fields OWNER TO postgres;

--
-- Name: admin_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_fields_id_seq OWNER TO postgres;

--
-- Name: admin_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_fields_id_seq OWNED BY public.admin_fields.id;


--
-- Name: business_saved_offerings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_saved_offerings (
    id uuid NOT NULL,
    "OfferingId" uuid,
    "BusinessId" uuid,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.business_saved_offerings OWNER TO postgres;

--
-- Name: businesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.businesses (
    id uuid NOT NULL,
    "AccountId" uuid,
    name character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    "websiteUrl" character varying(255),
    "logoUrl" character varying(255),
    "incorporatedAt" timestamp with time zone,
    "productType" character varying(255),
    category character varying(255),
    subcategory character varying(255),
    about character varying(255),
    "instagramHandle" character varying(255),
    "linkedinHandle" character varying(255),
    "twitterHandle" character varying(255),
    "tiktokHandle" character varying(255),
    "isFamiliarWithCdfi" boolean,
    "isFamiliarWithRvb" boolean,
    "hasPreviousOffering" boolean,
    "targetFundingAmount" character varying(255)[],
    "targetRepaymentYearsMax" integer,
    "isFundsForGrowth" boolean,
    "useOfFunds" text,
    "isFundingReadinessComplete" boolean,
    "lastMonthRevenue" double precision,
    "monthlyRecurringRevenue" double precision,
    "lastMonthExpenses" double precision,
    "creditScore" integer,
    "percentSalesOnline" double precision,
    "guaranteeAmount" double precision,
    "businessGoal" text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "fundingJourney" character varying(255),
    "locationId" integer,
    "incorporationType" character varying(255),
    industry character varying(255),
    type character varying(255)[],
    "lastYearRevenue" integer,
    "lastYearProfit" integer,
    "trailingThreeMonthRevenue" bigint,
    "trailingThreeMonthProfit" bigint,
    "outstandingPurchaseOrders" integer,
    "outstandingAccountsReceivable" integer,
    "totalAmountInGovernmentContracts" integer,
    "numberOfLoans" integer,
    "totalAmountInLoans" integer,
    "targetLoanAmount" integer,
    "growthMotivation" character varying(255)[],
    "loanMotivation" character varying(255)[],
    "loanTimeframe" integer[],
    "lastBankruptcyDate" timestamp with time zone,
    "shareholderInfo" jsonb
);


ALTER TABLE public.businesses OWNER TO postgres;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    "accountId" uuid NOT NULL,
    "accessToken" text,
    "itemId" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "institutionId" character varying(255),
    origin character varying(255) NOT NULL,
    "externalId" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    context character varying(255),
    "totalOfFailures" smallint DEFAULT 0,
    status character varying(255) DEFAULT 'active'::character varying
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id uuid NOT NULL,
    "businessId" uuid,
    "credentialSourceId" integer,
    description character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: credentialSource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."credentialSource" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "credentialSourceTypeId" integer,
    "imageUrl" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."credentialSource" OWNER TO postgres;

--
-- Name: credentialSourceType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."credentialSourceType" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."credentialSourceType" OWNER TO postgres;

--
-- Name: credentialSourceType_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."credentialSourceType_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."credentialSourceType_id_seq" OWNER TO postgres;

--
-- Name: credentialSourceType_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."credentialSourceType_id_seq" OWNED BY public."credentialSourceType".id;


--
-- Name: credentialSource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."credentialSource_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."credentialSource_id_seq" OWNER TO postgres;

--
-- Name: credentialSource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."credentialSource_id_seq" OWNED BY public."credentialSource".id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    "accountId" uuid NOT NULL,
    "externalId" character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "churnedAt" timestamp with time zone
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: demographics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demographics (
    id uuid NOT NULL,
    "AccountId" uuid,
    birthday timestamp with time zone,
    "isBlack" boolean,
    "isLgbtq" boolean,
    "isFemale" boolean,
    "isMilitary" boolean,
    "isDisabled" boolean,
    "isVeteran" boolean,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "genderIdentity" character varying(255),
    "raceAndEthnicity" character varying(255)[],
    "educationalLevel" character varying(255),
    "dateOfBirth" date,
    "hasDisability" boolean,
    "isLgbtPlus" boolean,
    "isMilitaryOrVeteran" boolean
);


ALTER TABLE public.demographics OWNER TO postgres;

--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id integer NOT NULL,
    "accountId" uuid,
    type character varying(255),
    path character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdByEmail" character varying(255),
    status character varying(255),
    origin character varying(255),
    "mimeType" character varying(255)
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: domain_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.domain_events (
    id bigint NOT NULL,
    value jsonb NOT NULL,
    version character varying(255) DEFAULT 'v1.0.0'::character varying NOT NULL,
    name character varying(255),
    "relatedEntityId" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "createdAtReferenceDate" timestamp with time zone NOT NULL
);


ALTER TABLE public.domain_events OWNER TO postgres;

--
-- Name: domain_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.domain_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domain_events_id_seq OWNER TO postgres;

--
-- Name: domain_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.domain_events_id_seq OWNED BY public.domain_events.id;


--
-- Name: funding_partner_benefits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funding_partner_benefits (
    "FundingPartnerId" uuid NOT NULL,
    value character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.funding_partner_benefits OWNER TO postgres;

--
-- Name: funding_partner_benefits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funding_partner_benefits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.funding_partner_benefits_id_seq OWNER TO postgres;

--
-- Name: funding_partner_benefits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funding_partner_benefits_id_seq OWNED BY public.funding_partner_benefits.id;


--
-- Name: funding_partner_saved_businesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funding_partner_saved_businesses (
    id uuid NOT NULL,
    "FundingPartnerId" uuid,
    "BusinessId" uuid,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.funding_partner_saved_businesses OWNER TO postgres;

--
-- Name: funding_partners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funding_partners (
    id uuid NOT NULL,
    "AccountId" uuid NOT NULL,
    name character varying(255),
    about text,
    "logoUrl" character varying(255),
    "websiteUrl" character varying(255),
    "isCrowdFunding" boolean DEFAULT false,
    "isDebtFunding" boolean DEFAULT false,
    "isOtherFunding" boolean DEFAULT false,
    "hasFundingOpportunities" boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.funding_partners OWNER TO postgres;

--
-- Name: ideal_matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ideal_matches (
    "businessId" uuid NOT NULL,
    "offeringId" uuid NOT NULL,
    score integer NOT NULL,
    details jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "potentialScore" integer
);


ALTER TABLE public.ideal_matches OWNER TO postgres;

--
-- Name: letter_boxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.letter_boxes (
    id integer NOT NULL,
    version character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    description jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL
);


ALTER TABLE public.letter_boxes OWNER TO postgres;

--
-- Name: letter_boxes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.letter_boxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.letter_boxes_id_seq OWNER TO postgres;

--
-- Name: letter_boxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.letter_boxes_id_seq OWNED BY public.letter_boxes.id;


--
-- Name: letters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.letters (
    id integer NOT NULL,
    "letterBoxId" integer NOT NULL,
    version character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    message text,
    attachment jsonb,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.letters OWNER TO postgres;

--
-- Name: letters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.letters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.letters_id_seq OWNER TO postgres;

--
-- Name: letters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.letters_id_seq OWNED BY public.letters.id;


--
-- Name: localizable_requirements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.localizable_requirements (
    "requirementId" uuid NOT NULL,
    "locationId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.localizable_requirements OWNER TO postgres;

--
-- Name: location_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.location_categories OWNER TO postgres;

--
-- Name: location_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.location_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_categories_id_seq OWNER TO postgres;

--
-- Name: location_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.location_categories_id_seq OWNED BY public.location_categories.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    "categoryId" integer,
    "parentId" integer,
    name character varying(255) NOT NULL,
    abbreviation character varying(255),
    "latLong" numeric(10,6)[] NOT NULL,
    "minMaxCodes" character varying(255)[] NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: offering_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offering_details (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL,
    "offeringId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.offering_details OWNER TO postgres;

--
-- Name: offering_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offering_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offering_details_id_seq OWNER TO postgres;

--
-- Name: offering_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offering_details_id_seq OWNED BY public.offering_details.id;


--
-- Name: offering_required_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offering_required_materials (
    id integer NOT NULL,
    "OfferingId" uuid NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.offering_required_materials OWNER TO postgres;

--
-- Name: offering_required_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offering_required_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offering_required_materials_id_seq OWNER TO postgres;

--
-- Name: offering_required_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offering_required_materials_id_seq OWNED BY public.offering_required_materials.id;


--
-- Name: offerings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offerings (
    id uuid NOT NULL,
    name character varying(255),
    category character varying(255),
    subcategory character varying(255),
    about text,
    "FundingPartnerId" uuid,
    "minAmount" double precision,
    "maxAmount" double precision,
    "with" character varying(255),
    "for" character varying(255),
    "interestRate" character varying(255),
    "repaymentMonths" integer,
    "targetBusiness" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "closingFee" double precision,
    "timeToFunding" character varying(255),
    "locationResumeFromRequirements" character varying(255),
    "isVisible" boolean DEFAULT true
);


ALTER TABLE public.offerings OWNER TO postgres;

--
-- Name: programs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.programs (
    id uuid NOT NULL,
    "OfferingId" uuid,
    "programType" character varying(255),
    "startDate" character varying(255),
    "endDate" character varying(255),
    timeline json,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.programs OWNER TO postgres;

--
-- Name: raw_infos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raw_infos (
    id integer NOT NULL,
    url text,
    type text,
    sent jsonb,
    received jsonb,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "relatedEntity" character varying(255) DEFAULT 'Client'::character varying NOT NULL,
    "relatedEntityId" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.raw_infos OWNER TO postgres;

--
-- Name: raw_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raw_infos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.raw_infos_id_seq OWNER TO postgres;

--
-- Name: raw_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_infos_id_seq OWNED BY public.raw_infos.id;


--
-- Name: requirements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requirements (
    id uuid NOT NULL,
    "OfferingId" uuid,
    "isStrict" boolean,
    name character varying(255),
    value character varying(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[] NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "rawValue" character varying(255)[],
    category character varying(255),
    "processingLogic" character varying(255),
    operator character varying(255),
    "isOptional" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.requirements OWNER TO postgres;

--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    "externalId" character varying(255) NOT NULL,
    "customerId" integer NOT NULL,
    items jsonb NOT NULL,
    price jsonb NOT NULL,
    status character varying(255),
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_id_seq OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: user_report_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_report_categories (
    id integer NOT NULL,
    "parentId" integer,
    name text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_report_categories OWNER TO postgres;

--
-- Name: user_report_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_report_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_report_categories_id_seq OWNER TO postgres;

--
-- Name: user_report_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_report_categories_id_seq OWNED BY public.user_report_categories.id;


--
-- Name: user_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_reports (
    id integer NOT NULL,
    "categoryId" integer,
    "rawInfoId" integer,
    version text,
    content jsonb NOT NULL,
    period timestamp with time zone[] NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "relatedEntity" character varying(255) NOT NULL,
    "relatedEntityId" character varying(255) NOT NULL,
    "isCacheable" boolean DEFAULT true
);


ALTER TABLE public.user_reports OWNER TO postgres;

--
-- Name: user_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_reports_id_seq OWNER TO postgres;

--
-- Name: user_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_reports_id_seq OWNED BY public.user_reports.id;


--
-- Name: admin_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_fields ALTER COLUMN id SET DEFAULT nextval('public.admin_fields_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: credentialSource id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."credentialSource" ALTER COLUMN id SET DEFAULT nextval('public."credentialSource_id_seq"'::regclass);


--
-- Name: credentialSourceType id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."credentialSourceType" ALTER COLUMN id SET DEFAULT nextval('public."credentialSourceType_id_seq"'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: domain_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domain_events ALTER COLUMN id SET DEFAULT nextval('public.domain_events_id_seq'::regclass);


--
-- Name: funding_partner_benefits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partner_benefits ALTER COLUMN id SET DEFAULT nextval('public.funding_partner_benefits_id_seq'::regclass);


--
-- Name: letter_boxes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letter_boxes ALTER COLUMN id SET DEFAULT nextval('public.letter_boxes_id_seq'::regclass);


--
-- Name: letters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letters ALTER COLUMN id SET DEFAULT nextval('public.letters_id_seq'::regclass);


--
-- Name: location_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_categories ALTER COLUMN id SET DEFAULT nextval('public.location_categories_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: offering_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offering_details ALTER COLUMN id SET DEFAULT nextval('public.offering_details_id_seq'::regclass);


--
-- Name: offering_required_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offering_required_materials ALTER COLUMN id SET DEFAULT nextval('public.offering_required_materials_id_seq'::regclass);


--
-- Name: raw_infos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_infos ALTER COLUMN id SET DEFAULT nextval('public.raw_infos_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: user_report_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_report_categories ALTER COLUMN id SET DEFAULT nextval('public.user_report_categories_id_seq'::regclass);


--
-- Name: user_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_reports ALTER COLUMN id SET DEFAULT nextval('public.user_reports_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20220610155854-create-account.js
20220624193943-create-funding-partner.js
20220629204319-create-demographic.js
20220711211208-create-offering.js
20220711213251-create-business.js
20220711213644-create-business-saved-offering.js
20220711224209-create-application.js
20220712044114-create-program.js
20220712045002-create-requirement.js
20220715194646-LoanDetailsToJson.js
20220719202348-create-funding-partner-saved-business.js
20220727220722-UpdateFPAboutColType.js
20220811214736-add-origin-to-account.js
20220825143345-create-ideal-matches-table.js
20220915190344-add-external-id-to-account.js
20220924001905-add-ideal-match-seek-indexes.js
20220927190021-add-account-index-to-business-table.js
20221003110101-add-funding-journey-to-business.js
20221004162222-add-raw-city-to-business.js
20221004183804-change-target-funding-amount-to-string-array.js
20221004202058-add-raw-value-into-requirements.js
20221006032652-create-admin-fields.js
20221007151239-add-discover-column.js
20221010171608-add-phone-number-column-to-account.js
20221012181835-add-requirement-values-as-not-null.js
20221012201929-amp-465-add-category-processing-logic-columns.js
20221012214247-offering-ux-phase-2.js
20221013034510-create-funding-partner-benefit.js
20221013040226-create-offering-required-material.js
20221013183459-amp-470-add-offering-location.js
20221017162044-change-admin-field-value-to-text.js
20221018042844-change-fp-benefit-id-type.js
20221019161352-add-unique-constraint-businessId-offeringId-application.js
20221019164756-change-application-details-to-jsonb.js
20221024230204-add-retool-user-to-admin-field.js
20221024232318-add-deletedAt-column-to-adminfields.js
20221026194904-add-utm-params-to-account.js
20221116042541-create-offering-details.js
20221118221610-add-referral-partner-to-account.js
20221119011215-bags-570-create-initial-debt-management-entities.js
20221212223354-adds-funding-partner-benefit-id-as-unique.js
20230103221200-bags-619-adds-offerings-visibility.js
20230118205622-create-document.js
20230206192801-add-created-by-email-to-documents.js
20230208195440-bags-691-add-institution-id-to-clients.js
20230216050826-add-status-document.js
20230216053642-add-category-to-admin-fields.js
20230221215509-add-origin-to-document.js
20230222-update-related-entity-id-from-uuid-to-string.js
20230223-create-related-entity-column-to-admin-fields-table.js
20230227142246-bags-738-create-location-tables.js
20230404210027-bags-915-adds-origin-to-client.js
202304051125-bags-906-create-and-fill-related-entity-columns-with-client.js
20230405133851-bags-915-remove-default-constraint-from-client-origin.js
20230405181559-bags-923-add-external-id-to-client.js
20230412182932-remove-client-fk-in-raw-info.js
20230412193616-remove-client-id-column.js
20230501162144-bags-1002-add-on-delete-cascade-to-account-id-fk-in-businesses.js
20230512190142-bags-1059-add-context-to-client-entity.js
20230512211336-create-accepted-sms-at.js
20230531161446-make-phone-optional.js
20230602060948-bags-1081-add-mime-type-to-document.js
20230627230749-add-utm-content-and-campaign-id-to-account.js
20230629191044-update-business-demographics-wrt-new-onboarding.js
20230630210110-bags-1168-improve-user-report-data-add-related-entity.js
20230711192424-bags-1186-rename-thisYear-to-trailingThreeMonth.js
20230721212357-bags-1222-convert-ttmr-to-big-int.js
20230725220141-bags-1226-add-email-index-to-accounts.js
20230815183921-bags-811-add-potentialscore-ideal-match.js
20230912014948-create-domain-events-table.js
20230913210144-bags-1278-add-failure-counter-and-status-to-client.js
20230920213347-rename-related-entity-to-name.js
20230920213351-remove-related-entity-column-from-domain-event.js
20230927211022-bags-1278-add-is-cacheable-to-user-report.js
20231006182254-bags-1366-add-operator-to-requirement.js
20231009174431-add-pk-constraint-to-localizable-requirement.js
20231023223652-bags-1408-create-letter-box-and-letter.js
20231024204343-bags-1408-add-letter-box-updated-at-trigger.js
20231101044609-redo_customer_table.js
20231128084718-redo_subscription_table.js
20231215212807-bags-1474-add-on-delete-cascade-to-localizable-requirements.js
20231220174621-bags-1478-add-status-to-letterbox.js
20231222185519-bags-1487-add-customer-churnedat.js
20240112195751-remove-rawCity-from-businesses.js
20240116164928-bags-1507-remove-applications.js
20240125162707-bags-1507-add-index-to-application-business-offering.js
20240312192900-bags-1573-add-letter-type-index.js
20240409202114-bags-1587-standardize-document-origin.js
20240411220903-bags-1591-increase-letter-limit-to-ensure-safety-for-use-case.js
20240424175909-bags-1608-add-shareholder-info-to-business.js
20240425175909-adding-credential.js
20240520194336-populating-credential-sources.js
20240524150545-bags-1631-add-is-optional-to-requirement.js
20240607133938-seed-more-credential-sources.js
20240612222625-fixing-monthly-metrics.js
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, "firstName", "lastName", email, "imageUrl", "accountType", "profileUrl", about, "createdAt", "updatedAt", origin, "externalId", discover, phone, "utmSource", "utmCampaign", "utmMedium", "referralPartner", "acceptedSmsAt", "utmContent", "utmCampaignId") FROM stdin;
9c65cfdb-1b33-4722-8239-068a9b0b030f	Test	User	test@test22.com	\N	\N	\N	\N	2024-06-18 04:02:07.382973+00	2024-06-18 04:02:07.376+00	http://localhost:3000	auth0|667106ad5fde06d5ff22718a	Instagram	(212) 445-0101	\N	\N	\N	\N	2024-06-18 04:02:01.18+00	\N	\N
\.


--
-- Data for Name: admin_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_fields (id, name, value, "relatedEntityId", "createdAt", "updatedAt", "user", "deletedAt", category, "relatedEntity") FROM stdin;
\.


--
-- Data for Name: business_saved_offerings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_saved_offerings (id, "OfferingId", "BusinessId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: businesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.businesses (id, "AccountId", name, city, state, country, "websiteUrl", "logoUrl", "incorporatedAt", "productType", category, subcategory, about, "instagramHandle", "linkedinHandle", "twitterHandle", "tiktokHandle", "isFamiliarWithCdfi", "isFamiliarWithRvb", "hasPreviousOffering", "targetFundingAmount", "targetRepaymentYearsMax", "isFundsForGrowth", "useOfFunds", "isFundingReadinessComplete", "lastMonthRevenue", "monthlyRecurringRevenue", "lastMonthExpenses", "creditScore", "percentSalesOnline", "guaranteeAmount", "businessGoal", "createdAt", "updatedAt", "fundingJourney", "locationId", "incorporationType", industry, type, "lastYearRevenue", "lastYearProfit", "trailingThreeMonthRevenue", "trailingThreeMonthProfit", "outstandingPurchaseOrders", "outstandingAccountsReceivable", "totalAmountInGovernmentContracts", "numberOfLoans", "totalAmountInLoans", "targetLoanAmount", "growthMotivation", "loanMotivation", "loanTimeframe", "lastBankruptcyDate", "shareholderInfo") FROM stdin;
8f644fef-e029-4ded-bf3b-fe74ac7a4ac1	9c65cfdb-1b33-4722-8239-068a9b0b030f	Test02	New York	NY	USA	\N	\N	2020-11-01 00:00:00+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	612	\N	\N	\N	2024-06-18 04:02:07.412+00	2024-06-18 04:02:07.412+00	\N	\N	Sole Proprietorship	Food	{"Consumer Packaged Goods"}	1231231	500000	200000	45000	0	0	0	0	0	500000	{"Make enough money to run my business full time"}	{"Buy equipment"}	{60}	\N	{"shareholders": [{"address": "New York, NY, USA", "fullName": "ASDasd", "ownership": {"percentage": 123, "sharesAmount": 1}, "taxOrSocialId": "123123"}], "authorizedSignatory": {"fullName": "1", "designation": "1", "taxOrSocialId": "1"}}
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, "accountId", "accessToken", "itemId", "createdAt", "updatedAt", "institutionId", origin, "externalId", context, "totalOfFailures", status) FROM stdin;
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, "businessId", "credentialSourceId", description, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: credentialSource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."credentialSource" (id, name, "credentialSourceTypeId", "imageUrl", "createdAt", "updatedAt") FROM stdin;
1	WSFS Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
2	Wintrust Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
3	Western Alliance Bancorporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
4	Wells Fargo	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
5	Webster Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
6	WAFD	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
7	Valley Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
8	USAA	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
9	United Community Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
10	United Bank (West Virginia)	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
11	UMB Financial Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
12	UBS	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
13	U.S. Bancorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
14	Truist Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
15	The Bank of New York Mellon	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
16	Texas Capital Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
17	TD Bank, N.A.	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
18	Synovus	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
19	Synchrony Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
20	Sumitomo Mitsui Banking Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
21	Stifel	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
22	State Street Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
23	South State Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
24	SoFi	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
25	Simmons Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
26	Santander Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
27	Regions Financial Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
28	RBC Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
29	Raymond James Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
30	Prosperity Bancshares	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
31	Popular, Inc.	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
32	PNC Financial Services	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
33	Pinnacle Financial Partners	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
34	Pinnacle Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
35	Pacific Premier Bancorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
36	Old National Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
37	Northern Trust	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
38	New York Community Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
39	Morgan Stanley	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
40	Mizuho Financial Group	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
41	Midland	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
42	M&T Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
43	KeyCorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
44	JPMorgan Chase	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
45	John Deere	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
46	Independent Bank Group, Inc.	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
47	Independent Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
48	Huntington Bancshares	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
49	HTLF Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
50	HSBC Bank USA	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
51	Hope Bancorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
52	Home BancShares	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
53	Hancock Whitney	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
54	Goldman Sachs	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
55	Glacier Bancorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
56	Fulton Financial Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
57	FNB Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
58	FirstBank Holding Co	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
59	First National of Nebraska	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
60	First Interstate BancSystem	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
61	First Horizon National Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
62	First Hawaiian Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
63	First Citizens BancShares	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
64	Fifth Third Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
65	EverBank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
66	Eastern Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
67	East West Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
68	Discover Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
69	Deutsche Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
70	Customers Bancorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
71	Cullen/Frost Bankers, Inc.	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
72	Credit Suisse[a]	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
73	Commerce Bancshares	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
74	Comerica	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
75	Columbia Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
76	Citizens Financial Group	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
77	Citigroup	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
78	CIBC Bank USA	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
79	Charles Schwab Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
80	Central Bancompany, Inc.	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
81	Cathay Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
82	Capital One	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
83	BOK Financial Corporation	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
84	BNP Paribas	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
85	BMO USA	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
86	Beal Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
87	BCI Financial Group	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
88	Barclays	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
89	BankUnited	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
90	Bank of Hawaii	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
91	Bank of America	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
92	Banc of California, Inc.[7]	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
93	Axos Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
94	Atlantic Union Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
95	Associated Banc-Corp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
96	Arvest Bank	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
97	Ameris Bancorp	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
98	Ameriprise	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
99	American Express	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
100	Ally Financial	1		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
101	QuickBooks	2		2024-06-12 21:49:08.338688+00	2024-06-12 21:49:08.338688+00
102	SVB (Silicon Valley Bank)	1		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
103	VyStar Credit Union	1		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
104	1st Century Bank	1		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
105	Navy Federal Credit Union	1		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
106	Novo	1		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
107	Fremont Bank	1		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
108	Ramp	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
109	Mercury	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
110	Square	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
111	Paypal	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
112	Klarna	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
113	Stripe	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
114	Brex	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
115	Wise	3		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
116	Mainstreet	4		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
117	Finaloop	4		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
118	Bill.com	4		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
119	Rho	4		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
120	Rippling	4		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
121	Xero	4		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
122	Amazon Business	5		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
123	Walmart	5		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
124	Kroger	5		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
125	Sellercentral	5		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
126	ADP	6		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
127	Onpay	6		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
128	Rippling	6		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
129	Margin Edge	7		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
130	Sumtracker	7		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
131	Dropbox-Accounting	8		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
132	LastPass	8		2024-06-12 21:49:08.366558+00	2024-06-12 21:49:08.366558+00
\.


--
-- Data for Name: credentialSourceType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."credentialSourceType" (id, name, "createdAt", "updatedAt") FROM stdin;
1	Bank	2024-06-12 21:49:08.336662+00	2024-06-12 21:49:08.336662+00
2	Accounting	2024-06-12 21:49:08.336662+00	2024-06-12 21:49:08.336662+00
3	Payment Processors and Financial Technology	2024-06-12 21:49:08.365545+00	2024-06-12 21:49:08.365545+00
4	Accounting and Expense Management	2024-06-12 21:49:08.365545+00	2024-06-12 21:49:08.365545+00
5	E-commerce and Retail	2024-06-12 21:49:08.365545+00	2024-06-12 21:49:08.365545+00
6	Payroll and Human Resources	2024-06-12 21:49:08.365545+00	2024-06-12 21:49:08.365545+00
7	Expense and Inventory Management:	2024-06-12 21:49:08.365545+00	2024-06-12 21:49:08.365545+00
8	Software and Cloud Services	2024-06-12 21:49:08.365545+00	2024-06-12 21:49:08.365545+00
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, "accountId", "externalId", provider, "createdAt", "updatedAt", "churnedAt") FROM stdin;
\.


--
-- Data for Name: demographics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.demographics (id, "AccountId", birthday, "isBlack", "isLgbtq", "isFemale", "isMilitary", "isDisabled", "isVeteran", "createdAt", "updatedAt", "genderIdentity", "raceAndEthnicity", "educationalLevel", "dateOfBirth", "hasDisability", "isLgbtPlus", "isMilitaryOrVeteran") FROM stdin;
0dbb0845-8f65-47ee-b4b2-0f8582699a86	9c65cfdb-1b33-4722-8239-068a9b0b030f	\N	\N	\N	\N	\N	\N	\N	2024-06-18 04:02:07.405+00	2024-06-18 04:02:07.405+00	Woman	{Asian}	PHD or Master's Degree	1990-01-01	f	t	f
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, "accountId", type, path, "createdAt", "updatedAt", "createdByEmail", status, origin, "mimeType") FROM stdin;
\.


--
-- Data for Name: domain_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.domain_events (id, value, version, name, "relatedEntityId", "createdAt", "createdAtReferenceDate") FROM stdin;
1	{"id": "9c65cfdb-1b33-4722-8239-068a9b0b030f", "email": "test@test22.com", "phone": "(212) 445-0101", "origin": "http://localhost:3000", "discover": "Instagram", "lastName": "User", "createdAt": "2024-06-18T04:02:07.382Z", "firstName": "Test", "updatedAt": "2024-06-18T04:02:07.376Z", "externalId": "auth0|667106ad5fde06d5ff22718a", "acceptedSmsAt": "2024-06-18T04:02:01.180Z"}	v1.0.0	AccountCreated	\N	2024-06-18 04:02:07.424+00	2024-06-18 04:02:07.376+00
2	{"id": "8f644fef-e029-4ded-bf3b-fe74ac7a4ac1", "city": "New York", "name": "Test02", "type": ["Consumer Packaged Goods"], "state": "NY", "country": "USA", "industry": "Food", "AccountId": "9c65cfdb-1b33-4722-8239-068a9b0b030f", "createdAt": "2024-06-18T04:02:07.412Z", "updatedAt": "2024-06-18T04:02:07.412Z", "creditScore": 612, "loanTimeframe": [60], "numberOfLoans": 0, "incorporatedAt": "2020-11-01T00:00:00.000Z", "lastYearProfit": 500000, "loanMotivation": ["Buy equipment"], "lastYearRevenue": 1231231, "shareholderInfo": {"shareholders": [{"address": "New York, NY, USA", "fullName": "ASDasd", "ownership": {"percentage": 123, "sharesAmount": 1}, "taxOrSocialId": "123123"}], "authorizedSignatory": {"fullName": "1", "designation": "1", "taxOrSocialId": "1"}}, "growthMotivation": ["Make enough money to run my business full time"], "targetLoanAmount": 500000, "incorporationType": "Sole Proprietorship", "lastBankruptcyDate": null, "totalAmountInLoans": 0, "trailingThreeMonthProfit": 45000, "outstandingPurchaseOrders": 0, "trailingThreeMonthRevenue": 200000, "outstandingAccountsReceivable": 0, "totalAmountInGovernmentContracts": 0}	v1.0.0	BusinessCreated	\N	2024-06-18 04:02:07.425+00	2024-06-18 04:02:07.412+00
\.


--
-- Data for Name: funding_partner_benefits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funding_partner_benefits ("FundingPartnerId", value, "createdAt", "updatedAt", id) FROM stdin;
\.


--
-- Data for Name: funding_partner_saved_businesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funding_partner_saved_businesses (id, "FundingPartnerId", "BusinessId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: funding_partners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funding_partners (id, "AccountId", name, about, "logoUrl", "websiteUrl", "isCrowdFunding", "isDebtFunding", "isOtherFunding", "hasFundingOpportunities", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: ideal_matches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ideal_matches ("businessId", "offeringId", score, details, "createdAt", "updatedAt", "potentialScore") FROM stdin;
\.


--
-- Data for Name: letter_boxes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.letter_boxes (id, version, type, description, "createdAt", "updatedAt", status) FROM stdin;
422	v1.0.0	collection	{"name": "headlineMetrics", "relatedEntityId": "9247fd86-8d8e-4496-bda8-f3515008532b"}	2024-04-11 15:57:57.36+00	2024-06-12 22:02:43.729475+00	active
423	v1.0.0	collection	{"name": "headlineMetrics", "relatedEntityId": "7733c6c5-2a3e-4a9e-833e-3b1edc355bfa"}	2024-04-11 17:52:08.951+00	2024-06-12 22:02:43.729475+00	active
430	v1.0.0	collection	{"name": "testFinancialSummary", "relatedEntityId": "7733c6c5-2a3e-4a9e-833e-3b1edc355bfa"}	2024-04-12 12:58:21.798+00	2024-06-12 22:02:43.729475+00	active
432	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "7733c6c5-2a3e-4a9e-833e-3b1edc355bfa"}	2024-04-15 09:54:34.237+00	2024-06-12 22:02:43.729475+00	active
433	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "0776e9ea-f251-49c7-a4aa-586c0c508c65"}	2024-04-15 18:07:00.586+00	2024-06-12 22:02:43.729475+00	active
434	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "db745ffd-8e94-4ddc-884d-9f34a9a4396d"}	2024-04-15 18:54:10.683+00	2024-06-12 22:02:43.729475+00	active
435	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "eda1369c-dde1-4204-8613-5f777f989b77"}	2024-04-15 19:02:28.555+00	2024-06-12 22:02:43.729475+00	active
436	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "671a3294-b87a-4e2a-9d29-4279279ff92d"}	2024-04-16 10:32:42.58+00	2024-06-12 22:02:43.729475+00	active
437	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "25d977a6-d229-48ae-995f-e322d0bb29fa"}	2024-04-16 11:40:47.049+00	2024-06-12 22:02:43.729475+00	active
454	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "445"}	2024-04-29 13:32:29.168+00	2024-06-12 22:02:43.729475+00	active
463	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "8ec9a46a-7d71-4444-a57e-7c776ddaa092"}	2024-04-30 22:03:14.893+00	2024-06-12 22:02:43.729475+00	active
464	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "f42a11bf-5423-445f-8dfa-4319b4430504"}	2024-04-30 22:20:44.797+00	2024-06-12 22:02:43.729475+00	active
465	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "fc66b42b-7c42-4c1c-98ea-ac1567732f1c"}	2024-04-30 22:26:53.47+00	2024-06-12 22:02:43.729475+00	active
467	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "a4261fd2-cebf-4b64-8727-ada9f75eb977"}	2024-04-30 22:35:06.091+00	2024-06-12 22:02:43.729475+00	active
466	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "40c8390b-b6c0-4c7d-8d7c-7f5fa440b918"}	2024-04-30 22:28:40.62+00	2024-06-12 22:02:43.729475+00	active
501	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "4ee561fd-b2b9-4d98-9b5a-ca4c2db0202b"}	2024-05-16 03:23:35.361+00	2024-06-12 22:02:43.729475+00	active
442	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "2ad951dd-917f-4949-b090-5fec6069b8ad"}	2024-04-17 14:59:40.145+00	2024-06-12 22:02:43.729475+00	active
502	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "d6db9fcf-72e2-4c28-b93a-fe78e3f16bb5"}	2024-05-16 03:29:24.272+00	2024-06-12 22:02:43.729475+00	active
503	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "815e36a1-da3b-4df3-b1fa-af8a885d15f2"}	2024-05-17 00:07:36.206+00	2024-06-12 22:02:43.729475+00	active
504	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "52d865c1-43a7-421f-85f6-9f59db723bed"}	2024-05-17 18:15:11.671+00	2024-06-12 22:02:43.729475+00	active
513	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "0b68af88-be8f-4842-aee6-2745b2bcd2b9"}	2024-06-10 20:42:52.575+00	2024-06-12 22:02:43.729475+00	active
438	v1.0.0	collection	{"name": "financialSummary", "relatedEntityId": "5866933b-3158-4031-a8bc-01a7e5ec1baa"}	2024-04-16 12:48:27.788+00	2024-06-12 22:02:43.729475+00	active
\.


--
-- Data for Name: letters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.letters (id, "letterBoxId", version, type, message, attachment, "createdAt", "updatedAt") FROM stdin;
438	504	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 54452.13, "revenue": 104952.81, "netIncome": 369583.75}}	2024-06-11 10:02:31.581+00	2024-06-11 10:02:31.581+00
439	504	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": -78488.38, "revenue": -32917.61, "netIncome": 0}}	2024-06-11 10:09:54.107+00	2024-06-11 10:09:54.107+00
440	504	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-06-11 10:09:56.082+00	2024-06-11 10:09:56.082+00
443	503	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": -23502.15, "revenue": 11579.08, "netIncome": 19394.84}}	2024-06-11 10:19:53.072+00	2024-06-11 10:19:53.072+00
444	503	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": -44389.32, "revenue": 13216.23, "netIncome": 29415.17}}	2024-06-11 10:21:21.994+00	2024-06-11 10:21:21.994+00
441	504	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": -42254.06, "revenue": 9528.85, "netIncome": 154319.8}}	2024-06-11 10:11:03.309+00	2024-06-11 10:11:03.309+00
442	504	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 43312.88, "revenue": 110099.69, "netIncome": 269447.5}}	2024-06-11 10:11:50.837+00	2024-06-11 10:11:50.837+00
445	503	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 5804.68, "revenue": 8241.61, "netIncome": 30039.34}}	2024-06-11 10:22:36.407+00	2024-06-11 10:22:36.407+00
446	503	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -43522.01, "revenue": -3172.68, "netIncome": 11394.43}}	2024-06-11 10:24:30.626+00	2024-06-11 10:24:30.626+00
447	502	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 8431, "revenue": 15912.51, "netIncome": 22668.89}}	2024-06-11 10:34:02.089+00	2024-06-11 10:34:02.089+00
448	502	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-06-11 10:34:03.177+00	2024-06-11 10:34:03.177+00
449	502	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 11656.61, "revenue": 18500.15, "netIncome": 25893.14}}	2024-06-11 10:34:30.475+00	2024-06-11 10:34:30.475+00
450	502	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": -3288.74, "revenue": 8615.5, "netIncome": 12283.66}}	2024-06-11 10:35:18.496+00	2024-06-11 10:35:18.496+00
451	502	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 6265.41, "revenue": 15460.28, "netIncome": 22180.51}}	2024-06-11 10:36:05.884+00	2024-06-11 10:36:05.884+00
453	501	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 9477.55, "revenue": 22447.17, "netIncome": 30806.89}}	2024-06-11 10:44:49.418+00	2024-06-11 10:44:49.418+00
456	466	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 1765.73, "revenue": 5053, "netIncome": 5053.19}}	2024-06-11 10:50:38.224+00	2024-06-11 10:50:38.224+00
457	466	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 1387.17, "revenue": 4522.5, "netIncome": 4522.5}}	2024-06-11 10:50:58.927+00	2024-06-11 10:50:58.927+00
458	466	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 3591.74, "revenue": 7562.95, "netIncome": 7562.95}}	2024-06-11 10:51:31.77+00	2024-06-11 10:51:31.77+00
277	422	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": null, "revenue": null, "netIncome": null}}	2024-04-11 17:33:18.313+00	2024-04-11 17:33:18.313+00
278	423	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": null, "revenue": null, "netIncome": null}}	2024-04-11 17:52:52.298+00	2024-04-11 17:52:52.298+00
279	423	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": null, "revenue": null, "netIncome": null}}	2024-04-11 17:54:38.64+00	2024-04-11 17:54:38.64+00
459	466	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 8894.63, "revenue": 23493.64, "netIncome": 23493.64}}	2024-06-11 10:52:00.711+00	2024-06-11 10:52:00.711+00
472	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 3, "revenue": 2, "netIncome": 1}}	2024-06-11 20:02:14.246+00	2024-06-11 20:02:14.246+00
295	430	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 150000, "revenue": 75000, "netIncome": 100000}}	2024-04-12 13:05:38.619+00	2024-04-12 13:05:38.619+00
296	430	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 150000, "revenue": 75000, "netIncome": 100000}}	2024-04-12 13:05:49.057+00	2024-04-12 13:05:49.057+00
297	432	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 150000, "revenue": 75000, "netIncome": 100000}}	2024-04-15 09:54:34.349+00	2024-04-15 09:54:34.349+00
298	432	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 140000, "revenue": 8000, "netIncome": 90000}}	2024-04-15 09:55:08.516+00	2024-04-15 09:55:08.516+00
299	432	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 130000, "revenue": 7000, "netIncome": 80000}}	2024-04-15 09:55:31.976+00	2024-04-15 09:55:31.976+00
300	433	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 130000, "revenue": 7000, "netIncome": 80000}}	2024-04-15 18:07:00.718+00	2024-04-15 18:07:00.718+00
301	433	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-04-15 18:42:29.55+00	2024-04-15 18:42:29.55+00
302	434	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-04-15 18:54:10.84+00	2024-04-15 18:54:10.84+00
303	434	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-04-15 18:54:12.542+00	2024-04-15 18:54:12.542+00
304	434	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-04-15 18:57:50.852+00	2024-04-15 18:57:50.852+00
305	435	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-04-15 19:02:28.676+00	2024-04-15 19:02:28.676+00
306	436	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-04-16 10:32:42.629+00	2024-04-16 10:32:42.629+00
307	437	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 5000, "revenue": 400, "netIncome": 150}}	2024-04-16 11:40:47.084+00	2024-04-16 11:40:47.084+00
308	438	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 130000, "revenue": 7000, "netIncome": 80000}}	2024-04-16 12:48:27.82+00	2024-04-16 12:48:27.82+00
309	438	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 140000, "revenue": 8000, "netIncome": 100000}}	2024-04-16 12:48:48.451+00	2024-04-16 12:48:48.451+00
311	442	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 18726.57, "revenue": 27813.11, "netIncome": 27813.11}}	2024-04-17 14:59:40.188+00	2024-04-17 14:59:40.188+00
320	438	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2023-02", "metrics": {"profit": 140000, "revenue": 8000, "netIncome": 100000}}	2024-04-26 09:29:17.577+00	2024-04-26 09:29:17.577+00
321	454	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2023-02", "metrics": {"profit": 140000, "revenue": 8000, "netIncome": 100000}}	2024-04-29 13:32:29.243+00	2024-04-29 13:32:29.243+00
353	463	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 4450.41, "revenue": 13795.6, "netIncome": 14718.7}}	2024-04-30 22:03:14.931+00	2024-04-30 22:03:14.931+00
354	463	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 4450.41, "revenue": 9961.96, "netIncome": 13795.6}}	2024-04-30 22:15:32.146+00	2024-04-30 22:15:32.146+00
355	464	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": -679.48, "revenue": 2050.8, "netIncome": 3482.71}}	2024-04-30 22:20:44.842+00	2024-04-30 22:20:44.842+00
356	465	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": -850.36, "revenue": 1390.42, "netIncome": 1390.42}}	2024-04-30 22:26:53.509+00	2024-04-30 22:26:53.509+00
357	466	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 3546.58, "revenue": 6010.95, "netIncome": 6010.95}}	2024-04-30 22:28:40.643+00	2024-04-30 22:28:40.643+00
358	467	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 1539.36, "revenue": 1539.36, "netIncome": 2007.08}}	2024-04-30 22:35:06.12+00	2024-04-30 22:35:06.12+00
378	438	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2023-12", "metrics": {"profit": 400, "revenue": 100, "netIncome": 500}}	2024-05-10 12:15:27.898+00	2024-05-10 12:15:27.898+00
403	466	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 2150, "revenue": 6355, "netIncome": 6355}}	2024-05-15 14:13:50.956+00	2024-05-15 14:13:50.956+00
405	501	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 25197, "revenue": 33873, "netIncome": 37926}}	2024-05-16 03:23:35.399+00	2024-05-16 03:23:35.399+00
406	442	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -28716, "revenue": 8353, "netIncome": 23378}}	2024-05-16 03:26:25.131+00	2024-05-16 03:26:25.131+00
407	502	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 6912, "revenue": 15460, "netIncome": 22180}}	2024-05-16 03:29:24.303+00	2024-05-16 03:29:24.303+00
408	503	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -40000, "revenue": -3120, "netIncome": 18386}}	2024-05-17 00:07:36.251+00	2024-05-17 00:07:36.251+00
409	503	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-05-17 00:11:30.265+00	2024-05-17 00:11:30.265+00
410	504	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 101126, "revenue": 171031, "netIncome": 269447}}	2024-05-17 18:15:11.72+00	2024-05-17 18:15:11.72+00
431	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -2794.14, "revenue": 18263.65, "netIncome": 25813.74}}	2024-06-10 20:42:52.622+00	2024-06-10 20:42:52.622+00
432	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": -1681.35, "revenue": 10712.09, "netIncome": 19064.44}}	2024-06-10 20:44:46.612+00	2024-06-10 20:44:46.612+00
433	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": -2794.14, "revenue": 18263.65, "netIncome": 25813.74}}	2024-06-10 20:45:46.943+00	2024-06-10 20:45:46.943+00
434	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -1681.35, "revenue": 10712.09, "netIncome": 19064.44}}	2024-06-10 20:47:09.506+00	2024-06-10 20:47:09.506+00
436	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": -3706.43, "revenue": 19773.23, "netIncome": 35956.1}}	2024-06-10 20:51:03.047+00	2024-06-10 20:51:03.047+00
435	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 9096.33, "revenue": 23616.61, "netIncome": 35345.77}}	2024-06-10 20:49:25.225+00	2024-06-10 20:49:25.225+00
452	501	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": 3231.55, "revenue": 9945.49, "netIncome": 19495.93}}	2024-06-11 10:40:46.743+00	2024-06-11 10:40:46.743+00
454	501	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": 12688.18, "revenue": 26842.94, "netIncome": 34791.35}}	2024-06-11 10:45:52.567+00	2024-06-11 10:45:52.567+00
455	501	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": 26049.1, "revenue": 34724.46, "netIncome": 38996.73}}	2024-06-11 10:46:53.506+00	2024-06-11 10:46:53.506+00
437	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": -8747.76, "revenue": 9095.72, "netIncome": 25521.54}}	2024-06-10 20:54:07.975+00	2024-06-10 20:54:07.975+00
276	422	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": null, "revenue": null, "netIncome": null}}	2024-04-11 16:03:05.155+00	2024-04-11 16:03:05.155+00
461	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": -2795.14, "revenue": 18263.65, "netIncome": 25813.74}}	2024-06-11 19:47:19.056+00	2024-06-11 19:47:19.056+00
462	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": 0, "revenue": 0, "netIncome": 0}}	2024-06-11 19:49:39.016+00	2024-06-11 19:49:39.016+00
463	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": -2794.14, "revenue": 18263.65, "netIncome": 25813.74}}	2024-06-11 19:54:16.964+00	2024-06-11 19:54:16.964+00
464	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -2794.14, "revenue": 18263.65, "netIncome": 25813.74}}	2024-06-11 19:56:33.161+00	2024-06-11 19:56:33.161+00
465	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": -1681.35, "revenue": 10712.09, "netIncome": 19064.44}}	2024-06-11 19:56:55.269+00	2024-06-11 19:56:55.269+00
466	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 9096.33, "revenue": 23616.61, "netIncome": 35345.77}}	2024-06-11 19:57:50.829+00	2024-06-11 19:57:50.829+00
467	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": -3706.43, "revenue": 19773.23, "netIncome": 35956.1}}	2024-06-11 19:58:05.661+00	2024-06-11 19:58:05.661+00
468	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-01", "metrics": {"profit": -3706.43, "revenue": 19773.23, "netIncome": 35956.1}}	2024-06-11 19:58:30.369+00	2024-06-11 19:58:30.369+00
469	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-02", "metrics": {"profit": 9096.33, "revenue": 23616.61, "netIncome": 35345.77}}	2024-06-11 19:58:51.126+00	2024-06-11 19:58:51.126+00
470	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-03", "metrics": {"profit": -1681.35, "revenue": 10712.09, "netIncome": 19064.44}}	2024-06-11 19:59:07.709+00	2024-06-11 19:59:07.709+00
471	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -2794.14, "revenue": 18263.65, "netIncome": 25813.74}}	2024-06-11 19:59:31.902+00	2024-06-11 19:59:31.902+00
473	513	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-04", "metrics": {"profit": -3, "revenue": -2, "netIncome": -1}}	2024-06-11 20:04:34.215+00	2024-06-11 20:04:34.215+00
474	438	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": 3, "revenue": -2, "netIncome": 1}}	2024-06-11 20:05:46.657+00	2024-06-11 20:05:46.657+00
475	438	v1.0.0	collection_item/monthly_metrics	\N	{"date": "2024-05", "metrics": {"profit": 500000, "revenue": 15000, "netIncome": 100000}}	2024-06-12 15:35:51.379+00	2024-06-12 15:35:51.379+00
\.


--
-- Data for Name: localizable_requirements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.localizable_requirements ("requirementId", "locationId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: location_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location_categories (id, name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, "categoryId", "parentId", name, abbreviation, "latLong", "minMaxCodes", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: offering_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offering_details (id, name, value, "offeringId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: offering_required_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offering_required_materials (id, "OfferingId", name, value, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: offerings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offerings (id, name, category, subcategory, about, "FundingPartnerId", "minAmount", "maxAmount", "with", "for", "interestRate", "repaymentMonths", "targetBusiness", "createdAt", "updatedAt", "closingFee", "timeToFunding", "locationResumeFromRequirements", "isVisible") FROM stdin;
\.


--
-- Data for Name: programs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.programs (id, "OfferingId", "programType", "startDate", "endDate", timeline, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: raw_infos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.raw_infos (id, url, type, sent, received, "createdAt", "updatedAt", "relatedEntity", "relatedEntityId") FROM stdin;
\.


--
-- Data for Name: requirements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requirements (id, "OfferingId", "isStrict", name, value, "createdAt", "updatedAt", "rawValue", category, "processingLogic", operator, "isOptional") FROM stdin;
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (id, "externalId", "customerId", items, price, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: user_report_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_report_categories (id, "parentId", name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: user_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_reports (id, "categoryId", "rawInfoId", version, content, period, "createdAt", "updatedAt", "relatedEntity", "relatedEntityId", "isCacheable") FROM stdin;
\.


--
-- Name: admin_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_fields_id_seq', 1, false);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- Name: credentialSourceType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."credentialSourceType_id_seq"', 8, true);


--
-- Name: credentialSource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."credentialSource_id_seq"', 132, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- Name: domain_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.domain_events_id_seq', 2, true);


--
-- Name: funding_partner_benefits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funding_partner_benefits_id_seq', 1, false);


--
-- Name: letter_boxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.letter_boxes_id_seq', 1, false);


--
-- Name: letters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.letters_id_seq', 1, false);


--
-- Name: location_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.location_categories_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, false);


--
-- Name: offering_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offering_details_id_seq', 1, false);


--
-- Name: offering_required_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offering_required_materials_id_seq', 1, false);


--
-- Name: raw_infos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.raw_infos_id_seq', 1, false);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 1, false);


--
-- Name: user_report_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_report_categories_id_seq', 1, false);


--
-- Name: user_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_reports_id_seq', 1, false);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: admin_fields admin_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_fields
    ADD CONSTRAINT admin_fields_pkey PRIMARY KEY (id);


--
-- Name: business_saved_offerings business_saved_offerings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_saved_offerings
    ADD CONSTRAINT business_saved_offerings_pkey PRIMARY KEY (id);


--
-- Name: businesses businesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.businesses
    ADD CONSTRAINT businesses_pkey PRIMARY KEY (id);


--
-- Name: clients clients_externalId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT "clients_externalId_key" UNIQUE ("externalId");


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: credentialSourceType credentialSourceType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."credentialSourceType"
    ADD CONSTRAINT "credentialSourceType_pkey" PRIMARY KEY (id);


--
-- Name: credentialSource credentialSource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."credentialSource"
    ADD CONSTRAINT "credentialSource_pkey" PRIMARY KEY (id);


--
-- Name: credential credential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT credential_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: demographics demographics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demographics
    ADD CONSTRAINT demographics_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: domain_events domain_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domain_events
    ADD CONSTRAINT domain_events_pkey PRIMARY KEY (id);


--
-- Name: funding_partner_saved_businesses funding_partner_saved_businesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partner_saved_businesses
    ADD CONSTRAINT funding_partner_saved_businesses_pkey PRIMARY KEY (id);


--
-- Name: funding_partners funding_partners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partners
    ADD CONSTRAINT funding_partners_pkey PRIMARY KEY (id);


--
-- Name: ideal_matches ideal_matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ideal_matches
    ADD CONSTRAINT ideal_matches_pkey PRIMARY KEY ("businessId", "offeringId");


--
-- Name: letter_boxes letter_boxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letter_boxes
    ADD CONSTRAINT letter_boxes_pkey PRIMARY KEY (id);


--
-- Name: letters letters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letters
    ADD CONSTRAINT letters_pkey PRIMARY KEY (id);


--
-- Name: localizable_requirements localizable_requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localizable_requirements
    ADD CONSTRAINT localizable_requirements_pkey PRIMARY KEY ("requirementId", "locationId");


--
-- Name: location_categories location_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_categories
    ADD CONSTRAINT location_categories_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: offering_details offering_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offering_details
    ADD CONSTRAINT offering_details_pkey PRIMARY KEY (id);


--
-- Name: offering_required_materials offering_required_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offering_required_materials
    ADD CONSTRAINT offering_required_materials_pkey PRIMARY KEY (id);


--
-- Name: offerings offerings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offerings
    ADD CONSTRAINT offerings_pkey PRIMARY KEY (id);


--
-- Name: programs programs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: raw_infos raw_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_infos
    ADD CONSTRAINT raw_infos_pkey PRIMARY KEY (id);


--
-- Name: requirements requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requirements
    ADD CONSTRAINT requirements_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: funding_partner_benefits unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partner_benefits
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- Name: user_report_categories user_report_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_report_categories
    ADD CONSTRAINT user_report_categories_pkey PRIMARY KEY (id);


--
-- Name: user_reports user_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_reports
    ADD CONSTRAINT user_reports_pkey PRIMARY KEY (id);


--
-- Name: accounts_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_email ON public.accounts USING btree (email);


--
-- Name: accounts_external_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_external_id ON public.accounts USING btree ("externalId");


--
-- Name: businesses__account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX businesses__account_id ON public.businesses USING btree ("AccountId");


--
-- Name: businesses_created_at_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX businesses_created_at_id ON public.businesses USING btree ("createdAt" DESC, id DESC);


--
-- Name: clients_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clients_account_id ON public.clients USING btree ("accountId");


--
-- Name: clients_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clients_status ON public.clients USING btree (status);


--
-- Name: funding_partner_benefits_pkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX funding_partner_benefits_pkey ON public.funding_partner_benefits USING btree (id);


--
-- Name: ideal_matches_business_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ideal_matches_business_id ON public.ideal_matches USING btree ("businessId");


--
-- Name: idx_letter_boxes_application_business_offering; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_letter_boxes_application_business_offering ON public.letter_boxes USING gin (((description -> 'businessId'::text)), ((description -> 'offeringId'::text))) WHERE ((type)::text = 'application'::text);


--
-- Name: idx_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_type ON public.letters USING btree (type);


--
-- Name: locations_minmaxcodes_numberlist_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX locations_minmaxcodes_numberlist_idx ON public.locations USING btree ((("minMaxCodes")::integer[]));


--
-- Name: offerings_created_at_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offerings_created_at_id ON public.offerings USING btree ("createdAt" DESC, id DESC);


--
-- Name: raw_infos_relatedEntityrelatedEntityId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "raw_infos_relatedEntityrelatedEntityId" ON public.raw_infos USING btree ("relatedEntity", "relatedEntityId");


--
-- Name: user_reports_is_cacheable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_reports_is_cacheable ON public.user_reports USING btree ("isCacheable");


--
-- Name: user_reports_related_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_reports_related_entity ON public.user_reports USING btree ("relatedEntity");


--
-- Name: value_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX value_id_index ON public.domain_events USING btree (value, id);


--
-- Name: letters update_letter_boxes_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_letter_boxes_trigger AFTER INSERT ON public.letters FOR EACH ROW EXECUTE FUNCTION public.update_letter_boxes_updated_at();


--
-- Name: business_saved_offerings business_saved_offerings_BusinessId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_saved_offerings
    ADD CONSTRAINT "business_saved_offerings_BusinessId_fkey" FOREIGN KEY ("BusinessId") REFERENCES public.businesses(id);


--
-- Name: business_saved_offerings business_saved_offerings_OfferingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_saved_offerings
    ADD CONSTRAINT "business_saved_offerings_OfferingId_fkey" FOREIGN KEY ("OfferingId") REFERENCES public.offerings(id);


--
-- Name: businesses businesses_AccountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.businesses
    ADD CONSTRAINT "businesses_AccountId_fkey" FOREIGN KEY ("AccountId") REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: businesses businesses_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.businesses
    ADD CONSTRAINT "businesses_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: clients clients_accountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT "clients_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id);


--
-- Name: credentialSource credentialSource_credentialSourceTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."credentialSource"
    ADD CONSTRAINT "credentialSource_credentialSourceTypeId_fkey" FOREIGN KEY ("credentialSourceTypeId") REFERENCES public."credentialSourceType"(id);


--
-- Name: credential credential_businessId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT "credential_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES public.businesses(id);


--
-- Name: credential credential_credentialSourceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT "credential_credentialSourceId_fkey" FOREIGN KEY ("credentialSourceId") REFERENCES public."credentialSource"(id);


--
-- Name: customers customers_accountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT "customers_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id) ON DELETE RESTRICT;


--
-- Name: demographics demographics_AccountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demographics
    ADD CONSTRAINT "demographics_AccountId_fkey" FOREIGN KEY ("AccountId") REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: documents documents_accountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT "documents_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: funding_partner_benefits funding_partner_benefits_FundingPartnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partner_benefits
    ADD CONSTRAINT "funding_partner_benefits_FundingPartnerId_fkey" FOREIGN KEY ("FundingPartnerId") REFERENCES public.funding_partners(id);


--
-- Name: funding_partner_saved_businesses funding_partner_saved_businesses_BusinessId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partner_saved_businesses
    ADD CONSTRAINT "funding_partner_saved_businesses_BusinessId_fkey" FOREIGN KEY ("BusinessId") REFERENCES public.businesses(id);


--
-- Name: funding_partner_saved_businesses funding_partner_saved_businesses_FundingPartnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partner_saved_businesses
    ADD CONSTRAINT "funding_partner_saved_businesses_FundingPartnerId_fkey" FOREIGN KEY ("FundingPartnerId") REFERENCES public.funding_partners(id);


--
-- Name: funding_partners funding_partners_AccountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_partners
    ADD CONSTRAINT "funding_partners_AccountId_fkey" FOREIGN KEY ("AccountId") REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ideal_matches ideal_matches_businessId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ideal_matches
    ADD CONSTRAINT "ideal_matches_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES public.businesses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ideal_matches ideal_matches_offeringId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ideal_matches
    ADD CONSTRAINT "ideal_matches_offeringId_fkey" FOREIGN KEY ("offeringId") REFERENCES public.offerings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: letters letters_letterBoxId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letters
    ADD CONSTRAINT "letters_letterBoxId_fkey" FOREIGN KEY ("letterBoxId") REFERENCES public.letter_boxes(id);


--
-- Name: localizable_requirements localizable_requirements_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localizable_requirements
    ADD CONSTRAINT "localizable_requirements_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: localizable_requirements localizable_requirements_requirementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localizable_requirements
    ADD CONSTRAINT "localizable_requirements_requirementId_fkey" FOREIGN KEY ("requirementId") REFERENCES public.requirements(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: locations locations_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT "locations_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.location_categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: locations locations_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT "locations_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: offering_details offering_details_offeringId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offering_details
    ADD CONSTRAINT "offering_details_offeringId_fkey" FOREIGN KEY ("offeringId") REFERENCES public.offerings(id);


--
-- Name: offerings offerings_FundingPartnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offerings
    ADD CONSTRAINT "offerings_FundingPartnerId_fkey" FOREIGN KEY ("FundingPartnerId") REFERENCES public.funding_partners(id);


--
-- Name: programs programs_OfferingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programs
    ADD CONSTRAINT "programs_OfferingId_fkey" FOREIGN KEY ("OfferingId") REFERENCES public.offerings(id);


--
-- Name: requirements requirements_OfferingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requirements
    ADD CONSTRAINT "requirements_OfferingId_fkey" FOREIGN KEY ("OfferingId") REFERENCES public.offerings(id);


--
-- Name: subscriptions subscriptions_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT "subscriptions_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public.customers(id);


--
-- Name: user_report_categories user_report_categories_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_report_categories
    ADD CONSTRAINT "user_report_categories_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public.user_report_categories(id);


--
-- Name: user_reports user_reports_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_reports
    ADD CONSTRAINT "user_reports_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.user_report_categories(id);


--
-- PostgreSQL database dump complete
--

