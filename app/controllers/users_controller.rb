class UsersController < ApplicationController
  before_action :authenticate_user
  
  def index
    @users=User.all
    @posts=Post.all
  end

  def new
    @user = User.new
    
  end

  def show
    @user=User.find_by(id: params[:id])
  end

  def create
    @user=User.new(name: params[:name], email: params[:email], password: params[:password], introduction: params[:introduction], image_name: "default_icon-9263fc59c414b7228d256fc178dcb22183561357950a68f5ad086ba7ee054974.jpeg")
    if @user.save
      session[:user_id] = @user.id
     flash[:notice] = "ようこそ！！"
     redirect_to("/users/#{@user.id}/show")
    else
      render("users/new")
    end
  end
  
  def edit
    @user=User.find_by(id: params[:id])
  end 

  
  
  def update
    @user=User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.introduction = params[:introduction]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("user_images/#{@user.image_name}",image.read)
    end

    if @user.save
      flash[:notice]="スケジュールを更新しました"
      redirect_to("/users/#{@user.id}/show")
    else
      flash[:alert] = "スケジュールを更新できませんでした"
      render("/users/#{@user.id}/show")
    end
  end
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:notice]="スケジュールを削除しました"
    redirect_to:users
  end 

  def account
    @user = User.find_by(id: params[:id])
  end

 

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/index")
    else
      flash[:notice] = "メールアドレスかパスワードが入力されていせん"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end  
 

  def user_params
    params.require(:user).permit(:image)
  end
end

