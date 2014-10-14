angular.module("maemonApp").factory 'Faye', ['$faye', ($faye) ->
  $faye("/events")
]
