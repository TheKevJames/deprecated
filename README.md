# DevStat

DevStat is an all-in-one page for viewing the status of your various projects.

## Deploy

Since you only really need the `docker-compose.yml` file for deployment, you
can deploy with:

    curl https://raw.githubusercontent.com/TheKevJames/devstat/master/docker-compose.yml > devstat.yml
    docker stack deploy -c devstat.yml thekevjames

You can update to the latest build with:

    docker service update --force thekevjames_devstat_web
    docker service update --force thekevjames_devstat_server

## Secrets

This project requires access to some secret keys; you can set these with:

    echo "my-github-token" | docker secret create github_token -
