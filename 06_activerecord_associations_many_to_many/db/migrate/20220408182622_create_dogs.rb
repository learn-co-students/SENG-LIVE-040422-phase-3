class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t| 
      # puts t.class
      t.string :name
      t.datetime :birthdate
      t.string :breed
      t.string :image_url
      t.datetime :last_fed_at
      t.datetime :last_walked_at
    end
  end
end
