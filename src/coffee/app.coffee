angular.module 'app', [], ->


angular.module 'app'
  .controller 'hello', ->
    @data = ->
      console.log 'clicked'
      alert 'hello world'
