CREATE TABLE customers
(
    id               UUID                        NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    name             TEXT                        NOT NULL,
    document         TEXT                        NOT NULL UNIQUE,
    birth_date       TIMESTAMP(0) WITH TIME ZONE NOT NULL,
    phone_number     TEXT                        NOT NULL UNIQUE,
    email            TEXT                        NOT NULL UNIQUE,
    reference_number TEXT                        NOT NULL,
    created_at       TIMESTAMP(0) WITH TIME ZONE NOT NULL             DEFAULT NOW(),
    updated_at       TIMESTAMP(0) WITH TIME ZONE NOT NULL             DEFAULT NOW()
);

COMMENT ON COLUMN customers.id IS 'Unique identifier for each customer';
COMMENT ON COLUMN customers.name IS 'Full name of the customer';
COMMENT ON COLUMN customers.document IS 'CPF or CNPJ number';
COMMENT ON COLUMN customers.birth_date IS 'Date of birth';
COMMENT ON COLUMN customers.phone_number IS 'Contact phone number';
COMMENT ON COLUMN customers.email IS 'Contact email address';
COMMENT ON COLUMN customers.reference_number IS 'External ID provided by the company';
COMMENT ON COLUMN customers.created_at IS 'Date of when the customer was registered';
COMMENT ON COLUMN customers.updated_at IS 'Date of the last update to the customer record';
