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
      scope.creatable = !scope.metric.id && !scope.inCreate
      scope.startEdit() if scope.creatable

      updateColor()
      scope.resetValue()
    , true

    scope.startEdit = ->
      scope.inEdit = true
      scope.initialValue = scope.metric.name

    scope.cancelEdit = ->
      scope.inEdit = false unless scope.creatable
      scope.metric.name = scope.initialValue

    scope.saveEdit = ->
      scope.onMetricUpdate(scope)
      scope.inEdit = false unless scope.creatable
      scope.initialValue = scope.metric.name

    scope.updateTmpValue = (value) ->
      return unless scope.editable

      if scope.inSelectValue
        scope.tmpValue = value

    scope.setValue = (value) ->
      return unless scope.editable

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
