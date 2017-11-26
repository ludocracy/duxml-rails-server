require 'sinatra'
require 're_duxml'

include ReDuxml

post '/resolveXML' do
  doc = Saxer.sax request.body.read
  answer = resolve(doc, params).to_s
  puts "answer=#{answer}"
end

post '/evaluateStr' do
  str = request.body.read
  Evaluator.new.evaluate(str, params).to_s
end
