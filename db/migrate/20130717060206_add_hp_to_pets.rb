class AddHpToPets < ActiveRecord::Migration
  def change
    add_column :pets, :curr_hp, :integer, default: 20
    add_column :pets, :max_hp, :integer, default: 20
  end
end
