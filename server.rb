require 'sinatra'
require 're_duxml'
require 'sinatra/cross_origin'

include ReDuxml

configure do
  enable :cross_origin
end

post '/resolveXML' do
  doc = Saxer.sax request.body.read
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  str = request.body.read
  Evaluator.new.evaluate(str, params).to_s
end
