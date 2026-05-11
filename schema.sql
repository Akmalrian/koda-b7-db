
CREATE TABLE transaction_categories (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE payment_methods (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  method_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
  user_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email      VARCHAR(255) NOT NULL UNIQUE,
  password   VARCHAR(255) NOT NULL,
  pin        VARCHAR(6),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE profiles (
  id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id   UUID NOT NULL UNIQUE,
  full_name VARCHAR(255),
  phone     VARCHAR(20),
  photo     TEXT,

  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE ewallet (
  id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE,
  balance DECIMAL(15, 2) NOT NULL DEFAULT 0.00,

  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE transactions (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sender_id        UUID,
  receiver_id      UUID,
  category_id      UUID NOT NULL,
  method_id        UUID,
  type             VARCHAR(20) NOT NULL,
  amount           DECIMAL(15, 2) NOT NULL CHECK (amount > 0),
  tax              DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  total_amount     DECIMAL(15, 2) NOT NULL,
  notes            TEXT,
  status           VARCHAR(20) NOT NULL DEFAULT 'pending',
  transaction_date TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (sender_id)   REFERENCES users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES transaction_categories(id),
  FOREIGN KEY (method_id)   REFERENCES payment_methods(id)
);

--Kategori Transaksi
INSERT INTO transaction_categories (category_name) VALUES
  ('topup'),
  ('transfer');

--Metode Pembayaran
INSERT INTO payment_methods (method_name) VALUES
  ('bca'),
  ('bri'),
  ('bni'),
  ('dana'),
  ('gopay'),
  ('ovo');