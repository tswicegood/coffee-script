assert = require 'assert'
vows = require 'vows'

exports.test = vows.describe 'Return behavior inside CoffeeScript',
  'Expression conversion under explicit returns':
    'with plain syntax':
      topic: ->
        return 'do' for x in [1,2,3]
      'are returned as the result of the expression': (topic) ->
        assert.equal topic.join(' '), 'do do do'

    'inside an array':
      topic: ->
        return ['re' for x in [1,2,3]]
      'are evaluated inside other expressions': (topic) ->
        assert.equal topic[0].join(' '), 're re re'

    'as an expression':
      topic: ->
        return ('mi' for x in [1,2,3])
      'can be wrapped in parenthesis as an explicit expression': (topic) ->
        assert.equal topic.join(' '), 'mi mi mi'

  'Testing return with multiple branches':
    topic: ->
      if false
        for a in b
          return c if d
      else
        "word"
    'do not have to explicitly use the return keyword': (topic) ->
      assert.equal topic, 'word'

  'Returns implicitly from within a switch statement':
    topic: ->
      switch 'a'
        when 'a' then 42
        else return 23
    'do not have to explicitly use the return keyword': (topic) ->
      assert.equal topic, 42

