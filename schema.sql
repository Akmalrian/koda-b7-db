CREATE TABLE users (
  id           SERIAL PRIMARY KEY,
  email        VARCHAR(255) NOT NULL UNIQUE,
  password     VARCHAR(255) NOT NULL,
  pin          VARCHAR(6),
  fullname     VARCHAR(255),
  photo_path   TEXT,
  phone_number VARCHAR(20),
  created_at   TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE wallet (
  id         SERIAL PRIMARY KEY,
  user_id    INT NOT NULL UNIQUE,
  balance    DECIMAL(15,2) NOT NULL DEFAULT 0,
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE transactions (
  id         SERIAL PRIMARY KEY,
  user_id    INT NOT NULL,
  type       VARCHAR(20) NOT NULL,
  amount     DECIMAL(15,2) NOT NULL,
  status     VARCHAR(20) NOT NULL DEFAULT 'pending',
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payment_methods (
  id           SERIAL PRIMARY KEY,
  payment_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE topup_details (
  id                SERIAL PRIMARY KEY,
  transaction_id    INT NOT NULL UNIQUE,
  wallet_id         INT NOT NULL,
  payment_method_id INT NOT NULL,
  order_amount      DECIMAL(15,2) NOT NULL,
  tax_amount        DECIMAL(15,2) NOT NULL DEFAULT 0,
  delivery_fee      DECIMAL(15,2) NOT NULL DEFAULT 0,
  total_amount      DECIMAL(15,2) NOT NULL,
  created_at        TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (transaction_id)    REFERENCES transactions(id),
  FOREIGN KEY (wallet_id)         REFERENCES wallet(id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id)
);

CREATE TABLE transfer_details (
  id                 SERIAL PRIMARY KEY,
  transaction_id     INT NOT NULL UNIQUE,
  sender_wallet_id   INT NOT NULL,
  receiver_wallet_id INT NOT NULL,
  amount             DECIMAL(15,2) NOT NULL,
  notes              TEXT,
  created_at         TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (transaction_id)     REFERENCES transactions(id),
  FOREIGN KEY (sender_wallet_id)   REFERENCES wallet(id),
  FOREIGN KEY (receiver_wallet_id) REFERENCES wallet(id)
);

-- ========================
-- INSERT DATA MASTER
-- ========================
INSERT INTO payment_methods (payment_name) VALUES
  ('bri'),
  ('dana'),
  ('bca'),
  ('gopay'),
  ('ovo');