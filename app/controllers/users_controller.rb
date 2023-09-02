class UsersController < ApplicationController
  def user_groups_root
    if current_user
      redirect_to user_groups_path(current_user)
    else
      redirect_to root_path
    end
  end
end
