module MoScopes
  class DateScopes < Module
    def initialize(attribute)
      @attribute = attribute
    end

    def included(model)
      date_attribute = @attribute

      model.scope "#{date_attribute}_before", ->(datetime) {
        where("#{date_attribute} < ?", datetime)
      }

      model.scope "#{date_attribute}_before_or_at", ->(datetime) {
        where("#{date_attribute} <= ?", datetime)
      }

      model.scope "#{date_attribute}_after", ->(datetime) {
        where("#{date_attribute} > ?", datetime)
      }

      model.scope "#{date_attribute}_after_or_at", ->(datetime) {
        where("#{date_attribute} >= ?", datetime)
      }

      model.scope "#{date_attribute}_between", ->(start, finish) {
        where("#{date_attribute} > :start AND #{date_attribute} < :finish", start: start, finish: finish)
      }

      model.scope "#{date_attribute}_between_or_at", ->(start, finish) {
        where("#{date_attribute} BETWEEN :start AND :finish", start: start, finish: finish)
      }
    end
  end
end
