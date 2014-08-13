class UsersController < ApplicationController
  def show
    @wikis = current_user.wikis
  end
end
