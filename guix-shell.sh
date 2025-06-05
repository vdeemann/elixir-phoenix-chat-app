#!/bin/bash
# Helper script to enter Guix environment
if command -v guix &> /dev/null; then
    echo "Entering Guix development environment..."
    exec guix shell --manifest=manifest.scm
else
    echo "Guix not available, using system environment"
    exec bash
fi
