class Portfolio < ApplicationRecord
    has_and_belongs_to_many :markets
    has_and_belongs_to_many :rules
    has_many :signals
    has_many :activities

    attr_accessor :days, :days_count,
                  :max, :min
end
