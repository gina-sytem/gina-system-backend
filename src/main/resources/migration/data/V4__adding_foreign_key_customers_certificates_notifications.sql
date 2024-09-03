ALTER TABLE certificates ADD CONSTRAINT fk_certificates_customers
FOREIGN KEY (customer_id) REFERENCES customers(id);

ALTER TABLE notifications ADD CONSTRAINT fk_notifications_customers
FOREIGN KEY (customer_id) REFERENCES customers(id);
