angular.module("maemonApp").directive "editable", ["$parse", "$timeout", ($parse, $timeout) ->
  restrict: "A"

  link: (scope, element, attributes, ngModel) ->
    editInput = element.find(attributes.editInput)
    editElement = element.find(attributes.editElement)

    showInput = ->
      return unless scope.enabled

      editInput.val scope.initialValue

      editElement.addClass 'ng-hide'
      editInput.removeClass 'ng-hide'
      $timeout -> editInput[0].focus()
    editElement.on 'click', showInput

    hideInput = ->
      return if scope.focused

      editElement.removeClass 'ng-hide'
      editInput.addClass 'ng-hide'

    editInput.on 'blur', ->
      hideInput()

    editInput.on 'keyup', (e) ->
      return unless e.keyCode == 13
      hideInput()

    scope.$watch attributes.focus, (value) ->
      scope.focused = value
      if value
        showInput()
      else
        hideInput()
    , true

    scope.$watch attributes.editable, (value) ->
      scope.enabled = value
      showInput() if scope.focused
    , true
]
