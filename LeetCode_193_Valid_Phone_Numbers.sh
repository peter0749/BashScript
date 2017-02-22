#!/bin/bash
## Valid Number: (xxx) xxx-xxxx or xxx-xxx-xxxx for all x in [0-9]
grep -P '^(\([0-9]{3}\)\ |[0-9]{3}\-)[0-9]{3}\-[0-9]{4}$' $1
