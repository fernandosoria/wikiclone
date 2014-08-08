class Wiki < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: [:finders, :history]

  default_scope {order('created_at DESC')}
end
