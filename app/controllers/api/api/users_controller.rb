module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
      before_action :access_restrict

      # GET /users
      def index
        @users = User.all

        render json: @users
      end

      # GET /users/1
      def show
        render json: @user
      end

      # POST /users
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      def destroy
        @user.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def user_params
          params.require(:user).permit(:name, :age)
        end

    private
      def access_restrict
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(:access_token => token)
        end
      end
    end
  end
end
