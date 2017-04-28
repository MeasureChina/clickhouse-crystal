require "./spec_helper"

describe Clickhouse do
  # create_test_db!

  it "query" do
    client = Clickhouse.connect({
      "host" => "localhost",
      "port" => "8123",
      "database" => "sensors",
    })
    client.should_not be_nil

    data = [
      ["2017-03-01", "123", "http://naver.com", "1"],
      [Time.now.to_s("%F"), "a38", "http://sonjw.com", "2"],
      ["2017-03-09", "2a3f", "http://google.com", "1"],
    ]
    result = client.insert!("#{TEST_DB_NAME}.#{TEST_DB_TABLE}", %w(time session_id url count), data)

    result.should be_true

    #
    query = client.query("SELECT * FROM #{TEST_DB_NAME}.#{TEST_DB_TABLE}")
    response = query.execute!
    
  end

  # drop_test_db!
end
