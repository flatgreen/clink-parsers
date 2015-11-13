-- pip_parser.lua
--
--
-- Copyright (c) 2015 Patrick Gaudichon aka 'flatgreen'
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--
--
--------------------------------------------------------------------------------
-- This file is a Lua script helper for pip :
--     http://pip.readthedocs.org/en/stable/installing/
-- with clink : http://mridgers.github.io/clink/
-- Two greats sofwares
--
-- november 2015
--  first release
--  verbs install

pip_parser = clink.arg.new_parser()
pip_parser:set_arguments(
    { "install", "uninstall",
    "freeze", "list",
    "show", "search",
    "wheel", "help"})

clink.arg.register_parser("pip", pip_parser)