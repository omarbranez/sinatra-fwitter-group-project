class User < ActiveRecord::Base
  has_secure_password # never forget
  has_many :tweets

  def slug
    username.downcase.gsub(" ", "-")
    # here the key is username, not name like in the playlister lab
    #needs to be hyphenated, since spaces arent escaped in routes
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug }
    #skips having to find the id
  end
end


