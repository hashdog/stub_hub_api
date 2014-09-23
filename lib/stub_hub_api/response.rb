#api exception
class ApiException < StandardError;end

module Faraday
  class Response::StubHub < Response::Middleware
    def parse_body(body)
      JSON.load(body)
    end

    def check_status(env)
      status = env[:status].to_s
      body   = env[:body]
      if status =~ /^5/
        raise ApiException.new({status: status, body: body})
      elsif status =~ /^4/
        raise ApiException.new({status: status, body: body})
      end
    end

    def call(environment)
      @app.call(environment).on_complete do |env|
        check_status(env)
        env[:body] = parse_body(env[:body])
      end
    end

  end
end
