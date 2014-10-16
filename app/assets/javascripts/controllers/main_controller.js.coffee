angular.module("maemonApp").controller 'MainController',
  ["$scope", "Users", "Relationships", "$routeParams", "$location", "Faye", ($scope, Users, Relationships, $routeParams, $location, Faye) ->
    loaded = ->
      conditions = [
        $scope.user
        $scope.currentUser
      ]
      $scope.loaded = true unless (undefined in conditions)

    Users.getCurrent().then (user) ->
      $scope.currentUser = user.data.user
      loaded()

      Relationships.all($scope.currentUser.id).then (relationships) ->
        $scope.currentUser.relationships = relationships.data.relationships

    $scope.loadUser = (userId) ->
      Users.get(userId).then (user) ->
        $scope.user = user.data.user
        Relationships.get($scope.currentUser.id, $scope.user.id).then (relationship) ->
          $scope.relationship = relationship.data.relationship
          loaded()

    $scope.isMe = ->
      if $scope.user && $scope.currentUser
        $scope.user.id == $scope.currentUser.id

    $scope.updateUser = (user) ->
      Users.update(user.id, $scope.user)

    $scope.goToUser = (user) ->
      $location.path "#{user.originalObject.id}"

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
