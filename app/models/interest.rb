class Interest < ActiveRecord::Base
	has_many :gifts, dependent: :destroy
  has_many :wishlists
end
