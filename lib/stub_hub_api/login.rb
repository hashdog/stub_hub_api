module StubHubApi
  class Login < Base
    attr_reader :response

    def initialize(consumer_key:, consumer_secret:, username:, password:)
      @consumer_key     = consumer_key
      @consumer_secret  = consumer_secret
      @username         = username
      @password         = password
      init
    end

    def full_response
      response
    end

    def user_id
      response.headers['x-stubhub-user-guid']
    end

    def account
      response.body
    end

    private
    def session
      return @conn if @conn

      @conn = Faraday.new(:url => base_url, :ssl => {:verify => false}) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
      @conn.basic_auth(@consumer_key, @consumer_secret)
      @conn
    end

    def init
      @response = session.post '/login', { grant_type: 'password', username: @username, password: @password}
    end
  end
end
