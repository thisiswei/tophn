class Vote < ActiveRecord::Base
  belongs_to :link
  belongs_to :user

  attr_accessible :link_id, :user_id, :up
end
