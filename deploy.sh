#!/bin/bash

export SECRET_KEY_BASE=E8L3Bzz6N+p5bi3wU8u5YILQT+V+Jw0ZaJyPDTwrK4ir9pAZ455QDFbFHR9f1end
export MIX_ENV=prod
export PORT=4797
export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"
export DATABSE_URL=ecto://events:events@localhost/events_app_prod

echo "Building..."

mix deps.get --only prod
mix compile
(cd assets && npm install)
(cd assets && webpack --mode production)
mix phx.digest

mix ecto.create
mix ecto.migrate

echo "Generating release..."
mix release

#echo "Stopping old copy of app, if any..."
#_build/prod/rel/practice/bin/practice stop || true

echo "Starting app..."

PROD=t ./start.sh
