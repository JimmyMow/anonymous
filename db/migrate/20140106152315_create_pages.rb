class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :person
      t.integer :person_id

      t.timestamps
    end
  end
end
