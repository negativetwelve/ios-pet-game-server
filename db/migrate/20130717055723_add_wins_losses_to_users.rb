class AddWinsLossesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wins, :integer, default: 0
    add_column :users, :losses, :integer, default: 0
    add_column :users, :passive_wins, :integer, default: 0
    add_column :users, :passive_losses, :integer, default: 0
    add_column :users, :run_aways, :integer, default: 0
    add_column :users, :passive_run_aways, :integer, default: 0
  end
end
