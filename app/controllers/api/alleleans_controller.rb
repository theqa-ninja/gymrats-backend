module Api
  class AlleleansController < ApplicationController
    def index
      render json: Allelean.all
    end

    def show
      user_id = params[:id]
      if Allelean.exists?(user_id)
        render json: Allelean.find(user_id)
      else
        render json: {status: 400, message: "invalid id"}.to_json
      end
    end

    def search
      query = params[:query]
      tempUser = Allelean.where('name LIKE ?',
        "%#{query}%")
        render json: tempUser
    end
  end
end

