#!/bin/sh

#  Script.sh
#  Printer3
#
#  Created by SFO Loaner on 11/14/19.
#  Copyright © 2019 SFO Loaner. All rights reserved.
lpadmin -p "Howard" -D "Some AirPrint Printer" -E -v ipp://10.252.31.20/ipp/print -m everywhere
