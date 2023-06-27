require "test_helper"

class MoScopes::EnumScopesTest < ActiveSupport::TestCase
  setup do
    @draft_event = create_event(status: :draft)
    @published_event = create_event(status: :published)
    @archived_event = create_event(status: :archived)
  end

  test "attribute_is" do
    assert_equal [@draft_event], Event.status_is(:draft)
  end

  test "attribute_is_not" do
    assert_equal [@published_event, @archived_event], Event.status_is_not(:draft)
  end

  test "attribute_is_any" do
    assert_equal [@draft_event, @archived_event], Event.status_is_any(:draft, :archived)
  end

  test "attribute_is_not_any" do
    assert_equal [@published_event], Event.status_is_not_any(:draft, :archived)
  end
end
