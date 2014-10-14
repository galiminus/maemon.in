app.factory 'Faye', ['$faye', ($faye) ->
  $faye("/events")
]
