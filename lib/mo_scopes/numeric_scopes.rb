module MoScopes
  class NumericScopes < Module

    def initialize(attribute)
      @attribute = attribute
    end

    def included(model)
      numeric_attribute = @attribute

      model.scope "#{numeric_attribute}_eq", ->(value) {
        where("#{numeric_attribute} = ?", value)
      }

      model.scope "#{numeric_attribute}_lt", ->(value) {
        where("#{numeric_attribute} < ?", value)
      }

      model.scope "#{numeric_attribute}_lte", ->(value) {
        where("#{numeric_attribute} <= ?", value)
      }

      model.scope "#{numeric_attribute}_gt", ->(value) {
        where("#{numeric_attribute} > ?", value)
      }

      model.scope "#{numeric_attribute}_gte", ->(value) {
        where("#{numeric_attribute} >= ?", value)
      }

      model.scope "#{numeric_attribute}_between", ->(start, finish) {
        where("#{numeric_attribute} > :start AND #{numeric_attribute} < :finish", start: start, finish: finish)
      }

      model.scope "#{numeric_attribute}_between_or_equal", ->(start, finish) {
        where("#{numeric_attribute} BETWEEN :start AND :finish", start: start, finish: finish)
      }
    end
  end
end
