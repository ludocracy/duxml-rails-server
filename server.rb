require 'sinatra'
require 're_duxml'
require 'sinatra/cors'

include ReDuxml


set :allow_origin, "*" #"https://duxml.herokuapp.com https://mysterious-castle-11258.herokuapp.com"

post '/resolveXML' do
  doc = Saxer.sax request.body.read
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  str = request.body.read
  Evaluator.new.evaluate(str, params).to_s
end
