
#!/bin/bash

export MIX_ENV=prod
export PORT=4793
export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"

echo "Stopping old copy of app, if any..."

_build/prod/rel/task_tracker/bin/task_tracker stop || true

echo "Starting app..."

_build/prod/rel/task_tracker/bin/task_tracker start

