//= require d3

$(function() {
  var dataset = []; //建立空的資料陣列

  for (var i = 0; i < 20; i++) {
    var newNum = 5 + Math.floor(Math.random() * 30);
    dataset.push(newNum);
  }
  d3.select('.graph-1').selectAll('div')
    .data(dataset)
    .enter()
    .append('div')
    .attr('class', 'bar')
    .style('height', function(d) { //將data的值取出作為高
      return (d * 3) + 'px';
    });
});

$(function() {
  var w = 600,
    h = 250;
  var dataset = [];

  for (var i = 0; i < 20; i++) {
    var num1 = Math.floor(5 + Math.random() * 480);
    var num2 = Math.floor(5 + Math.random() * 230);
    dataset.push([num1, num2]);
  }
  //開始畫圖

  var svg = d3.select('.graph-2').append('svg')
    .attr({
      'width': w,
      'height': h
    });
  svg.selectAll('circle').data(dataset).enter()
    .append('circle')
    .attr({
      'cx': function(d) {
        return d[0] + 10;
      },
      'cy': function(d) {
        return d[1] + 10;
      },
      'r': function(d) {
        return Math.sqrt(h - d[1]);
      },
      'fill': function(d) {
        return d3.hsl(d[0] % 360, 0.6, 0.6);
      }
    });

  //把字標上去
  svg.selectAll('text').data(dataset).enter() //補上資料數值
    .append('text')
    .text(function(d) {
      return d[0] + ',' + d[1];
    }) //將值寫到SVG上
    .attr({
      'x': function(d) {
        return d[0];
      }, //和上面相同，算出X、Y的位置
      'y': function(d) {
        return d[1];
      },
      'fill': 'red', //文字填滿為紅色
      'font-size': '10px' //Fill、font-size也可以用CSS寫喔～
    });


});


// Sclae練習

$(function() {
  var w = 650,
    h = 250,
    padding = 20;
  var dataset = [];
  for (var i = 0; i < 20; i++) {
    var Num1 = 5 + Math.floor(Math.random() * 900);
    var Num2 = 5 + Math.floor(Math.random() * 220);
    dataset.push([Num1, Num2]);
  }

  //max

  var Xmax = d3.max(dataset, function(d) {
      return d[0];
    }),
    Xmin = d3.min(dataset, function(d) {
      return d[1];
    }),
    Ymax = d3.max(dataset, function(d) {
      return d[1];
    }),
    Ymin = d3.min(dataset, function(d) {
      return d[1];
    });

  // console.log("Xmax: " + Xmax);
  // console.log("Xmin: " + Xmin);
  // console.log("Ymax: " + Ymax);
  // console.log("Ymin: " + Ymin);

  var xScale = d3.scale.linear()
    .domain([Xmin, Xmax])
    .range([padding, w - padding]);

  var yScale = d3.scale.linear()
    .domain([Ymin, Ymax])
    .range([h - padding, padding]);

  var svg = d3.select('.graph-3').append('svg')
    .attr({
      'width': w,
      'height': h
    });

  svg.selectAll('circle').data(dataset).enter()
    .append('circle')
    .attr({
      'cx': function(d) {
        return xScale(d[0]);
      },
      'cy': function(d) {
        return yScale(d[1]);
      },
      'r': function(d) {
        return Math.sqrt(h - d[1]);
      },
      'fill': function(d) {
        return d3.hsl(d[0] % 360, .6, .6);
      }
    });

  svg.selectAll('text').data(dataset).enter()
    .append('text')
    .text(function(d) {
      return d[0] + ',' + d[1];
    })
    .attr({
      'x': function(d) {
        return xScale(d[0]);
      },
      'y': function(d) {
        return yScale(d[1]);
      },
      'fill': 'black',
      'font-size': '10px'
    });
});

