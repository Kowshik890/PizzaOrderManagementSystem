PGDMP         '                 y            Pizza    9.6.20    9.6.20 /    }           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ~           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16450    Pizza    DATABASE     �   CREATE DATABASE "Pizza" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Pizza";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    16451 t   add_ingredient(character varying, character varying, double precision, double precision, character varying, boolean)    FUNCTION     �  CREATE FUNCTION public.add_ingredient(name character varying, province character varying, price double precision, quantity double precision, supplier character varying, is_hidden boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN 

INSERT INTO ingredient(name, province, price, quantity, supplier, is_hidden) VALUES (name, province, price, quantity, supplier, is_hidden);

return 'success';

END;
$$;
 �   DROP FUNCTION public.add_ingredient(name character varying, province character varying, price double precision, quantity double precision, supplier character varying, is_hidden boolean);
       public       postgres    false    1    3            �            1255    16452 $   add_pizza(integer, double precision)    FUNCTION     �   CREATE FUNCTION public.add_pizza(size integer, price double precision) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO public."pizza"(
	 size, price)
	VALUES (size, price);
return 'New pizza added successfully!';	
	
END;
$$;
 F   DROP FUNCTION public.add_pizza(size integer, price double precision);
       public       postgres    false    3    1            �            1255    16504 (   add_supplier(character varying, boolean)    FUNCTION       CREATE FUNCTION public.add_supplier(name character varying, is_hidden boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO public."supplier"(
	 name, is_hidden)
	VALUES (name,is_hidden);
return 'New supplier added successfully!';
END;
$$;
 N   DROP FUNCTION public.add_supplier(name character varying, is_hidden boolean);
       public       postgres    false    3    1            �            1255    16454    delete_ingredient(integer)    FUNCTION     �   CREATE FUNCTION public.delete_ingredient(ing_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
  DELETE
  FROM
  ingredient
  WHERE ingredient.id = ing_id;
  RETURN 'Ingredient removed successfully!';
END;
$$;
 8   DROP FUNCTION public.delete_ingredient(ing_id integer);
       public       postgres    false    1    3            �            1255    16455    delete_supplier(integer)    FUNCTION     �   CREATE FUNCTION public.delete_supplier(sid integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
  DELETE
  FROM
  supplier
  WHERE supplier.id = sid;
  RETURN 'Supplier removed successfully!';
END;
$$;
 3   DROP FUNCTION public.delete_supplier(sid integer);
       public       postgres    false    3    1            �            1255    16456    fetch_all_ingredient()    FUNCTION     7  CREATE FUNCTION public.fetch_all_ingredient() RETURNS TABLE(id integer, name character varying, province character varying, price double precision, quantity double precision, supplier character varying, is_hidden boolean)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from ingredient;
end;
$$;
 -   DROP FUNCTION public.fetch_all_ingredient();
       public       postgres    false    1    3            �            1255    16457    fetch_all_pizza()    FUNCTION     �   CREATE FUNCTION public.fetch_all_pizza() RETURNS TABLE(id integer, size integer, price double precision)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from pizza;
end;
$$;
 (   DROP FUNCTION public.fetch_all_pizza();
       public       postgres    false    1    3            �            1255    16458    fetch_all_supplier()    FUNCTION     �   CREATE FUNCTION public.fetch_all_supplier() RETURNS TABLE(id integer, name character varying, is_hidden boolean)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from supplier;
end;
$$;
 +   DROP FUNCTION public.fetch_all_supplier();
       public       postgres    false    3    1            �            1255    16459    fetch_available_ingredient()    FUNCTION     |  CREATE FUNCTION public.fetch_available_ingredient() RETURNS TABLE(id integer, name character varying, province character varying, price double precision, quantity double precision, supplier character varying, is_hidden boolean)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from ingredient where ingredient.quantity > 0 AND ingredient.is_hidden = false;
end;
$$;
 3   DROP FUNCTION public.fetch_available_ingredient();
       public       postgres    false    3    1            �            1255    16460    fetch_available_supplier()    FUNCTION     �   CREATE FUNCTION public.fetch_available_supplier() RETURNS TABLE(id integer, name character varying, is_hidden boolean)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from supplier where supplier.is_hidden = false;
end;
$$;
 1   DROP FUNCTION public.fetch_available_supplier();
       public       postgres    false    1    3            �            1255    16461    fetch_ingredient(integer)    FUNCTION     ^  CREATE FUNCTION public.fetch_ingredient(ing_id integer) RETURNS TABLE(id integer, name character varying, province character varying, price double precision, quantity double precision, supplier character varying, is_hidden boolean)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from ingredient where ingredient.id = ing_id;
end;
$$;
 7   DROP FUNCTION public.fetch_ingredient(ing_id integer);
       public       postgres    false    1    3            �            1255    16509    fetch_supplier(integer)    FUNCTION     �   CREATE FUNCTION public.fetch_supplier(sid integer) RETURNS TABLE(id integer, name character varying, is_hidden boolean)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select * from supplier where supplier.id = sid;
end;
$$;
 2   DROP FUNCTION public.fetch_supplier(sid integer);
       public       postgres    false    1    3            �            1255    16462 �   update_ingredient(integer, character varying, character varying, double precision, double precision, character varying, boolean)    FUNCTION        CREATE FUNCTION public.update_ingredient(ing_id integer, ing_name character varying, ing_province character varying, ing_price double precision, ing_quantity double precision, ing_supplier character varying, ing_is_hidden boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN	
  UPDATE ingredient
  SET name = ing_name, province = ing_province, price = ing_price, quantity = ing_quantity, supplier = ing_supplier, is_hidden = ing_is_hidden
  WHERE ingredient.id = ing_id;
  RETURN 'Ingredient updated successfully!';
END;
$$;
 �   DROP FUNCTION public.update_ingredient(ing_id integer, ing_name character varying, ing_province character varying, ing_price double precision, ing_quantity double precision, ing_supplier character varying, ing_is_hidden boolean);
       public       postgres    false    3    1            �            1255    16463 4   update_supplier(integer, character varying, boolean)    FUNCTION     =  CREATE FUNCTION public.update_supplier(sup_id integer, sup_name character varying, sup_ishidden boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN	
  UPDATE supplier
  SET name = sup_name, is_hidden = sup_ishidden
  WHERE supplier.id = sup_id;
  RETURN 'Supplier updated successfully!';
END;
$$;
 h   DROP FUNCTION public.update_supplier(sup_id integer, sup_name character varying, sup_ishidden boolean);
       public       postgres    false    3    1            �            1259    16464 
   ingredient    TABLE        CREATE TABLE public.ingredient (
    id integer NOT NULL,
    name character varying NOT NULL,
    province character varying NOT NULL,
    price double precision NOT NULL,
    quantity double precision NOT NULL,
    supplier character varying NOT NULL,
    is_hidden boolean NOT NULL
);
    DROP TABLE public.ingredient;
       public         postgres    false    3            �            1259    16470    ingredient_id_seq    SEQUENCE     z   CREATE SEQUENCE public.ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.ingredient_id_seq;
       public       postgres    false    185    3            �           0    0    ingredient_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;
            public       postgres    false    186            �            1259    16472    order     TABLE        CREATE TABLE public."order " (
    id integer NOT NULL,
    pizza_size integer NOT NULL,
    ing_id character varying NOT NULL,
    quantity integer NOT NULL,
    pizza_price double precision NOT NULL,
    ing_price double precision NOT NULL,
    total_price double precision NOT NULL
);
    DROP TABLE public."order ";
       public         postgres    false    3            �            1259    16478    pizza    TABLE     w   CREATE TABLE public.pizza (
    id integer NOT NULL,
    size integer NOT NULL,
    price double precision NOT NULL
);
    DROP TABLE public.pizza;
       public         postgres    false    3            �            1259    16481    pizza_id_seq    SEQUENCE     u   CREATE SEQUENCE public.pizza_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.pizza_id_seq;
       public       postgres    false    3    188            �           0    0    pizza_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.pizza_id_seq OWNED BY public.pizza.id;
            public       postgres    false    189            �            1259    16483    supplier    TABLE        CREATE TABLE public.supplier (
    id integer NOT NULL,
    name character varying NOT NULL,
    is_hidden boolean NOT NULL
);
    DROP TABLE public.supplier;
       public         postgres    false    3            �            1259    16489    supplier_id_seq    SEQUENCE     x   CREATE SEQUENCE public.supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.supplier_id_seq;
       public       postgres    false    190    3            �           0    0    supplier_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.supplier_id_seq OWNED BY public.supplier.id;
            public       postgres    false    191            �           2604    16491    ingredient id    DEFAULT     n   ALTER TABLE ONLY public.ingredient ALTER COLUMN id SET DEFAULT nextval('public.ingredient_id_seq'::regclass);
 <   ALTER TABLE public.ingredient ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    186    185            �           2604    16492    pizza id    DEFAULT     d   ALTER TABLE ONLY public.pizza ALTER COLUMN id SET DEFAULT nextval('public.pizza_id_seq'::regclass);
 7   ALTER TABLE public.pizza ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    189    188            �           2604    16493    supplier id    DEFAULT     j   ALTER TABLE ONLY public.supplier ALTER COLUMN id SET DEFAULT nextval('public.supplier_id_seq'::regclass);
 :   ALTER TABLE public.supplier ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    191    190            t          0    16464 
   ingredient 
   TABLE DATA               ^   COPY public.ingredient (id, name, province, price, quantity, supplier, is_hidden) FROM stdin;
    public       postgres    false    185   i?       �           0    0    ingredient_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.ingredient_id_seq', 19, true);
            public       postgres    false    186            v          0    16472    order  
   TABLE DATA               i   COPY public."order " (id, pizza_size, ing_id, quantity, pizza_price, ing_price, total_price) FROM stdin;
    public       postgres    false    187    @       w          0    16478    pizza 
   TABLE DATA               0   COPY public.pizza (id, size, price) FROM stdin;
    public       postgres    false    188   @       �           0    0    pizza_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.pizza_id_seq', 13, true);
            public       postgres    false    189            y          0    16483    supplier 
   TABLE DATA               7   COPY public.supplier (id, name, is_hidden) FROM stdin;
    public       postgres    false    190   n@       �           0    0    supplier_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.supplier_id_seq', 24, true);
            public       postgres    false    191            �           2606    16495    ingredient ingredient_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.ingredient DROP CONSTRAINT ingredient_pkey;
       public         postgres    false    185    185            �           2606    16497    order  order _pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."order "
    ADD CONSTRAINT "order _pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."order " DROP CONSTRAINT "order _pkey";
       public         postgres    false    187    187            �           2606    16499    pizza pizza_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pizza
    ADD CONSTRAINT pizza_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pizza DROP CONSTRAINT pizza_pkey;
       public         postgres    false    188    188            �           2606    16501    supplier supplier_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_pkey;
       public         postgres    false    190    190            �           2606    16503    ingredient unique_ingredient 
   CONSTRAINT     r   ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT unique_ingredient UNIQUE (name, province, price, quantity);
 F   ALTER TABLE ONLY public.ingredient DROP CONSTRAINT unique_ingredient;
       public         postgres    false    185    185    185    185    185            t   �   x�UMA� ;��T4ۡ���~a�L!M	��~�Н�X�e�΂Zr-�E0�c��.��O͸���뻽b����?�?4j�m�	,,����m�1F�\��6�*��`�
+�X�~�ԡ�1��s���.j      v      x������ � �      w   A   x�U���0B�0���K���4� ��Bȉ��.%��p����L5�NAϟ�r�o�7H~���      y   K   x�34�LJJ�L�24�1,`K(�Ȁ3@,C�┤bˈ311�0���//���,�22�32�RA�b���� ���     