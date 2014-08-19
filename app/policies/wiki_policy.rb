class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    user.present? && (record.user == user || record.collaborators.include?(user))
  end

  def edit?
    update?
  end

  def premium?
    user.role?(:admin) || user.role?(:premium)
  end
end