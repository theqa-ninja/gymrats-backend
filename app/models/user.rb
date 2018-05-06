# require 'FitbitHelper'
class User < ApplicationRecord
# include FitbitHelper
  @temp_token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1RFJCMjQiLCJhdWQiOiIyMkNSS1QiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd251dCB3cHJvIHdzbGUgd3dlaSB3c29jIHdhY3Qgd3NldCB3bG9jIiwiZXhwIjoxNTI1NjIxMTc3LCJpYXQiOjE1MjU1OTIzNzd9.oadFv1CPNV9xXe5XMpDGtfJAZgbabzbffpgqaG9T-sk"
  def self.PullFitBitGoals(user_id)
    user = User.find(user_id)
    fb_token = user.fitbit_token
    fb_token = @temp_token
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/activities/goals/daily.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => fb_token
    },
    timeout: 5)

    return "Error: #{ret.code}" if ret.code != 200
    ret = ret.body.split("\n")
    result = JSON.parse(ret.join("\n"))
    user.daily_steps = result['goals']['steps']
    user.daily_floors = result['goals']['floors']
    user.daily_distance = result['goals']['distance']
    user.daily_calorie_burn = result['goals']['caloriesOut']
    user.save!
  end

  def self.GetWaterGoal(user_id)
    user = User.find(user_id)
    fb_token = user.fitbit_token
    fb_token = @temp_token
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/foods/log/water/goal.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => fb_token
    },
    timeout: 5)

    # byebug
    return "Error: #{ret.code}" if ret.code != 200
    ret = ret.body.split("\n")
    result = JSON.parse(ret.join("\n"))
    watergoal = result['goal']['goal']
    watergoal = (watergoal/29.57).floor if (watergoal > 20)
    user.daily_water_in_cups = watergoal
    user.save!
  end

  def self.GetSleepGoal(user_id)
    user = User.find(user_id)
    fb_token = user.fitbit_token
    fb_token = @temp_token
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/sleep/goal.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => fb_token
    },
    timeout: 5)

    # byebug
    return "Error: #{ret.code}" if ret.code != 200
    ret = ret.body.split("\n")
    result = JSON.parse(ret.join("\n"))
    user.daily_sleep_in_mins = result['goal']['minDuration']
    user.daily_bedtime = result['goal']['bedtime']
    user.daily_wakeuptime = result['goal']['wakeupTime']
    user.save!
  end

  def self.getUserInfo(user_id)
    user = User.find(user_id)
    fb_token = user.fitbit_token
    fb_token = @temp_token
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/profile.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => fb_token
    },
    timeout: 5)

    return "Error: #{ret.code}" if ret.code != 200
    user.name = result['user']['displayName']
    user.save!
  end
end
