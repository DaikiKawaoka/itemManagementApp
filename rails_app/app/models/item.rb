class Item < ApplicationRecord
  attr_accessor :image
  belongs_to :user
  has_one_attached :item_image
  validates :itemImage,   content_type: { in: %w[image/jpeg image/gif image/png image/jpg],
    message: "その画像は使用できません。" },
    size:         { less_than: 5.megabytes,
    message: "サイズが大きすぎます。" }
  validates :user_id, presence: true
  validates :name, presence: true,length: { maximum: 50 }
  validates :comment,length: { maximum: 255 }
  validates :type, presence: true
  validates :assessment, presence: true
  validates :purchase_of_place, presence: true,length: { maximum: 30 }
  validates :price, presence: true

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
    item_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
