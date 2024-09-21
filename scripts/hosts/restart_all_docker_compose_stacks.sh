# Simply restarting the container will not apply changes made in the compose file.
# Need to re-CREATE the container by brining the compose stack down and backup
for dir in ~/app-stacks/*; do (cd "$dir" && docker compose down && docker compose up -d); done