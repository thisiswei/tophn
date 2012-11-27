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

      def collect_links(entries)
        entries = clean_up_entries_with_nils 
        entries.each do |entry| 
          title  = entry.link.title
          if title.downcase.match(KEYWORD)
            username, score, url = entry.user.name, entry.voting.score, entry.link.href  
            return if username.nil?
            if  Link.exists?(title: title)
                update_link(title,score)
            else
              #person = find_or_create_person(username) 
              Link.create!(title: title, hnscore: score, url: url, created_at: entry.time, hnuser: username)
            end
          end
        end
      end

      def clean_up_entries_with_nils
        Entry.all(10).delete_if{|m| m.user.name.nil? or m.voting.score.nil? }
      end

      def update_link(title,score)
        link = Link.find_by_title(title)
        link.update_attributes(hnscore: score)
      end

      def find_or_create_person(name)
        Person.find_by_hn_username(name) || Person.create(hn_username: name) 
      end
  end
end



