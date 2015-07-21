$(document).on 'ready page:load', ->
  className = $("#line-chart").attr("class")
  elementId = 'line-chart-users'
  titleText = '新增用户人数折线图'

  switch(className)
    when 'past_day'
      showLine '/admin/past_day_users_count', elementId, titleText
    when 'past_week'
      showLine '/admin/past_week_users_count', elementId, titleText
    when 'past_month'
      showLine '/admin/past_month_users_count', elementId, titleText
    when 'past_year'
      showLine '/admin/past_year_users_count', elementId, titleText

showLine = (url, elementId, titleText) ->
  $.ajax
    url: url
    success: (count) ->
      require.config paths: { echarts: '/assets/echarts/build/dist' }
      require [
        'echarts'
        'echarts/chart/line'
      ], (ec) ->
        x_data = []
        y_data = []
        $.each count, (key, value) ->
          x_data.push key
          y_data.push value

        myChart = ec.init(document.getElementById(elementId))
        option =
          title: { text: '新增用户人数折线图' }
          tooltip: { trigger: 'axis' }
          xAxis: [
            {
              type: 'category'
              boundaryGap: false
              data: x_data
            }
          ]
          yAxis: [
            {
              type: 'value'
              axisLabel: { formatter: '{value} 千人' }
            }
          ]
          series: [
            {
              name: '注册人数'
              type: 'line'
              data: y_data
              markPoint: data: [
                {
                  type: 'max'
                  name: '最大值'
                }
                {
                  type: 'min'
                  name: '最小值'
                }
              ]
              markLine: data: [
                {
                  type: 'average'
                  name: '平均值'
                }
              ]
            }
          ]

        myChart.setOption option
