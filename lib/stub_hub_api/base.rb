module StubHubApi
  class Base
    attr_reader :token, :sandbox

    def initialize(token:, sandbox:)
      @token   = token
      @sandbox = sandbox
    end

    def get_query_api url, options
      session.get(make_request_url(url, options)).body
    end

    def post_query_api url, payload = false, options
      if payload
        session.post do |req|
          req.url url
          req.headers['Content-Type'] = 'application/json'
          req.body = options.to_json
        end.body
      else
        session.post(url, builder_options(options)).body
      end
    end

    def post_multi_part_query_api url, options, file_path
      session.post do |req|
        req.url make_request_url(url, options)
        req.headers['Content-Type'] = 'multipart/form-data'
        req.body = {}
        req.body[:file] = Faraday::UploadIO.new(open(file_path).path, 'application/pdf')
      end.body
    end

    def delete_query_api url
      session.delete(make_request_url(url, {})).body
    end

    def put_query_api url, payload = false, options
      if payload
        session.put do |req|
          req.url url
          req.headers['Content-Type'] = 'application/json'
          req.body = options.to_json
        end.body
      else
        session.put(url, builder_options(options)).body
      end
    end

    private

    def sandbox_base_url
      'https://api.stubhubsandbox.com'
    end

    def base_url
      'https://api.stubhub.com'
    end

    def current_base_url
      sandbox ? sandbox_base_url : base_url
    end

    def make_request_url url, options
      "#{url}#{builder_options(options)}"
    end

    def builder_options options
      options.any? ? "?#{to_query(options)}" : ''
    end

    def to_query(options)
      Faraday::Utils.build_nested_query(options)
    end

    def session
      return @connection if @connection

      @connection = ::Faraday.new current_base_url, ssl: {verify: false} do |conn|
        conn.use Faraday::Response::StubHub
        conn.request  :url_encoded
        conn.request  :multipart
        conn.response :logger
        conn.adapter  Faraday.default_adapter
      end
      @connection.authorization :Bearer, token
      @connection
    end

  end
end
