class Collect 

  class << self 
    KEYWORD =/(python|ruby|rails|javascript|program|learn|show hn|developer|code|api|django|code|course|web application|design|database|pattern|hack|librar|create|hackathon)/
    include RubyHackernews
    def perform
      update_links
    end

    private
      
      def update_links
        
        entries = Entry.all(8) # will return 10 pages hn_news
        x,y = filter_entries(entries)
        update_keyword_links(x)
        update_top_links(y)
      end

      def update_keyword_links(entries)
        mining_entries(entries,'keyword')
      end

      def update_top_links(entries)
        mining_entries(entries,'top')
      end 

      def filter_entries(entries)
        entries_with_keywords  = []
        all_other_entries      = []

        entries.each do |entry|
          unless entry.user.name.nil? or entry.voting.score.nil?
            if entry.link.title.downcase.match(KEYWORD) or entry.link.href.match(/github/)
              entries_with_keywords << entry
            else
              all_other_entries << entry
            end
          end
        end
        return entries_with_keywords, sorted(all_other_entries)[-50..-20]
      end 

      def mining_entries(entries,kind)
        entries.each do |entry| 
          title  = entry.link.title 
          username, score, url = entry.user.name, entry.voting.score, filter(entry.link.href)  
          person = find_or_create_person(username) 
          unless Link.exists?(url: url) or Link.exists?(title: title)  
            person.links.create!(title: title, hnscore: score, url: url, hn_created_at: entry.time, hnuser: username, kind: kind) 
          else
            update_score(url,score)
          end 
        end
      end 

      def sorted(entries)
        entries.sort_by{|m| m.voting.score}
      end
 
      

      def update_score(url,score)
        link = Link.find_by_url(url)
        link.update_attributes(hnscore: score)
      end

      def find_or_create_person(name)
        Person.find_by_hn_username(name) || Person.create(hn_username: name) 
      end
      
      def filter(link)
        link.include?('http') ? link : ("http://news.ycombinator.com/"+link) 
      end


      
  end
end



