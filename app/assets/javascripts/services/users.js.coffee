angular.module("maytricsApp").service "Users",
  ["$http", ($http) ->
    getUser: (id) ->
      $http
        method: "GET"
        url: "/users/#{id}.json"

    getCurrent: ->
      $http
        method: "GET"
        url: "/user.json"

    updateUser: (id, data) ->
      $http
        method: "PUT"
        url: "/users/#{id}.json"
        data: data
]
