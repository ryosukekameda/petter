class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.integer :followings_id, null: false
      t.integer :followers_id, null: false
      t.timestamps
    end
  end
end
