app = angular.module("maytricsApp",
  [
    "templates"
    "xeditable"
    "ngRoute"
    "ngAnimate"
    "rt.encodeuri"
    "angucomplete-alt"
  ])
app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "home.html"
      controller: "HomeController"
    .when '/:userId',
      templateUrl: "metrics.html"
      controller: "MetricsController"
    .when '/:userId/:search',
      templateUrl: "metrics.html"
      controller: "MetricsController"
]
app.config ['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true);
]

app.run ['editableThemes', (editableThemes) ->
  editableThemes.bs3.submitTpl ='<span></span>'
  editableThemes.bs3.cancelTpl ='<span></span>'
]
app.run ['editableOptions', (editableOptions) ->
  editableOptions.theme = 'bs3'
]
