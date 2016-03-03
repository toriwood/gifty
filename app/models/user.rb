class User < ActiveRecord::Base
	has_many :wishlists, dependent: :destroy
	has_many :gifts, dependent: :destroy
	
	serialize :interests, Array
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def age
  	(Date.today - self.birthday).to_i / 365
  end

end
