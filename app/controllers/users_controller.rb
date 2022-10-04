class UsersController < ApplicationController
    skip_before_action :authorize, only: :create

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.arrors.full_messages }, status: :unprocessable_entity
        end        
    end

    def show
        user = @current_user
        if user
            render json: user
        else
            render json: {error: "Unauthorized user"}, status: :unauthorized
        end

    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
