angular.module("maytricsApp").service "Hashtags",
  [ ->
    extract = (metric) ->
      metric.name.match(/#\w+/g);

    extract: extract
    extractAll: (metrics) ->
      hashtags = [].concat (metrics.map (metric) -> extract(metric))...
      hashtags = hashtags.filter (metric) -> metric != null
      hashtagsDict = {}
      hashtagsDict[hashtag] = hashtag.substr(1) for hashtag in hashtags
      value for _, value of hashtagsDict
]
