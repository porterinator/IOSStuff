PRAGMA auto_vacuum = 1;

CREATE TABLE niche (
    id INTEGER PRIMARY KEY, 
    name TEXT,
    resource_uri TEXT,
    slug TEXT,
    wishlist_count INTEGER,
    nowreading_count INTEGER,
    read_count INTEGER
);