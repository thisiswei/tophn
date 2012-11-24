class Showhn 

  class << self 
    KEYWORD =/(python|ruby|rails|javascript|program|learn|show hn|developer|code|api|djanjo|coders|course|web application)/
    include RubyHackernews
    def perform
      collect_links
    end

    private

      def collect_links
        Entry.all(1).each do |entry| 
          title    = entry.link.title 
          if title.match(KEYWORD) 
              username = entry.user.name
              score    = entry.voting.score 
              url      = entry.link.href
              unless Link.exists?(title)
                  person = Person.new(hn_username: username)
                  if person.new_record?
                    person.save!
                  else
                    person = Person.find_by_name(username) 
                  end
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



