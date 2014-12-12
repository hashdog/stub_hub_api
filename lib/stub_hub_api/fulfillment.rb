module StubHubApi
  class Fulfillment < Base
    def upload_pdf(file_path, sale_id, options)
      post_multi_part_query_api("/fulfillment/pdf/v1/sale/#{sale_id}", options, file_path)
    end
  end
end
