module Api
  module V1
    class SessionsController < ApplicationController
      include ApplicationHelper

      respond_to :json

      def new
        password = decrypt(params[:user][:password])
        email = decrypt(params[:user][:email])
        user = User.find_by_email(email.downcase)
        if user && user.authenticate(password)
          if user.app_id == params[:user][:app_id]
            render json: user.to_json
          else
            user.app_id = params[:user][:app_id]
            if user.save
              render json: user.to_json
            else
              render json: {error: {code: 1, reason: 'cannot save user'}}
            end
          end
        end
      end

      def create
        params[:user][:password] = decrypt(params[:user][:password])
        params[:user][:password_confirmation] = decrypt(params[:user][:password_confirmation])
        params[:user][:email] = decrypt(params[:user][:email])
        user = User.create(params[:user])
        if user
          render json: user.to_json
        else
          render json: {error: 2, reason: 'error idk'}
        end
      end

      def mobile
        if params[:password].length > 0 and params[:email].length > 0
          password = decrypt(params[:password])
          email = decrypt(params[:email])
        else
          render json: {error: {code: 2, reason: 'no email and password'}}
          return
        end
        user = User.find_by_email(email.downcase)
        if user && user.authenticate(password)
          if user.app_id == params[:app_id]
            render json: user.to_json
          else
            user.app_id = params[:app_id]
            if user.save
              render json: user.to_json
            else
              render json: {error: {code: 1, reason: 'cannot save user'}}
            end
          end
        else
          render json: {error: {code: 2, reason: 'no user or invalid credentials'}}
        end
      end

      def destroy
        sign_out
        redirect_to root_url
      end
    end
  end
end

