Wrangler
=======
Wrangler is a Lua object filtration module written with the LÖVE framework in mind. This module will take a list of Lua objects and sort through them, removing any items that do not match the given criteria.

## Filters ##
Wrangler sorts items using functions called filters. A filter receives, in order, the Wrangler object, the object being processed, the name of the filter, and the value to compare the object with. If the object passes the filter, the filter should return **true**. Otherwise, it should return **false**.

```Lua
function filter(self, object, name, value)
  return object.foo == value
end
```

By default, a Wrangler object has two filters: *not* and *or*, both of which take a separate list of criteria. Wrangler objects do not have, nor do they need, an *and* filter as criteria are implicitly exclusive.

## Usage ##
To use Wrangler, require the module into your project and create a new Wrangler object.
```Lua
local Wrangler = require("Wrangler")()
```

Once the new object is created, you can add filters to it and use it to process a list of items.
```Lua
local Wrangler = require("Wrangler")()

Wrangler:addFilter("foo", function(self, object, name, value)
  return object.foo == value
end)

local t = {
  {
    foo = "bar",
    a = "a",
    2 = "two"
  },
  {
    foo = "foo",
    a = "b",
    2 = "four"
  }
}

Wrangler:filter(t, {
  foo = "bar"
})

print(t[1] and t[1].foo) -- bar
print(t[2] and t[2].foo) -- false (t[2] is nil)
```

Note that Wrangler:filter works directly on the table you give to it, so if the table you need it to filter should not change, it is recommended that you unpack or clone it into another table to be processed instead.

For convenience, Wrangler:filter returns the table you passed to it.
