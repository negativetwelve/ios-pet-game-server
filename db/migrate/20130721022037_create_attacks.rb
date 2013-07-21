class CreateAttacks < ActiveRecord::Migration
  def change
    create_table :attacks do |t|
      t.string :name
      t.integer :pp
      t.integer :power
      t.integer :accuracy
      t.string :category

      t.timestamps
    end
  end
end
