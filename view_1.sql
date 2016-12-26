select g.id as id_grafo, p.pk_uid as pk_uid_pill
from (select gs.id,st_buffer (gs.geom, 0.01) as geom from grafo_stradale gs) g, -- calcolo un buffer sul grafo
     (select pt.pk_uid, closestpoint (l.geom, pt.geom) as geometry 
      from pti_pill pt, grafo_stradale l
      group by pt.pk_uid
      having min ( st_length(shortestline (pt.geom, l.geom)))) p -- calcolo i punti closestpoint
where st_intersects (p.geometry, g.geom) = 1 -- solo feature che si intersecano 
order by p.pk_uid -- ordino per 
