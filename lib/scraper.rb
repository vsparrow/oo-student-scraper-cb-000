require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(url)
    doc = Nokogiri::HTML(open(url))
    students = []
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      # student_hash[:profile_url] = "./fixtures/students-site/#{student.css("a").attribute("href").value}"
      student_hash[:profile_url] = "#{student.css("a").attribute("href").value}"  #learn.co wants above, but test wants this.
      students << student_hash
    end #each
    students
  end #scrape_index_page


  #scrape_profile_page method is responsible for scraping an individual student's profile page to get further information about that student.
#   {:twitter=>"http://twitter.com/flatironschool",
#   :linkedin=>"https://www.linkedin.com/in/flatironschool",
#   :github=>"https://github.com/learn-co,
#   :blog=>"http://flatironschool.com",
#   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#   :bio=> "I'm a school"
#  }
  def self.scrape_profile_page(url)
    # It should use nokogiri and Open-URI to access that page.
    # puts "***************************************#{url}"
    doc = Nokogiri::HTML(open(url))
    # puts doc
    # blog =
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text
    doc.css(".social-icon-container a").each do |a|
      # puts "*******************************#{a}"
      # puts a.css("img").attribute("src")
      icon = a.css("img").attribute("src")
      # if icon = "../assets/img/twitter-icon.png"
      #   twitter=a.attribute("href").value
      # end #if
      # puts a.attribute("href").value # https://twitter.com/jmburges
      # puts a.class  #Nokogiri::XML::Element
      if a.attribute("href").value.include?("twitter")
        twitter=a.attribute("href").value
      elsif a.attribute("href").value.include?("linkedin")
        linkedin=a.attribute("href").value
      elsif a.attribute("href").value.include?("github")
        github=a.attribute("href").value
      else
        blog = a.attribute("href").value
      end #if

      # twitter=a.attribute("href")

    end #each
    # puts "*********************************twitter:#{twitter}"
    # puts "*********************************linkedin:#{linkedin}"
    # puts "*********************************github:#{github}"
    # puts "*********************************blog:#{blog}"

    hash = {}
    hash[:twitter] =twitter if twitter!=""
    hash[:linkedin] =linkedin if linkedin!=""
    hash[:github] =github if github!=""
    hash[:blog] =blog if blog!=""
    hash[:profile_quote] =profile_quote
    hash[:bio] = bio
    # puts hash
    hash
    # binding.pry
    # The return value of this method should be a hash in which the key/value pairs describe an individual student.
    #   Some students don't have a twitter or some other social link.
  end #scrape_profile_page

end
# file:///home/ubuntu/dev/oo-student-scraper-cb-000/fixtures/student-site/index.html
# Scraper.scrape_index_page("./fixtures/student-site/index.html")
