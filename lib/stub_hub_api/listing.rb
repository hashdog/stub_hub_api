module StubHubApi
  class Listing < Base
    def create(options = {})
      post_query_api("/inventory/listings/v1", true, options)
    end

    def create_with_barcode(options = {})
      post_query_api("/inventory/listings/v1/barcodes", true, options)
    end

    def delete(listing_id)
      delete_query_api("/inventory/listings/v1/#{listing_id}")
    end

    def update(listing_id, options = {})
      put_query_api("/inventory/listings/v1/#{listing_id}", true, options)
    end

    def show(listing_id, options = {})
      get_query_api("/inventory/listings/v1/#{listing_id}", options)
    end

  end
end
