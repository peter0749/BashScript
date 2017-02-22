#!/bin/bash
## Valid Number: (xxx) xxx-xxxx or xxx-xxx-xxxx for all x in [0-9]
grep -P '^(\([[:digit:]]{3}\)\ |[[:digit:]]{3}\-)[[:digit:]]{3}\-[[:digit:]]{4}$' $1
