class Showhn

  class << self 
    KEYWORD =/(python|ruby|rails|javascript|program|learn|show hn|developer|code|api|djanjo|coders|course|web application)/
    def perform
      collect_links
    end

    private

      def collect_links
        Entry.all(10).each do |entry| 
          title    = entry.link.title 
          if title.match(KEYWORD) 
              username = entry.user.name
              score    = entry.voting.score 
              url      = entry.link.href
              unless Link.exists?(title)
                  person = Person.find_or_create!(hn_username: username)
                  person.links.create!(title: title, hnscore: score, url: url, created_at: entry.time) 
              else
                link = Link.find_by_title(title)
                link.update_attributes(hnscore: score) 
              end
          end
        end
      end
  end
end



