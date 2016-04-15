class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :birthdate, :date
    add_column :users, :scores, :integer, default: 0
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :promocode, :string
    add_column :users, :imageurl, :string
  end
end
