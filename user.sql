-- GET USER LOGIN INFORMATION (email, fullname, photo)
SELECT
  id,
  email,
  fullname,
  photo_path
FROM users
WHERE id = 1;


-- GET / CHECK USER PIN
SELECT pin
FROM users
WHERE id = 1;


-- GET USER ACCOUNT INFORMATION (balance, income, expense)
SELECT
  w.balance,

  (
    SELECT SUM(t.amount)
    FROM transactions t
    WHERE t.user_id = w.user_id
      AND t.type    = 'topup'
      AND t.status  = 'success'
  ) AS total_income,

  (
    SELECT SUM(t.amount)
    FROM transactions t
    WHERE t.user_id = w.user_id
      AND t.type    = 'transfer'
      AND t.status  = 'success'
  ) AS total_expense

FROM wallet w
WHERE w.user_id = 1;


-- GET USER PROFILE (photo, fullname, phone, email)
SELECT
  fullname,
  phone_number,
  photo_path,
  email
FROM users
WHERE id = 1;


-- CHANGE USER PROFILE
UPDATE users
SET
  fullname     = 'Akmal Rian',
  phone_number = '08123456789',
  photo_path   = 'url-or-base64',
  updated_at   = NOW()
WHERE id = 1;


-- CHANGE PASSWORD
UPDATE users
SET
  password   = 'new_hashed_password',
  updated_at = NOW()
WHERE id = 1;


-- CHANGE PIN
UPDATE users
SET
  pin        = '123456',
  updated_at = NOW()
WHERE id = 1;
