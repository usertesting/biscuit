# Biscuit

This gem is a Ruby wrapper around `@dcoker`'s [biscuit library](https://github.com/dcoker/biscuit), a multi-region HA key-value store for your AWS infrastructure secrets.

By using this Ruby library, it is easy to integrate into a Ruby/Rails stack.

## Installation

- Add this line to your application's Gemfile:

    ```ruby
    gem 'biscuit'
    ```

- And then run `bundle`.

- `touch` a yaml file (or multiple for different environments).

## Usage

### Loading K/V pairs into a hash

```ruby
secrets_file = "some_yaml_file.yaml"
SECRETS = Biscuit::SecretsDecrypter.new(secrets_file).load

puts SECRETS["some_password"]
# => "decrypted password"
```

### Loading into ENV Vars

If you store config in ENV vars as suggested by the [12 Factor App](https://12factor.net/config), you can load your AWS encrypted secrets into ENV vars like this:

```ruby
secrets_file = "some_yaml_file.yaml"
Biscuit::SecretsDecrypter.new(secrets_file).load do |key, value|
  ENV[key] = value
end
```

This approach pairs with [dotenv](https://github.com/bkeepers/dotenv) really well - dotenv for test/development, and biscuit for staging/production environments.

#### With Rails

Load your secrets in `application.rb`, between loading Rails/bundler, before the Application config starts:

```ruby
require "rails/all"

...

Bundler.require(*Rails.groups)

...

# Add in your biscuit loading here:
secrets_file = "#{__dir__}/secrets/#{Rails.env}.yml"
if File.exist?(secrets_file) # You can also check things like if Rails.env.production?
  Biscuit::SecretsDecrypter.new(secrets_file).load do |key, value|
    ENV[key] = value
  end
end

...

module MyApp
  class Application < Rails::Application
    ....
```

#### Adding a new key

From the application root, run `biscuit put -f`, followed by the path to the yaml you want to encrypt in, followed by the key, followed by the example.

```bash
$ biscuit put -f config/secrets/production.yml SECRET_KEY "sensitive value"
```

#### Getting a key (CLI)

```bash
$ biscuit export -f config/secrets/production.yml | grep "SECRET_KEY"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/biscuit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