//長條圖練習
$(function() {
  var w = 700,
    h = 250,
    padding = 30,
    barMargin = 5;

  var dataset = [];
  for (var i = 0; i < 20; i++) {
    var num1 = 5 + Math.floor(Math.random() * 255);
    dataset.push(num1);
  }

  var barWidth = (w - padding * 2) / dataset.length - barMargin;

  var Ymax = d3.max(dataset, function(d) {
      return d;
    }),
    Ymin = d3.min(dataset, function(d) {
      return d;
    });

  var xScale = d3.scale.linear()
    .domain([0, dataset.length])
    .range([padding, w - padding]);
  var yScale = d3.scale.linear()
    .domain([Ymin, Ymax])
    .range([h - padding, padding]);

  var svg = d3.select('.bar-chart').append('svg').attr({
    'width': w,
    'height': h
  });

  svg.selectAll('rect').data(dataset).enter()
    .append('rect')
    .attr({
      'x': function(d, i) {
        return xScale(i);
      },
      'y': function(d) {
        return h - yScale(d);
      },

      'width': barWidth,
      'height': function(d) {
        return yScale(d);
      },
      'fill': function(d) {
        var color = 0.2 + d * 0.002;
        return d3.hsl(200, color, color);
      }
    });

  svg.selectAll('text').data(dataset).enter()
    .append('text').text(function(d) {
      return d;
    })
    .attr({
      'x': function(d, i) {
        return xScale(i) + barWidth / 2;
      },
      'y': function(d) {
        return h - yScale(d) + 15;
      },
      'text-anchor': 'middle',
      'fill': 'white',
      'font-size': '10px'
    });


});


// import json的長條圖練習(各分類以及各媒體的總計)

$(function() {
  $.getJSON("/admin/posts/statistics.json", function(d) {
    // console.log(d.classifications);
    // console.log(d.countries);
    // console.log(d.post_info);
    // console.log(d.classifications_total);
    // console.log(d.country_classifications_total);
    var dataset = d.post_info;
    var w = 1000,
      h = 250,
      padding = 30,
      barMargin = 10;

    var Ymax = d3.max(dataset, function(d) {
        return d[2];
      }),
      Ymin = d3.min(dataset, function(d) {
        return d[2];
      });
    var xScale = d3.scale.linear()
      .domain([0, dataset.length])
      .range([padding, w - padding]),
      yScale = d3.scale.linear()
      .domain([Ymin, Ymax])
      .range([padding, h - padding]);
    var colorScale = d3.scale.linear()
      .domain([Ymin, Ymax])
      .range([Ymin, Ymax]);

    var barWidth = (w - padding * 2) / dataset.length - barMargin;

    // console.log("Ymax: " + Ymax);
    // console.log("Ymin: " + Ymin);

    var svg = d3.select('.posts-chart').append('svg')
      .attr({
        'width': w,
        'height': h
      });

    svg.selectAll('rect').data(dataset).enter()
      .append('rect')
      .attr({
        'x': function(d, i) {
          return xScale(i);
        },
        'y': function(d) {
          return h - yScale(d[2]);
        },
        'width': barWidth,
        'height': function(d) {
          return yScale(d[2]);
        },
        'fill': function(d) {
          var color = 0.2 + colorScale(d[2]);
          return d3.hsl(200, color, 0.8);
        },
        'title': function(d) {
          return 'Name : ' + d[0] + " " + d[1];
        }
      });
    svg.selectAll('text').data(dataset).enter()
      .append('text')
      .text(function(d) {
        return d[2];
      }).attr({
        'x': function(d, i) {
          return xScale(i) + barWidth / 2;
        },
        'y': function(d) {
          return h - yScale(d[2]) + 15;
        },
        'fill': 'black',
        'text-anchor': 'middle',
        'font-size': '10px'
      });



  });
});

// axis-practice

