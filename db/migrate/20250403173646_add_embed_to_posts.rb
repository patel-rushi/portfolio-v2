class AddEmbedToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :embed, :text
  end
end
