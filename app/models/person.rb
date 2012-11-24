class Person < ActiveRecord::Base
  attr_accessible :about, :hn_username, :alpha_geek
  has_many:links
  validates_uniqueness_of :hn_username
  validates_presence_of :hn_username
  before_save  :fill_in_about
  after_create :whether_a_alpha_geek

  private 
    def fill_in_about        
      user_hn_profile_url = "http://news.ycombinator.com/user?id=#{self.hn_username}"
      self.about = get_about(user_hn_profile_url)
    end   

    def get_about(url)
      response = Net::HTTP.get_response(URI.parse(url)).body                      
      return if response.nil?
      noko_response = Nokogiri::HTML(response)
      about_content = noko_response.css('tr')[-3].css('td')[1].text
    end    

    def  whether_a_alpha_geek
      links = Link.where(person_id: self.id)
      return if links.nil?
      total_score = links.map(&:hnscore).inject(0){|total,n| total+n ; total} 
      total_score > 50 ? self.alpha_geek=true : self.alpha_geek=false
      self.save!
    end

       

  
end
