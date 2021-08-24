class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
      @book = Book.new
      @users = User.all
  end

  def index
    @users = User.all
    @user = User.new
    @book =Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "successfly update user!"
    else
      render action: :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end
