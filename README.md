## ERD (Entity Relationship Diagram)

```mermaid
erDiagram

    USERS {
        uuid user_id PK
        string email
        string password
        string pin
        timestamp created_at
        timestamp updated_at
    }

    PROFILES {
        uuid id PK
        uuid user_id FK
        string full_name
        string phone
        string photo
    }

    EWALLET {
        uuid id PK
        uuid user_id FK
        decimal balance
    }

  TRANSACTIONS {
    uuid id PK
    uuid sender_id FK
    uuid receiver_id FK
    uuid category_id FK
    uuid method_id FK
    string type
    decimal amount
    decimal tax
    decimal total_amount
    string notes
    string status
    timestamp transaction_date
  }

  TRANSACTION_CATEGORIES {
    uuid id PK
    string category_name
  }

  PAYMENT_METHODS {
    uuid id PK
    string method_name
  }

USERS ||--|| PROFILES : "memiliki"
USERS ||--|| EWALLET : "memiliki"
USERS ||--o{ TRANSACTIONS : "mengirim (sender)"
USERS ||--o{ TRANSACTIONS : "menerima (receiver)"
TRANSACTIONS ||--o{ TRANSACTION_CATEGORIES : "memiliki kategori"
TRANSACTIONS ||--o{ PAYMENT_METHODS : "memiliki metode"


```