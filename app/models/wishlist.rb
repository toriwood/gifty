class Wishlist < ActiveRecord::Base
	belongs_to :user
  belongs_to :interest
  belongs_to :holiday
	has_many :gifts, dependent: :destroy
end
