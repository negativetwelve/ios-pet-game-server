class Pet < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  belongs_to :user

  def to_json
    return {
      name: name,
      level: level,
      experience: experience,
      attack: attack,
      special_attack: special_attack,
      defense: defense,
      special_defense: special_defense,
      speed: speed,
    }
  end
end
