class Article

  def Article.add_content(name=$name, paragraphs=3)
    $driver.find_element(:id, 'article_headline_input').send_keys(name)
    @body = "Posuere massa ipsam aliquip ac ullamcorper, conubia repellat? Anim rhoncus, felis alias cupiditate! Quisque vivamus inventore asperiores bibendum ligula pellentesque repudiandae quas, egestas fugit? Numquam saepe ad iure aute nostrud lobortis rutrum, quibusdam earum ante quibusdam nonummy corporis adipisicing orci, est accusamus dapibus facilis magnam, eos faucibus senectus, dolorem sodales, semper nonummy mauris enim, eum. Molestias massa perspiciatis, magni lacinia nam sapiente anim! Odit. Ratione ducimus? Temporibus dui est interdum commodo hymenaeos, labore class vehicula erat, pede totam vivamus, nisi perferendis veritatis curae molestie aspernatur, nascetur risus mus hymenaeos dolorum leo beatae, quia rhoncus temporibus doloribus nostrud risus. Vel irure.
"
    # Switch to frame of editor so that text can be inputed
    $driver.switch_to.frame "editor_ifr"
    $driver.switch_to.active_element.send_keys(@body * paragraphs)
    $driver.switch_to.default_content
  end

  def Article.skip_spellcheck
    spellcheck = $driver.find_element(:id, 'spell_check_button')
    $driver.action.move_to(spellcheck, 10, 10).click.perform
    done = $driver.find_element(:id => "spell_check_button_done")
    $wait.until {done.displayed?}
    $driver.action.move_to(done, 10, 2).click.perform
    ArticleNavigation.next_step
  end  
end

class ArticleNavigation

  def ArticleNavigation.next_step
    next_step = $driver.find_element(:xpath => '//*[@id="create_steps"]/ul/li[4]/a')
    $wait.until { next_step.location_once_scrolled_into_view } 
    next_step.click
  end

  def ArticleNavigation.step_two
    $driver.find_element(:xpath => '//*[@id="create_steps"]/ul/li[2]/a').click
  end
end
