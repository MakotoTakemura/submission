class UsersController < ApplicationController
  before_action :ensure_correct_user, only:[:edit, :update]
  
  def index
    @users = User.page(params[:page]).reverse_order
    @post_book = Book.new
    @post_books = Book.page(params[:page]).reverse_order
  end
  
  def show
    @user = User.find(params[:id])
    @post_books = @user.books.page(params[:page]).reverse_order
    @post_book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
    flash[:notice] = "You have successfully updated."
    redirect_to user_path(@user.id)
    else
    render action: :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path(current_user.id)
     end
  end
end
