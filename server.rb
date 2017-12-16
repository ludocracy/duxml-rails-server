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

post '/resolveJSON' do
  json = JSON.parse(request.body.read)['json']
  xml = Element.new('e')
  xml << json.to_json
  result = resolve(xml, params).text
  # TODO this is temporary and assumes a flat JSON object corresponding to flat SVG XML
  resolvedJSON = JSON.parse(result)
  filteredJSON = resolvedJSON.keep_if do |obj|
    obj.delete('if') if obj['if'] == 'true'
    obj['if'] != 'false'
  end
  filteredJSON.to_json
end

post '/resolveXML' do
  xmlStr = JSON.parse(request.body.read)["xml"]
  doc = Saxer.sax xmlStr
  resolve(doc, params).to_s
end

post '/evaluateStr' do
  str = JSON.parse(request.body.read)["expression"]
  result = Evaluator.new.evaluate(str, params || {})
  result.to_s
end
