
class Link < ActiveRecord::Base
  PER_PAGE = 43
  attr_accessible :title, :url, :hnscore, :hnuser
  belongs_to :user
  has_many :votes

  validates :title, :uniqueness => true
  validates :url, :uniqueness => true 
  validates :url,:title,:hnscore, :presence => {:message => 'what the heck ?'}
  
  class << self
    include RubyHackernews
    def update
      return if Link.last.created_at >  2.hour.ago
      update_links(10)
    end
    private
      def update_links(pages)
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

      def better_ranks(data,pages)
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

      def sort_by_rank(data)
        data.delete_if{|m| m.voting.score.nil?} 
        data = data.sort_by{|m| m.voting.score}
      end
       
  end
end
