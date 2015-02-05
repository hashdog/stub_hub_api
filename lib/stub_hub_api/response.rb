#api exception
class ApiException < StandardError;end

#monkey patch for json
module JSON
  def self.is_json?(foo)
    begin
      return false unless foo.is_a?(String)
      JSON.parse(foo).all?
    rescue JSON::ParserError
      false
    end
  end
end


module Faraday
  class Response::StubHub < Response::Middleware
    def parse_body(body)
      if JSON.is_json?(body)
        JSON.parse(body)
      else
        Nokogiri::XML(body)
      end
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
