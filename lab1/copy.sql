COPY Models FROM '/usr/local/postgres/models.csv' DELIMITER ';' CSV HEADER;

COPY Production FROM '/usr/local/postgres/production.csv' DELIMITER ';' CSV HEADER;

COPY Routes FROM '/usr/local/postgres/routes.csv' DELIMITER ';' CSV HEADER;

COPY Service FROM '/usr/local/postgres/service.csv' DELIMITER ';' CSV HEADER;

COPY Trains FROM '/usr/local/postgres/trains.csv' DELIMITER ';' CSV HEADER;