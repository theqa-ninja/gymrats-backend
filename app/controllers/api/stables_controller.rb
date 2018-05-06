module Api
  class StablesController < ApplicationController
    def index
      render json: Stable.all
    end

    def show
      user_id = params[:user_id]
      if Stable.exists?(user_id: user_id)
        render json: Stable.where(user_id: user_id)
      else
        render json: {status: 400, message: "invalid id"}.to_json
      end
    end

    def calulateExp
      user_id = params[:user_id]
      if User.exists?(user_id)
        yesterday = Date.yesterday.strftime("%Y-%m-%d")
        stable  = Stable.CalculateExp(user_id, yesterday)
        render json: stable
      else
        render json: {status: 400, message: "invalid user_id"}.to_json
      end
    end

    def new
      newUserInfo = Hash.new
      newUserInfo['name'] = params[:name]
      newUserInfo['email'] = params[:email]
      newUser = Stable.new(newUserInfo)
      if newStable.save!
        render json: newUser
      else
        render json: {status: 400, message: "error creating user"}.to_json
      end
    end

    def edit
      user_id = params[:id]
      render json: {status: 400, message: "invalid id"} if !Stable.exists?(user_id)
      updated_user = Stable.find(user_id)
      updated_Stable.name = params[:name] if params[:name]
      updated_Stable.email = params[:email] if params[:email]
      if updated_Stable.save!
        render json: updated_user
      else
        render json: {status: 400, message: "error updating user"}.to_json
      end
    end

    def destroy
      user_id = params[:id]
      if Stable.exists?(user_id)
        Stable.delete(user_id)
        render json: {status: 200, message: "deleted!"}
      end
      render json: {status: 400, message: "invalid id"}
    end
  end
end

