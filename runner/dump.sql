--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: equipment_groups_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.equipment_groups_type_enum AS ENUM (
    'free_weight',
    'machines',
    'cable_machines',
    'body_weight',
    'benches_and_racks'
);


--
-- Name: equipments_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.equipments_type_enum AS ENUM (
    'dumbbells',
    'barbell',
    'ez_bar',
    'v_bar',
    'trap_bar',
    'rope',
    'straight_bar',
    'cord_handles',
    'ab_machines',
    'butterfly',
    'butterfly_reverse',
    'leg_extension_machines',
    'leg_curl_machines',
    'chest_press_machines',
    'biceps_machines',
    'smith_machines',
    'hack_squat_machines',
    'deadlift_machines',
    'shoulder_press_machines',
    'lateral_raise_machines',
    'triceps_machines',
    'calf_raise_machines',
    'glute_machines',
    'lat_pulldown',
    'cable',
    'cable_crossover',
    'row_cable',
    'pull_up_bar',
    'dip_bars',
    'romain_chair',
    'glute_ham_raise_bench',
    'flat_bench',
    'adjustable_bench',
    'decline_bench',
    'flat_bench_with_rack',
    'incline_bench_with_rack',
    'decline_bench_with_rack',
    'squat_rack',
    'preacher_curl_bench',
    'row_bench'
);


--
-- Name: exercise_examples_category_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exercise_examples_category_enum AS ENUM (
    'compound',
    'isolation'
);


--
-- Name: exercise_examples_experience_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exercise_examples_experience_enum AS ENUM (
    'beginner',
    'intermediate',
    'advanced',
    'pro'
);


--
-- Name: exercise_examples_force_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exercise_examples_force_type_enum AS ENUM (
    'push',
    'pull'
);


--
-- Name: exercise_examples_tutorials_resource_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exercise_examples_tutorials_resource_type_enum AS ENUM (
    'youtube_video',
    'video',
    'text'
);


--
-- Name: exercise_examples_weight_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exercise_examples_weight_type_enum AS ENUM (
    'free',
    'fixed'
);


--
-- Name: muscle_groups_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.muscle_groups_type_enum AS ENUM (
    'chest_muscles',
    'back_muscles',
    'abdominal_muscles',
    'legs',
    'arms_and_forearms',
    'shoulder_muscles'
);


--
-- Name: muscles_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.muscles_type_enum AS ENUM (
    'pectoralis_major',
    'pectoralis_minor',
    'trapezius',
    'latissimus_dorsi',
    'rhomboids',
    'teres_major',
    'rectus_abdominis',
    'obliques',
    'calf',
    'gluteal',
    'hamstrings',
    'quadriceps',
    'anterior_deltoid',
    'lateral_deltoid',
    'posterior_deltoid',
    'biceps',
    'triceps',
    'forearm'
);


--
-- Name: users_experience_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.users_experience_enum AS ENUM (
    'beginner',
    'intermediate',
    'advanced',
    'pro'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: equipment_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment_groups (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    type public.equipment_groups_type_enum,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: equipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    equipment_group_id uuid,
    type public.equipments_type_enum,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: excluded_equipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.excluded_equipments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    equipment_id uuid,
    user_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: excluded_muscles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.excluded_muscles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    muscle_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id uuid,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: exercise_example_bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_example_bundles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    percentage integer,
    exercise_example_id uuid,
    muscle_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: exercise_examples; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_examples (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    image_url character varying,
    description character varying,
    category public.exercise_examples_category_enum,
    weight_type public.exercise_examples_weight_type_enum,
    force_type public.exercise_examples_force_type_enum,
    experience public.exercise_examples_experience_enum
);


--
-- Name: exercise_examples_equipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_examples_equipments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    equipment_id uuid,
    exercise_example_id uuid
);


--
-- Name: exercise_examples_tutorials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_examples_tutorials (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    exercise_example_id uuid,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying,
    value character varying,
    language character varying,
    author character varying,
    resource_type public.exercise_examples_tutorials_resource_type_enum
);


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercises (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    volume double precision,
    repetitions integer,
    intensity double precision,
    training_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    exercise_example_id uuid
);


--
-- Name: iterations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.iterations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    weight double precision,
    repetitions integer,
    exercise_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: muscle_exercise_bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muscle_exercise_bundles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    percentage integer,
    exercise_example_id uuid,
    muscle_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: muscle_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muscle_groups (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    name_ua character varying,
    name_ru character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    type public.muscle_groups_type_enum
);


--
-- Name: muscles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muscles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    muscle_group_id uuid,
    name_ua character varying,
    name_ru character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    type public.muscles_type_enum,
    recovery_time_hours integer
);


--
-- Name: trainings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trainings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    duration integer,
    volume double precision,
    repetitions integer,
    intensity double precision,
    user_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    height double precision NOT NULL,
    experience public.users_experience_enum
);


