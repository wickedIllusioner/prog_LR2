WITH AssetVulnStat AS (
    SELECT asset_id, COUNT(*) AS v_cnt FROM public.vulnerability_asset GROUP BY asset_id
),
AssetThreatStat AS (
    SELECT va.asset_id, COUNT(DISTINCT ic.threat_id) AS t_cnt
    FROM public.incident i
    JOIN public.incident_vulnerability iv ON i.id = iv.incident_id
    JOIN public.vulnerability_asset va ON iv.vulnerability_asset_id = va.id
    JOIN public.incident_indicator ii ON i.id = ii.incident_id
    JOIN public.indicator_compromise ic ON ii.ioc_id = ic.id
    GROUP BY va.asset_id
),
ProblemAssets AS (
    SELECT av.asset_id
    FROM AssetVulnStat av
    JOIN AssetThreatStat at ON av.asset_id = at.asset_id
    WHERE av.v_cnt > (SELECT AVG(v_cnt) FROM AssetVulnStat) 
      AND at.t_cnt > (SELECT AVG(t_cnt) FROM AssetThreatStat)
)
SELECT DISTINCT i.id, i.title, a.hostname
FROM public.incident i
JOIN public.incident_vulnerability iv ON i.id = iv.incident_id
JOIN public.vulnerability_asset va ON iv.vulnerability_asset_id = va.id
JOIN public.asset a ON va.asset_id = a.id
WHERE a.id IN (SELECT asset_id FROM ProblemAssets);