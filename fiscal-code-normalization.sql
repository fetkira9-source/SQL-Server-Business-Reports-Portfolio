# ERP Data Cleansing and Fiscal Code Standardization

## Description

This project demonstrates SQL Server data maintenance procedures used to improve data quality, standardize fiscal codes, and prepare transactional information for regulatory reporting.

### Skills Demonstrated

* SQL Server
* Data Cleansing
* ERP Data Maintenance
* Fiscal Data Standardization
* Data Quality Management
* Batch Updates

```sql
-- Archive invalid purchase transactions

UPDATE PurchaseInvoices
SET RecordStatus = 'Archived'
WHERE EntryDate BETWEEN '2026-03-01' AND '2026-03-31'
  AND (
        DocumentSeries IN ('RT', 'PR', 'RT2', 'PR2')
        OR DocumentType = 'PurchaseReturn'
      );

-- Mark valid transactions as processed

UPDATE PurchaseInvoices
SET AccountingStatus = 'Processed'
WHERE EntryDate BETWEEN '2026-03-01' AND '2026-03-31'
  AND RecordStatus = 'Active';

-- Archive fiscal transaction records

UPDATE FiscalTransactions
SET RecordStatus = 'Archived'
WHERE EntryDate BETWEEN '2026-03-01' AND '2026-03-31'
-- Fiscal code normalization

UPDATE PurchaseInvoices
SET FiscalCode = '1949'
WHERE FiscalCode = '1.949';

UPDATE FiscalTransactions
SET FiscalCode = '1949'
WHERE FiscalCode = '1.949';

UPDATE PurchaseItems
SET FiscalCode = '1949'
WHERE FiscalCode = '1.949';

UPDATE PurchaseInvoices
SET FiscalCode = '2949'
WHERE FiscalCode = '2.949';

UPDATE FiscalTransactions
SET FiscalCode = '2949'
WHERE FiscalCode = '2.949';

UPDATE PurchaseItems
SET FiscalCode = '2949'
WHERE FiscalCode = '2.949';

UPDATE SalesInvoices
SET FiscalCode = '5949'
WHERE FiscalCode = '5.949';

UPDATE FiscalTransactions
SET FiscalCode = '5949'
WHERE FiscalCode = '5.949';

UPDATE SalesItems
SET FiscalCode = '5949'
WHERE FiscalCode = '5.949';
```
