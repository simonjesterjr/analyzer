class Rule < ApplicationRecord

  has_and_belongs_to_many :portfolios
  has_many :signals

  enum category: [ :entry, :exit, :money, :confirmation_entry, :confirmation_exit ]

end
