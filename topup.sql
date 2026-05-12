  --INSERT transactions, langsung ambil id nya
  WITH new_transaction AS (
    INSERT INTO transactions (user_id, type, amount, status)
    VALUES (6, 'topup', 100000, 'success')
    RETURNING id
  )
  -- Pakai id dari new_transaction untuk buat topup_details
  INSERT INTO topup_details (
    transaction_id,
    wallet_id,
    payment_method_id,
    order_amount,
    tax_amount,
    delivery_fee,
    total_amount
  )
  SELECT
    id,       -- id dari new_transaction
    1,        -- wallet_id
    1,        -- payment_method_id
    100000,   -- order_amount
    10000,    -- tax_amount
    0,        -- delivery_fee
    110000    -- total_amount
  FROM new_transaction;

  -- Tambah balance wallet
  UPDATE wallet
  SET
    balance    = balance + 100000,
    updated_at = NOW()
  WHERE id = 1;
  