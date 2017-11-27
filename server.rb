require 'sinatra'
require 're_duxml'

include ReDuxml

post '/resolveXML' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response['Access-Control-Allow-Origin'] = '*'

  doc = Saxer.sax request.body.read
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response['Access-Control-Allow-Origin'] = '*'

  str = request.body.read
  result = Evaluator.new.evaluate(str, params || {})
  puts "evaluate(#{str}, #{params}) => #{result.to_s}"
  result.to_s
end
