use order;
CREATE TABLE outbox (
    id varchar(50) PRIMARY KEY,
    aggregatetype varchar(255),
    aggregateid varchar(255),
    type varchar(255),
    payload TEXT
);
