REGG=/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
require 'ruby-hackernews'

class Link < ActiveRecord::Base
  include RubyHackernews
  attr_accessible :title, :url, :hnscore
  belongs_to :user
  has_many :votes
  scope :top, lambda{ Link.all.sort_by{|l| l.votes.count}.reverse}

  before_save :format_url
  validates :title, :uniqueness => true
  validates :url, :uniqueness => true

  validates :url,:title, :presence => {:message => 'Name cannot be blank, Task not saved'}
  
  def self.get_hacker_news 
    lean_top_ten_pages = Entry.all(10).delete_if{|m| m.voting.score.nil?}
    sorted_top_ten_pages = lean_top_ten_pages.sort_by{|m| m.voting.score}
    top_fifty_entries = sorted_top_ten_pages[0..50]
    top_fifty_entries.each do |entry|
      entry_link  = entry.link.href
      actual_link = entry_link.include?('http') ? entry_link : ("http://news.ycombinator.com"+entry_link)
      link_in_database = Link.find_by_title(actual_link) 
      if link_in_database.nil?
        link = Link.new(:title   => entry.link.title ,
                          :hnscore => entry.voting.score, 
                          :url     => actual_link  )
          link.user_id = 1 
          link.save 
      else 
        link = link_in_database
        link.hnscore = entry.voting.score
        link.save
      end 
    end
  end
  private
     def format_url
       self.url = 'http://'<<self.url unless self.url.include?('http://') or self.url.include?('https://')
     end
end

