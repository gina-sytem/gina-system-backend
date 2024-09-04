CREATE TABLE notifications
(
    id                UUID                        NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id       UUID                        NOT NULL,
    type              TEXT                        NOT NULL,
    trigger_date      TIMESTAMP(0) WITH TIME ZONE NOT NULL,
    triggered_date    TIMESTAMP(0) WITH TIME ZONE NOT NULL,
    is_manual_trigger BOOLEAN,
    created_at        TIMESTAMP(0) WITH TIME ZONE NOT NULL             DEFAULT NOW(),
    updated_at        TIMESTAMP(0) WITH TIME ZONE NOT NULL             DEFAULT NOW()
);

COMMENT ON COLUMN notifications.id IS 'Unique identifier for each certificate';
COMMENT ON COLUMN notifications.customer_id IS 'Reference to the customer associated with the notification';
COMMENT ON COLUMN notifications.type IS 'Type of notification (e.g., Birthday, Certificate Expiry).';
COMMENT ON COLUMN notifications.trigger_date IS 'Date when the notification is to be sent';
COMMENT ON COLUMN notifications.triggered_date IS 'Date when the notification was sent';
COMMENT ON COLUMN notifications.is_manual_trigger IS 'Boolean flag indicating if the notification was triggered manually';
COMMENT ON COLUMN notifications.created_at IS 'Date of when the certificate was registered';
COMMENT ON COLUMN notifications.updated_at IS 'Date of the last update to the certificate record';
