ARG runtimeImage=sdk

FROM ehonda/dotnet/${runtimeImage}-icu-full

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
