require 'sinatra'
require 're_duxml'
require 'sinatra/cross_origin'

include ReDuxml

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options "*" do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

post '/resolveXML' do
  cross_origin
  doc = Saxer.sax request.body.read
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  cross_origin
  str = request.body.read
  Evaluator.new.evaluate(str, params).to_s
end
