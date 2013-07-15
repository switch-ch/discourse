class CreateAaiUserInfos < ActiveRecord::Migration
  def change
    create_table :aai_user_infos do |t|
      t.integer :user_id, null: false
      t.string :unique_id, null: false
      t.text :persistent_id, null: false
      t.string :username, null: false
      t.string :given_name
      t.string :surname
      t.string :email
      t.string :home_organization

      t.timestamps
    end
    add_index :aai_user_infos, :user_id, unique: true
    add_index :aai_user_infos, :unique_id, unique: true
  end
end
