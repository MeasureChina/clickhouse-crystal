# clickhouse-crystal

clickhouse for crystal-lang

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  clickhouse-crystal:
    github: measurechina/clickhouse-crystal
```

## Usage

```crystal
require "clickhouse-crystal"


# init
client = Clickhouse.connect({
  "host" => "localhost",
  "port" => "8123",
  "database" => "sensors",
})

# insert
body = [
  {
    table: "test_db.sensors",
    columns: %w(uid name date),
    data: [
      [11, "son", "2017-03-01 11:12:13"],
      [22, "park", Time.now.to_s("%F %X"),
    ],
  },
]

result = client.insert!(body)

# query
query = client.query("SELECT COUNT(1) FROM sensors")
response = query.execute!

query = client.query("SELECT * FROM sensors;")
response = query.execute!


```


## Contributors
- metacortex - creator, maintainer
