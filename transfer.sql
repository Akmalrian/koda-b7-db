-- CREATE TRANSFER

  -- Insert transaction, langsung ambil dari id nya
  WITH new_transaction AS(
  INSERT INTO transactions (user_id, type, amount, status)
  VALUES (6, 'transfer', 50000, 'success');
  RETURNING id;
  )
  -- pakai id dari new_transaction untuk membuat transfer detail
  INSERT INTO transfer_details (
    transaction_id,
    sender_wallet_id,
    receiver_wallet_id,
    amount,
    notes
  )
  SELECT
    id,  -- id dari transaksi yang baru dibuat
    6,                 -- sender_wallet_id
    7,                 -- receiver_wallet_id
    50000,
    'Bayar kopi'
  FROM new_transaction;

  -- 3. Kurangi balance pengirim
  UPDATE wallet
  SET
    balance    = balance - 50000,
    updated_at = NOW()
  WHERE id = 6
    AND balance >= 50000;    -- validasi saldo cukup

  -- 4. Tambah balance penerima
  UPDATE wallet
  SET
    balance    = balance + 50000,
    updated_at = NOW()
  WHERE id = 7;
