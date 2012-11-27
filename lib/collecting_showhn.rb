class Showhn 

  class << self 
    KEYWORD =/(python|ruby|rails|javascript|program|learn|show hn|developer|code|api|djanjo|code|course|web application|hack)/
    include RubyHackernews
    def perform
      update_links
    end

    private
      
      def update_links
         collect_links 
      end

      def collect_links
        entries = filter_entries_with_keywords 
        return if entries.none?

        entries.each do |entry| 
          title  = entry.link.title

          if title.downcase.match(KEYWORD)
            username, score, url = entry.user.name, entry.voting.score, filter(entry.link.href)  
            person = find_or_create_person(username) 
            person.links.create!(title: title, hnscore: score, url: url, created_at: entry.time, hnuser: username) unless Link.exists?(url: url) or Link.exists?(title: title)
          end 

            #if  Link.exists?(url: url)
            #   update_link(title,score)
            #else

        end
      end

      def filter_entries_with_keywords
        Entry.all(10).find_all{|entry| entry.link.title.match(KEYWORD)}.delete_if{|entry| entry.user.name.nil? or entry.voting.score.nil? }
      end

      def update_link(title,score)
        link = Link.find_by_title(title)
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



