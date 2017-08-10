#!/bin/bash

SCRIPT_VAR=Eins

export SCRIPT_VAR

echo "Script variable in Script: $SCRIPT_VAR"
echo "Travis variable in Script: $TRAVIS_VAR"