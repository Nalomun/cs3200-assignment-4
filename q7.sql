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