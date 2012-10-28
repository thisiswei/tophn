class Link < ActiveRecord::Base
  attr_accessible :title, :url
  belongs_to :user
  has_many :votes

end
