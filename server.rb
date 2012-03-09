
require 'sinatra' 
require 'sinatra/reloader'
require 'json' 

use Rack::Deflater

# stubbing call to google spreadsheet and run it on the localhost
get '/' do 

  headers.merge!({
    "cache-control" => "private, max-age=122",
    "content-type" => "application/x-javascript; charset=UTF-8",
    "date" => "Thu, 08 Mar 2012 04:06:52 GMT",
    "expires" => "Thu, 08 Mar 2012 04:06:52 GMT",
    "server" => "GSE",
    "status" => "200 OK",
    "version" => "HTTP/1.1",
    "x-content-type-options" => "nosniff",
    "x-xss-protection" => "1; mode=block"
  })

stub = <<eos 
google.visualization.Query.setResponse({"version":"0.6","status":"ok","sig":"565811536","table":{"cols":[{"id":"A","label":"Month","type":"string","pattern":""},{"id":"B","label":"2008","type":"number","pattern":"#0.###############"},{"id":"C","label":"2009","type":"number","pattern":"#0.###############"},{"id":"D","label":"2010","type":"number","pattern":"#0.###############"},{"id":"E","label":"10-Years Average","type":"number","pattern":"#0.###############"}],"rows":[{"c":[{"v":"Jan"},{"v":145.0,"f":"145"},{"v":156.0,"f":"156"},{"v":160.0,"f":"160"},{"v":149.2,"f":"149.2"}]},{"c":[{"v":"Feb"},{"v":251.0,"f":"251"},{"v":201.0,"f":"201"},{"v":245.0,"f":"245"},{"v":250.3,"f":"250.3"}]},{"c":[{"v":"Mar"},{"v":173.0,"f":"173"},{"v":210.0,"f":"210"},{"v":201.0,"f":"201"},{"v":211.3,"f":"211.3"}]},{"c":[{"v":"Apr"},{"v":59.0,"f":"59"},{"v":87.0,"f":"87"},{"v":90.0,"f":"90"},{"v":73.5,"f":"73.5"}]},{"c":[{"v":"May"},{"v":7.0,"f":"7"},{"v":0.0,"f":"0"},{"v":4.0,"f":"4"},{"v":5.3,"f":"5.3"}]},{"c":[{"v":"Jun"},{"v":0.0,"f":"0"},{"v":0.0,"f":"0"},{"v":0.0,"f":"0"},{"v":0.5,"f":"0.5"}]},{"c":[{"v":"Jul"},{"v":0.0,"f":"0"},{"v":2.0,"f":"2"},{"v":0.0,"f":"0"},{"v":0.7,"f":"0.7"}]},{"c":[{"v":"Aug"},{"v":0.0,"f":"0"},{"v":0.0,"f":"0"},{"v":0.0,"f":"0"},{"v":0.2,"f":"0.2"}]},{"c":[{"v":"Sep"},{"v":11.0,"f":"11"},{"v":15.0,"f":"15"},{"v":21.0,"f":"21"},{"v":12.3,"f":"12.3"}]},{"c":[{"v":"Oct"},{"v":7.0,"f":"7"},{"v":33.0,"f":"33"},{"v":25.0,"f":"25"},{"v":26.2,"f":"26.2"}]},{"c":[{"v":"Nov"},{"v":37.0,"f":"37"},{"v":41.0,"f":"41"},{"v":63.0,"f":"63"},{"v":40.3,"f":"40.3"}]},{"c":[{"v":"Dec"},{"v":122.0,"f":"122"},{"v":101.0,"f":"101"},{"v":99.0,"f":"99"},{"v":111.1,"f":"111.1"}]}]}});
eos

end
