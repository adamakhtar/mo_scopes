module MoScopes
  class ModuleBuilder
    # Determines relevant scopes to be generated for given attribute
    # creates a module with these scopes and returns it to caller so they can be included in the
    # model.
    # E.g. given an attribute called :title of type :string, it will create a module with scopes
    # to query by the title.
    def self.build_for_single_attribute(model_class, attribute)
      attribute_type = model_class.column_for_attribute(attribute).type

      raise Error.new(
        "Unrecognized attribute. #{attribute.inspect} was passed to mo_scopes_for but this "\
        "attribute does not exist on #{model_class.name}. Please check and fix."
      ) unless attribute_type

      scope_klass = [
        EnumScopes, # must come before the NumericScopes as enums are integer column backed
        StringScopes,
        DateScopes,
        NumericScopes,
        BooleanScopes,
      ].detect {|scope_klass| scope_klass.matches?(model_class, attribute, attribute_type) }

      raise Error.new(
        "Unsupported attribute. #{attribute.inspect} can not be used with MoScopes as it is of "\
        "type #{attribute_type.inspect} and this is not supported."
      ) unless scope_klass

      return scope_klass.for(model_class.name, attribute)
    end

    # Determines relevant scopes to be generated for given pair of attribute
    # currently only date range scopes support pairs.
    # creates a module with these scopes and returns it to caller so they can be included in the
    # model.
    # E.g. given attributes starts_at and ends_at that are both :datetime it will create a
    # module with scopes to query with date ranges.
    def self.build_for_pair_of_attributes(model_class, attributes_tuple)
      raise Error.new(
        "Invalid number of attributes provided as a range. Expected two attributes to represent a "\
        "range but got #{attributes_tuple.size}"
      ) unless attributes_tuple.size == 2

      starts_at_attribute, ends_at_attribute = attributes_tuple

      starts_at_type = model_class.column_for_attribute(starts_at_attribute).type
      ends_at_type = model_class.column_for_attribute(ends_at_attribute).type

      unless MoScopes::DateRangeScopes.matches?(
        model_class,
        starts_at_attribute,
        starts_at_type,
        ends_at_attribute,
        ends_at_type
      )
        raise Error, "Invalid attributes for date range scopes. #{starts_at_attribute} and/or #{ends_at_attribute} are not a date or datetime and so MoScopes can not create date range scopes for them."
      end

      return MoScopes::DateRangeScopes.for(model_class.name, starts_at_attribute, ends_at_attribute)
    end
  end
end