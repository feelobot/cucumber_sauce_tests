class Homepage
  def Homepage.select_lead_article
    article = $wait.until { $driver.find_element(:id => 'lead-story') }
    article.click
  end
end