module StubHubApi
  class Event < Base
    def get_event(event_id, options = {})
      get_query_api("/catalog/events/v2/#{event_id}", options)
    end
  end
end
