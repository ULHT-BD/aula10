-- exemplo dado em aula sobre formas de remoção de duplicados
-- adicionar atributo tmp_id
ALTER TABLE load_voting ADD tmp_id INT;

-- popular tmp_id com numeros sequenciais
SET @rownum := 0;
UPDATE load_voting SET tmp_id=(@rownum := @rownum + 1) ORDER BY id_movie ;

-- confirmar dados em nova coluna
SELECT * FROM load_voting lv ORDER BY tmp_id;

-- podemos obter o id mais alto de cada votacao com
SELECT MAX(tmp_id) tmp_id
FROM load_voting lv 
GROUP BY id_movie;

-- podemos remover duplicados mantendo apenas os que correspondem ao max
DELETE FROM load_voting
WHERE tmp_id NOT IN
(SELECT MAX(tmp_id) tmp_id
FROM load_voting lv 
GROUP BY id_movie
);

-- ou remover usando delete join
DELETE lv2
FROM load_voting lv1
JOIN load_voting lv2 ON lv1.id_movie = lv2.id_movie 
WHERE lv1.tmp_id > lv2.tmp_id ;

-- remover tmp_id
ALTER TABLE load_voting DROP tmp_id;