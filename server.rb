require 'sinatra'
require 're_duxml'

include ReDuxml

# origin_domains = 'https://dry-draw.firebaseapp.com http://localhost:3000'
origin_domains = '*'

options '*' do
    response.headers['Access-Control-Allow-Origin'] = origin_domains
    response['Access-Control-Allow-Origin'] = origin_domains
end

post '/resolveXML' do
  response.headers['Access-Control-Allow-Origin'] = origin_domains
  response['Access-Control-Allow-Origin'] = origin_domains

  doc = Saxer.sax request.body.read
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  response.headers['Access-Control-Allow-Origin'] = origin_domains
  response['Access-Control-Allow-Origin'] = origin_domains

  str = request.body.read
  result = Evaluator.new.evaluate(str, params || {})
  puts "evaluate(#{str}, #{params}) => #{result.to_s}"
  result.to_s
end
