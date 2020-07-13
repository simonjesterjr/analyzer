class Signal < ApplicationRecord
  belongs_to :rule
  belongs_to :portfolio

  enum status: [ :init, :applied, :ignored ]
end
