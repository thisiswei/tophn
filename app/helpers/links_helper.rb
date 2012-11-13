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
end
