class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

	serialize :interests, Array
  serialize :following, Array
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


  has_attached_file :image, 
    styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
