module Api
  module V1
    class BattlesController < ApplicationController
      respond_to :json

      def index
        users = User.limit(10).shuffle
        render json: {users: User.to_json(users)}
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

      def attack
        @battle = Battle.where(id: params[:battle_id]).first
        @turn = Battle.make_turn(@battle, 'attack', params)
        if @turn
          render json: {turn: @turn.to_json}
        else
          render json: {error: {code: 9, reason: 'Error while processing turn.'}}
        end
      end

      def run
        @battle = Battle.where(id: params[:battle_id]).first
        if Battle.end(@battle)
          render json: {success: {code: 7, reason: 'Successfully ran from battle.'}}
        else
          render json: {error: {code: 8, reason: 'Could not run away.'}}
        end
      end

    end
  end
end
