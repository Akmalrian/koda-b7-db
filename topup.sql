--Top Up
UPDATE ewallet
SET balance = balance + 50000
WHERE user_id = 2;

INSERT INTO transactions ( receiver_id, category_id, method_id, type, amount, tax, total_amount, status ) VALUES
(2,
(SELECT id FROM transaction_categories WHERE category_name = 'topup'),
(SELECT id FROM payment_methods WHERE method_name = 'bca'),
'income',
50000,
5000,
55000, 
'success'
);
