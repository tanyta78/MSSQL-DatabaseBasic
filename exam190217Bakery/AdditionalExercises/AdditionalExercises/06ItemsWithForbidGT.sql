SELECT i.Name AS Item,
       i.Price,
       i.MinLevel,
       gt.Name AS [Forbidden Game Type]
FROM Items i
     LEFT JOIN GameTypeForbiddenItems gtfi ON i.Id = gtfi.ItemId
     LEFT JOIN GameTypes gt ON gtfi.GameTypeId = gt.Id
ORDER BY [Forbidden Game Type] DESC,
         Item;