require 'httparty'
require 'json'
require 'oauth'

module FitbitHelper
  def GetWaterGoal(fb_token)
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/profile.json", query: {"Authorization" => "bearer " + fb_token},
    headers: {
      'Content-Type' => 'application/json'
    },
    timeout: 5)

    byebug
  end
end
