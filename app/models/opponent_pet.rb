require 'pet_battle_features'

class OpponentPet < ActiveRecord::Base
  include PetBattleFeatures
  # attr_accessible :title, :body
end
