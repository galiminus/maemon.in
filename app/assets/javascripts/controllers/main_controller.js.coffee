angular.module("maemonApp").controller 'MainController',
  [ "$scope"
    "$q"
    "Users"
    "Relationships"
    "$routeParams"
    "$location"
    "Faye",
    ($scope, $q, Users, Relationships, $routeParams, $location, Faye) ->
      $scope.userLoaded = Users.get($routeParams.userId).then (user) ->
        $scope.user = user.data.user

      $scope.currentUserLoaded = Users.getCurrent().then (user) ->
        $scope.currentUser = user.data.user
        Relationships.all($scope.currentUser.id).then (relationships) ->
          $scope.currentUser.relationships = relationships.data.relationships

      $scope.updateUser = (user) ->
        Users.update(user.id, $scope.user)

      $scope.goToUser = (user) ->
        $location.path "#{user.originalObject.id}"
]
