SELECT
    c.FirstName || ' ' || c.LastName AS CustomerName,
    c.Country,
    ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS TotalSpent,
    RANK() OVER (
        PARTITION BY c.Country
        ORDER BY SUM(ii.UnitPrice * ii.Quantity) DESC
    ) AS SpendingRank,
    ROUND(SUM(SUM(ii.UnitPrice * ii.Quantity)) OVER (
        PARTITION BY c.Country
        ORDER BY SUM(ii.UnitPrice * ii.Quantity) DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS RunningCountryRevenue
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
INNER JOIN invoice_items ii ON i.InvoiceId = ii.InvoiceId
GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country
ORDER BY c.Country, SpendingRank;