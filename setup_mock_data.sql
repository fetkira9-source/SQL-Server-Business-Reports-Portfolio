-- 1. Create Simulated Product Master Table (Mimics SB1010)
CREATE TABLE #SB1010_MOCK (
    B1_COD VARCHAR(15),
    B1_DESC VARCHAR(40),
    B1_CUSTD DECIMAL(12,2),
    D_E_L_E_T_ VARCHAR(1)
);
INSERT INTO #SB1010_MOCK VALUES 
('10001', 'Premium Wireless Headset', 45.50, ''),
('10002', 'Mechanical Keyboard RGB', 30.00, ''),
('10003', 'Ergonomic Office Mouse', 15.25, ''),
('24505', 'Smart Fitness Watch v2', 85.00, ''), -- Used in purchase tracking sample
('40001', 'USB-C Hub Multiport', 12.00, ''),    -- Used in sales performance sample
('40002', '4K Ultra HD Monitor 27', 190.00, ''),
('.TEST_ITEM', 'Internal Dummy Product', 0.00, ''); -- Will be filtered out by NOT LIKE '.%'
-- 2. Create Simulated Local Stock Table (Mimics SB2010)
CREATE TABLE #SB2010_MOCK (
    B2_FILIAL VARCHAR(2),
    B2_LOCAL VARCHAR(1),
    B2_COD VARCHAR(15),
    B2_QATU DECIMAL(12,2),
    B2_RESERVA DECIMAL(12,2),
    D_E_L_E_T_ VARCHAR(1)
);
INSERT INTO #SB2010_MOCK VALUES 
('01', '1', '10001', 120.00, 15.00, ''), -- Branch 01, Main Local
('01', '1', '10002', 85.00, 5.00, ''),
('01', '1', '10003', 250.00, 40.00, ''),
('01', '1', '40001', 50.00, 0.00, ''),
('01', '1', '40002', 15.00, 3.00, ''),
('02', '1', '10001', 45.00, 0.00, ''),  -- Branch 02 Stock
('02', '1', '10002', 110.00, 12.00, '');
-- 3. Create Simulated Customer Master Table (Mimics SA1010)
CREATE TABLE #SA1010_MOCK (
    A1_COD VARCHAR(6),
    A1_NOME VARCHAR(40),
    A1_CGC VARCHAR(14),
    A1_PESSOA VARCHAR(1),
    A1_DDD VARCHAR(3),
    A1_TEL VARCHAR(9),
    A1_TELEX VARCHAR(9),
    A1_CONTATO VARCHAR(30),
    A1_VEND VARCHAR(3),
    A1_EST VARCHAR(2),
    A1_MUN VARCHAR(30),
    A1_ULTCOM VARCHAR(8),
    D_E_L_E_T_ VARCHAR(1)
);
INSERT INTO #SA1010_MOCK VALUES 
('C00001', 'Global Tech Solutions Europe', '12345678000199', 'J', '011', '5551234', '9995551', 'John Smith', '03', 'SP', 'Sao Paulo', '20250301', ''),
('C00002', 'Alice Global Distribution', '98765432100', 'F', '021', '5559876', '9995559', 'Alice Johnson', '01', 'RJ', 'Rio de Janeiro', '20250215', '');
-- 4. Create Simulated Sales Invoice Headers (Mimics SF2010)
CREATE TABLE #SF2010_MOCK (
    F2_FILIAL VARCHAR(2),
    F2_SERIE VARCHAR(3),
    F2_DOC VARCHAR(9),
    F2_EMISSAO VARCHAR(8),
    F2_CLIENTE VARCHAR(6),
    F2_VEND1 VARCHAR(3),
    F2_VALBRUT DECIMAL(12,2),
    D_E_L_E_T_ VARCHAR(1)
);
INSERT INTO #SF2010_MOCK VALUES 
('01', '001', '000275340', '20250210', 'C00001', '03', '1500.00', ''),
('01', '001', '000275341', '20250218', 'C00002', '03', '350.00', '');
-- 5. Create Simulated Sales Invoice Items (Mimics SD2010)
CREATE TABLE #SD2010_MOCK (
    D2_FILIAL VARCHAR(2),
    D2_SERIE VARCHAR(3),
    D2_DOC VARCHAR(9),
    D2_COD VARCHAR(15),
    D2_QUANT DECIMAL(12,2),
    D2_PRUNIT DECIMAL(12,2),
    D2_DESCON DECIMAL(12,2),
    D2_TOTAL DECIMAL(12,2),
    D_E_L_E_T_ VARCHAR(1)
);
INSERT INTO #SD2010_MOCK VALUES 
('01', '001', '000275340', '40001', 10.00, 150.00, 50.00, 1450.00, ''),
('01', '001', '000275341', '10002', 2.00, 175.00, 0.00, 350.00, '');
--- =====================================================================
--- EXAMPLE OF HOW THE PORTFOLIO QUERY RUNS USING THE MOCK TABLES Above:
--- =====================================================================
SELECT 
    B1.B1_COD AS [Product_Code],
    B1.B1_DESC AS [Description],
    SUM(B2.B2_QATU) AS [Current_Stock],
    B1.B1_CUSTD AS [Unit_Cost]
FROM 
    #SB1010_MOCK B1
LEFT JOIN 
    #SB2010_MOCK B2 ON 
        B2.B2_COD = B1.B1_COD AND 
        B2.D_E_L_E_T_ = '' AND 
        B2.B2_FILIAL = '01' AND 
        B2.B2_LOCAL = '1'
WHERE 
    B1.D_E_L_E_T_ = '' AND 
    B1.B1_DESC NOT LIKE '.%'
GROUP BY 
    B1.B1_COD, B1.B1_DESC, B1.B1_CUSTD;
-- Clean up environment
DROP TABLE #SB1010_MOCK;
DROP TABLE #SB2010_MOCK;
DROP TABLE #SA1010_MOCK;
DROP TABLE #SF2010_MOCK;
DROP TABLE #SD2010_MOCK;
