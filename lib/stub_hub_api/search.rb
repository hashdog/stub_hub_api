module StubHubApi
  class Search < Base
    def listing(options = {})
      get_query_api("/search/inventory/v1", options)
    end

    def section(options = {})
      get_query_api("/search/inventory/v1/sectionsummary", options)
    end

    def event(options = {})
      get_query_api("/search/catalog/events/v2", options)
    end
  end
end
