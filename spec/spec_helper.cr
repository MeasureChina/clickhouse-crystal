require "spec"
require "../src/clickhouse"

TEST_DB_NAME = "test"
TEST_DB_TABLE = "sensors"
TEST_DB_OPTS = {
  "host" => "localhost",
  "port" => "8123",
  "database" => TEST_DB_NAME,
}

def create_test_db!
  drop_test_db!

  Process.run "clickhouse-client --query 'CREATE TABLE #{TEST_DB_NAME}.#{TEST_DB_TABLE} (time Date, session_id String, url String, count Int64) ENGINE = ReplacingMergeTree(time, (session_id, url), 8192)'", shell: true
end

def drop_test_db!
  Process.run "clickhouse-client --query 'DROP TABLE #{TEST_DB_NAME}.#{TEST_DB_TABLE}'", shell: true
end
