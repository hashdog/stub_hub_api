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

    def post_multi_part_query_api url, options, file
      session.post do |req|
        req.url make_request_url(url, options)
        req.headers['Content-Type'] = 'multipart/form-data'
        req.body = {}
        req.body[:file] = Faraday::UploadIO.new(file, 'application/pdf')
        req.options.timeout = 2000
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

    def user_agents
      ["Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 (FM Scene 4.6.1) ",
       "Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 (.NET CLR 3.5.30729) (Prevx 3.0.5) ",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36"]
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
      @connection.headers[:user_agent] = user_agents.shuffle.first
      @connection.authorization :Bearer, token
      @connection
    end

  end
end
