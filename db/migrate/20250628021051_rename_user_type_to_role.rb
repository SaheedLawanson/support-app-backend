class RenameUserTypeToRole < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :user_type, :role
  end
end
