# StubHubApi

This gem provides access to add, edit and delete listings appearing on StubHub.

## Installation

Add this line to your application's Gemfile:

    gem 'stub_hub_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stub_hub_api

## Usage

### Get credentials account

    client = StubHubApi::Login.new(consumer_key: 'consumer_key',
                              consumer_secret: 'consumer_secret',
                              username: 'username',
                              password: 'password')

    client.account
    client.user_id

### Account Management
    client = StubHubApi::AccountManagement.new("token")
    client.get_listing('user_id', options)
    client.get_listings('user_id')

### Account Management Sales
    client = StubHubApi::AccountManagementSale.new("token")
    client.get_sales(user_id, options)

### Listing
    client = StubHubApi::Listing.new("token")
    client.create(options)
    client.create_with_barcode(options)
    client.delete(listing_id)
    client.update(listing_id, options)
    client.show(listing_id, options)

### Search
    client = StubHubApi::Search.new("token")
    client.listing(options)
    client.section(options)
    client.event(options)

### Alerts
    client = StubHubApi::Alert.new("token")
    client.delete(user_id, alert_id)
    client.update(user_id, options)
    client.show(user_id, alert_id, options)


## Contributing

1. Fork it ( https://github.com/hashdog/stub_hub_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
