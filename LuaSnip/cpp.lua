local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("cp-simple", fmt([[
    #include <bits/stdc++.h>
    using namespace std;

    #define ln '\n'
    #define ll long long
    #define all(x) begin(x), end(x)
    #define pb emplace_back

    int32_t main() {{
      cin.tie(nullptr)->sync_with_stdio(0);
      {}
      return 0;
    }}
  ]], {
    i(0, "// your code here")
  })),
}

