app = angular.module("maytricsApp",
  [
    "xeditable"
    "ngRoute"
    "ngAnimate"
    "akoenig.deckgrid"
  ])
app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "home.html"
      controller: "HomeController"
    .when '/:userId',
      templateUrl: "metrics.html"
      controller: "MetricsController"
]
app.run ['editableThemes', (editableThemes) ->
  editableThemes.bs3.submitTpl ='<span></span>'
  editableThemes.bs3.cancelTpl ='<span></span>'
]
app.run ['editableOptions', (editableOptions) ->
  editableOptions.theme = 'bs3'
]
