module LinksHelper
  def short_url(url)
    url.split('/')[2]
  end

  def username(id)
    u=User.find(id)
    if u && u.username 
      link_to u.username,"http://twitter.com/#{u.username}"
    else
      ""
    end
  end

  def hn_user(user)
    if user 
      link_to user, "http://news.ycombinator.com/user?id=#{user}"
    else
      ""
    end
  end

  def score(link)
      result=raw(if link.hnscore  > 200
        " | score :  <span id= 'hn_score'> " + " #{link.hnscore} " + "</span>"
      else 
        " | score : <span id= 'normal_score'> " + " #{link.hnscore}" +  "</span> "
      end) 
      result
  end
  
  def link_title(link)
    title          = link.title                           
    title_downcase = title.downcase
    better_title=raw(if title_downcase.match(/(show hn|(python|ruby|rails))/)
                        "<span id='title_highlight'>" + "#{ link_to title, link.url}" + "</span>"
                     else
                        "#{link_to title, link.url}"
                     end)
    better_title
  end
end
