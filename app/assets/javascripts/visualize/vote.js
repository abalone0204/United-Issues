//= require d3
$(function() {
  $.getJSON("/democracy_issues/results.json", function(json_data) {
    console.log(json_data.votes);
    console.log(typeof json_data.votes);
    var w = 300;
    var h = 300;
    var r = h / 2;
    // var color = [rgba(143,203,220,1), rgba(237,183,131,1), rgba(147,201,174,1)];
    var color = ['#8FCBDC',  '#EDB783', '#93C9AE'];
    var data = json_data.votes;


    var vis = d3.select('#pie-chart').append("svg:svg").data([data]).attr("width", w).attr("height", h).append("svg:g").attr("transform", "translate(" + r + "," + r + ")");
    var pie = d3.layout.pie().value(function(d) {
      return d.value;
    });

    // declare an arc generator function
    var arc = d3.svg.arc().outerRadius(r);

    // select paths, use arc generator to draw
    var arcs = vis.selectAll("g.slice").data(pie).enter().append("svg:g").attr("class", "slice");
    arcs.append("svg:path")
      .attr("fill", function(d, i) {
        return color[i];
      })
      .attr("d", function(d) {
        // log the result of the arc generator to show how cool it is :)
        console.log(arc(d));
        return arc(d);
      });

    // add the text
    arcs.append("svg:text").attr("transform", function(d) {
      d.innerRadius = 0;
      d.outerRadius = r;
      return "translate(" + arc.centroid(d) + ")";
    }).attr("text-anchor", "middle").text(function(d, i) {
      return data[i].label;
    });
  });

});