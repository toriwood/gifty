class Gift < ActiveRecord::Base
  attr_reader :image_remote_url
  belongs_to :user
  belongs_to :wishlist
  validates  :wishlist, presence: true
  validates :url, presence: true
  belongs_to :interest

  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def image_remote_url=(url_value)
    url_value = URI.encode(url_value)
    self.image = URI.parse(url_value)
    @image_remote_url = url_value
  end

  def self.search(search)
    where("LOWER(name) LIKE :search OR LOWER(description) LIKE :search", search: "%#{search.downcase}%")
  end

end
