#!/bin/bash

set -eo pipefail

# Arguments
#   1 Runtime image
#   2 Globalization enabled
build_and_run() {
    local runtimeImage="$1"
    local globalizationEnabled="$2"

    local imageName=dotnet-alpine-icu-console
    local globalizationSuffix
    globalizationSuffix=$(if [[ -n "$globalizationEnabled" ]]; then echo -with-globalization; fi)

    local imageSuffix="$runtimeImage$globalizationSuffix"
    local fullImageName="$imageName:$imageSuffix"

    local dockerfile
    dockerfile=$(if [[ -n "$globalizationEnabled" ]]; then echo globalization-enabled.Dockerfile; else echo Dockerfile; fi)

    echo "$imageSuffix"
    # --quiet still prints the image sha, so we redirect to /dev/null as well
    docker image build \
            --quiet \
            --file "$dockerfile" \
            --tag "$fullImageName" \
            --build-arg runtimeImage="$runtimeImage" \
            . \
        > /dev/null
    docker container run --rm "$fullImageName"
    echo ""
}

build_and_run sdk
build_and_run runtime
build_and_run aspnet

build_and_run sdk "true"
build_and_run runtime "true"
build_and_run aspnet "true"
