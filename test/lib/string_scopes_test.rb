require "test_helper"

class MoScopes::StringScopesTest < ActiveSupport::TestCase

  setup do
    @developer_meetup = create_event(title: "Developer Bash")
    @designer_meetup = create_event(title: "Designer Party")
  end

  test "attribute_starting" do
    assert_equal [@developer_meetup], Event.title_starting("Dev")
    assert_equal [@developer_meetup], Event.title_starting("dev")
    assert_equal [@developer_meetup], Event.title_starting("Dev", case_sensitive: true)
    assert_equal [], Event.title_starting("dev", case_sensitive: true)
  end

  test "attribute_ending" do
    assert_equal [@developer_meetup], Event.title_ending("Bash")
    assert_equal [@developer_meetup], Event.title_ending("bash")
    assert_equal [@developer_meetup], Event.title_ending("Bash", case_sensitive: true)
    assert_equal [], Event.title_ending("bash", case_sensitive: true)
  end

  test "attribute_containing" do
    assert_equal [@developer_meetup], Event.title_containing("loper")
    assert_equal [@developer_meetup], Event.title_containing("loper")
    assert_equal [@developer_meetup], Event.title_containing("loper", case_sensitive: true)
    assert_equal [], Event.title_containing("Loper", case_sensitive: true)
  end
end
