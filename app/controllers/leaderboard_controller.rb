class LeaderboardController < ApplicationController

  def index
    users = User.order(params[:category]).limit(10)
    render json: {users: User.to_json(users)}
  end

end
