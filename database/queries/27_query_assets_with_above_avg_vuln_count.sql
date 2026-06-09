WITH ActiveVulns AS (
    SELECT asset_id, COUNT(*) AS count 
    FROM public.vulnerability_asset 
    WHERE status != 'Закрыта' 
    GROUP BY asset_id
)
SELECT a.hostname, av.count 
FROM ActiveVulns av
JOIN public.asset a ON av.asset_id = a.id
WHERE av.count > (SELECT AVG(count) FROM ActiveVulns);