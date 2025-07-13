class Event < ApplicationRecord
  include MoScopes::StringScopes.new(:title)
  include MoScopes::BooleanScopes.new(:published)
  include MoScopes::NumericScopes.new(:price)
  include MoScopes::DateScopes.new(:starts_at)
  include MoScopes::DateScopes.new(:ends_at)
  include MoScopes::EnumScopes.new(:status)
  include MoScopes::DateRangeScopes.new(:starts_at, :ends_at)

  enum :status, [:draft, :published, :archived]
end
