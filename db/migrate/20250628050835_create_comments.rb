class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :support_request, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
