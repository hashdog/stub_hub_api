module StubHubApi
  class Fulfillment < Base
    def upload_pdf(file_path, sale_id, options)
      doc       = post_multi_part_query_api("/fulfillment/pdf/v1/sale/#{sale_id}", options, file_path)
      fields    = %w(orderId row seatNo uploadStatus delivered)
      response  = {}
      doc.xpath("uploadPDFTicketToOrderResponse").each do |xml|
        fields.each do |field|
          response[field] = xml.at_xpath(field).content if xml.at_xpath(field).content
        end
      end
      response
    end

    def preload_pdf(file_path, listing_id, options)
      doc       = post_multi_part_query_api("/fulfillment/pdf/v1/listing/#{listing_id}", options, file_path)
      fields    = %w(listingId row seat uploadStatus preDelivered)
      response  = {}
      doc.xpath("uploadPDFTicketToListingResponse").each do |xml|
        fields.each do |field|
          response[field] = xml.at_xpath(field).content if xml.at_xpath(field).content
        end
      end
      response
    end
  end
end
