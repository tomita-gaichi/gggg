class UsersController < ApplicationController
  def index
    @users=User.all
    @posts=Post.all
  end
  def new
    @user = User.new
    
  end
  
  def create
    @user=User.new(params.require(:user).permit(:title,:start_date,:end_date,:check,:introduction))
    if @user.save
      flash[:notice] = "スケジュールを新規登録しました"
      redirect_to:users
    else
      flash[:alert] = "スケジュールを登録できませんでした"
      render"new"
    end
  end
  
  def show
    @user=User.find(params[:id])
    @post=Post.new
    @posts=Post.where(user_id:@user.id)
  end

  def edit
    @user=User.find(params[:id])
  end 
  
  def update
    @user=User.find(params[:id])
    if @user.update(params.require(:user).permit(:title,:start_date,:end_date,:check,:introduction))
      flash[:notice]="スケジュールを更新しました"
      redirect_to :users
    else
      flash[:alert] = "スケジュールを更新できませんでした"
      render"edit"
    end
  end
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:notice]="スケジュールを削除しました"
    redirect_to:users
  end 
 
end
class User < ApplicationRecord
   has_many :posts
  validates:title,presence:true
  validates:start_date,presence:true
  validates:end_date,presence:true
  validate :date_before_today
  validate :empty_date
  
  def empty_date
    if end_date.blank?
    errors[:end_date] << "は今日以降のものを選択してください" 

    end
  end
  def date_before_today
    return if end_date.blank?
    if end_date < Date.today 
    errors.add(:end_date, "は今日以降のものを選択してください")  
    end
  end
end
