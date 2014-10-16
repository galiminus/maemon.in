app = angular.module("maemonApp",
  [
    "templates"
    "ngRoute"
    "rt.encodeuri"
    "faye"
  ])
app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/:userId',
      templateUrl: "metrics.html"
      controller: "MetricsController"
    .when '/:userId/search/:search',
      templateUrl: "metrics.html"
      controller: "MetricsController"
    .when '/:userId/notifications',
      templateUrl: "notifications.html"
      controller: "NotificationsController"
]
app.config ['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true);
]
