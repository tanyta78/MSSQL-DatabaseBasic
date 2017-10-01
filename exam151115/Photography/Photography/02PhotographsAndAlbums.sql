SELECT Photographs.Title,Albums.Name FROM Photographs
JOIN AlbumsPhotographs ON Photographs.Id=AlbumsPhotographs.PhotographId
JOIN Albums ON AlbumsPhotographs.AlbumId=Albums.Id
ORDER BY Albums.Name,Photographs.Title DESC