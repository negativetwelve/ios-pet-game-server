class AddHpToPets < ActiveRecord::Migration
  def change
    add_column :pets, :curr_hp, :integer, default: 0
    add_column :pets, :max_hp, :integer, default: 0
  end
end
