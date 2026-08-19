#!/bin/bash
set -euo pipefail

name="Modihigh"

echo "Hello $name"

false | echo "This command runs"

echo "This won't be reached if the pipeline fails"