class Api::V1::UsersController < ActionController::API

  before_action :set_user, only: [:show, :update]
  wrap_parameters :user, include: [:name,:user_name,:email,:password, :password_confirmation]

    # 拾えなかったExceptionが発生したら500 Internal server errorを応答する
    rescue_from Exception, with: :render_status_500

    # ActiveRecordのレコードが見つからなければ404 not foundを応答する
    rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    @users = User.all
  end

  def show
  end

  def create
    @user = User.new(user_params_new)
    if @user.save
      render status: 200, json: { status: 200 }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params_update)
      head :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params_new
      params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
    end

    def user_params_update
      params.permit(:name, :user_name, :comment, :email, :password, :password_confirmation)
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end

end
