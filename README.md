GASTON
======

Gaston is a dead simple Ruby config store. Write your config in yaml files, and retrieve it through one Gaston.

Installation
------------

Install it with rubygems:

    gem install gaston

With bundler, add it to your `Gemfile`:

``` ruby
gem "gaston", "~>0.0.1"
```

Always specify environment in yaml :

``` yaml
:development:
  api:
    key: "api_key"
:test:
  api:
    key: "prod_api_key"
```

Create an initializer. You can define an environment with the `env` method, and specify config files with the `files` method. Default `env` is `:development`.

``` ruby
Gaston.configure do |config|
  config.env = Rails.env
  config.files = Dir[Rails.root.join("config/gaston/**/*.yml")]
end
Config = Gaston.retrieve
```

Querying a config key :

``` ruby
Config.db.user
```

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself in another branch so I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


Copyright
---------

MIT. See LICENSE for further details.
