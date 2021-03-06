class BookCommentsController < ApplicationController
  def create
    post_book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = post_book.id
    if comment.save
      redirect_to book_path(post_book.id)
    else
      @post_book = post_book
      @book = Book.new
      @post_comment = comment
      render "books/show"
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end  
end
