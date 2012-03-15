
require 'sinatra' 
require 'sinatra/reloader'
require 'json' 
require 'cgi'
use Rack::Deflater


before do 
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
end

# stubbing call to google spreadsheet and run it on the localhost
get '/*' do 
  count = {:accountID => 123, :count => 4}

  data = [{:time => "Feb 7", :hits => rand(50)},
          {:time => "Feb 8", :hits => rand(50)},
          {:time => "Feb 9", :hits => rand(50)},
          {:time => "Feb 10", :hits => rand(50)},
          {:time => "Feb 11", :hits => rand(50)},
          {:time => "Feb 12", :hits => rand(50)},
          {:time => "Feb 13", :hits => rand(50)}]

=begin
  class Array
    def shuffle!
      size.downto(1) { |n| push delete_at(rand(n))}
      self
    end
  end
  data.shuffle!
=end  
  count.merge! ({:dataPoints => data})
  count.to_json
end

