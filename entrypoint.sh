#!/bin/sh

set -e

# Arguments
#   * 1 - Name of variable
#   * 2 - Variable
print_if_set() {
    if  [ -n "$2" ]; then
        echo "$1 = $2"
    fi
}

# List installed icu packages
#   * Run with --quiet to not print warnings about ignored main / community
apk --quiet list icu*

print_if_set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT "$DOTNET_SYSTEM_GLOBALIZATION_INVARIANT"
print_if_set LC_ALL "$LC_ALL"
print_if_set LANG "$LANG"

# Run the test
dotnet /app/DotnetAlpineIcu.Console.dll || echo $?
