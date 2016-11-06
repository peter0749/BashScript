UPDATE variable SET value = 'i:0;' WHERE name= 'maintenance_mode';
DELETE FROM cache_bootstrap WHERE cid = 'variables';

