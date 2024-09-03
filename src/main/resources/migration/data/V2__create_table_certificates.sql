CREATE TABLE certificates
(
    id              UUID                        NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id     UUID                        NOT NULL,
    model           TEXT                        NOT NULL,
    expiration_date TIMESTAMP(0) WITH TIME ZONE NOT NULL,
    issue_date      TIMESTAMP(0) WITH TIME ZONE NOT NULL,
    created_at      TIMESTAMP(0) WITH TIME ZONE NOT NULL             DEFAULT NOW(),
    updated_at      TIMESTAMP(0) WITH TIME ZONE NOT NULL             DEFAULT NOW()
);

COMMENT ON COLUMN certificates.id IS 'Unique identifier for each certificate';
COMMENT ON COLUMN certificates.customer_id IS 'Reference to the customer associated with the notification';
COMMENT ON COLUMN certificates.model IS 'Enum (A1, A3, NEOID)';
COMMENT ON COLUMN certificates.expiration_date IS 'Expiry date of the certificate';
COMMENT ON COLUMN certificates.issue_date IS 'Issue date of the certificate';
COMMENT ON COLUMN certificates.created_at IS 'Date of when the certificate was registered';
COMMENT ON COLUMN certificates.updated_at IS 'Date of the last update to the certificate record';
