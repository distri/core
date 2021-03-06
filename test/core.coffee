Core = require "../core"

ok = assert
equals = assert.equal
test = it

describe "Core", ->

  test "#extend", ->
    o = Core()

    o.extend
      test: "jawsome"

    equals o.test, "jawsome"

  test "#attrAccessor", ->
    o = Core
      test: "my_val"

    o.attrAccessor("test")

    equals o.test(), "my_val"
    equals o.test("new_val"), o
    equals o.test(), "new_val"

  test "#attrReader", ->
    o = Core
      test: "my_val"

    o.attrReader("test")

    equals o.test(), "my_val"
    equals o.test("new_val"), "my_val"
    equals o.test(), "my_val"

  test "#include", ->
    o = Core
      test: "my_val"

    M = (I, self) ->
      self.attrReader "test"

      self.extend
        test2: "cool"

    ret = o.include M

    equals ret, o, "Should return self"

    equals o.test(), "my_val"
    equals o.test2, "cool"

  test "#include multiple", ->
    o = Core
      test: "my_val"

    M = (I, self) ->
      self.attrReader "test"

      self.extend
        test2: "cool"

    M2 = (I, self) ->
      self.extend
        test2: "coolio"

    o.include M, M2

    equals o.test2, "coolio"
