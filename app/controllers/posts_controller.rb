class PostsController < ApplicationController
  def index
  end
  def new
  end
 
  def create
    @post=Post.new(params.require(:post).permit(:content,:user_id))
    if @post.save
      flash[:notice]="新規投稿をしました"
      redirect_to :users
    else
      flash[:not] = "スケジュールを登録できませんでした"
      render"new"
    end
  end
 
  def show
    @post=Post.find(params[:id])
  end
 
  def edit
    @post=Post.find(params[:id])
  end
 
  def update
      @post=Post.find(params[:id])
    if @post.update(params.require(:post).permit(:content,:user_id))
      flash[:notice]="投稿を更新しました"
      redirect_to :users
    else
      render"edit"
    end
  end
 
  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to :users
  end
end
