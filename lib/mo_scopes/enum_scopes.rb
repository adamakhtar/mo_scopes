module MoScopes
  class EnumScopes < Module

    def initialize(attribute)
      @attribute = attribute
    end

    def included(model)
      enum_attribute = @attribute

      model.scope "#{enum_attribute}_is", ->(enum) {
        where("#{enum_attribute}": enum)
      }

      model.scope "#{enum_attribute}_is_any", ->(*enums) {
        where("#{enum_attribute}": enums)
      }

      model.scope "#{enum_attribute}_is_not", ->(enum) {
        where.not("#{enum_attribute}": enum)
      }

      model.scope "#{enum_attribute}_is_not_any", ->(*enums) {
        where.not("#{enum_attribute}": enums)
      }
    end
  end
end
