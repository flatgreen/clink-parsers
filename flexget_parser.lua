-- flexget_parser.lua
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
-- This file is a Lua script helper for fleget http://flexget.com/
-- -V 1.2.505
-- with clink : http://mridgers.github.io/clink/
-- Two greats sofwares
-- april 2016

local execute_parser
local flexget_parser
local inject_parser
local series_parser
local plugin_parser
local movie_queue_parser
local rejected_parser
local failed_parser
local seen_parser
local daemon_parser
local backlog_parser
local database_parser
local archive_parser
local history_parser

local function flags(...)
    local p = clink.arg.new_parser()
    p:set_flags(...)
    return p
end

local function args(...)
    local p = clink.arg.new_parser()
    p:set_arguments(...)
    return p
end

execute_parser = clink.arg.new_parser():set_flags(
    "-h", "--help",
    "--tasks", "--learn",
    "--no-cache", "--stop-waiting",
    "--disable-tracking", "--cli-config",
    "--discover-now", "--tail-reset",
    "--now", "--dl-path",
    "--dump"..args({"eval","trace","accepted","rejected","undecided","title"}),
    "--dump-config", "--template",
    "--try-regexp",
    "-v", "--verbose", 
    "-s", "--silent"
    )

inject_parser = clink.arg.new_parser(
    { "title", "url" },
    "--accept"..execute_parser,
    "--force"..execute_parser,
    "--fields"..execute_parser,
    "-h", "--help"
    )
    
series_parser = clink.arg.new_parser(
    {"list",
    "show",
    "begin",
    "remove",
    "forget" },
    "-h", "--help"
    )
    
plugins_parser = clink.arg.new_parser():set_flags(
    "-h", "--help",
    "--group", "--phase"
    )
    
movie_queue_parser = clink.arg.new_parser(
    { "list", "add", "del",
    "forget", "clear"},
    "-h", "--help"
    )
    
rejected_parser = clink.arg.new_parser(
    { "list", "clear"},
    "-h", "--help"
    )

failed_parser = clink.arg.new_parser(
    { "list", "clear"},
    "-h", "--help"
    )
    
seen_parser = clink.arg.new_parser(
    { "forget", "add", "search"},
    "-h", "--help"
    )

daemon_parser = clink.arg.new_parser(
    { "start", "stop"..flags("--wait"), "status", "reload"},
    "-h", "--help"
    )
    
backlog_parser = clink.arg.new_parser(
    { "list", "clear"},
    "-h", "--help"
    )
  
database_parser = clink.arg.new_parser(
    { "cleanup", "vacuum", "reset", "reset-plugin" },
    "-h", "--help"
    )

archive_parser = clink.arg.new_parser()
archive_parser:set_flags("-h", "--help")
archive_parser:set_arguments(
    { "search"..flags("--tags","--sources"),
    "inject", "tag-source", "consolidate"}
    )
    
history_parser = clink.arg.new_parser(
    "-h", "--help", "--limit", "--search", "--tasks"
    )

flexget_parser = clink.arg.new_parser()
flexget_parser:set_arguments(
    { "execute"..execute_parser,
    "daemon"..daemon_parser,
    "backlog"..backlog_parser,
    "check",
    "database"..database_parser,
    "doc", 
    "movie-queue"..movie_queue_parser,
    "plugins"..plugins_parser,
    "series"..series_parser,
    "rejected"..rejected_parser,
    "failed"..failed_parser,
    "seen"..seen_parser,
    "archive"..archive_parser,
    "history"..history_parser,
    "inject"..inject_parser
    }
    )

local log_level_array = {
        "none", "critical", "error", "warning", "info", "verbose",
        "debug", "trace"
        }
 
flexget_parser:set_flags(
    "--test",
    "-V", "--version",
    "-c"..args{clink.matches_are_files},
    "-l"..args{clink.matches_are_files},
    "--logfile"..args{clink.matches_are_files},
    "-L"..args{log_level_array},
    "--loglevel"..args{log_level_array},
    "--bugreport", "--profile", "--cron", "--debug-db-sessions",
    "--debug-warnings"
    )

clink.arg.register_parser("flexget", flexget_parser)