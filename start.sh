#!/bin/bash

export MIX_ENV=prod
export PORT=4797
export NODEBIN='pwd'/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"
# TODO uncomment 
#export DATABASE_URL=ecto://events:events@localhost/events_app_prod
_build/prod/rel/events_app/bin/events_app start