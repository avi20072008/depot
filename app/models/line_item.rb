class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
  	product.price * qty
  end

  def self.decrease(li_id)
  	current_li = LineItem.find(li_id)

  	if current_li.qty > 1
  		current_li.qty -= 1
  	else
  		current_li.destroy
  	end
  	current_li
  end
end
