module MoScopes
  class BooleanScopes < Module

    def initialize(attribute)
      @attribute = attribute
    end

    def included(model)
      boolean_attribute = @attribute

      model.scope "#{boolean_attribute}", -> {
        where("#{boolean_attribute} = ?", true)
      }

      model.scope "not_#{boolean_attribute}", -> {
        where("#{boolean_attribute} = ?", false)
      }

      model.scope "#{boolean_attribute}_or_nil", -> {
        where("#{boolean_attribute} = ? OR #{boolean_attribute} IS NULL", true)
      }

      model.scope "not_#{boolean_attribute}_or_nil", -> {
        where("#{boolean_attribute} = ? OR #{boolean_attribute} IS NULL", false)
      }


      model.scope "#{boolean_attribute}_is_nil", -> {
        where("#{boolean_attribute} IS NULL")
      }
    end
  end
end
