class Attack < ActiveRecord::Base
  attr_accessible :name, :category, :pp, :power, :accuracy

  has_many :pet_attacks
  has_many :pets, through: :pet_attacks

end
