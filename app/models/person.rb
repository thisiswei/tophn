class Person < ActiveRecord::Base
  attr_accessible :about, :hn_username, :alpha_geek
  has_many:links
  validates_uniqueness_of :hn_username
  validates_presence_of :hn_username
  before_create  :fill_in_about
  after_create   :whether_a_alpha_geek
  


  def to_s
    hn_username
  end
  private

    def fill_in_about
      user_hn_profile_url = "http://news.ycombinator.com/user?id=#{self.hn_username}"
      self.about = get_about(user_hn_profile_url)
    end   

    def get_about(url)
      response = Net::HTTP.get_response(URI.parse(url)).body
      return if response == "No such user."
      parsed_response = Nokogiri::HTML(response)
      parsed_response.css('tr')[-3].css('td')[1].text 
      sleep 1.5
    end    

    def  whether_a_alpha_geek
      links = Link.where(person_id: self.id)
      total_score = links.map(&:hnscore).inject(0){|total,n| total+n }
      self.alpha_geek = total_score > 100 ? true : false
      self.save
    end

       

  
end
