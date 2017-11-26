require 'sinatra'
require 're_duxml'

include ReDuxml

post '/resolveXML' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  doc = Saxer.sax request.body.read
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  str = request.body.read
  Evaluator.new.evaluate(str, params).to_s
end
