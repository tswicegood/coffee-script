assert = require "assert"
vows = require "vows"

exports.test = vows.describe "Variable assignment in CoffeeScript",
  "Variables":
    topic: -> true
    "are assigned with an =": ->
      number = 42
      assert.equal 42, number

      opposite = true
      assert.ok opposite

    "can be assigned conditionally with a trailing if": ->
      question_was_ambiguous = true
      number = 0
      number = 42 if question_was_ambiguous
      assert.equal 42, number

    "can be assigned conditionally with a trailing unless": ->
      question_was_clear = false
      number = 0
      number = 42 unless question_was_clear
      assert.equal 42, number
