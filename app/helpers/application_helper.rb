module ApplicationHelper

  def title
    base = "Wishlist"
    if @title.nil?
      base
    else
      "#{base} | #{@title}"
    end
  end

end
