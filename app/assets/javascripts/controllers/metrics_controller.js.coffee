angular.module("maytricsApp").controller 'MetricsController',
  ["$scope", "$routeParams", "$location", "Metrics", "Users",
    ($scope, $routeParams, $location, Metrics, Users, $filter) ->
      $scope.user =
        id: $routeParams.userId
      $scope.loadUser $scope.user.id

      loadMetricsPage = (page) ->
        $scope.metricsPages ||= []
        $scope.search =
          query: $routeParams.search
          page: page
          per: 15
        Metrics.all($routeParams.userId, $scope.search).then (response) ->
          $scope.metricsPages[page - 1] = response.data.metrics

      $scope.$watch "search", (-> loadMetricsPage 1), true

      $scope.create = ->
        metric =
          name: "New metric"
          value: 5

        Metrics.create($scope.currentUser.id, metric).then (response) ->
          $scope.metricsPages[0].unshift response.data.metric

      $scope.delete = (metric) ->
        Metrics.delete($scope.currentUser.id, metric.id).then ->
          $scope.metrics =
            (element for element in $scope.metrics when element != metric)

      $scope.update = (metric) ->
        if (metric.name == "")
          $scope.delete metric
        else
          Metrics.update($scope.currentUser.id, metric.id, metric)
]
