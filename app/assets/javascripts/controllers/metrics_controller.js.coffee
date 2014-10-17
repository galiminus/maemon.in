angular.module("maemonApp").controller 'MetricsController',
  ["$scope", "$routeParams", "$location", "Metrics", "Users",
    ($scope, $routeParams, $location, Metrics, Users, $filter) ->
      $scope.user =
        id: $routeParams.userId
      $scope.loadUser $scope.user.id

      $scope.loadMetricsPage = (page) ->
        $scope.metricsPages ||= [{metrics: []}]
        search =
          query: $scope.query
          page: page
          per: if page == 1 && $scope.isMe() then 14 else 15
        Metrics.all($routeParams.userId, search).then (response) ->
          $scope.totalPages = response.data.meta.pagination.total_pages
          $scope.totalCount = response.data.meta.pagination.total_count

          if page <= $scope.totalPages
            $scope.metricsPages[page - 1] = response.data
          if page == 1 && $scope.isMe()
            $scope.create()

      $scope.query = $routeParams.search
      $scope.$watch "query", (-> $scope.loadMetricsPage 1), true

      $scope.create = ->
        metric =
          name: ""
          value: 0
        $scope.metricsPages[0].metrics.unshift metric

      $scope.delete = (page, metric) ->
        page.metrics =
          (element for element in page.metrics when element != metric)
        Metrics.delete($scope.currentUser.id, metric.id).then ->

      $scope.update = (metricsPage, metric) ->
        if (metric.name == "")
          $scope.delete metricsPage, metric
        else
          if metric.id
            Metrics.update($scope.currentUser.id, metric.id, metric)
          else
            Metrics.create($scope.currentUser.id, metric).then (response) ->
              metric.id = response.data.metric.id
              $scope.create()
]
