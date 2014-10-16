angular.module("maemonApp").directive "metric", ["$parse", "Hashtags", "$timeout", ($parse, Hashtags, $timeout) ->
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
      scope.creatable = !scope.metric.id && !scope.inCreate

      updateColor()
      scope.resetValue()
    , true

    scope.startCreate = ->
      scope.inCreate = true
      scope.creatable = false
      scope.startEdit()

    scope.startEdit = ->
      scope.inEdit = true
      $timeout ->
        element.find("input")[0].focus()

    scope.stopEdit = ->
      scope.inEdit = false unless scope.inCreate

    scope.saveEdit = ->
      scope.onMetricUpdate(scope)
      scope.stopEdit()

    scope.updateTmpValue = (value) ->
      if scope.inSelectValue
        scope.tmpValue = value

    scope.setValue = (value) ->
      if scope.inSelectValue
        scope.metric.value = value
        scope.inSelectValue = false

        if scope.metric.id
          scope.onMetricUpdate(scope)


    scope.deleteMetric = ->
      scope.onMetricDelete(scope)

    scope.resetValue = ->
      scope.tmpValue = scope.metric.value
]
