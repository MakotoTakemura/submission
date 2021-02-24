class ChangePostBooksToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_table :post_books, :books
  end
end
