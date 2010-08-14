assert = require 'assert'
vows = require 'vows'

x  = y  = 10
x1 = y1 = 20

exports.test = vows.describe "Behavior of arguments in functions",
  "Arguments can be provided":
    topic: ->
      [[10, 10, 20, 20], (x, y, x1, y1) -> (x - x1) * (x - y1)]

    "all on one line": (topic) ->
      [[x, y, x1, y1], area] = topic
      assert.equal area(x, y, x1, y1), 100

    "broken up, one line per argument": (topic) ->
      [[x, y, x1, y1], area] = topic
      result = area(
        x,
        y,
        x1,
        y1
      )
      assert.equal result, 100

    "broken across several lines with odd indentation": (topic) ->
      [[x, y, x1, y1], area] = topic
      result = area(x, y,
                       x1, y1
      )
      assert.equal result, 100


  "Implied arguments":
    topic: ->
      ->
        sum = 0
        sum += val for val in arguments
        sum
    "are accessible via arguments keyword": (sumOfArgs) ->
      assert.equal sumOfArgs(1, 2, 3, 4, 5), 15

  "Splats":
    "at beginning of arguments":
      topic: ->
        ((splat..., @arg) ->).call context = {}, 1, 2, 3
        context

      "Collect all but the explicit argument": (topic) ->
        assert.equal topic.arg, 3

    "generally":
      topic: ->
        ((@arg...) ->).call context = {}, 1, 2, 3
        context
      "Collect all of the parameters passed in": (topic) ->
        assert.equal topic.arg.join(" "), "1 2 3"

  "Class arguments":
    topic: ->
      class Klass
        constructor: (@one, @two) ->

    "that are passed as instances variables to the constructor as stored on the instance": (Klass) ->
      obj = new Klass 1, 2
      assert.equal obj.one, 1
      assert.equal obj.two, 2
