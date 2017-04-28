require "http/client"

module Clickhouse
  class Query
    @client : Client
    @query_str : String
    @query_opts : OptionType
    property format : String = "JSONCompact"

    def initialize(@client, @query_str, @query_opts = OptionType.new)
    end

    def execute!
      headers = HTTP::Headers.new
      headers.add "Content-Type", "application/x-www-form-urlencoded"

      # if @client.has_auth_token?
      #   headers.add "Authorization", "Token #{@client.get_auth_token}"
      # end

      http = HTTP::Client.new(@client.get_host, @client.get_port)

      body = "#{@query_str} FORMAT #{@format}"

      response = http.post("/", headers, body)
      response.body
      # puts response.body
      # puts response.body.class
      # puts response.status_code
      # puts response.success?

      # response_json = JSON.parse(response.body) rescue nil
      # if response_json && response_json["error"]?
      #   raise QueryError.new(message: response_json["error"].as_s)
      # end
      #
      # if response_json.nil? || response.status_code != 200
      #   raise Error.new(message: "HTTP ERROR (#{response.status_code}): #{response.body[0..128]}")
      # end
      #
      # response_json["results"]
    end

    def to_sql
      @query_str.strip
    end

  end
end
