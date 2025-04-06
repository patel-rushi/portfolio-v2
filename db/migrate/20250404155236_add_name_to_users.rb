class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    if !table_exists?(:users)
      create_table :users do |t|
        t.string :name, null: true
        t.string :email, null: true
        t.string :password_digest, null: false

        t.timestamps
      end
    else
      add_column :users, :name, :string
    end
  end
end
