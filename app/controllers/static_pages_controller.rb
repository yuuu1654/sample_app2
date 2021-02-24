class StaticPagesController < ApplicationController
  
  
  # => "app/views/#{リソース名}/@{アクション名}.html.erb"
  # => "app/views/static_pages/home.html.erb"
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
    # => app/views/static_pages/about.html.erb
  end
  
  def contact
  end
end

    
