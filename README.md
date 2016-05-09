== README
[![Codacy Badge](https://api.codacy.com/project/badge/grade/6413a59d11734abfbbe3075d0e4eb814)](https://www.codacy.com/app/twhnat/docker-CerebralCortex-Frontend)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
Postgres:

```create database cc_vermont_production with owner=cerebralcortex encoding='UTF-8' lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;```


Cassandra Init:

```
CREATE KEYSPACE cc_SITE_production WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3'}  AND durable_writes = true;

CREATE TABLE cc_SITE_production.rawdata (
    datastream_id varint,
    day text,
    datetime timestamp,
    offset int,
    sample text,
    PRIMARY KEY ((datastream_id, day), datetime)
) WITH CLUSTERING ORDER BY (datetime ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
 ```


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
