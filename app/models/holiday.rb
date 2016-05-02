class Holiday < ActiveRecord::Base
  belongs_to :user
  has_many :gifts
  has_many :wishlists
end
