 class SlideShow

  def SlideShow.create(amount)
    header = $wait.until { $driver.find_element(:xpath => '//*[@id="bleacherreport"]/body/div[15]/div[1]/h3')}
    header.text.should == "Create slideshow"
    title = $driver.find_element(:id => 'slideshow-title')
    title.send_keys $name
    slides = $driver.find_element(:id => "num-slides")
    slides.find_element(:css => "option[value='#{amount}']").click
    create = $driver.find_element(:id => "slideshow-create-submit")
    create.click
    self.verify_title($time)
    amount+=1
    self.get_slides.length.should == amount
  end

  def SlideShow.get_slides
    slides = $wait.until { $driver.find_elements(:class => 'slideshow_slide') }
  end

  def SlideShow.verify_title(name)
    title = $wait.until { $driver.find_element(:id => 'article_headline_input').text }
    slide = $wait.until { $driver.find_element(:class => 'slide_title').text }
    title.include? name 
    slide.include? name
  end

  def SlideShow.go_to_slide(num)
    slides = self.get_slides
    slides[num].click
  end

  def SlideShow.verify_preview
    ArticleNavigation.next_step
    $wait.until { $driver.find_element(:css => 'div#preview_sidebar')}
  end

  def SlideShow.publish
    ArticleNavigation.next_step
    hq.skip_topics # SET TAGS
    hq.verify_article_published
    hq.select_article($time) # SELECT ARTICLE FROM WRITER HQ
  end

  #################################
  #       LEGACY CMS              #
  #################################
  def SlideShow.legacy_go_to_slide(num)
    begin
      slides = $wait.until { $driver.find_elements(:class => 'slideshow_slide') }
      slides[num].displayed?
      slides[num].click
    rescue Selenium::WebDriver::Error::UnknownError => e
      raise "Can't Select Slide, Something Went Wrong"
    end
  end
end
#################################
#       SLIDE             #
#################################
class Slide
  def Slide.add_content(title,type)
    case type
    when "getty","presswire"
      m = Media.image
      m.search
      Media.next_arrow if type == "presswire"
    when "ooyala","youtube"
      m = Media.video
      m.search
      Media.next_arrow if type == "youtube"
    when "embed"
      m = Media.embed
    else 
      raise "Unsupported Media Type"
    end
    m.insert(0)
    $long_wait.until { $driver.find_element(:id => 'slide-drop-zone').find_element(:class => 'has_content') }
    Article.add_content(title,1)
  end

  def add
    current_slides = SlideShow.get_slides.length
    button = $wait.until { $driver.find_element(:id => 'add_slide_button') }
    button.click
    $wait.until { current_slides ==  (SlideShow.get_slides.length + 1) }
  end
end