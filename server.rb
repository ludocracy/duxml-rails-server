require 'sinatra'
require 're_duxml'

include ReDuxml

@e = Evaluator.new

post '/resolveXML' do
  doc = Saxer.sax request.body.read
  puts params
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  str = request.body.read
  Evaluator.new.evaluate(str, params)
end
