angular.module("maytricsApp").controller 'MainController',
  ["$scope", "Users", "$routeParams", ($scope, Users, $routeParams) ->
    Users.getCurrent().then (user) ->
      $scope.currentUser = user.data.user
      $scope.$broadcast 'logged.in', $scope.currentUser

    $scope.loadUser = (userId) ->
      Users.get(userId).then (user) ->
        $scope.user = user.data.user

    $scope.updateUser = (user) ->
      Users.update(user.id, $scope.user)
]
