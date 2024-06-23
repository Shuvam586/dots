#!/bin/bash

name=`iwgetid -r`

if [ -z "$name" ]; then
	echo ""
else
	echo " $name"
fi