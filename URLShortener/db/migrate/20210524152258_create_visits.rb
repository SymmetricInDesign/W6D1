class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id, null: false
      t.integer :user_id, null: false
      t.timestamps


      t.index :shortened_url_id
      t.index :user_id
    end
  end
end
