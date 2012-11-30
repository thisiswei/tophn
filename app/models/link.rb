
class Link < ActiveRecord::Base
  PER_PAGE = 35
  attr_accessible :title, :url, :hnscore, :hnuser, :created_at, :person_id, :kind ,:hn_created_at
  belongs_to :user
  belongs_to :person

  validates :title, :uniqueness => true
  validates :url, :uniqueness => true 
  validates :url,:title, :presence => {:message => 'what the heck ?'}
  
            
end
