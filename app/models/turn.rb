class Turn < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :battle_actions

  def to_json
    return {
      battle_actions: battle_actions_to_json
    }
  end

  def battle_actions_to_json
    battle_actions.collect{|ba| ba.to_json}
  end
end
