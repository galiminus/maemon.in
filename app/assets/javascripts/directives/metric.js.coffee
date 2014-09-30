angular.module("maytricsApp").directive "metric", ["$parse", "Hashtags", ($parse, Hastags) ->
  restrict: "E"
  templateUrl: "metric.html"
  link: (scope, element, attributes) ->
    scope.onMetricUpdate = $parse(attributes.onMetricUpdate)
    scope.onMetricDelete = $parse(attributes.onMetricDelete)

    scope.$watch attributes.editableIf, (value) ->
      scope.editable = value


    updateColor = ->
      metricHashtags = Hastags.extract(scope.metric)

      scope.colorClass = "color-0"
      if metricHashtags
        position = scope.hashtags.indexOf(metricHashtags[0].substr(1)) + 1
        scope.colorClass = "color-#{position}"

    scope.$watch attributes.metric, (metric) ->
      return unless metric

      scope.metric = metric

      updateColor()
      scope.resetValue()
    , true

    scope.$watch "hashtags", (hashtags) ->
      return unless hashtags

      updateColor()
    , true

    scope.updateTmpValue = (value) ->
      scope.tmpValue = value

    scope.updateMetric = (metric) ->
      scope.showOptions = false
      scope.inEdit = false
      scope.onMetricUpdate(scope)

    scope.setValue = (value) ->
      scope.metric.value = value
      scope.onMetricUpdate(scope)

    scope.deleteMetric = ->
      scope.onMetricDelete(scope)

    scope.resetValue = ->
      scope.tmpValue = scope.metric.value
]