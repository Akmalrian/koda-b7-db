--register
  INSERT INTO users (email, password)
  VALUES ('cobacoba@gmail.com', '123456')
  RETURNING user_id;

  INSERT INTO profiles (user_id)
  VALUES (3);

  INSERT INTO ewallet (user_id, balance)
  VALUES (3, 0.00);

--login
SELECT
  u.user_id,
  u.email,
  u.password,   
  u.pin,
  p.full_name,
  p.phone,
  p.photo,
  e.balance
FROM users u
JOIN profiles p ON p.user_id = u.user_id
JOIN ewallet e  ON e.user_id = u.user_id
WHERE u.email = 'akmal@gmail.com';


table ewallet
DROP TABLE payment_methods;
DELETE TABLE users
WHERE email = 'akmal@gmail.com';