class Showhn 

  class << self 
    KEYWORD =/(python|ruby|rails|javascript|program|learn|show hn|developer|code|api|djanjo|coders|course|web application)/
    include RubyHackernews
    def perform
      update_links
    end

    private
      
      def update_links
         return if Entry.all(1).nil?
         collect_links 
      end

      def collect_links
        Entry.all(9).each do |entry| 
          title    = entry.link.title.downcase
          if title.match(KEYWORD)
            username = entry.user.name
            score    = entry.voting.score     
            url      = entry.link.href  
            if  Link.exists?(title: title)
              link = Link.find_by_title(title)
              link.update_attributes(hnscore: score)  
                #person = Person.new(hn_username: username)
                 #if person.new_record?
                 #   person.save!
                 # else
                 #   person = Person.find_by_name(username) 
                 # end
            else
              Link.create!(title: title, hnscore: score, url: url, created_at: entry.time, hnuser: username)
            end
          end
        end
      end
  end
end



