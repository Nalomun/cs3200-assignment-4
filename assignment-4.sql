SELECT DISTINCT c.LastName, c.Email
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId;

SELECT al.Title AS AlbumTitle, ar.Name AS ArtistName
FROM albums al
INNER JOIN artists ar ON al.ArtistId = ar.ArtistId;

SELECT State, COUNT(DISTINCT CustomerId) AS UniqueCustomers
FROM customers
WHERE State IS NOT NULL
GROUP BY State
ORDER BY State ASC;

SELECT State, COUNT(DISTINCT CustomerId) AS UniqueCustomers
FROM customers
WHERE State IS NOT NULL
GROUP BY State
HAVING COUNT(DISTINCT CustomerId) > 10;

SELECT DISTINCT ar.Name
FROM artists ar
INNER JOIN albums al ON ar.ArtistId = al.ArtistId
WHERE LOWER(al.Title) LIKE '%symphony%';

SELECT DISTINCT ar.Name
FROM artists ar
INNER JOIN albums al ON ar.ArtistId = al.ArtistId
INNER JOIN tracks t ON al.AlbumId = t.AlbumId
INNER JOIN media_types mt ON t.MediaTypeId = mt.MediaTypeId
INNER JOIN playlist_track pt ON t.TrackId = pt.TrackId
INNER JOIN playlists p ON pt.PlaylistId = p.PlaylistId
WHERE LOWER(mt.Name) LIKE '%mpeg%'
  AND p.Name IN ('Brazilian Music', 'Grunge');

SELECT COUNT(*) AS ArtistCount
FROM (
    SELECT ar.ArtistId
    FROM artists ar
    INNER JOIN albums al ON ar.ArtistId = al.ArtistId
    INNER JOIN tracks t ON al.AlbumId = t.AlbumId
    INNER JOIN media_types mt ON t.MediaTypeId = mt.MediaTypeId
    WHERE LOWER(mt.Name) LIKE '%mpeg%'
    GROUP BY ar.ArtistId
    HAVING COUNT(t.TrackId) >= 10
) AS mpeg_artists;

SELECT
    p.PlaylistId,
    p.Name,
    ROUND(SUM(t.Milliseconds) / 3600000.0, 2) AS LengthInHours
FROM playlists p
INNER JOIN playlist_track pt ON p.PlaylistId = pt.PlaylistId
INNER JOIN tracks t ON pt.TrackId = t.TrackId
GROUP BY p.PlaylistId, p.Name
HAVING SUM(t.Milliseconds) / 3600000.0 > 2
ORDER BY LengthInHours DESC;

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