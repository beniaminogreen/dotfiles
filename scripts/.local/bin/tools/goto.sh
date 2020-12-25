#!/usr/bin/bash
tag=`echo ${1##*\{} | cut -d "}" -f1`

if ls /home/beniamino/Documents/articles/$tag*.pdf > /dev/null 2>&1; then
	zathura /home/beniamino/Documents/articles/$tag*.pdf & exit
fi

if ls /home/beniamino/Documents/books/$tag*.pdf > /dev/null 2>&1; then
	zathura /home/beniamino/Documents/books/$tag*.pdf & exit
fi

echo "No articles matching that tag found"
