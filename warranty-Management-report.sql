SELECT
    W.ProtocolNumber,
    W.CustomerID,
    P.ProductCode,
    P.ProductName,
    P.ProductCost,
    W.InvoiceSeries,
    W.InvoiceNumber,
    W.TransactionDate
FROM WarrantyTransactions W
INNER JOIN Products P
    ON W.ProductCode = P.ProductCode
WHERE
    W.TransactionDate >= '2024-01-01'
    AND W.TransactionType = 'WarrantyInspection'
    AND W.Status <> 'Cancelled'
    AND W.ProtocolNumber NOT IN
    (
        SELECT ProtocolNumber
        FROM WarrantyTransactions
        WHERE TransactionType = 'WarrantyClosed'
    )
ORDER BY
    W.ProtocolNumber;
