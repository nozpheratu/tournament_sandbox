class Tournament < ActiveRecord::Base
  attr_accessible :ends_at, :instructions, :name, :starts_at

  has_many :competitions
end
