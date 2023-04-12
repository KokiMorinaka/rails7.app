require 'nokogiri'
require 'open-uri'
require 'csv'

url = 'https://job.mynavi.jp/25/pc/search/query.html?HR:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,99/'

doc = Nokogiri::HTML(open(url))

links = doc.css('a.js-add-examination-list-text').map { |link| link['href'] }

CSV.open('companySec.csv', 'wb') do |csv|
    links.each do |link|
      begin
        sleep 1
        link_url = URI.join(url, link).to_s

        link_doc = Nokogiri::HTML(open(link_url))

        company_name = link_doc.css('h1').text
        
        establish = link_doc.css('th#corpDescDtoListDescTitle250 + td').text
        employees = link_doc.css('th#corpDescDtoListDescTitle270 + td').text
        capital = link_doc.css('th#corpDescDtoListDescTitle260 + td').text
    
        csv << [company_name, establish, employees, capital]
      end
    end
  end