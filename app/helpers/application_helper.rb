module ApplicationHelper
  
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
     size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}" 
    #gravatar_url = "https://secure.gravatar.com/avatar/e095b97d6b7ef20555f791b5f4cb5f86?s=80"
    image_tag(gravatar_url, alt: user.chefname, class: "img-circle")
  end
end
