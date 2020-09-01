class Api::V1::ItemsController < ActionController::API
  before_action :logged_in?, only: [:create, :destroy,:update,:index]
  before_action :set_item, only: [:show,:update]

  def index
    @items = current_user.items
    @items.each do |item|
      item_image = item.item_image
      if item_image.present?
        item.imgtext = encode_base64(item_image) # 画像ファイルを1.で定義したメソッドでBase64エンコードし、renderするデータに追加する
      end
    end
  end

  def show
    item_image = @item.item_image
    if item_image.present?
      @item.imgtext = encode_base64(item_image) # 画像ファイルを1.で定義したメソッドでBase64エンコードし、renderするデータに追加する
    end
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      @item.parse_base64(params[:image])
      render status: 200, json: { status: 200 }
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user == @item.user
      if @item.update(item_params)
        
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy

  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

    #データベースに登録
    def item_params
      params.require(:item).permit(:name, :comment,:assessment,:item_type,
                                    :price,:purchase_of_place,:price,:purchase_date,:favorite)
    end

    # 各モデルのレコードに添付された画像ファイルをBase64でエンコードする
    def encode_base64(image_file)
      image = Base64.encode64(image_file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
      blob = ActiveStorage::Blob.find(image_file[:id]) # Blobを作成
      "data:#{blob[:content_type]};base64,#{image}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
    end

    # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
     #@current_user = @current_user || User.find_by(id: session[:user_id])と同じ意味
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end


  #受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
