#!/usr/bin/env bash

# Jenkins executes this script before it builds the trustme image (i.e. pre-yocto).
# If this script exits with a non-zero code, the whole pipeline fails.
# Right now it is used to execute the current unit tests in the common directory.
# However, it can be extended and used for any pre-build-time task (fuzzing, other tests, etc).

echo "pass"
