class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  #順序逆ならエラーになる(loginしてないとcurrent_user?が呼び出せない)
  
  #GET /users
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/:id
  def show
    # user = User.first (ローカル変数)
    @user = User.find(params[:id]) #(インスタンス変数)
    # @@user = User.first (グローバル変数：ほとんど使わない)
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users (+ params)
  def create
    # (user + given params).save
    @user = User.new(user_params)
    if @user.save
      # Success(valid params)
      # GET "/users/#{@user.id}"
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1)
      #             => /users/1
    else
      # Failure(not valid params)
      render 'new'
    end
  end
  
  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    # => app/views/users/edit.html.erb
  end
  
  # PATCH /users/:id
  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      #更新に成功した場合を扱う
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # @users.errors <== ここにデータが入っている
      render 'edit'
    end
  end
  
  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  # GET /users/:id/following
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  # GET /users/:id/followers
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end
    
    #beforeアクション
    
    
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) #unless~ (~が偽の時)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
