require "test_helper"

class MoScopes::NumericScopesTest < ActiveSupport::TestCase
  test "attribute_eq" do
    event_a = create_event(price: 10)
    _event_b = create_event(price: 11)

    assert_equal [event_a], Event.price_eq(10)
  end

  test "attribute_lt" do
    event_a = create_event(price: 10)
    _event_b = create_event(price: 11)

    assert_equal [event_a], Event.price_lt(11)
  end

  test "attribute_lte" do
    event_a = create_event(price: 10)
    event_b = create_event(price: 11)

    assert_equal [event_a, event_b], Event.price_lte(11)
  end

  test "attribute_gt" do
    _event_a = create_event(price: 10)
    event_b = create_event(price: 11)

    assert_equal [event_b], Event.price_gt(10)
  end

  test "attribute_gte" do
    event_a = create_event(price: 10)
    event_b = create_event(price: 11)

    assert_equal [event_a, event_b], Event.price_gte(10)
  end

  test "attribute_between" do
    event_a = create_event(price: 10)
    event_b = create_event(price: 20)

    assert_equal [event_a, event_b], Event.price_between(9, 21)
    assert_equal [], Event.price_between(10, 20)
  end

  test "attribute_between_or_equal" do
    event_a = create_event(price: 10)
    event_b = create_event(price: 20)

    assert_equal [event_a, event_b], Event.price_between_or_equal(10, 20)
    assert_equal [], Event.price_between_or_equal(11, 19)
  end
end
