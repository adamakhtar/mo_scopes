module MoScopes
  class DateRangeScopes < Module
    def self.matches?(model_class, start_attribute, start_attribute_type, end_attribute, end_attribute_type)
      both_date_times = start_attribute_type == :datetime && end_attribute_type == :datetime
      both_dates = start_attribute_type == :date && end_attribute_type == :date

      both_date_times || both_dates
    end

    def self.for(model_name, start_at_attribute, ends_at_attribute)
      module_name = prepare_module_name(model_name, start_at_attribute, ends_at_attribute)
      mod = const_set(module_name, Module.new)

      mod.module_eval do
        extend ActiveSupport::Concern

        included do

          # start_at_and_ends_At_within
          scope "#{start_at_attribute}_and_#{ends_at_attribute}_within", -> (starts_at, ends_at) {
            self.where(
              "#{start_at_attribute} >= ? AND #{ends_at_attribute} <= ?",
              starts_at,
              ends_at
            )
          }

          # start_at_and_ends_at_overlapping
          scope "#{start_at_attribute}_and_#{ends_at_attribute}_overlapping", -> (starts_at, ends_at) {
            self.where(
              "#{start_at_attribute} < ? AND #{ends_at_attribute} > ?",
              starts_at,
              ends_at
            )
          }
        end
      end

      mod
    end

    def self.prepare_module_name(model_name, starts_at_attribute, ends_at_attribute)
      "#{model_name}"\
      "#{starts_at_attribute.to_s.camelize}"\
      "#{ends_at_attribute.to_s.camelize}"\
      "DateRangeScopes"
    end
  end
end
