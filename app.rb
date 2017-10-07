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

  collection_css_path = 'html body' # <= customize
  collection = html_document.css(collection_css_path)

  collection.each do |element|
    #title
    title_css_path = '.cover .rf-project-cover:nth-child(1) > div:nth-child(2) > a:nth-child(1)' # <= customize
    title = element.css(title_css_path).text

    @cards << [title]
  end

  erb :'search'
end