class Wiki < ActiveRecord::Base
  belongs_to :user
  
  extend FriendlyId

  friendly_id :title, use: [:finders, :history]

  default_scope {order('created_at DESC')}
end
