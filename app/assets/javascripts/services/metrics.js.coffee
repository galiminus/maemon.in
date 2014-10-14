angular.module("maemonApp").service "Metrics",
  ["$http", ($http) ->
    all: (userId, params) ->
      $http
        method: "GET"
        url: "/users/#{userId}/metrics.json"
        params: params

    create: (userId, data) ->
      $http
        method: "POST"
        url: "/users/#{userId}/metrics.json"
        data:
          name: data.name
          value: data.value

    update: (userId, id, data) ->
      $http
        method: "PUT"
        url: "/users/#{userId}/metrics/#{id}.json"
        data:
          name: data.name
          value: data.value

    delete: (userId, id) ->
      $http
        method: "DELETE"
        url: "/users/#{userId}/metrics/#{id}.json"
]
