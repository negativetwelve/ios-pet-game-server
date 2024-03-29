module Api
  module V1
    class LeaderboardController < ApplicationController
      include ApplicationHelper

      respond_to :json

      def index
        users = User.order("wins DESC").limit(10)
        render json: {users: User.to_json(users)}
      end

    end
  end
end
