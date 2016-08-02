class CommentsController < ApplicationController
  #コメントを保存、投稿するためのアクション
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用する
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    
      # クライアント要求に応じてフォーマットを変更
      respond_to do |format|
        if @comment.save
          format.html { redirect_to blog_path(@blog), notice: "コメントを投稿しました" } #←いらないっぽい
          #js形式でレスポンスを返す
          format.js { render "index" }
        else
          format.html { render "new", notice: "コメントを入力してください" }
        end
      end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@comment.blog), notice: 'コメントを削除しました' } #←いらないっぽい
      format.js { render :index }
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :blog_id)
  end
end
