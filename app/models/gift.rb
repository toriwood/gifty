class Gift < ActiveRecord::Base
	belongs_to :wishlist

	validates :url, presence: true, :unless => :image?
	validates :image, presence: true, :unless => :url?

	validate :url_xor_image

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def url_xor_image
  	 unless url.blank? ^ image.blank?
  	 	errors.add(:base, "Specify a url or upload an image, not both.")
  	 end
  end
end
