module Api
  class StablesController < ApplicationController
    def index
      render json: Stable.all
    end

    def show
      user_id = params[:id]
      if Stable.exists?(user_id)
        render json: Stable.find(user_id)
      else
        render json: {status: 400, message: "invalid id"}.to_json
      end
    end

    def search
      query = params[:query]
      tempUser = Stable.where('name LIKE ?' +
        ' OR email LIKE ?',
        "%#{query}%","%#{query}%")
        render json: tempUser
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

