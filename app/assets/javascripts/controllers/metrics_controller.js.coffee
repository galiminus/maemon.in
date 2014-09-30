angular.module("maytricsApp").controller 'MetricsController',
  ["$scope", "$routeParams", "$location", "Metrics", "Users", "Hashtags",
    ($scope, $routeParams, $location, Metrics, Users, Hashtags, $filter) ->
      $scope.search = if $routeParams.search then "##{$routeParams.search}" else ""
      $scope.user =
        id: $routeParams.userId
      $scope.loadUser $scope.user.id

      Metrics.all($routeParams.userId).then (response) ->
        $scope.metrics = response.data.metrics.sort (metric1, metric2) ->
          metric1.id < metric2.id

        $scope.$watch "metrics", ->
          $scope.hashtags = Hashtags.extractAll $scope.metrics
        , true

        $scope.create = ->
          metric =
            name: "New metric"
            value: 5

          Metrics.create($scope.currentUser.id, metric).then (response) ->
            $scope.metrics.unshift response.data.metric
            $scope.loadViewport $scope.page

        $scope.delete = (metric) ->
          Metrics.delete($scope.currentUser.id, metric.id).then ->
            $scope.metrics =
              (element for element in $scope.metrics when element != metric)
            $scope.loadViewport $scope.page

        $scope.update = (metric) ->
          if (metric.name == "")
            $scope.delete metric
          else
            Metrics.update($scope.currentUser.id, metric.id, metric)

        $scope.loadViewport = (page) ->
          perPage = 21
          $scope.metricsViewport = $scope.metrics[0..((page + 1) * perPage - 1)]

        $scope.page = 0
        $scope.loadMore = ->
          $scope.page++
          $scope.loadViewport $scope.page
        $scope.loadMore()
]
