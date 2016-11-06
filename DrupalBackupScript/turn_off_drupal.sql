UPDATE variable SET value = 'i:1;' WHERE name= 'maintenance_mode';
DELETE FROM cache_bootstrap WHERE cid = 'variables';

