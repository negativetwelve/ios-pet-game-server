module Api
  module V1
    class BattlesController < ApplicationController
      respond_to :json

      def index
        users = User.all
        render json: {users: User.to_json(users.shuffle)}
      end
    end
  end
end
