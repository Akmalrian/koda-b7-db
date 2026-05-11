--register
  INSERT INTO users (email, password)
  VALUES ('Tes123@gmail.com', '123qweA23')
  RETURNING user_id;

  INSERT INTO profiles (user_id)
  VALUES ('d8040472-fde0-4cae-aef6-42013e42ee1a');

  INSERT INTO ewallet (user_id, balance)
  VALUES ('d8040472-fde0-4cae-aef6-42013e42ee1a', 0.00);

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
JOIN ewallet e  ON e.user_id = u.user_id;
