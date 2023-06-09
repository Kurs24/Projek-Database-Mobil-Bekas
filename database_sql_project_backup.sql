PGDMP     5    ,                {            proyek_jual_mobil_bekas    15.2    15.2 "    /           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            0           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            1           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            2           1262    17398    proyek_jual_mobil_bekas    DATABASE     �   CREATE DATABASE proyek_jual_mobil_bekas WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
 '   DROP DATABASE proyek_jual_mobil_bekas;
                postgres    false            �            1255    17694 *   heversine_distance(real, real, real, real)    FUNCTION     2  CREATE FUNCTION public.heversine_distance(latitude1 real, latitude2 real, longitude1 real, longitude2 real) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
	lon1 float := radians(longitude1);
	lon2 float := radians(longitude2);
	lat1 float := radians(latitude1);
	lat2 float := radians(latitude2);
	
	dlon float := lon2 - lon1;
	dlat float := lat2 - lat1;
	a float;
	c float;
	r float := 6371;
	jarak float;
	
	BEGIN
	a := sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
	c := 2 * asin(sqrt(a));
	jarak := r * c;
	
	RETURN jarak;
END;
$$;
 k   DROP FUNCTION public.heversine_distance(latitude1 real, latitude2 real, longitude1 real, longitude2 real);
       public          postgres    false            �            1259    17639    bid    TABLE     �   CREATE TABLE public.bid (
    bid_id integer NOT NULL,
    iklan_bid_id integer,
    pembeli_bid_id integer,
    tanggal_bid date DEFAULT CURRENT_DATE,
    harga_bid integer,
    status_bid character varying(20)
);
    DROP TABLE public.bid;
       public         heap    postgres    false            �            1259    17622    iklan    TABLE     �   CREATE TABLE public.iklan (
    iklan_id integer NOT NULL,
    mobil_iklan_id integer,
    penjual_iklan_id integer,
    judul_iklan text,
    tanggal_posting date
);
    DROP TABLE public.iklan;
       public         heap    postgres    false            �            1259    17545    mobil    TABLE     Y  CREATE TABLE public.mobil (
    mobil_id integer NOT NULL,
    penjual_mobil_id integer,
    merk_mobil character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    jenis_body character varying(50) NOT NULL,
    tipe_mobil character varying(15) NOT NULL,
    tahun_pembuatan integer NOT NULL,
    harga_jual integer NOT NULL
);
    DROP TABLE public.mobil;
       public         heap    postgres    false            �            1259    17695    jumlah_mobil    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW public.jumlah_mobil AS
 SELECT mobil.model,
    count(mobil.model) AS jumlah_model
   FROM public.mobil
  GROUP BY mobil.model
  WITH NO DATA;
 ,   DROP MATERIALIZED VIEW public.jumlah_mobil;
       public         heap    postgres    false    217            �            1259    17404    kota    TABLE     �   CREATE TABLE public.kota (
    kota_id integer NOT NULL,
    nama_kota character varying(100) NOT NULL,
    latitude real NOT NULL,
    longitude real NOT NULL
);
    DROP TABLE public.kota;
       public         heap    postgres    false            �            1259    17419    pembeli    TABLE     �   CREATE TABLE public.pembeli (
    pembeli_id integer NOT NULL,
    kota_pembeli_id integer,
    nama_depan character varying(50) NOT NULL,
    nama_belakang character varying(50) NOT NULL,
    detail_kontak character varying(100) NOT NULL
);
    DROP TABLE public.pembeli;
       public         heap    postgres    false            �            1259    17449    penjual    TABLE     �   CREATE TABLE public.penjual (
    penjual_id integer NOT NULL,
    kota_penjual_id integer,
    nama_depan character varying(50) NOT NULL,
    nama_belakang character varying(50) NOT NULL,
    detail_kontak character varying(100) NOT NULL
);
    DROP TABLE public.penjual;
       public         heap    postgres    false            �            1259    17703    rerata_harga_mobil    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW public.rerata_harga_mobil AS
 SELECT mobil.model,
    (avg(mobil.harga_jual))::double precision AS rerata_harga
   FROM public.mobil
  GROUP BY mobil.model
  WITH NO DATA;
 2   DROP MATERIALIZED VIEW public.rerata_harga_mobil;
       public         heap    postgres    false    217    217            *          0    17639    bid 
   TABLE DATA           g   COPY public.bid (bid_id, iklan_bid_id, pembeli_bid_id, tanggal_bid, harga_bid, status_bid) FROM stdin;
    public          postgres    false    219   0+       )          0    17622    iklan 
   TABLE DATA           i   COPY public.iklan (iklan_id, mobil_iklan_id, penjual_iklan_id, judul_iklan, tanggal_posting) FROM stdin;
    public          postgres    false    218   3       %          0    17404    kota 
   TABLE DATA           G   COPY public.kota (kota_id, nama_kota, latitude, longitude) FROM stdin;
    public          postgres    false    214   �7       (          0    17545    mobil 
   TABLE DATA           �   COPY public.mobil (mobil_id, penjual_mobil_id, merk_mobil, model, jenis_body, tipe_mobil, tahun_pembuatan, harga_jual) FROM stdin;
    public          postgres    false    217   9       &          0    17419    pembeli 
   TABLE DATA           h   COPY public.pembeli (pembeli_id, kota_pembeli_id, nama_depan, nama_belakang, detail_kontak) FROM stdin;
    public          postgres    false    215   �;       '          0    17449    penjual 
   TABLE DATA           h   COPY public.penjual (penjual_id, kota_penjual_id, nama_depan, nama_belakang, detail_kontak) FROM stdin;
    public          postgres    false    216   8@       �           2606    17644    bid bid_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_pkey PRIMARY KEY (bid_id);
 6   ALTER TABLE ONLY public.bid DROP CONSTRAINT bid_pkey;
       public            postgres    false    219            �           2606    17628    iklan iklan_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.iklan
    ADD CONSTRAINT iklan_pkey PRIMARY KEY (iklan_id);
 :   ALTER TABLE ONLY public.iklan DROP CONSTRAINT iklan_pkey;
       public            postgres    false    218            �           2606    17408    kota kota_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.kota
    ADD CONSTRAINT kota_pkey PRIMARY KEY (kota_id);
 8   ALTER TABLE ONLY public.kota DROP CONSTRAINT kota_pkey;
       public            postgres    false    214            �           2606    17549    mobil mobil_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.mobil
    ADD CONSTRAINT mobil_pkey PRIMARY KEY (mobil_id);
 :   ALTER TABLE ONLY public.mobil DROP CONSTRAINT mobil_pkey;
       public            postgres    false    217            �           2606    17423    pembeli pembeli_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.pembeli
    ADD CONSTRAINT pembeli_pkey PRIMARY KEY (pembeli_id);
 >   ALTER TABLE ONLY public.pembeli DROP CONSTRAINT pembeli_pkey;
       public            postgres    false    215            �           2606    17453    penjual penjual_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.penjual
    ADD CONSTRAINT penjual_pkey PRIMARY KEY (penjual_id);
 >   ALTER TABLE ONLY public.penjual DROP CONSTRAINT penjual_pkey;
       public            postgres    false    216            �           2606    17645    bid fk_iklan_bid    FK CONSTRAINT     z   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT fk_iklan_bid FOREIGN KEY (iklan_bid_id) REFERENCES public.iklan(iklan_id);
 :   ALTER TABLE ONLY public.bid DROP CONSTRAINT fk_iklan_bid;
       public          postgres    false    3211    219    218            �           2606    17424    pembeli fk_kota_pembeli    FK CONSTRAINT     �   ALTER TABLE ONLY public.pembeli
    ADD CONSTRAINT fk_kota_pembeli FOREIGN KEY (kota_pembeli_id) REFERENCES public.kota(kota_id);
 A   ALTER TABLE ONLY public.pembeli DROP CONSTRAINT fk_kota_pembeli;
       public          postgres    false    215    3203    214            �           2606    17454    penjual fk_kota_penjual    FK CONSTRAINT     �   ALTER TABLE ONLY public.penjual
    ADD CONSTRAINT fk_kota_penjual FOREIGN KEY (kota_penjual_id) REFERENCES public.kota(kota_id);
 A   ALTER TABLE ONLY public.penjual DROP CONSTRAINT fk_kota_penjual;
       public          postgres    false    214    3203    216            �           2606    17629    iklan fk_mobil_iklan    FK CONSTRAINT     �   ALTER TABLE ONLY public.iklan
    ADD CONSTRAINT fk_mobil_iklan FOREIGN KEY (mobil_iklan_id) REFERENCES public.mobil(mobil_id);
 >   ALTER TABLE ONLY public.iklan DROP CONSTRAINT fk_mobil_iklan;
       public          postgres    false    217    218    3209            �           2606    17650    bid fk_pembeli_bid    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT fk_pembeli_bid FOREIGN KEY (pembeli_bid_id) REFERENCES public.pembeli(pembeli_id);
 <   ALTER TABLE ONLY public.bid DROP CONSTRAINT fk_pembeli_bid;
       public          postgres    false    215    219    3205            �           2606    17634    iklan fk_penjual_iklan    FK CONSTRAINT     �   ALTER TABLE ONLY public.iklan
    ADD CONSTRAINT fk_penjual_iklan FOREIGN KEY (penjual_iklan_id) REFERENCES public.penjual(penjual_id);
 @   ALTER TABLE ONLY public.iklan DROP CONSTRAINT fk_penjual_iklan;
       public          postgres    false    216    218    3207            �           2606    17550    mobil fk_penjual_mobil    FK CONSTRAINT     �   ALTER TABLE ONLY public.mobil
    ADD CONSTRAINT fk_penjual_mobil FOREIGN KEY (penjual_mobil_id) REFERENCES public.penjual(penjual_id);
 @   ALTER TABLE ONLY public.mobil DROP CONSTRAINT fk_penjual_mobil;
       public          postgres    false    216    3207    217            +           0    17695    jumlah_mobil    MATERIALIZED VIEW DATA     /   REFRESH MATERIALIZED VIEW public.jumlah_mobil;
          public          postgres    false    220    3374            ,           0    17703    rerata_harga_mobil    MATERIALIZED VIEW DATA     5   REFRESH MATERIALIZED VIEW public.rerata_harga_mobil;
          public          postgres    false    221    3374            *   �  x�uY��.7
����l	�k�7p��>�Vm9��/�hF�fg���A�@7�e�>����G8z����������1��	�E���o��������;"�<����	�Q��H\��">^��<[$���hbOK,��$_ciO�������5(�ώjރ���k݈�Ğ/M��Ǜ��/���b͑���H�����+~K]L��R�6L�KG�H2_�i�D-��/Q�R��c=}�Ivy)�P\�����V�ⴼ���P��H��m�<�5I+��&�O	����wuO4��@���Y���a&�SЫ3F�B]�&�
���(��֦��W,"��%�/�fV�DuG5�� ���Π��݋\:�$�S��nA�#E��8��?r�@Xj��i�Ȏf�
H�UQ���Q�4��:<Eg�%��x��路��+�mɺ�`~lӎ��b�u�d7���7>Et"��|H�yBm�3��<��ͷ�u��:�欼�p�#���N3����a�x���~����ӢN�8���^��k���{�=� NV�EZM���<�#o�G�#�s I���ǂ���#f
��e8��Ħy]o$!�.��9��XRYN$��+*L,0��Ir��H�`��i��`y�6��vH��}[��N���Ul|���Q���}B��r�.{�^f}�f���l���_S���9G䙕c�<�漬�,�Ŀ�T�#���&�]���+Fs�h�O���\�&N�F2|0�h�M��5o��A�Զ�򀸖�x��u
�����.\�T�	��U%_U@����J�N�tvi�F�ɨY«�x�b��>���ε�.�L��};���t�Ҕg�|��z��jŊӬР�.,k#��G�k�d�J*����20���ԈM�>�L@�\'�O���0dk��-��8���휾V�SXt$�錠e��ѡ��FϠ�ov��̶𮉶��Tn���4]�VC���>��"������m�6ݖ��ڝ����u�N.�@E�tҿ������
��7!@�@By��Wl��Gs5|)�V@9��S�ͷIJ��8��6�_�N%�!��!iÎ��IӼ}}e��x�B���yNv�vbyG���$h6�*�J(A��0D:U��'V���=9��w�"^+CA�L������!�c�KB��2��-Tv
)�L3@�����l���/���Y;�[+�<�Z��v��*��y�+�2;@`#��B�f�����D�B�ư�64<��!�X;<�L�j�P��+n�y��X7�@�郀Z�l�ͤ�h�˧.�򐭤2�2b�&'�^�yN���yK��wpo�����x$������0�G��D=4��X�[�ͷ�M�M�]E�;�X����g�|2��~'#����#m��%G�(c
4�+r1��&OA#76$U|u���|�C�MD@@�����|p��׻��A����6ᶙ	]�^��1�m�#��5U����x_�|��5L1y��/{��*�q�i���Ά�����P4(��-0���e��~?e����Ä�m}-��6�E�l�����S=P'
3����9~�4�\A���i�U�gKB84���&i�_��Y�*OGK:�OTh0���ˊ�Q�`B�د�:^�d��O�ܻf�,|�==�O4��+.��vv��K���!{�8{��$E��TF�� O_�RiQ�����./��=��J�R1f�:K�uG�L�����,AF\�H�\y
jh4Z��[����t
��?;�<M���m�U� [��������r��D%U�,�-�~(���?����X��+�*�\q���]������bx�P��d�4��u�Z�{
���Hz���Ԕ O4��U�H��tM:�nZ��'����@K"M�5A?_�>�8�it�[4=��'�},�6U5:�[����W����}��.T��&�rS$�_t�a�*��,O7��y%x]6�i�^���~~~����      )   �  x�mV�n�8<�_��@�cG����:�i/���DY$�|�VS�HN0�L�����G������V��`��(בSo�~eQ���:�,E}������3ȫ�5���5�8w(ϲ�Q��x0j0?F3(��{����f�g����Z�Ѕ��N��Q>z�o��=Ze��0pE�FT��N��NM�i�@�0َ�B;��Sȣ�/�>�{7�q
�f;(���S�3����k�*\:������?l���b���f�!��"ϢD�Z�I�·�)r=��`��bKC����"*��b�5m���Q� 6�Y0A�2�#`I�t�<xoUb����G��u:���F���ΣA��fT����r��8��ԥ�g����Î��p#E�yv3:o�7��͈N��(u%�@�ǉ:�oE�ٹM��]{�E;[�I�U�Ľ��iS�@�	���� 	({&O�~��ioûʋ��U/�y�ַ�n׊JB�����ʌ4�uX2�}�%���̓���P#�|�VF�RC�P�NިW���ܾQ�-�#�'y��*��{n �0Mh �4+}æ��AW�ԋk�m���tx��3�<��8qfA�F�}��E��#��e&8���J-��y���N\�u#��/s�Q癋�&�|r���w�P�Y�tcS��s�áD�N!�B�E3lKөWX:��N�_n���/��5�5�v;K̂=vwp��3��G@�(e�N�8|Y?N�`��[��O�I�B����	�Y��Q���3K� /V�������?A�:�甴��4�����>&�.d.�E>g�g�|��c��U�3Ƥw��e�o>JTn�0^A��$4�<$���-O�\�?v�'gQ�F���	DcOa�j��{�ɚ��ځ)$تY��qH̊^��XX!��eM,�!ae�f��I������'��RZ���\��N'؜z�iZv;��R���t�&��!�r�X~b�r�%��"oD����J���qk\低!P��4Mq��J|M6�eֆ$ٴ��3��D<߬�q��Cֆe�����t�������r��-}?�cK�et����+����Xq�,�Ǎ��$���O)\�mHy�qz�a_������U*=������E��S�+Ͳ�r�/�z�!������/R�� �Y��      %   T  x�U��j�0����?Iװ�-�B���^fI	&������/?��42A���{�_���}��N݋D��U:H+qj�����t��"0�Ŗ옞���L�X r��p�y�I���0ܰu���3���1
s�ᖫ��[=�p�^Jlj� ��d7u5�y��zUWX�,��m����߇�:�]i��R$�5�'nt��>Rb.̦R���@ �ǽ�~)�b��YL�$n����~���p�]Q�vd�b%�<�m���z�Ձmâ�U�m`�noϷ�/�a���B%s%B�ʣ���y���6ۛ�1�"�f�C~�9�?��.�Fɂ>4GD��/�~ �ז�      (   x  x����j�@��GO�H��j/MZ�@�S���l�8�r�~��:��%�ʅO�c����YqP��SY��m���<�j��ׯ^���~�q�jv���<�Ap%(7ΏU��bX܈�U�TjQ�@��4�1�QT �f������;�:��8;�S�l��0'���
T���L2�ng�[�b�r�f��ɟ~S��H�4�k�)�cp����M*�mu� :�h�\C;4�m(�i@8��_���l~����\����8���G��kp�pL�8�
mzj�'邃���z_�X�X6YT�H6�Yt��a/��J�eB]�;w�f����ʐ�B��;E+�k��e�w���o����#�����"V!<�#%�S�1Lb���5+�T�����ݳ�}��sߥ$i�3��9:v)�/X{�<D�i�4Ɯ�?�߰�F=��ω4��&��-[	�)\�6�� �"���,܏т���*`ۆf�'�� ]^�V�@��靏��UT�X?��Տ-r@�4璓	����>��AY�i�Βh����||-�ٗ}Ul�
S&�(�緗i/�7|�I*�W����&��������bؠ�{�ϧ,����      &   �  x�M�Io7���装�Y܏�˱$[�ra2cg�1z�@�>��=q.<jy����D+�x8�G�\7ǩ��❶�3.u6i�$��Fܯqݯ�Z�������b�K�
��~����ҏoe�0MW��V9��t�z��)¾�m����t&���h����/����e��ĵ�Wi��uZn���+ⶠV݉�u�tp��t�h-���rwe�s]���C�h�J'gU�V��V�Kc�:���8�KR�1��*d�2����nK/>��k�9�Y���4���\P{��_��<K�W��)�<Ic�7��Y���n<��J{l"بr�Qj�_�qSķM9�o�=�l�uIKcE�u\C�~:��2V(}$�>�w�z�.�Ǽ�T���!�,�(Ksދ�֯�F<��墢1�HC��C��S�uw�6�[�,"Y��-���hr����jm}g6hR[�mR�
H��v��k㈏�az�F3/21ԧ*>�ê�!�"��)z�Ҭ��3=�u.�kje|̒G:�v*�x?��G,3Zl3�z��K�&�M��M- xK�P�e�K������zO�4�ף�MT�'+ɵ�?���>�aU��UШl }��P�p���CV�0��F������}�A#~(���S�u��OC�������fA�#��%I�)#���������C�����k�*>�P'��`$-�n!g�U�m���/G86[/�i:���2�����'>_%�i��z�f}�ۚfg y0�k�o�)��ԭ��|���d���As[���y�iq��I��7Z�8�2���4П�lP�8�φ��ꉏ���j9;:q�V���],��x�A[�ӌ��|���ĩE}B�����<��ljgVXʠ�����r�#�a ��Z��ݗq).����F�?���3G�3���e��ws��:6?u�qˏ�~�?O��ˉ b\-R�8ېF�:����0���'L�u�]��5�ޔ��s����ʞ��_���m��m��}� ���|?	q�Zv5����^�g��3׎9`l�<c�2�Q���J�r��#�6��T��1>y�f�ɐt�%�>��z�oUNKʜ�5�Ld���/�%~� Q�	S6{����_�K)����      '   x  x�MU�N�H}��
?�jT��Ȅ(dEe4/�iBWp����Ϲ.7!��|t���.$'��a�V��=Λ:�w�Ƴ�ج�1FZ�\2��<'�P��v�p%�.��� ���I�M�[1�l�����P-i$qM/u�_�~f�*V�R��:��P+>RO�8?L�TZ���ʔdlM?�ַ�����(o�
�F��{z�a���-�H蜻hK�f�|�,>�$�u���.uC�"��@�v���EӺ�6ᬋ�t&� �n�:���N��DA�����'i�<>�}�/ܵm�TpQ9�4V���pWt����N�u��ΥT�q���4��uxz��Ĝ�t֥�q����u�i'nh�?� gP��r��<P_k_�eݠ�vM8m���J�
�x�y��JO���4f��wh�Y�<�5=�ohˆT�?,��v�{��f����|*��<\iZ���w3����o�]�],IK��Q�������'��g�N���DiM�xYw�Ѯ�q�]��cT!�l���4,�۰��]
P���u�;7���TX�T �$��+��Ňaz��� Ѷ����҆����sM�#HY�5��]25c�me�a�zx��6�,	��"��/�-$~�\6�z�N>c!��� 4�x�z�9����\��&�ҖU�4n*����>����̸���\R_w���oK�ҙ�؏�3d/~ |��V�앉����8��~֍�^�4Lu�t����εm��+���{{����s%�U��k"��m�̆��'E��sA�В�j�힍J�5.�W.#Kxq+/w86F�ұ�f>L����KM��g�q,�uL�Pʲ]�t�5��!x��!"�p;��܂9i��9�XflZ[h�������/&d���
vQL�����4�~D��l�ǧ�m߀TH�*x�J�Z)^���Е����q@@{״u�����~x�Y�{th�}K�����/�"&Bwh
P��e`��~�����me�i�HW�����,> `Ժx�ɟ�+E�&��_Y9ُC}��6��j ���2�f�/~,M�h<����%�,bq�hZM�4��x12�V�e?�f�����1�r�'j��R��1��     