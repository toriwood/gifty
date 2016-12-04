class Gift < ActiveRecord::Base
  attr_reader :image_remote_url
  belongs_to :user
  belongs_to :wishlist
  belongs_to :interest
  belongs_to :holiday

  validates :wishlist_id, presence: true
  validates :url, presence: true, allow_blank: false
  validates :name, presence: true, length: { in: 1..50 }
  validates :description, presence: true, length: { in: 1..130 }
  validates_format_of :url, :with => URI.regexp(['http','https'])

  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def image_remote_url=(url_value)
    url_value = URI.encode(url_value)
    self.image = URI.parse(url_value)
    @image_remote_url = url_value
  rescue OpenURI::HTTPError => ex
    @image_remote_url = nil
  end

  def self.search(search)
    where("LOWER(name) LIKE :search OR LOWER(description) LIKE :search", search: "%#{search.downcase}%")
  end

end
