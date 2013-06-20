module Api
  module V1
    class SessionsController < ApplicationController
      respond_to :json

      def new
        if params[:app_id].length > 0 and params[:email].length > 0
          user = User.where(email: params[:email]).first
          if user
            if user.app_id == params[:app_id]
              respond_with(user.to_json)
            else
              user.app_id = params[:app_id]
              if user.save
                respond_with(user.to_json)
              else
                respond_with({error: 'cannot save user', attempt: 1})
                # try again
              end
            end
          else
            user = User.create(email: params[:email], app_id: params[:app_id], password: params[:password], password_confirmation: params[:password_confirmation])
            if user.save
              respond_with(user.to_json)
            else
              respond_with({error: 'cannot save user', attempt: 1})
              # try again
            end
          end
        elsif params[:email].length > 0
          respond_with({error: 'missing app_id', attempt: 1})
          # try to get an app id.
        else
          respond_with({error: 'missing app_id and email', attempt: 1})
          # redirect to sign up flow
        end
      end

      def create
        user = User.find_by_email(params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          sign_in user
          redirect_back_or root_url
        else
          flash.now[:error] = 'Invalid email/password combination'
          render 'new'
        end
      end

      def destroy
        sign_out
        redirect_to root_url
      end
    end
  end
end

