angular.module("maytricsApp").service "Hashtags",
  [ ->
    extract: (metric) ->
      metric.name.match(/#\w+/g);

    getColor: (hashtag) ->
      hash = 5381;

      for c in hashtag
        hash = ((hash << 5) + hash) + hashtag.charCodeAt(c)
      (hash & 0x00FFFFFF).toString(16)
]
