# Thomson Reuters API Client

Uses the [Reuter's TRKD API](http://thomsonreuters.com/knowledge-direct/) to grab financial data for stocks, such as quotes, estimates and snapshots.

This gem will only work if you have been provided with valid credentials by Reuters. See below for more information about configuring your login credentials.

A dependency on Ruby >= 2.0.0 is also required, due to an issue with SSL Certificates with the Reuter' API in earlier versions.

## Installation

Add this line to your application's Gemfile:

    gem 'reuters'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reuters

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

## Contributing

If you find a bug, have a feature request or even want to contribute an enhancement or fix, please follow the contributing guidelines included in the repository.