class AddUserToWiki < ActiveRecord::Migration
  def change
    add_reference :wikis, :user, index: true
  end
end
