
(function() {
 
  var el = '#graph'         /* dom ID where SVG element is appended to */
    , w = 400               /* width of the SVG element */
    , h = 200               /* height of the SVG element */
    , margin = 20           /* margin of the SVG element */
    , uri = 'data.json'     /* uri of data source */
    , interval = 50000      /* graph update interval */
    // ===================
    // Do not change below
    // ===================
    , data = []             /* data source */
    , data_max = null       /* numbers of data points */
    , x = null              /* d3 linear function */
    , y = null              /* d3 linear function */
      
      /* parent container of elements */  
    , s = d3.select(el).append("svg:svg").attr('width', w).attr('height', h)
    
      /* group all elements of the graph */
    , g = s.append("svg:g").attr("transform", "translate(0,200)")
     
      /* a line function that draws line on the graph */
    , line = d3.svg.line().x(function(d, i) { return x(i); })
                          .y(function(d) { return -1 * y(d.hits); });
  
  d3.json(uri, function(json) {
    data = json;
    console.log (data);
    if (json === null)
      if (console)
        console.log("Error fetching the data");
  });

  console.log(data);
  var date_stringify = function(utc) {
    var t = utc.split(/[- :]/);
    var format = d3.time.format("%b %d");
    return format(new Date(t[0], t[1]-1, t[2]));
  }
  
  /** x,y marks. mapping data to pixels (used as function) */
  x = d3.scale.linear().domain([0, data.length])
        .range([0 + margin, w - margin]);
  y = d3.scale.linear().domain([0, data_max])
        .range([0 + margin, h - margin]);
            
  /** append the line graph*/
  g.append("svg:path").attr("d", line(data));
  
  var tooltip = d3.select("#graph").append("div")
                  .attr("class", "tooltip")
                  .style("opacity", -1);
                  
  var showTooltip = function (text) {
    tooltip.html(text)
           .transition()
           .duration(500)
           .style("opacity", 1);
  };    
  
  var moveTooltip = function() {
    tooltip.style("left", d3.event.pageX + 5 + "px")
           .style("top", d3.event.pageY + 5 + "px");
  };
  
  var hideTooltip = function() {
    tooltip.transition()
           .duration(500)
           .style("opacity", -1);
  };
  
  /** Append nodes to the line. Use transform on attribute to position the nodes
   *  because d3.js does not support x and y-accessors as of now */
  g.selectAll("path.dot")
    .data(data)
    .enter().append("svg:path")
    .attr("class", "dot")
    .attr("transform", function(d, i) { 
      return "translate(" + x(i) + "," + (-1 * y(d.hits)) + ")";
    })
    .attr("d", d3.svg.symbol())
    .on("mouseover", function(d) {
      showTooltip (date_stringify(d.time) + "<br/>Impression: " + d.hits);
    })
    .on("mousemove", moveTooltip)
    .on("mouseout", hideTooltip);

  /** append the x and y axis */
  var top = -1 * y(data_max),
      bottom = -1 * y(0),
      left = x(0), 
      right = x(w);

  g.append("svg:line")
    .attr("x1", left)
    .attr("y1", bottom) 
    .attr("x2", right)
    .attr("y2", bottom);

  g.append("svg:line")
    .attr("x1", left)
    .attr("y1", bottom)
    .attr("x2", left)
    .attr("y2", top);
    
  /** append the tick marks*/
  g.selectAll(".xTicks")
    .data(x.ticks(data.length))
    .enter().append("svg:line")
    .attr("class", "xTicks")
    .attr("x1", function(d) { return x(d); })
    .attr("x2", function(d) { return x(d); })
    .attr("y1", bottom)
    .attr("y2", -1 * y(-0.3));

  g.selectAll(".yTicks")
     .data(y.ticks(data.length))
     .enter().append("svg:line")
     .attr("class", "yTicks")
     .attr("x1", x(-0.05))
     .attr("x2", x(0))
     .attr("y1", function(d) { return -1 * y(d); })
     .attr("y2", function(d) { return -1 * y(d); });
     
  /** append label for current data input */
  g.selectAll(".xLabel")
    .data(data_time)
    .enter().append("svg:text")
    .attr("class", "xLabel")
    .text(function(d) { return date_stringify(d); })
    .data(x.ticks(data.length))
    .attr("x", function(d) { return x(d) })
    .attr("y", 0)
    .attr("text-anchor", "middle");
    
  g.selectAll(".yLabel")
    .data(y.ticks(data.length))
    .enter().append("svg:text")
    .attr("class", "yLabel")
    .text(String)
    .attr("x", 0)
    .attr("y", function(d) { return -1 * y(d) })
    .attr("text-anchor", "right")
    .attr("dy", 2);

  function update() {
    console.log("Updating graph...");
  }
 
  /*
  setInterval(function() {
  
    update();
  }, 1000); */
  
}).call(this);
