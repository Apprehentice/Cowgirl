local wrangler = {}

function wrangler.new()
  local c = setmetatable({}, wrangler)
  c.filters = {
    "not" = function(self, object, criterion, criteria)
      for criterion, value in pairs(criteria) do
        assert(self.filters[criterion], "No such filter (" .. criterion .. ")")
        if self.filters[criterion](self, object, value) then
          return false
        end
      end
    end,
    "or" = function(self, object, criterion, criteria)
      for criterion, value in pairs(criteria) do
        assert(self.filters[criterion], "No such filter (" .. criterion .. ")")
        if self.filters[criterion](self, object, value) then
          return true
        end
      end
    end
  }

  return c
end

function wrangler:filter(list, criteria)
  for index, object in ipairs(list) do
    for criterion, value in pairs(criteria) do
      assert(self.filters[criterion], "No such filter (" .. criterion .. ")")
      if not self.filters[criterion](self, object, criterion, value) then
        table.remove(list, index)
        break
      end
    end
  end
  return list
end

function wrangler:addFilter(name, filter)
  assert(type(filter) == "function", "bad argument #2 to 'addFilter' (function expected, got " .. type(filter) .. ")")
  self.filters[name] = filter
end

function wrangler:removeFilter(name)
  self.filters[name] = nil
end

return setmetatable(wrangler, { __call = wrangler.new })
