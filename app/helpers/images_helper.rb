module ImagesHelper
  def get_image_absolute_path
    if Rails.env.production?
      ImagesController::MARK_DOWN_TEMPLATE_PRODUCTION.gsub!(/hosturl/, request.host + @image.image.url)
    else
      ImagesController::MARK_DOWN_TEMPLATE_DEV.gsub!(/hosturl/, request.host_with_port +  @image.image.url)
    end
  end
end
