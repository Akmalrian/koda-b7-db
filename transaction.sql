-- GET TRANSACTION HISTORY
-- Ambil semua history (topup + transfer) dari tabel transactions
SELECT
  t.id,
  t.type,
  t.amount,
  t.status,
  t.created_at
FROM transactions t
WHERE t.user_id = 1
ORDER BY t.created_at DESC;


-- GET HISTORY WITH OPTION (income/expense, date range)
-- Filter berdasarkan tipe dan rentang tanggal
SELECT
  t.id,
  t.type,
  t.amount,
  t.status,
  t.created_at
FROM transactions t
WHERE t.user_id   = 1
  AND t.type      = 'transfer'       -- ganti 'topup' untuk income
  AND t.status    = 'success'
  AND t.created_at BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY t.created_at DESC;


-- GET DETAIL HISTORY TOPUP
-- Ambil detail topup dari transaction_id tertentu
SELECT
  t.id            AS transaction_id,
  t.type,
  t.status,
  t.created_at,
  td.order_amount,
  td.tax_amount,
  td.delivery_fee,
  td.total_amount,
  pm.payment_name
FROM transactions t
JOIN topup_details td  ON td.transaction_id    = t.id
JOIN payment_methods pm ON pm.id               = td.payment_method_id
WHERE t.id      = 1
  AND t.user_id = 1;


-- GET DETAIL HISTORY TRANSFER
-- Ambil detail transfer dari transaction_id tertentu
SELECT
  t.id          AS transaction_id,
  t.type,
  t.status,
  t.created_at,
  trd.amount,
  trd.notes,
  sender.email   AS sender_email,
  receiver.email AS receiver_email
FROM transactions t
JOIN transfer_details trd ON trd.transaction_id     = t.id
JOIN wallet ws            ON ws.id                  = trd.sender_wallet_id
JOIN wallet wr            ON wr.id                  = trd.receiver_wallet_id
JOIN users sender         ON sender.id              = ws.user_id
JOIN users receiver       ON receiver.id            = wr.user_id
WHERE t.id      = 1
  AND t.user_id = 1;


-- FIND RECEIVER WITH PAGINATION
SELECT
  u.id,
  u.fullname,
  u.phone_number,
  u.photo_path,
  w.id AS wallet_id
FROM users u
JOIN wallet w ON w.user_id = u.id
WHERE u.id != 1
  AND (
    u.fullname     LIKE '%ghaluh%'
    OR u.phone_number LIKE '%0821%'
  )
ORDER BY u.fullname ASC
LIMIT 7 OFFSET 0;    -- halaman 1. halaman 2: OFFSET 7, dst