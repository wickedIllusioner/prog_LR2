SELECT threat_name, threat_type, risk_level 
FROM public.threat_catalog 
WHERE risk_level > 7;