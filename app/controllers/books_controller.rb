class BooksController < ApplicationController
  before_action :authenticate_user!


  def new
    @book = Book.new(book_params)
  end

  def create
    @book = Book.new(book_params)
    @user =current_user
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "you have created book successfully."
    else @books = Book.all
      @book_new = Book.new
      render :index
    end
  end

  def index
    @book_new = Book.new
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to  book_path(@book.id), notice: "You have updated book successfully."
    else
       @books = Book.all
       render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"

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
