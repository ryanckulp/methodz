# Methodz

Simple utility to lookup object methods by partial name match or type.

```rb
user = User.last

# returns methods for this class only (ignores Object.methods, ActiveModel::Dirty, and attribute getter/setters)
user.methodz

# returns methods with 'stripe' partial match in definition
user.methodz('stripe')

# returns public methods with 'stripe' partial match
user.methodz(q: 'stripe', type: 'public')

# returns protected methods with 'pass' partial match (ie 'password_reset!')
user.methodz(q: 'password', type: 'protected')

# returns private methods with 'customer' partial match
user.methodz(q: 'customer', type: 'private')
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add methodz

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install methodz

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ryanckulp/methodz.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
