class CommentsController < ApplicationController
  def create
    @book = Book.find params[:book_id]
    @comment = @book.comments.create(comment_params)
    @comment.commenter = current_user.email
    @comment.save
    redirect_to @book
  end

  def destroy
    @book = Book.find params[:book_id]
    @comment = @book.comments.find params[:id]
    @comment.destroy
    redirect_to @book
  end

  def edit
    @book = Book.find params[:book_id]
    @comment = @book.comments.find params[:id]
  end

  def update
    @book = Book.find params[:book_id]
    @comment = @book.comments.find params[:id]
    @comment.save
    if @comment.update(comment_params).permit(:content)
      redirect_to @comment
    else
      render 'edit'
    end
  end

end

private
def comment_params
  params.require(:comment).permit(:commenter, :body)
end

