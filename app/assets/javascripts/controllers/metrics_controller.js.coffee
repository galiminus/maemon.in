angular.module("maytricsApp").controller 'MetricsController',
  ["$scope", "$routeParams", "Metrics", "Users"
    ($scope, $routeParams, Metrics, Users) ->
      $scope.loadUser $routeParams.userId

      Metrics.all($routeParams.userId).then (response) ->
        $scope.metrics = response.data.metrics

        $scope.create = ->
          metric =
            name: "New metric",
            value: 5,

          Metrics.create($scope.currentUser.id, metric).then (response) ->
            $scope.metrics.unshift response.data.metric

        $scope.delete = (metric) ->
          Metrics.delete($scope.currentUser.id, metric.id).then ->
            $scope.metrics =
              (element for element in $scope.metrics when element != metric)

        $scope.update = (metric) ->
          Metrics.update($scope.currentUser.id, metric.id, metric)
]
