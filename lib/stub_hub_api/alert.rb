module StubHubApi
  class Alert < Base
    def create(user_id, options = {})
      post_query_api("/user/customers/v1/#{user_id}/pricealerts", true, options)
    end

    def update(user_id, options = {})
      put_query_api("/user/customers/v1/#{user_id}/pricealerts/#{alert_id}", true, options)
    end

    def delete(user_id, alert_id)
      delete_query_api("/user/customers/v1/#{user_id}/pricealerts/#{alert_id}")
    end

    def show(user_id, alert_id, options = {})
      get_query_api("/user/customers/v1/#{user_id}/pricealerts/#{alert_id}", false, options)
    end
  end
end
