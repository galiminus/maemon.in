angular.module("maytricsApp").service "Relationships",
  ["$http", ($http) ->
    get: (userId, id) ->
      $http
        method: "GET"
        url: "/users/#{userId}/relationships/#{id}.json"

    all: (userId) ->
      $http
        method: "GET"
        url: "/users/#{userId}/relationships.json"

    create: (userId, data) ->
      $http
        method: "POST"
        url: "/users/#{userId}/relationships.json"
        data:
          id: data.followed_id

    delete: (userId, id) ->
      $http
        method: "DELETE"
        url: "/users/#{userId}/relationships/#{id}.json"
]
