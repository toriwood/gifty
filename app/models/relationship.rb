class Relationship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User"
	validates :friend_id, uniqueness: { scope: :user }
end
