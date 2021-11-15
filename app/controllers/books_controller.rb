class BooksController < ApplicationController
  def index
    @book = Book.all.reverse
  end

  def show
    @book = Book.find params[:id]
    @comments = Comment.where(book_id: @book).order("created_at DESC")
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find params[:id]
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find params[:id]
    @book.destroy

    redirect_to root_path
  end

  def like
    @book = Book.find params[:id]
    if @book.likes.where(user_id: current_user.id).present?
      like = @book.likes.where(user_id: current_user.id).first
      like.destroy
    else
      like = @book.likes.new
      like.user_id = current_user.id
      like.save
    end

    redirect_to @book
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
