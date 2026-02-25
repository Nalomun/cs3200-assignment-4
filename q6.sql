SELECT DISTINCT ar.Name
FROM artists ar
INNER JOIN albums al ON ar.ArtistId = al.ArtistId
INNER JOIN tracks t ON al.AlbumId = t.AlbumId
INNER JOIN media_types mt ON t.MediaTypeId = mt.MediaTypeId
INNER JOIN playlist_track pt ON t.TrackId = pt.TrackId
INNER JOIN playlists p ON pt.PlaylistId = p.PlaylistId
WHERE LOWER(mt.Name) LIKE '%mpeg%'
  AND p.Name IN ('Brazilian Music', 'Grunge');