class Link < ActiveRecord::Base
  attr_accessible :title, :url
  belongs_to :user
  has_many :votes
  scope :top, lambda{ Link.all.sort_by{|l| l.votes.count}.reverse}

  before_save :format_url
  validates :title, :uniqueness => true
  validates :url, :uniqueness => true

  validates :url,:title, :presence => {:message => 'Name cannot be blank, Task not saved'}



  private
     def format_url
       self.url = 'http://'<<self.url unless self.url.include?('http://') or self.url.include?('https://')
     end
end
