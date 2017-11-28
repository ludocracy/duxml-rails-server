require 'sinatra'
require 're_duxml'

include ReDuxml

# origin_domains = 'https://dry-draw.firebaseapp.com http://localhost:3000'
origin_domains = '*'

options '*' do
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  200
end

before do
  response['Access-Control-Allow-Origin'] = origin_domains
  response['Content-Type'] = 'application/json'
end

post '/resolveXML' do
  puts "params = #{params}"
  xmlStr = JSON.parse(request.body.read)["xml"]
  doc = Saxer.sax xmlStr
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  puts "params = #{params}"
  str = JSON.parse(request.body.read)["expression"]
  puts "expression = #{str}"
  result = Evaluator.new.evaluate(str, params || {})
  puts "result = #{result}"
  result.to_s
end
