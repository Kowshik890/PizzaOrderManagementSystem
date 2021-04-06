PGDMP         8                y            baker    13.1    13.0 5    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    41259    baker    DATABASE     P   CREATE DATABASE baker WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE baker;
                ashiq    false            �            1255    41260    del_ingredient_detail(bigint)    FUNCTION     �   CREATE FUNCTION public.del_ingredient_detail(id bigint) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE ingredient_detail SET deleted=true WHERE id=$1;
$_$;
 7   DROP FUNCTION public.del_ingredient_detail(id bigint);
       public          ashiq    false            �            1255    41261    del_supplier(bigint)    FUNCTION     �   CREATE FUNCTION public.del_supplier(id bigint) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE supplier SET deleted=true WHERE id=$1;
$_$;
 .   DROP FUNCTION public.del_supplier(id bigint);
       public          ashiq    false            �            1255    41262     fetch_ingredient_detail(boolean)    FUNCTION     �  CREATE FUNCTION public.fetch_ingredient_detail(include_deleted boolean) RETURNS TABLE(id bigint, id_ingredient bigint, region character varying, id_supplier bigint, price double precision, quantity bigint, is_hidden boolean)
    LANGUAGE sql STABLE
    AS $$
SELECT id, id_ingredient, region, id_supplier, price, quantity, is_hidden FROM ingredient_detail WHERE include_deleted OR NOT deleted ORDER BY id;
$$;
 G   DROP FUNCTION public.fetch_ingredient_detail(include_deleted boolean);
       public          ashiq    false            �            1255    41263    fetch_ingredients(boolean)    FUNCTION     �   CREATE FUNCTION public.fetch_ingredients(include_deleted boolean) RETURNS TABLE(id bigint, name character varying)
    LANGUAGE sql STABLE
    AS $$
SELECT id, name FROM ingredient WHERE include_deleted OR NOT deleted ORDER BY id;
$$;
 A   DROP FUNCTION public.fetch_ingredients(include_deleted boolean);
       public          ashiq    false            �            1255    41264     fetch_order_ingredient_details()    FUNCTION       CREATE FUNCTION public.fetch_order_ingredient_details() RETURNS TABLE(id bigint, id_order bigint, id_ingredient_detail bigint, quantity bigint, price double precision)
    LANGUAGE sql STABLE
    AS $$
SELECT * FROM order_ingredient_detail ORDER BY id;
$$;
 7   DROP FUNCTION public.fetch_order_ingredient_details();
       public          ashiq    false            �            1255    41265    fetch_orders(boolean)    FUNCTION     $  CREATE FUNCTION public.fetch_orders(include_deleted boolean) RETURNS TABLE(id bigint, datetime date, id_pizza bigint, pizza_price double precision)
    LANGUAGE sql STABLE
    AS $$
SELECT id, datetime, id_pizza, pizza_price FROM "order" WHERE include_deleted OR NOT deleted ORDER BY id;
$$;
 <   DROP FUNCTION public.fetch_orders(include_deleted boolean);
       public          ashiq    false            �            1255    41266    fetch_pizzas()    FUNCTION     �   CREATE FUNCTION public.fetch_pizzas() RETURNS TABLE(id bigint, size bigint, price double precision)
    LANGUAGE sql STABLE
    AS $$
SELECT id, size, price FROM pizza;
$$;
 %   DROP FUNCTION public.fetch_pizzas();
       public          ashiq    false            �            1255    41267    fetch_supplier_by_id(bigint)    FUNCTION       CREATE FUNCTION public.fetch_supplier_by_id(supplierid bigint) RETURNS TABLE(id bigint, name character varying, ingredients character varying, is_hidden boolean)
    LANGUAGE sql STABLE
    AS $$
SELECT id, name, ingredients, is_hidden FROM supplier WHERE id = supplierId;
$$;
 >   DROP FUNCTION public.fetch_supplier_by_id(supplierid bigint);
       public          ashiq    false            �            1255    41268    fetch_suppliers(boolean)    FUNCTION     1  CREATE FUNCTION public.fetch_suppliers(include_deleted boolean) RETURNS TABLE(id bigint, name character varying, ingredients character varying, is_hidden boolean)
    LANGUAGE sql STABLE
    AS $$
