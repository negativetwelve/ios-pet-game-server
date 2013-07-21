class PetAttack < ActiveRecord::Base
  attr_accessible :attack_id, :pp

  belongs_to :pet
  belongs_to :attack

end
