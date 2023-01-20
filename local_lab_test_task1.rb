# Need to install rest-client gem and nokogiri gem
# run gem install rest-client
# rum gem install nokogiri
require 'rest-client'
require 'nokogiri'
require 'json'

url =  "https://www.nasa.gov/api/2/ubernode/479003"
url_response = RestClient.get(url)
json_response = JSON.parse(url_response)['_source']
response_body = json_response['body']
article_body_html = Nokogiri::HTML(response_body)
result = {
  'title': json_response['title'],
  'date': json_response['promo-date-time'],
  'release_no': json_response['release-id'],
  'article': article_body_html.css('p').text
}
puts result