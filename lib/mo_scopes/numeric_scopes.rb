module MoScopes
  class NumericScopes < Module
    def self.matches?(model_class, attribute, attribute_type)
      [:integer, :float].include?(attribute_type)
    end

    def self.for(model_name, attribute)
      mod = const_set("#{model_name}#{attribute.to_s.camelize}Scopes", Module.new)

      mod.module_eval do
        extend ActiveSupport::Concern

        included do
          scope "#{attribute}_eq", -> (value) {
            self.where("#{attribute} = ?", value)
          }

          scope "#{attribute}_lt", -> (value) {
            self.where("#{attribute} < ?", value)
          }

          scope "#{attribute}_lte", -> (value) {
            self.where("#{attribute} <= ?", value)
          }

          scope "#{attribute}_gt", -> (value) {
            self.where("#{attribute} > ?", value)
          }

          scope "#{attribute}_gte", -> (value) {
            self.where("#{attribute} >= ?", value)
          }

          scope "#{attribute}_between", -> (start, finish) {
            self.where("#{attribute} > :start AND #{attribute} < :finish", start: start, finish: finish)
          }

          scope "#{attribute}_between_or_equal", -> (start, finish) {
            self.where("#{attribute} BETWEEN :start AND :finish", start: start, finish: finish)
          }
        end
      end

      mod
    end
  end
end