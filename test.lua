json = require("cjson")
Wrangler = require("init")()
time = require("time")

Wrangler:addFilter("id", function(self, object, name, value)
  return object.id == value
end)

Wrangler:addFilter("first_name", function(self, object, name, value)
  return object.first_name:match(value) ~= nil
end)

Wrangler:addFilter("last_name", function(self, object, name, value)
  return object.last_name:match(value) ~= nil
end)

Wrangler:addFilter("email", function(self, object, name, value)
  return object.email:match(value) ~= nil
end)

Wrangler:addFilter("gender", function(self, object, name, value)
  return object.gender:match(value) ~= nil
end)

Wrangler:addFilter("color", function(self, object, name, value)
  return object.color:match(value) ~= nil
end)

Wrangler:addFilter("leet", function(self, object, name, value)
  return object.leet:match(value) ~= nil
end)

sampleFile = io.open("test.json")
sampletxt = sampleFile:read("*a")
sampleFile:close()
sample = json.decode(sampletxt)

sampleLen = #sample

print("Press enter to begin filtering...")
io.read()

print("Find all males from reddit.com ...")
start = time.clock()
Wrangler:filter(sample, { gender = "^Male$", email = "reddit.com" })
finish = time.clock()

print("Started at " .. start)
print("Finished at " .. finish)
print("Processed " .. sampleLen .. " entries in " .. (finish - start) .. "s")
