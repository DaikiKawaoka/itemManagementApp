class Api::V1::SessionsController < ActionController::API

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
    else
      render status: 400, json: { status: 400, message: 'ログイン失敗' }
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
