class User < ApplicationRecord
  #ユーザが消えるとItemも消える
  has_many :items , dependent: :destroy
  has_one_attached :user_image
  attr_accessor :image


  # validates :eyecatch,   content_type: { in: %w[image/jpeg image/gif image/png],
  #                                       message: "その画像は使用できません。" },
  #                                       size: { less_than: 5.megabytes,
  #                                       message: "サイズが大きすぎます。" }

  before_save { email.downcase! }
  has_secure_password
  validates :name,  presence: true, length: { minimum: 5,maximum: 30 }
  validates :user_name, presence: true, length: { minimum: 5,maximum: 30 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: true
  validates :comment,length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def parse_base64(image)
    if image.present? || rex_image(image) == ''
      content_type = create_extension(image)
      contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
    end
    attach_image(filename)
  end

  private

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  def attach_image(filename)
    user_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end

end
