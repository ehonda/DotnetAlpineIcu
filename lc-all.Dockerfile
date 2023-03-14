ARG runtimeImage=sdk

FROM dockerehonda/dotnet/${runtimeImage}-icu-full

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
