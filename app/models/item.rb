class Item < ActiveRecord::Base
  attr_accessible :name, :description, :category, :price, :can_sell, :in_battle, :in_store, :unlock_level

  def self.to_json(items)
    return items.collect{ |item| item.to_json }
  end

  def to_json
    return {
      encid: id,
      name: name,
      description: description,
      category: category,
      price: price,
      can_sell: can_sell,
      in_battle: in_battle,
      in_store: in_store,

      unlock_level: unlock_level,
    }
  end

end
