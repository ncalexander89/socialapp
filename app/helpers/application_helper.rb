module ApplicationHelper
  def avatar_for(user, size: 80)
    if user.avatar.attached?
      image_tag user.avatar.variant(resize_to_limit: [size, size]), alt: user.name || user.email
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag gravatar_url, alt: user.name || user.email
    end
  end
end
