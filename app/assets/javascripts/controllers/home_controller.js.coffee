angular.module("maytricsApp").controller 'HomeController',
  ["$scope", "$location", ($scope, $location) ->
    $scope.$on 'logged.in', (_, currentUser) ->
      $location.path "#{currentUser.id}"
]
