local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- A simple "hello" snippet
  s("hello", t("Hello, world!")),

  -- A function template
  s("fn", fmt([[
    function {}({})
      {}
    end
  ]], {
    i(1, "name"),
    i(2, "args"),
    i(0, "-- body"),
  })),
}