SELECT id, name, ingredients, is_hidden FROM supplier WHERE include_deleted OR NOT deleted ORDER BY id;
$$;
 ?   DROP FUNCTION public.fetch_suppliers(include_deleted boolean);
       public          ashiq    false            �            1255    41269 !   ins_ingredient(character varying)    FUNCTION     �   CREATE FUNCTION public.ins_ingredient(name character varying) RETURNS bigint
    LANGUAGE sql
    AS $_$
INSERT INTO ingredient(name, deleted) VALUES ($1, false)
RETURNING id;
$_$;
 =   DROP FUNCTION public.ins_ingredient(name character varying);
       public          ashiq    false            �            1255    41270 [   ins_ingredient_detail(bigint, character varying, bigint, double precision, bigint, boolean)    FUNCTION     y  CREATE FUNCTION public.ins_ingredient_detail(id_ingredient bigint, region character varying, id_supplier bigint, price double precision, quantity bigint, is_hidden boolean) RETURNS bigint
    LANGUAGE sql
    AS $_$
INSERT INTO ingredient_detail(id_ingredient, region, id_supplier, price, quantity, is_hidden, deleted) VALUES ($1, $2, $3, $4, $5, $6, false)
RETURNING id;
$_$;
 �   DROP FUNCTION public.ins_ingredient_detail(id_ingredient bigint, region character varying, id_supplier bigint, price double precision, quantity bigint, is_hidden boolean);
       public          ashiq    false            �            1255    41271 )   ins_order(date, bigint, double precision)    FUNCTION     �   CREATE FUNCTION public.ins_order(datetime date, id_pizza bigint, pizza_price double precision) RETURNS bigint
    LANGUAGE sql
    AS $_$
INSERT INTO "order"(datetime, id_pizza, pizza_price, deleted) VALUES ($1, $2, $3, false)
RETURNING id;
$_$;
 ^   DROP FUNCTION public.ins_order(datetime date, id_pizza bigint, pizza_price double precision);
       public          ashiq    false            �            1255    41272 E   ins_order_ingredient_detail(bigint, bigint, bigint, double precision)    FUNCTION     5  CREATE FUNCTION public.ins_order_ingredient_detail(id_order bigint, id_ingredient_detail bigint, quantity bigint, price double precision) RETURNS bigint
    LANGUAGE sql
    AS $_$
INSERT INTO order_ingredient_detail(id_order, id_ingredient_detail, quantity, price) VALUES ($1, $2, $3, $4)
RETURNING id;
$_$;
 �   DROP FUNCTION public.ins_order_ingredient_detail(id_order bigint, id_ingredient_detail bigint, quantity bigint, price double precision);
       public          ashiq    false            �            1255    41273 ;   ins_supplier(character varying, character varying, boolean)    FUNCTION       CREATE FUNCTION public.ins_supplier(name character varying, ingredients character varying, is_hidden boolean) RETURNS bigint
    LANGUAGE sql
    AS $_$INSERT INTO supplier(name, ingredients, is_hidden, deleted) VALUES ($1, $2, $3, false)
RETURNING id;
$_$;
 m   DROP FUNCTION public.ins_supplier(name character varying, ingredients character varying, is_hidden boolean);
       public          ashiq    false            �            1255    41274 )   restock_ingredient_detail(bigint, bigint)    FUNCTION     �   CREATE FUNCTION public.restock_ingredient_detail(id bigint, qt bigint) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE ingredient_detail SET quantity=(quantity + $2) WHERE id=$1;
$_$;
 F   DROP FUNCTION public.restock_ingredient_detail(id bigint, qt bigint);
       public          ashiq    false            �            1255    41275 )   upd_ingredient(bigint, character varying)    FUNCTION     �   CREATE FUNCTION public.upd_ingredient(id bigint, name character varying) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE ingredient SET name=$2 WHERE id=$1;