$(function() {
  var w = 600,
    h = 400,
    padding = 30;
  var dataset = [];
  var numDataPoints = 100;
  var xRange = Math.random() * 500;
  var yRange = Math.random() * 200;

  for (var i = 0; i < numDataPoints; i++) {
    var num1 = Math.floor(Math.random() * xRange);
    var num2 = Math.floor(Math.random() * yRange);

    dataset.push([num1, num2]);
  }

  var Xmax = d3.max(dataset, function(d) {
      return d[0];
    }),
    Xmin = d3.min(dataset, function(d) {
      return d[0];
    }),
    Ymax = d3.max(dataset, function(d) {
      return d[1];
    }),
    Ymin = d3.min(dataset, function(d) {
      return d[1];
    });
  // console.log(Xmax);
  // console.log(Xmin);
  // console.log(Ymax);
  // console.log(Ymin);

  var xScale = d3.scale.linear()
    .domain([Xmin, Xmax])
    .range([padding, w - padding]),
    yScale = d3.scale.linear()
    .domain([Ymin, Ymax])
    .range([h - padding, padding]);

  var svg = d3.select('.axis-practice').append('svg').attr({
    'width': w,
    'height': h
  });

  svg.selectAll('circle').data(dataset).enter()
    .append('circle').attr({
      'cx': function(d) {
        return xScale(d[0]);
      },
      'cy': function(d) {
        return yScale(d[1]);
      },
      'r': '2px',
      'fill': 'red'
    });
  var xAxis = d3.svg.axis().scale(xScale) //增加軸線物件，並套用尺度(x)
    .orient("bottom") //標示位置
    .ticks(6); //刻度數量

  var yAxis = d3.svg.axis().scale(yScale) //增加軸線物件，並套用尺度(y)
    .orient("left") //標示位置
    .ticks(10); //刻度數量

  svg.append('g').attr('class', 'axis') //增加一個群組並加上class="axis"
    .attr('transform', 'translate(0, ' + (h - padding) + ')') //移動到下方
    .call(xAxis); //將軸線匯入

  svg.append('g').attr('class', 'axis')
    .attr('transform', 'translate(' + (padding) + ')', 0) //移動到左方
    .call(yAxis);
});


// line-chart

$(function() {
  var w = 600,
    h = 500;
  var i = 0;
  var svg = d3.select(".touch-chart").append("svg")
    .attr({
      'width': w,
      'height': h
    });

  svg.append('rect').attr({
    'width': w,
    'height': h
  }).on("ontouchstart" in document ? "touchmove" : "mousemove", particle);

  function particle() {
    var m = d3.mouse(this);

    svg.insert("circle", "rect")
      .attr("cx", m[0])
      .attr("cy", m[1])
      .attr("r", 1e-6)
      .style("stroke", d3.hsl((i = (i + 1) % 360), 1, .5))
      .style("stroke-opacity", 1)
      .transition()
      .duration(2000)
      .ease(Math.sqrt)
      .attr("r", 100)
      .style("stroke-opacity", 1e-6)
      .remove();

    d3.event.preventDefault();
  }
});


//real pie

$(function() {
  $.getJSON("/admin/posts/statistics.json", function(d) {
    var w = 400;
    var h = 400;

    var svg = d3.select('.real-chart').append('svg') //插入SVG
      .attr('width', w)
      .attr('height', h)
      .append("g")
      .attr("transform", "translate(" + w / 2 + "," + h / 2 + ")");;

    var posts = d.posts;
    var classifications = d.classifications;
    var countries = d.countries;

    var classify_group = groupBy('classification', classifications);
    var country_group = groupBy('country_classification', countries);

    //開始畫圖
    var r = h / 2;
    var color = d3.scale.category20c();
    var arc = d3.svg.arc()
      .outerRadius(r - 10)
      .innerRadius(0);
    var pie = d3.layout.pie()
      .sort(null)
      .value(function(d) {
        return d[1].length;
      });

    var g = svg.selectAll(".arc")
      .data(pie(classify_group))
      .enter().append("g")
      .attr("class", "arc");

     g.append("path")
      .attr("d", arc)
      .style("fill", function(d,i){return color(i)});

    g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d[1].length) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d[0]; });

    function groupBy(dividerName, dividerSet) {
      var result = [];
      for (var i = 0; i < dividerSet.length; i++) {
        var posts_collection = [];
        for (var j = 0; j < posts.length; j++) {
          if (posts[j][dividerName] == dividerSet[i][1]) {
            posts_collection.push(posts[j]);
          }
        }
        result.push([dividerSet[i][0], posts_collection]);
      }
      return result;
    }

  });
});