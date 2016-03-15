class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: true

	serialize :interests, Array
  serialize :following, Array
  serialize :celebrating, Array
  serialize :special_days, Hash
	
  has_many :wishlists, dependent: :destroy
  has_many :gifts, dependent: :destroy
  
  has_many :relationships
  has_many :friends, through: :relationships

  has_many :inverted_relationships, class_name: "Relationship", foreign_key: "friend_id"
  has_many :followers, through: :inverted_relationships, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def age
  	(Date.today - self.birthday).to_i / 365
  end

#calculate age to allow for age search in form using ransack gem
  scope :age_between, lambda{|from_age, to_age|
  if from_age.present? and to_age.present?
    where( :birthday =>  (Date.today - to_age.to_i.year)..(Date.today - from_age.to_i.year) )
  end
}

  ransacker :age, :formatter => proc {|v| Date.today - v.to_i.year} do |parent|
    parent.table[:birthday]
  end   

  has_attached_file :image, 
    styles: { medium: "300x300#", thumb: "100x100#" }, 
      default_url: "https://s3.amazonaws.com/gifted.twood/missing.png?X-Amz-Date=20160315T120842Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=ceda7526a139a576b592a815b31d8e20e6a15f627589eccb6491fc05b4efd555&X-Amz-Credential=ASIAIY4N5XDCD6YQ4RGA/20160315/us-east-1/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=AQoDYXdzEF0agAJrYCkbxTqqW7JF0ruzZWsiXbu4tapVojCQVUtHlp/61MhyMyh8NxhN6LOicG6pWvEA6APu79B1FPLAZ2c1mJJnZExJP2%2BHGSn/1RlRYk/ieCQszWP3SIpqRrda5/sPA48JA9G54CzDwx6RY/6YwpvnowmVoD9rHCIxELk6VocN6iymEENQkNVC9wWTJH2nfpZL6CuRdWxpqJRhc6dFl76lj%2B5WxLA/8CGMcqTrI5K3/huwiUsrCe1qzxU/RBrIc9/EYgnpI%2B56VKy1f6GNeO7M7pgpjZuYLVVfOaDvft2SAFQVmRXwzZ3GwNKQrq4/D2UoTvBcx5YpsnXUHHQDLZ%2BxILD2n7cF"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end