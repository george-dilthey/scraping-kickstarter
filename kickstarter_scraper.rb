# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2 a").text.strip
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css(".location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i,
      :pledged => project.css("ul.project-stats li.pledged strong").text.gsub("$","").to_i
    }
  end
  puts projects
  projects
end

create_project_hash