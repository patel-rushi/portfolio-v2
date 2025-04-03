class AddRemoteIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :remote_id, :string
  end
end
