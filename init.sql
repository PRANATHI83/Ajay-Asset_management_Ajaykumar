-- Connect to the database
\c new_employee_db;

-- Create the asset_requests table
CREATE TABLE IF NOT EXISTS asset_requests (
    id SERIAL PRIMARY KEY,
    employee_id VARCHAR(7) NOT NULL,
    employee_name VARCHAR(40) NOT NULL,
    email VARCHAR(40) NOT NULL,
    request_date DATE NOT NULL,
    asset_type VARCHAR(50) NOT NULL,
    asset_name VARCHAR(30) NOT NULL,
    details VARCHAR(150) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Constraints
    CONSTRAINT valid_email CHECK (email ~* '^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]@gmail\\.com$'),
    CONSTRAINT valid_employee_id CHECK (employee_id ~ '^ATS0[0-9]{3}$' AND employee_id <> 'ATS0000')
);

-- Unique constraint to avoid duplicate requests per day
CREATE UNIQUE INDEX IF NOT EXISTS unique_asset_request
ON asset_requests (employee_id, asset_name, request_date);

-- Insert sample data
INSERT INTO asset_requests (employee_id, employee_name, email, request_date, asset_type, asset_name, details, status)
VALUES ('ATS0123', 'John Doe', 'john.doe@gmail.com', CURRENT_DATE, 'Laptop', 'MacBook Pro', 'Need for development work', 'Approved')
ON CONFLICT DO NOTHING;
