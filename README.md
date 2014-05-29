# Thomson Reuters API Client

[![Coverage Status](https://coveralls.io/repos/Stockflare/reuters/badge.png?branch=master)](https://coveralls.io/r/Stockflare/reuters?branch=master) [![Build Status](https://travis-ci.org/Stockflare/reuters.svg?branch=master)](https://travis-ci.org/Stockflare/reuters) [![Dependency Status](https://gemnasium.com/Stockflare/reuters.svg)](https://gemnasium.com/Stockflare/reuters) [![Code Climate](https://codeclimate.com/github/Stockflare/reuters.png)](https://codeclimate.com/github/Stockflare/reuters)


Uses the [Reuter's TRKD API](http://thomsonreuters.com/knowledge-direct/) to grab financial data for stocks, such as quotes, estimates and snapshots.

This gem will only work if you have been provided with valid credentials by Reuters. See below for more information about configuring your login credentials.

## Installation

Add this line to your application's Gemfile:

    gem 'reuters'

And then execute:

    $ bundle install

## Usage

This gem provides no CLI and is intended to be used in conjunction with other applications.

### Configuring Credentials

Before any API calls will work, you need to configure the library with valid credentials. Once credentials have been configured, an access token will be retrieved from the Reuter' API upon a client request.

```
Reuters.configure do |config|

  config.credentials do |login|
    # Set username
    login.username = "my_username"

    # Set my password
    login.password = "my_super_secret_password"

    # Set application ID
    login.application_id = "application_id"
  end

end
```

### Configuring Namespaces and WSDL endpoints

All the default configurations point towards the SOAP11 service that Reuters provides. In our experience, we were unable to get their SOAP 2 service working reliably.

Each class has a `#configure` method that can be used to adjust the endpoints and other attributes of the class, as shown in the example below.

```
Reuters::Namespaces::Search::Equity.configure do |c|
  c.name 'Search/A_Different_Equity_1'
end

```

### Making A Request

There are three components to each request made to the Reuter's API. The `Request` object, the `Client` and finally the `Response`. Because Reuters API calls can become quite complex it would become arduous to build a separate "helper" method for every possible variation on every possible call.

#### Building A Request

All requests to the Reuters API are XML-based. You are responsible for building the request (except for adding the "xmlns" attributes; which should be handled by the client). Every example documented below, can be nested up to n-depth. I have laid out some examples and their XML-counterparts to help you get started with the request builder.

**Note: These are only examples to help you get started with the request builder, and are not valid API Calls**

```
<Query>
  <ExchangeCode Include="true">NYSE</ExchangeCode>
</Query>
```

```
message = Reuters::Builder.new
message.query.exchange_code = "NYSE"
message.query.exchange_code include: true
```

You can also pass a block to the builder to achieve the same result:

```
message = Reuters::Builder.new do |body|
  body.query do |query|
    query.exchange_code = "NYSE"
    query.exchange_code include: true
  end
end
```

---

The builder allows you to very quickly define nested elements with attributes:

```
<This>
  <Is>
    <A>
      <Nested>
        <Element Hello="world">
        </Element>
      </Nested>
    </A>
  </Is>
</This>
```

```
message = Reuters::Builder.new
message.this.is.a.nested.element hello: "world"
```

---

The Request Builder also supports building arrays of elements with only attributes, content or both.

```
<Filter>
  <ExchangeCode Include="true">
    <StringValue Value="NSQ" Negated="false" />
    <StringValue Value="GER" Negated="true" />
    <StringValue Value="LSE" Negated="false" />
  </ExchangeCode>
</Filter>
```

```
Reuters::Builder.new do |body|
  body.filter do |filter|
    filter.exchange_code include: true do |ex|
      ex.stringValue [
        { value: "NSQ", negated: false },
        { value: "GER", negated: true },
        { value: "LSE", negated: false },
      ]
    end
  end
end
```

```
<Filter>
  <ExchangeCode Include="true">
    <StringValue Negated="false">NSQ</StringValue>
    <StringValue Negated="true">GER</StringValue>
    <StringValue Negated="false">LSE</StringValue>
  </ExchangeCode>
</Filter>
```

```
Reuters::Builder.new do |body|
  body.filter do |filter|
    filter.exchange_code include: true do |ex|
      ex.stringValue [
        { negated: false },
        { negated: true },
        { negated: false },
      ]
      ex.stringValue = ["NSQ", "GER", "LSE"]
    end
  end
end
```

The request that you build, will be sent inside the request element. So there is no need to define any header information.

```
<Body>
  <GetEquityQuote_Request_1 ...>
    <!-- Your request will appear here -->
  </GetEquityQuote_Request_1>
</Body>
```

#### Sending the Request to a Client

When you initialize a client that requires a valid access token, the client will automagically take care of obtaining a token for you when the request is sent (providing you have valid credentials configured).

```
Reuters::Credentials.configure do |c|
  c.username = "my_username"
  c.password = "my_password"
  c.app_id = "my_app_id"
end

message = Reuters::Builder.new do |body|
  ...
end

client = Reuters::Client::Search::Equity.new

client.operations #=> [:get_equity_quote_1]

client.get_equity_quote_1(message)
```

#### Using the Response

Different Response classes parse data slightly differently depending on how it is intended to be used. You will need to take a look at the documentation for the Response corresponding to your Client.


## Contributing

The Reuters API is vast and has lots of calls that each vary in complexity and usage. At the moment, we only have limited development time, so have only developed the calls that we use. 

If you would like to develop an API Call, open an issue and please feel free to ask for assistance with building it. 

If you find a bug, have a feature request or even want to contribute an enhancement or fix, please follow the contributing guidelines included in the repository.