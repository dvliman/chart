
require 'sinatra' 
require 'sinatra/reloader'
require 'json' 

use Rack::Deflater

# stubbing call to google spreadsheet and run it on the localhost
get '/' do 

  headers.merge!({
    "cache-control" => "private, max-age=122",
    "content-type" => "application/json; charset=UTF-8",
    "date" => "Thu, 08 Mar 2012 04:06:52 GMT",
    "expires" => "Thu, 08 Mar 2012 04:06:52 GMT",
    "status" => "200 OK",
    "version" => "HTTP/1.1",
    "x-content-type-options" => "nosniff",
    "x-xss-protection" => "1; mode=block"
  })
response['Access-Control-Allow-Origin'] = '*'
stub = <<eos 
{
  "accountID": "123",
  "count": "4", 
  "dataPoints": [ {"time": "1328072400", "hits":2, "type":"Month"},
                  {"time": "1328115600", "hits":3, "type":"Month"}, 
                  {"time": "1328119200", "hits":4, "type":"Day"},
                  {"time": "1328119200", "hits":1, "type":"Day"},
                  {"time": "1328072300", "hits":12, "type":"Month"}]
}
eos

end
