SELECT State, COUNT(DISTINCT CustomerId) AS UniqueCustomers
FROM customers
WHERE State IS NOT NULL
GROUP BY State
ORDER BY State ASC;