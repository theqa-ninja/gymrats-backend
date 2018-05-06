module Api
  class HelixController < ApplicationController
    def index
      render json: HelixInfo.all
    end

    def show
      user_id = params[:id]
      if HelixInfo.exists?(user_id)
        render json: HelixInfo.find(user_id)
      else
        render json: {status: 400, message: "invalid id"}.to_json
      end
    end

    def search
      query = params[:query]
      tempUser = HelixInfo.where('trait LIKE ?' +
        ' OR insight LIKE ?' + ' OR gene LIKE ?',
        "%#{query}%","%#{query}%","%#{query}%")
        render json: tempUser
    end
  end
end

