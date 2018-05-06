module Api
  class UsersController < ApplicationController
    def index
      render json: User.all
    end

    def show
      user_id = params[:id]
      if User.exists?(user_id)
        render json: User.find(user_id)
      else
        render json: {status: 400, message: "invalid id"}.to_json
      end
    end

    def search
      query = params[:query]
      tempUser = User.where('name LIKE ?' +
        ' OR email LIKE ?',
        "%#{query}%","%#{query}%")
        render json: tempUser
    end

    def updateGoals
      user_id = params[:id]
      if User.exists?(user_id)
        User.GetWaterGoal(user_id)
        User.GetSleepGoal(user_id)
        User.PullFitBitGoals(user_id)
        render json: User.find(user_id)
      else
        render json: {status: 400, message: "invalid id"}.to_json
      end
    end

    def new
      newUserInfo = Hash.new
      newUserInfo['name'] = params[:name]
      newUserInfo['email'] = params[:email]
      newUser = User.new(newUserInfo)
      if newUser.save!
        a_id = Allelean.egg
        a_id = Allelean.randomizer if params[:dna]
        Stable.new(user_id: newUser.id, allelean_id: a_id, aquired_date: Time.now.utc).save!
        render json: newUser
      else
        render json: {status: 400, message: "error creating user"}.to_json
      end
    end

    def edit
      user_id = params[:id]
      render json: {status: 400, message: "invalid id"} if !User.exists?(user_id)
      updated_user = User.find(user_id)
      updated_user.name = params[:name] if params[:name]
      updated_user.email = params[:email] if params[:email]
      if updated_user.save!
        render json: updated_user
      else
        render json: {status: 400, message: "error updating user"}.to_json
      end
    end

    def destroy
      user_id = params[:id]
      if User.exists?(user_id)
        User.delete(user_id)
        render json: {status: 200, message: "deleted!"}
      end
      render json: {status: 400, message: "invalid id"}
    end
  end
end

