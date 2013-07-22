module UserBattleFeatures

  def pets_to_json
    return pets.collect {|pet| pet.to_json}
  end

  def active_pets
    pets
  end

  def has_alive_pets?
    active_pets.each do |pet|
      if pet.is_alive?
        return true
      end
    end
    return false
  end

end
