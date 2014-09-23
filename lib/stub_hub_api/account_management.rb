module StubHubApi
  class AccountManagement < Base
    def get_listing(listing_id, options = {})
      get_query_api("/accountmanagement/listings/v1/#{listing_id}", options)
    end

    def get_listings(user_id, options = {})
      get_query_api("/accountmanagement/listings/v1/seller/#{user_id}", options)
    end
  end
end
