--　username　をセレクトし編集しつつ更新する
--　mst_usersに、usernameカラムがあるとして。

UPDATE mst_users
SET username = B.uname
FROM
(
  SELECT id, COALESCE(arr[2] || '_' || arr[1] || '_' || arr[3], username) as uname FROM
  (
    SELECT id, username, regexp_split_to_array(username, '_') as arr FROM mst_users
  ) A
) B
WHERE mst_users.id = B.id

--アンダースコア(_)の他に、アットマーク(@)でも分割する
--サブクエリのA.arrは、{mamoru,fuji,32,example.com}のように返ってくるので、
--配列を組み替えて文字列結合した結果(mamoru_fuji_32@example.com)で更新する

UPDATE mst_users
SET email = B.uname
FROM
(
  SELECT id, COALESCE(arr[3] || '_' || arr[1] || '_' || arr[2]  || '@' || arr[4], email) as uname FROM
  (
    SELECT id, email, regexp_split_to_array(email, '(_|@)') as arr FROM mst_users
  ) A
) B
WHERE mst_users.id = B.id
