CREATE TABLE Models (
    id int,
    name text,
    version int,
    places int,
    speed int
);

CREATE TABLE Production (
    id int,
    city text,
    name text,
    start_year int,
    end_year int
);

CREATE TABLE Routes (
    id int,
    city1 text,
    city2 text,
    cost int,
    is_active boolean
);

CREATE TABLE Service (
    id int,
    city text,
    name text,
    start_year int,
    end_year int
);

CREATE TABLE Trains (
    id int,
    model int,
    produced int,
    route int,
    serve int,
    prod_year int,
    status text
);
