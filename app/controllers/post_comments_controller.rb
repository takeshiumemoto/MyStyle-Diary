class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user = current_user
    if @post_comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'コメントが追加されました' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: 'コメントの追加に失敗しました。' }
        format.js { render js: "alert('コメントの追加に失敗しました。');" }
      end
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post = @post_comment.post # 追加: @post を設定
    @post_comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'コメントが削除されました。' }
      format.js
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
