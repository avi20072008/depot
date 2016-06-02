class Product < ActiveRecord::Base
	def self.latest
		Product.order(:updated_at).last
	end
end
