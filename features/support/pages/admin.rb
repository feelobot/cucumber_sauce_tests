
class Admin
  def Admin.login
    $th = TestHelper.new
    $th.login
  end
  def Admin.actions(action)
    gear = $wait.until { $driver.find_element(:class => 'admin-actions') }
    gear.click
    case action
    when "article admin"
      link = $wait.until { $driver.find_element(:css => 'ul.admin-actions-menu > li:nth-of-type(4)') }
    else
      raise "Admin Action Not Available"
    end
    link.click
  end
end

class ArticleAdmin
  def ArticleAdmin.action(a)
    actions = {
      "edit" => "edit-photo",
      "change" => "add-photo",
      "add" => "add-photo"
    }
    el = $wait.until { $driver.find_element(:class => actions[a]) }
    @before_url =  get_photo_hook_image_url
    el.click
    Legacy.getty_search unless a == "edit"
  end

  def ArticleAdmin.get_photo_hook_image_url
    img = $wait.until { $driver.find_element(:class => 'media_area_photo') }
    img.location_once_scrolled_into_view
    img_url = img.attribute('style')
    img_url.match(/([0-9]+)_/)[1]
  end

  def ArticleAdmin.compare_photo_urls
    after_url = get_photo_hook_image_url
    @before_url == after_url
  end
end