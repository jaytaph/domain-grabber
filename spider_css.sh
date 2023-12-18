#!/bin/bash

num_parallel=1

cat domains.txt | xargs -I {} -P $num_parallel ./extract_css.sh html/{}.html
