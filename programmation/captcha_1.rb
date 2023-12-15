require 'mechanize'
require 'base64'
require 'rtesseract'

code = nil 
count = 0

while code.nil?
  
  url_page = 'http://challenge01.root-me.org/programmation/ch8/'
  agent = Mechanize.new
  page = agent.get(url_page)
  
  encoded_image_data = page.search('img').first['src']
  base64_data = encoded_image_data.split(',')[1]
  image_data = Base64.decode64(base64_data)
  
  File.open('image.png', 'wb') { |file| file.write(image_data) }
  
  ocr = RTesseract.new('image.png', lang: 'eng')
  text = ocr.to_s.strip
  
  form = page.forms.first
  form.field_with(name: 'cametu').value = text 
  
  submitted_page = agent.submit(form)
  
  doc = Nokogiri::HTML(submitted_page.body)
  text = doc.css('p').text.strip
  match_data = text.match(/le flag est (\w+)/)
  
  if match_data
    code = match_data[1]
  end
  count += 1
  puts "number of try #{count}"
end

puts "code: #{code}"