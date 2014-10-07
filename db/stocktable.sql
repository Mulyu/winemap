load data local infile "db/seed_csv/wines_winevarieties.csv" into table wines_winevarieties fields terminated by ',';
load data local infile "db/seed_csv/situations_wines.csv" into table situations_wines fields terminated by ',';
load data local infile "db/seed_csv/localregions_wines.csv" into table localregions_wines fields terminated by ',';