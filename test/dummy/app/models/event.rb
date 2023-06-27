class Event < ApplicationRecord
  include MoScopes

  enum :status, [:draft, :published, :archived]

  mo_scopes_for(:title)
  mo_scopes_for(:starts_at)
  mo_scopes_for(:price)
  mo_scopes_for(:published)
  mo_scopes_for(:status)
  mo_scopes_for([:starts_at, :ends_at])
end
