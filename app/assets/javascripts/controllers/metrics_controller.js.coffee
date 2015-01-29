angular.module("maemonApp").controller 'MetricsController',
  [ "$scope"
    "$q"
    "$routeParams"
    "$location"
    "Relationships"
    "Metrics"
    "Users"
    "Faye",
    ($scope, $q, $routeParams, $location, Relationships, Metrics, Users, Faye) ->
      $q.all([$scope.userLoaded, $scope.currentUserLoaded]).then ->
        Relationships.get($scope.currentUser.id, $scope.user.id).then (relationship) ->
          $scope.relationship = relationship.data.relationship
        $scope.loaded = true

        $scope.loadMetricsPage = (page) ->
          $scope.metricsPages ||= [{metrics: []}]
          search =
            query: $scope.query
            page: page
            per: if page == 1 && ($scope.user.id == $scope.currentUser.id) then 14 else 15
          Metrics.all($scope.user.userId, search).then (response) ->
            $scope.totalPages = response.data.meta.pagination.total_pages
            $scope.totalCount = response.data.meta.pagination.total_count

            if page <= $scope.totalPages
              $scope.metricsPages[page - 1] = response.data
            if page == 1 && $scope.user.id == $scope.currentUser.id
              $scope.totalPages = 1 if $scope.totalPages == 0
              $scope.create()

        $scope.query = $routeParams.search
        $scope.$watch "query", (-> $scope.loadMetricsPage 1), true

        $scope.create = ->
          metric =
            name: ""
            value: 0
          $scope.metricsPages[0].metrics.unshift metric

        $scope.delete = (page, metric) ->
          Metrics.delete($scope.currentUser.id, metric.id).then ->
            page.metrics =
              (element for element in page.metrics when element != metric)

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
