
class Link < ActiveRecord::Base
  PER_PAGE = 43
  include RubyHackernews
  attr_accessible :title, :url, :hnscore, :hnuser
  belongs_to :user
  has_many :votes
  scope :top, lambda{ Link.all.sort_by{|l| l.votes.count}.reverse}

  before_save :format_url
  validates :title, :uniqueness => true
  validates :url, :uniqueness => true 
  validates :url,:title,:hnscore, :presence => {:message => 'what the heck ?'}
  
  
  def self.update
    if Link.last.created_at < 1.hour.ago
      self.update_links(8)
    end
  end

  def self.update_links(pages)
    top_entries = better_ranks(Entry.all(pages),pages)
    top_entries.each do |entry|
      entry_link       = entry.link.href
      actual_link      = entry_link.include?('http') ? entry_link : ("http://news.ycombinator.com/"+entry_link)
      entry_title      = entry.link.title
      entry_vote       = entry.voting.score
      unless Link.exists?(:title => entry_title)
            link = Link.new(:title   => entry_title ,
                            :hnscore => entry_vote,
                            :url     => actual_link,
                            :hnuser  => entry.user.name  )
            link.save 
      else
        link = Link.find_by_title(entry_title)
        link.update_attributes(hnscore: entry_vote)
      end
    end
  end

  def self.better_ranks(data,pages)
    result = []
    (-pages...0).each do |page|
      slice = sort_by_rank(data[-30*(page+1)...-30*page])
      case -page
      when 1
        result += (slice[-10..-1])
      when 2..3
        result += (slice[-5..-1])
      when 4..8
        result += (slice[-3..-1])
      else
        result += (slice[-2..-1])
      end
    end 
    result
  end

  def self.sort_by_rank(data)
    data.delete_if{|m| m.voting.score.nil?} 
    data = data.sort_by{|m| m.voting.score}
  end

  private
     def format_url
       self.url = 'http://'<<self.url unless self.url.include?('http://') or self.url.include?('https://')
     end
end

