SELECT DISTINCT
    P.ProductCode,
    P.ProductName,
    S.InvoiceDate,
    S.InvoiceSeries,
    S.InvoiceNumber,
    SI.Quantity,
    S.TotalAmount,
    P.Cost
FROM Products P
INNER JOIN SalesItems SI
    ON SI.ProductCode = P.ProductCode
INNER JOIN SalesInvoices S
    ON S.InvoiceNumber = SI.InvoiceNumber
WHERE
    S.SalesRepresentative = 'Representative A'
    AND S.InvoiceDate BETWEEN '2025-09-01' AND '2025-09-30'
    AND S.TotalAmount > 1
ORDER BY
    S.InvoiceNumber,
    P.ProductCode;
