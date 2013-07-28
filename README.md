[![Build Status](https://travis-ci.org/chatgris/Gaston.png?branch=master)](https://travis-ci.org/chatgris/Gaston)

# GASTON

Gaston is a dead simple Ruby config store. Write your config in yaml files, and
retrieve it through one Gaston.

## Installation

Ruby 1.9.2 is required.

Install it with rubygems:

    gem install gaston

With bundler, add it to your `Gemfile`:

``` ruby
gem "gaston"
```

Within a rails project, run the following command:

``` bash
rails g gaston:config
```

Otherwise, create an initializer. You can define an environment with the `env`
method, and specify config files with the `files` method. Default `env` is
`:development`.

``` ruby
Gaston.configure do |gaston|
  gaston.env = Rails.env
  gaston.files = Dir[Rails.root.join("config/gaston/**/*.yml")]
end
```

## Usage

Always specify environment in yaml :

Environment values are merged on `:gaston` values. `:gaston` is optional.

You can use erb inside values.

``` yaml
:gaston:
  api:
    state: "awesome"
:development:
  api:
    key: "api_key"
:test:
  api:
    key: <%= ENV["API_KEY"] %>
```

Since verion `0.2.0`, gaston also accept json files.


Querying a config key :

``` ruby
Gaston.api.state # => 'awesome'
Gaston.api.key # => 'api_key'
```

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version
unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have
your own version, that is fine but bump version in a commit by itself in another
branch so I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## Copyright

MIT. See LICENSE for further details.
