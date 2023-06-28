require "test_helper"

class MoScopes::BooleanScopesTest < ActiveSupport::TestCase
  setup do
    @true_event = create_event(published: true)
    @false_event = create_event(published: false)
    @nil_event = create_event(published: nil)
  end

  test "attribute_is_true" do
    assert_equal [@true_event], Event.published_is_true
  end

  test "attribute_is_false" do
    assert_equal [@false_event], Event.published_is_false
  end

  test "attribute_is_nil_or_false" do
    assert_equal [@false_event, @nil_event], Event.published_is_nil_or_false
  end

  test "attribute_is_nil" do
    assert_equal [@nil_event], Event.published_is_nil
  end
end
