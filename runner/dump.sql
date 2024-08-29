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
INSERT INTO public.exercise_example_bundles VALUES ('6a155359-0805-4787-a022-ce3812bcf05c', 85, 'ddc2e877-7197-42fa-ae1e-59706d209774', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 19:58:20.496346', '2024-08-27 19:58:20.496346');
INSERT INTO public.exercise_example_bundles VALUES ('fefc9491-3df3-4e18-9f17-2746e3989075', 10, 'ddc2e877-7197-42fa-ae1e-59706d209774', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 19:58:20.496346', '2024-08-27 19:58:20.496346');
INSERT INTO public.exercise_example_bundles VALUES ('9ef3dd63-ae20-4b40-9f0e-ff3d9390c73b', 5, 'ddc2e877-7197-42fa-ae1e-59706d209774', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 19:58:20.496346', '2024-08-27 19:58:20.496346');
INSERT INTO public.exercise_example_bundles VALUES ('7687354a-a9e4-4eea-8a55-9515da80328a', 70, '8324ae75-08e9-48de-a00b-55d229085712', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:02:25.698074', '2024-08-27 20:02:25.698074');
INSERT INTO public.exercise_example_bundles VALUES ('9cf926d9-80bd-444c-8f6c-0ff9c558e8e2', 25, '8324ae75-08e9-48de-a00b-55d229085712', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:02:25.698074', '2024-08-27 20:02:25.698074');
INSERT INTO public.exercise_example_bundles VALUES ('75d3423c-38d0-4260-a912-4eeacbe4fc1a', 5, '8324ae75-08e9-48de-a00b-55d229085712', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:02:25.698074', '2024-08-27 20:02:25.698074');
INSERT INTO public.exercise_example_bundles VALUES ('e24cd5ac-96e4-4955-9357-8cef40f6b2cf', 85, 'bbfbcfe2-1f56-492e-afa6-75e595b84fde', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:04:23.484123', '2024-08-27 20:04:23.484123');
INSERT INTO public.exercise_example_bundles VALUES ('800b2a70-816c-49f0-a8b9-870aff6088b8', 10, 'bbfbcfe2-1f56-492e-afa6-75e595b84fde', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:04:23.484123', '2024-08-27 20:04:23.484123');
INSERT INTO public.exercise_example_bundles VALUES ('479ce6bc-3090-41f5-ae9a-f07004aa44b2', 5, 'bbfbcfe2-1f56-492e-afa6-75e595b84fde', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:04:23.484123', '2024-08-27 20:04:23.484123');
INSERT INTO public.exercise_example_bundles VALUES ('6f734756-9c48-4dcd-bee2-6bed69665219', 80, '09386394-e4e1-4a6d-adce-d5f5a518485c', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:09:12.659219', '2024-08-27 20:09:12.659219');
INSERT INTO public.exercise_example_bundles VALUES ('3d22c4c2-ebc1-4aea-a9e0-6e35b6b50cb4', 15, '09386394-e4e1-4a6d-adce-d5f5a518485c', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:09:12.659219', '2024-08-27 20:09:12.659219');
INSERT INTO public.exercise_example_bundles VALUES ('f760f86f-5b69-469e-a4ba-393f949e1a8c', 5, '09386394-e4e1-4a6d-adce-d5f5a518485c', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:09:12.659219', '2024-08-27 20:09:12.659219');
INSERT INTO public.exercise_example_bundles VALUES ('afb55144-4d6a-4132-bbda-a5dc1583f964', 85, 'cfb2d83a-b3dc-44e9-ab08-53f9269752d6', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:11:42.127843', '2024-08-27 20:11:42.127843');
INSERT INTO public.exercise_example_bundles VALUES ('a6857925-338c-491e-8808-e1996bf2e9b7', 10, 'cfb2d83a-b3dc-44e9-ab08-53f9269752d6', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:11:42.127843', '2024-08-27 20:11:42.127843');
INSERT INTO public.exercise_example_bundles VALUES ('2ee74b2f-791d-4c57-8048-ccafdb6aa5c4', 5, 'cfb2d83a-b3dc-44e9-ab08-53f9269752d6', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:11:42.127843', '2024-08-27 20:11:42.127843');
INSERT INTO public.exercise_example_bundles VALUES ('c4f5967c-315d-44a5-808c-c1611f1290e6', 85, '2522a61a-2190-43e9-ae52-ca6bb023815e', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:13:52.515436', '2024-08-27 20:13:52.515436');
INSERT INTO public.exercise_example_bundles VALUES ('df2bdb42-b9d5-4495-a53a-db3378a362ce', 10, '2522a61a-2190-43e9-ae52-ca6bb023815e', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:13:52.515436', '2024-08-27 20:13:52.515436');
INSERT INTO public.exercise_example_bundles VALUES ('6cba3937-9806-42a5-bf8b-e14a0db50c5d', 5, '2522a61a-2190-43e9-ae52-ca6bb023815e', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:13:52.515436', '2024-08-27 20:13:52.515436');
INSERT INTO public.exercise_example_bundles VALUES ('c36a9453-2ebb-4e48-8645-d707664d9a14', 85, '9fc5ae4d-2868-4576-bb67-9c83663fc005', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:15:21.120047', '2024-08-27 20:15:21.120047');
INSERT INTO public.exercise_example_bundles VALUES ('125a37fd-101e-4192-9ad7-795e39eed73d', 10, '9fc5ae4d-2868-4576-bb67-9c83663fc005', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:15:21.120047', '2024-08-27 20:15:21.120047');
INSERT INTO public.exercise_example_bundles VALUES ('cfb15031-a060-42e0-aaf0-bd4407588e80', 5, '9fc5ae4d-2868-4576-bb67-9c83663fc005', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:15:21.120047', '2024-08-27 20:15:21.120047');
INSERT INTO public.exercise_example_bundles VALUES ('212ec793-103d-485e-a0fb-78bcf7e69244', 70, '89f423d0-315f-4d93-b346-dcb468a97045', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:17:28.420295', '2024-08-27 20:17:28.420295');
INSERT INTO public.exercise_example_bundles VALUES ('c578ca42-13db-478c-bd7a-4968bc7fceb7', 25, '89f423d0-315f-4d93-b346-dcb468a97045', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:17:28.420295', '2024-08-27 20:17:28.420295');
INSERT INTO public.exercise_example_bundles VALUES ('1d693839-4b53-4a99-b42c-c73816b5161e', 5, '89f423d0-315f-4d93-b346-dcb468a97045', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:17:28.420295', '2024-08-27 20:17:28.420295');
INSERT INTO public.exercise_example_bundles VALUES ('c1a35037-a4fa-4a0d-b014-8a123c7e5371', 85, '194fa2ee-7f92-4982-903e-3db80293d773', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:20:16.525543', '2024-08-27 20:20:16.525543');
INSERT INTO public.exercise_example_bundles VALUES ('1ba42609-7d2e-4934-8452-1cdebdef5545', 10, '194fa2ee-7f92-4982-903e-3db80293d773', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:20:16.525543', '2024-08-27 20:20:16.525543');
INSERT INTO public.exercise_example_bundles VALUES ('f500643c-e69d-4f80-a477-0ffcc4b35c03', 5, '194fa2ee-7f92-4982-903e-3db80293d773', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:20:16.525543', '2024-08-27 20:20:16.525543');
INSERT INTO public.exercise_example_bundles VALUES ('e006cd44-daa3-4fa0-af65-7fe2e178bc65', 85, 'f2fb31f0-7f6b-42b6-9a79-c22453ac6a63', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:24:43.755434', '2024-08-27 20:24:43.755434');
INSERT INTO public.exercise_example_bundles VALUES ('77ef457c-da51-4cdf-93ad-b6640f250f6d', 10, 'f2fb31f0-7f6b-42b6-9a79-c22453ac6a63', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:24:43.755434', '2024-08-27 20:24:43.755434');
INSERT INTO public.exercise_example_bundles VALUES ('220ad7dc-5334-486c-a6c6-9504ed2865ee', 5, 'f2fb31f0-7f6b-42b6-9a79-c22453ac6a63', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:24:43.755434', '2024-08-27 20:24:43.755434');
INSERT INTO public.exercise_example_bundles VALUES ('359c0953-b4ef-491e-b221-327ebb8b4332', 70, '5e3c933f-7511-463e-88b1-a139c8276e69', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:27:54.267144', '2024-08-27 20:27:54.267144');
INSERT INTO public.exercise_example_bundles VALUES ('802888ae-b322-4b39-a632-7637af500f7f', 25, '5e3c933f-7511-463e-88b1-a139c8276e69', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:27:54.267144', '2024-08-27 20:27:54.267144');
INSERT INTO public.exercise_example_bundles VALUES ('0aea0f3c-3a35-481c-bf47-0c67621a3190', 5, '5e3c933f-7511-463e-88b1-a139c8276e69', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:27:54.267144', '2024-08-27 20:27:54.267144');
INSERT INTO public.exercise_example_bundles VALUES ('286f93a5-488c-445c-a83b-9f7f594e1a9f', 80, 'e7f390fd-7435-44e1-b354-c62073934c66', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-27 20:29:12.669187', '2024-08-27 20:29:12.669187');
INSERT INTO public.exercise_example_bundles VALUES ('65cd8ab4-5fb8-47ef-ab4c-69ee14f6b74b', 15, 'e7f390fd-7435-44e1-b354-c62073934c66', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-27 20:29:12.669187', '2024-08-27 20:29:12.669187');
INSERT INTO public.exercise_example_bundles VALUES ('396c6aeb-d8a3-4e2d-93bb-a232a59e1eb9', 5, 'e7f390fd-7435-44e1-b354-c62073934c66', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-27 20:29:12.669187', '2024-08-27 20:29:12.669187');
INSERT INTO public.exercise_example_bundles VALUES ('35506cbe-e3e9-40dc-b9ea-f4860277ae16', 80, '7e0566c6-eefb-4992-a673-d19902933c26', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:36:41.156018', '2024-08-28 20:36:41.156018');
INSERT INTO public.exercise_example_bundles VALUES ('9f0a3f11-df67-4c5b-8cad-0d27c7f88515', 15, '7e0566c6-eefb-4992-a673-d19902933c26', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:36:41.156018', '2024-08-28 20:36:41.156018');
INSERT INTO public.exercise_example_bundles VALUES ('8032cadc-a816-463a-b641-8c9a1a9b7e7f', 5, '7e0566c6-eefb-4992-a673-d19902933c26', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:36:41.156018', '2024-08-28 20:36:41.156018');
INSERT INTO public.exercise_example_bundles VALUES ('04ce1d65-c38b-41d6-b147-8443ac574a39', 90, '7fd82f79-1f5f-4bae-8f2d-b94ecae595d5', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:38:26.227275', '2024-08-28 20:38:26.227275');
INSERT INTO public.exercise_example_bundles VALUES ('9181bc7c-a816-4a6c-a98f-dd3546ac088e', 7, '7fd82f79-1f5f-4bae-8f2d-b94ecae595d5', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:38:26.227275', '2024-08-28 20:38:26.227275');
INSERT INTO public.exercise_example_bundles VALUES ('81ac49ef-d773-45d0-b49c-8dfabb43b04a', 3, '7fd82f79-1f5f-4bae-8f2d-b94ecae595d5', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:38:26.227275', '2024-08-28 20:38:26.227275');
INSERT INTO public.exercise_example_bundles VALUES ('22bffc78-de7c-42c1-8961-1e4d90d0fbc5', 80, '908341ec-de1f-44bd-b84d-74ff8a7162a0', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:40:22.165845', '2024-08-28 20:40:22.165845');
INSERT INTO public.exercise_example_bundles VALUES ('571a48fc-5925-4f15-8dfc-e213be2f1f10', 15, '908341ec-de1f-44bd-b84d-74ff8a7162a0', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:40:22.165845', '2024-08-28 20:40:22.165845');
INSERT INTO public.exercise_example_bundles VALUES ('56d11ef9-22f5-47a2-8f76-d4726626535c', 5, '908341ec-de1f-44bd-b84d-74ff8a7162a0', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:40:22.165845', '2024-08-28 20:40:22.165845');
INSERT INTO public.exercise_example_bundles VALUES ('fae3fbba-87c1-48b9-a1f5-c413c4f8199d', 85, 'a2736a56-04b3-4437-835e-1e2dc8029c9e', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:42:25.590465', '2024-08-28 20:42:25.590465');
INSERT INTO public.exercise_example_bundles VALUES ('72b533bf-7ecc-44ef-a3d6-8341e89a57f4', 10, 'a2736a56-04b3-4437-835e-1e2dc8029c9e', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:42:25.590465', '2024-08-28 20:42:25.590465');
INSERT INTO public.exercise_example_bundles VALUES ('5bbfac84-4013-45a8-9b99-9f2c4bdc9f2a', 5, 'a2736a56-04b3-4437-835e-1e2dc8029c9e', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:42:25.590465', '2024-08-28 20:42:25.590465');
INSERT INTO public.exercise_example_bundles VALUES ('d6ea6f0f-7ebd-4227-b328-5163f5d3b37c', 85, 'da809d98-950b-4ca0-a71b-c67d21fd66da', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:44:17.61958', '2024-08-28 20:44:17.61958');
INSERT INTO public.exercise_example_bundles VALUES ('26369c9c-9bd0-480b-aa2d-99d56c2ba5ce', 10, 'da809d98-950b-4ca0-a71b-c67d21fd66da', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:44:17.61958', '2024-08-28 20:44:17.61958');
INSERT INTO public.exercise_example_bundles VALUES ('8019eac5-d12c-4517-9543-d75c3533648d', 5, 'da809d98-950b-4ca0-a71b-c67d21fd66da', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:44:17.61958', '2024-08-28 20:44:17.61958');
INSERT INTO public.exercise_example_bundles VALUES ('8ae65297-68ee-407b-a342-29011a79f740', 70, '4de0744d-0a78-4052-aa1b-e5340959d9fe', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:45:27.519854', '2024-08-28 20:45:27.519854');
INSERT INTO public.exercise_example_bundles VALUES ('8f96b5ae-66e8-43ab-9829-1d3eb4fd2b6c', 25, '4de0744d-0a78-4052-aa1b-e5340959d9fe', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:45:27.519854', '2024-08-28 20:45:27.519854');
INSERT INTO public.exercise_example_bundles VALUES ('d6255721-a7b1-40f7-9da5-eacf0d50ea55', 5, '4de0744d-0a78-4052-aa1b-e5340959d9fe', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:45:27.519854', '2024-08-28 20:45:27.519854');
INSERT INTO public.exercise_example_bundles VALUES ('02c75169-d17d-4fda-9966-41f95f97b71a', 85, 'd7abed66-3c4a-490b-91cc-8e714336f9fa', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:47:16.406993', '2024-08-28 20:47:16.406993');
INSERT INTO public.exercise_example_bundles VALUES ('b8b6c1e7-2ca5-4cda-b338-77aa5f06a990', 10, 'd7abed66-3c4a-490b-91cc-8e714336f9fa', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:47:16.406993', '2024-08-28 20:47:16.406993');
INSERT INTO public.exercise_example_bundles VALUES ('72814fea-17fb-4f97-b4d4-cd75406e06b6', 5, 'd7abed66-3c4a-490b-91cc-8e714336f9fa', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:47:16.406993', '2024-08-28 20:47:16.406993');
INSERT INTO public.exercise_example_bundles VALUES ('2da5ef47-51fc-47f2-9581-c3359b7bb7a2', 80, 'cfd086be-f452-4f1d-b0cc-3988d677a8b4', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:48:17.215743', '2024-08-28 20:48:17.215743');
INSERT INTO public.exercise_example_bundles VALUES ('c4156439-cf72-4c0e-913a-c1c301963353', 15, 'cfd086be-f452-4f1d-b0cc-3988d677a8b4', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:48:17.215743', '2024-08-28 20:48:17.215743');
INSERT INTO public.exercise_example_bundles VALUES ('bdf0c0fd-f77e-4dc9-9ae6-9c232684de1f', 5, 'cfd086be-f452-4f1d-b0cc-3988d677a8b4', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:48:17.215743', '2024-08-28 20:48:17.215743');
INSERT INTO public.exercise_example_bundles VALUES ('59f803eb-ec03-4710-b533-2f85e4a6a304', 80, '8508cffc-1df6-4db2-9447-3bafd74a1325', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:50:28.799487', '2024-08-28 20:50:28.799487');
INSERT INTO public.exercise_example_bundles VALUES ('8491b0e5-ef25-4e6c-a0e0-3e83a666b5cb', 15, '8508cffc-1df6-4db2-9447-3bafd74a1325', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:50:28.799487', '2024-08-28 20:50:28.799487');
INSERT INTO public.exercise_example_bundles VALUES ('eaf9958f-405d-4f53-b955-0cbc5eaa3a31', 5, '8508cffc-1df6-4db2-9447-3bafd74a1325', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:50:28.799487', '2024-08-28 20:50:28.799487');
INSERT INTO public.exercise_example_bundles VALUES ('7690f0ab-a01d-4d0a-b69d-362d8f09649d', 85, '4f1c3655-21e7-4225-a39e-944774f59f76', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:51:35.460372', '2024-08-28 20:51:35.460372');
INSERT INTO public.exercise_example_bundles VALUES ('e246a056-0fd4-4125-b4ca-344ffb2563bf', 10, '4f1c3655-21e7-4225-a39e-944774f59f76', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:51:35.460372', '2024-08-28 20:51:35.460372');
INSERT INTO public.exercise_example_bundles VALUES ('8e0973e3-0225-435d-a3da-af33ab7caf6a', 5, '4f1c3655-21e7-4225-a39e-944774f59f76', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:51:35.460372', '2024-08-28 20:51:35.460372');
INSERT INTO public.exercise_example_bundles VALUES ('8c8d6212-2996-468e-b70c-b3cdfd8283ac', 85, '6d5dc164-3c35-4719-85f1-5c75558f0125', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:53:42.341484', '2024-08-28 20:53:42.341484');
INSERT INTO public.exercise_example_bundles VALUES ('32048a96-d0f0-4e0d-96c9-75d8250e936e', 10, '6d5dc164-3c35-4719-85f1-5c75558f0125', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:53:42.341484', '2024-08-28 20:53:42.341484');
INSERT INTO public.exercise_example_bundles VALUES ('d801e688-0f42-4ada-93ac-7c66dc1cdc5f', 5, '6d5dc164-3c35-4719-85f1-5c75558f0125', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:53:42.341484', '2024-08-28 20:53:42.341484');
INSERT INTO public.exercise_example_bundles VALUES ('9d64ae39-0a2d-4a36-b25b-c0491ef07f09', 85, 'cebf4622-c0a9-4759-a070-48c7556da67d', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:55:59.978276', '2024-08-28 20:55:59.978276');
INSERT INTO public.exercise_example_bundles VALUES ('f66eca64-85ac-480c-859c-a7a202f80c40', 10, 'cebf4622-c0a9-4759-a070-48c7556da67d', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:55:59.978276', '2024-08-28 20:55:59.978276');
INSERT INTO public.exercise_example_bundles VALUES ('3e6d0801-0f61-4122-a443-f63a54d96c95', 5, 'cebf4622-c0a9-4759-a070-48c7556da67d', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:55:59.978276', '2024-08-28 20:55:59.978276');
INSERT INTO public.exercise_example_bundles VALUES ('7ddb43ad-2bf4-4ee9-9d26-64e8ca647021', 85, '4d72c2f1-2c10-45a3-9f5e-1f04012c0681', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 20:59:16.612181', '2024-08-28 20:59:16.612181');
INSERT INTO public.exercise_example_bundles VALUES ('0f34d7e9-633f-4e54-bc21-578803be3f6c', 10, '4d72c2f1-2c10-45a3-9f5e-1f04012c0681', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 20:59:16.612181', '2024-08-28 20:59:16.612181');
INSERT INTO public.exercise_example_bundles VALUES ('e94558cd-0108-4393-9138-cc6ca0e91980', 5, '4d72c2f1-2c10-45a3-9f5e-1f04012c0681', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 20:59:16.612181', '2024-08-28 20:59:16.612181');
INSERT INTO public.exercise_example_bundles VALUES ('0a92235f-d91e-4199-aa57-5cef5fc3aa44', 85, 'af39600b-6fc5-435a-a5f8-a1d0a9994030', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:00:57.792071', '2024-08-28 21:00:57.792071');
INSERT INTO public.exercise_example_bundles VALUES ('1bf2ea8e-a838-4bf6-9eb5-3eb4c517da3c', 10, 'af39600b-6fc5-435a-a5f8-a1d0a9994030', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:00:57.792071', '2024-08-28 21:00:57.792071');
INSERT INTO public.exercise_example_bundles VALUES ('8c8bacba-acf6-4e00-ab5b-a25cc233ca17', 5, 'af39600b-6fc5-435a-a5f8-a1d0a9994030', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:00:57.792071', '2024-08-28 21:00:57.792071');
INSERT INTO public.exercise_example_bundles VALUES ('9788a05d-36bf-4d3c-af1d-782a0eb747c8', 80, '101f365e-5c84-438a-84b4-c8e798bd0aff', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:02:48.210751', '2024-08-28 21:02:48.210751');
INSERT INTO public.exercise_example_bundles VALUES ('f2ccb77e-cb64-4aec-abd2-84ecc00b7ab5', 15, '101f365e-5c84-438a-84b4-c8e798bd0aff', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:02:48.210751', '2024-08-28 21:02:48.210751');
INSERT INTO public.exercise_example_bundles VALUES ('f1576c2f-d0c8-4ab3-a11c-99543570cf1c', 5, '101f365e-5c84-438a-84b4-c8e798bd0aff', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:02:48.210751', '2024-08-28 21:02:48.210751');
INSERT INTO public.exercise_example_bundles VALUES ('ddc0e6cb-ee1f-44fe-81dc-35410fc4c0d6', 80, '1f28edb2-29ae-467c-ad11-310c3f656fe2', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:04:44.322521', '2024-08-28 21:04:44.322521');
INSERT INTO public.exercise_example_bundles VALUES ('effbbeea-0fd3-4f82-a987-adc1ffc43554', 15, '1f28edb2-29ae-467c-ad11-310c3f656fe2', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:04:44.322521', '2024-08-28 21:04:44.322521');
INSERT INTO public.exercise_example_bundles VALUES ('f2b36da1-f603-4a55-af44-f6b39032b5f0', 5, '1f28edb2-29ae-467c-ad11-310c3f656fe2', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:04:44.322521', '2024-08-28 21:04:44.322521');
INSERT INTO public.exercise_example_bundles VALUES ('9540c901-4f6e-47a6-88c9-8ea560256cd2', 85, '04a13a1c-de2b-46f4-be62-3fa6b4655d0d', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:07:18.65042', '2024-08-28 21:07:18.65042');
INSERT INTO public.exercise_example_bundles VALUES ('8c9bf94b-f741-457a-aeac-bf818fd5f718', 10, '04a13a1c-de2b-46f4-be62-3fa6b4655d0d', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:07:18.65042', '2024-08-28 21:07:18.65042');
INSERT INTO public.exercise_example_bundles VALUES ('631957e2-6c5f-49a5-83d5-09d6f86ec463', 5, '04a13a1c-de2b-46f4-be62-3fa6b4655d0d', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:07:18.65042', '2024-08-28 21:07:18.65042');
INSERT INTO public.exercise_example_bundles VALUES ('4cc17443-d7c3-4c36-8d9e-ecd3dc543382', 85, 'a9545ccb-3ec7-4646-95c9-f3a708d0d968', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:08:56.496251', '2024-08-28 21:08:56.496251');
INSERT INTO public.exercise_example_bundles VALUES ('74095fef-97e6-4916-bf1e-d703ea4cb8e9', 10, 'a9545ccb-3ec7-4646-95c9-f3a708d0d968', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:08:56.496251', '2024-08-28 21:08:56.496251');
INSERT INTO public.exercise_example_bundles VALUES ('059e32e7-5719-460b-bcb6-38aa5024e8d9', 5, 'a9545ccb-3ec7-4646-95c9-f3a708d0d968', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:08:56.496251', '2024-08-28 21:08:56.496251');
INSERT INTO public.exercise_example_bundles VALUES ('de8d2675-d4b6-4bb0-a1d1-890af84cdb6e', 85, 'b99df7e8-eb44-4be1-be81-701347580781', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:11:35.040483', '2024-08-28 21:11:35.040483');
INSERT INTO public.exercise_example_bundles VALUES ('01ce0a2c-8cb9-4542-9240-1e901564e901', 10, 'b99df7e8-eb44-4be1-be81-701347580781', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:11:35.040483', '2024-08-28 21:11:35.040483');
INSERT INTO public.exercise_example_bundles VALUES ('bdbb9c39-070c-4847-a2ab-977959c11119', 5, 'b99df7e8-eb44-4be1-be81-701347580781', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:11:35.040483', '2024-08-28 21:11:35.040483');
INSERT INTO public.exercise_example_bundles VALUES ('7f67c08f-1397-41d3-b294-6f306aed2f30', 85, '8d2a9df4-af32-4943-b74b-ae901e866b32', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:12:39.510696', '2024-08-28 21:12:39.510696');
INSERT INTO public.exercise_example_bundles VALUES ('2e6b5842-c52d-43d2-acda-67fe18055829', 10, '8d2a9df4-af32-4943-b74b-ae901e866b32', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:12:39.510696', '2024-08-28 21:12:39.510696');
INSERT INTO public.exercise_example_bundles VALUES ('3bf2065d-b91a-436f-90fa-0ba57755cbb3', 5, '8d2a9df4-af32-4943-b74b-ae901e866b32', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:12:39.510696', '2024-08-28 21:12:39.510696');
INSERT INTO public.exercise_example_bundles VALUES ('52a0e7d8-4962-4192-9dfb-9f0f5b48ac59', 85, '8ca7bf65-0ddb-4c64-ba64-f71f25c85d7c', '97a87b01-35e8-490a-94b9-9bdae9c2f965', '2024-08-28 21:13:34.07981', '2024-08-28 21:13:34.07981');
INSERT INTO public.exercise_example_bundles VALUES ('121f3152-c07b-44cc-b7f3-ef38e2b31c5d', 10, '8ca7bf65-0ddb-4c64-ba64-f71f25c85d7c', '9a8024fe-c721-4bea-969c-db88674b5ece', '2024-08-28 21:13:34.07981', '2024-08-28 21:13:34.07981');
INSERT INTO public.exercise_example_bundles VALUES ('8ae3652b-8d1e-4eac-9b91-9026dbf38473', 5, '8ca7bf65-0ddb-4c64-ba64-f71f25c85d7c', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-28 21:13:34.07981', '2024-08-28 21:13:34.07981');
INSERT INTO public.exercise_example_bundles VALUES ('35d1707b-aa87-43b3-a320-752801d2a79e', 85, '12221e5c-0208-48fc-8c56-62c266932f74', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:15:51.730675', '2024-08-29 15:15:51.730675');
INSERT INTO public.exercise_example_bundles VALUES ('46c80286-6bff-4f69-851b-910d2369a1d6', 10, '12221e5c-0208-48fc-8c56-62c266932f74', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:15:51.730675', '2024-08-29 15:15:51.730675');
INSERT INTO public.exercise_example_bundles VALUES ('50486b86-ebd4-4b4c-9280-8411cdc4715e', 5, '12221e5c-0208-48fc-8c56-62c266932f74', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 15:15:51.730675', '2024-08-29 15:15:51.730675');
INSERT INTO public.exercise_example_bundles VALUES ('0da7deec-6af4-4e4a-a41d-110faa0c4576', 65, '1959abd3-4ab1-42d4-b7e2-45693b899d51', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:18:06.541035', '2024-08-29 15:18:06.541035');
INSERT INTO public.exercise_example_bundles VALUES ('67e88933-f17e-4044-bf29-07ce3bff2a16', 15, '1959abd3-4ab1-42d4-b7e2-45693b899d51', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:18:06.541035', '2024-08-29 15:18:06.541035');
INSERT INTO public.exercise_example_bundles VALUES ('298c95e6-0f7b-49a3-a70f-183a2e983c62', 10, '1959abd3-4ab1-42d4-b7e2-45693b899d51', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:18:06.541035', '2024-08-29 15:18:06.541035');
INSERT INTO public.exercise_example_bundles VALUES ('033d08b2-7d9d-42e2-aaf1-0bfe73fe9645', 5, '1959abd3-4ab1-42d4-b7e2-45693b899d51', '57559b71-b757-468a-983d-a1b3cec4acef', '2024-08-29 15:18:06.541035', '2024-08-29 15:18:06.541035');
INSERT INTO public.exercise_example_bundles VALUES ('e9794145-8423-4dc7-9582-24fc055ce404', 65, '48191b99-06fa-4218-b61b-c9b9abd73278', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:20:32.339592', '2024-08-29 15:20:32.339592');
INSERT INTO public.exercise_example_bundles VALUES ('2de49805-defb-4a66-9797-b3988ab9598a', 15, '48191b99-06fa-4218-b61b-c9b9abd73278', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:20:32.339592', '2024-08-29 15:20:32.339592');
INSERT INTO public.exercise_example_bundles VALUES ('705d2863-3dc4-4bfd-ab14-ad96b598c0ee', 15, '48191b99-06fa-4218-b61b-c9b9abd73278', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:20:32.339592', '2024-08-29 15:20:32.339592');
INSERT INTO public.exercise_example_bundles VALUES ('4e86593f-e6d9-435f-8f86-8383d4a953c9', 70, '92d77415-1f9a-430b-ba52-0a09ec07b3a1', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:21:42.163608', '2024-08-29 15:21:42.163608');
INSERT INTO public.exercise_example_bundles VALUES ('f24f55d1-01e8-4e27-a61f-c4097fb3c8cb', 15, '92d77415-1f9a-430b-ba52-0a09ec07b3a1', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:21:42.163608', '2024-08-29 15:21:42.163608');
INSERT INTO public.exercise_example_bundles VALUES ('2509772e-d8c9-475b-9fdc-d59578f9b428', 15, '92d77415-1f9a-430b-ba52-0a09ec07b3a1', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:21:42.163608', '2024-08-29 15:21:42.163608');
INSERT INTO public.exercise_example_bundles VALUES ('996ebef3-4e0e-4b2b-ac23-9b83dd52c1c4', 70, '816440ad-f8f2-4ef7-a11f-b6a2bd63fcef', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 15:23:10.34105', '2024-08-29 15:23:10.34105');
INSERT INTO public.exercise_example_bundles VALUES ('f240102b-68d2-4f97-98ba-dec59ac1d7b2', 10, '816440ad-f8f2-4ef7-a11f-b6a2bd63fcef', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:23:10.34105', '2024-08-29 15:23:10.34105');
INSERT INTO public.exercise_example_bundles VALUES ('9c005217-ecae-4588-bc94-a17b6d256e16', 70, '506d1cc7-529a-42af-b5bf-4c4d0a9aa409', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:24:22.337443', '2024-08-29 15:24:22.337443');
INSERT INTO public.exercise_example_bundles VALUES ('a05478f7-9b9b-4514-b8f7-473a3a3753fd', 15, '506d1cc7-529a-42af-b5bf-4c4d0a9aa409', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:24:22.337443', '2024-08-29 15:24:22.337443');
INSERT INTO public.exercise_example_bundles VALUES ('39701760-5842-4e25-a670-9de44f4d7bf1', 15, '506d1cc7-529a-42af-b5bf-4c4d0a9aa409', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:24:22.337443', '2024-08-29 15:24:22.337443');
INSERT INTO public.exercise_example_bundles VALUES ('78474d36-735e-4cfe-935d-216162d59fbe', 70, '9ab8fe00-58de-48c4-942d-b10e8d16f1c1', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:26:45.186356', '2024-08-29 15:26:45.186356');
INSERT INTO public.exercise_example_bundles VALUES ('f8fb1559-f946-4f2e-b8c6-10d92bd45719', 15, '9ab8fe00-58de-48c4-942d-b10e8d16f1c1', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:26:45.186356', '2024-08-29 15:26:45.186356');
INSERT INTO public.exercise_example_bundles VALUES ('e6f4ebc5-0b4b-4a73-b430-cf6654c97450', 10, '9ab8fe00-58de-48c4-942d-b10e8d16f1c1', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:26:45.186356', '2024-08-29 15:26:45.186356');
INSERT INTO public.exercise_example_bundles VALUES ('8baba903-12c2-4d7f-8f0b-7e29c710dfdf', 70, '3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 15:28:20.98104', '2024-08-29 15:28:20.98104');
INSERT INTO public.exercise_example_bundles VALUES ('5d3f7ec4-0cea-43e2-9759-3541ff71716d', 10, '3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:28:20.98104', '2024-08-29 15:28:20.98104');
INSERT INTO public.exercise_example_bundles VALUES ('a0d71ab1-ffc9-44a9-b058-bed5d2c3a18e', 85, '77aa5752-a586-4dfe-b69d-4da16fff0b79', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:30:57.606742', '2024-08-29 15:30:57.606742');
INSERT INTO public.exercise_example_bundles VALUES ('186ba70a-7eac-43e4-8dbd-aaefeefa2921', 10, '77aa5752-a586-4dfe-b69d-4da16fff0b79', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:30:57.606742', '2024-08-29 15:30:57.606742');
INSERT INTO public.exercise_example_bundles VALUES ('f834bc81-45b6-47fd-bb54-2a6435dc400e', 5, '77aa5752-a586-4dfe-b69d-4da16fff0b79', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 15:30:57.606742', '2024-08-29 15:30:57.606742');
INSERT INTO public.exercise_example_bundles VALUES ('8bbcb4b4-a8b1-492f-bdb6-d4674bea4ff5', 70, '4035dfef-3cc6-4a15-a97f-c167bd274d02', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 15:34:32.570508', '2024-08-29 15:34:32.570508');
INSERT INTO public.exercise_example_bundles VALUES ('1624cc25-90f3-463c-8f09-e6abe7b598fd', 15, '4035dfef-3cc6-4a15-a97f-c167bd274d02', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 15:34:32.570508', '2024-08-29 15:34:32.570508');
INSERT INTO public.exercise_example_bundles VALUES ('f5f95f04-8afc-4bf4-95d2-e37b6bc9c254', 10, '4035dfef-3cc6-4a15-a97f-c167bd274d02', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 15:34:32.570508', '2024-08-29 15:34:32.570508');
INSERT INTO public.exercise_example_bundles VALUES ('baf0c79a-5c3a-4f8c-816a-eed36d2b6722', 60, 'aada0f37-1f30-4d61-a284-8003027bc871', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 20:14:43.144259', '2024-08-29 20:14:43.144259');
INSERT INTO public.exercise_example_bundles VALUES ('cbf0c97b-87f3-4e43-bd24-1eab52a07b09', 15, 'aada0f37-1f30-4d61-a284-8003027bc871', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-29 20:14:43.144259', '2024-08-29 20:14:43.144259');
INSERT INTO public.exercise_example_bundles VALUES ('c4cd69f4-952e-4252-a230-40c898157d69', 60, 'afd7f719-5789-48a0-a5d9-77e9cb1669bb', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 20:16:07.195713', '2024-08-29 20:16:07.195713');
INSERT INTO public.exercise_example_bundles VALUES ('35f7b0bc-cd7a-4212-8711-34d59cec57a7', 15, 'afd7f719-5789-48a0-a5d9-77e9cb1669bb', '831f39bd-80a8-4d11-9964-bde1788abae1', '2024-08-29 20:16:07.195713', '2024-08-29 20:16:07.195713');
INSERT INTO public.exercise_example_bundles VALUES ('08cfc3f2-c523-4530-9b62-978405f4d186', 70, '16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:17:41.63891', '2024-08-29 20:17:41.63891');
INSERT INTO public.exercise_example_bundles VALUES ('c05764b0-06cb-45c8-b1e6-45a7e028eec1', 15, '16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:17:41.63891', '2024-08-29 20:17:41.63891');
INSERT INTO public.exercise_example_bundles VALUES ('24bcb630-9149-45f6-9672-5ab33892d7b5', 10, '16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 20:17:41.63891', '2024-08-29 20:17:41.63891');
INSERT INTO public.exercise_example_bundles VALUES ('1da6f04d-13df-4d65-a7fd-281a50c0e732', 75, '3a70ce9c-b1f0-43a7-8775-7d3e7c109c5d', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 20:18:52.139204', '2024-08-29 20:18:52.139204');
INSERT INTO public.exercise_example_bundles VALUES ('e5ab98fc-3b8d-46c6-a3f0-716e5bb5bcc3', 85, '4353173b-93b2-4fb1-b462-fc8330b15ce5', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:20:58.538331', '2024-08-29 20:20:58.538331');
INSERT INTO public.exercise_example_bundles VALUES ('8b66e798-34af-4619-ac4c-2f92c35fcbf5', 15, '4353173b-93b2-4fb1-b462-fc8330b15ce5', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:20:58.538331', '2024-08-29 20:20:58.538331');
INSERT INTO public.exercise_example_bundles VALUES ('19642115-011c-498a-9c16-929cf39df0b4', 80, '1b8fe6fc-9ede-4f28-b4a0-30504db61fed', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:26:45.600818', '2024-08-29 20:26:45.600818');
INSERT INTO public.exercise_example_bundles VALUES ('4e34e6e0-acb2-4693-9523-09ecac106c8d', 10, '1b8fe6fc-9ede-4f28-b4a0-30504db61fed', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:26:45.600818', '2024-08-29 20:26:45.600818');
INSERT INTO public.exercise_example_bundles VALUES ('c2a59210-7416-489f-8b30-ce4642d41e19', 65, '90b8d661-a9ef-47e5-8c98-b0599874a972', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:28:36.088381', '2024-08-29 20:28:36.088381');
INSERT INTO public.exercise_example_bundles VALUES ('2abfee71-b506-41ea-b502-e32795d0d3e5', 20, '90b8d661-a9ef-47e5-8c98-b0599874a972', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:28:36.088381', '2024-08-29 20:28:36.088381');
INSERT INTO public.exercise_example_bundles VALUES ('65043464-547a-457f-ac99-90035c81e778', 10, '90b8d661-a9ef-47e5-8c98-b0599874a972', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 20:28:36.088381', '2024-08-29 20:28:36.088381');
INSERT INTO public.exercise_example_bundles VALUES ('e7f81e4e-2e60-4ba4-8a30-850735b416ff', 85, 'ac45c513-55f3-437f-a10f-ba3c0763a746', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:31:23.026096', '2024-08-29 20:31:23.026096');
INSERT INTO public.exercise_example_bundles VALUES ('69cfa607-cddb-4635-bb1c-f4a39bf7baa6', 15, 'ac45c513-55f3-437f-a10f-ba3c0763a746', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:31:23.026096', '2024-08-29 20:31:23.026096');
INSERT INTO public.exercise_example_bundles VALUES ('0ca31014-7d80-4f94-974c-8907ab49cd66', 25, '3a70ce9c-b1f0-43a7-8775-7d3e7c109c5d', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:18:52.139204', '2024-08-29 20:18:52.139204');
INSERT INTO public.exercise_example_bundles VALUES ('14390b19-58d5-4baa-bfe1-1545a83dcee6', 25, 'aada0f37-1f30-4d61-a284-8003027bc871', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:14:43.144259', '2024-08-29 20:14:43.144259');
INSERT INTO public.exercise_example_bundles VALUES ('c2f13f0a-8685-405e-a687-8f88f9c67358', 10, '1b8fe6fc-9ede-4f28-b4a0-30504db61fed', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:26:45.600818', '2024-08-29 20:26:45.600818');
INSERT INTO public.exercise_example_bundles VALUES ('c84d35b2-b004-4603-b40f-c10fa3f6f34e', 5, '16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:17:41.63891', '2024-08-29 20:17:41.63891');
INSERT INTO public.exercise_example_bundles VALUES ('9c7f4c7e-622b-4780-b9fb-d63085f63e01', 20, '816440ad-f8f2-4ef7-a11f-b6a2bd63fcef', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 15:23:10.34105', '2024-08-29 15:23:10.34105');
INSERT INTO public.exercise_example_bundles VALUES ('5a0929d3-3ca3-4199-8650-733c33edff75', 20, '3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 15:28:20.98104', '2024-08-29 15:28:20.98104');
INSERT INTO public.exercise_example_bundles VALUES ('2e773854-1c03-4979-990e-5f99034b712f', 25, 'afd7f719-5789-48a0-a5d9-77e9cb1669bb', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:16:07.195713', '2024-08-29 20:16:07.195713');
INSERT INTO public.exercise_example_bundles VALUES ('7d31886d-671b-435c-911c-0a7eeb1b06ae', 5, '9ab8fe00-58de-48c4-942d-b10e8d16f1c1', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 15:26:45.186356', '2024-08-29 15:26:45.186356');
INSERT INTO public.exercise_example_bundles VALUES ('d788b68a-eb98-4bc0-b79f-8b6453326295', 5, '1959abd3-4ab1-42d4-b7e2-45693b899d51', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 15:18:06.541035', '2024-08-29 15:18:06.541035');
INSERT INTO public.exercise_example_bundles VALUES ('f9378064-767c-4923-91f7-9e262029841b', 5, '90b8d661-a9ef-47e5-8c98-b0599874a972', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:28:36.088381', '2024-08-29 20:28:36.088381');
INSERT INTO public.exercise_example_bundles VALUES ('70288cb4-32bf-49ac-b370-c8a11609ee49', 5, '4035dfef-3cc6-4a15-a97f-c167bd274d02', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 15:34:32.570508', '2024-08-29 15:34:32.570508');
INSERT INTO public.exercise_example_bundles VALUES ('1dd0c1ca-e7bb-4806-ac66-e924c4bd41c1', 5, '48191b99-06fa-4218-b61b-c9b9abd73278', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 15:20:32.339592', '2024-08-29 15:20:32.339592');
INSERT INTO public.exercise_example_bundles VALUES ('d30434cf-f748-4299-af46-65f7300e4390', 90, '3a41edcb-2c19-4d06-9585-8fe745aba723', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:34:53.748206', '2024-08-29 20:34:53.748206');
INSERT INTO public.exercise_example_bundles VALUES ('7300f52e-1789-4649-8f38-d8c8006be688', 10, '3a41edcb-2c19-4d06-9585-8fe745aba723', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:34:53.748206', '2024-08-29 20:34:53.748206');
INSERT INTO public.exercise_example_bundles VALUES ('e86dab08-8334-4690-8652-1c6fe128cf5f', 80, 'b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 20:37:21.061386', '2024-08-29 20:37:21.061386');
INSERT INTO public.exercise_example_bundles VALUES ('89ef302e-7b77-49e8-be04-0e3062b5c166', 10, 'b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:37:21.061386', '2024-08-29 20:37:21.061386');
INSERT INTO public.exercise_example_bundles VALUES ('89a7929f-d43e-4ecc-8b29-ef6f8688304d', 10, 'b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 20:37:21.061386', '2024-08-29 20:37:21.061386');
INSERT INTO public.exercise_example_bundles VALUES ('e08096ec-27f0-4478-bb9e-853bf4b7b07e', 70, 'ed5db0ac-4343-4e68-a884-d5f84e4020c1', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 20:46:11.388752', '2024-08-29 20:46:11.388752');
INSERT INTO public.exercise_example_bundles VALUES ('70ff85e6-3839-408c-b9c5-d0860f1a8bf0', 30, 'ed5db0ac-4343-4e68-a884-d5f84e4020c1', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:46:11.388752', '2024-08-29 20:46:11.388752');
INSERT INTO public.exercise_example_bundles VALUES ('b435bc67-d0b8-402f-a16f-95460d4555ca', 60, 'd20646b6-efd1-49fc-8ffa-180461aea5ab', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:48:13.154841', '2024-08-29 20:48:13.154841');
INSERT INTO public.exercise_example_bundles VALUES ('c2864939-77db-47b7-b077-3b3a34d53ef3', 40, 'd20646b6-efd1-49fc-8ffa-180461aea5ab', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:48:13.154841', '2024-08-29 20:48:13.154841');
INSERT INTO public.exercise_example_bundles VALUES ('40f232e4-b484-4a7b-8d16-42e8e8ed9883', 50, '1f8abb63-8024-46ca-ac1e-2574a839eed6', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:49:40.17922', '2024-08-29 20:49:40.17922');
INSERT INTO public.exercise_example_bundles VALUES ('25c4d749-d403-4741-8783-ab5664b044d8', 20, '1f8abb63-8024-46ca-ac1e-2574a839eed6', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:49:40.17922', '2024-08-29 20:49:40.17922');
INSERT INTO public.exercise_example_bundles VALUES ('4abedc47-6928-4e31-a8f8-0bb31b217230', 20, '1f8abb63-8024-46ca-ac1e-2574a839eed6', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 20:49:40.17922', '2024-08-29 20:49:40.17922');
INSERT INTO public.exercise_example_bundles VALUES ('66fb7482-1a5f-4bbc-9249-25270b1c0a91', 10, '1f8abb63-8024-46ca-ac1e-2574a839eed6', '9e69205f-6c6e-44a7-8ee6-89215e28a28e', '2024-08-29 20:49:40.17922', '2024-08-29 20:49:40.17922');
INSERT INTO public.exercise_example_bundles VALUES ('501f29fb-afeb-4544-8562-bb19cc2c958b', 60, 'b22e5ada-86c1-4104-828b-b7e06a7f5d16', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 20:52:10.207849', '2024-08-29 20:52:10.207849');
INSERT INTO public.exercise_example_bundles VALUES ('9d034650-7110-4fae-8c78-238edf390402', 20, 'b22e5ada-86c1-4104-828b-b7e06a7f5d16', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:52:10.207849', '2024-08-29 20:52:10.207849');
INSERT INTO public.exercise_example_bundles VALUES ('dda329ff-1aee-42bf-9006-70d3155e9505', 20, 'b22e5ada-86c1-4104-828b-b7e06a7f5d16', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 20:52:10.207849', '2024-08-29 20:52:10.207849');
INSERT INTO public.exercise_example_bundles VALUES ('85059bcb-312a-45ea-a5c0-1bbeb200af13', 85, '7a933584-128c-4b82-8e5b-5e7312cadfdf', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 20:55:27.355761', '2024-08-29 20:55:27.355761');
INSERT INTO public.exercise_example_bundles VALUES ('d71c0a45-f49c-41cf-9782-adc7229b97ed', 15, '7a933584-128c-4b82-8e5b-5e7312cadfdf', 'c57aa60c-61ea-4498-b01f-fedcafe8a32a', '2024-08-29 20:55:27.355761', '2024-08-29 20:55:27.355761');
INSERT INTO public.exercise_example_bundles VALUES ('0ebfceaa-eddc-40b6-9b56-808df984e027', 80, '984e5dac-f3a8-4980-bfc9-da370cf45e46', '97136fa7-622a-49d6-9d09-403a631d253d', '2024-08-29 20:58:25.071017', '2024-08-29 20:58:25.071017');
INSERT INTO public.exercise_example_bundles VALUES ('e50f6ac0-717d-46bd-9131-ee0f408ff106', 15, '984e5dac-f3a8-4980-bfc9-da370cf45e46', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 20:58:25.071017', '2024-08-29 20:58:25.071017');
INSERT INTO public.exercise_example_bundles VALUES ('110189dd-0cb4-4230-be89-48b44bdc9b1f', 5, '984e5dac-f3a8-4980-bfc9-da370cf45e46', '0fd0be35-f933-43b8-a0d7-a4b6adaa9c1a', '2024-08-29 20:58:25.071017', '2024-08-29 20:58:25.071017');
INSERT INTO public.exercise_example_bundles VALUES ('2fa55741-9045-4328-b9e1-2e165aa86388', 80, 'ff188494-a871-4721-9d1e-26742539080c', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 21:01:10.94488', '2024-08-29 21:01:10.94488');
INSERT INTO public.exercise_example_bundles VALUES ('39ef207e-5b1f-4225-b2ba-cdd05ec9b599', 20, 'ff188494-a871-4721-9d1e-26742539080c', '2e0faf2b-31a5-4c63-ac15-454be132796f', '2024-08-29 21:01:10.94488', '2024-08-29 21:01:10.94488');
INSERT INTO public.exercise_example_bundles VALUES ('35979c85-f21c-4888-aa66-77d1b8dd64e5', 90, '68381c41-b015-4218-93cb-2bcb64bee255', 'd736a513-9d73-47a3-bffc-c14911662ea2', '2024-08-29 21:09:08.316316', '2024-08-29 21:09:08.316316');
INSERT INTO public.exercise_example_bundles VALUES ('2e7a9a9f-ba5c-4125-9672-e4215bf74fd9', 10, '68381c41-b015-4218-93cb-2bcb64bee255', '2da3d8f2-6a28-45ff-90a2-ea3a6bb2afe8', '2024-08-29 21:09:08.316316', '2024-08-29 21:09:08.316316');


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
INSERT INTO public.exercise_examples VALUES ('bbfbcfe2-1f56-492e-afa6-75e595b84fde', 'Standing Barbell Curl', '2024-08-27 20:04:23.470927', '2024-08-27 20:04:23.470927', '', 'The standing barbell curl is the cornerstone of many bicep building routines. Grasp a barbell or Olympic bar at around shoulder width apart using an underhand grip (palms facing up).
Stand straight up, feet together (you may be more comfortable putting one foot back for stability), back straight, and with your arms fully extended.
The bar should not be touching your body.
Keeping your eyes facing forwards, elbows tucked in at your sides, and your body completely still, slowly curl the bar up.
Squeeze your biceps hard at the top of the movement, and then slowly lower it back to the starting position.
Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('ddc2e877-7197-42fa-ae1e-59706d209774', 'Standing Dumbbell Curl', '2024-08-27 19:58:20.484787', '2024-08-27 19:58:20.484787', '', 'Assume the starting position for the standing dumbbell curl by grasping a pair of dumbbells and standing straight up, feet together, and dumbbells by your side. The dumbbells should not be touching your body.
Your palms should face upwards.
Take up the slack by bending the elbows slightly. Tension should be on the biceps.
Slowly curl the dumbbells up as far as possible.
Squeeze the biceps hard, and then slowly lower the dumbbells back down to the starting position.
Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('8324ae75-08e9-48de-a00b-55d229085712', 'Standing Hammer Curl', '2024-08-27 20:02:25.685377', '2024-08-27 20:02:25.685377', '', 'Grab a pair of dumbbells and stand up with the dumbbells by your sides.
With a neutral grip, bend your arms slightly to keep the tension on the biceps.
With your palms still facing your body, slowly curl the dumbbells up as far as possible.
Squeeze the biceps at the top of the movement, and then slowly lower the weight back to the starting position.
Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('09386394-e4e1-4a6d-adce-d5f5a518485c', 'Incline Dumbbell Curl', '2024-08-27 20:09:12.651079', '2024-08-27 20:09:12.651079', '', 'Position an incline bench at roughly 55-65 degrees, select the desired weight from the rack, and sit upright with your back flat against the pad. Using a supinated (palms up) grip, take a deep breath and curl both dumbbells towards your shoulders. Once the biceps are fully shortened, slowly lower the weights back to the starting position. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('cfb2d83a-b3dc-44e9-ab08-53f9269752d6', 'Concentration Curl', '2024-08-27 20:11:42.117375', '2024-08-27 20:11:42.117375', '', 'Select the desired weight from the rack, and sit in an upright position on a flat bench. Hinge forward and position your elbow near the base of your knee. Place your free hand on the other knee to stabilize yourself. Using a supinated (palms facing up) grip, take a deep breath and curl the dumbbell towards your shoulder. Once the bicep is fully shortened, slowly lower the weight back to the starting position. Repeat for the desired number of repetitions on both sides.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('2522a61a-2190-43e9-ae52-ca6bb023815e', 'Cable Curl', '2024-08-27 20:13:52.504713', '2024-08-27 20:13:52.504713', '', 'Set up for this type of cable curl by attaching a straight bar to the low pulley cable and selecting the weight you want to use on the stack. Stand facing the cable machine with your legs shoulder-width apart. Grasp the rope extension with a neutral grip (thumbs facing the body). With your elbows tucked in by your sides, slowly curl the rope up as far as possible. Squeeze the biceps at the top of the movement, and then slowly lower the weight back to the starting position. This is one rep. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('9fc5ae4d-2868-4576-bb67-9c83663fc005', 'EZ Bar Preacher Curl', '2024-08-27 20:15:21.110573', '2024-08-27 20:15:21.110573', '', 'The EZ bar preacher curl is a great exercise to isolate the biceps while minimizing the strain on your wrists. Adjust the seat on the preacher bench so that your upper arms sit comfortably on the padding when seated. Load the desired weight on the barbell. Sit on the preacher bench and grip the EZ bar with your hands shoulder-width apart using an underhand (palms facing up) grip. (note: You can use a wide or narrow grip on this exercise) Keeping your back straight and eyes facing forward, take the weight off the rack to support it with your arms slightly bent. This is the starting position. Slowly bring the weight up until your forearms are at a right angle to the floor. Squeeze the bicep at the top of the movement and slowly lower it back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('89f423d0-315f-4d93-b346-dcb468a97045', 'Zottman Curl', '2024-08-27 20:17:28.409294', '2024-08-27 20:17:28.409294', '', 'Select the desired weight from the rack and assume a shoulder width stance. Using a supinated grip, take a deep breath and curl the dumbbells towards your shoulders. Once the biceps are fully shortened, rotate the forearms to a pronated position (palms down) and slowly lower the weight back to the starting position. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('194fa2ee-7f92-4982-903e-3db80293d773', 'Barbell Preacher Curl', '2024-08-27 20:20:16.517741', '2024-08-27 20:20:16.517741', '', 'Load the desired weight on the barbell, and sit in an upright position with your chest flat against the preacher bench. Keep your upper arm pressed into the pad and use a supinated grip (palms facing up). Extend your arms until your biceps are fully lengthened. This is the starting position. Take a deep breath and curl the weight by bending at the elbows until the bar is at shoulder height. Squeeze the biceps at the top of the movement and slowly lower the bar back to the starting position. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9', 'Machine Shoulder Press', '2024-08-29 20:17:41.629601', '2024-08-29 20:17:41.629601', '', 'Assume a seated position in the machine with the handles set at roughly shoulder height. Grab the handles with a pronated or neutral grip. Inhale and press directly overhead. Slowly lower the handles back to the starting position. Repeat for the desired number of repetitions.', 'compound', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('f2fb31f0-7f6b-42b6-9a79-c22453ac6a63', 'Alternating Seated Dumbbell Curl', '2024-08-27 20:24:43.747305', '2024-08-27 20:24:43.747305', '', 'Set up for the alternating seated dumbbell curl by grabbing a flat bench and placing a set of dumbbells at one end. Sit on the end of the bench with your feet out in front of you and your knees together. Pick up the dumbbells from the floor and let them hang by your sides with your palms facing up. Bend the arms slightly to take the tension into the biceps. This is the starting position for the exercise. With your back straight and your elbows tucked in at your sides, slowly curl the dumbbell up with one arm. Squeeze the bicep hard, then slowly lower the weight back to the starting position. Repeat for the other arm, and then repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('5e3c933f-7511-463e-88b1-a139c8276e69', 'Cross Body Hammer Curl (Pinwheel Curls)', '2024-08-27 20:27:54.259424', '2024-08-27 20:27:54.259424', '', 'Set up for the cross body hammer curl by grasping a pair of dumbbells and holding them at your sides. You should be using a neutral grip (palms facing the body) and have a slight bend in your arms. This is the starting position for the exercise. Beginning with one arm, slowly curl the dumbbell up across the front of your body. Squeeze the bicep at the top of the movement, and then slowly lower the weight back to the starting position. Repeat this movement for your other arm. This is one rep. Now repeat to complete your set.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('e7f390fd-7435-44e1-b354-c62073934c66', 'Alternating Standing Dumbbell Curl', '2024-08-27 20:29:12.662559', '2024-08-27 20:29:12.662559', '', 'The standing dumbbell curl is a good way to correct any strength and size imbalances in the biceps as it works each muscle individually. Set up for the exercise by grasping a set of dumbbells and standing straight up with the dumbbells by your side. Your palms should be facing up, and the dumbbells should not touch your body. Before starting the set, take up the slack by lifting the weight slightly so the tension is on your bicep muscles. Starting with your weakest arm (usually the left), curl the dumbbell up as far as possible. Squeeze the bicep at the top of the exercise, and then slowly lower the weight down without it touching your body or taking the tension off your bicep. Repeat for the other arm. That''s one rep. Now repeat for the desired amount of reps to complete the set.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('7e0566c6-eefb-4992-a673-d19902933c26', 'Cable Curl (Rope Extension)', '2024-08-28 20:36:41.142025', '2024-08-28 20:36:41.142025', '', 'Set up for this type of cable curl by attaching a rope extension to the low pulley cable and selecting the weight you want to use on the stack. Stand facing the cable machine with your legs shoulder-width apart. Grasp the rope extension with a neutral grip (thumbs facing the body). With your elbows tucked in by your sides, slowly curl the rope up as far as possible. Squeeze the biceps at the top of the movement, and then slowly lower the weight back to the starting position. This is one rep. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('7fd82f79-1f5f-4bae-8f2d-b94ecae595d5', 'Machine Bicep Curl', '2024-08-28 20:38:26.215597', '2024-08-28 20:38:26.215597', '', 'Set up for the machine bicep curl by setting the seat height and selecting the weight you want to use on the stack. Adjust the seat height so your upper arms rest comfortably on the padding. Grasp the bar with an underhand grip around shoulder width apart. Bend the elbows slightly to take the weight up and place tension on the biceps. Slowly curl the weight up as far as possible, squeezing the biceps at the top of the movement. Pause, and then slowly lower the weight. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('908341ec-de1f-44bd-b84d-74ff8a7162a0', 'Alternating Standing Dumbbell Curl', '2024-08-28 20:40:22.148816', '2024-08-28 20:40:22.148816', '', 'Set up for the exercise by grasping a set of dumbbells and standing straight up with the dumbbells by your side. Your palms should be facing up, and the dumbbells should not touch your body. Before starting the set, take up the slack by lifting the weight slightly so the tension is on your bicep muscles. Starting with your weakest arm (usually the left), curl the dumbbell up as far as possible. Squeeze the bicep at the top of the exercise, and then slowly lower the weight down without it touching your body or taking the tension off your bicep. Repeat for the other arm. That''s one rep. Now repeat for the desired amount of reps to complete the set.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('a2736a56-04b3-4437-835e-1e2dc8029c9e', 'Spider Curl', '2024-08-28 20:42:25.582502', '2024-08-28 20:42:25.582502', '', 'To set up for the spider curl you need to either turn the arm padding around 180 degrees or position yourself at the front of the bench facing the seat. Grab an EZ Bar and hold it with an underhand grip around shoulder width apart. Position yourself with your stomach on the padding and arms hanging off the high side. Keep your eyes facing forward and slowly curl the weight up as far as possible. Squeeze the biceps, pause, and then slowly lower the weight back to the bottom. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('da809d98-950b-4ca0-a71b-c67d21fd66da', 'Seated Dumbbell Curl', '2024-08-28 20:44:17.593336', '2024-08-28 20:44:17.593336', '', 'Set up for the seated dumbbell curl by grabbing a flat bench and placing a set of dumbbells at one end. Sit on the end of the bench with your feet out in front of you and your knees together. Pick the dumbbells up off the floor and let them hang by your sides with your palms facing up. Bend the arms slightly to take up the tension in the biceps. This is the starting position for the exercise. With your back straight and your elbows tucked in at your sides, slowly curl both dumbbells up as far as possible. Squeeze the biceps hard, and then slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('4de0744d-0a78-4052-aa1b-e5340959d9fe', 'Standing Dumbbell Reverse Curl', '2024-08-28 20:45:27.508894', '2024-08-28 20:45:27.508894', '', 'Select the desired weight from the rack and assume a shoulder width stance. Using a pronated (palms down) grip, take a deep breath and curl the dumbbells towards your shoulders. Once the biceps are fully shortened, slowly lower the weight back to the starting position. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('d7abed66-3c4a-490b-91cc-8e714336f9fa', 'Dumbbell Preacher Curl', '2024-08-28 20:47:16.396698', '2024-08-28 20:47:16.396698', '', 'Select the desired weight from the rack, and sit in an upright position with your chest flat against the preacher bench. Keep your upper arm pressed into the pad and use a supinated (palms facing up) grip. Take a deep breath and slowly lower the dumbbell away from your shoulder. Once the bicep is fully lengthened, curl the weight back to the starting position. Repeat for the desired number of repetitions on both sides.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('cfd086be-f452-4f1d-b0cc-3988d677a8b4', 'Dumbbell Hammer Preacher Curl', '2024-08-28 20:48:17.207982', '2024-08-28 20:48:17.207982', '', 'Select the desired weight from the rack, and sit in an upright position with your chest flat against the preacher bench. Keep your upper arm pressed into the pad and use a neutral (palms facing up) grip. Take a deep breath and slowly lower the dumbbell away from your shoulder. Once the bicep is fully lengthened, curl the weight back to the starting position. Repeat for the desired number of repetitions on both sides.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('8508cffc-1df6-4db2-9447-3bafd74a1325', 'Seated Hammer Curl', '2024-08-28 20:50:28.789635', '2024-08-28 20:50:28.789635', '', 'Set up for the seated hammer curl by grabbing a flat bench and placing a set of dumbbells at one end. Sit on the end of the bench with your feet out in front of you and your knees together. Pick the dumbbells up off the floor and let them hang by your sides with a neutral grip. Bend the arms slightly to keep tension on the biceps. This is the starting position for the exercise. With your back straight and your elbows tucked in at your sides, slowly curl up the dumbbells up as far as possible. Squeeze the biceps and slowly lower the dumbbells back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('4f1c3655-21e7-4225-a39e-944774f59f76', 'Wide Grip Standing Barbell Curl', '2024-08-28 20:51:35.44937', '2024-08-28 20:51:35.44937', '', 'Grasp a barbell with your hands at a wider than shoulder width, using an underhand grip (palms facing up). Your feet should be firmly on the floor, about shoulder width apart. If you prefer, you can place one foot back. This is the starting position. Keeping your body fixed (do not swing!), slowly curl the weight up as far as possible. Squeeze the biceps, and then slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('6d5dc164-3c35-4719-85f1-5c75558f0125', 'Wide Grip Cable Curl', '2024-08-28 20:53:42.332689', '2024-08-28 20:53:42.332689', '', 'Set up for this type of cable curl by attaching a straight bar to the low pulley cable and selecting the weight you want to use on the stack. Stand facing the cable machine with your legs shoulder-width apart. Grasp the rope extension with a neutral grip (thumbs facing the body), and hands wider than shoulder width apart. With your elbows tucked in by your sides, slowly curl the rope up as far as possible. Squeeze the biceps at the top of the movement, and then slowly lower the weight back to the starting position. This is one rep. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('cebf4622-c0a9-4759-a070-48c7556da67d', 'Squatting Cable Curl', '2024-08-28 20:55:59.966001', '2024-08-28 20:55:59.966001', '', 'The squatting cable curl is a great exercise that allows you to isolate the biceps. Set up for the exercise by attaching a straight bar to the low pulley cable and selecting the weight you want to use on the stack. Stand facing the cable machine and grasp the bar using an underhand grip (palms facing up) with your hands around shoulder width apart. Squat down and rest the back of your arms (just behind the elbows) on your knees. Your knees will act as padding to isolate the biceps. Slowly curl the bar up towards your body as far as possible. Squeeze the biceps, and then slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('4d72c2f1-2c10-45a3-9f5e-1f04012c0681', 'Alternating Incline Dumbbell Curl', '2024-08-28 20:59:16.602427', '2024-08-28 20:59:16.602427', '', 'Set up for the alternating incline dumbbell curl by setting the bench at a 30-45 degree incline and sitting a pair of dumbbells at the end. The lower the incline, the more challenging the exercise will be so 30 degrees is preferred. Sit on the bench, pick up the dumbbells, and lay back with your back flat on the padding. You should be holding the dumbbells with an underhand grip, palms facing up. Take up the slack in your arms by slightly bending them. This will put tension on the biceps. This is the starting position for the exercise. Keeping your elbows fixed, slowly curl up the dumbbell in your weakest arm. Squeeze the bicep at the top of the movement, then slowly lower back to the starting position. Repeat for your other arm, and then repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('af39600b-6fc5-435a-a5f8-a1d0a9994030', 'Incline Bench Dumbbell Curl', '2024-08-28 21:00:57.784199', '2024-08-28 21:00:57.784199', '', 'The incline bench dumbbell curl is a good exercise to isolate the bicep muscle. Set an adjustable bench to an angle of around 45 degrees. Grab a dumbbell and position yourself at the highest end of the bench. Rest the back of your upper arm on the bench padding and allow your arm to fully extend until the dumbbell is almost touching the bench. You should be holding the dumbbell using an underhand grip, palm facing up. Use your other arm for support by holding the bench. Contract your bicep and slowly curl it up as far as possible. Squeeze the muscle, and then slowly lower back to the starting position. Repeat for desired reps, and then repeat for the other arm.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('101f365e-5c84-438a-84b4-c8e798bd0aff', 'Incline Bench Hammer Curl', '2024-08-28 21:02:48.198286', '2024-08-28 21:02:48.198286', '', 'The incline bench dumbbell hammer curl is a good exercise to isolate the bicep muscle while also hitting the forearms. Set an adjustable bench to an angle of around 45 degrees. Grab a dumbbell and position yourself at the highest end of the bench. Rest the back of your upper arm on the bench padding and allow your arm to fully extend until the dumbbell is almost touching the bench. You should be holding the dumbbell using a neutral grip, thumb facing towards you. Use your other arm for support by holding the bench. Tense your bicep and slowly curl it up as far as possible. Squeeze the muscle, and then slowly lower the weight back to the starting position. Repeat for desired reps, and then repeat for the other arm.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('1f28edb2-29ae-467c-ad11-310c3f656fe2', 'Alternating Seated Hammer Curl', '2024-08-28 21:04:44.306578', '2024-08-28 21:04:44.306578', '', 'Set up for the alternating seated hammer curl by grabbing a flat bench and placing a set of dumbbells at one end. Sit on the end of the bench with your feet out in front of you and your knees together. Pick the dumbbells up off the floor and let them hang by your sides with a neutral grip. Bend the arms slightly to keep tension on the biceps. This is the starting position for the exercise. With your back straight and your elbows tucked in at your sides, slowly curl the dumbbell up with one arm. Squeeze the bicep hard, and then slowly lower the dumbbell back to the starting position. Repeat this for your other arm, and then repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('04a13a1c-de2b-46f4-be62-3fa6b4655d0d', 'Barbell Concentration Curl', '2024-08-28 21:07:18.63992', '2024-08-28 21:07:18.63992', '', 'The barbell concentration curl is a great exercise for isolating the biceps. Grab a flat bench and sit the barbell you want to use at one end. Sit on the end of the bench with your feet slightly wider than shoulder width apart. Grasp the barbell with an underhand grip (palms facing up), with your hands about 6-8 inches apart. Lean forward until your upper arms are touching the inside of your thighs. Use your thighs to hold your arms in position throughout the exercise. Keeping your head up, eyes facing forward, slowly curl the barbell up as far as possible. Squeeze the biceps and then slowly lower the bar back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('a9545ccb-3ec7-4646-95c9-f3a708d0d968', 'Two-Arm Low Pulley Cable Curl', '2024-08-28 21:08:56.485198', '2024-08-28 21:08:56.485198', '', 'For this exercise, you will need a cable machine with two low pulley extensions. Set up by attaching a single handle to each of the two low pulley cables and selecting the weight you want to use. Grab each handle with an underhand grip. Standing in the center of the two pulleys, take a step forward. Your arms should be fully extended and slightly behind your body. With your elbows fixed in position, slowly curl your arms up as far as possible. Squeeze the biceps at the top of the movement, and then slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('b99df7e8-eb44-4be1-be81-701347580781', 'Lying Incline Bench Barbell Curl', '2024-08-28 21:11:35.028903', '2024-08-28 21:11:35.028903', '', 'Set an incline bench at a 30-degree angle (If you do not have access to an incline bench you can prop up a straight bench). Grab an EZ bar and place it at the end of the incline bench. Lay on the bench with your chest against the padding. Your chest should be at the end of the bench. Grasp the EZ bar with an underhand grip (palms facing up), with your hands about shoulder-width apart. Keeping your eyes up and bending at the elbows, slowly curl the bar up as far as possible. Squeeze the biceps at the top of the movement, and then slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('afd7f719-5789-48a0-a5d9-77e9cb1669bb', 'Standing Cable Reverse Fly', '2024-08-29 20:16:07.188606', '2024-08-29 20:16:07.188606', '', 'Position two cables at chest height and attach a handle. Reach across your body and grab one handle with a neutral grip. Repeat for the opposite arm. Position the arms straight ahead holding onto each handle and keep a soft bend in the knees. Keep the elbows slightly bent and pull the handles laterally without squeezing the shoulder blades together excessively. Slowly lower the handles back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('8d2a9df4-af32-4943-b74b-ae901e866b32', 'Close Grip EZ Bar Curl', '2024-08-28 21:12:39.501074', '2024-08-28 21:12:39.501074', '', 'Using a close grip on the EZ Bar works the outer parts of the biceps more. Grasp an EZ Bar with an underhand grip (palms facing up). Your hands should be about 6-8 inches apart. Stand straight up, with your feet firmly on the floor at around shoulder width apart. You may find it more comfortable to take one foot back. Keeping your body completely still and eyes facing forward, slowly curl the bar up as far as possible. Squeeze your biceps at the top of the movement, and then slowly lower the weight back down. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('8ca7bf65-0ddb-4c64-ba64-f71f25c85d7c', 'Wide Grip EZ Bar Curl', '2024-08-28 21:13:34.072785', '2024-08-28 21:13:34.072785', '', 'The wide-grip EZ Bar curl is a good exercise for training the inner part of the biceps. Grasp an EZ Bar with your hands at a wider than shoulder width using an underhand grip (palms facing up). Your feet should be firmly on the floor, about shoulder-width apart. If you prefer, you can place one foot back. This is the starting position. Keeping your body fixed (do not swing!), slowly curl the weight up as far as possible. Squeeze the biceps, and then slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('12221e5c-0208-48fc-8c56-62c266932f74', 'Dumbbell Lateral Raise', '2024-08-29 15:15:51.70192', '2024-08-29 15:15:51.70192', '', 'Select the desired weight from the rack, then take a few steps back into an open area. Take a deep breath and raise the dumbbells to shoulder height using a neutral grip (palms facing in) while keeping the elbows slightly bent. Slowly lower the dumbbells back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('1959abd3-4ab1-42d4-b7e2-45693b899d51', 'Military Press (AKA Overhead Press)', '2024-08-29 15:18:06.528089', '2024-08-29 15:18:06.528089', '', 'Adjust the barbell to just below shoulder height then load the desired weight onto the bar. Assume a shoulder width stance and place your hands at (or just outside of) shoulder width with a pronated grip on the bar. Step underneath the bar and unrack it while keeping the spine in a neutral position. Take two steps back, inhale, brace, tuck the chin, then press the bar to lockout overhead. Exhale once the bar gets to lockout and reverse the movement slowly while controlling the bar back to your chest. Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('48191b99-06fa-4218-b61b-c9b9abd73278', 'Seated Dumbbell Press', '2024-08-29 15:20:32.329274', '2024-08-29 15:20:32.329274', '', 'Set up an adjustable angle bench to 90 degrees and select the desired weight from the rack. Pick up the dumbbells from the floor using a neutral grip (palms facing in). Position the end of the dumbbells on your knees and sit down on the bench. Using a safe and controlled motion, kick your knees up one at a time in order to get each dumbbell into place. Once the dumbbells are in place, rotate your palms so they are facing forward. Take a deep breath then press the dumbbells overhead by extending the elbows and contracting the deltoids. Slowly lower the dumbbells back to the starting position (the arms should be roughly 90 degrees or slightly lower depending upon limb lengths). Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('92d77415-1f9a-430b-ba52-0a09ec07b3a1', 'Standing Dumbbell Shoulder Press', '2024-08-29 15:21:42.152136', '2024-08-29 15:21:42.152136', '', 'Set up for the exercise by grabbing a pair of dumbbells and standing up with your feet around shoulder width apart. Raise the dumbbells to shoulder height on each side, and rotate your palms so they are facing forward. This is the starting position for the exercise. Take a deep breath then press the dumbbells overhead by extending the elbows and contracting the deltoids. Slowly lower the dumbbells back to the starting position (the arms should be roughly 90 degrees or slightly lower depending upon limb lengths). Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('816440ad-f8f2-4ef7-a11f-b6a2bd63fcef', 'Bent Over Dumbbell Reverse Fly', '2024-08-29 15:23:10.33151', '2024-08-29 15:23:10.33151', '', 'Select the desired weight from the rack then take a few steps back into an open area. Hinge from the hips until your body is almost parallel to the floor and allow the arms to hang straight down from the shoulders with a neutral grip. Take a deep breath and pull the dumbbells towards the ceiling using the rear deltoids. Slowly lower the dumbbells back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('506d1cc7-529a-42af-b5bf-4c4d0a9aa409', 'Smith Machine Shoulder Press', '2024-08-29 15:24:22.323538', '2024-08-29 15:24:22.323538', '', 'Place an adjustable bench in the Smith machine and adjust the back to a 90-degree angle. Adjust the bar to around eye level and load the desired weight on the bar. Position your hands around shoulder-width apart and unrack the bar using a pronated grip. This is the starting position for the movement. Press the bar overhead by extending the elbows and contracting the deltoids. Slowly lower the bar back to the starting position (the arms should be roughly 90 degrees or slightly lower depending on limb lengths). Repeat for the desired number of repetitions.', 'compound', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('9ab8fe00-58de-48c4-942d-b10e8d16f1c1', 'Seated Arnold Press', '2024-08-29 15:26:45.175874', '2024-08-29 15:26:45.175874', '', 'Set up an adjustable angle bench to 90 degrees and select the desired weight from the rack. Pick up the dumbbells from the floor using a neutral grip (palms facing in). Position the end of the dumbbells on your knees and sit down on the bench. Using a safe and controlled motion, kick your knees up one at a time in order to get each dumbbell into place. Once the dumbbells are in place, rotate your palms so they are facing you. Take a deep breath then press the dumbbells overhead by extending the elbows and contracting the deltoids. As you press, rotate the dumbbells until your palms are facing forward. Slowly lower the dumbbells back to the starting position (the arms should be roughly 90 degrees or slightly lower depending upon limb lengths). Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4', 'Seated Bent Over Dumbbell Reverse Fly', '2024-08-29 15:28:20.973087', '2024-08-29 15:28:20.973087', '', 'Secure a flat bench and select the desired weight from the rack. Sit in an upright position and then hinge forward from the hips. Allow the arms to hang straight down from the shoulders with a neutral grip and dumbbells behind your calves. Take a deep breath and pull the dumbbells towards the ceiling using the rear deltoids. Slowly lower the dumbbells back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('77aa5752-a586-4dfe-b69d-4da16fff0b79', 'Seated Dumbbell Lateral Raise', '2024-08-29 15:30:57.598844', '2024-08-29 15:30:57.598844', '', 'Grab a pair of dumbbells with a neutral grip and sit on the edge of a flat bench with your feet around shoulder width apart. This is the starting position for the exercise. Slowly raise the dumbbells to around shoulder height. Pause and slowly lower the dumbbell back to the starting position. Repeat for desired reps.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('4035dfef-3cc6-4a15-a97f-c167bd274d02', 'Seated Barbell Shoulder Press', '2024-08-29 15:34:32.562958', '2024-08-29 15:34:32.562958', '', 'Adjust the barbell to just below shoulder height while standing then load the desired weight onto the bar. Place an adjustable bench beneath the bar in an upright position. Sit down on the bench and unrack the bar using a pronated grip. Inhale, brace, tuck the chin, then lower the bar to the top of your chest. Exhale and press the bar back to lockout. Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('aada0f37-1f30-4d61-a284-8003027bc871', 'Cable Face Pull', '2024-08-29 20:14:43.135772', '2024-08-29 20:14:43.135772', '', 'Assume a split stance with the arms straight out in front of you utilizing a pronated grip. Inhale and pull the rope towards your face with the elbows high. Slowly lower the rope back to the starting position and repeat for the desired number of repetitions on both sides.', 'compound', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('3a70ce9c-b1f0-43a7-8775-7d3e7c109c5d', 'Machine Reverse Fly', '2024-08-29 20:18:52.12644', '2024-08-29 20:18:52.12644', '', 'Face the fly machine while seated with your chest against the pad and the handles positioned in front of your torso. Reach forward and grasp each handle with a pronated or neutral grip. Contract the rear delts while keeping the elbows bent and open the arms in a reverse fly motion. Slowly lower the handles back to the starting position and repeat for the desired number of repetitions.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('4353173b-93b2-4fb1-b462-fc8330b15ce5', 'Cable Lateral Raise', '2024-08-29 20:20:58.523546', '2024-08-29 20:20:58.523546', '', 'Set the pulleys of a dual cable machine to the low setting and select the weight you wish to use. Stand facing away from the machine and grasp opposite handles with opposite hands. Stand straight up with your arms in front of you (crossed over). The weight should be slightly off the stack. This is the starting position for the movement. Keeping your elbows high, extend your arms out in a semi-circle motion. Once your hands get to around shoulder height, pause and slowly lower the weight back to the starting position. Repeat for desired reps.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('1b8fe6fc-9ede-4f28-b4a0-30504db61fed', 'Single Arm Cable Lateral Raise (Crossbody)', '2024-08-29 20:26:45.591795', '2024-08-29 20:26:45.591795', '', 'Position a cable at the lowest position possible and attach a single handle. Reach across your body and grab the handle with a neutral grip. Keep the elbow slightly bent and pull the handle across your body and raise laterally. Slowly lower the handle back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'pull', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('90b8d661-a9ef-47e5-8c98-b0599874a972', 'Seated Behind the Neck Shoulder Press', '2024-08-29 20:28:36.062554', '2024-08-29 20:28:36.062554', '', 'Adjust the barbell to just below shoulder height while standing then load the desired weight onto the bar. Place an adjustable bench beneath the bar in an upright position. Sit down on the bench and unrack the bar using a pronated grip. Inhale, brace, tuck the chin, then lower the bar to the back of your neck. Exhale and press the bar back to lockout. Repeat for the desired number of repetitions.', 'compound', 'fixed', 'push', 'intermediate');
INSERT INTO public.exercise_examples VALUES ('ac45c513-55f3-437f-a10f-ba3c0763a746', 'Standing Dumbbell Front Raise', '2024-08-29 20:31:23.01677', '2024-08-29 20:31:23.01677', '', 'Choose a pair of dumbbells with a pronated grip and assume a shoulder-width stance. Inhale, brace your abs and raise your arms vertically while keeping a slight bend in your elbow. Once your arms are parallel with the floor, slowly lower the dumbbells back to the starting position. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('3a41edcb-2c19-4d06-9585-8fe745aba723', 'Machine Lateral Raise', '2024-08-29 20:34:53.7379', '2024-08-29 20:34:53.7379', '', 'Begin by selecting the weight you wish to use on the stack of a lateral raise machine. Adjust the seat height and sit facing the machine with your feet flat on the floor around shoulder width apart. Secure your arms in the padding and grip the handles. Look straight ahead. You are now ready to begin the exercise. With a bend in the elbows and moving only at the shoulders, begin pushing the weight up until your forearms are just above parallel. Contract your shoulders at the height of the movement and begin slowly lowering the weight using the same semicircle motion you used raise it. Repeat this movement for desired reps.', 'isolation', 'fixed', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1', 'Bent Over Rear Delt Fly (Head on Bench)', '2024-08-29 20:37:21.051883', '2024-08-29 20:37:21.051883', '', 'Position an incline bench at roughly 70-80 degrees and select the desired weight from the rack. Hinge from the hips until your head is resting comfortably on the incline bench and allow the arms to hang straight down from the shoulders with a neutral grip. Take a deep breath and pull the dumbbells towards the ceiling using the rear deltoids. Slowly lower the dumbbells back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('ed5db0ac-4343-4e68-a884-d5f84e4020c1', 'Bent Over Low Pulley Rear Delt Fly', '2024-08-29 20:46:11.377576', '2024-08-29 20:46:11.377576', '', 'Position two cables at the bottom of the cable pulley machine and attach a handle. Hinge forward, reach across your body, and grab the handle with a neutral grip. Repeat for the opposite arm. Allow the arms to hang straight down and keep a soft bend in the knees. Keep the elbows slightly bent and pull the handles laterally without squeezing the shoulder blades together excessively. Slowly lower the handle back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('d20646b6-efd1-49fc-8ffa-180461aea5ab', 'Smith Machine Upright Row', '2024-08-29 20:48:13.145019', '2024-08-29 20:48:13.145019', '', 'Select the desired weight and load it onto a barbell. Unrack the bar by rotating the safety latches off the j-hooks. Inhale, brace your abs, and then lead the movement by driving the elbows high as you pull the bar to chest height. When the bar has reached its peak, reverse the movement slowly while controlling the bar back to the starting position. Repeat for the desired number of repetitions.', 'compound', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('1f8abb63-8024-46ca-ac1e-2574a839eed6', 'Push Press', '2024-08-29 20:49:40.170706', '2024-08-29 20:49:40.170706', '', 'Adjust the barbell to just below shoulder height then load the desired weight onto the bar. Assume a shoulder width stance and place your hands at (or just outside of) shoulder width with a pronated grip on the bar. Step underneath the bar and unrack it while keeping the spine in a neutral position. Take two steps back, inhale, brace, and tuck the chin to prepare to go overhead. Dip slightly at the knees and hips, then press the bar to lockout overhead by extending your legs and arms simultaneously. Exhale once the bar gets to lockout and reverse the movement slowly while controlling the bar back to your chest. Repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('b22e5ada-86c1-4104-828b-b7e06a7f5d16', 'Seated Neutral Grip Dumbbell Shoulder Press', '2024-08-29 20:52:10.197207', '2024-08-29 20:52:10.197207', '', 'Set up an adjustable angle bench to 90 degrees and select the desired weight from the rack. Pick up the dumbbells from the floor using a neutral grip (palms facing in). Position the end of the dumbbells on your knees and sit down on the bench. Using a safe and controlled motion, kick your knees up one at a time in order to get each dumbbell into place. Take a deep breath then press the dumbbells overhead by extending the elbows and contracting the deltoids. Slowly lower the dumbbells back to the starting position (the arms should be roughly 90 degrees or slightly lower depending upon limb lengths). Maintain a neutral grip throughout the duration of the exercise and repeat for the desired number of repetitions.', 'compound', 'free', 'push', 'beginner');
INSERT INTO public.exercise_examples VALUES ('7a933584-128c-4b82-8e5b-5e7312cadfdf', 'One-Arm Cable Front Raise', '2024-08-29 20:55:27.345366', '2024-08-29 20:55:27.345366', '', 'Set up for the exercise by attaching a single grip handle to a low pulley cable machine and selecting the weight you want to use. Stand facing away from the machine and grip the handle with one hand using an overhand grip (palm facing down). Stand up and hold the handle just off your thighs pulling weight off the stack. This is the starting position. To execute, slowly raise the handle to around shoulder height while keeping your arm straight and your body fixed. Pause, and then slowly lower the weight to the starting position. Do not allow the stack to drop or the handle to touch your body. Repeat for desired reps and then repeat using your right arm.', 'isolation', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('984e5dac-f3a8-4980-bfc9-da370cf45e46', 'Incline Rear Delt Fly', '2024-08-29 20:58:25.061062', '2024-08-29 20:58:25.061062', '', 'Set up for the exercise by setting an adjustable back bench to an angle of around 30-40 degrees. Grab a set of dumbbells and position yourself with your chest on the back of the bench (prone position). Plant your feet on the floor for stability and hold the dumbbells with a neutral grip. Take a deep breath and pull the dumbbells towards the ceiling using the rear deltoids. Slowly lower the dumbbells back to the starting position under control. Repeat for the desired number of repetitions.', 'isolation', 'free', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('ff188494-a871-4721-9d1e-26742539080c', 'Cable Front Raise (Bilateral)', '2024-08-29 21:01:10.936876', '2024-08-29 21:01:10.936876', '', 'Assume a shoulder width stance with the cable running between your legs and grasp the handle with both hands using a pronated grip. Inhale, brace your abs, and raise the arms vertically while keeping the elbows slightly bent. Once the arms are parallel with the floor, slowly lower the handle back to the starting position. Repeat for the desired number of repetitions.', 'compound', 'fixed', 'pull', 'beginner');
INSERT INTO public.exercise_examples VALUES ('68381c41-b015-4218-93cb-2bcb64bee255', 'One-Arm Standing Dumbbell Front Raise', '2024-08-29 21:09:08.306005', '2024-08-29 21:09:08.306005', '', 'Grab a dumbbell with a pronated grip and assume a shoulder-width stance. This is the starting position.
Inhale, brace your core and raise your arm vertically while keeping a slight bend in your elbow.
Moving only at the shoulder, continue raising the dumbbell until your arm is just above parallel to the floor.
Pause for a brief moment at the top of the movement, and slowly lower the dumbbell back to the starting position.
Repeat for desired reps, and then repeat the movement with your other arm.', 'isolation', 'free', 'pull', 'beginner');


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
INSERT INTO public.exercise_examples_equipments VALUES ('919bf994-abf9-4f5c-884f-46da3cd3f80c', '2024-08-27 19:58:20.501476', '2024-08-27 19:58:20.501476', '9d66ac93-3a48-429d-aeaa-54302856e204', 'ddc2e877-7197-42fa-ae1e-59706d209774');
INSERT INTO public.exercise_examples_equipments VALUES ('c89b9ddc-1549-4d80-a57f-d856172457fe', '2024-08-27 20:02:25.708679', '2024-08-27 20:02:25.708679', '9d66ac93-3a48-429d-aeaa-54302856e204', '8324ae75-08e9-48de-a00b-55d229085712');
INSERT INTO public.exercise_examples_equipments VALUES ('40670a4f-b5e7-433e-8389-2ec8f1b7a989', '2024-08-27 20:04:23.492626', '2024-08-27 20:04:23.492626', 'b17ae8af-2d78-4e77-b45b-39253c28247a', 'bbfbcfe2-1f56-492e-afa6-75e595b84fde');
INSERT INTO public.exercise_examples_equipments VALUES ('09167929-b842-45c2-8f88-3807cac125be', '2024-08-27 20:09:12.665161', '2024-08-27 20:09:12.665161', '9d66ac93-3a48-429d-aeaa-54302856e204', '09386394-e4e1-4a6d-adce-d5f5a518485c');
INSERT INTO public.exercise_examples_equipments VALUES ('f98fce80-3602-436c-b8ef-2377e96e8ff1', '2024-08-27 20:09:12.665161', '2024-08-27 20:09:12.665161', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '09386394-e4e1-4a6d-adce-d5f5a518485c');
INSERT INTO public.exercise_examples_equipments VALUES ('32d62846-1c9f-4aa4-9187-2db8864bac0c', '2024-08-27 20:11:42.135236', '2024-08-27 20:11:42.135236', '9d66ac93-3a48-429d-aeaa-54302856e204', 'cfb2d83a-b3dc-44e9-ab08-53f9269752d6');
INSERT INTO public.exercise_examples_equipments VALUES ('d1778c89-8b8c-4250-951f-1bc07cd8ba74', '2024-08-27 20:11:42.135236', '2024-08-27 20:11:42.135236', '85dbccf6-454e-4440-8905-50a90d91dbcc', 'cfb2d83a-b3dc-44e9-ab08-53f9269752d6');
INSERT INTO public.exercise_examples_equipments VALUES ('626336cb-099c-4327-ae2a-8af1fd311592', '2024-08-27 20:13:52.521551', '2024-08-27 20:13:52.521551', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '2522a61a-2190-43e9-ae52-ca6bb023815e');
INSERT INTO public.exercise_examples_equipments VALUES ('0cd72b5b-7997-42ee-8352-c7bbac6d7ef6', '2024-08-27 20:13:52.521551', '2024-08-27 20:13:52.521551', '15495639-2adb-41b8-899c-493ac0172f57', '2522a61a-2190-43e9-ae52-ca6bb023815e');
INSERT INTO public.exercise_examples_equipments VALUES ('a8bdaf61-efd4-4969-94bc-e53ef45ff4e1', '2024-08-27 20:15:21.126869', '2024-08-27 20:15:21.126869', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '9fc5ae4d-2868-4576-bb67-9c83663fc005');
INSERT INTO public.exercise_examples_equipments VALUES ('42498a55-2fa1-4abc-943a-91ca3f049118', '2024-08-27 20:15:21.126869', '2024-08-27 20:15:21.126869', '061ad8e2-77aa-4ba8-9a41-51788e7803c7', '9fc5ae4d-2868-4576-bb67-9c83663fc005');
INSERT INTO public.exercise_examples_equipments VALUES ('caed2850-ef60-4ea3-adf3-8b6becc18356', '2024-08-27 20:17:28.427593', '2024-08-27 20:17:28.427593', '9d66ac93-3a48-429d-aeaa-54302856e204', '89f423d0-315f-4d93-b346-dcb468a97045');
INSERT INTO public.exercise_examples_equipments VALUES ('435c0462-ab6a-48bb-83ad-17280c97ad7f', '2024-08-27 20:20:16.532749', '2024-08-27 20:20:16.532749', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '194fa2ee-7f92-4982-903e-3db80293d773');
INSERT INTO public.exercise_examples_equipments VALUES ('6f4e4021-6766-4963-931c-3d3713bd57ce', '2024-08-27 20:20:16.532749', '2024-08-27 20:20:16.532749', '061ad8e2-77aa-4ba8-9a41-51788e7803c7', '194fa2ee-7f92-4982-903e-3db80293d773');
INSERT INTO public.exercise_examples_equipments VALUES ('cbce280d-286e-434a-86fd-e9341139d0c6', '2024-08-27 20:24:43.761365', '2024-08-27 20:24:43.761365', '9d66ac93-3a48-429d-aeaa-54302856e204', 'f2fb31f0-7f6b-42b6-9a79-c22453ac6a63');
INSERT INTO public.exercise_examples_equipments VALUES ('b4f00c95-f019-4e9c-ac6c-62c305550718', '2024-08-27 20:24:43.761365', '2024-08-27 20:24:43.761365', '85dbccf6-454e-4440-8905-50a90d91dbcc', 'f2fb31f0-7f6b-42b6-9a79-c22453ac6a63');
INSERT INTO public.exercise_examples_equipments VALUES ('c01dad93-88d8-424f-b87b-920bfd26194f', '2024-08-27 20:27:54.270257', '2024-08-27 20:27:54.270257', '9d66ac93-3a48-429d-aeaa-54302856e204', '5e3c933f-7511-463e-88b1-a139c8276e69');
INSERT INTO public.exercise_examples_equipments VALUES ('6c0ed978-3e4c-4a8f-bcdf-743eae8e1e8e', '2024-08-27 20:29:12.674065', '2024-08-27 20:29:12.674065', '9d66ac93-3a48-429d-aeaa-54302856e204', 'e7f390fd-7435-44e1-b354-c62073934c66');
INSERT INTO public.exercise_examples_equipments VALUES ('51ad2af3-e4ba-401d-a774-418630a8f725', '2024-08-28 20:36:41.160119', '2024-08-28 20:36:41.160119', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '7e0566c6-eefb-4992-a673-d19902933c26');
INSERT INTO public.exercise_examples_equipments VALUES ('71a2cdd4-6c01-4dde-acde-b63102f23727', '2024-08-28 20:36:41.160119', '2024-08-28 20:36:41.160119', 'af38ec0a-1465-45a8-99ba-a394224530dc', '7e0566c6-eefb-4992-a673-d19902933c26');
INSERT INTO public.exercise_examples_equipments VALUES ('742219cd-68b7-4125-b2f8-b084840f3fe5', '2024-08-28 20:38:26.235987', '2024-08-28 20:38:26.235987', '0d0f8242-be68-4086-b665-0a11ff6a0dcd', '7fd82f79-1f5f-4bae-8f2d-b94ecae595d5');
INSERT INTO public.exercise_examples_equipments VALUES ('28f116e4-d3ad-43f1-9a41-68721e7390bb', '2024-08-28 20:40:22.177236', '2024-08-28 20:40:22.177236', '9d66ac93-3a48-429d-aeaa-54302856e204', '908341ec-de1f-44bd-b84d-74ff8a7162a0');
INSERT INTO public.exercise_examples_equipments VALUES ('7fe61f2a-fa43-45ce-b5a4-6232e94ca7e7', '2024-08-28 20:42:25.596199', '2024-08-28 20:42:25.596199', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', 'a2736a56-04b3-4437-835e-1e2dc8029c9e');
INSERT INTO public.exercise_examples_equipments VALUES ('a2f639d5-a744-4b90-8a4e-ff82d1d85120', '2024-08-28 20:42:25.596199', '2024-08-28 20:42:25.596199', '061ad8e2-77aa-4ba8-9a41-51788e7803c7', 'a2736a56-04b3-4437-835e-1e2dc8029c9e');
INSERT INTO public.exercise_examples_equipments VALUES ('d721c23f-f0d8-4b71-bd8a-5352f76e3386', '2024-08-28 20:44:17.626931', '2024-08-28 20:44:17.626931', '9d66ac93-3a48-429d-aeaa-54302856e204', 'da809d98-950b-4ca0-a71b-c67d21fd66da');
INSERT INTO public.exercise_examples_equipments VALUES ('ee825b0f-bde3-4a9d-a09c-d5c852191aa6', '2024-08-28 20:44:17.626931', '2024-08-28 20:44:17.626931', '85dbccf6-454e-4440-8905-50a90d91dbcc', 'da809d98-950b-4ca0-a71b-c67d21fd66da');
INSERT INTO public.exercise_examples_equipments VALUES ('5ab6ca83-5ae3-4aa0-a814-be1dbc79fa26', '2024-08-28 20:45:27.526977', '2024-08-28 20:45:27.526977', '9d66ac93-3a48-429d-aeaa-54302856e204', '4de0744d-0a78-4052-aa1b-e5340959d9fe');
INSERT INTO public.exercise_examples_equipments VALUES ('a1f64ee7-9236-41e1-9112-e11077db7892', '2024-08-28 20:47:16.414029', '2024-08-28 20:47:16.414029', '9d66ac93-3a48-429d-aeaa-54302856e204', 'd7abed66-3c4a-490b-91cc-8e714336f9fa');
INSERT INTO public.exercise_examples_equipments VALUES ('d8654edb-8d03-45f1-8581-d946b232df09', '2024-08-28 20:47:16.414029', '2024-08-28 20:47:16.414029', '061ad8e2-77aa-4ba8-9a41-51788e7803c7', 'd7abed66-3c4a-490b-91cc-8e714336f9fa');
INSERT INTO public.exercise_examples_equipments VALUES ('3703bf88-1b47-425e-82f7-457aba871579', '2024-08-28 20:48:17.220792', '2024-08-28 20:48:17.220792', '9d66ac93-3a48-429d-aeaa-54302856e204', 'cfd086be-f452-4f1d-b0cc-3988d677a8b4');
INSERT INTO public.exercise_examples_equipments VALUES ('d925c831-38d4-4fc5-867f-c75a2e87d057', '2024-08-28 20:48:17.220792', '2024-08-28 20:48:17.220792', '061ad8e2-77aa-4ba8-9a41-51788e7803c7', 'cfd086be-f452-4f1d-b0cc-3988d677a8b4');
INSERT INTO public.exercise_examples_equipments VALUES ('da90a877-7897-431f-9189-604e28eb6eec', '2024-08-28 20:50:28.807559', '2024-08-28 20:50:28.807559', '9d66ac93-3a48-429d-aeaa-54302856e204', '8508cffc-1df6-4db2-9447-3bafd74a1325');
INSERT INTO public.exercise_examples_equipments VALUES ('6abbd704-6b0d-4d1c-9ea8-01b1446aa88d', '2024-08-28 20:50:28.807559', '2024-08-28 20:50:28.807559', '85dbccf6-454e-4440-8905-50a90d91dbcc', '8508cffc-1df6-4db2-9447-3bafd74a1325');
INSERT INTO public.exercise_examples_equipments VALUES ('ce5d2d10-6c3f-49dd-80d9-5e524a71adfb', '2024-08-28 20:51:35.466127', '2024-08-28 20:51:35.466127', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '4f1c3655-21e7-4225-a39e-944774f59f76');
INSERT INTO public.exercise_examples_equipments VALUES ('2ac37880-db07-447a-95a5-26f2132aac39', '2024-08-28 20:53:42.347893', '2024-08-28 20:53:42.347893', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '6d5dc164-3c35-4719-85f1-5c75558f0125');
INSERT INTO public.exercise_examples_equipments VALUES ('2d2ead25-67dc-44a2-8a23-98d577699335', '2024-08-28 20:53:42.347893', '2024-08-28 20:53:42.347893', '15495639-2adb-41b8-899c-493ac0172f57', '6d5dc164-3c35-4719-85f1-5c75558f0125');
INSERT INTO public.exercise_examples_equipments VALUES ('c6ddacaf-c3e1-4b95-9f77-89ca21c40d1b', '2024-08-28 20:55:59.983829', '2024-08-28 20:55:59.983829', '752ee7ba-ae88-46f0-95fb-e0a316212f16', 'cebf4622-c0a9-4759-a070-48c7556da67d');
INSERT INTO public.exercise_examples_equipments VALUES ('803c7970-45b1-49a7-8ead-092a88d77f0f', '2024-08-28 20:55:59.983829', '2024-08-28 20:55:59.983829', '15495639-2adb-41b8-899c-493ac0172f57', 'cebf4622-c0a9-4759-a070-48c7556da67d');
INSERT INTO public.exercise_examples_equipments VALUES ('509d67c8-9a10-44dd-b89f-5f642d11e423', '2024-08-28 20:59:16.619963', '2024-08-28 20:59:16.619963', '9d66ac93-3a48-429d-aeaa-54302856e204', '4d72c2f1-2c10-45a3-9f5e-1f04012c0681');
INSERT INTO public.exercise_examples_equipments VALUES ('ea1de13e-c07f-460b-8291-2c552c993ceb', '2024-08-28 20:59:16.619963', '2024-08-28 20:59:16.619963', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '4d72c2f1-2c10-45a3-9f5e-1f04012c0681');
INSERT INTO public.exercise_examples_equipments VALUES ('c839c5f1-2827-45f6-8e4d-3e3c0a1d01cf', '2024-08-28 21:00:57.798104', '2024-08-28 21:00:57.798104', '9d66ac93-3a48-429d-aeaa-54302856e204', 'af39600b-6fc5-435a-a5f8-a1d0a9994030');
INSERT INTO public.exercise_examples_equipments VALUES ('7d0a7413-8e8b-49ca-b1e4-55565c4f8085', '2024-08-28 21:00:57.798104', '2024-08-28 21:00:57.798104', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', 'af39600b-6fc5-435a-a5f8-a1d0a9994030');
INSERT INTO public.exercise_examples_equipments VALUES ('ad6cd9b9-23aa-4fcd-ab6b-629d7dc1578f', '2024-08-28 21:02:48.219979', '2024-08-28 21:02:48.219979', '9d66ac93-3a48-429d-aeaa-54302856e204', '101f365e-5c84-438a-84b4-c8e798bd0aff');
INSERT INTO public.exercise_examples_equipments VALUES ('23e62232-997b-45b6-bbdc-ec912214531b', '2024-08-28 21:02:48.219979', '2024-08-28 21:02:48.219979', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '101f365e-5c84-438a-84b4-c8e798bd0aff');
INSERT INTO public.exercise_examples_equipments VALUES ('0e3d31f7-f75c-4fac-9d86-c77b7098cd10', '2024-08-28 21:04:44.328641', '2024-08-28 21:04:44.328641', '9d66ac93-3a48-429d-aeaa-54302856e204', '1f28edb2-29ae-467c-ad11-310c3f656fe2');
INSERT INTO public.exercise_examples_equipments VALUES ('bcba2cc7-ab4a-4f1a-9759-57ac35ef4b8c', '2024-08-28 21:04:44.328641', '2024-08-28 21:04:44.328641', '85dbccf6-454e-4440-8905-50a90d91dbcc', '1f28edb2-29ae-467c-ad11-310c3f656fe2');
INSERT INTO public.exercise_examples_equipments VALUES ('c3a45345-3d3e-445d-9cc7-838f34452f2b', '2024-08-28 21:07:18.658519', '2024-08-28 21:07:18.658519', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '04a13a1c-de2b-46f4-be62-3fa6b4655d0d');
INSERT INTO public.exercise_examples_equipments VALUES ('47f07a62-9c4b-475a-9d26-e646f82e6e4f', '2024-08-28 21:07:18.658519', '2024-08-28 21:07:18.658519', '85dbccf6-454e-4440-8905-50a90d91dbcc', '04a13a1c-de2b-46f4-be62-3fa6b4655d0d');
INSERT INTO public.exercise_examples_equipments VALUES ('51805a34-b706-4493-a65d-f470397e7f5a', '2024-08-28 21:08:56.505989', '2024-08-28 21:08:56.505989', '752ee7ba-ae88-46f0-95fb-e0a316212f16', 'a9545ccb-3ec7-4646-95c9-f3a708d0d968');
INSERT INTO public.exercise_examples_equipments VALUES ('73574159-3fc4-413f-ae56-beb39d6e90a5', '2024-08-28 21:08:56.505989', '2024-08-28 21:08:56.505989', '331a0c35-f5a5-478d-ba7c-9f14ba2ee0fa', 'a9545ccb-3ec7-4646-95c9-f3a708d0d968');
INSERT INTO public.exercise_examples_equipments VALUES ('8cd074c5-a535-4b77-a2df-127416314513', '2024-08-28 21:11:35.048465', '2024-08-28 21:11:35.048465', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', 'b99df7e8-eb44-4be1-be81-701347580781');
INSERT INTO public.exercise_examples_equipments VALUES ('39f6d8eb-19c7-4fe7-973a-cb44d2ae153b', '2024-08-28 21:11:35.048465', '2024-08-28 21:11:35.048465', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', 'b99df7e8-eb44-4be1-be81-701347580781');
INSERT INTO public.exercise_examples_equipments VALUES ('4ff03dac-9429-45b7-990a-98f44b743764', '2024-08-28 21:12:39.517028', '2024-08-28 21:12:39.517028', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '8d2a9df4-af32-4943-b74b-ae901e866b32');
INSERT INTO public.exercise_examples_equipments VALUES ('e76166c7-4e73-4c1c-b2aa-f111389a9545', '2024-08-28 21:13:34.085593', '2024-08-28 21:13:34.085593', 'ad130932-4b2f-4e7b-b3a4-c20b4a6b85ae', '8ca7bf65-0ddb-4c64-ba64-f71f25c85d7c');
INSERT INTO public.exercise_examples_equipments VALUES ('16ea2d9b-2c74-4f90-8d9c-6861101331aa', '2024-08-29 15:15:51.74105', '2024-08-29 15:15:51.74105', '9d66ac93-3a48-429d-aeaa-54302856e204', '12221e5c-0208-48fc-8c56-62c266932f74');
INSERT INTO public.exercise_examples_equipments VALUES ('c8101224-bac1-4806-84b3-9dacd70412fa', '2024-08-29 15:18:06.552249', '2024-08-29 15:18:06.552249', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '1959abd3-4ab1-42d4-b7e2-45693b899d51');
INSERT INTO public.exercise_examples_equipments VALUES ('83e06a51-6b84-4f0b-b9a8-3a2d13e1288e', '2024-08-29 15:20:32.345462', '2024-08-29 15:20:32.345462', '9d66ac93-3a48-429d-aeaa-54302856e204', '48191b99-06fa-4218-b61b-c9b9abd73278');
INSERT INTO public.exercise_examples_equipments VALUES ('807dbb10-eb51-4e7d-ad22-5b44ac9a124a', '2024-08-29 15:20:32.345462', '2024-08-29 15:20:32.345462', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '48191b99-06fa-4218-b61b-c9b9abd73278');
INSERT INTO public.exercise_examples_equipments VALUES ('04f0ea3f-6d9a-49e4-9be3-68ca12c15e76', '2024-08-29 15:21:42.17181', '2024-08-29 15:21:42.17181', '9d66ac93-3a48-429d-aeaa-54302856e204', '92d77415-1f9a-430b-ba52-0a09ec07b3a1');
INSERT INTO public.exercise_examples_equipments VALUES ('edebb1f2-1fa5-419d-a3c0-32924c31c27d', '2024-08-29 15:23:10.34832', '2024-08-29 15:23:10.34832', '9d66ac93-3a48-429d-aeaa-54302856e204', '816440ad-f8f2-4ef7-a11f-b6a2bd63fcef');
INSERT INTO public.exercise_examples_equipments VALUES ('4e5220bc-a955-46f6-acf1-d8a3728219bc', '2024-08-29 15:24:22.345392', '2024-08-29 15:24:22.345392', '623e0be7-870a-4bca-b053-76e99c9ea7e0', '506d1cc7-529a-42af-b5bf-4c4d0a9aa409');
INSERT INTO public.exercise_examples_equipments VALUES ('dc57c652-3894-4e49-b37e-c826f461e309', '2024-08-29 15:24:22.345392', '2024-08-29 15:24:22.345392', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '506d1cc7-529a-42af-b5bf-4c4d0a9aa409');
INSERT INTO public.exercise_examples_equipments VALUES ('124a1851-bdeb-432a-bb2f-6ef4dffba346', '2024-08-29 15:26:45.193381', '2024-08-29 15:26:45.193381', '9d66ac93-3a48-429d-aeaa-54302856e204', '9ab8fe00-58de-48c4-942d-b10e8d16f1c1');
INSERT INTO public.exercise_examples_equipments VALUES ('26c840b4-3fa1-43fd-86b8-c45f5aeafd56', '2024-08-29 15:26:45.193381', '2024-08-29 15:26:45.193381', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '9ab8fe00-58de-48c4-942d-b10e8d16f1c1');
INSERT INTO public.exercise_examples_equipments VALUES ('a0f9048e-b208-43be-9fdc-fa7d8f847b2c', '2024-08-29 15:28:20.987723', '2024-08-29 15:28:20.987723', '9d66ac93-3a48-429d-aeaa-54302856e204', '3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4');
INSERT INTO public.exercise_examples_equipments VALUES ('2ea0be10-8a19-45fb-9790-6b7080eda7af', '2024-08-29 15:28:20.987723', '2024-08-29 15:28:20.987723', '85dbccf6-454e-4440-8905-50a90d91dbcc', '3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4');
INSERT INTO public.exercise_examples_equipments VALUES ('86bd6604-76d9-4e67-b8db-e22499270425', '2024-08-29 15:30:57.610887', '2024-08-29 15:30:57.610887', '9d66ac93-3a48-429d-aeaa-54302856e204', '77aa5752-a586-4dfe-b69d-4da16fff0b79');
INSERT INTO public.exercise_examples_equipments VALUES ('82a6ea43-4dd4-4a5b-b083-1c423977e9b4', '2024-08-29 15:30:57.610887', '2024-08-29 15:30:57.610887', '85dbccf6-454e-4440-8905-50a90d91dbcc', '77aa5752-a586-4dfe-b69d-4da16fff0b79');
INSERT INTO public.exercise_examples_equipments VALUES ('06e0fb66-fd04-42a4-83c5-68c3fea2a620', '2024-08-29 15:34:32.577527', '2024-08-29 15:34:32.577527', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '4035dfef-3cc6-4a15-a97f-c167bd274d02');
INSERT INTO public.exercise_examples_equipments VALUES ('3027b509-5f77-4ae5-998f-7757492ca6d8', '2024-08-29 15:34:32.577527', '2024-08-29 15:34:32.577527', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '4035dfef-3cc6-4a15-a97f-c167bd274d02');
INSERT INTO public.exercise_examples_equipments VALUES ('b577535e-0ce1-43e5-9b60-de4ec07c3078', '2024-08-29 20:14:43.148532', '2024-08-29 20:14:43.148532', '752ee7ba-ae88-46f0-95fb-e0a316212f16', 'aada0f37-1f30-4d61-a284-8003027bc871');
INSERT INTO public.exercise_examples_equipments VALUES ('d1ce8d63-ec75-4de0-9ee1-4fc7728f5e84', '2024-08-29 20:14:43.148532', '2024-08-29 20:14:43.148532', 'af38ec0a-1465-45a8-99ba-a394224530dc', 'aada0f37-1f30-4d61-a284-8003027bc871');
INSERT INTO public.exercise_examples_equipments VALUES ('2efb1622-d211-4150-be80-c3dd4037ce18', '2024-08-29 20:16:07.202411', '2024-08-29 20:16:07.202411', '752ee7ba-ae88-46f0-95fb-e0a316212f16', 'afd7f719-5789-48a0-a5d9-77e9cb1669bb');
INSERT INTO public.exercise_examples_equipments VALUES ('7bb99942-9023-470a-b175-9905edb19ad6', '2024-08-29 20:16:07.202411', '2024-08-29 20:16:07.202411', '373d04ea-8079-439a-82a3-d118da6253b1', 'afd7f719-5789-48a0-a5d9-77e9cb1669bb');
INSERT INTO public.exercise_examples_equipments VALUES ('bd152d98-e1c6-4139-af62-d47ec4c49be0', '2024-08-29 20:17:41.643146', '2024-08-29 20:17:41.643146', '6c587294-e384-4941-b90d-e6ec64b8731d', '16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9');
INSERT INTO public.exercise_examples_equipments VALUES ('252ce762-35c3-4e0c-a69f-b00ed415e607', '2024-08-29 20:18:52.142987', '2024-08-29 20:18:52.142987', '526347a3-ee32-473d-9b5d-049f526ae48e', '3a70ce9c-b1f0-43a7-8775-7d3e7c109c5d');
INSERT INTO public.exercise_examples_equipments VALUES ('d5cf5dfc-fbb9-4665-9e19-e23c98fbf5d1', '2024-08-29 20:20:58.542902', '2024-08-29 20:20:58.542902', 'a6628e7c-1488-4268-82ee-5174f3a5a2a5', '4353173b-93b2-4fb1-b462-fc8330b15ce5');
INSERT INTO public.exercise_examples_equipments VALUES ('dd7903c9-c39c-467c-b1e9-a09da60b3993', '2024-08-29 20:20:58.542902', '2024-08-29 20:20:58.542902', '373d04ea-8079-439a-82a3-d118da6253b1', '4353173b-93b2-4fb1-b462-fc8330b15ce5');
INSERT INTO public.exercise_examples_equipments VALUES ('1ae81a2e-bc2c-4b26-8265-6cbaae1ddbdd', '2024-08-29 20:26:45.608525', '2024-08-29 20:26:45.608525', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '1b8fe6fc-9ede-4f28-b4a0-30504db61fed');
INSERT INTO public.exercise_examples_equipments VALUES ('bca20113-bc6c-4f5d-a2de-ac2d2569b544', '2024-08-29 20:26:45.608525', '2024-08-29 20:26:45.608525', '331a0c35-f5a5-478d-ba7c-9f14ba2ee0fa', '1b8fe6fc-9ede-4f28-b4a0-30504db61fed');
INSERT INTO public.exercise_examples_equipments VALUES ('9a555a4d-cbf5-4162-a204-45ce474e98b9', '2024-08-29 20:28:36.098732', '2024-08-29 20:28:36.098732', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '90b8d661-a9ef-47e5-8c98-b0599874a972');
INSERT INTO public.exercise_examples_equipments VALUES ('f31fdd69-b646-4bd9-af1d-6c51063cb038', '2024-08-29 20:28:36.098732', '2024-08-29 20:28:36.098732', '6345b70f-6e3f-46e2-9d51-3be51250ed99', '90b8d661-a9ef-47e5-8c98-b0599874a972');
INSERT INTO public.exercise_examples_equipments VALUES ('0ba39240-7331-42e3-b240-cdd72a7f06eb', '2024-08-29 20:31:23.033752', '2024-08-29 20:31:23.033752', '9d66ac93-3a48-429d-aeaa-54302856e204', 'ac45c513-55f3-437f-a10f-ba3c0763a746');
INSERT INTO public.exercise_examples_equipments VALUES ('4239d23f-aa2d-47b5-b59b-63f90e49b0b3', '2024-08-29 20:34:53.754866', '2024-08-29 20:34:53.754866', '0268b0d7-f8e4-47ea-b9da-969427b43adf', '3a41edcb-2c19-4d06-9585-8fe745aba723');
INSERT INTO public.exercise_examples_equipments VALUES ('710586e7-bf4e-407f-82bb-60e5337a9a1f', '2024-08-29 20:37:21.068102', '2024-08-29 20:37:21.068102', '9d66ac93-3a48-429d-aeaa-54302856e204', 'b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1');
INSERT INTO public.exercise_examples_equipments VALUES ('1eadea08-5f24-48e8-b9e6-b97e88edba3f', '2024-08-29 20:37:21.068102', '2024-08-29 20:37:21.068102', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', 'b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1');
INSERT INTO public.exercise_examples_equipments VALUES ('4399522d-7aad-4eb3-afce-36f03020478c', '2024-08-29 20:46:11.394407', '2024-08-29 20:46:11.394407', 'a6628e7c-1488-4268-82ee-5174f3a5a2a5', 'ed5db0ac-4343-4e68-a884-d5f84e4020c1');
INSERT INTO public.exercise_examples_equipments VALUES ('f9d45502-5c8c-4963-a147-885233e3bf4c', '2024-08-29 20:46:11.394407', '2024-08-29 20:46:11.394407', '331a0c35-f5a5-478d-ba7c-9f14ba2ee0fa', 'ed5db0ac-4343-4e68-a884-d5f84e4020c1');
INSERT INTO public.exercise_examples_equipments VALUES ('f72e14a6-5683-4f7d-a0e6-e5012b4ca59c', '2024-08-29 20:48:13.159828', '2024-08-29 20:48:13.159828', '623e0be7-870a-4bca-b053-76e99c9ea7e0', 'd20646b6-efd1-49fc-8ffa-180461aea5ab');
INSERT INTO public.exercise_examples_equipments VALUES ('063c63b4-153c-4ddc-93ec-e5c28fac3095', '2024-08-29 20:49:40.184734', '2024-08-29 20:49:40.184734', 'b17ae8af-2d78-4e77-b45b-39253c28247a', '1f8abb63-8024-46ca-ac1e-2574a839eed6');
INSERT INTO public.exercise_examples_equipments VALUES ('0f3ebc8e-b4cd-447d-9799-5558e2b585c4', '2024-08-29 20:52:10.214663', '2024-08-29 20:52:10.214663', '9d66ac93-3a48-429d-aeaa-54302856e204', 'b22e5ada-86c1-4104-828b-b7e06a7f5d16');
INSERT INTO public.exercise_examples_equipments VALUES ('ef2cd1df-932f-41ec-b154-08d471d4ac36', '2024-08-29 20:52:10.214663', '2024-08-29 20:52:10.214663', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', 'b22e5ada-86c1-4104-828b-b7e06a7f5d16');
INSERT INTO public.exercise_examples_equipments VALUES ('6b3c6a02-ea89-4410-b7e5-9520f1b79e13', '2024-08-29 20:55:27.361136', '2024-08-29 20:55:27.361136', '752ee7ba-ae88-46f0-95fb-e0a316212f16', '7a933584-128c-4b82-8e5b-5e7312cadfdf');
INSERT INTO public.exercise_examples_equipments VALUES ('dbd25a48-bfb0-4845-9327-f6e455c7ba20', '2024-08-29 20:55:27.361136', '2024-08-29 20:55:27.361136', '331a0c35-f5a5-478d-ba7c-9f14ba2ee0fa', '7a933584-128c-4b82-8e5b-5e7312cadfdf');
INSERT INTO public.exercise_examples_equipments VALUES ('ef1abdcc-386b-42bb-865e-e36307434f47', '2024-08-29 20:58:25.076692', '2024-08-29 20:58:25.076692', '9d66ac93-3a48-429d-aeaa-54302856e204', '984e5dac-f3a8-4980-bfc9-da370cf45e46');
INSERT INTO public.exercise_examples_equipments VALUES ('3d2f7c53-f1c5-4303-9479-965d5be0ab8e', '2024-08-29 20:58:25.076692', '2024-08-29 20:58:25.076692', '6215cbaf-6065-4534-a9d5-a588c1b3dc28', '984e5dac-f3a8-4980-bfc9-da370cf45e46');
INSERT INTO public.exercise_examples_equipments VALUES ('125d4f99-0e82-40c1-ac09-6a354c5669a9', '2024-08-29 21:01:10.950406', '2024-08-29 21:01:10.950406', '752ee7ba-ae88-46f0-95fb-e0a316212f16', 'ff188494-a871-4721-9d1e-26742539080c');
INSERT INTO public.exercise_examples_equipments VALUES ('792c6603-c86f-4fe8-b9a6-e96cf74247c2', '2024-08-29 21:01:10.950406', '2024-08-29 21:01:10.950406', '15495639-2adb-41b8-899c-493ac0172f57', 'ff188494-a871-4721-9d1e-26742539080c');
INSERT INTO public.exercise_examples_equipments VALUES ('6a9ab4bb-d478-4077-8e89-6a205a5c3a7f', '2024-08-29 21:09:08.322752', '2024-08-29 21:09:08.322752', '9d66ac93-3a48-429d-aeaa-54302856e204', '68381c41-b015-4218-93cb-2bcb64bee255');


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
INSERT INTO public.exercise_examples_tutorials VALUES ('cab82808-aaa4-477b-b746-2a64f1d5465e', '2024-08-27 19:58:20.505585', 'ddc2e877-7197-42fa-ae1e-59706d209774', '2024-08-27 19:58:20.505585', 'Instruction', 'https://www.muscleandstrength.com/exercises/standing-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('0b79c08d-185f-4cba-be67-447c3d2bca6e', '2024-08-27 20:02:25.72501', '8324ae75-08e9-48de-a00b-55d229085712', '2024-08-27 20:02:25.72501', 'Instruction', 'https://www.muscleandstrength.com/exercises/standing-hammer-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('27a001b1-ea70-42f8-b15a-4109dc6390f1', '2024-08-27 20:04:23.501329', 'bbfbcfe2-1f56-492e-afa6-75e595b84fde', '2024-08-27 20:04:23.501329', 'Instruction', 'https://www.muscleandstrength.com/exercises/standing-barbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('b3567c80-fa31-4ded-ad30-4f2d93a58f94', '2024-08-27 20:09:12.671498', '09386394-e4e1-4a6d-adce-d5f5a518485c', '2024-08-27 20:09:12.671498', 'Instruction', 'https://www.muscleandstrength.com/exercises/incline-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('73eb4400-1ca8-43f4-a1a7-7a0f4d0c0987', '2024-08-27 20:11:42.146264', 'cfb2d83a-b3dc-44e9-ab08-53f9269752d6', '2024-08-27 20:11:42.146264', 'Instruction', 'https://www.muscleandstrength.com/exercises/concentration-cur.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('4a28cb49-a9ac-4984-956c-3a808ed9e100', '2024-08-27 20:13:52.5284', '2522a61a-2190-43e9-ae52-ca6bb023815e', '2024-08-27 20:13:52.5284', 'Instruction', 'https://www.muscleandstrength.com/exercises/cable-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('5a5fee97-12d2-49d3-a5c7-44d5c18d4e60', '2024-08-27 20:15:21.134177', '9fc5ae4d-2868-4576-bb67-9c83663fc005', '2024-08-27 20:15:21.134177', 'Instruction', 'https://www.muscleandstrength.com/exercises/ez-bar-preacher-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('438050ee-234c-4749-9973-2b1e1395c2a3', '2024-08-27 20:17:28.436328', '89f423d0-315f-4d93-b346-dcb468a97045', '2024-08-27 20:17:28.436328', 'Instruction', 'https://www.muscleandstrength.com/exercises/zottman-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('8032afa2-ecdc-40ce-b74a-b4b81833109b', '2024-08-27 20:20:16.539538', '194fa2ee-7f92-4982-903e-3db80293d773', '2024-08-27 20:20:16.539538', 'Instruction', 'https://www.muscleandstrength.com/exercises/preacher-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('b4556a80-c740-400f-9416-5d51e8bd1a7c', '2024-08-27 20:24:43.768139', 'f2fb31f0-7f6b-42b6-9a79-c22453ac6a63', '2024-08-27 20:24:43.768139', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternate-seated-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('1e463850-3679-4640-ac82-43b432cd4354', '2024-08-27 20:27:54.273105', '5e3c933f-7511-463e-88b1-a139c8276e69', '2024-08-27 20:27:54.273105', 'Instruction', 'https://www.muscleandstrength.com/exercises/hammer-curl-across-the-body.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('534c7357-af8c-4acc-9e8b-1957e1c7b391', '2024-08-27 20:29:12.679687', 'e7f390fd-7435-44e1-b354-c62073934c66', '2024-08-27 20:29:12.679687', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternating-standing-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('062d002b-2520-4509-b564-f42680c2f112', '2024-08-28 20:36:41.167373', '7e0566c6-eefb-4992-a673-d19902933c26', '2024-08-28 20:36:41.167373', 'Instruction', 'https://www.muscleandstrength.com/exercises/rope-cable-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('a2ed2a18-dbf3-4511-8375-bcd29ad5c5f1', '2024-08-28 20:38:26.243951', '7fd82f79-1f5f-4bae-8f2d-b94ecae595d5', '2024-08-28 20:38:26.243951', 'Instruction', 'https://www.muscleandstrength.com/exercises/bicep-machine-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('2813175a-73ce-4878-8688-855e6b96f45b', '2024-08-28 20:40:22.184956', '908341ec-de1f-44bd-b84d-74ff8a7162a0', '2024-08-28 20:40:22.184956', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternating-standing-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('93d89743-7f31-467e-9139-3a51287b90b8', '2024-08-28 20:42:25.599982', 'a2736a56-04b3-4437-835e-1e2dc8029c9e', '2024-08-28 20:42:25.599982', 'Instruction', 'https://www.muscleandstrength.com/exercises/spider-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('086c5202-03af-4ddd-b1b3-1489cd2f1092', '2024-08-28 20:44:17.631408', 'da809d98-950b-4ca0-a71b-c67d21fd66da', '2024-08-28 20:44:17.631408', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('54865527-573e-4886-b4fb-0423bb84a112', '2024-08-28 20:45:27.532554', '4de0744d-0a78-4052-aa1b-e5340959d9fe', '2024-08-28 20:45:27.532554', 'Instruction', 'https://www.muscleandstrength.com/exercises/standing-dumbbell-reverse-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('92eb9e05-1d0c-4c5c-b017-2173ebde679e', '2024-08-28 20:47:16.420991', 'd7abed66-3c4a-490b-91cc-8e714336f9fa', '2024-08-28 20:47:16.420991', 'Instruction', 'https://www.muscleandstrength.com/exercises/dumbbell-preacher-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('a0c4a3df-21f6-4b15-8e3f-f97a1a6988b4', '2024-08-28 20:48:17.224854', 'cfd086be-f452-4f1d-b0cc-3988d677a8b4', '2024-08-28 20:48:17.224854', 'Instruction', 'https://www.muscleandstrength.com/exercises/dumbbell-hammer-preacher-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('d91dab50-4010-4d77-a31f-426f9b6876e6', '2024-08-28 20:50:28.816209', '8508cffc-1df6-4db2-9447-3bafd74a1325', '2024-08-28 20:50:28.816209', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-hammer-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('88f8bd38-3aa9-4993-95b5-2c99a4513d6a', '2024-08-28 20:51:35.474625', '4f1c3655-21e7-4225-a39e-944774f59f76', '2024-08-28 20:51:35.474625', 'Instruction', 'https://www.muscleandstrength.com/exercises/wide-grip-standing-barbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('207c3f9e-7897-433b-a2d4-62c7babf9807', '2024-08-28 20:53:42.35421', '6d5dc164-3c35-4719-85f1-5c75558f0125', '2024-08-28 20:53:42.35421', 'Instruction', 'https://www.muscleandstrength.com/exercises/wide-grip-cable-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('3e1338c6-7035-4eff-9e35-e4c9fd2ec5c0', '2024-08-28 20:55:59.99147', 'cebf4622-c0a9-4759-a070-48c7556da67d', '2024-08-28 20:55:59.99147', 'Instruction', 'https://www.muscleandstrength.com/exercises/squatting-cable-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('7de9f083-5f63-414e-a55d-8d65fad04831', '2024-08-28 20:59:16.626936', '4d72c2f1-2c10-45a3-9f5e-1f04012c0681', '2024-08-28 20:59:16.626936', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternate-incline-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('d861e407-cd88-4a1a-a309-f4cb6d79efe6', '2024-08-28 21:00:57.80593', 'af39600b-6fc5-435a-a5f8-a1d0a9994030', '2024-08-28 21:00:57.80593', 'Instruction', 'https://www.muscleandstrength.com/exercises/incline-bench-dumbbell-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('566cfa52-4b88-4cf2-9d3e-97a49b5d6f90', '2024-08-28 21:02:48.226469', '101f365e-5c84-438a-84b4-c8e798bd0aff', '2024-08-28 21:02:48.226469', 'Instruction', 'https://www.muscleandstrength.com/exercises/incline-bench-hammer-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('b417033b-7404-41d7-8120-535014e906b0', '2024-08-28 21:04:44.332303', '1f28edb2-29ae-467c-ad11-310c3f656fe2', '2024-08-28 21:04:44.332303', 'Instruction', 'https://www.muscleandstrength.com/exercises/alternate-seated-hammer-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('b71af520-afaf-4129-8064-fab15b6fe00e', '2024-08-28 21:07:18.66717', '04a13a1c-de2b-46f4-be62-3fa6b4655d0d', '2024-08-28 21:07:18.66717', 'Instruction', 'https://www.muscleandstrength.com/exercises/barbell-concentration-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('2e8c2616-d762-47f4-b699-1e8b66d5ee22', '2024-08-28 21:08:56.511181', 'a9545ccb-3ec7-4646-95c9-f3a708d0d968', '2024-08-28 21:08:56.511181', 'Instruction', 'https://www.muscleandstrength.com/exercises/two-arm-cable-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('99a6d50e-24c8-4a9e-b1b2-d8f2095bc699', '2024-08-28 21:11:35.05554', 'b99df7e8-eb44-4be1-be81-701347580781', '2024-08-28 21:11:35.05554', 'Instruction', 'https://www.muscleandstrength.com/exercises/lying-barbell-curl-on-incline-bench.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('c724a5ad-bced-490b-8d84-3d21afce1e99', '2024-08-28 21:12:39.522477', '8d2a9df4-af32-4943-b74b-ae901e866b32', '2024-08-28 21:12:39.522477', 'Instruction', 'https://www.muscleandstrength.com/exercises/close-grip-ez-bar-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('8c5b611e-f0c3-44c6-b9e6-6f6f22f6fff3', '2024-08-28 21:13:34.093099', '8ca7bf65-0ddb-4c64-ba64-f71f25c85d7c', '2024-08-28 21:13:34.093099', 'Instruction', 'https://www.muscleandstrength.com/exercises/wide-grip-ez-bar-curl.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('700767d7-3653-4b86-8a5c-055c7e6b8939', '2024-08-29 15:15:51.748742', '12221e5c-0208-48fc-8c56-62c266932f74', '2024-08-29 15:15:51.748742', 'Instruction', 'https://www.muscleandstrength.com/exercises/dumbbell-lateral-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('bc2b63b6-6d93-4268-9ca2-5152fe9e18ce', '2024-08-29 15:18:06.560396', '1959abd3-4ab1-42d4-b7e2-45693b899d51', '2024-08-29 15:18:06.560396', 'Instruction', 'https://www.muscleandstrength.com/exercises/military-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('df44e89b-067c-4c6f-8e5a-2f89e5f4c147', '2024-08-29 15:20:32.35161', '48191b99-06fa-4218-b61b-c9b9abd73278', '2024-08-29 15:20:32.35161', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-dumbbell-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('37c26228-ad3a-4c15-aeeb-d1deaf8e2760', '2024-08-29 15:21:42.175515', '92d77415-1f9a-430b-ba52-0a09ec07b3a1', '2024-08-29 15:21:42.175515', 'Instruction', 'https://www.muscleandstrength.com/exercises/standing-dumbbell-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('eac64ab8-63b2-4f2f-a6e1-8d4c7d1efea9', '2024-08-29 15:23:10.354831', '816440ad-f8f2-4ef7-a11f-b6a2bd63fcef', '2024-08-29 15:23:10.354831', 'Instruction', 'https://www.muscleandstrength.com/exercises/bent-over-dumbbell-reverse-fly.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('4c396eb9-f737-4365-bbf1-827f44d17578', '2024-08-29 15:24:22.354872', '506d1cc7-529a-42af-b5bf-4c4d0a9aa409', '2024-08-29 15:24:22.354872', 'Instruction', 'https://www.muscleandstrength.com/exercises/smith-machine-shoulder-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('9e882e14-cf5d-452f-9c43-c9215088f6a6', '2024-08-29 15:26:45.200647', '9ab8fe00-58de-48c4-942d-b10e8d16f1c1', '2024-08-29 15:26:45.200647', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-arnold-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('cb933468-f577-4d7b-a522-5e75cad2e082', '2024-08-29 15:28:20.99358', '3d6e76b5-b409-4f5b-bba4-c22cb10cfbd4', '2024-08-29 15:28:20.99358', 'Instruction', 'https://www.muscleandstrength.com/exercises/dumbbell-reverse-fly.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('b4dbebd0-6e0f-4724-aee9-8ba920f32f7a', '2024-08-29 15:30:57.613763', '77aa5752-a586-4dfe-b69d-4da16fff0b79', '2024-08-29 15:30:57.613763', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-dumbbell-lateral-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('0c2553fb-24c1-4080-a0a1-de15b951afe5', '2024-08-29 15:34:32.581279', '4035dfef-3cc6-4a15-a97f-c167bd274d02', '2024-08-29 15:34:32.581279', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-shoulder-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('3d9b5f36-ebf9-411c-9993-d8631941805e', '2024-08-29 20:14:43.152232', 'aada0f37-1f30-4d61-a284-8003027bc871', '2024-08-29 20:14:43.152232', 'Instruction', 'https://www.muscleandstrength.com/exercises/cable-face-pull', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('33b3c57a-1d97-4deb-a378-0f90df0305dc', '2024-08-29 20:16:07.209522', 'afd7f719-5789-48a0-a5d9-77e9cb1669bb', '2024-08-29 20:16:07.209522', 'Instruction', 'https://www.muscleandstrength.com/exercises/standing-cable-flys.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('89209fa2-dc4a-436d-8f93-a7e758943ad4', '2024-08-29 20:17:41.647658', '16ba69dc-e99d-4a71-bbcb-0f3ce096a9d9', '2024-08-29 20:17:41.647658', 'Instruction', 'https://www.muscleandstrength.com/exercises/machine-shoulder-press', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('985789eb-ea87-4683-850c-fcc21ee8d30a', '2024-08-29 20:18:52.146299', '3a70ce9c-b1f0-43a7-8775-7d3e7c109c5d', '2024-08-29 20:18:52.146299', 'Instruction', 'https://www.muscleandstrength.com/exercises/machine-reverse-fly', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('361dfc42-797d-4bad-b031-c6ebaee7a250', '2024-08-29 20:20:58.546255', '4353173b-93b2-4fb1-b462-fc8330b15ce5', '2024-08-29 20:20:58.546255', 'Instruction', 'https://www.muscleandstrength.com/exercises/two-arm-cable-lateral-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('11886edc-a99d-42fe-92b5-af177e0871a0', '2024-08-29 20:26:45.613024', '1b8fe6fc-9ede-4f28-b4a0-30504db61fed', '2024-08-29 20:26:45.613024', 'Instruction', 'https://www.muscleandstrength.com/exercises/one-arm-cable-lateral-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('5e7f8f5d-66bb-4dfc-9439-edc59aca8e17', '2024-08-29 20:28:36.106864', '90b8d661-a9ef-47e5-8c98-b0599874a972', '2024-08-29 20:28:36.106864', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-barbell-press-behind-neck.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('35de8743-24f5-42ee-a9b0-9f683fa0dc93', '2024-08-29 20:31:23.040025', 'ac45c513-55f3-437f-a10f-ba3c0763a746', '2024-08-29 20:31:23.040025', 'Instruction', 'https://www.muscleandstrength.com/exercises/dumbbell-front-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('693d5eb9-4412-4074-94df-3ed7e2419213', '2024-08-29 20:34:53.760936', '3a41edcb-2c19-4d06-9585-8fe745aba723', '2024-08-29 20:34:53.760936', 'Instruction', 'https://www.muscleandstrength.com/exercises/machine-lateral-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('b8beb312-2939-4809-aec5-f09fad8057b4', '2024-08-29 20:37:21.073228', 'b8fa1238-0f58-4daa-ade8-0f8c6fa2d1b1', '2024-08-29 20:37:21.073228', 'Instruction', 'https://www.muscleandstrength.com/exercises/bent-over-rear-delt-fly-head-on-bench', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('f13b9116-341d-4508-bde6-f2cd2accc271', '2024-08-29 20:46:11.400277', 'ed5db0ac-4343-4e68-a884-d5f84e4020c1', '2024-08-29 20:46:11.400277', 'Instruction', 'https://www.muscleandstrength.com/exercises/bent-over-cable-rear-delt-fly', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('e7666271-2b3f-4f4b-9f1d-d066dc7904b6', '2024-08-29 20:48:13.1669', 'd20646b6-efd1-49fc-8ffa-180461aea5ab', '2024-08-29 20:48:13.1669', 'Instruction', 'https://www.muscleandstrength.com/exercises/smith-machine-upright-row.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('dd17b5b6-e6fc-4983-a3d7-b26353eaa8f7', '2024-08-29 20:49:40.190105', '1f8abb63-8024-46ca-ac1e-2574a839eed6', '2024-08-29 20:49:40.190105', 'Instruction', 'https://www.muscleandstrength.com/exercises/push-press', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('d87539f2-d946-4e2a-aad0-7d9d62d7d453', '2024-08-29 20:52:10.220788', 'b22e5ada-86c1-4104-828b-b7e06a7f5d16', '2024-08-29 20:52:10.220788', 'Instruction', 'https://www.muscleandstrength.com/exercises/seated-palms-in-dumbbell-press.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('13149a05-c177-4345-bfdb-f896a9afddbd', '2024-08-29 20:55:27.364256', '7a933584-128c-4b82-8e5b-5e7312cadfdf', '2024-08-29 20:55:27.364256', 'Instruction', 'https://www.muscleandstrength.com/exercises/one-arm-cable-front-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('a0a31a37-35a3-4131-9eb1-1eba4af6f12c', '2024-08-29 20:58:25.082319', '984e5dac-f3a8-4980-bfc9-da370cf45e46', '2024-08-29 20:58:25.082319', 'Instruction', 'https://www.muscleandstrength.com/exercises/dumbbell-reverse-fly-on-incline-bench.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('07d80744-6325-4258-9a9f-fd3b5efc98af', '2024-08-29 21:01:10.956917', 'ff188494-a871-4721-9d1e-26742539080c', '2024-08-29 21:01:10.956917', 'Instruction', 'https://www.muscleandstrength.com/exercises/cable-front-raise.html', 'en', NULL, 'video');
INSERT INTO public.exercise_examples_tutorials VALUES ('ed29c229-bac4-466a-b9e2-021040b2d112', '2024-08-29 21:09:08.329319', '68381c41-b015-4218-93cb-2bcb64bee255', '2024-08-29 21:09:08.329319', 'Instruction', 'https://www.muscleandstrength.com/exercises/one-arm-standing-dumbbell-front-raise.html', 'en', NULL, 'video');


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

