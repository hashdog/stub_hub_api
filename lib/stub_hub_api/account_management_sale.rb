module StubHubApi
  class AccountManagementSale < Base
    def get_sales(user_id, options = {})
      get_query_api("/accountmanagement/sales/v1/seller/#{user_id}", options)
    end
  end
end
