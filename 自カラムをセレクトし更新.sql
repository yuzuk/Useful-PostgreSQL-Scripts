--username　をセレクトし編集しつつ更新する
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