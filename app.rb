require 'open-uri'
require 'nokogiri'
require 'sinatra'

get '/' do
  erb :'home'
end

get '/search' do
  @cards = []

  search_url = "https://www.behance.net/search?content=projects&sort=appreciations&time=week&search=fus%C3%A9e" # <= customize

  html_file = open(search_url)
  html_document = Nokogiri::HTML(html_file)

  collection_css_path = 'div.rf-project-cover.rf-project-cover--project.js-item.js-project-cover.qa-project-cover.editable.first' # <= customize
  collection = html_document.css(collection_css_path) 

  collection.each do |element|
    
      # image
      image_url_css_path = 'div.rf-project-cover.rf-project-cover--project.js-item.js-project-cover.qa-project-cover.editable.first a.rf-project-cover__image-container.js-project-cover-image-link.js-project-link img.rf-project-cover__image' # <= customize
      image_url = element.css(image_url_css_path).attr('src')

      @cards << [title, absolute_url, image_url]
    end
  end

  erb :'search'
end


