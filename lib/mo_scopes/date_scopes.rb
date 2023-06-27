module MoScopes
  class DateScopes < Module
    def self.matches?(model_class, attribute, attribute_type)
      [:date, :datetime].include?(attribute_type)
    end

    def self.for(model_name, attribute)
      mod = const_set("#{model_name}#{attribute.to_s.camelize}Scopes", Module.new)

      mod.module_eval do
        extend ActiveSupport::Concern

        included do
          scope "#{attribute}_before", -> (datetime) {
            self.where("#{attribute} < ?", datetime)
          }

          scope "#{attribute}_before_or_at", -> (datetime) {
            self.where("#{attribute} <= ?", datetime)
          }

          scope "#{attribute}_after", -> (datetime) {
            self.where("#{attribute} > ?", datetime)
          }

          scope "#{attribute}_after_or_at", -> (datetime) {
            self.where("#{attribute} >= ?", datetime)
          }

          scope "#{attribute}_between", -> (start, finish) {
            self.where("#{attribute} > :start AND #{attribute} < :finish", start: start, finish: finish)
          }

          scope "#{attribute}_between_or_at", -> (start, finish) {
            self.where("#{attribute} BETWEEN :start AND :finish", start: start, finish: finish)
          }
        end
      end

      mod
    end
  end
end
