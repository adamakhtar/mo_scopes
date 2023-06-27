class MoScopes::DateScopesTest < ActiveSupport::TestCase
  setup do
    freeze_time
  end

  teardown do
    unfreeze_time
  end

  test "starts_at_and_ends_at_within" do
    event_a = create_event(starts_at: 30.minutes.from_now, ends_at: 60.minutes.from_now)
    event_b = create_event(starts_at: 10.minutes.from_now, ends_at: 90.minutes.from_now)

    assert_equal [event_a, event_b], Event.starts_at_and_ends_at_within(0.minutes.from_now, 100.minutes.from_now)
    assert_equal [event_a], Event.starts_at_and_ends_at_within(5.minutes.from_now, 70.minutes.from_now)

    # test within is when starts and ends at within or at the given times
    assert_equal [event_a], Event.starts_at_and_ends_at_within(30.minutes.from_now, 70.minutes.from_now)
    assert_equal [event_a], Event.starts_at_and_ends_at_within(5.minutes.from_now, 60.minutes.from_now)

    # test out of bounds
    assert_equal [], Event.starts_at_and_ends_at_within(31.minutes.from_now, 70.minutes.from_now)
    assert_equal [], Event.starts_at_and_ends_at_within(20.minutes.from_now, 59.minutes.from_now)
  end
end
