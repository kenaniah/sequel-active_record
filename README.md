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

Coming soon...

## Features

| Feature | Description | ActiveRecord | Sequel |
| --- | --- | --- | --- |
| `:first` | Overrides `#first` to implicitly sort by the primary key | [`#first`](http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-first) | [`#first`](http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html#method-i-first)
| `:last` | Provides `#last!`, but leaves Sequel's `#last` intact given its more intuitive sort | [`#last`](http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-last), [`#last!`](http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-last-21) | [`#last`](http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html#method-i-last)

## Contributing

Bug reports and pull requests are certainly welcome at https://github.com/kenaniah/sequel-active_record.

I would like to grow a community around this gem, with
