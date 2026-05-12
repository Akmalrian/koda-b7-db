
table profiles
DROP TABLE users
DELETE FROM transaction_categories
WHERE id = ALL;

-- REGISTER
-- Saat register otomatis buat users dan wallet

  INSERT INTO users (email, password)
  VALUES ('akmal@gmail.com', '123456');

  INSERT INTO wallet (user_id, balance)
  VALUES (LAST_INSERT_ID(), 0);


-- LOGIN
SELECT
  u.id,
  u.email,
  u.password,
  u.pin,
  u.fullname,
  u.photo_path,
  u.phone_number,
  w.balance
FROM users u
JOIN wallet w ON w.user_id = u.id
WHERE u.email = 'akmal@gmail.com';

table transactions