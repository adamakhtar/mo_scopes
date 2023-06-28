module MoScopes
  class StringScopes < Module
    def self.matches?(model_class, attribute, attribute_type)
      [:string, :text].include?(attribute_type)
    end

    def self.for(model_name, attribute)
      mod = const_set("#{model_name}#{attribute.to_s.camelize}Scopes", Module.new)

      mod.module_eval do
        extend ActiveSupport::Concern

        included do
          scope "#{attribute}_starting", ->(term, case_sensitive = false) {
            if case_sensitive
              where("#{attribute} LIKE ?", "#{term}%")
            else
              where("#{attribute} ILIKE ?", "#{term}%")
            end
          }

          scope "#{attribute}_ending", ->(term, case_sensitive: false) {
            if case_sensitive
              where("#{attribute} LIKE ?", "%#{term}")
            else
              where("#{attribute} ILIKE ?", "%#{term}")
            end
          }

          scope "#{attribute}_containing", ->(term, case_sensitive: false) {
            if case_sensitive
              where("#{attribute} LIKE ?", "%#{term}%")
            else
              where("#{attribute} ILIKE ?", "%#{term}%")
            end
          }
        end
      end

      mod
    end
  end
end
