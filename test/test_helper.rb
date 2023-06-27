# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
require "rails/test_help"
require "byebug"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end


class ActiveSupport::TestCase
  def create_event(attrs={})
    Event.create!(valid_event_attrs(attrs))
  end

  def valid_event_attrs(attrs={})
    {
      title: "Develper Meetup",
      description: "A great event to meet new friends",
      starts_at: 2.weeks.from_now,
      ends_at: 2.weeks.from_now + 1.hour,
      price: 1000,
      published: true,
      status: :draft
    }.merge(attrs)
  end
end