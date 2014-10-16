angular.module("maemonApp").service "Hashtags",
  [ ->
    extract: (metric) ->
      return unless metric.name

      metric.name.match(/#\w+/g);

    getColor: (hashtag) ->
      hash = 5381;

      for c in hashtag
        hash = ((hash << 5) + hash) + hashtag.charCodeAt(c)
      (hash & 0x00FFFFFF).toString(16)
]
