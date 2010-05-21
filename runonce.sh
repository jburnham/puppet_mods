#!/bin/sh

aptitude update && aptitude -y install puppet

cd puppetdebian/ && test/run.sh reallyrun

cd serversetup && test/run.sh reallyrun
