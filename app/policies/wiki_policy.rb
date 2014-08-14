class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def premium?
    user.role?(:admin) || user.role?(:premium)
  end
end