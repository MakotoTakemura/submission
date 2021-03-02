class FavoritesController < ApplicationController
    def create
        post_book = Book.find(params[:book_id])
        favorite = current_user.favorites.new(book_id: post_book.id)
        favorite.save
        redirect_back(fallback_location: book_path(post_book))  
    end

    def destroy
        post_book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: post_book.id)
        favorite.destroy
        redirect_back(fallback_location: book_path(post_book))
    end
end
