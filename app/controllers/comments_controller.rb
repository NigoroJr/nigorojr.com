class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment.article = Article.find(params[:article_id])
    @comment.name = params[:name]
    @comment.body = params[:body]
    @comment.article_id = params[:article_id]

    if @comment.save
      redirect_to @comment.article, notice: "Posted comment"
    else
      render @comment.article
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    # Don't delete comments on someone else's article
    if !@logged_in_as.can_modify(@comment.article)
      raise Forbidden
    end

    # Remember the article
    article = @comment.article

    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to article, notice: "Deleted comment"
  end
end
