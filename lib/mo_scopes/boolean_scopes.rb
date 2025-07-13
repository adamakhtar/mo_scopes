module MoScopes
  class BooleanScopes < Module

    def initialize(attribute)
      @attribute = attribute
    end

    def included(model)
      boolean_attribute = @attribute

      model.scope "#{boolean_attribute}_is_true", -> {
        where("#{boolean_attribute} IS ?", true)
      }

      model.scope "#{boolean_attribute}_is_false", -> {
        where("#{boolean_attribute} IS ?", false)
      }

      model.scope "#{boolean_attribute}_is_nil_or_false", -> {
        where("#{boolean_attribute} IS ? OR #{boolean_attribute} IS NULL", false)
      }

      model.scope "#{boolean_attribute}_is_nil", -> {
        where("#{boolean_attribute} IS NULL")
      }
    end
  end
end
