#!/bin/sh

#set -euo pipefail

# List installed icu packages
apk list icu*

# Run the test
dotnet /app/DotnetAlpineIcu.Console.dll || echo $?
