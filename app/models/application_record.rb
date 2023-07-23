class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def float_of_2_decimal(float_n)
    num = float_n.to_s.split('.')
    num[1] = num.size > 1 ? num[1] = num[1][0..1] : "00"
    num.join(".").to_f
  end
end
