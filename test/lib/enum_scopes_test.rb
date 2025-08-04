require "test_helper"

class MoScopes::EnumScopesTest < ActiveSupport::TestCase
  setup do
    @pending_event = create_event(status: :pending)
    @approved_event = create_event(status: :approved)
    @rejected_event = create_event(status: :rejected)
  end

  test "attribute_is" do
    assert_equal [@pending_event], Event.status_is(:pending)
  end

  test "attribute_is_not" do
    assert_equal [@approved_event, @rejected_event], Event.status_is_not(:pending)
  end

  test "attribute_is_any" do
    assert_equal [@pending_event, @approved_event], Event.status_is_any(:pending, :approved)
  end

  test "attribute_is_not_any" do
    assert_equal [@rejected_event], Event.status_is_not_any(:pending, :approved)
  end
end
