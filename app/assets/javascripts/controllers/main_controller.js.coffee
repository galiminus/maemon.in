angular.module("maytricsApp").controller 'MainController',
  ["$scope", "Users", "$routeParams", ($scope, Users, $routeParams) ->
    Users.getCurrent().then (user) ->
      $scope.currentUser = user.data.user
      $scope.$broadcast 'logged.in', $scope.currentUser

    $scope.loadUser = (userId) ->
      Users.getUser(userId).then (user) ->
        $scope.user = user.data.user
]
