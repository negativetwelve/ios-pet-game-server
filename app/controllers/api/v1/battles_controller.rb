module Api
  module V1
    class BattlesController < ApplicationController
      respond_to :json

      def index
        users = User.limit(10).shuffle
        render json: {users: User.to_json(users)}
      end

      def create
        
      end

      def start
        @user = User.where(id: params[:user_id]).first
        opponent_user = User.where(id: params[:opponent_id]).first
        @opponent = Opponent.copy(opponent_user)
        @battle = Battle.start(@user, @opponent)
        if @battle
          render json: {battle: @battle.to_json}
        else
          render json: {error: {code: 6, reason: 'Could not start battle.'}}
        end
      end

      def run
        @battle = Battle.where(id: params[:battle_id]).first
        if Battle.end(@battle)
          render json: {success: {code: 7, reason: 'Battle successfully ended.'}}
        else
          render json: {error: {code: 8, reason: 'Could not end battle.'}}
        end
      end

    end
  end
end
