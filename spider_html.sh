#!/bin/bash

num_parallel=25

cat domains.txt | xargs -I {} -P $num_parallel ./get_domain.sh {}
