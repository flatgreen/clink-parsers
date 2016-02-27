#!/usr/bin/env python
from __future__ import unicode_literals

import os
from os.path import dirname as dirn
import sys

sys.path.insert(0, dirn(dirn((os.path.abspath(__file__)))))
import youtube_dl

CLINK_COMPLETION_FILE = "youtube-dl_parser.lua"
CLINK_COMPLETION_TEMPLATE = "devscripts/clink-completion.in"


def build_completion(opt_parser):
    opts_flag = []
    for group in opt_parser.option_groups:
        for option in group.option_list:
            # for every long flag
            opts_flag.append(option.get_opt_string())
    with open(CLINK_COMPLETION_TEMPLATE) as f:
        template = f.read()
    with open(CLINK_COMPLETION_FILE, "w") as f:
        # just using the special char
        filled_template = template.replace("{{flags}}", ", ".join('"'+ item + '"' for item in opts_flag))
        f.write(filled_template)

parser = youtube_dl.parseOpts()[0]
build_completion(parser)
