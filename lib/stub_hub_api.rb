require 'json'
require 'faraday'

require_relative 'stub_hub_api/version'
require_relative 'stub_hub_api/response'
require_relative 'stub_hub_api/base'
require_relative 'stub_hub_api/login'
require_relative 'stub_hub_api/account_management'
require_relative 'stub_hub_api/account_management_sale'
require_relative 'stub_hub_api/event'
require_relative 'stub_hub_api/listing'


module StubHubApi;end

#this made full response
# r= StubHubApi::Login.new(consumer_key: 'riQoorTrNuGcZjLzco4sicQepasa',
#                       consumer_secret: 'GL7jzI9P4dmCNmnHkLRHcOp7byQa',
#                       username: 'maurotorres@gmail.com',
#                       password: 'hashdog1000')

# puts r.account
# puts r.user_id

# r = StubHubApi::AccountManagement.new("323fb2d1e2af18f057b2cd7329a0b627")
# #puts r.get_listing('0347D80588EB3470E05400212868BB17', includeFees: true)
# puts r.get_listings('0347D80588EB3470E05400212868BB17')


#r = StubHubApi::AccountManagementSale.new("323fb2d1e2af18f057b2cd7329a0b627")
#puts r.get_listing('0347D80588EB3470E05400212868BB17', includeFees: true)
#puts r.get_sales('0347D80588EB3470E05400212868BB17')



#r = StubHubApi::Event.new("323fb2d1e2af18f057b2cd7329a0b627")
#puts r.get_listing('0347D80588EB3470E05400212868BB17', includeFees: true)
#puts r.get_event('1')


# r = StubHubApi::Listing.new("323fb2d1e2af18f057b2cd7329a0b627")
# res = r.create({"listing"=>{"event"=>{"name"=>"Fall Out Boy with Panic At the Disco", "date"=>"2013-09-21T19 =>00 =>00-0700", "venue"=>"America's Cup Pavilion", "city"=>"San Francisco, CA"}, "pricePerTicket"=>{"amount"=>12, "currency"=>"USD"}, "quantity"=>6, "splitOption"=>"NONE"}})
# puts res.body.inspect


# r = StubHubApi::Listing.new("323fb2d1e2af18f057b2cd7329a0b627")
# res = r.delete("1111")
# puts res.body.inspect


r = StubHubApi::Listing.new(token: "323fb2d1e2af18f057b2cd7329a0b627", sandbox: true)
res = r.update("111",{"listing"=>{"event"=>{"name"=>"Fall Out Boy with Panic At the Disco", "date"=>"2013-09-21T19 =>00 =>00-0700", "venue"=>"America's Cup Pavilion", "city"=>"San Francisco, CA"}, "pricePerTicket"=>{"amount"=>12, "currency"=>"USD"}, "quantity"=>6, "splitOption"=>"NONE"}})
puts res.body.inspect

