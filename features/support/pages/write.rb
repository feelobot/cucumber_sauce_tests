class Writer
  def initialize(version, search_term, name)
    $version = version
    $search_term = search_term
    $time = Time.now.to_i.to_s
    $name =  $time + " " + name
    $th = TestHelper.new
    $th.login
    $driver.find_element(:xpath => '//*[@id="user-menu"]/li[6]/span[2]').click 
    $driver.find_element(:xpath =>'//*[@id="user-menu"]/li[6]/ul/li[1]/a').click
    #$branch_name = $wait.until { $driver.find_element(:id => "branch-name").text.slice(9) } || "prod"
    #$driver.find_element(:xpath => '//*[@id="branch-name"]/span').click unless ENV['ENVIRONMENT'] == "prod"
  end

  def get_stats(type) 
    s = StoreToMongo.new
    puts s.calculate_stats("#{type}_search") unless type == "tweet" || type == "poll"
    puts s.calculate_stats("drag_and_drop_#{type}")
    puts s.calculate_stats("move_#{type}")
  end

end
