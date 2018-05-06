class Allelean < ApplicationRecord

  def self.egg
    Allelean.first.id
  end

  def self.randomizer
    total = Allelean.count
    Allelean.find(Random.rand(total))
  end
end
