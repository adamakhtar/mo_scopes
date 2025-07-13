module MoScopes
  class StringScopes < Module
    def initialize(attribute)
      @attribute = attribute
    end

    def included(model)
      string_attribute = @attribute

      model.scope "#{string_attribute}_starting", ->(term, case_sensitive = false) {
        if case_sensitive
          where("#{string_attribute} LIKE ?", "#{term}%")
        else
          where("#{string_attribute} ILIKE ?", "#{term}%")
        end
      }

      model.scope "#{string_attribute}_ending", ->(term, case_sensitive = false) {
        if case_sensitive
          where("#{string_attribute} LIKE ?", "%#{term}")
        else
          where("#{string_attribute} ILIKE ?", "%#{term}")
        end
      }

      model.scope "#{string_attribute}_containing", ->(term, case_sensitive = false) {
        if case_sensitive
          where("#{string_attribute} LIKE ?", "%#{term}%")
        else
          where("#{string_attribute} ILIKE ?", "%#{term}%")
        end
      }
    end
  end
end
