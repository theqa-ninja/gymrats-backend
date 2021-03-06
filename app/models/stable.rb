class Stable < ApplicationRecord

  @temp_token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1RFJCMjQiLCJhdWQiOiIyMkNSS1QiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd251dCB3cHJvIHdzbGUgd3dlaSB3c29jIHdhY3Qgd3NldCB3bG9jIiwiZXhwIjoxNTI1NjU4MjQxLCJpYXQiOjE1MjU2Mjk0NDF9.xWc1RT3lcS7YaA1B7y8StjtgLg9tiByAQs7GFm6KtZk"

  def self.WeeklyPrize(user_id, date)
    user = User.find(user_id)
    fb_token = user.fitbit_token
    fb_token = @temp_token
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/activities/date/#{date}.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => fb_token
    },
    timeout: 5)
    byebug
    return "Error: #{ret.code}" if ret.code != 200
    unit = Stable.where(user_id: user_id, is_active: true).first()
    unitInfo = Allelean.find(unit.allelean_id)
    ret = ret.body.split("\n")
    result = JSON.parse(ret.join("\n"))
    step_goal = result['goals']['steps']
    floor_goal = result['goals']['floors']
    distance_goal = result['goals']['distance']
    calorie_burn_goal = result['goals']['caloriesOut']

    steps = result['summary']['steps'].to_f
    floors = result['summary']['floors'].to_f
    distance = result['summary']['distances'][0]['distance'].to_f
    calorie_burn = result['summary']['caloriesOut'].to_f
    exp = 100.0
    if (unitInfo.id != Allelean.egg)
      exp = exp * (steps / step_goal / unitInfo.multiplier_steps)
      # exp = exp * (floors / floor_goal / unitInfo.multiplier_steps)
      # exp = exp * (distance / distance_goal / unitInfo.multiplier_steps)
      exp = exp * (calorie_burn / calorie_burn_goal / unitInfo.multiplier_calories)
    else
      exp = exp * (steps / step_goal) * (floors / floor_goal) * (distance / distance_goal) * (calorie_burn / calorie_burn_goal)
    # user.name = result['user']['displayName']
    # user.save!
    end
    exp = 100 if (exp > 100)
    unit.exp = unit.exp + exp
    if (unit.exp >= 100)
      unit.level = unit.level + (unit.exp.to_i / 100)
      unit.exp = unit.exp % 100
    end
    unit.save!
    unit
  end

  def self.CalculateExp(user_id, date)
    user = User.find(user_id)
    fb_token = user.fitbit_token
    fb_token = @temp_token
    ret = HTTParty.get("https://api.fitbit.com/1/user/-/activities/date/#{date}.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => fb_token
    },
    timeout: 5)
    return "Error: #{ret.code}" if ret.code != 200
    unit = Stable.where(user_id: user_id, is_active: true).first()
    unitInfo = Allelean.find(unit.allelean_id)
    ret = ret.body.split("\n")
    result = JSON.parse(ret.join("\n"))
    step_goal = result['goals']['steps']
    floor_goal = result['goals']['floors']
    distance_goal = result['goals']['distance']
    calorie_burn_goal = result['goals']['caloriesOut']

    steps = result['summary']['steps'].to_f
    floors = result['summary']['floors'].to_f
    distance = result['summary']['distances'][0]['distance'].to_f
    calorie_burn = result['summary']['caloriesOut'].to_f
    exp = 100.0
    if (unitInfo.id != Allelean.egg)
      exp = exp * (steps / step_goal / unitInfo.multiplier_steps)
      # exp = exp * (floors / floor_goal / unitInfo.multiplier_steps)
      # exp = exp * (distance / distance_goal / unitInfo.multiplier_steps)
      exp = exp * (calorie_burn / calorie_burn_goal / unitInfo.multiplier_calories)
    else
      exp = exp * (steps / step_goal) * (floors / floor_goal) * (distance / distance_goal) * (calorie_burn / calorie_burn_goal)
    # user.name = result['user']['displayName']
    # user.save!
    end
    exp = 100 if (exp > 100)
    unit.exp = unit.exp + exp
    if (unit.exp >= 100)
      unit.level = unit.level + (unit.exp.to_i / 100)
      unit.exp = unit.exp % 100
    end
    unit.save!
    unit
  end
end
