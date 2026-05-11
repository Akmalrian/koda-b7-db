--User Login information
SELECT
  u.user_id,
  u.email,
  p.full_name,
  p.photo
FROM users u
JOIN profiles p ON p.user_id = u.user_id
WHERE u.user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a';

SELECT pin
FROM users
WHERE user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a';


--ACCOUNT INFORMATION (balance, income, expense)
SELECT e.balance,
  (
    SELECT SUM(amount)
    FROM transactions
    WHERE receiver_id = e.user_id
      AND type        = 'income'
      AND status      = 'success'
  ) AS total_income,

  (
    SELECT SUM(amount)
    FROM transactions
    WHERE sender_id = e.user_id
      AND type      = 'expense'
      AND status    = 'success'
  ) AS total_expense
FROM ewallet e
WHERE e.user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a';

--User Profile Information
SELECT
  p.full_name,
  p.phone,
  p.photo,
  u.email
FROM profiles p
JOIN users u ON u.user_id = p.user_id
WHERE p.user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a';

--change User Profile
UPDATE profiles
SET
  full_name = 'tes coba',
  phone     = '08154335322',
  photo     = 'tes123.jpg'
WHERE user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a'
RETURNING *;

--change password
UPDATE users
SET
  password   = 'tes111',
  updated_at = NOW()
WHERE user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a';

--change pin
UPDATE users
SET
  pin        = '123456',
  updated_at = NOW()
WHERE user_id = 'de8c120b-cead-4226-b918-1061ec7e1ab8';