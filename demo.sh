#!/bin/bash

set -eo pipefail

# TODO: Put combinations of stuff to build in an array

# Arguments
#   1 Locale
get_locale_suffix() {
    local locale="$1"

    if [[ -n "$locale" ]]; then
        echo -n "-$locale" | tr '[:upper:]' '[:lower:]' | tr -c '[:alnum:]' -
    fi
}

# Gets the name of the runtime image
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
#   3 (Optional) Extra locale argument
get_runtime_image_name() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"
    local locale="$3"
    
    local localeSuffix
    localeSuffix=$(get_locale_suffix "$locale")

    echo dockerehonda/dotnet/"$dotnetBaseImageName"-"$globalizationSupportLevel""$localeSuffix"
}

# Builds a single runtime image
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
#   3 (Optional) Extra locale argument
build_runtime_image() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"
    local locale="$3"

    local dockerfileName="$globalizationSupportLevel".Dockerfile

    local imageName
    imageName=$(get_runtime_image_name "$dotnetBaseImageName" "$globalizationSupportLevel" "$locale")

    # Build locale build arg if locale has a value
    #   * See (for why we use this): https://www.shellcheck.net/wiki/SC2086
    #   * Could be put into a function like this: https://stackoverflow.com/a/49971213
    local localeBuildArg=()
    if [[ -n "$locale" ]]; then
        localeBuildArg=(--build-arg locale="$locale")
    fi

    echo "Preparing runtime image $imageName"
    
    # We don't need any context for those, wo we pipe in the dockerfile via STDIN
    # See: https://docs.docker.com/engine/reference/commandline/build/#build-with--
    docker image build \
            --quiet \
            --tag "$imageName" \
            --build-arg runtimeImage="$dotnetBaseImageName" \
            "${localeBuildArg[@]}" \
            - < "$dockerfileName" \
        > /dev/null
}

# Builds all runtime images we need for the demo
build_runtime_images() {
    build_runtime_image sdk plain
    build_runtime_image runtime plain
    build_runtime_image aspnet plain

    build_runtime_image sdk icu-half
    build_runtime_image runtime icu-half
    build_runtime_image aspnet icu-half

    build_runtime_image sdk icu-full
    build_runtime_image runtime icu-full
    build_runtime_image aspnet icu-full

    build_runtime_image sdk lc-all en_US.UTF-8
    build_runtime_image runtime lc-all en_US.UTF-8
    build_runtime_image aspnet lc-all en_US.UTF-8

    build_runtime_image sdk lc-all de_DE.UTF-8
    build_runtime_image runtime lc-all de_DE.UTF-8
    build_runtime_image aspnet lc-all de_DE.UTF-8

    # TODO: New section
    echo ""
}

# Gets the name of the application under runtime image
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
#   3 (Optional) Extra locale argument
get_application_image_name() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"
    local locale="$3"

    local localeSuffix
    localeSuffix=$(get_locale_suffix "$locale")

    echo dockerehonda/dotnet-alpine-icu-console/"$dotnetBaseImageName"-"$globalizationSupportLevel""$localeSuffix"
}

# Builds the application in a specific runtime
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
#   3 (Optional) Extra locale argument
build_application_image() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"
    local locale="$3"

    local runtimeImageName
    runtimeImageName=$(get_runtime_image_name "$dotnetBaseImageName" "$globalizationSupportLevel" "$locale")

    local applicationImageName
    applicationImageName=$(get_application_image_name "$dotnetBaseImageName" "$globalizationSupportLevel" "$locale")

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
    build_application_image sdk plain
    build_application_image runtime plain
    build_application_image aspnet plain

    build_application_image sdk icu-half
    build_application_image runtime icu-half
    build_application_image aspnet icu-half

    build_application_image sdk icu-full
    build_application_image runtime icu-full
    build_application_image aspnet icu-full

    build_application_image sdk lc-all en_US.UTF-8
    build_application_image runtime lc-all en_US.UTF-8
    build_application_image aspnet lc-all en_US.UTF-8

    build_application_image sdk lc-all de_DE.UTF-8
    build_application_image runtime lc-all de_DE.UTF-8
    build_application_image aspnet lc-all de_DE.UTF-8

    # TODO: New section
    echo ""
}

# Runs the application in a specific runtime
# Arguments
#   1 Dotnet base image name
#   2 Globalization support level
#   3 (Optional) Extra locale argument
run_application_image() {
    local dotnetBaseImageName="$1"
    local globalizationSupportLevel="$2"
    local locale="$3"

    local applicationImageName
    applicationImageName=$(get_application_image_name "$dotnetBaseImageName" "$globalizationSupportLevel" "$locale")

    echo "Running application image $applicationImageName"
    docker container run --rm "$applicationImageName"
    echo ""
}

run_application_images() {
    run_application_image sdk plain
    run_application_image runtime plain
    run_application_image aspnet plain

    run_application_image sdk icu-half
    run_application_image runtime icu-half
    run_application_image aspnet icu-half

    run_application_image sdk icu-full
    run_application_image runtime icu-full
    run_application_image aspnet icu-full

    run_application_image sdk lc-all en_US.UTF-8
    run_application_image runtime lc-all en_US.UTF-8
    run_application_image aspnet lc-all en_US.UTF-8

    run_application_image sdk lc-all de_DE.UTF-8
    run_application_image runtime lc-all de_DE.UTF-8
    run_application_image aspnet lc-all de_DE.UTF-8
}

build_runtime_images
build_application_images
run_application_images
