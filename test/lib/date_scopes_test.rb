class MoScopes::DateScopesTest < ActiveSupport::TestCase
  setup do
    freeze_time
  end

  teardown do
    unfreeze_time
  end

  test "attribute_before" do
    event_a = create_event(starts_at: 10.hours.from_now)
    _event_b = create_event(starts_at: 20.hours.from_now)

    assert_equal [event_a], Event.starts_at_before(10.hours.from_now + 1.second)
    assert_equal [], Event.starts_at_before(10.hours.from_now)
    assert_equal [], Event.starts_at_before(10.hours.from_now - 1.second)
  end

  test "attribute_before_or_at" do
    event_a = create_event(starts_at: 10.hours.from_now)
    _event_b = create_event(starts_at: 20.hours.from_now)

    assert_equal [event_a], Event.starts_at_before_or_at(10.hours.from_now + 1.second)
    assert_equal [event_a], Event.starts_at_before_or_at(10.hours.from_now)
    assert_equal [], Event.starts_at_before_or_at(10.hours.from_now - 1.second)
  end

  test "attribute_after" do
    event_a = create_event(starts_at: 10.hours.from_now)
    _event_b = create_event(starts_at: 5.hours.from_now)

    assert_equal [], Event.starts_at_after(10.hours.from_now + 1.second)
    assert_equal [], Event.starts_at_after(10.hours.from_now)
    assert_equal [event_a], Event.starts_at_after(10.hours.from_now - 1.second)
  end

  test "attribute_after_or_at" do
    event_a = create_event(starts_at: 10.hours.from_now)
    _event_b = create_event(starts_at: 5.hours.from_now)

    assert_equal [], Event.starts_at_after_or_at(10.hours.from_now + 1.second)
    assert_equal [event_a], Event.starts_at_after_or_at(10.hours.from_now)
    assert_equal [event_a], Event.starts_at_after_or_at(10.hours.from_now - 1.second)
  end

  test "attribute_between" do
    event_a = create_event(starts_at: 10.hours.from_now)
    event_b = create_event(starts_at: 20.hours.from_now)

    assert_equal [event_a, event_b], Event.starts_at_between(10.hours.from_now - 1.second, 20.hours.from_now + 1.second)
    assert_equal [], Event.starts_at_between(10.hours.from_now, 20.hours.from_now)
  end

  test "attribute_between_or_at" do
    event_a = create_event(starts_at: 10.hours.from_now)
    event_b = create_event(starts_at: 20.hours.from_now)

    assert_equal [event_a, event_b], Event.starts_at_between_or_at(10.hours.from_now, 20.hours.from_now)
    assert_equal [], Event.starts_at_between_or_at(10.hours.from_now + 1.second, 20.hours.from_now - 1.second)
  end
end
