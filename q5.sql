SELECT DISTINCT ar.Name
FROM artists ar
INNER JOIN albums al ON ar.ArtistId = al.ArtistId
WHERE LOWER(al.Title) LIKE '%symphony%';