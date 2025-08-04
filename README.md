# MoScopes

**Not ready for use.** Still a work in progress.

## Outline

MoScopes automatically generates common database scopes for ActiveRecord models based on attribute types. Instead of writing repetitive scope methods (and their tests!), simply include the appropriate scope modules and get instant access to standardized query methods.

E.g. Setting MoScopes on a model like this one:

```ruby
class Event < ApplicationRecord
  include MoScopes::NumericScopes.new(:price)
  include MoScopes::DateScopes.new(:starts_at)
  include MoScopes::EnumScopes.new(:status)

  enum :status, [:pending, :approved, :rejected]
end
```

would give you scopes like these:

```ruby
# Numeric scopes
Event.price_gt(50)                   # Events with price > 50
Event.price_between(25, 100)         # Events with price between 25-100


# Date scopes
Event.starts_at_after(1.week.ago)    # Events starting after last week
Event.starts_at_between(today, next_month)

# Enum scopes
Event.status_is(:approved)            # Approved events
Event.status_is_any(:pending, :approved)
```

## String Scopes

**PERFORMANCE warning** These scopes use LIKE and ILIKE and as such not performant on large tables as
they can't use regular indexes effectively. Consider utlising database specific solutions
(Postgres trigram indexes / full text search) or use a specialised search tool such as Elasticsearch.

```
include MoScopes::StringScopes.new(:title)

Event.title_starting("The")
Event.title_containing("he en")
Event.title_ending("end")

# scopes are case insensitive by default. Pass true for case sensitive searches
Event.title_starting("The", true)
```

## Numeric Scopes

```
include MoScopes::NumericScopes.new(:price)

Event.price_eq(50)                   # Events with price = 50
Event.price_lt(100)                  # Events with price < 100
Event.price_lte(100)                 # Events with price <= 100
Event.price_gt(25)                   # Events with price > 25
Event.price_gte(25)                  # Events with price >= 25
Event.price_between(25, 100)         # Events with price between 25-100 (exclusive)
Event.price_between_or_equal(25, 100) # Events with price between 25-100 (inclusive)
```

## Date Scopes

```
include MoScopes::DateScopes.new(:starts_at)

Event.starts_at_before(1.week.from_now)      # Events starting before next week
Event.starts_at_before_or_at(1.week.from_now) # Events starting before or at next week
Event.starts_at_after(1.week.ago)            # Events starting after last week
Event.starts_at_after_or_at(1.week.ago)      # Events starting after or at last week
Event.starts_at_between(today, next_month)   # Events starting between today and next month (exclusive)
Event.starts_at_between_or_at(today, next_month) # Events starting between today and next month (inclusive)
Event.starts_at_is_nil                       # Events with no start date
```

## Boolean Scopes

```
include MoScopes::BooleanScopes.new(:published)

Event.published                              # Published events (published = true)
Event.not_published                          # Unpublished events (published = false)
Event.published_or_nil                       # Published events or events with nil published value
Event.not_published_or_nil                   # Unpublished events or events with nil published value
Event.published_is_nil                       # Events with no published value
```

## Enum Scopes

```
include MoScopes::EnumScopes.new(:status)

Event.status_is(:approved)                   # Events with status = approved
Event.status_is_any(:pending, :approved)    # Events with status in [pending, approved]
Event.status_is_not(:rejected)              # Events with status != rejected
Event.status_is_not_any(:pending, :rejected) # Events with status not in [pending, rejected]
```

## Date Range Scopes

```
include MoScopes::DateRangeScopes.new(:starts_at, :ends_at)

Event.starts_at_and_ends_at_within(today, next_month)     # Events completely within date range
Event.starts_at_and_ends_at_overlapping(today, next_month) # Events overlapping with date range
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "mo_scopes"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install mo_scopes
```

## Tests

Run tests via `bundle exec rake app:test`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
