--Riwayat Transaksi
SELECT t.id, t.type, t.amount, t.tax, t.total_amount, t.notes, t.status, t.transaction_date, pm.method_name, tc.category_name, sender.email AS sender_email, receiver.email AS receiver_email
FROM transactions t
JOIN transaction_categories tc ON tc.id = t.category_id
LEFT JOIN payment_methods pm ON pm.id = t.method_id
LEFT JOIN users sender ON sender.user_id = t.sender_id
LEFT JOIN users receiver ON receiver.user_id = t.receiver_id
WHERE sender_id = 3
OR receiver_id = 3
ORDER BY t.transaction_date DESC;

--Riwayat Transaksi dengan option (income/expense data range)
SELECT t.id, t.type, t.amount, t.tax, t.total_amount, t.status, t.transaction_date, tc.category_name
FROM transactions t
JOIN transaction_categories tc ON tc.id = t.category_id
WHERE (t.sender_id = 3 OR t.receiver_id = 3)
AND t.type = 'expense'
AND t.status = 'success'
AND t.transaction_date BETWEEN '2026-01-01' AND '2026-12-31'
ORDER BY t.transaction_date DESC;

--Pencarian dan Pagination
SELECT u.user_id, p.full_name, p.phone, p.photo
FROM users u
JOIN profiles p ON p.user_id = u.user_id
WHERE u.user_id != 3
AND (
    p.full_name LIKE '%a%' 
    OR p.phone LIKE '%082342%' 
)
ORDER BY p.full_name ASC
LIMIT 10 OFFSET 0;

--Transfer
--saldo si pengirim
UPDATE ewallet
SET balance = balance - 50000
WHERE user_id = 2
AND balance >= 50000;

--saldo si penerima
UPDATE ewallet
SET balance = balance + 50000
WHERE user_id = 3;

--catat transaksi
INSERT INTO transactions (sender_id, receiver_id, category_id, type, amount, total_amount, notes, status) VALUES
(2,3,(SELECT id FROM transaction_categories WHERE category_name = 'transfer' ),
'expense',50000,50000,'Bayar Kopi','success');

table transactions;