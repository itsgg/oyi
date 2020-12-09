# Oyi

Ruby library for https://oyindonesia.com/ APIs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oyi'
```

And then execute:

```bash
bundle install
````

Or install it yourself as:

```bash
gem install oyi
```

## Development 

### Running the tests

```bash
rake spec
```
### Generate Documentation
```bash
rake yard
```
## Usage

### Configure the client

For the request params and responses please refer https://api-docs.oyindonesia.com/

```ruby
Oyi::Client.configure(api_url: 'url', api_username: 'username', api_key: 'api_key')
```

### Account Methods

Get beneficiery account details
```ruby
Oyi::Account.inquiry(params)
```

### Disbursement Methods

Get beneficiary account details
```ruby
Oyi::Disbursement.inquiry(params)
```

Start disbursing money to a specific amount
```ruby
Oyi::Disbursement.remit(params)
```

Get status of a disbursement request
```ruby
Oyi::Disbursement.remit_status(params)
```

Get partner balance
```ruby
Oyi::Disbursement.balance
```

Create a scheduled disbursement
```ruby
Oyi::Disbursement.schedule_remit(params)
```

Get the details of a scheduled remit
```ruby
Oyi::Disbursement.schedule_remit_details(params)
```

Get a list of all scheduled remits
```ruby
Oyi::Disbursement.list_scheduled_remit(params)
```

Delete a scheduled remit
```ruby
Oyi::Disbursement.cancel_scheduled_remit(params)
```

Retry a scheduled remit
```ruby
Oyi::Disbursement.retry_scheduled_remit(params)
```

### Virtual Account Methods

Create a new VA number
```ruby
Oyi::VirtualAccount.create(params)
```

Get VA details
```ruby
Oyi::VirtualAccount.get(id)
```

Update existing VA
```ruby
Oyi::VirtualAccount.update(id, params)
```

Get all VAs
```ruby
Oyi::VirtualAccount.all(params)
```

Get all transactions for a VA
```ruby
Oyi::VirtualAccount.transaction(id, params)
```

### Acceptance Methods

Create a payment checkout URL
```ruby
Oyi::Acceptance.payment_checkout(params)
```

Create a payment checkout URL with addtional details for invoicing
```ruby
Oyi::Acceptance.create_invoice(params)
```

Get the status of a transaction
```ruby
Oyi::Acceptance.status(params)
```

Delete a payment/invoice link
```ruby
Oyi::Acceptance.delete(params)
```

Get the details of a payment/invoice link
```ruby
Oyi::Acceptance.get(params)
```
