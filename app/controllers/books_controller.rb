class BooksController < ApplicationController

  def new
    @book = Book.new(book_params)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "you have created book successfly."
    else @book = Book.all
      render "index"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfly delete book!"

  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user)
  end

   def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
     if current_user != @user
       redirect_to books_path
     end
   end

   def baria_user
     unless params[:id].to_i == current_user.id
       redirect_to user_path(current_user)
     end
   end

end
