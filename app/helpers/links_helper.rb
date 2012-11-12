module LinksHelper
  def short_url(url)
    url.split('/')[2]
  end

  def username(id)
    u=User.find(id)
    if u.username
      link_to u.username,"http://twitter.com/#{u.username}"
    else
      "__"
    end
  end
end
