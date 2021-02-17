class SessionsController < ApplicationController
  
  # GET /login
  def new
    # × @session = Session.new
    # ○ scope: :session + url: login_path
  end
  
  # POST /login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #nilガード
      if user.activated?
        # ユーザーログイン後にユーザー情報ページにリダイレクトされる
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # alert-danger => 赤色のフラッシュ
      flash.now[:danger] = 'Invalid email/password combination' 
      render 'new'
      # redirect_to vs render
      # GET /users/1 => show template
      #                 render 'new' (0回目)
    end
  end
  
  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end

