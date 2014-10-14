angular.module("maemonApp").controller 'MetricsController',
  ["$scope", "$routeParams", "$location", "Metrics", "Users",
    ($scope, $routeParams, $location, Metrics, Users, $filter) ->
      $scope.user =
        id: $routeParams.userId
      $scope.loadUser $scope.user.id

      $scope.loadMetricsPage = (page) ->
        $scope.metricsPages ||= []
        search =
          query: $scope.query
          page: page
          per: 15
        Metrics.all($routeParams.userId, search).then (response) ->
          $scope.totalPages = response.data.meta.pagination.total_pages
          $scope.totalCount = response.data.meta.pagination.total_count

          if page <= $scope.totalPages
            $scope.metricsPages[page - 1] = response.data

      $scope.query = $routeParams.search
      $scope.$watch "query", (-> $scope.loadMetricsPage 1), true

      $scope.create = ->
        metric =
          name: "New metric"
          value: 5

        $scope.metricsPages[0].metrics.unshift metric
        Metrics.create($scope.currentUser.id, metric).then (response) ->
          metric.id = response.data.metric.id

      $scope.delete = (page, metric) ->
        Metrics.delete($scope.currentUser.id, metric.id).then ->
          page.metrics =
            (element for element in page.metrics when element != metric)

      $scope.update = (metricsPage, metric) ->
        if (metric.name == "")
          $scope.delete metricsPage, metric
        else
          Metrics.update($scope.currentUser.id, metric.id, metric)
]
