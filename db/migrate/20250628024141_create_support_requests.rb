class CreateSupportRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :support_requests do |t|
      t.string :reference
      t.string :request_type
      t.string :subject
      t.text :description
      t.string :attachments
      t.string :status
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :agent, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
