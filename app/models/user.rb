class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: true

	serialize :interests, Array
  serialize :following, Array
  serialize :celebrating, Array
  serialize :special_days, Hash
	
  has_many :wishlists, dependent: :destroy
  has_many :gifts, dependent: :destroy
  has_many :holidays, dependent: :destroy
  accepts_nested_attributes_for :holidays
  
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
      default_url: 'missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end