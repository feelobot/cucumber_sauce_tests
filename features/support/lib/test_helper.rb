require File.join(File.dirname(__FILE__), 'store_to_mongo')

class TestHelper
  def goto(url)
      if url.include?("?")
        url = "#{url}&ads=0&skins=0"
      else
        url = "#{url}?ads=0&skins=0"
      end
      $driver.navigate.to(STAG4 + url)
      $title = $driver.title
      $hr = '#' * 78
    end

  def login
    begin
      case $version
      when "legacy"
        user =  LEGACY_USER
        pass = LEGACY_PASS
      else
        user = DISCOVERY_USER
        pass = DISCOVERY_PASS
      end
      login = $wait.until { $driver.find_element(:id => "log_in_link")}
      login.click
      login_button = $long_wait.until { $driver.find_element(:id => "login_button") }
      email_input = $wait.until { $driver.find_element(:id, 'hat_log_in_email') }
      password_input = $driver.find_element(:id, 'hat_log_in_password')
      email_input.send_keys(user)
      sleep(2)
      password_input.send_keys(pass)
      
      password_input.submit
      $wait.until { $driver.find_element(:css => "span.user-full-name") }
    rescue Timeout::Error => e
      raise "Problem Logging In..."
    end
  end

  def logout
    $driver.find_element(:css, 'span.user-full-name').click
    $wait.until { $driver.find_element(:link => "Logout") }
    $driver.find_element(:link, 'Logout').click
    $wait.until { $driver.find_element(:id => "log_in_link") }
  end

  def end_timer(start,type,search=nil)
    finish = Time.now.to_i
    time_elapsed = (finish - start) * 1000
    StoreToMongo.new.store_timing(time_elapsed,type, search)
  end

  def is_element_present(element_locator)
    begin
      $driver.find_element(element_locator)
      return true
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      return false
    end
  end

end