--
-- Name: weight_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weight_history (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid,
    weight double precision NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Data for Name: equipment_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.equipment_groups VALUES ('56550c17-dd77-40c2-8737-fde011dcbbaa', 'Free Weight', 'free_weight', '2024-07-26 15:20:13.307246', '2024-07-26 15:20:13.307246');
INSERT INTO public.equipment_groups VALUES ('fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'Machines', 'machines', '2024-07-26 15:21:01.438902', '2024-07-26 15:21:01.438902');
INSERT INTO public.equipment_groups VALUES ('7f343be4-0ec8-458a-a45b-d5ab7c1973de', 'Cable Machines', 'cable_machines', '2024-07-26 15:22:38.32104', '2024-07-26 15:22:38.32104');
INSERT INTO public.equipment_groups VALUES ('3670c91d-010e-4e58-b1c6-282fb5fe12c6', 'Body Weight', 'body_weight', '2024-07-26 15:23:05.785405', '2024-07-26 15:23:05.785405');
INSERT INTO public.equipment_groups VALUES ('9f7ba689-6791-4c1e-8ad7-da558a028fac', 'Benches & Racks', 'benches_and_racks', '2024-07-26 15:23:43.201296', '2024-07-26 15:23:43.201296');


--
-- Data for Name: equipments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.equipments VALUES ('9d66ac93-3a48-429d-aeaa-54302856e204', 'Dumbbells', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'dumbbells', '2024-07-26 15:27:07.977174', '2024-07-26 15:27:07.977174');
INSERT INTO public.equipments VALUES ('b17ae8af-2d78-4e77-b45b-39253c28247a', 'Barbell', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'barbell', '2024-07-26 15:27:53.397531', '2024-07-26 15:27:53.397531');
INSERT INTO public.equipments VALUES ('ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', 'EZ Bar', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'ez_bar', '2024-07-26 15:27:53.397531', '2024-07-26 15:27:53.397531');
INSERT INTO public.equipments VALUES ('21aad68b-b21b-4452-9ebf-7407be8e613d', 'Trap Bar', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'trap_bar', '2024-07-26 15:27:53.397531', '2024-07-26 15:27:53.397531');
INSERT INTO public.equipments VALUES ('15495639-2adb-41b8-899c-493ac0172f57', 'Straight Bar', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'straight_bar', '2024-07-26 15:30:17.071839', '2024-07-26 15:30:17.071839');
INSERT INTO public.equipments VALUES ('331a0c35-f5a5-478d-ba7c-9f14ba2ee0fa', 'Cord Handles', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'cord_handles', '2024-07-26 15:30:34.728288', '2024-07-26 15:30:34.728288');
INSERT INTO public.equipments VALUES ('527227fe-8182-4aec-949a-66335c5ce25e', 'AB Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'ab_machines', '2024-07-27 09:01:03.349338', '2024-07-27 09:01:03.349338');
INSERT INTO public.equipments VALUES ('3f2fb6e0-df68-4881-a735-f07ea083aaa7', 'Butterfly', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'butterfly', '2024-07-27 09:01:03.349338', '2024-07-27 09:01:03.349338');
INSERT INTO public.equipments VALUES ('526347a3-ee32-473d-9b5d-049f526ae48e', 'Butterfly Reverse', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'butterfly_reverse', '2024-07-27 09:01:03.349338', '2024-07-27 09:01:03.349338');
INSERT INTO public.equipments VALUES ('c74a2236-739f-476b-96d9-a11487d4049f', 'Leg Extension Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'leg_extension_machines', '2024-07-27 09:01:03.349338', '2024-07-27 09:01:03.349338');
INSERT INTO public.equipments VALUES ('a8a80e95-9165-4200-af80-cd7608099307', 'Leg Curl Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'leg_curl_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('79e4532a-afda-421f-9b5f-8c2de5f63ec0', 'Chest Press Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'chest_press_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('0d0f8242-be68-4086-b665-0a11ff6a0dcd', 'Biceps Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'biceps_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('623e0be7-870a-4bca-b053-76e99c9ea7e0', 'Smith Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'smith_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('20e225dd-68d7-409b-9b7d-5ef6d4224d02', 'Hack Squat Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'hack_squat_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('6ba064c9-68b3-4b76-af61-6a81eee230c8', 'Deadlift Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'deadlift_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('6c587294-e384-4941-b90d-e6ec64b8731d', 'Shoulder Press Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'shoulder_press_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('0268b0d7-f8e4-47ea-b9da-969427b43adf', 'Lateral Raise Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'lateral_raise_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('f3166b1f-125f-4fb9-a443-e1fc2b1c0f8f', 'Triceps Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'triceps_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('7752a881-139d-4cf4-98b2-e92e9de0e2e5', 'Calf Raise Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'calf_raise_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('f3dadde9-6213-4a90-8fc0-12bd7bf7ea6b', 'Glute Machines', 'fcfa00b0-820c-494a-ac9e-ff4cf4e69489', 'glute_machines', '2024-07-27 09:03:40.163591', '2024-07-27 09:03:40.163591');
INSERT INTO public.equipments VALUES ('18995b62-6971-4750-84fe-0c2bc712f352', 'Lat Pulldown', '7f343be4-0ec8-458a-a45b-d5ab7c1973de', 'lat_pulldown', '2024-07-27 09:04:50.495', '2024-07-27 09:04:50.495');
INSERT INTO public.equipments VALUES ('752ee7ba-ae88-46f0-95fb-e0a316212f16', 'Cable', '7f343be4-0ec8-458a-a45b-d5ab7c1973de', 'cable', '2024-07-27 09:04:50.495', '2024-07-27 09:04:50.495');
INSERT INTO public.equipments VALUES ('a6628e7c-1488-4268-82ee-5174f3a5a2a5', 'Cable Crossover', '7f343be4-0ec8-458a-a45b-d5ab7c1973de', 'cable_crossover', '2024-07-27 09:04:50.495', '2024-07-27 09:04:50.495');
INSERT INTO public.equipments VALUES ('373d04ea-8079-439a-82a3-d118da6253b1', 'Row Cable', '7f343be4-0ec8-458a-a45b-d5ab7c1973de', 'row_cable', '2024-07-27 09:04:50.495', '2024-07-27 09:04:50.495');
INSERT INTO public.equipments VALUES ('ddf4299a-fc48-47bd-9bdf-7e3d7692b09f', 'Pull Up Bar', '3670c91d-010e-4e58-b1c6-282fb5fe12c6', 'pull_up_bar', '2024-07-27 09:05:48.252957', '2024-07-27 09:05:48.252957');
INSERT INTO public.equipments VALUES ('c01e10b9-4ef6-4f23-9b41-7f6d5d4d1e85', 'Dip Bars', '3670c91d-010e-4e58-b1c6-282fb5fe12c6', 'dip_bars', '2024-07-27 09:05:48.252957', '2024-07-27 09:05:48.252957');
INSERT INTO public.equipments VALUES ('afe516f8-6dc9-45ca-b95e-81142c336878', 'Romain Chair', '3670c91d-010e-4e58-b1c6-282fb5fe12c6', 'romain_chair', '2024-07-27 09:05:48.252957', '2024-07-27 09:05:48.252957');
INSERT INTO public.equipments VALUES ('306270ba-834e-461e-81ce-45fd5a77c99f', 'Glute Ham Raise Bench', '3670c91d-010e-4e58-b1c6-282fb5fe12c6', 'glute_ham_raise_bench', '2024-07-27 09:05:48.252957', '2024-07-27 09:05:48.252957');
INSERT INTO public.equipments VALUES ('85dbccf6-454e-4440-8905-50a90d91dbcc', 'Flat Bench', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'flat_bench', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('6215cbaf-6065-4534-a9d5-a588c1b3dc28', 'Adjustable Bench', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'adjustable_bench', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('c4d5e6fe-30fd-4f16-8646-634102d1bf1b', 'Decline Bench', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'decline_bench', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('e7fc1da0-48df-4338-b03f-1cea01cd12d5', 'Flat Bench with Rack', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'flat_bench_with_rack', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('6345b70f-6e3f-46e2-9d51-3be51250ed99', 'Incline Bench with Rack', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'incline_bench_with_rack', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('9677e942-8a9b-4754-a27f-7e4d945681a1', 'Decline Bench with Rack', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'decline_bench_with_rack', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('a025ec57-670e-45ea-962e-9c9430786666', 'Squat Rack', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'squat_rack', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('061ad8e2-77aa-4ba8-9a41-51788e7803c7', 'Preacher Curl Bench', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'preacher_curl_bench', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('0eda801d-e31d-4943-8a73-68c702f3d3d2', 'Row Bench', '9f7ba689-6791-4c1e-8ad7-da558a028fac', 'row_bench', '2024-07-27 09:07:42.088418', '2024-07-27 09:07:42.088418');
INSERT INTO public.equipments VALUES ('af38ec0a-1465-45a8-99ba-a394224530dc', 'Rope', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'rope', '2024-08-23 14:52:12.166064', '2024-08-23 14:52:12.166064');
INSERT INTO public.equipments VALUES ('524da8cf-0303-4c53-8761-832a5fdb54ed', 'V Bar', '56550c17-dd77-40c2-8737-fde011dcbbaa', 'v_bar', '2024-08-26 14:04:38.569404', '2024-08-26 14:04:38.569404');


--
-- Data for Name: excluded_equipments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: excluded_muscles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.excluded_muscles VALUES ('72d745dc-a320-4427-b51b-5f38ad1d25d4', 'bba5b66d-9a9c-4b44-8dd6-9574760038ee', '2024-08-23 11:26:13.686097', '5e2eab59-bccb-4679-997a-398e18bc254c', '2024-08-23 11:26:13.686097');
INSERT INTO public.excluded_muscles VALUES ('21a6a90b-4784-4d8f-a595-2c29c15b1e51', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 11:26:17.182962', '5e2eab59-bccb-4679-997a-398e18bc254c', '2024-08-23 11:26:17.182962');
INSERT INTO public.excluded_muscles VALUES ('afd95d66-4d77-4374-a4d5-06267634f5e5', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-23 11:58:00.185268', '5e2eab59-bccb-4679-997a-398e18bc254c', '2024-08-23 11:58:00.185268');
INSERT INTO public.excluded_muscles VALUES ('043193a4-67d5-49ca-adb7-fd26355f2160', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 11:58:00.642429', '5e2eab59-bccb-4679-997a-398e18bc254c', '2024-08-23 11:58:00.642429');


--
-- Data for Name: exercise_example_bundles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.exercise_example_bundles VALUES ('88a227ca-81cf-463f-94f0-b75d6cc75d35', 7, '11644e17-247a-46b0-a391-b3b2a2a6bba8', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-26 14:15:00.637773', '2024-08-26 14:15:00.637773');
INSERT INTO public.exercise_example_bundles VALUES ('e29c077b-a6a5-4b93-9680-ba40bcfc5345', 3, '11644e17-247a-46b0-a391-b3b2a2a6bba8', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 14:15:00.637773', '2024-08-26 14:15:00.637773');
INSERT INTO public.exercise_example_bundles VALUES ('5f8e03d7-7651-4cba-8bd5-b70776118cd2', 10, '11644e17-247a-46b0-a391-b3b2a2a6bba8', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-26 14:15:00.637773', '2024-08-26 14:15:00.637773');
INSERT INTO public.exercise_example_bundles VALUES ('20ca0e99-8e9a-4313-8b35-21555c94f268', 70, '11644e17-247a-46b0-a391-b3b2a2a6bba8', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:15:00.637773', '2024-08-26 14:15:00.637773');
INSERT INTO public.exercise_example_bundles VALUES ('e28949e2-b238-43e1-98db-b5969877e4f5', 10, '11644e17-247a-46b0-a391-b3b2a2a6bba8', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-26 14:15:00.637773', '2024-08-26 14:15:00.637773');
INSERT INTO public.exercise_example_bundles VALUES ('6782aa22-6e1a-4f3a-b8d3-f49cb5f11527', 80, '6cb225d2-be00-461d-9bf0-7f0c87cfea0b', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 13:51:17.104274', '2024-08-23 13:51:17.104274');
INSERT INTO public.exercise_example_bundles VALUES ('7a781077-e89b-42bb-95e6-4bf7c887cc29', 20, '6cb225d2-be00-461d-9bf0-7f0c87cfea0b', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 13:51:17.104274', '2024-08-23 13:51:17.104274');
INSERT INTO public.exercise_example_bundles VALUES ('6999837a-f658-4cc1-9845-75f0227aaab0', 80, 'b790c6a6-ecd1-4b3a-afbc-22cd82e55658', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 14:29:51.275739', '2024-08-23 14:29:51.275739');
INSERT INTO public.exercise_example_bundles VALUES ('2e9c4465-b20f-4e59-99f7-350ed659af26', 20, 'b790c6a6-ecd1-4b3a-afbc-22cd82e55658', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 14:29:51.275739', '2024-08-23 14:29:51.275739');
INSERT INTO public.exercise_example_bundles VALUES ('76b8152c-3971-4713-888f-4c412c5107f1', 85, '4d3a89ab-70ae-4311-8b40-a058b2f3057b', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 14:41:48.917167', '2024-08-23 14:41:48.917167');
INSERT INTO public.exercise_example_bundles VALUES ('9ca41f6a-2cf1-4b4c-a280-28858703f3c9', 15, '4d3a89ab-70ae-4311-8b40-a058b2f3057b', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 14:41:48.917167', '2024-08-23 14:41:48.917167');
INSERT INTO public.exercise_example_bundles VALUES ('cf554580-e8a2-4485-99c9-ca9069b84603', 80, '0e2fe1e8-f8f1-48e6-b360-8c9d4d9991a6', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 14:53:43.913741', '2024-08-23 14:53:43.913741');
INSERT INTO public.exercise_example_bundles VALUES ('4897d4d8-17c7-4cf0-9ee5-41160d8f1f42', 20, '0e2fe1e8-f8f1-48e6-b360-8c9d4d9991a6', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 14:53:43.913741', '2024-08-23 14:53:43.913741');
INSERT INTO public.exercise_example_bundles VALUES ('d630120e-c17f-461e-8e47-c238101bbbea', 5, 'ab0d7384-444e-446a-911d-f64ac31db8ef', 'b4658891-9713-48c4-864c-8dd907da19b0', '2024-08-23 15:30:18.889592', '2024-08-23 15:30:18.889592');
INSERT INTO public.exercise_example_bundles VALUES ('71b829f5-c42e-427a-86a1-2b0c9959e9cf', 30, 'ab0d7384-444e-446a-911d-f64ac31db8ef', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-23 15:30:18.889592', '2024-08-23 15:30:18.889592');
INSERT INTO public.exercise_example_bundles VALUES ('87dc02f1-1516-4fca-93ac-6f2b5e7312b9', 15, 'ab0d7384-444e-446a-911d-f64ac31db8ef', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-23 15:30:18.889592', '2024-08-23 15:30:18.889592');
INSERT INTO public.exercise_example_bundles VALUES ('dcebd1df-e9b5-4cb8-ac2f-d6f169fe4b58', 45, 'ab0d7384-444e-446a-911d-f64ac31db8ef', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 15:30:18.889592', '2024-08-23 15:30:18.889592');
INSERT INTO public.exercise_example_bundles VALUES ('9b49ec23-4c23-4b11-bdd5-8226abc7b0a0', 5, 'ab0d7384-444e-446a-911d-f64ac31db8ef', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 15:30:18.889592', '2024-08-23 15:30:18.889592');
INSERT INTO public.exercise_example_bundles VALUES ('e67acbe6-3752-4843-9000-d87f877b8849', 5, '650e9725-d36c-4688-bcab-adf93dfe9e5d', 'b4658891-9713-48c4-864c-8dd907da19b0', '2024-08-23 15:44:41.332965', '2024-08-23 15:44:41.332965');
INSERT INTO public.exercise_example_bundles VALUES ('652efe63-0e4b-4830-a0d2-9443672da215', 25, '650e9725-d36c-4688-bcab-adf93dfe9e5d', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-23 15:44:41.332965', '2024-08-23 15:44:41.332965');
INSERT INTO public.exercise_example_bundles VALUES ('2a0e87be-8d27-47ad-a4d1-1011e9298693', 15, '650e9725-d36c-4688-bcab-adf93dfe9e5d', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-23 15:44:41.332965', '2024-08-23 15:44:41.332965');
INSERT INTO public.exercise_example_bundles VALUES ('6e92c283-f0bb-4161-a291-eb46bafdd40e', 50, '650e9725-d36c-4688-bcab-adf93dfe9e5d', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 15:44:41.332965', '2024-08-23 15:44:41.332965');
INSERT INTO public.exercise_example_bundles VALUES ('cc503015-28c3-4090-b072-53d7dbf43b16', 5, '650e9725-d36c-4688-bcab-adf93dfe9e5d', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 15:44:41.332965', '2024-08-23 15:44:41.332965');
INSERT INTO public.exercise_example_bundles VALUES ('39313a9e-b4b3-47e4-842e-208bb338e74a', 5, '3b828d2f-797f-4a45-9d1d-1d3efe38fb54', 'b4658891-9713-48c4-864c-8dd907da19b0', '2024-08-23 15:50:27.647239', '2024-08-23 15:50:27.647239');
INSERT INTO public.exercise_example_bundles VALUES ('a4ff9fe6-5923-4888-9ad8-bc3caff0c3ce', 25, '3b828d2f-797f-4a45-9d1d-1d3efe38fb54', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-23 15:50:27.647239', '2024-08-23 15:50:27.647239');
INSERT INTO public.exercise_example_bundles VALUES ('30f2a505-55c2-4bd0-b74f-cfa6bdbeed17', 15, '3b828d2f-797f-4a45-9d1d-1d3efe38fb54', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-23 15:50:27.647239', '2024-08-23 15:50:27.647239');
INSERT INTO public.exercise_example_bundles VALUES ('c4eef49f-0b04-44de-90b0-148484007fa4', 50, '3b828d2f-797f-4a45-9d1d-1d3efe38fb54', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 15:50:27.647239', '2024-08-23 15:50:27.647239');
INSERT INTO public.exercise_example_bundles VALUES ('ac6025bc-b4cb-4775-8d78-82ae1634df2d', 5, '3b828d2f-797f-4a45-9d1d-1d3efe38fb54', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 15:50:27.647239', '2024-08-23 15:50:27.647239');
INSERT INTO public.exercise_example_bundles VALUES ('e5d05435-4c49-4900-987e-0be1fed5df55', 10, '7517ae2f-c198-4a33-8a1d-1dc7327d1430', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-23 20:29:25.1916', '2024-08-23 20:29:25.1916');
INSERT INTO public.exercise_example_bundles VALUES ('15793138-fe56-4263-be2f-6df2b9b8eed6', 15, '7517ae2f-c198-4a33-8a1d-1dc7327d1430', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-23 20:29:25.1916', '2024-08-23 20:29:25.1916');
INSERT INTO public.exercise_example_bundles VALUES ('e05517be-f96e-4c2e-955e-51026b7fad31', 70, '7517ae2f-c198-4a33-8a1d-1dc7327d1430', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 20:29:25.1916', '2024-08-23 20:29:25.1916');
INSERT INTO public.exercise_example_bundles VALUES ('9aa0603b-61eb-4f10-9e48-13f176ec547b', 5, '7517ae2f-c198-4a33-8a1d-1dc7327d1430', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 20:29:25.1916', '2024-08-23 20:29:25.1916');
INSERT INTO public.exercise_example_bundles VALUES ('cd6fc1f9-fc65-40f9-b6a3-0dc66104ce4e', 10, '4aafe702-f2fc-4fa2-a7fb-c31c279adeda', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-23 20:36:43.355792', '2024-08-23 20:36:43.355792');
INSERT INTO public.exercise_example_bundles VALUES ('94df2963-cd52-40e6-8acc-6a7bce910a77', 15, '4aafe702-f2fc-4fa2-a7fb-c31c279adeda', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-23 20:36:43.355792', '2024-08-23 20:36:43.355792');
INSERT INTO public.exercise_example_bundles VALUES ('2a64ad71-1bc3-41eb-b583-c82a795e5ca1', 65, '4aafe702-f2fc-4fa2-a7fb-c31c279adeda', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-23 20:36:43.355792', '2024-08-23 20:36:43.355792');
INSERT INTO public.exercise_example_bundles VALUES ('0be804c3-aa15-4ba1-ab73-1fa05ab89781', 10, '4aafe702-f2fc-4fa2-a7fb-c31c279adeda', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-23 20:36:43.355792', '2024-08-23 20:36:43.355792');
INSERT INTO public.exercise_example_bundles VALUES ('296368ee-2357-4884-843b-001815eb58eb', 5, 'faf6674c-2a2a-4b03-ab8b-7a033052b572', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-24 13:49:36.256733', '2024-08-24 13:49:36.256733');
INSERT INTO public.exercise_example_bundles VALUES ('4f8dead0-6147-4e91-9471-ed0cc16a55e2', 15, 'faf6674c-2a2a-4b03-ab8b-7a033052b572', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-24 13:49:36.256733', '2024-08-24 13:49:36.256733');
INSERT INTO public.exercise_example_bundles VALUES ('6ef6e9e6-7c76-4e9a-8175-50c156ab6a5f', 70, 'faf6674c-2a2a-4b03-ab8b-7a033052b572', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-24 13:49:36.256733', '2024-08-24 13:49:36.256733');
INSERT INTO public.exercise_example_bundles VALUES ('0de77642-bf82-42ba-a9d4-20a07baedd16', 10, 'faf6674c-2a2a-4b03-ab8b-7a033052b572', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-24 13:49:36.256733', '2024-08-24 13:49:36.256733');
INSERT INTO public.exercise_example_bundles VALUES ('113dc604-3006-4bc6-be1b-37224b7d22fe', 50, '93e6b1c4-0510-41d4-983c-a1fde003881f', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-24 13:55:14.342158', '2024-08-24 13:55:14.342158');
INSERT INTO public.exercise_example_bundles VALUES ('a51e0538-ad97-4c59-9b1f-5b309afbbc51', 15, '93e6b1c4-0510-41d4-983c-a1fde003881f', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-24 13:55:14.342158', '2024-08-24 13:55:14.342158');
INSERT INTO public.exercise_example_bundles VALUES ('3aebaec1-6632-4c73-ba8c-6952dba05975', 30, '93e6b1c4-0510-41d4-983c-a1fde003881f', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-24 13:55:14.342158', '2024-08-24 13:55:14.342158');
INSERT INTO public.exercise_example_bundles VALUES ('064356e6-5f00-447c-be92-417544cafb0f', 5, '93e6b1c4-0510-41d4-983c-a1fde003881f', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-24 13:55:14.342158', '2024-08-24 13:55:14.342158');
INSERT INTO public.exercise_example_bundles VALUES ('14388af7-5dec-40f2-93f9-251203ac087f', 5, '0eaa8980-e29e-4f33-88b0-915db5cf309a', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-24 15:00:28.261712', '2024-08-24 15:00:28.261712');
INSERT INTO public.exercise_example_bundles VALUES ('03e7efda-d175-45ce-9424-e35e1694177b', 20, '0eaa8980-e29e-4f33-88b0-915db5cf309a', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-24 15:00:28.261712', '2024-08-24 15:00:28.261712');
INSERT INTO public.exercise_example_bundles VALUES ('e462d49b-8854-4d9c-a2b4-7e613438fe8d', 70, '0eaa8980-e29e-4f33-88b0-915db5cf309a', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-24 15:00:28.261712', '2024-08-24 15:00:28.261712');
INSERT INTO public.exercise_example_bundles VALUES ('f5cdbe03-ce9d-447f-9c6a-c199db0346cf', 5, '0eaa8980-e29e-4f33-88b0-915db5cf309a', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-24 15:00:28.261712', '2024-08-24 15:00:28.261712');
INSERT INTO public.exercise_example_bundles VALUES ('cb83ce2d-8aee-47ea-9b4e-a71f4b618d8a', 15, '9f0c8916-a08b-4fe5-9f24-e1680ef627a8', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-24 15:05:24.066839', '2024-08-24 15:05:24.066839');
INSERT INTO public.exercise_example_bundles VALUES ('eb65b18d-1ecc-4bc4-b9f1-920c31315722', 15, '9f0c8916-a08b-4fe5-9f24-e1680ef627a8', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-24 15:05:24.066839', '2024-08-24 15:05:24.066839');
INSERT INTO public.exercise_example_bundles VALUES ('03d7628e-87b2-40b7-95db-da120ea3cf9e', 65, '9f0c8916-a08b-4fe5-9f24-e1680ef627a8', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-24 15:05:24.066839', '2024-08-24 15:05:24.066839');
INSERT INTO public.exercise_example_bundles VALUES ('996f10ba-b0a0-445b-81e7-29b390dd755d', 5, '9f0c8916-a08b-4fe5-9f24-e1680ef627a8', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-24 15:05:24.066839', '2024-08-24 15:05:24.066839');
INSERT INTO public.exercise_example_bundles VALUES ('337b2432-790c-4da6-89bb-e9d3494fc6db', 5, '547f1f7e-3ee1-4b39-99eb-3462b1ec13af', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-24 15:14:04.496892', '2024-08-24 15:14:04.496892');
INSERT INTO public.exercise_example_bundles VALUES ('46745aee-08e8-4f56-b1b4-5aec7ff13476', 15, '547f1f7e-3ee1-4b39-99eb-3462b1ec13af', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-24 15:14:04.496892', '2024-08-24 15:14:04.496892');
INSERT INTO public.exercise_example_bundles VALUES ('abd6d56d-1d25-422f-b795-f278139c9572', 70, '547f1f7e-3ee1-4b39-99eb-3462b1ec13af', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-24 15:14:04.496892', '2024-08-24 15:14:04.496892');
INSERT INTO public.exercise_example_bundles VALUES ('8c76f415-184d-4cd4-8e31-8776f8594f67', 10, '547f1f7e-3ee1-4b39-99eb-3462b1ec13af', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-24 15:14:04.496892', '2024-08-24 15:14:04.496892');
INSERT INTO public.exercise_example_bundles VALUES ('ac8a1331-b694-4383-883d-1303ae5bf228', 3, '275097d4-3c8d-4040-9b2e-5f294919df04', '1ddbb748-37a6-4d66-a7d4-4957bdbc647f', '2024-08-24 15:21:25.320698', '2024-08-24 15:21:25.320698');
INSERT INTO public.exercise_example_bundles VALUES ('2d9192aa-8c25-4b78-b6da-6111d54f0d10', 3, '275097d4-3c8d-4040-9b2e-5f294919df04', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-24 15:21:25.320698', '2024-08-24 15:21:25.320698');
INSERT INTO public.exercise_example_bundles VALUES ('1bf5346d-a25e-44e9-987b-16018d0a9d33', 5, '275097d4-3c8d-4040-9b2e-5f294919df04', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-24 15:21:25.320698', '2024-08-24 15:21:25.320698');
INSERT INTO public.exercise_example_bundles VALUES ('663ac7b2-0efa-4af8-8e68-5b3743275b36', 5, '275097d4-3c8d-4040-9b2e-5f294919df04', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-24 15:21:25.320698', '2024-08-24 15:21:25.320698');
INSERT INTO public.exercise_example_bundles VALUES ('9dd4593f-1740-4bb6-9b42-ac12612b60c2', 74, '275097d4-3c8d-4040-9b2e-5f294919df04', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-24 15:21:25.320698', '2024-08-24 15:21:25.320698');
INSERT INTO public.exercise_example_bundles VALUES ('d6378421-7dd2-4e30-8e29-e9b54007c407', 10, '275097d4-3c8d-4040-9b2e-5f294919df04', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-24 15:21:25.320698', '2024-08-24 15:21:25.320698');
INSERT INTO public.exercise_example_bundles VALUES ('499e865a-3135-4ba7-b234-ad2829a7a45f', 3, '5985d847-0473-444e-8fe0-9da5341ef986', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 14:10:38.4213', '2024-08-26 14:10:38.4213');
INSERT INTO public.exercise_example_bundles VALUES ('7e8e06b7-05da-4185-ada7-5fe66e050ee1', 5, '5985d847-0473-444e-8fe0-9da5341ef986', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-26 14:10:38.4213', '2024-08-26 14:10:38.4213');
INSERT INTO public.exercise_example_bundles VALUES ('1a6610cb-266c-4631-b48a-f7cb7fac9d87', 7, '5985d847-0473-444e-8fe0-9da5341ef986', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:10:38.4213', '2024-08-26 14:10:38.4213');
INSERT INTO public.exercise_example_bundles VALUES ('0db79f53-e4a4-444a-8634-08b66cf9235f', 75, '5985d847-0473-444e-8fe0-9da5341ef986', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:10:38.4213', '2024-08-26 14:10:38.4213');
INSERT INTO public.exercise_example_bundles VALUES ('a91744b3-2a6a-4c0f-a493-db486500377d', 10, '5985d847-0473-444e-8fe0-9da5341ef986', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-26 14:10:38.4213', '2024-08-26 14:10:38.4213');
INSERT INTO public.exercise_example_bundles VALUES ('7bd3907b-eacc-46dd-842f-47941c61279f', 10, '50774526-c91f-4d71-82a8-456526b0fbd0', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-26 14:21:24.517126', '2024-08-26 14:21:24.517126');
INSERT INTO public.exercise_example_bundles VALUES ('a757a9c8-94b8-4890-9c45-b4fc096f1a28', 3, '50774526-c91f-4d71-82a8-456526b0fbd0', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 14:21:24.517126', '2024-08-26 14:21:24.517126');
INSERT INTO public.exercise_example_bundles VALUES ('d6d66074-2ad3-4169-9948-05cc659e74f0', 7, '50774526-c91f-4d71-82a8-456526b0fbd0', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-26 14:21:24.517126', '2024-08-26 14:21:24.517126');
INSERT INTO public.exercise_example_bundles VALUES ('235a838e-41db-4402-ada9-6919697d8852', 5, '50774526-c91f-4d71-82a8-456526b0fbd0', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:21:24.517126', '2024-08-26 14:21:24.517126');
INSERT INTO public.exercise_example_bundles VALUES ('08df3ca9-1e6b-46ee-8cc5-dff2ef9989fe', 75, '50774526-c91f-4d71-82a8-456526b0fbd0', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:21:24.517126', '2024-08-26 14:21:24.517126');
INSERT INTO public.exercise_example_bundles VALUES ('dbbd9f85-c19f-4775-a1d8-0117a3fdb8c0', 3, '385fb192-7c2c-405a-b483-f36e32e241c8', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-26 14:31:15.925866', '2024-08-26 14:31:15.925866');
INSERT INTO public.exercise_example_bundles VALUES ('ead15f95-2373-4ae3-93c2-4b25a299c691', 30, '385fb192-7c2c-405a-b483-f36e32e241c8', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-26 14:31:15.925866', '2024-08-26 14:31:15.925866');
INSERT INTO public.exercise_example_bundles VALUES ('3bce6cda-6a21-4139-a1b1-61242b994c35', 7, '385fb192-7c2c-405a-b483-f36e32e241c8', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:31:15.925866', '2024-08-26 14:31:15.925866');
INSERT INTO public.exercise_example_bundles VALUES ('3c16442f-55c3-44a6-aaee-227ffe547d1b', 60, '385fb192-7c2c-405a-b483-f36e32e241c8', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:31:15.925866', '2024-08-26 14:31:15.925866');
INSERT INTO public.exercise_example_bundles VALUES ('c9e17142-9f8e-4aee-a248-23c3b8f81e1b', 33, 'c21d3b0f-c8a8-4b7f-92ea-90dc567a1183', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-26 14:36:25.64298', '2024-08-26 14:36:25.64298');
INSERT INTO public.exercise_example_bundles VALUES ('a1ae109e-f6d9-4875-83a0-8271fabf798b', 10, 'c21d3b0f-c8a8-4b7f-92ea-90dc567a1183', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:36:25.64298', '2024-08-26 14:36:25.64298');
INSERT INTO public.exercise_example_bundles VALUES ('abd1f4e9-2c21-48fa-9183-54a67d26b8c0', 57, 'c21d3b0f-c8a8-4b7f-92ea-90dc567a1183', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:36:25.64298', '2024-08-26 14:36:25.64298');
INSERT INTO public.exercise_example_bundles VALUES ('21e181ac-103a-4976-83ef-bf7d79bf373d', 3, '04d275d8-71df-4695-ace9-899ce6e41b29', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-26 14:39:55.631326', '2024-08-26 14:39:55.631326');
INSERT INTO public.exercise_example_bundles VALUES ('cdfc0623-dfef-4ddc-a118-d027ee0efacb', 7, '04d275d8-71df-4695-ace9-899ce6e41b29', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:39:55.631326', '2024-08-26 14:39:55.631326');
INSERT INTO public.exercise_example_bundles VALUES ('4ef797d6-9579-4c34-bb18-eef1a7b5cf5b', 90, '04d275d8-71df-4695-ace9-899ce6e41b29', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:39:55.631326', '2024-08-26 14:39:55.631326');
INSERT INTO public.exercise_example_bundles VALUES ('73d55224-e0cc-4625-a0f6-2c13f2c02a86', 5, '1b4402c2-2459-45c1-8d24-356322c71d20', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 14:46:34.082451', '2024-08-26 14:46:34.082451');
INSERT INTO public.exercise_example_bundles VALUES ('293f3ce5-ca84-4ce2-8d4a-d25e088c1272', 5, '1b4402c2-2459-45c1-8d24-356322c71d20', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:46:34.082451', '2024-08-26 14:46:34.082451');
INSERT INTO public.exercise_example_bundles VALUES ('e9e55355-5a3e-4a26-8605-82e056734465', 90, '1b4402c2-2459-45c1-8d24-356322c71d20', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:46:34.082451', '2024-08-26 14:46:34.082451');
INSERT INTO public.exercise_example_bundles VALUES ('68ce91fd-05a6-49e2-a3a7-47c2bde7f3a0', 5, '4f9bdd10-28bc-447e-8cf5-fbf47cd9af79', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 14:52:11.244098', '2024-08-26 14:52:11.244098');
INSERT INTO public.exercise_example_bundles VALUES ('609d1d59-52b1-4a47-9274-795756d11360', 5, '4f9bdd10-28bc-447e-8cf5-fbf47cd9af79', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 14:52:11.244098', '2024-08-26 14:52:11.244098');
INSERT INTO public.exercise_example_bundles VALUES ('111cdf18-c08f-4133-8e95-8aa4549ef28c', 90, '4f9bdd10-28bc-447e-8cf5-fbf47cd9af79', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 14:52:11.244098', '2024-08-26 14:52:11.244098');
INSERT INTO public.exercise_example_bundles VALUES ('1aea43fc-04d5-4c68-a744-6da969b4e0ec', 5, '6a312bde-cc33-450b-8f1d-6091ccffe9cc', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-26 15:16:20.199318', '2024-08-26 15:16:20.199318');
INSERT INTO public.exercise_example_bundles VALUES ('c5a1bbba-5a08-45ef-b15e-bbd8e1ec03ea', 5, '6a312bde-cc33-450b-8f1d-6091ccffe9cc', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 15:16:20.199318', '2024-08-26 15:16:20.199318');
INSERT INTO public.exercise_example_bundles VALUES ('3a96266d-7ef7-4e52-9506-20a930f7941a', 5, '6a312bde-cc33-450b-8f1d-6091ccffe9cc', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 15:16:20.199318', '2024-08-26 15:16:20.199318');
INSERT INTO public.exercise_example_bundles VALUES ('eafb9352-ecfd-40d0-a070-02526d31c373', 85, '6a312bde-cc33-450b-8f1d-6091ccffe9cc', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 15:16:20.199318', '2024-08-26 15:16:20.199318');
INSERT INTO public.exercise_example_bundles VALUES ('90ad90a5-335d-4ff0-9e11-4b201a07a6ba', 4, '21e7460d-aa00-448b-8c82-994a73e0164c', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-26 15:20:51.083182', '2024-08-26 15:20:51.083182');
INSERT INTO public.exercise_example_bundles VALUES ('76982849-abc8-464e-afb0-447a8131dbd2', 4, '21e7460d-aa00-448b-8c82-994a73e0164c', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-26 15:20:51.083182', '2024-08-26 15:20:51.083182');
INSERT INTO public.exercise_example_bundles VALUES ('e7bf4936-7256-470e-bbe7-7e0cc9fb3417', 7, '21e7460d-aa00-448b-8c82-994a73e0164c', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-26 15:20:51.083182', '2024-08-26 15:20:51.083182');
INSERT INTO public.exercise_example_bundles VALUES ('ae3dd37f-9fa3-4f6b-b55e-6b5b602a2eb0', 85, '21e7460d-aa00-448b-8c82-994a73e0164c', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-26 15:20:51.083182', '2024-08-26 15:20:51.083182');
INSERT INTO public.exercise_example_bundles VALUES ('0bcb7511-93a0-44d3-84f9-069817c301b9', 3, 'ee8cc366-d33b-45a6-84b0-4ab416585ad1', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-27 16:05:54.978989', '2024-08-27 16:05:54.978989');
INSERT INTO public.exercise_example_bundles VALUES ('184b87a1-9a62-4c30-84af-1d41ee495921', 5, 'ee8cc366-d33b-45a6-84b0-4ab416585ad1', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-27 16:05:54.978989', '2024-08-27 16:05:54.978989');
INSERT INTO public.exercise_example_bundles VALUES ('9d8bb8b1-eaaa-45fd-bd2a-793ffdf705bb', 7, 'ee8cc366-d33b-45a6-84b0-4ab416585ad1', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 16:05:54.978989', '2024-08-27 16:05:54.978989');
INSERT INTO public.exercise_example_bundles VALUES ('5d6a57a3-3484-4157-8e13-704b6fc2b01f', 20, 'ee8cc366-d33b-45a6-84b0-4ab416585ad1', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 16:05:54.978989', '2024-08-27 16:05:54.978989');
INSERT INTO public.exercise_example_bundles VALUES ('228def8d-0219-4b5f-b953-77558ab99b01', 65, 'ee8cc366-d33b-45a6-84b0-4ab416585ad1', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 16:05:54.978989', '2024-08-27 16:05:54.978989');
INSERT INTO public.exercise_example_bundles VALUES ('0c6a8197-d0c6-4436-b902-0e06b20f08ac', 85, '490df80e-d34c-42cf-bfe5-c27ddd2cd734', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:08:58.77674', '2024-08-27 17:08:58.77674');
INSERT INTO public.exercise_example_bundles VALUES ('9f643fad-c319-409f-996f-f73ed0be2be5', 7, '490df80e-d34c-42cf-bfe5-c27ddd2cd734', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:08:58.77674', '2024-08-27 17:08:58.77674');
INSERT INTO public.exercise_example_bundles VALUES ('e73950e2-a50a-43af-921c-511a7bf30eae', 5, '490df80e-d34c-42cf-bfe5-c27ddd2cd734', 'b4658891-9713-48c4-864c-8dd907da19b0', '2024-08-27 17:08:58.77674', '2024-08-27 17:08:58.77674');
INSERT INTO public.exercise_example_bundles VALUES ('4a711708-1db5-4d8a-b0b4-9b7a0de9ed8b', 3, '490df80e-d34c-42cf-bfe5-c27ddd2cd734', 'f6e65bfe-0746-4a8f-8210-0e9bf88d9886', '2024-08-27 17:08:58.77674', '2024-08-27 17:08:58.77674');
INSERT INTO public.exercise_example_bundles VALUES ('dc847242-4679-44c9-b745-7b297eac4c01', 55, 'e21344ff-b825-4a99-bf8b-a778bf1964d1', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:14:24.429554', '2024-08-27 17:14:24.429554');
INSERT INTO public.exercise_example_bundles VALUES ('0600b519-6d37-4fde-b790-79ea0d48112f', 25, 'e21344ff-b825-4a99-bf8b-a778bf1964d1', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 17:14:24.429554', '2024-08-27 17:14:24.429554');
INSERT INTO public.exercise_example_bundles VALUES ('328de5b9-70a8-4eb9-b08f-9520e3cbb86e', 15, 'e21344ff-b825-4a99-bf8b-a778bf1964d1', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:14:24.429554', '2024-08-27 17:14:24.429554');
INSERT INTO public.exercise_example_bundles VALUES ('223035aa-6c8e-418b-8285-f93ab5950ef2', 5, 'e21344ff-b825-4a99-bf8b-a778bf1964d1', 'f6e65bfe-0746-4a8f-8210-0e9bf88d9886', '2024-08-27 17:14:24.429554', '2024-08-27 17:14:24.429554');
INSERT INTO public.exercise_example_bundles VALUES ('d75b33f1-1a5d-4443-8165-207c728f97de', 85, 'd6743870-0d5a-4180-9671-181b8f65e03e', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:17:13.843181', '2024-08-27 17:17:13.843181');
INSERT INTO public.exercise_example_bundles VALUES ('09b6b03b-1f0a-411f-b4a9-65e0e3dd6251', 10, 'd6743870-0d5a-4180-9671-181b8f65e03e', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:17:13.843181', '2024-08-27 17:17:13.843181');
INSERT INTO public.exercise_example_bundles VALUES ('194b2a4e-0e5b-4ce2-9eba-ad5f6ed14e28', 5, 'd6743870-0d5a-4180-9671-181b8f65e03e', 'b4658891-9713-48c4-864c-8dd907da19b0', '2024-08-27 17:17:13.843181', '2024-08-27 17:17:13.843181');
INSERT INTO public.exercise_example_bundles VALUES ('95ad4d7e-324f-40cc-9d49-45db44ea0f1f', 90, '855bd9e5-3546-4cfd-b048-e8017f01bfeb', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:37:27.246315', '2024-08-27 17:37:27.246315');
INSERT INTO public.exercise_example_bundles VALUES ('e7f23007-ba25-4d73-843e-511f4cfd5737', 7, '855bd9e5-3546-4cfd-b048-e8017f01bfeb', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:37:27.246315', '2024-08-27 17:37:27.246315');
INSERT INTO public.exercise_example_bundles VALUES ('ca071223-d031-49f3-8998-0a4e9c43ac04', 3, '855bd9e5-3546-4cfd-b048-e8017f01bfeb', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 17:37:27.246315', '2024-08-27 17:37:27.246315');
INSERT INTO public.exercise_example_bundles VALUES ('fe5a7d39-3e3a-4a5c-94bb-c2c3a9f41bd7', 85, '53defdc5-bfec-4af4-bfba-60440e3493cc', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:40:04.038365', '2024-08-27 17:40:04.038365');
INSERT INTO public.exercise_example_bundles VALUES ('dc55bf23-a1e2-439a-a330-313276f65c49', 10, '53defdc5-bfec-4af4-bfba-60440e3493cc', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:40:04.038365', '2024-08-27 17:40:04.038365');
INSERT INTO public.exercise_example_bundles VALUES ('4b4553ac-4060-4f3e-88db-7366cde47744', 5, '53defdc5-bfec-4af4-bfba-60440e3493cc', 'b4658891-9713-48c4-864c-8dd907da19b0', '2024-08-27 17:40:04.038365', '2024-08-27 17:40:04.038365');
INSERT INTO public.exercise_example_bundles VALUES ('43b6f73e-fbbb-4174-86d0-ffdca377721d', 85, '748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:41:21.150235', '2024-08-27 17:41:21.150235');
INSERT INTO public.exercise_example_bundles VALUES ('33498eb0-fac1-4a2e-84c5-ad04089181ab', 10, '748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-27 17:41:21.150235', '2024-08-27 17:41:21.150235');
INSERT INTO public.exercise_example_bundles VALUES ('86d04a02-0f80-4f1e-88b9-df9a92e05310', 5, '748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:41:21.150235', '2024-08-27 17:41:21.150235');
INSERT INTO public.exercise_example_bundles VALUES ('4250a8bb-f09e-40be-b305-8a58e486319c', 90, 'a90f4822-63c5-42b9-943c-ff0ceacad1eb', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-27 17:44:25.493574', '2024-08-27 17:44:25.493574');
INSERT INTO public.exercise_example_bundles VALUES ('e85c86b2-941a-41d7-a060-ae9efcc440ef', 7, 'a90f4822-63c5-42b9-943c-ff0ceacad1eb', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-27 17:44:25.493574', '2024-08-27 17:44:25.493574');
INSERT INTO public.exercise_example_bundles VALUES ('8c5fc4c7-284f-47b1-b3d3-667369204674', 3, 'a90f4822-63c5-42b9-943c-ff0ceacad1eb', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 17:44:25.493574', '2024-08-27 17:44:25.493574');


--
-- Data for Name: exercise_examples; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.exercise_examples VALUES ('650e9725-d36c-4688-bcab-adf93dfe9e5d', 'EZ Bar Skullcrusher', '2024-08-23 15:44:41.300424', '2024-08-23 15:44:41.300424', 'https://www.mensjournal.com/.image/t_share/MTk2OTg4MTk1NjA1MzI1NDUy/barbellskullcrusher.jpg', 'Select your desired weight and sit on the edge of a flat bench.
To get into position, lay back and keep the bar close to your chest. Once you are supine, press the weight to lockout.
Lower the weights towards your head by unlocking the elbows and allowing the ez bar to drop toward your forehead or just above.
Once your forearms reach parallel or just below, reverse the movement by extending the elbows while flexing the triceps to lockout the weight.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('3b828d2f-797f-4a45-9d1d-1d3efe38fb54', 'Weighted Tricep Dips', '2024-08-23 15:50:27.637943', '2024-08-23 15:50:27.637943', 'https://steelsupplements.com/cdn/shop/articles/shutterstock_566901937_2000x.jpg?v=1599047555', 'Step up onto the dip station (if possible) and position your hands with a neutral grip.
Initiate the dip by unlocking the elbows and slowly lowering the body until the forearms are almost parallel with the floor.
Control the descent to parallel and then drive back to the starting position by pushing through the palms.
Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'advanced');
INSERT INTO public.exercise_examples VALUES ('b790c6a6-ecd1-4b3a-afbc-22cd82e55658', 'Lying Dumbbell Extension', '2024-08-23 14:29:51.253789', '2024-08-23 14:29:51.253789', 'https://weighttrainingexercises4you.com/wp-content/uploads/Lying-Dumbbell-Triceps-Extension.jpg', 'Grab a pair of dumbbells and sit on the end of a flat bench with the dumbbells resting on your thighs.
Lie back on the bench and extend the dumbbells above your head. The dumbbells should not be touching and you should be using a neutral grip (palms facing each other).
Bending at the elbows only, keeping your elbows fixed and pointing at your hips, slowly lower the dumbbells down beside your head until they are about level with your ears.
Pause and squeeze the triceps. Then raise the dumbbells back to the starting position.
Do not lock the elbows out, and then repeat for desired reps.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('6cb225d2-be00-461d-9bf0-7f0c87cfea0b', 'Straight Bar Tricep Extension', '2024-08-23 13:51:17.085276', '2024-08-23 13:51:17.085276', 'https://miro.medium.com/v2/resize:fit:683/0*WTHf_Xa35BeFOEAl.jpg', 'Attach a straight bar to a cable stack as high as possible and assume a standing position.
Grasp the straight bar with a pronated grip (palms facing down) and lean forward slightly by hinging at the hips.
Initiate the movement by extending the elbows and flexing the triceps.
Pull the handle downward until the elbows are almost locked out and then slowly lower under control back to the starting position.
Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('4d3a89ab-70ae-4311-8b40-a058b2f3057b', 'Seated Dumbbell Tricep Extension', '2024-08-23 14:41:48.900488', '2024-08-23 14:41:48.900488', 'https://www.dmoose.com/cdn/shop/articles/1_f16231a6-e9e2-4ff0-b3f1-b1ccdfbac2dc.jpg?v=1658323250', '', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('0e2fe1e8-f8f1-48e6-b360-8c9d4d9991a6', 'Rope Tricep Extension', '2024-08-23 14:53:43.902288', '2024-08-23 14:53:43.902288', 'https://www.dmoose.com/cdn/shop/articles/1_6a24d912-5f74-43d4-bc20-578944bd99f7.jpg?v=1648734107', 'Attach a rope to a cable stack as high as possible and assume a standing position.
Grasp the rope with a neutral grip (palms facing in) and lean forward slightly by hinging at the hips.
Initiate the movement by extending the elbows and flexing the triceps.
Pull the rope downward until the elbows are almost locked out and then slowly lower under control back to the starting position.
Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('ab0d7384-444e-446a-911d-f64ac31db8ef', 'Close Grip Bench Press', '2024-08-23 15:30:18.860564', '2024-08-23 15:30:18.860564', 'https://steelsupplements.com/cdn/shop/articles/shutterstock_69079681_2000x.jpg?v=1599316230', 'Lie flat on a bench and set your hands at shoulder width.
Set your shoulder blades by pinching them together and driving them into the bench.
Take a deep breath and allow your spotter to help you with the lift off in order to maintain tightness through your upper back.
Let the weight settle and ensure your upper back remains tight after lift off.
Inhale and allow the bar to descend slowly by unlocking the elbows.
Lower the bar in a straight line to the base of the sternum (breastbone) and touch the chest.
Push the bar back up in a straight line by pressing yourself into the bench, driving your feet into the floor for leg drive, and extending the elbows.
Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('7517ae2f-c198-4a33-8a1d-1dc7327d1430', '45 Degree Lying Tricep Extension (EZ Bar)', '2024-08-23 20:29:25.181737', '2024-08-23 20:29:25.181737', 'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2015/10/triceps-article-social.jpg?quality=86&strip=all', 'Sit on the end of a flat bench width a barbell on your thighs.
Grip the EZ-bar on the inner grips. Bring the bar up to your chest and lay down on your back.
Extend your arms straight up above your chest.
Keeping your arms straight move the bar back so it is angled out past your head.
Keeping your elbows fixed in place and not pointing out, slowly lower the bar until it is almost touching the top of your head or bench behind your head.
Pause, and then slowly extend your arms back to the starting position.
Do not lock your elbows out, and then repeat for desired reps.', 'isolation', 'free', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('4aafe702-f2fc-4fa2-a7fb-c31c279adeda', '45 Degree Lying Tricep Extension', '2024-08-23 20:36:43.346849', '2024-08-23 20:36:43.346849', 'https://www.bodybuilding.com/fun/images/2015/your-complete-guide-to-skullcrushers-graphics-45-degree-skullcrusher-700xh.jpg', 'Sit on the end of a flat bench with a barbell on your thighs.
Grip the barbell with an overhand (palms facing down) with your hands about shoulder width apart.
Bring the bar up to your chest and lay down on your back.
Extend your arms straight up above your chest.
Keeping your arms straight, move the bar back to the position shown in the video above.
Keeping your elbows fixed in place and not pointing out, slowly lower the bar until it is almost touching the top of your head or bench behind your head.
Pause, and then slowly extend your arms back to the starting position.
Do not lock your elbows out, and then repeat for desired reps.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('faf6674c-2a2a-4b03-ab8b-7a033052b572', 'Alternating Bent-Over Dumbbell Kickback ', '2024-08-24 13:49:36.23273', '2024-08-24 13:49:36.23273', 'https://hips.hearstapps.com/hmg-prod/images/young-man-working-out-with-dumbbell-at-gym-royalty-free-image-1667582833.jpg?crop=1xw:0.84415xh;center,top', 'Select the appropriate dumbbells and place them on the floor in front of you.
Bending at the knees and keeping your back straight, squat down and pick up the dumbbells with a neutral grip (palms facing inward). Your feet should be around shoulder-width apart.
Get into the starting position by keeping your back straight, bending slightly at the knees, and bending over at the waist. Your torso should almost be parallel to the floor.
Tuck your upper arms close to your torso and bend at the elbows, forming a 90-degree angle with your upper arms and forearms. This is the starting position. 
Beginning with your left arm and moving only at the elbow, raise the dumbbell behind you until your arm is fully extended.
Pause, and then lower the dumbbell back to the starting position.
Repeat this movement with your right arm and then repeat for desired reps.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('c21d3b0f-c8a8-4b7f-92ea-90dc567a1183', 'Close Grip EZ Bar Press', '2024-08-26 14:36:25.633347', '2024-08-26 14:36:25.633347', 'https://s3assets.skimble.com/assets/1141234/image_iphone.jpg', 'Select your desired weight and sit on the edge of a flat bench.
To get into position, lay back and keep the bar close to your chest using a neutral grip. Once you are supine, press the weight to lockout.
Unlock the elbows and extend the shoulders to lower the weight to your chest.
Once the bar touches your chest, reverse the movement by extending the elbows while flexing the triceps to lockout the weight.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('93e6b1c4-0510-41d4-983c-a1fde003881f', 'Alternating Dumbbell Floor Press', '2024-08-24 13:55:14.325068', '2024-08-24 13:55:14.325068', 'https://cdn.shopify.com/s/files/1/2623/4904/files/Dumbbell_Floor_Press_b2da358c-6c1e-4ab5-98a6-98e24bfa6d52_600x600.png?v=1659337818', 'Begin sitting on the floor in an upright position with your legs straight and the dumbbells vertically balanced on the floor.
Pick up each dumbbell and set it high in your hip crease while maintaining a tight grip.
Slowly lay back while keeping the dumbbells close to your chest and bend your knees to roughly 45 degrees and move your feet up slightly.
Press the weights to full extension by contracting your triceps and chest.
Slowly lower one dumbbell under control as far as comfortably possible (the handle should be about level with your chest) while keeping the other locked out at the top.
Contract the chest and triceps to push the dumbbell back to the starting position.
Slowly lower the other dumbbell under control until your elbow touches the floor while keeping the other locked out at the top.
To complete the exercise, simply lower the weights to the ground in “controlled drop” fashion. It should be a smooth motion but not one requiring excessive effort or one that puts the shoulder under unnecessary risk.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('0eaa8980-e29e-4f33-88b0-915db5cf309a', 'Alternating Lying Dumbbell Extension', '2024-08-24 15:00:28.238965', '2024-08-24 15:00:28.238965', 'https://weighttrainingexercises4you.com/wp-content/uploads/Alternating-Lying-Dumbbell-Triceps-Extension.jpg', 'Set up for the exercise by setting a pair of dumbbells at the end of a flat bench.
Pick up the dumbbells off the floor using a neutral grip (palms facing in), position the ends of the dumbbells on your thighs, and sit down on the bench.
To get in position you need to rock back pushing the dumbbells back with your thighs and only slightly bending at the elbows.
Now you should be in a position to start the set, laying back on the bench and holding the dumbbells straight up above your chest with a neutral grip.
Slowly lower the left dumbbell down by bending only at the elbow. You will be moving in a semi-circular motion until the dumbbell is about even with your left ear. Continue to hold the right dumbbell in place.
Pause, and then raise the dumbbell back to the starting position. 
Repeat the movement with your right arm and then repeat for desired reps.', 'isolation', 'free', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('9f0c8916-a08b-4fe5-9f24-e1680ef627a8', 'Bench Dip', '2024-08-24 15:05:24.055319', '2024-08-24 15:05:24.055319', 'https://steelsupplements.com/cdn/shop/articles/shutterstock_1526664821_1000x.jpg?v=1644523346', 'Set up for the bench dip by placing 2 flat benches parallel to one another to around 4-5 feet apart (you may need to adjust the width to suit your height).
Put your heels on the edge of one bench around shoulder-width apart.
Place your hands on the edge of the other bench. This is the starting position for the exercise.
Keeping your body close to the bench, slowly dip down until your elbows are at the same height as your shoulders.
Slowly push back up, squeezing through the triceps.
Do not lock the elbows out at the top of the exercise, and repeat.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('547f1f7e-3ee1-4b39-99eb-3462b1ec13af', 'Bent Over Dumbbell Tricep Kickback', '2024-08-24 15:14:04.484126', '2024-08-24 15:14:04.484126', 'https://hips.hearstapps.com/hmg-prod/images/triceps-kickback-1551296273.jpg', 'Select the desired weight from the rack and stand in an open area.
Hinge forward, row the dumbbells into position, then extend the elbows while flexing the triceps.
Slowly lower the dumbbells back to the starting position and repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('275097d4-3c8d-4040-9b2e-5f294919df04', 'Cable Concentration Tricep Extension', '2024-08-24 15:21:25.308798', '2024-08-24 15:21:25.308798', 'https://www.bodybuilding.com/images/2016/june/7-best-triceps-exercises-youre-not-doing-v2-7-700xh.jpg', 'Set up for the exercise by attaching a single grip handle to a high pulley cable machine and selecting the weight you want to use on the stack.
Grab the handle with an underhand grip (palm facing up) with your right hand.
Turn so your left side is facing the cable machine and drop your left knee to the floor.
Your right thigh should be parallel to the floor, as it will be used as a support during the exercise.
Position the back of your elbow (bottom of the tricep) against your inner right thigh. This is the starting position for the exercise.
Keeping your body fixed, slowly extend the arm as far as possible.
Squeeze the tricep, and then slowly lower the weight back to the starting position.
Repeat for desired reps.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('5985d847-0473-444e-8fe0-9da5341ef986', 'Cable Tricep Extension With V-Bar', '2024-08-26 14:10:38.408306', '2024-08-26 14:10:38.408306', 'https://atletiq.com/content/exercises/243/male_1.jpg', 'Attach a v-bar to a cable stack as high as possible and assume a standing position.
Grasp the v-bar with a semi pronated grip (palms slightly facing) and lean forward slightly by hinging at the hips.
Initiate the movement by extending the elbows and flexing the triceps.
Pull the handle downward until the elbows are almost locked out and then slowly lower under control back to the starting position.
Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('11644e17-247a-46b0-a391-b3b2a2a6bba8', 'Cable Tricep Kickback', '2024-08-26 14:15:00.627444', '2024-08-26 14:15:00.627444', 'https://bodybuilding-wizard.com/wp-content/uploads/2015/02/cable-tricep-kickback-2.jpg', 'Set up for the cable tricep kickback by attaching a single grip handle to a low pulley cable machine and selecting the weight you want to use.
Grab the handle using your left hand with an overhand grip and take a step back from the cable machine.
Keeping your feet together and knees slightly bent, bend down until your body is around parallel to the floor.
Use your free right hand to stabilize yourself.
Bring the elbow up as far as possible and keep it tight by your side. This is the starting position for the exercise.
Keeping your elbow in place and your body fixed, extend your arm out as far as possible.
Squeeze the tricep, and then slowly lower the weight back to the starting position.
Repeat for desired reps.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('50774526-c91f-4d71-82a8-456526b0fbd0', 'California Skullcrusher', '2024-08-26 14:21:24.510891', '2024-08-26 14:21:24.510891', 'https://www.bodybuilding.com/fun/images/2015/your-complete-guide-to-skullcrushers-desktop-2-960x540.jpg', 'Select your desired weight and sit on the edge of a flat bench.
To get into position, lay back and keep the bar close to your chest using a neutral grip. Once you are supine, press the weight to lockout.
Unlock the elbows and allow the ez bar to drop toward your forehead or just above.
Once your forearms reach parallel or just below, allow the upper arms to extend overhead (similar to a pullover).
As the arms reach full extension, pull the elbows back to the starting position and then extend the elbows while flexing the triceps to lockout the weight.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('385fb192-7c2c-405a-b483-f36e32e241c8', 'Close Grip Chest Press', '2024-08-26 14:31:15.917591', '2024-08-26 14:31:15.917591', 'https://www.dmoose.com/cdn/shop/articles/1_155d781f-a698-40e7-bdb6-f0de019f9b89.jpg?v=1648738774', 'Set up for the close grip chest press by adjusting the rack height (if adjustable) and loading the weight you want to use on the barbell.
Lay back on the bench with your feet firmly on the floor.
Grab the bar with an overhand grip (palms facing your feet) with your hands around 12 inches apart. 
Take the barbell off the rack and hold it straight above your chest. Bend the elbows slightly to take the weight onto your chest/triceps.
Slowly lower the bar to your middle chest.
Pause, then slowly push the bar back to the starting position. Don''t lock your elbows out!
Repeat for desired reps.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('04d275d8-71df-4695-ace9-899ce6e41b29', 'Seated Dumbbell Tricep Extension', '2024-08-26 14:39:55.622736', '2024-08-26 14:39:55.622736', 'https://www.dmoose.com/cdn/shop/articles/1_f16231a6-e9e2-4ff0-b3f1-b1ccdfbac2dc.jpg?v=1658323250', 'Select the desired weight from the rack and position an adjustable bench at 90 degrees.
To get into position, sit in an upright position and lift the dumbbell to the top of your shoulder. Take a deep breath, overlap your hands around the dumbbell, then press it into position overhead.
Maintain an overlapping grip and slowly lower the dumbbell behind your head by unlocking your elbows.
Once your forearms reach parallel or just below, drive the dumbbell back to the starting point by extending the elbows and flexing the triceps.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('1b4402c2-2459-45c1-8d24-356322c71d20', 'Two Arm Standing Dumbbell Extension', '2024-08-26 14:46:34.072768', '2024-08-26 14:46:34.072768', 'https://media.post.rvohealth.io/wp-content/uploads/2021/10/overhead-tricep-extension-dumbbell-732x549-thumbnail.jpg', 'Select the desired weight from the rack and stand in an open area.
To get into position, lift the dumbbell to the top of your shoulder, take a deep breath, overlap your hands around the dumbbell, then press it into position overhead.
Maintain an overlapped grip and slowly lower the dumbbell behind your head by unlocking your elbows.
Once your forearms reach parallel or just below, drive the dumbbell back to the starting point by extending the elbows and flexing the triceps.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('4f9bdd10-28bc-447e-8cf5-fbf47cd9af79', 'French Press', '2024-08-26 14:52:11.233011', '2024-08-26 14:52:11.233011', 'https://www.guinnessworldrecords.com/world-records/images/619083-most-weight-lifted-by-ez-bar-french-press-french-curl-in-one-minute-header.jpg', 'Set up for the french press by loading a barbell or EZ-bar with the appropriate amount of weight and placing it on the floor in front of you.
Bend only at the knees and grasp the barbell with an overhand grip (palms facing down) with your hands about 8-12 inches apart.
Stand up straight with the bar with your feet around shoulder-width apart and a slight bend in your knees.
Lift the bar above your head and bend at your elbows slightly to take the tension onto your triceps. Your palms are now facing upward. This is the starting position for the exercise.
Keeping your elbows fixed and pointing straight up toward the ceiling, slowly lower the bar down behind your head as far as comfortably possible.
Pause, and then slowly raise the bar back to the starting position.
Don''t lock your elbows out, and then repeat the movement. ', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('6a312bde-cc33-450b-8f1d-6091ccffe9cc', 'Reverse Grip Cable Tricep Extension', '2024-08-26 15:16:20.191397', '2024-08-26 15:16:20.191397', 'https://ignorelimits.com/wp-content/uploads/2017/08/how-to-reverse-grip-cable-triceps-pushdown-Copy.jpg', 'Attach a straight bar to a cable stack as high as possible and assume a standing position.
Grasp the straight bar with a supinated grip (palms facing up) and lean forward slightly by hinging at the hips.
Initiate the movement by extending the elbows and flexing the triceps.
Pull the handle downward until the elbows are almost locked out and then slowly lower under control back to the starting position.
Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('21e7460d-aa00-448b-8c82-994a73e0164c', 'Dumbbell Tate Press', '2024-08-26 15:20:51.07074', '2024-08-26 15:20:51.07074', 'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2017/06/600-tate-press.jpg?quality=86&strip=all', 'Select the desired weight from the rack and sit down on a flat bench.
To get into position, lay back and keep the weights close to your chest. Once you are in position, take a deep breath, then press the dumbbells to lockout at the top.
Maintain a pronated grip (thumbs pointing towards each other) and allow the elbows to bend while lowering the inner portion of the dumbbells to the chest.
Once the ends of the dumbbells touch your chest, reverse the movement and flex the triceps to lockout the elbows.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('ee8cc366-d33b-45a6-84b0-4ab416585ad1', 'Close Grip Press Behind-The-Neck', '2024-08-27 16:05:54.962719', '2024-08-27 16:05:54.962719', 'https://assets.myworkouts.io/exercises-media/b6KbXDksgkfbm3TtY/close_grip_press_behind_neck_male_v5_thumb100Poster_capoff.jpg', 'Set up for the close grip behind the neck press by loading the appropriate weight onto an EZ bar or barbell and sitting on the end of a flat bench or a bench with a back rest.
Grasp the bar with a close grip (just inside shoulder width) using an overhand grip (palms facing forward).
Raise the bar straight above your head until your arms are nearly fully extended (keep a slight bend in your elbows). This is the starting position.
Slowly lower the bar down behind your neck by bending at the elbows. The bar should come down as far as comfortably possible or when your forearms are around parallel to the floor.
Slowly raise the bar back to the starting position. This is one rep.
Repeat for desired reps.', 'isolation', 'free', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('490df80e-d34c-42cf-bfe5-c27ddd2cd734', 'Decline Lying Dumbbell Extension', '2024-08-27 17:08:58.772907', '2024-08-27 17:08:58.772907', '', 'Select the desired weight from the rack and position an adjustable bench on a slight decline of 15-30 degrees.
Lay back keeping the weights close to your chest. Once your back is flat against the pad, press the weights to lockout using a neutral grip.
Lower the weights towards your shoulders by unlocking the elbows while maintaining a neutral grip.
Once your forearms reach parallel or just below, drive the dumbbell back to the starting point by extending the elbows and flexing the triceps.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('e21344ff-b825-4a99-bf8b-a778bf1964d1', 'Decline Close Grip Bench Press', '2024-08-27 17:14:24.425351', '2024-08-27 17:14:24.425351', '', 'Lie flat on an decline bench, set your hands at shoulder width, and hook your feet underneath the pad.
Set your shoulder blades by pinching them together and driving them into the bench.
Take a deep breath and allow your spotter to help you with the lift off in order to maintain tightness through your upper back.
Let the weight settle and ensure your upper back remains tight after lift off.
Inhale and allow the bar to descend slowly by unlocking the elbows.
Lower the bar in a straight line to just below your sternum (breastbone) and touch the chest.
Push the bar back up in a straight line by pressing yourself into the bench and extending the elbows.
Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('d6743870-0d5a-4180-9671-181b8f65e03e', 'Decline Lying Tricep Extension (Skullcrusher)', '2024-08-27 17:17:13.831319', '2024-08-27 17:17:13.831319', '', 'Select your desired weight and sit on the edge of an decline bench at roughly 20-30 degrees.
To get into position, lay back and keep the bar close to your chest. Once you are supine, press the weight to lockout.
Unlock the elbows and allow the ez bar to drop toward your forehead or just above.
Once your forearms reach parallel or just below, reverse the movement by extending the elbows while flexing the triceps to lockout the weight.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('855bd9e5-3546-4cfd-b048-e8017f01bfeb', 'Dumbbell Tricep Kickback', '2024-08-27 17:37:27.234715', '2024-08-27 17:37:27.234715', '', 'Set up for the dumbbell tricep kickback by grabbing a flat bench and sitting a dumbbell on the left-hand side at one end.
Position yourself on the left side of the bench with your right knee and right hand resting on the bench.
Using a neutral grip, pick up the dumbbell with your left hand. Keep your back straight and look forward.
Tuck your left upper arm close to your torso and bend at the elbow, forming a 90-degree angle with your upper arm and forearm. This is the starting position.
Moving only at the elbow, raise the dumbbell behind you until your arm is fully extended.
Pause, and then lower the dumbbell back to the starting position.
Repeat this movement for desired reps and then repeat using your right arm.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('53defdc5-bfec-4af4-bfba-60440e3493cc', 'EZ Bar Incline Skullcrusher', '2024-08-27 17:40:04.03333', '2024-08-27 17:40:04.03333', '', 'Select your desired weight and sit on the edge of an adjustable bench set at 20-30 degrees.
To get into position, lay back and keep the bar close to your chest. Once you are supine, press the weight to lockout.
Unlock the elbows and allow the ez bar to drop toward your forehead or just above.
Once your forearms reach parallel or just below, reverse the movement by extending the elbows while flexing the triceps to lockout the weight.
Repeat for the desired number of repetitions.', 'isolation', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2', 'High Pulley Overhead Tricep Extension (Rope Extension)', '2024-08-27 17:41:21.141757', '2024-08-27 17:41:21.141757', '', 'Attach a rope to a cable stack as high as possible and assume a standing position.
Utilize a split stance, grasp the rope overhead with a neutral grip (palms facing), and lean forward by hinging at the hips.
Initiate the movement by extending the elbows and flexing the triceps.
Pull the rope downward until the elbows are almost locked out and then slowly lower under control back to the starting position.
Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('a90f4822-63c5-42b9-943c-ff0ceacad1eb', 'High Pulley Overhead Tricep Extension', '2024-08-27 17:44:25.490434', '2024-08-27 17:44:25.490434', '', 'Set up for the high pulley tricep extension by attaching a straight bar to a high pulley and selecting the weight you want to use on the stack.
Facing away from the pulley, grab the bar behind your neck with an overhand grip at shoulder width apart.
Bend over at the waist until your torso is almost parallel to the floor. This will lift the weight slightly from the stack.
You can stagger your feet and bend slightly at the knees to help with balance.
Your upper arms should be parallel to the floor at this point and you should be grabbing the bar behind your head. You are now in the starting position.
Moving only at your elbow joints, slowly push the bar out in from of your body until your arms are fully extended. 
Pause, and then slowly bring the bar back to the starting position.
Repeat this movement for desired reps.', 'isolation', 'fixed', 'push', 'beginner');


--
-- Data for Name: exercise_examples_equipments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.exercise_examples_equipments VALUES ('18eac9b2-be10-4878-a7ad-cc7a56f4c846', '2024-08-23 13:51:17.110081', '2024-08-23 13:51:17.110081', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '6cb225d2-be00-461d-9bf0-7f0c87cfea0b');
INSERT INTO public.exercise_examples_equipments VALUES ('30d229f2-dbe0-4c88-ae9e-f194a7a8d323', '2024-08-23 13:51:17.110081', '2024-08-23 13:51:17.110081', '15495639-2adb-41b8-899c-493ac0172f57', '6cb225d2-be00-461d-9bf0-7f0c87cfea0b');
INSERT INTO public.exercise_examples_equipments VALUES ('3878ca87-c414-4a75-b59f-29a12f24c9ee', '2024-08-23 14:29:51.284754', '2024-08-23 14:29:51.284754', '9d66ac93-3a48-429d-aeaa-54302856e204', 'b790c6a6-ecd1-4b3a-afbc-22cd82e55658');
INSERT INTO public.exercise_examples_equipments VALUES ('042477ef-e59a-434d-a0e1-11b576345a4e', '2024-08-23 14:29:51.284754', '2024-08-23 14:29:51.284754', '85dbccf6-454e-4440-8905-50a90d91dbcc', 'b790c6a6-ecd1-4b3a-afbc-22cd82e55658');
INSERT INTO public.exercise_examples_equipments VALUES ('89bed541-8da6-4559-808e-e34b2dde6345', '2024-08-23 14:41:48.924103', '2024-08-23 14:41:48.924103', '9d66ac93-3a48-429d-aeaa-54302856e204', '4d3a89ab-70ae-4311-8b40-a058b2f3057b');
INSERT INTO public.exercise_examples_equipments VALUES ('69d34b8c-9bb3-4ed7-bb21-8c3a803c7eca', '2024-08-23 14:41:48.924103', '2024-08-23 14:41:48.924103', '85dbccf6-454e-4440-8905-50a90d91dbcc', '4d3a89ab-70ae-4311-8b40-a058b2f3057b');
INSERT INTO public.exercise_examples_equipments VALUES ('38b56251-60a5-408c-83af-c5d33d61c7da', '2024-08-23 14:53:43.92338', '2024-08-23 14:53:43.92338', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '0e2fe1e8-f8f1-48e6-b360-8c9d4d9991a6');
INSERT INTO public.exercise_examples_equipments VALUES ('4c3e2a94-a011-4e8e-beed-1e0348721c85', '2024-08-23 14:53:43.92338', '2024-08-23 14:53:43.92338', 'af38ec0a-1465-45a8-99ba-a394224530dc', '0e2fe1e8-f8f1-48e6-b360-8c9d4d9991a6');
INSERT INTO public.exercise_examples_equipments VALUES ('49782b9d-fbf1-4930-8b1e-39f5f4b17d58', '2024-08-23 15:30:18.903829', '2024-08-23 15:30:18.903829', 'b17ae8af-2d78-4e77-b45b-39253c28247a', 'ab0d7384-444e-446a-911d-f64ac31db8ef');
INSERT INTO public.exercise_examples_equipments VALUES ('bbdbe4a6-a6eb-4755-b30e-3a03daef2393', '2024-08-23 15:30:18.903829', '2024-08-23 15:30:18.903829', 'e7fc1da0-48df-4338-b03f-1cea01cd12d5', 'ab0d7384-444e-446a-911d-f64ac31db8ef');
INSERT INTO public.exercise_examples_equipments VALUES ('f02409fc-7bce-4fcc-85d4-e158dd891e8f', '2024-08-23 15:44:41.339864', '2024-08-23 15:44:41.339864', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '650e9725-d36c-4688-bcab-adf93dfe9e5d');
INSERT INTO public.exercise_examples_equipments VALUES ('10eacba8-7484-47ea-9d09-3d702f319c2b', '2024-08-23 15:44:41.339864', '2024-08-23 15:44:41.339864', '85dbccf6-454e-4440-8905-50a90d91dbcc', '650e9725-d36c-4688-bcab-adf93dfe9e5d');
INSERT INTO public.exercise_examples_equipments VALUES ('d1fade6c-1e1b-4bdb-80e2-c5be66f92913', '2024-08-23 15:50:27.656054', '2024-08-23 15:50:27.656054', 'c01e10b9-4ef6-4f23-9b41-7f6d5d4d1e85', '3b828d2f-797f-4a45-9d1d-1d3efe38fb54');
INSERT INTO public.exercise_examples_equipments VALUES ('bd1362af-1dd6-4e05-b7e4-98c642ea54d2', '2024-08-23 20:29:25.198434', '2024-08-23 20:29:25.198434', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '7517ae2f-c198-4a33-8a1d-1dc7327d1430');
INSERT INTO public.exercise_examples_equipments VALUES ('ab80f98c-307e-4a28-a7b0-0ea95ab0885d', '2024-08-23 20:29:25.198434', '2024-08-23 20:29:25.198434', '85dbccf6-454e-4440-8905-50a90d91dbcc', '7517ae2f-c198-4a33-8a1d-1dc7327d1430');
INSERT INTO public.exercise_examples_equipments VALUES ('13f22fa8-9d47-4d81-874b-fbea62ed7a20', '2024-08-23 20:36:43.361959', '2024-08-23 20:36:43.361959', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '4aafe702-f2fc-4fa2-a7fb-c31c279adeda');
INSERT INTO public.exercise_examples_equipments VALUES ('d254e8c0-5208-4d9d-b4ed-963e13b7cc16', '2024-08-23 20:36:43.361959', '2024-08-23 20:36:43.361959', '85dbccf6-454e-4440-8905-50a90d91dbcc', '4aafe702-f2fc-4fa2-a7fb-c31c279adeda');
INSERT INTO public.exercise_examples_equipments VALUES ('69f86c20-a30e-42e2-a53e-ed84621e1c9d', '2024-08-24 13:49:36.268549', '2024-08-24 13:49:36.268549', '9d66ac93-3a48-429d-aeaa-54302856e204', 'faf6674c-2a2a-4b03-ab8b-7a033052b572');
INSERT INTO public.exercise_examples_equipments VALUES ('2d770bea-fe04-4786-932e-bc15dd64e6ff', '2024-08-24 13:55:14.353429', '2024-08-24 13:55:14.353429', '9d66ac93-3a48-429d-aeaa-54302856e204', '93e6b1c4-0510-41d4-983c-a1fde003881f');
INSERT INTO public.exercise_examples_equipments VALUES ('be1b632c-b299-4966-a8dc-2edbc2f0a1bb', '2024-08-24 15:00:28.276311', '2024-08-24 15:00:28.276311', '9d66ac93-3a48-429d-aeaa-54302856e204', '0eaa8980-e29e-4f33-88b0-915db5cf309a');
INSERT INTO public.exercise_examples_equipments VALUES ('268c38c2-ca53-4c01-8cf3-84d04c8b6ba2', '2024-08-24 15:00:28.276311', '2024-08-24 15:00:28.276311', '85dbccf6-454e-4440-8905-50a90d91dbcc', '0eaa8980-e29e-4f33-88b0-915db5cf309a');
INSERT INTO public.exercise_examples_equipments VALUES ('1d820e1c-d5b4-4508-be3d-40bed6caf5cf', '2024-08-24 15:05:24.076016', '2024-08-24 15:05:24.076016', '85dbccf6-454e-4440-8905-50a90d91dbcc', '9f0c8916-a08b-4fe5-9f24-e1680ef627a8');
INSERT INTO public.exercise_examples_equipments VALUES ('1c6d7cc2-ad98-4caf-a03a-8f718de298e1', '2024-08-24 15:14:04.506549', '2024-08-24 15:14:04.506549', '9d66ac93-3a48-429d-aeaa-54302856e204', '547f1f7e-3ee1-4b39-99eb-3462b1ec13af');
INSERT INTO public.exercise_examples_equipments VALUES ('d72c94d3-3ede-4a1d-9976-fcc1afcfe9e9', '2024-08-24 15:21:25.329077', '2024-08-24 15:21:25.329077', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '275097d4-3c8d-4040-9b2e-5f294919df04');
INSERT INTO public.exercise_examples_equipments VALUES ('1ea89282-bb1f-4180-be24-3204e4b018cc', '2024-08-24 15:21:25.329077', '2024-08-24 15:21:25.329077', '331a0c35-f5a5-478d-ba7c-9f14ba2ee0fa', '275097d4-3c8d-4040-9b2e-5f294919df04');
INSERT INTO public.exercise_examples_equipments VALUES ('82b1cf49-36bb-4782-b791-c412629e44a3', '2024-08-26 14:10:38.427023', '2024-08-26 14:10:38.427023', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '5985d847-0473-444e-8fe0-9da5341ef986');
INSERT INTO public.exercise_examples_equipments VALUES ('26d6be34-ab58-483c-973b-2b6b44ae32fb', '2024-08-26 14:10:38.427023', '2024-08-26 14:10:38.427023', '524da8cf-0303-4c53-8761-832a5fdb54ed', '5985d847-0473-444e-8fe0-9da5341ef986');
INSERT INTO public.exercise_examples_equipments VALUES ('9df444cb-f6ec-46e6-be44-382e92bf1f74', '2024-08-26 14:15:00.646836', '2024-08-26 14:15:00.646836', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '11644e17-247a-46b0-a391-b3b2a2a6bba8');
INSERT INTO public.exercise_examples_equipments VALUES ('3c8c831c-be6b-4c40-8342-f0d954a5a051', '2024-08-26 14:21:24.526649', '2024-08-26 14:21:24.526649', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '50774526-c91f-4d71-82a8-456526b0fbd0');
INSERT INTO public.exercise_examples_equipments VALUES ('26fc3b65-5f07-4ff9-ab98-ba3a95cd56b4', '2024-08-26 14:21:24.526649', '2024-08-26 14:21:24.526649', '85dbccf6-454e-4440-8905-50a90d91dbcc', '50774526-c91f-4d71-82a8-456526b0fbd0');
INSERT INTO public.exercise_examples_equipments VALUES ('670cce16-0591-4106-9a96-b0e051bd88a3', '2024-08-26 14:31:15.934013', '2024-08-26 14:31:15.934013', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '385fb192-7c2c-405a-b483-f36e32e241c8');
INSERT INTO public.exercise_examples_equipments VALUES ('327c5b0f-436f-471e-bb85-d3cca3304ccc', '2024-08-26 14:31:15.934013', '2024-08-26 14:31:15.934013', 'e7fc1da0-48df-4338-b03f-1cea01cd12d5', '385fb192-7c2c-405a-b483-f36e32e241c8');
INSERT INTO public.exercise_examples_equipments VALUES ('500f112d-a47a-42d7-a51e-c109c0e55241', '2024-08-26 14:36:25.650101', '2024-08-26 14:36:25.650101', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', 'c21d3b0f-c8a8-4b7f-92ea-90dc567a1183');
INSERT INTO public.exercise_examples_equipments VALUES ('eb7d7dc5-4b50-45a2-bbbb-143af87dbf29', '2024-08-26 14:36:25.650101', '2024-08-26 14:36:25.650101', '85dbccf6-454e-4440-8905-50a90d91dbcc', 'c21d3b0f-c8a8-4b7f-92ea-90dc567a1183');
INSERT INTO public.exercise_examples_equipments VALUES ('654dbcff-51cc-4663-be9c-8a32ca26b0a5', '2024-08-26 14:39:55.639589', '2024-08-26 14:39:55.639589', '9d66ac93-3a48-429d-aeaa-54302856e204', '04d275d8-71df-4695-ace9-899ce6e41b29');
INSERT INTO public.exercise_examples_equipments VALUES ('7b0c1dff-bb12-4286-b798-a4cf1c930d0a', '2024-08-26 14:39:55.639589', '2024-08-26 14:39:55.639589', '85dbccf6-454e-4440-8905-50a90d91dbcc', '04d275d8-71df-4695-ace9-899ce6e41b29');
INSERT INTO public.exercise_examples_equipments VALUES ('c09e37f5-af2f-4713-8689-9afb65465850', '2024-08-26 14:46:34.09067', '2024-08-26 14:46:34.09067', '9d66ac93-3a48-429d-aeaa-54302856e204', '1b4402c2-2459-45c1-8d24-356322c71d20');
INSERT INTO public.exercise_examples_equipments VALUES ('48cffaea-2b3b-4f81-9ae9-c273cca655f2', '2024-08-26 14:52:11.254518', '2024-08-26 14:52:11.254518', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '4f9bdd10-28bc-447e-8cf5-fbf47cd9af79');
INSERT INTO public.exercise_examples_equipments VALUES ('9a73cd1f-c0b6-428c-b244-29cb35215685', '2024-08-26 15:16:20.205226', '2024-08-26 15:16:20.205226', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '6a312bde-cc33-450b-8f1d-6091ccffe9cc');
INSERT INTO public.exercise_examples_equipments VALUES ('03882ba0-6533-4556-bd5f-52c3e40b3a68', '2024-08-26 15:16:20.205226', '2024-08-26 15:16:20.205226', '15495639-2adb-41b8-899c-493ac0172f57', '6a312bde-cc33-450b-8f1d-6091ccffe9cc');
INSERT INTO public.exercise_examples_equipments VALUES ('28bbaf0c-aba8-4da2-a0cf-c8578b7b9da9', '2024-08-26 15:20:51.090958', '2024-08-26 15:20:51.090958', '9d66ac93-3a48-429d-aeaa-54302856e204', '21e7460d-aa00-448b-8c82-994a73e0164c');
INSERT INTO public.exercise_examples_equipments VALUES ('0692ecf0-4068-49a7-b6db-be6c49ea7568', '2024-08-26 15:20:51.090958', '2024-08-26 15:20:51.090958', '85dbccf6-454e-4440-8905-50a90d91dbcc', '21e7460d-aa00-448b-8c82-994a73e0164c');
INSERT INTO public.exercise_examples_equipments VALUES ('f67de955-3f11-4582-b4ae-b7f7cadf152d', '2024-08-27 16:05:54.993335', '2024-08-27 16:05:54.993335', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', 'ee8cc366-d33b-45a6-84b0-4ab416585ad1');
INSERT INTO public.exercise_examples_equipments VALUES ('ab289319-cdfb-4cd8-af2c-f098fd619382', '2024-08-27 16:05:54.993335', '2024-08-27 16:05:54.993335', '85dbccf6-454e-4440-8905-50a90d91dbcc', 'ee8cc366-d33b-45a6-84b0-4ab416585ad1');
INSERT INTO public.exercise_examples_equipments VALUES ('e97ffe69-97ee-4a11-bd73-a6a8ecf924f9', '2024-08-27 17:08:58.779312', '2024-08-27 17:08:58.779312', '9d66ac93-3a48-429d-aeaa-54302856e204', '490df80e-d34c-42cf-bfe5-c27ddd2cd734');
INSERT INTO public.exercise_examples_equipments VALUES ('6f55bf0d-3bee-4ddd-9141-08e368809a62', '2024-08-27 17:08:58.779312', '2024-08-27 17:08:58.779312', 'c4d5e6fe-30fd-4f16-8646-634102d1bf1b', '490df80e-d34c-42cf-bfe5-c27ddd2cd734');
INSERT INTO public.exercise_examples_equipments VALUES ('4c6b53f9-7fc1-4682-b98d-8f429afa4f1b', '2024-08-27 17:14:24.432331', '2024-08-27 17:14:24.432331', 'b17ae8af-2d78-4e77-b45b-39253c28247a', 'e21344ff-b825-4a99-bf8b-a778bf1964d1');
INSERT INTO public.exercise_examples_equipments VALUES ('10331756-3ad0-430e-88a0-c189e5c83d47', '2024-08-27 17:14:24.432331', '2024-08-27 17:14:24.432331', '9677e942-8a9b-4754-a27f-7e4d945681a1', 'e21344ff-b825-4a99-bf8b-a778bf1964d1');
INSERT INTO public.exercise_examples_equipments VALUES ('50d919a7-85d0-4214-8741-348e907a78b5', '2024-08-27 17:17:13.853581', '2024-08-27 17:17:13.853581', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', 'd6743870-0d5a-4180-9671-181b8f65e03e');
INSERT INTO public.exercise_examples_equipments VALUES ('7425c787-5ca8-4fc8-bb4d-565d5fe0cd0c', '2024-08-27 17:17:13.853581', '2024-08-27 17:17:13.853581', 'c4d5e6fe-30fd-4f16-8646-634102d1bf1b', 'd6743870-0d5a-4180-9671-181b8f65e03e');
INSERT INTO public.exercise_examples_equipments VALUES ('92373663-669a-4b32-96b9-69573292388f', '2024-08-27 17:37:27.255281', '2024-08-27 17:37:27.255281', '9d66ac93-3a48-429d-aeaa-54302856e204', '855bd9e5-3546-4cfd-b048-e8017f01bfeb');
INSERT INTO public.exercise_examples_equipments VALUES ('e9854721-7de4-4d5c-848a-84a8128b807a', '2024-08-27 17:37:27.255281', '2024-08-27 17:37:27.255281', '85dbccf6-454e-4440-8905-50a90d91dbcc', '855bd9e5-3546-4cfd-b048-e8017f01bfeb');
INSERT INTO public.exercise_examples_equipments VALUES ('65cc3832-31d3-4318-97de-77f2ed80c959', '2024-08-27 17:40:04.041202', '2024-08-27 17:40:04.041202', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '53defdc5-bfec-4af4-bfba-60440e3493cc');
INSERT INTO public.exercise_examples_equipments VALUES ('284d2351-a82b-4c2c-8034-6389c8289553', '2024-08-27 17:40:04.041202', '2024-08-27 17:40:04.041202', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '53defdc5-bfec-4af4-bfba-60440e3493cc');
INSERT INTO public.exercise_examples_equipments VALUES ('a7265729-e2e4-4256-a60f-8be6e5244aee', '2024-08-27 17:41:21.156137', '2024-08-27 17:41:21.156137', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2');
INSERT INTO public.exercise_examples_equipments VALUES ('0c085ba8-854c-448c-bf29-887e0da8d3de', '2024-08-27 17:41:21.156137', '2024-08-27 17:41:21.156137', 'af38ec0a-1465-45a8-99ba-a394224530dc', '748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2');
INSERT INTO public.exercise_examples_equipments VALUES ('4064f615-ed61-463c-b3ff-7922b7df32d5', '2024-08-27 17:44:25.496539', '2024-08-27 17:44:25.496539', '752ee7ba-ae88-46f0-95fb-e0a316212f16', 'a90f4822-63c5-42b9-943c-ff0ceacad1eb');
INSERT INTO public.exercise_examples_equipments VALUES ('6a0ee9fe-90e0-4578-b4d7-6cfe9add1c1f', '2024-08-27 17:44:25.496539', '2024-08-27 17:44:25.496539', '15495639-2adb-41b8-899c-493ac0172f57', 'a90f4822-63c5-42b9-943c-ff0ceacad1eb');


--
-- Data for Name: exercise_examples_tutorials; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.exercise_examples_tutorials VALUES ('0a7a066f-3204-4610-8fd2-85c353db0bf5', '2024-08-23 13:51:17.120552', '6cb225d2-be00-461d-9bf0-7f0c87cfea0b', '2024-08-23 13:51:17.120552', 'Tutorial Straight Bar Tricep Extension', 'https://www.youtube.com/watch?v=mpZ9VRisAyw', 'en', 'https://www.muscleandstrength.com', 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('60491dcd-c34d-494b-855b-7d574c7c2c0c', '2024-08-23 14:29:51.296687', 'b790c6a6-ecd1-4b3a-afbc-22cd82e55658', '2024-08-23 14:29:51.296687', 'Straight Bar Tricep Extension', 'https://www.youtube.com/watch?v=mpZ9VRisAyw', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('c33f6813-abc9-41cb-bb27-cff2db6f24e7', '2024-08-23 14:41:48.931538', '4d3a89ab-70ae-4311-8b40-a058b2f3057b', '2024-08-23 14:41:48.931538', 'Seated Overhead Dumbbell Tricep Extension
', 'https://www.youtube.com/watch?v=LlCFtWCQc5s', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('c0dbd0ad-661d-4ced-a393-183e6f058753', '2024-08-23 14:53:43.932664', '0e2fe1e8-f8f1-48e6-b360-8c9d4d9991a6', '2024-08-23 14:53:43.932664', 'Rope Tricep Extension
', 'https://www.youtube.com/watch?v=LzwgB15UdO8', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('460c09cc-8701-45ad-9491-8588b6e0f3e0', '2024-08-23 15:30:18.909949', 'ab0d7384-444e-446a-911d-f64ac31db8ef', '2024-08-23 15:30:18.909949', 'Bench Press (Close Grip)
', 'https://www.youtube.com/watch?v=j-NhORwJDb4', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('90d26987-58eb-4756-8a5c-cf76f791a849', '2024-08-23 15:44:41.345481', '650e9725-d36c-4688-bcab-adf93dfe9e5d', '2024-08-23 15:44:41.345481', 'EZ Bar Skullcrusher
', 'https://www.youtube.com/watch?v=K6MSN4hCDM4', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('a5bbf4db-4be8-482b-b77f-52d3cb3c3bb7', '2024-08-23 15:50:27.665106', '3b828d2f-797f-4a45-9d1d-1d3efe38fb54', '2024-08-23 15:50:27.665106', 'Dip (Weighted)
', 'https://www.youtube.com/watch?v=ZQnPQG5d67E', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('8dc32419-56a2-44c0-9d39-898d48394a9d', '2024-08-23 20:29:25.204889', '7517ae2f-c198-4a33-8a1d-1dc7327d1430', '2024-08-23 20:29:25.204889', 'Instruction', 'https://www.muscleandstrength.com/exercises/ez-bar-back-of-the-head-lying-tricep-extension.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('d646bbfa-cf3e-411c-92e5-daaa4568d474', '2024-08-23 20:36:43.368496', '4aafe702-f2fc-4fa2-a7fb-c31c279adeda', '2024-08-23 20:36:43.368496', 'Instruction', 'https://www.muscleandstrength.com/exercises/ez-bar-back-of-the-head-lying-tricep-extension.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('96fb5621-dc90-464a-961b-eba8f93074e9', '2024-08-24 13:49:36.279978', 'faf6674c-2a2a-4b03-ab8b-7a033052b572', '2024-08-24 13:49:36.279978', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternate-bent-over-dumbbell-kickback.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('47c395ce-d0ba-4e8a-ae57-9e0d28f42752', '2024-08-24 13:55:14.363423', '93e6b1c4-0510-41d4-983c-a1fde003881f', '2024-08-24 13:55:14.363423', 'Instruction', 'https://www.youtube.com/watch?v=fP12p0k2YL8', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('95cf2e06-cafd-4753-b995-1c6acb5baa7e', '2024-08-24 15:00:28.288128', '0eaa8980-e29e-4f33-88b0-915db5cf309a', '2024-08-24 15:00:28.288128', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternate-lying-dumbbell-extension.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('9e563b8f-55d2-441f-8533-3534ba2d3d86', '2024-08-24 15:05:24.082217', '9f0c8916-a08b-4fe5-9f24-e1680ef627a8', '2024-08-24 15:05:24.082217', 'Instruction', 'https://www.muscleandstrength.com/exercises/tricep-bench-dip.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('820512e8-f42e-46e9-99af-a7270c126966', '2024-08-24 15:14:04.512657', '547f1f7e-3ee1-4b39-99eb-3462b1ec13af', '2024-08-24 15:14:04.512657', 'Instruction', 'https://www.youtube.com/watch?v=BL9CzOQZDrs', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('7175c8f6-a736-44af-96f2-261b90f5755f', '2024-08-24 15:21:25.334711', '275097d4-3c8d-4040-9b2e-5f294919df04', '2024-08-24 15:21:25.334711', 'Instruction', 'https://www.muscleandstrength.com/exercises/cable-concentration-tricep-extension.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('6bceba7d-538e-40e6-974d-6b7d8e58ad6c', '2024-08-26 14:10:38.433204', '5985d847-0473-444e-8fe0-9da5341ef986', '2024-08-26 14:10:38.433204', 'Instruction', 'https://www.youtube.com/watch?v=KYGarkmUqvk', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('809e8e23-1a2f-4c49-bcea-11149138ecac', '2024-08-26 14:15:00.653682', '11644e17-247a-46b0-a391-b3b2a2a6bba8', '2024-08-26 14:15:00.653682', 'Instruction', 'https://www.muscleandstrength.com/exercises/cable-tricep-kickback.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('4b9617f2-1455-4bdd-9257-3e6754b56839', '2024-08-26 14:21:24.531486', '50774526-c91f-4d71-82a8-456526b0fbd0', '2024-08-26 14:21:24.531486', 'Instruction', 'https://www.youtube.com/watch?v=iYd36-rreNU', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('35cbbf52-bdd8-4be6-8580-997d48ac4f93', '2024-08-26 14:31:15.942235', '385fb192-7c2c-405a-b483-f36e32e241c8', '2024-08-26 14:31:15.942235', 'Instruction', 'https://www.muscleandstrength.com/exercises/close-grip-chest-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('0bd88f33-fdd3-4017-bc2b-b4d1d1b44ec1', '2024-08-26 14:36:25.659867', 'c21d3b0f-c8a8-4b7f-92ea-90dc567a1183', '2024-08-26 14:36:25.659867', 'Instruction', 'https://www.youtube.com/watch?v=LduzOtuJ3uA', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('6f274c78-173c-4a0c-9c6d-1e972067562e', '2024-08-26 14:39:55.647713', '04d275d8-71df-4695-ace9-899ce6e41b29', '2024-08-26 14:39:55.647713', 'Instruction', 'https://www.youtube.com/watch?v=LlCFtWCQc5s', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('ea1fcb81-1b7d-466c-b337-de877bfe7d94', '2024-08-26 14:46:34.099504', '1b4402c2-2459-45c1-8d24-356322c71d20', '2024-08-26 14:46:34.099504', 'Instruction', 'https://www.youtube.com/watch?v=VjmgzEmODnI', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('309552c9-6af5-419d-9226-d837c7979399', '2024-08-26 14:52:11.262224', '4f9bdd10-28bc-447e-8cf5-fbf47cd9af79', '2024-08-26 14:52:11.262224', 'Instruction', 'https://www.muscleandstrength.com/exercises/french-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('c1f7ad6f-b0eb-4a8e-9c1d-fb77559baac1', '2024-08-26 15:16:20.211697', '6a312bde-cc33-450b-8f1d-6091ccffe9cc', '2024-08-26 15:16:20.211697', 'Instruction', 'https://www.youtube.com/watch?v=mNDpEivaal8', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('6aa84096-0208-4f8c-9170-6eb2e5f92ab7', '2024-08-26 15:20:51.099335', '21e7460d-aa00-448b-8c82-994a73e0164c', '2024-08-26 15:20:51.099335', 'Instruction', 'https://www.youtube.com/watch?v=0BsOmGkxMCI', 'en', NULL, 'youtube_video');
INSERT INTO public.exercise_examples_tutorials VALUES ('4a7f64f5-82bc-45ba-90bc-3321d7853277', '2024-08-27 16:05:55.002649', 'ee8cc366-d33b-45a6-84b0-4ab416585ad1', '2024-08-27 16:05:55.002649', 'Instruction', 'https://www.muscleandstrength.com/exercises/close-grip-press-behind-neck.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('7de73397-fec6-48e7-ad84-f183e1960f69', '2024-08-27 17:08:58.78312', '490df80e-d34c-42cf-bfe5-c27ddd2cd734', '2024-08-27 17:08:58.78312', 'Instruction', 'https://www.muscleandstrength.com/exercises/decline-lying-dumbbell-extension.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('e9fd4344-6cc6-44fb-92c7-ad815b44a660', '2024-08-27 17:14:24.435235', 'e21344ff-b825-4a99-bf8b-a778bf1964d1', '2024-08-27 17:14:24.435235', 'Instruction', 'https://www.muscleandstrength.com/exercises/decline-close-grip-bench-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('a40473a0-96e0-4732-b8f0-4dc64dc35781', '2024-08-27 17:17:13.868725', 'd6743870-0d5a-4180-9671-181b8f65e03e', '2024-08-27 17:17:13.868725', 'Instruction', 'https://www.muscleandstrength.com/exercises/decline-lying-tricep-extension-skullcrusher.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('bf41d941-f0ad-4821-b5f0-d75040fc1170', '2024-08-27 17:37:27.262147', '855bd9e5-3546-4cfd-b048-e8017f01bfeb', '2024-08-27 17:37:27.262147', 'Instruction', 'https://www.muscleandstrength.com/exercises/tricep-kickback.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('2165daa5-a0a0-4a0e-a364-df6e6564bc77', '2024-08-27 17:40:04.044618', '53defdc5-bfec-4af4-bfba-60440e3493cc', '2024-08-27 17:40:04.044618', 'Instruction', 'https://www.muscleandstrength.com/exercises/ez-bar-incline-skullcrusher.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('51293886-f321-47fc-a1a3-b71cee4a67f7', '2024-08-27 17:41:21.163974', '748e0a60-9429-4a9d-8a6b-3ba76a7fc4b2', '2024-08-27 17:41:21.163974', 'Instruction', 'https://www.muscleandstrength.com/exercises/overhead-tricep-extension.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('95111d60-4fc0-4cc4-8162-ac50d32b0629', '2024-08-27 17:44:25.499546', 'a90f4822-63c5-42b9-943c-ff0ceacad1eb', '2024-08-27 17:44:25.499546', 'Instruction', 'https://www.muscleandstrength.com/exercises/high-pulley-overhead-tricep-extension.html', 'en', NULL, 'video');


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: iterations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: muscle_exercise_bundles; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: muscle_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.muscle_groups VALUES ('e1f1e456-3f8d-46f6-b7ba-75bb4b8c3802', 'Abdominal Muscles', 'Черевні М''язи', 'Брюшные Мышцы', '2023-11-12 00:38:32.665553', '2023-11-12 00:38:32.665553', 'abdominal_muscles');
INSERT INTO public.muscle_groups VALUES ('2043a22c-c547-42c2-81bb-81f85693d9cd', 'Arms and Forearms', 'Руки і передпліччя', 'Руки и предплечья', '2023-11-12 00:38:32.665553', '2023-11-12 00:38:32.665553', 'arms_and_forearms');
INSERT INTO public.muscle_groups VALUES ('4289bf91-51d8-40b0-9aca-66780584a4eb', 'Back Muscles', 'Спинні М''язи', 'Спинные Мышцы', '2023-11-12 00:38:32.665553', '2023-11-12 00:38:32.665553', 'back_muscles');
INSERT INTO public.muscle_groups VALUES ('255efc07-6c7e-42ab-97e5-01c06d60b5a3', 'Legs', 'Ноги', 'Ноги', '2023-11-12 00:38:32.665553', '2023-11-12 00:38:32.665553', 'legs');
INSERT INTO public.muscle_groups VALUES ('5fd8ccc9-8630-4357-a234-c2f278d905db', 'Chest Muscles', 'Грудні М''язи', 'Грудные Мышцы', '2023-11-12 00:38:32.665553', '2023-11-12 00:38:32.665553', 'chest_muscles');
INSERT INTO public.muscle_groups VALUES ('e1117068-06cd-4330-a4f9-93b485165805', 'Shoulder Muscles', 'Плечові М''язи', 'Плечевые Мышцы', '2023-11-12 00:38:32.665553', '2023-11-12 00:38:32.665553', 'shoulder_muscles');


--
-- Data for Name: muscles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.muscles VALUES ('2e0faf2b-31a5-4c63-ac15-454be132796f', 'Trapezius', '4289bf91-51d8-40b0-9aca-66780584a4eb', 'Трапецієподібні м''язи', 'Трапециевидные мышцы', '2023-11-12 00:44:51.190921', '2023-11-12 00:44:51.190921', 'trapezius', 48);
INSERT INTO public.muscles VALUES ('af854064-078a-4f50-af1d-8744e866751e', 'Rhomboids', '4289bf91-51d8-40b0-9aca-66780584a4eb', 'Ромбовидні м''язи', 'Ромбовидные мышцы', '2023-11-12 00:44:51.190921', '2023-11-12 00:44:51.190921', 'rhomboids', 48);
INSERT INTO public.muscles VALUES ('1ddbb748-37a6-4d66-a7d4-4957bdbc647f', 'Obliques', 'e1f1e456-3f8d-46f6-b7ba-75bb4b8c3802', 'Бічні м''язи черева', 'Боковые мышцы живота', '2023-11-12 00:49:49.921299', '2023-11-12 00:49:49.921299', 'obliques', 48);
INSERT INTO public.muscles VALUES ('9e69205f-6c6e-44a7-8ee6-89215e28a28e', 'Rectus Abdominis', 'e1f1e456-3f8d-46f6-b7ba-75bb4b8c3802', 'Пряма м''язи черева', 'Прямая мышца живота', '2023-11-12 00:49:49.921299', '2023-11-12 00:49:49.921299', 'rectus_abdominis', 48);
INSERT INTO public.muscles VALUES ('57559b71-b757-468a-983d-a1b3cec4acef', 'Quadriceps', '255efc07-6c7e-42ab-97e5-01c06d60b5a3', 'Квадрицепси', 'Квадрицепсы', '2023-11-12 00:51:12.539967', '2023-11-12 00:51:12.539967', 'quadriceps', 48);
INSERT INTO public.muscles VALUES ('831f39bd-80a8-4d11-9964-bde1788abae1', 'Latissimus Dorsi', '4289bf91-51d8-40b0-9aca-66780584a4eb', 'Широкі м''язи спини', 'Широчайшие мышцы спины', '2023-11-12 00:44:51.190921', '2023-11-12 00:44:51.190921', 'latissimus_dorsi', 48);
INSERT INTO public.muscles VALUES ('c57aa60c-61ea-4498-b01f-fedcafe8a32a', 'Pectoralis Major', '5fd8ccc9-8630-4357-a234-c2f278d905db', 'Грудні великі м''язи', 'Грудные большие мышцы', '2023-11-12 00:44:51.190921', '2023-11-12 00:44:51.190921', 'pectoralis_major', 48);
INSERT INTO public.muscles VALUES ('2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', 'Lateral Deltoid', 'e1117068-06cd-4330-a4f9-93b485165805', 'Середня дельтовидна', 'Средний делтовидный ', '2023-11-13 21:03:29.671135', '2023-11-13 21:03:29.671135', 'lateral_deltoid', 48);
INSERT INTO public.muscles VALUES ('d736a513-9d73-47a3-bffc-c14911662ea2', 'Anterior Deltoid', 'e1117068-06cd-4330-a4f9-93b485165805', 'Передня дельтовидна ', 'Передний делтовидный', '2023-11-13 21:03:29.671135', '2023-11-13 21:03:29.671135', 'anterior_deltoid', 48);
INSERT INTO public.muscles VALUES ('97136fa7-622a-49d6-9d09-403a631d253d', 'Posterior Deltoid', 'e1117068-06cd-4330-a4f9-93b485165805', 'Задня дельтовидна', 'Задний делтовидный', '2023-11-13 21:03:29.671135', '2023-11-13 21:03:29.671135', 'posterior_deltoid', 48);
INSERT INTO public.muscles VALUES ('bba5b66d-9a9c-4b44-8dd6-9574760038ee', 'Calf Muscles', '255efc07-6c7e-42ab-97e5-01c06d60b5a3', 'Задні стегнові м''язи', 'Мышцы голени', '2023-11-12 00:51:12.539967', '2023-11-12 00:51:12.539967', 'calf', 48);
INSERT INTO public.muscles VALUES ('f6e65bfe-0746-4a8f-8210-0e9bf88d9886', 'Gluteal Muscles', '255efc07-6c7e-42ab-97e5-01c06d60b5a3', 'Сідничні м''язи', 'Ягодичные мышцы', '2023-11-15 21:31:45.933229', '2023-11-15 21:31:45.933229', 'gluteal', 48);
INSERT INTO public.muscles VALUES ('b4658891-9713-48c4-864c-8dd907da19b0', 'Pectoralis Minor', '5fd8ccc9-8630-4357-a234-c2f278d905db', 'Грудні малі м''язи', 'Грудные малые мышцы', '2023-11-12 00:44:51.190921', '2023-11-12 00:44:51.190921', 'pectoralis_minor', 48);
INSERT INTO public.muscles VALUES ('3eeaa9fa-0847-4780-9d01-185f91252794', 'Hamstrings', '255efc07-6c7e-42ab-97e5-01c06d60b5a3', 'Підколінні м''язи', 'Бедренные мышцы', '2023-11-12 00:51:12.539967', '2023-11-12 00:51:12.539967', 'hamstrings', 48);
INSERT INTO public.muscles VALUES ('9a8024fe-c721-4bea-969c-db88674b5ece', 'Forearm Muscles', '2043a22c-c547-42c2-81bb-81f85693d9cd', 'М''язи передпліччя', 'Мышцы предплечья', '2023-11-13 21:01:37.624512', '2023-11-13 21:01:37.624512', 'forearm', 36);
INSERT INTO public.muscles VALUES ('97a87b01-35e8-490a-94b9-9bdae9c2f965', 'Biceps Brachii', '2043a22c-c547-42c2-81bb-81f85693d9cd', 'Біцепси', 'Бицепсы', '2023-11-12 00:47:55.131334', '2023-11-12 00:47:55.131334', 'biceps', 36);
INSERT INTO public.muscles VALUES ('0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', 'Triceps Brachii', '2043a22c-c547-42c2-81bb-81f85693d9cd', 'Трицепси', 'Трицепсы', '2023-11-13 21:01:37.624512', '2023-11-13 21:01:37.624512', 'triceps', 36);
INSERT INTO public.muscles VALUES ('be38dcef-1bc8-487b-a44f-96df1ab9e68c', 'Teres Major', '4289bf91-51d8-40b0-9aca-66780584a4eb', 'Терес мажор', 'Терес мажор', '2024-07-30 19:46:35.870695', '2024-07-30 19:46:35.870695', 'teres_major', 36);


--
-- Data for Name: trainings; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES ('5e2eab59-bccb-4679-997a-398e18bc254c', 'alienworkout@admin.panel', '$2a$10$qiW50vCNFhj.A02Gozd3mOGozaY.JHwPXC3oK/wJ2kq8MHoS64aiS', 'Admin User', '2024-08-23 10:23:20.828239', '2024-08-23 10:23:20.828239', 1.65, 'advanced');


--
-- Data for Name: weight_history; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.weight_history VALUES ('59fe6576-cc7d-41ad-9094-d94527eb0472', '5e2eab59-bccb-4679-997a-398e18bc254c', 65, '2024-08-23 10:23:20.841272', '2024-08-23 10:23:20.841272');


--
-- Name: muscle_exercise_bundles PK_228cbcce883be9a79735d6de922; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_exercise_bundles
    ADD CONSTRAINT "PK_228cbcce883be9a79735d6de922" PRIMARY KEY (id);


--
-- Name: equipments PK_250348d5d9ae4946bcd634f3e61; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipments
    ADD CONSTRAINT "PK_250348d5d9ae4946bcd634f3e61" PRIMARY KEY (id);


--
-- Name: excluded_equipments PK_6833f08aa872b23c33a2b207073; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excluded_equipments
    ADD CONSTRAINT "PK_6833f08aa872b23c33a2b207073" PRIMARY KEY (id);


--
-- Name: exercise_examples PK_6ec4db5d5601a567816d4de278b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_examples
    ADD CONSTRAINT "PK_6ec4db5d5601a567816d4de278b" PRIMARY KEY (id);


--
-- Name: excluded_muscles PK_9557dfb4752d43a0520eaf71ddd; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excluded_muscles
    ADD CONSTRAINT "PK_9557dfb4752d43a0520eaf71ddd" PRIMARY KEY (id);


--
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- Name: weight_history PK_a5697ac8bfdda68bc5e37d25297; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weight_history
    ADD CONSTRAINT "PK_a5697ac8bfdda68bc5e37d25297" PRIMARY KEY (id);


--
-- Name: exercise_examples_equipments PK_aa80c21af8dbad5c0146c09e43c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_examples_equipments
    ADD CONSTRAINT "PK_aa80c21af8dbad5c0146c09e43c" PRIMARY KEY (id);


--
-- Name: trainings PK_b67237502b175163e47dc85018d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainings
    ADD CONSTRAINT "PK_b67237502b175163e47dc85018d" PRIMARY KEY (id);


--
-- Name: exercise_example_bundles PK_c2cc4b67be9e9d112e21443a32a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_example_bundles
    ADD CONSTRAINT "PK_c2cc4b67be9e9d112e21443a32a" PRIMARY KEY (id);


--
-- Name: exercises PK_c4c46f5fa89a58ba7c2d894e3c3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT "PK_c4c46f5fa89a58ba7c2d894e3c3" PRIMARY KEY (id);


--
-- Name: muscle_groups PK_c992270adab7acafcedcf3e4428; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_groups
    ADD CONSTRAINT "PK_c992270adab7acafcedcf3e4428" PRIMARY KEY (id);


--
-- Name: muscles PK_d447d24f0750ae71b1ec5ae9668; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscles
    ADD CONSTRAINT "PK_d447d24f0750ae71b1ec5ae9668" PRIMARY KEY (id);


--
-- Name: iterations PK_d62c93eaa6fc8129cb942633d12; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.iterations
    ADD CONSTRAINT "PK_d62c93eaa6fc8129cb942633d12" PRIMARY KEY (id);


--
-- Name: exercise_examples_tutorials PK_de469132881b9b76e0b37fad6ea; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_examples_tutorials
    ADD CONSTRAINT "PK_de469132881b9b76e0b37fad6ea" PRIMARY KEY (id);


--
-- Name: equipment_groups PK_f2248d363b3cd233ec04be2cfac; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment_groups
    ADD CONSTRAINT "PK_f2248d363b3cd233ec04be2cfac" PRIMARY KEY (id);


--
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- Name: IDX_b43dd7bd8917f9fca521d49232; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_b43dd7bd8917f9fca521d49232" ON public.trainings USING btree (created_at);


--
-- Name: trainings FK_0a6488e45e7e8ed7d5f69e0dead; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainings
    ADD CONSTRAINT "FK_0a6488e45e7e8ed7d5f69e0dead" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: muscle_exercise_bundles FK_183fdb588e33d2d612dc4998e95; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_exercise_bundles
    ADD CONSTRAINT "FK_183fdb588e33d2d612dc4998e95" FOREIGN KEY (exercise_example_id) REFERENCES public.exercise_examples(id) ON DELETE CASCADE;


--
-- Name: exercise_example_bundles FK_2d9baa79828c7180ebf28ff5065; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_example_bundles
    ADD CONSTRAINT "FK_2d9baa79828c7180ebf28ff5065" FOREIGN KEY (muscle_id) REFERENCES public.muscles(id) ON DELETE CASCADE;


--
-- Name: excluded_equipments FK_3fc2cde19015c5361418979a02a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excluded_equipments
    ADD CONSTRAINT "FK_3fc2cde19015c5361418979a02a" FOREIGN KEY (equipment_id) REFERENCES public.equipments(id) ON DELETE CASCADE;


--
-- Name: excluded_muscles FK_487dfe271837b6e15ee40561fc7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excluded_muscles
    ADD CONSTRAINT "FK_487dfe271837b6e15ee40561fc7" FOREIGN KEY (muscle_id) REFERENCES public.muscles(id) ON DELETE CASCADE;


--
-- Name: muscle_exercise_bundles FK_5b415788262521c5bfe20147ddc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_exercise_bundles
    ADD CONSTRAINT "FK_5b415788262521c5bfe20147ddc" FOREIGN KEY (muscle_id) REFERENCES public.muscles(id) ON DELETE CASCADE;


--
-- Name: exercise_example_bundles FK_600bedaa30ff58235320ef11133; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_example_bundles
    ADD CONSTRAINT "FK_600bedaa30ff58235320ef11133" FOREIGN KEY (exercise_example_id) REFERENCES public.exercise_examples(id) ON DELETE CASCADE;


--
-- Name: excluded_equipments FK_67d0ce866c36449a91e2b5e7296; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excluded_equipments
    ADD CONSTRAINT "FK_67d0ce866c36449a91e2b5e7296" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: iterations FK_83c23650e879d2d07e375574069; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.iterations
    ADD CONSTRAINT "FK_83c23650e879d2d07e375574069" FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: weight_history FK_90d01effa2fdd927e738e232f0e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weight_history
    ADD CONSTRAINT "FK_90d01effa2fdd927e738e232f0e" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: muscles FK_97c14a3154bde81534490d92186; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscles
    ADD CONSTRAINT "FK_97c14a3154bde81534490d92186" FOREIGN KEY (muscle_group_id) REFERENCES public.muscle_groups(id) ON DELETE CASCADE;


--
-- Name: exercise_examples_equipments FK_a97b574c6a2ddefc48ce4e34f80; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_examples_equipments
    ADD CONSTRAINT "FK_a97b574c6a2ddefc48ce4e34f80" FOREIGN KEY (exercise_example_id) REFERENCES public.exercise_examples(id) ON DELETE CASCADE;


--
-- Name: exercises FK_b0947cc4c27363a5d4525d103dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT "FK_b0947cc4c27363a5d4525d103dd" FOREIGN KEY (training_id) REFERENCES public.trainings(id) ON DELETE CASCADE;


--
-- Name: exercise_examples_tutorials FK_c37eef836efb07dc487deb27fca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_examples_tutorials
    ADD CONSTRAINT "FK_c37eef836efb07dc487deb27fca" FOREIGN KEY (exercise_example_id) REFERENCES public.exercise_examples(id) ON DELETE CASCADE;


--
-- Name: exercise_examples_equipments FK_ca612324a3e3a31b91989cac790; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_examples_equipments
    ADD CONSTRAINT "FK_ca612324a3e3a31b91989cac790" FOREIGN KEY (equipment_id) REFERENCES public.equipments(id) ON DELETE CASCADE;


--
-- Name: equipments FK_dbe5cf6e8bfb13366defd7706ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipments
    ADD CONSTRAINT "FK_dbe5cf6e8bfb13366defd7706ab" FOREIGN KEY (equipment_group_id) REFERENCES public.equipment_groups(id) ON DELETE CASCADE;


--
-- Name: exercises FK_f2cff4897a8c9ce4a3511086e1e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT "FK_f2cff4897a8c9ce4a3511086e1e" FOREIGN KEY (exercise_example_id) REFERENCES public.exercise_examples(id) ON DELETE SET NULL;


--
-- Name: excluded_muscles FK_fb5bf30c118024b483e9e2d88c8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excluded_muscles
    ADD CONSTRAINT "FK_fb5bf30c118024b483e9e2d88c8" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

