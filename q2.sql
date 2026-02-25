SELECT al.Title AS AlbumTitle, ar.Name AS ArtistName
FROM albums al
INNER JOIN artists ar ON al.ArtistId = ar.ArtistId;