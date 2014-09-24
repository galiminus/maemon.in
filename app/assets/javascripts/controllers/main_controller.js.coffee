angular.module("maytricsApp").controller 'MainController',
  ["$scope", "Users", "$routeParams", "$location", ($scope, Users, $routeParams, $location) ->
    Users.getCurrent().then (user) ->
      $scope.currentUser = user.data.user
      $scope.$broadcast 'logged.in', $scope.currentUser

    $scope.loadUser = (userId) ->
      Users.get(userId).then (user) ->
        $scope.user = user.data.user

    $scope.updateUser = (user) ->
      Users.update(user.id, $scope.user)

    $scope.goToUser = (user) ->
      $location.path "#{user.originalObject.id}"
]
