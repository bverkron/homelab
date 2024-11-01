# Simply restarting the container will not apply changes made in the compose file.
# Need to re-CREATE the container by bringing the compose stack down and back up
echo "Stopping stacks..."
for dir in ~/app-stacks/*; do
  (cd "$dir" && [ -f "compose.yaml" ] && docker compose down)
done
echo "Stop operation finished."

read -p "Start stacks? [Y/y]" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Starting stacks..."
  for dir in ~/app-stacks/*; do
    (cd "$dir" && [ -f "compose.yaml" ] && docker compose up -d)
  done
else
  echo "Doing nothing"
fi

