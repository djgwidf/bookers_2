class UsersController < ApplicationController
 before_action :authenticate_user!
 
  def show
    @user = User.find(params[:id])
    @books = @user.books
      @book = Book.new
      @users = User.all
  end

  def index
    @users = User.all
    @user = current_user
    @book =Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path
    end

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "successfully update user!"
    else
      render action: :edit
    end

  end

  private
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
     if current_user != @user
       redirect_to books_path
     end
  end
  

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
  
  

end
