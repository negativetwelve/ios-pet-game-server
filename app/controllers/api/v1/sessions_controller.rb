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
            render json: {user: user.to_json, pets: user.pets_to_json}
          else
            user.app_id = params[:user][:app_id]
            if user.save
              render json: {user: user.to_json, pets: user.pets_to_json}
            else
              render json: {error: {code: 1, reason: 'cannot save user'}}, status: 422
            end
          end
        else
          render json: {error: {code: 2, reason: 'Username and password are invalid.'}}, status: 422
        end
      end

      def check_username
        if params[:username].length > 50
          render json: {error: {code: 4, reason: 'Sorry! Username must be less than 50 characters.'}}, status: 422
          return
        end
        if params[:username].length < 3
          render json: {error: {code: 4, reason: 'Sorry! Username must be more than 3 characters.'}}, status: 422
          return
        end
        user = User.find_by_username(params[:username].downcase)
        if user
          render json: {error: {code: 3, reason: 'Sorry! That username is taken.'}}, status: 422
        else
          render json: {success: {code: 3, reason: 'Success! That username is available!', username: params[:username]}}, status: 200
        end
      end

      def create
        params[:user][:password] = decrypt(params[:user][:password])
        params[:user][:password_confirmation] = decrypt(params[:user][:password_confirmation])
        params[:user][:email] = decrypt(params[:user][:email])
        if params[:user][:password].length < 6
          render json: {error: {code: 5, reason: 'Sorry! Password must be at least 6 characters.'}}, status: 422
          return
        end
        begin
          user = User.create!(params[:user])
          pet = Pet.create!(params[:pet])
          user.pets << pet
        rescue ActiveRecord::RecordInvalid => invalid
          message = invalid.record.errors
          message = message.map { |k, v| "#{k} #{v}" }.to_sentence.capitalize.gsub('_', ' ')
          render json: {error: {code: 2, reason: message}}, status: 422
          return
        end
        if user
          render json: {user: user.to_json, pets: user.pets_to_json}
        else
          render json: {error: {code: 2, reason: 'error'}}, status: 422
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
            render json: {user: user.to_json, pets: user.pets_to_json}
          else
            user.app_id = params[:app_id]
            if user.save
              render json: {user: user.to_json, pets: user.pets_to_json}
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

