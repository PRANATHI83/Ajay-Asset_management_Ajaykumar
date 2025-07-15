async function initializeDatabase() {
    try {
        console.log('Creating asset_requests table...');
        await pool.query(`
            CREATE TABLE IF NOT EXISTS asset_requests (
                id SERIAL PRIMARY KEY,
                employee_id VARCHAR(7),
                employee_name VARCHAR(40),
                email VARCHAR(40),
                request_date DATE,
                asset_type VARCHAR(50),
                asset_name VARCHAR(30),
                details VARCHAR(150),
                status VARCHAR(20) DEFAULT 'Pending',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        `);
        await pool.query(`
            INSERT INTO asset_requests (employee_id, employee_name, email, request_date, asset_type, asset_name, details, status)
            VALUES ('ATS0123', 'John Doe', 'john.doe@gmail.com', CURRENT_DATE, 'Laptop', 'MacBook Pro', 'Need for development work', 'Approved')
            ON CONFLICT DO NOTHING;
        `);
        console.log('Database table initialized with sample data');
    } catch (err) {
        console.error('Error initializing database:', err.message);
        throw err;
    }
}