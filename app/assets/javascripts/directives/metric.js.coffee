angular.module("maytricsApp").directive "metric", ["$parse", ($parse) ->
  restrict: "E"
  templateUrl: "metric.html"
  link: (scope, element, attributes) ->
    scope.onMetricUpdate = $parse(attributes.onMetricUpdate)
    scope.onMetricDelete = $parse(attributes.onMetricDelete)

    scope.$watch attributes.editableIf, (value) ->
      scope.editable = value

    scope.$watch attributes.metric, (metric) ->
      if metric
        scope.metric = metric
        scope.resetValue()

    scope.updateTmpValue = (value) ->
      scope.tmpValue = value

    scope.updateMetric = (metric) ->
      scope.showOptions = false
      scope.onMetricUpdate(scope)

    scope.setValue = (value) ->
      scope.metric.value = value
      scope.onMetricUpdate(scope)

    scope.deleteMetric = ->
      scope.onMetricDelete(scope)

    scope.resetValue = ->
      scope.tmpValue = scope.metric.value
]