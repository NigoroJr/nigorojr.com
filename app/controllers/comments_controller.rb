class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment.article = Article.find(params[:article_id])
    @comment.name = params[:name]
    @comment.body = params[:body]
    @comment.article_id = params[:article_id]

    # Mismatched capcha
    # TODO: Don't hardcode this
    # TODO: Do something better than redirecting (will lose comment entered)
    if !simple_captcha_valid?
      flash[:error] = "Text did not match with the image"
      redirect_to @comment.article
      return
    end

    if @comment.save
      flash[:notice] = "Posted comment"
      redirect_to @comment.article
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

    flash[:notice] = "Deleted comment"
    redirect_to article
  end
end
