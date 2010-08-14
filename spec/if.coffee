assert = require "assert"
vows = require "vows"

exports.test = vows.describe "If statement",
  "If structures as expressions":
    topic: -> true
    "evaluate regardless of levels": ->
      a = b = d = true
      c = false

      result = if a
        if b
          if c then false else
            if d
              true

      assert.ok result

    "evaluate across a single line": ->
      first = if false then false else second = if false then false else true

      assert.ok first
      assert.ok second

    "trailing if statements evaluate too": ->
      result = if false
        false
      else if NaN
        false
      else
        true

      assert.ok result

  "Unless syntax":
    topic: -> true
    "works like an if !value statement": ->
      result = unless true
        10
      else
        11

      assert.equal result, 11

      result2 = if !true
        10
      else
        11
      assert.equal result, result2

    "allows the same syntax as if <stmt> then <val>": ->
      result = unless true then 10 else 11
      assert.equal result, 11

  "Inline if statements":
    topic: -> true

    "Can be nested": ->
      echo = (x) -> x
      result = if true then echo((if false then 'xxx' else 'y') + 'a')
      assert.equal result, 'ya'

    "Work with inline functions": ->
      func = -> if 1 < 0.5 then 1 else -1
      assert.equal func(), -1

  "Empty results for if statements":
    topic: -> true
    "Compile and return undefined": ->
      result = if false
      else if false
      else

      assert.equal result, undefined

    "Also work with commented out blocks": ->
      result = if false
        # comment
      else if true
        # comment
      else

      assert.equal result, undefined

  "If statements as returned expressions":
    topic: -> true
    "Return null if there is no else and if fails": ->
      func = ->
        if false then null
      assert.equal func(), null

