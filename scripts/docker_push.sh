#! /bin/bash

# Login to docker
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

# Push only if it's not a pull request
if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  # Push only if we're testing the master branch
  if [ "$TRAVIS_BRANCH" == "dev" ] || [ "$TRAVIS_BRANCH" == "master" ]; then

    # Build and push
    docker build -t $IMAGE_NAME .
    echo "Pushing $IMAGE_NAME:latest"
    docker tag $IMAGE_NAME "$REMOTE_IMAGE_URL:latest"
    docker push "$REMOTE_IMAGE_URL:latest"
    echo "Pushed $IMAGE_NAME:latest"
  else
    echo "Skipping deploy because branch is not 'dev'"
  fi
else
  echo "Skipping deploy because it's a pull request"
fi
