# ActiveRecord plugin for Sequel

Provides a set of features that make Sequel more compatible with code that was
written for ActiveRecord. Long-term goal is to make a near drop-in replacement
to ease the transition for projects that were previously built with ActiveRecord
as the default ORM. Individual features may be enabled / disabled when including
this plugin.

Please see the [examples](#examples) section and the [features](#features) table
below.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'sequel-active_record'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-active_record

## Examples

As with any Sequel plugin, this may be invoked on `Sequel::Model` or any of its subclasses. Specific features may be loaded by specifying an array.

```ruby
# Loads all features for all models
Sequel::Model.plugin :active_record

# Load selected features on a specific model
class Artist < Sequel::Model; end;
Artist.plugin :active_record, features: [:first, :last]

# May be called multiple times to load additional features
Artist.plugin :active_record, features: [:ordering]
```

### Default Features

When invoked without a specific array of features, the following are loaded by default:

 * `:first`
 * `:last`

## Features

| Feature | Description | ActiveRecord | Sequel |
| --- | --- | --- | --- |
| `:first` | Overrides `#first` to implicitly sort by the primary key | [`#first`](http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-first) | [`#first`](http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html#method-i-first)
| `:last` | Provides `#last!`, but leaves Sequel's `#last` intact given its intuitive sort. **Sorts differently than ActiveRecord**. | [`#last`](http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-last), [`#last!`](http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-last-21) | [`#last`](http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html#method-i-last)

## To Do

 - [ ] Write unit tests for `:last`
 - [ ] CircleCI

## Contributing

Bug reports and pull requests are certainly welcome at https://github.com/kenaniah/sequel-active_record.

I would like to grow a community around this gem, with
