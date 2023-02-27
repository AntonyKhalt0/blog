# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def following
    @following = current_user.following.paginate(page: params[:page], per_page: 7)
  end

  def followers
    @followers = current_user.followers.paginate(page: params[:page], per_page: 7)
  end
end
