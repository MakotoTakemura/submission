class RenamePostBookIdColumnToPostComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_comments, :post_book_id, :book_id
  end
end
