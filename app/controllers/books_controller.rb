class BooksController < ApplicationController
  before_action :ensure_correct_user, only:[:edit, :update]
   
  def new
    
  end

  def create
    @post_books = Book.page(params[:page]).reverse_order
    @post_book = Book.new(post_book_params)
    @post_book.user_id = current_user.id
    
    if @post_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@post_book.id)
    else
      render action: :index
    end
  end

  def index
    @post_books = Book.page(params[:page]).reverse_order
    @post_book = Book.new
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @book = Book.new
    @post_book = Book.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def edit
    @post_book = Book.find(params[:id])
  end
  
  def update
    @post_book = Book.find(params[:id])
    @post_book.update(post_book_params)
    if @post_book.save
    flash[:notice] = "You have successfully updated."
    redirect_to book_path(@post_book.id)
    else
    render action: :edit
    end
  end

  def destroy
    @post_book = Book.find(params[:id])
    @post_book.destroy
    redirect_to books_path
  end
  
  
  private

  def post_book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
     unless @book.user == current_user
     redirect_to books_path
     end
  end
end