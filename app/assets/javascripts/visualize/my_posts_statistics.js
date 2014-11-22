//= require d3
$(function() {

  $.getJSON("/posts/my_posts.json", function(d) {
    var w = 800,
      h = 300,
      padding = 50,
      barMargin = 5;

    var svg = d3.select('.real-chart').append('svg') //插入SVG
      .attr('width', w)
      .attr('height', h);
      console.table(d.my_posts);
    var my_posts = ['我的文章', d.my_posts];

    var posts = d.posts;
    var classifications = d.classifications;
    var countries = d.countries;

    var classify_group = groupBy('classification', classifications);
    var country_group = groupBy('country_classification', countries);
    country_group.push(['', []]);
    console.table(classify_group);
    console.table(my_posts);


    //算出每一個bar的寬度
    barChart(classify_group);
    // barChart(country_group);
    $('.class-btn').on('click', function(e) { //每次點擊的時候
      var dataset = [];
      e.preventDefault();
      param = $(this).data("param");
      if (param === 'classify_group') {
        dataset = classify_group;
      } else {
        dataset = country_group;
      }
      var Ymax = d3.max(dataset, function(d) {
          return d[1].length;
        }),
        Ymin = d3.min(dataset, function(d) {
          return d[1].length;
        });

      var xScale = d3.scale.linear()
        .domain([0, dataset.length])
        .range([padding, w - padding]);
      var yScale = d3.scale.linear()
        .domain([Ymin, Ymax])
        .range([0, h - padding]);

      var barWidth = (w - padding * 2) / dataset.length - barMargin;

      svg.selectAll('rect').data(dataset)
        .transition() //套用動態效果
        .duration(250) //動態持續時間
        .each('start', function() { //過場開始執行
          d3.select(this)
            .attr('fill', '#b33d3c');
        })
        .transition() //套用動態效果
        .duration(1000) //第二段時間
        .attr({
          'x': function(d, i) {
            return xScale(i);
          }, //利用尺度算出X的位置
          'y': function(d) {
            return h - yScale(d[1].length);
          }, //同理算出Y，但是要放在底部，所以要y-yScale(d)
          'width': barWidth, //bar的寬度
          'height': function(d) {
            return yScale(d[1].length);
          }, //高度算法與Y相同
          'fill': function(d, i) {
            var color = '#FECB0A';
            return color;
          }
        });

      svg.selectAll('text').data(dataset)
        .transition() //套用動態效果
        .duration(1000) //第二段時間
        .text(function(d) {
          return d[0];
        }) //將值寫到SVG上
        .attr({
          'x': function(d, i) {
            return xScale(i) + barWidth / 2;
          },
          //和上面相同，算出X、Y的位置
          'y': function(d) {
            return h - yScale(d[1].length) - 10;
          }, //數值放在bar 內
          'fill': 'black',
          'text-anchor': 'middle', //文字置中
          'font-size': '10px' //Fill、font-size也可以用CSS寫喔～
        });
    });

    function barChart(dataset) {
      var Ymax = d3.max(dataset, function(d) {
          return d[1].length;
        }),
        Ymin = d3.min(dataset, function(d) {
          return d[1].length;
        });

      var xScale = d3.scale.linear()
        .domain([0, dataset.length])
        .range([padding, w - padding]);
      var yScale = d3.scale.linear()
        .domain([0, Ymax])
        .range([0, h - padding]);

      var barWidth = (w - padding * 2) / dataset.length - barMargin;
      svg.selectAll('rect').data(dataset).enter()
        .append('rect')
        .attr({
          'x': function(d, i) {
            return xScale(i);
          }, //利用尺度算出X的位置
          'y': function(d) {
            return h - yScale(d[1].length);
          }, //同理算出Y，但是要放在底部，所以要y-yScale(d)
          'width': barWidth, //bar的寬度
          'height': function(d) {
            return yScale(d[1].length);
          }, //高度算法與Y相同
          'fill': function(d, i) {
            var color = '#FECB0A';
            return color;
            // return d3.hsl(200, 0.5, 0.5);
          }
        });
      svg.selectAll('text').data(dataset).enter() //補上資料數值
        .append('text')
        .text(function(d) {
          return d[0];
        }) //將值寫到SVG上
        .attr({
          'x': function(d, i) {
            return xScale(i) + barWidth / 2;
          },
          //和上面相同，算出X、Y的位置
          'y': function(d) {
            return h - yScale(d[1].length) - 10;
          }, //數值放在bar 內
          'fill': 'black', //文字填滿為白色
          'text-anchor': 'middle', //文字置中
          'font-size': '10px' //Fill、font-size也可以用CSS寫喔～
        });


    }


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
      result.push(my_posts);
      return result;
    }
  });


});