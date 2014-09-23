angular.module("maytricsApp").service "Users",
  ["$http", ($http) ->
    get: (id) ->
      $http
        method: "GET"
        url: "/users/#{id}.json"

    getCurrent: ->
      $http
        method: "GET"
        url: "/user.json"

    update: (id, user) ->
      $http
        method: "PUT"
        url: "/users/#{id}.json"
        data:
          user:
            name: user.name
]
