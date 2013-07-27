module Api
  module V1
    class ItemsController < ApplicationController
      respond_to :json

      def index
        @items = Item.all
        render json: {items: Item.to_json(@items)}
      end
    end
  end
end
