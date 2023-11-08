-- Create a table to store patient information
CREATE TABLE patients (
    ID INT PRIMARY KEY,         
    Name VARCHAR(100),          -- Patient's name
    date_of_birth DATE          -- Patient's date of birth
);

-- Create a table to store medical history records
CREATE TABLE medical_history (
    ID INT PRIMARY KEY,         -- Unique identifier for each medical history record
    admitted_at TIMESTAMP,     -- Timestamp when the patient was admitted
    patients_ID INT,           -- Foreign key referencing the patient
    status VARCHAR(100),       -- Medical history status
    CONSTRAINT FK_medical_history_patients FOREIGN KEY (patients_ID)
    REFERENCES patients(ID)    -- Create a foreign key relationship with the patients table
);

-- Create a table to store treatment information
CREATE TABLE treatments (
    ID INT PRIMARY KEY,         -- Unique identifier for each treatment
    type VARCHAR(100),         -- Type of treatment
    name VARCHAR(100),         -- Name of the treatment
    medical_history_ID INT,    -- Foreign key referencing the medical history
    CONSTRAINT FK_treatments_medical_history FOREIGN KEY (medical_history_ID)
    REFERENCES medical_history(ID)  -- Create a foreign key relationship with the medical_history table
);

-- Create a table to store invoice information
CREATE TABLE invoices (
    ID INT PRIMARY KEY,         -- Unique identifier for each invoice
    total_amount DECIMAL(5, 2),  -- Total amount of the invoice with decimal precision
    generated_at TIMESTAMP,     -- Timestamp when the invoice was generated
    payed_at TIMESTAMP,         -- Timestamp when the invoice was paid
    medical_history_ID INT,    -- Foreign key referencing the medical history
    CONSTRAINT FK_invoices_medical_history FOREIGN KEY (medical_history_ID)
    REFERENCES medical_history(ID)  -- Create a foreign key relationship with the medical_history table
);

-- Create a table to store invoice items
CREATE TABLE invoice_items (
    ID INT PRIMARY KEY,         -- Unique identifier for each invoice item
    unit_price DECIMAL(5, 2),  -- Price per unit of the item with decimal precision
    quantity INT,              -- Quantity of items
    total_price DECIMAL(5, 2), -- Total price for the invoice item with decimal precision
    invoices_ID INT,           -- Foreign key referencing the invoices
    treatments_ID INT,         -- Foreign key referencing the treatments
    CONSTRAINT FK_invoice_items_invoices FOREIGN KEY (invoices_ID)
    REFERENCES invoices(ID),   -- Create a foreign key relationship with the invoices table
    CONSTRAINT FK_invoice_items_treatments FOREIGN KEY (treatments_ID)
    REFERENCES treatments(ID)  -- Create a foreign key relationship with the treatments table
);

-- Create a table to associate patients with treatments
CREATE TABLE patient_treatment (
    patients_ID INT,           -- Foreign key referencing the patients
    treatments_ID INT,         -- Foreign key referencing the treatments
    CONSTRAINT FK_patient_treatment_patient FOREIGN KEY (patients_ID)
    REFERENCES patients(ID),   -- Create a foreign key relationship with the patients table
    CONSTRAINT FK_patient_treatment_treatment FOREIGN KEY (treatments_ID)
    REFERENCES treatments(ID)  -- Create a foreign key relationship with the treatments table
);

-- Create indexes for the patient_treatment table
CREATE INDEX IDX_patient_treatment_patient ON patient_treatment (patients_ID);
CREATE INDEX IDX_patient_treatment_treatment ON patient_treatment (treatments_ID);
