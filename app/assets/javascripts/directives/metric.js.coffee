angular.module("maemonApp").directive "metric", ["$parse", "Hashtags", ($parse, Hashtags) ->
  restrict: "E"
  templateUrl: "metric.html"
  link: (scope, element, attributes) ->
    scope.onMetricUpdate = $parse(attributes.onMetricUpdate)
    scope.onMetricDelete = $parse(attributes.onMetricDelete)

    scope.$watch attributes.editableIf, (value) ->
      scope.editable = value

    updateColor = ->
      metricHashtags = Hashtags.extract(scope.metric)
      if metricHashtags
        color = Hashtags.getColor(metricHashtags[0].substr(1))
        scope.style = { 'border-bottom-color': "##{color}" }
    scope.$watch attributes.metric, (metric) ->
      return unless metric

      scope.metric = metric

      updateColor()
      scope.resetValue()
    , true

    scope.updateTmpValue = (value) ->
      if scope.inEdit
        scope.tmpValue = value

    scope.updateMetric = (metric) ->
      scope.onMetricUpdate(scope)

    scope.setValue = (value) ->
      if scope.inEdit
        scope.metric.value = value
        scope.onMetricUpdate(scope)
        scope.inEdit = false

    scope.deleteMetric = ->
      scope.onMetricDelete(scope)

    scope.resetValue = ->
      scope.tmpValue = scope.metric.value
]