$_$;
 H   DROP FUNCTION public.upd_ingredient(id bigint, name character varying);
       public          ashiq    false            �            1255    41276 B   upd_ingredient_detail(bigint, character varying, double precision)    FUNCTION     �   CREATE FUNCTION public.upd_ingredient_detail(id bigint, region character varying, price double precision) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE ingredient_detail SET region=$2, price=$3 WHERE id=$1;
$_$;
 i   DROP FUNCTION public.upd_ingredient_detail(id bigint, region character varying, price double precision);
       public          ashiq    false            �            1255    41277 (   upd_ingredient_detail_visibility(bigint)    FUNCTION     �   CREATE FUNCTION public.upd_ingredient_detail_visibility(id bigint) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE ingredient_detail SET is_hidden=(not is_hidden) WHERE id=$1;
$_$;
 B   DROP FUNCTION public.upd_ingredient_detail_visibility(id bigint);
       public          ashiq    false            �            1255    41278 C   upd_supplier(bigint, character varying, character varying, boolean)    FUNCTION     �   CREATE FUNCTION public.upd_supplier(id bigint, name character varying, ingredients character varying, is_hidden boolean) RETURNS void
    LANGUAGE sql
    AS $_$
UPDATE supplier SET name=$2, ingredients=$3, is_hidden=$4 WHERE id=$1;
$_$;
 x   DROP FUNCTION public.upd_supplier(id bigint, name character varying, ingredients character varying, is_hidden boolean);
       public          ashiq    false            �            1259    41279 
   ingredient    TABLE     ~   CREATE TABLE public.ingredient (
    id bigint NOT NULL,
    name character varying NOT NULL,
    deleted boolean NOT NULL
);
    DROP TABLE public.ingredient;
       public         heap    ashiq    false            �            1259    41285    ingredient_detail    TABLE     .  CREATE TABLE public.ingredient_detail (
    id bigint NOT NULL,
    id_ingredient bigint NOT NULL,
    region character varying NOT NULL,
    id_supplier bigint NOT NULL,
    price double precision NOT NULL,
    quantity bigint NOT NULL,
    is_hidden boolean NOT NULL,
    deleted boolean NOT NULL
);
 %   DROP TABLE public.ingredient_detail;
       public         heap    ashiq    false            �            1259    41291    ingredient_detail_id_seq    SEQUENCE     �   ALTER TABLE public.ingredient_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ingredient_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          ashiq    false    201            �            1259    41293    ingredient_id_seq    SEQUENCE     �   ALTER TABLE public.ingredient ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          ashiq    false    200            �            1259    41295    order    TABLE     �   CREATE TABLE public."order" (
    id bigint NOT NULL,
    datetime date NOT NULL,
    id_pizza bigint NOT NULL,
    pizza_price double precision NOT NULL,
    deleted boolean NOT NULL
);
    DROP TABLE public."order";
       public         heap    ashiq    false            �            1259    41298    order_id_seq    SEQUENCE     �   ALTER TABLE public."order" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          ashiq    false    204            �            1259    41300    order_ingredient_detail    TABLE     �   CREATE TABLE public.order_ingredient_detail (
    id bigint NOT NULL,
    id_order bigint NOT NULL,
    id_ingredient_detail bigint NOT NULL,
    quantity bigint NOT NULL,
    price double precision NOT NULL
);
 +   DROP TABLE public.order_ingredient_detail;
       public         heap    ashiq    false            �            1259    41303    order_ingredient_detail_id_seq    SEQUENCE     �   ALTER TABLE public.order_ingredient_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_ingredient_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          ashiq    false    206            �            1259    41305    pizza    TABLE     u   CREATE TABLE public.pizza (
    id bigint NOT NULL,
    size bigint NOT NULL,
    price double precision NOT NULL
);
    DROP TABLE public.pizza;
       public         heap    ashiq    false            �            1259    41308    pizza_id_seq    SEQUENCE     �   ALTER TABLE public.pizza ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pizza_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          ashiq    false    208            �            1259    41310    supplier    TABLE     �   CREATE TABLE public.supplier (
    id bigint NOT NULL,
    name character varying NOT NULL,
    ingredients character varying NOT NULL,
    is_hidden boolean NOT NULL,
    deleted boolean NOT NULL
);
    DROP TABLE public.supplier;
       public         heap    ashiq    false            �            1259    41316    supplier_id_seq    SEQUENCE     �   ALTER TABLE public.supplier ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          ashiq    false    210            �          0    41279 
   ingredient 
   TABLE DATA           7   COPY public.ingredient (id, name, deleted) FROM stdin;
    public          ashiq    false    200   jI       �          0    41285    ingredient_detail 
   TABLE DATA           x   COPY public.ingredient_detail (id, id_ingredient, region, id_supplier, price, quantity, is_hidden, deleted) FROM stdin;
    public          ashiq    false    201   �I       �          0    41295    order 
   TABLE DATA           O   COPY public."order" (id, datetime, id_pizza, pizza_price, deleted) FROM stdin;
    public          ashiq    false    204   SJ       �          0    41300    order_ingredient_detail 
   TABLE DATA           f   COPY public.order_ingredient_detail (id, id_order, id_ingredient_detail, quantity, price) FROM stdin;
    public          ashiq    false    206   �J       �          0    41305    pizza 
   TABLE DATA           0   COPY public.pizza (id, size, price) FROM stdin;
    public          ashiq    false    208   K       �          0    41310    supplier 
   TABLE DATA           M   COPY public.supplier (id, name, ingredients, is_hidden, deleted) FROM stdin;
    public          ashiq    false    210   ?K       �           0    0    ingredient_detail_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ingredient_detail_id_seq', 40, true);
          public          ashiq    false    202                        0    0    ingredient_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.ingredient_id_seq', 22, true);
          public          ashiq    false    203                       0    0    order_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.order_id_seq', 24, true);
          public          ashiq    false    205                       0    0    order_ingredient_detail_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.order_ingredient_detail_id_seq', 45, true);
          public          ashiq    false    207                       0    0    pizza_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.pizza_id_seq', 3, true);
          public          ashiq    false    209                       0    0    supplier_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.supplier_id_seq', 22, true);
          public          ashiq    false    211            b           2606    41319 (   ingredient_detail ingredient_detail_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ingredient_detail
    ADD CONSTRAINT ingredient_detail_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.ingredient_detail DROP CONSTRAINT ingredient_detail_pkey;
       public            ashiq    false    201            `           2606    41321    ingredient ingredient_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.ingredient DROP CONSTRAINT ingredient_pkey;
       public            ashiq    false    200            f           2606    41323 4   order_ingredient_detail order_ingredient_detail_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.order_ingredient_detail
    ADD CONSTRAINT order_ingredient_detail_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.order_ingredient_detail DROP CONSTRAINT order_ingredient_detail_pkey;
       public            ashiq    false    206            d           2606    41325    order order_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public            ashiq    false    204            h           2606    41327    pizza pizza_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pizza
    ADD CONSTRAINT pizza_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pizza DROP CONSTRAINT pizza_pkey;
       public            ashiq    false    208            j           2606    41329    supplier supplier_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_pkey;
       public            ashiq    false    210            �   B   x�34�������L�2��N�I����9���Լ|ς�9#5�8�62@�22Db!���qqq f��      �   �   x�5���0D��Pa'Mҵ,�,EJ�RU$��qju���{>�����*_p��������0��r�!M������<�ֵ����8=�\��W��S��U�6%ÛЫ^�*`�h�������V���D�(�      �   1   x�32�4202�50�54�4�4�L�22F3�4�� �s� �b���� `{
l      �   i   x�M���0�35L��f��?GI	z��,�J�7�H��	_/��B-i�?R
~	��X�.D<��0Rp߭���b���1��< �*����Ν�=��^�5      �   "   x�3�44�4�2�42�4�2�41�4����� .�]      �   �   x�M���0E�ӯ�4F�ϥ� �ѭ�Z��X:���B5q9�s��M6pԕ��AP\�&58��!7����-	!p�z;S�7���B��Ղ讀n�,Y�A�Z[�� x��'Z.���d7h��(,���я.��0��4��}��MOԆ���"�����b������FZ,T��}�� ߴQ�     