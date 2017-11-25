require 'sinatra'
require 're_duxml'

post '/resolveXML' do
  xml = request.body.read
  # TODO load xml file
  # instantiate
  # respond to client
end

post '/evaluateStr' do
  str = request.body.read
  ReDuxml::Evaluator.new.evaluate(str, params)
end
