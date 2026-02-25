SELECT DISTINCT c.LastName, c.Email
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId;