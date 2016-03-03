class Interest < ActiveRecord::Base
	has_many :gifts, dependent: :destroy
end
