#!/usr/bin/env python2
import sys
import os
import midi

fn = str(sys.argv[1])
try:
    patt = midi.read_midifile(fn)
except:
    exit(1)

if len(patt[0])!=len(patt[1]):
    exit(0)

for i in xrange(len(patt[0])):
    a = patt[0][i]
    b = patt[1][i]
    if a!=b:
        if isinstance(a, midi.NoteOnEvent) and type(a)==type(b):
            if a.tick!=b.tick or a.data[0]!=b.data[0]:
                exit(0)

os.unlink(fn)
exit(1)
