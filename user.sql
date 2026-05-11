--User Login information
SELECT
  u.user_id,
  u.email,
  p.full_name,
  p.photo
FROM users u
JOIN profiles p ON p.user_id = u.user_id
WHERE u.user_id = 1;

SELECT pin
FROM users
WHERE user_id = 1;

--User Profile Information
SELECT
  p.full_name,
  p.phone,
  p.photo,
  u.email
FROM profiles p
JOIN users u ON u.user_id = p.user_id
WHERE p.user_id = 1;

--change User Profile
UPDATE profiles
SET
  full_name = 'Akmal Oktarian',
  phone     = '08123432222',
  photo     = 'coba.jpg'
WHERE user_id = 2
RETURNING *;

--change password
UPDATE users
SET
  password   = 'coba111',
  updated_at = NOW()
WHERE user_id = 3;

--change pin
UPDATE users
SET
  pin        = '123456',
  updated_at = NOW()
WHERE user_id = 2;

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
WHERE e.user_id = 3;

