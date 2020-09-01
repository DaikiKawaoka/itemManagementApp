class Api::V1::SessionsController < ActionController::API
  include Api::V1::SessionsHelper

  def index
    @user = current_user
    if @user
      #ログインしている
    else
      #ログインしていない
      render status: 201, json: { status: 201, message: 'ログインしていません' }
    end
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      log_in @user
      render status: 200, json: { status: 200, message: 'ログイン成功' }
    else
      render status: 201, json: { status: 201, message: 'ログイン失敗' }
    end
  end

  def destroy
    if logged_in?
      log_out
      if !logged_in?
        render status: 200, json: { status: 200, message: 'ログアウト成功' }
      else
        render status: 201, json: { status: 201, message: 'ログアウト失敗' }
      end
    else
      render status: 201, json: { status: 201, message: 'そもそもログインしていません' }
    end

  end
end
