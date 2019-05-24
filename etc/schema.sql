-- bolivar.db - a database describing the bolivar corpus

-- Alejandro & Eric
-- May 24, 2019 - first cut


-- documents
CREATE TABLE documents (

	filename   TEXT,
	did        TEXT,
	date       TEXT,
	addressee  TEXT,
	place      TEXT,
	type       TEXT

);

