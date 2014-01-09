class AddGenderToPage < ActiveRecord::Migration
  def change
    add_column :pages, :gender, :string
  end
end
