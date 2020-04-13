class AddCommentToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :comment, :string
  end
end
