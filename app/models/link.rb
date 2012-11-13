
class Link < ActiveRecord::Base
  include RubyHackernews
  attr_accessible :title, :url, :hnscore
  belongs_to :user
  has_many :votes
  scope :top, lambda{ Link.all.sort_by{|l| l.votes.count}.reverse}

  before_save :format_url
  validates :title, :uniqueness => true
  validates :url, :uniqueness => true 
  validates :url,:title, :presence => {:message => 'what the heck ?'}
  
  
  def self.update
    if Link.last.created_at < 5.hour.ago
      self.update_links
    end
  end

  def self.update_links
    lean_top_ten_pages = Entry.all(1).delete_if{|m| m.voting.score.nil?}
    sorted_top_ten_pages = lean_top_ten_pages.sort_by{|m| m.voting.score}.reverse
    top_fifty_entries = sorted_top_ten_pages[0..50]
    top_fifty_entries.each do |entry|
      entry_link       = entry.link.href
      actual_link      = entry_link.include?('http') ? entry_link : ("http://news.ycombinator.com"+entry_link)
      entry_title      = entry.link.title
      entry_vote       = entry.voting.score
      unless Link.exists?(:title => entry_title)
            link = Link.new(:title   => entry_title ,
                            :hnscore => entry_vote,
                            :url     => actual_link  )
            link.user_id = 1 
            link.save 
      else
        link = Link.find_by_title(entry_title)
        link.update_attributes(hnscore: entry_vote)
      end
    end
  end

  private
     def format_url
       self.url = 'http://'<<self.url unless self.url.include?('http://') or self.url.include?('https://')
     end
end

