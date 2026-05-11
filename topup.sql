
UPDATE ewallet
SET balance = balance + 50000
WHERE user_id = 'd4cf7861-6f31-4fc3-983a-331a52155ff0';

INSERT INTO transactions ( receiver_id, category_id, method_id, type, amount, tax, total_amount, status ) VALUES
('d4cf7861-6f31-4fc3-983a-331a52155ff0',
(SELECT id FROM transaction_categories WHERE category_name = 'topup'),
(SELECT id FROM payment_methods WHERE method_name = 'bca'),
'income',
30000,
3000,
33000,
'success'
);