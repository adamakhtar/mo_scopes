require "mo_scopes/version"
require "mo_scopes/engine"

require "mo_scopes/module_builder"
require "mo_scopes/string_scopes"
require "mo_scopes/date_scopes"
require "mo_scopes/date_range_scopes"
require "mo_scopes/numeric_scopes"
require "mo_scopes/boolean_scopes"
require "mo_scopes/enum_scopes"

module MoScopes
  extend ActiveSupport::Concern

  class Error < StandardError; end

  class_methods do
    def mo_scopes_for(attribute_or_tuple)
      if attribute_or_tuple.is_a?(Symbol)
        include ModuleBuilder.build_for_single_attribute(self, attribute_or_tuple)
      elsif attribute_or_tuple.is_a?(Array)
        include ModuleBuilder.build_for_pair_of_attributes(self, attribute_or_tuple)
      end
    end
  end
end
