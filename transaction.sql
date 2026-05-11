--Riwayat Top Up
SELECT t.id, t.type, t.amount, t.tax, t.total_amount, t.notes, t.status, t.transaction_date, pm.method_name, tc.category_name, sender.email AS sender_email, receiver.email AS receiver_email
FROM transactions t
JOIN transaction_categories tc ON tc.id = t.category_id
JOIN payment_methods pm ON pm.id = t.method_id
LEFT JOIN users sender ON sender.user_id = t.sender_id
LEFT JOIN users receiver ON receiver.user_id = t.receiver_id
WHERE sender_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a'
OR receiver_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a'
ORDER BY t.transaction_date DESC;

--Riwayat Transfer
SELECT t.id, t.type, t.amount, t.tax, t.total_amount, t.status, t.transaction_date, tc.category_name
FROM transactions t
JOIN transaction_categories tc ON tc.id = t.category_id
WHERE (t.sender_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a' OR t.receiver_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a')
AND t.type = 'expense'
AND t.status = 'success'
AND t.transaction_date BETWEEN '2026-01-01' AND '2026-12-31'
ORDER BY t.transaction_date DESC;

--Pencarian dan Pagination
SELECT u.user_id, p.full_name, p.phone, p.photo
FROM users u
JOIN profiles p ON p.user_id = u.user_id
WHERE u.user_id != 'd8040472-fde0-4cae-aef6-42013e42ee1a'
AND (
    p.full_name LIKE '%name%' 
    OR p.phone LIKE '%0812%' 
)
ORDER BY p.full_name ASC
LIMIT 10 OFFSET 0;

--Transfer
--saldo si pengirim
UPDATE ewallet
SET balance = balance - 50000
WHERE user_id = 'de8c120b-cead-4226-b918-1061ec7e1ab8' 
AND balance >= 50000;

--saldo si penerima
UPDATE ewallet
SET balance = balance + 50000
WHERE user_id = 'd8040472-fde0-4cae-aef6-42013e42ee1a';

--catat transaksi
INSERT INTO transactions (sender_id, receiver_id, category_id, type, amount, total_amount, notes, status) VALUES
('de8c120b-cead-4226-b918-1061ec7e1ab8','d8040472-fde0-4cae-aef6-42013e42ee1a',(SELECT id FROM transaction_categories WHERE category_name = 'transfer' ),
'expense',50000,50000,'Bayar Kue','success');

table transactions;