require "test_helper"

class MoScopes::BooleanScopesTest < ActiveSupport::TestCase
  setup do
    @true_event = create_event(published: true)
    @false_event = create_event(published: false)
    @nil_event = create_event(published: nil)
  end

  test "published: published attribute is true" do
    assert_equal [@true_event], Event.published
  end

  test "not_published: published attribute is false" do
    assert_equal [@false_event], Event.not_published
  end

  test "published_or_nil: published attribute is true or nil" do
    assert_equal [@true_event, @nil_event], Event.published_or_nil
  end

  test "not_published_or_nil: published attribute is false or nil" do
    assert_equal [@false_event, @nil_event], Event.not_published_or_nil
  end

  test "published_is_nil: published attribute is nil" do
    assert_equal [@nil_event], Event.published_is_nil
  end
end
