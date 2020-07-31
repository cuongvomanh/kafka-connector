# kafka-connector
```
#curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d '{ "name": "product-connector", "config": { "connector.class": "io.debezium.connector.mysql.MySqlConnector", "tasks.max": "1", "database.hostname": "mariadb_product", "database.port": "3306", "database.user": "root", "database.password": "rootpass", "database.server.id": "223344", "database.server.name": "customerdbserver","table.whitelist": "product.outbox", "transforms": "outbox", "transforms.outbox.type" :"io.debezium.transforms.outbox.EventRouter", "database.history.kafka.bootstrap.servers": "kafka:9092", "database.history.kafka.topic":"dbhistory.productdb", "transforms.outbox.table.fields.additional.placement" : "id:envelope:id"  } }'
curl -X DELETE http://localhost:8083/connectors/product-connector
mysql -h 127.0.0.1 -uroot --port 3307 -prootpass < init.sql
mysql -h 127.0.0.1 -uroot --port 3308 -prootpass < init.sql

mysql -h 127.0.0.1 -uroot --port 3307 -prootpass < product.sql
mysql -h 127.0.0.1 -uroot --port 3308 -prootpass < order.sql
curl -H "Accept:application/json" localhost:8083/
curl -H "Accept:application/json" localhost:8083/connectors/
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d '@./connector.json'
curl GET localhost:8083/connectors/product-connector/status
./kafka-topics.sh --list --zookeeper 127.0.0.1:2181

mysql -h 127.0.0.1 -uroot --port 3307 -prootpass < insert_product.sql
./kafka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic outbox.event.ProductInfo --from-beginning

```

mkdir -p ./zookeeper/data
mkdir -p ./zookeeper/txns
mkdir -p ./zookeeper/logs
mkdir -p ./zookeeper/conf
mkdir -p ./kafka/data
mkdir -p ./kafka/config
mkdir -p ./kafka/logs
mkdir -p ./kafka/connect

mkdir -p mariadb_product/datadir
mkdir -p ./mariadb_product/config/
touch ./mariadb_product/config/custom_my.cnf

mkdir -p mariadb_order/datadir
mkdir -p ./mariadb_order/config/
touch ./mariadb_order/config/custom_my.cnf
mkdir -p ./mongodb2/persist




