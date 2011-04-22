class HomeController < ApplicationController
  layout 'koala'

  def index
    graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
    @likes = graph.get_connections("me", "likes")
  end
end

