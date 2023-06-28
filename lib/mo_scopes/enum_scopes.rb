module MoScopes
  class EnumScopes < Module
    def self.matches?(model_class, attribute, attribute_type)
      model_class.defined_enums.key?(attribute.to_s)
    end

    def self.for(model_name, attribute)
      mod = const_set("#{model_name}#{attribute.to_s.camelize}Scopes", Module.new)

      mod.module_eval do
        extend ActiveSupport::Concern

        included do
          scope "#{attribute}_is", ->(enum) {
            where("#{attribute}": enum)
          }

          scope "#{attribute}_is_any", ->(*enums) {
            where("#{attribute}": enums)
          }

          scope "#{attribute}_is_not", ->(enum) {
            where.not("#{attribute}": enum)
          }

          scope "#{attribute}_is_not_any", ->(*enums) {
            where.not("#{attribute}": enums)
          }
        end
      end

      mod
    end
  end
end
