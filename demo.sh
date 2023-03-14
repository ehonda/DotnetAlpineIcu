#!/bin/bash

set -eo pipefail

# TODO: Put combinations of stuff to build in an array

# Gets the name of the runtime image
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
get_runtime_image_name() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"

    echo dockerehonda/dotnet/"$dotnetBaseImageName"-"$globalizationSupportLevel"
}

# Builds a single runtime image
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
build_runtime_image() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"

    local dockerfileName="$globalizationSupportLevel".Dockerfile
    local imageName
    imageName=$(get_runtime_image_name "$dotnetBaseImageName" "$globalizationSupportLevel")

    echo "Preparing runtime image $imageName"
    # We don't need any context for those, wo we pipe in the dockerfile via STDIN
    # See: https://docs.docker.com/engine/reference/commandline/build/#build-with--
    docker image build \
            --quiet \
            --tag "$imageName" \
            --build-arg runtimeImage="$dotnetBaseImageName" \
            - < "$dockerfileName" \
        > /dev/null
}

# Builds all runtime images we need for the demo
build_runtime_images() {
    build_runtime_image sdk icu-half
    build_runtime_image runtime icu-half
    build_runtime_image aspnet icu-half

    build_runtime_image sdk icu-full
    build_runtime_image runtime icu-full
    build_runtime_image aspnet icu-full

    build_runtime_image sdk lc-all
    build_runtime_image runtime lc-all
    build_runtime_image aspnet lc-all

    # TODO: New section
    echo ""
}

# Gets the name of the application under runtime image
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
get_application_image_name() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"

    echo dockerehonda/dotnet-alpine-icu-console/"$dotnetBaseImageName"-"$globalizationSupportLevel"
}

# Builds the application in a specific runtime
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
build_application_image() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"

    local runtimeImageName
    runtimeImageName=$(get_runtime_image_name "$dotnetBaseImageName" "$globalizationSupportLevel")

    local applicationImageName
    applicationImageName=$(get_application_image_name "$dotnetBaseImageName" "$globalizationSupportLevel")

    echo "Preparing application image $applicationImageName"
    docker image build \
            --quiet \
            --tag "$applicationImageName" \
            --build-arg runtimeImage="$runtimeImageName" \
            . \
        > /dev/null
}

# Builds all application images we need for the demo
build_application_images() {
    build_application_image sdk icu-half
    build_application_image runtime icu-half
    build_application_image aspnet icu-half

    build_application_image sdk icu-full
    build_application_image runtime icu-full
    build_application_image aspnet icu-full

    build_application_image sdk lc-all
    build_application_image runtime lc-all
    build_application_image aspnet lc-all

    # TODO: New section
    echo ""
}

# Runs the application in a specific runtime
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
run_application_image() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"

    local applicationImageName
    applicationImageName=$(get_application_image_name "$dotnetBaseImageName" "$globalizationSupportLevel")

    echo "Running application image $applicationImageName"
    docker container run --rm "$applicationImageName"
    echo ""
}

run_application_images() {
    run_application_image sdk icu-half
    run_application_image runtime icu-half
    run_application_image aspnet icu-half

    run_application_image sdk icu-full
    run_application_image runtime icu-full
    run_application_image aspnet icu-full

    run_application_image sdk lc-all
    run_application_image runtime lc-all
    run_application_image aspnet lc-all
}

# TODO: no-icu version

build_runtime_images
build_application_images
run_application_images
