module ApplicationHelper
  def profile_img(user)
    if user.avatar?
     return image_tag(user.avatar)
    else
      return image_tag('no-image.jpg')
    end
    
    #SNSでログインした時
    unless user.image_url.blank?
      img_url = user.image_url
    else
      img_url = 'no-image.jpg'
    end
    image_tag(img_url)
  end
end





  





