require 'open-uri'
require 'nokogiri'
require 'sinatra'

get '/' do
  erb :'home'
end

get '/search' do
  @cards = []

  search_url = "https://dribbble.com/search?q=wagon" # <= customize

  html_file = open(search_url)
  html_document = Nokogiri::HTML(html_file)

  collection_css_path = 'li.group' # <= customize
  collection = html_document.css(collection_css_path)

  collection.each do |element|
    #title
    title_css_path = '.dribbble .dribbble-shot .dribbble-img a.dribbble-over strong' # <= customize
    title = element.css(title_css_path).text

    @cards << [title]
  end

  erb :'search'
end

