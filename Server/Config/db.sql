CREATE TABLE IF NOT EXISTS articles(
        id serial PRIMARY KEY,
        created timestamp NOT NULL,
        content text NOT NULL,
        title text NOT NULL
        );

GRANT ALL ON articles TO postgres;
