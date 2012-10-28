module LinksHelper
  def short_url(url)

  end

  def username(id)
    u=User.find(id)
    link_to u.username,"http://twitter.com/#{u.username}"
  end
end
