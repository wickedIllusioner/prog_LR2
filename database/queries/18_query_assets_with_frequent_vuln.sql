WITH AssetVulns AS (
    SELECT asset_id, COUNT(*) AS v_count 
    FROM public.vulnerability_asset GROUP BY asset_id
)
SELECT a.hostname, av.v_count
FROM AssetVulns av
JOIN public.asset a ON av.asset_id = a.id
WHERE av.v_count > (SELECT AVG(v_count) FROM AssetVulns);