CREATE TABLE patients (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE medical_history (
    ID INT PRIMARY KEY,
    admitted_at TIMESTAMP,
    patients_ID INT,
    status VARCHAR(100),
    CONSTRAINT FK_medical_history_patients FOREIGN KEY (patients_ID)
    REFERENCES patients(ID)
);

CREATE TABLE treatments (
    ID INT PRIMARY KEY,
    type VARCHAR(100),
    name VARCHAR(100),
    medical_history_ID INT,
    CONSTRAINT FK_treatments_medical_history FOREIGN KEY (medical_history_ID)
    REFERENCES medical_history(ID)
);

CREATE TABLE invoices (
    ID INT PRIMARY KEY,
    total_amount DECIMAL(5, 2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_ID INT,
    CONSTRAINT FK_invoices_medical_history FOREIGN KEY (medical_history_ID)
    REFERENCES medical_history(ID)
);

CREATE TABLE invoice_items (
    ID INT PRIMARY KEY,
    unit_price DECIMAL(5, 2),
    quantity INT,
    total_price DECIMAL(5, 2),
    invoices_ID INT,
    treatments_ID INT,
    CONSTRAINT FK_invoice_items_invoices FOREIGN KEY (invoices_ID)
    REFERENCES invoices(ID),
    CONSTRAINT FK_invoice_items_treatments FOREIGN KEY (treatments_ID)
    REFERENCES treatments(ID)
);

CREATE TABLE patient_treatment (
    patients_ID INT,
    treatments_ID INT,
    CONSTRAINT FK_patient_treatment_patient FOREIGN KEY (patients_ID)
    REFERENCES patients(ID),
    CONSTRAINT FK_patient_treatment_treatment FOREIGN KEY (treatments_ID)
    REFERENCES treatments(ID)
);

CREATE INDEX IDX_patient_treatment_patient ON patient_treatment (patients_ID);
CREATE INDEX IDX_patient_treatment_treatment ON patient_treatment (treatments_ID);
