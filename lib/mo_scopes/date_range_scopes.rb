module MoScopes
  class DateRangeScopes < Module
    def initialize(starts_at_attribute, ends_at_attribute)
      @starts_at_attribute = starts_at_attribute
      @ends_at_attribute = ends_at_attribute
    end

    def included(model)
      starts_at_attribute = @starts_at_attribute
      ends_at_attribute = @ends_at_attribute

      model.scope "#{starts_at_attribute}_and_#{ends_at_attribute}_within", ->(starts_at, ends_at) {
        where(
          "#{starts_at_attribute} >= ? AND #{ends_at_attribute} <= ?",
          starts_at,
          ends_at
        )
      }

      # start_at_and_ends_at_overlapping
      model.scope "#{starts_at_attribute}_and_#{ends_at_attribute}_overlapping", ->(starts_at, ends_at) {
        where(
          "#{starts_at_attribute} < ? AND #{ends_at_attribute} > ?",
          starts_at,
          ends_at
        )
      }
    end
  end
end
