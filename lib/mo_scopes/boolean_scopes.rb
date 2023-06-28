module MoScopes
  class BooleanScopes < Module
    def self.matches?(model_class, attribute, attribute_type)
      attribute_type == :boolean
    end

    def self.for(model_name, attribute)
      mod = const_set("#{model_name}#{attribute.to_s.camelize}Scopes", Module.new)

      mod.module_eval do
        extend ActiveSupport::Concern

        included do
          scope "#{attribute}_is_true", -> {
            where("#{attribute} IS ?", true)
          }

          scope "#{attribute}_is_false", -> {
            where("#{attribute} IS ?", false)
          }

          scope "#{attribute}_is_nil_or_false", -> {
            where("#{attribute} IS ? OR #{attribute} IS NULL", false)
          }

          scope "#{attribute}_is_nil", -> {
            where("#{attribute} IS NULL")
          }
        end
      end

      mod
    end
  end
end
