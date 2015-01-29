angular.module("maemonApp").controller 'HeaderController',
  [ "$scope", "$q", ($scope, $q) ->
    $q.all([$scope.userLoaded, $scope.currentUserLoaded]).then ->
      $scope.follow = (user) ->
        Relationships.create($scope.currentUser.id, followed_id: user.id).then (relationship) ->
          $scope.relationship = relationship.data.relationship

      $scope.unfollow = (user) ->
        Relationships.delete($scope.currentUser.id, user.id).then (relationship) ->
          $scope.relationship = false

      $scope.userQuery = ""
      $scope.$watch "userQuery", (query) ->
        search =
          query: query
          page: 1
          per: 20
        Users.all(search).then (response) ->
          $scope.users = response.data.users
      , true

      $scope.editUserName = ->
        $scope.inEditUserName = true

      $scope.stopEditUserName = ->
        $scope.inEditUserName = false
]
