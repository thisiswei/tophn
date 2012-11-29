
class Link < ActiveRecord::Base
  PER_PAGE = 35
  attr_accessible :title, :url, :hnscore, :hnuser, :created_at, :person_id
  belongs_to :user
  belongs_to :person

  validates :title, :uniqueness => true
  validates :url, :uniqueness => true 
  validates :url,:title, :presence => {:message => 'what the heck ?'}
  
  class << self
    include RubyHackernews
    def update
      update_links(8)
    end
    private
      def update_links(pages)
        top_entries = better_ranks(Entry.all(pages),pages)
        top_entries.each do |entry|
          entry_link       = entry.link.href
          actual_link      = entry_link.include?('http') ? entry_link : ("http://news.ycombinator.com/"+entry_link)
          entry_title      = entry.link.title
          entry_vote       = entry.voting.score
          unless Link.exists?(:title => entry_title) or Link.exists?(url: actual_link)
            link = Link.create!(:title       => entry_title ,
                                :hnscore     => entry_vote,
                                :hnuser      => entry.user.name,
                                :url         => actual_link,
                                :created_at  => entry.time)
          else
            link = Link.find_by_title(entry_title)
            link.update_attributes(hnscore: entry_vote)
          end
        end
      end

      def better_ranks(data,pages)
        result = []
        (-pages...0).each do |page|
          slice = sort_by_rank(data[-33*(page+1)...-30*page])
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
