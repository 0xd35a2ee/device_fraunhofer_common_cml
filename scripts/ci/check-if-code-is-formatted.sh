#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"
FILES=$(find $ROOT_DIR -type f -regextype sed -regex ".*\(\.c\|\.h\)")

diff -u <(cat $FILES) <(clang-format $FILES)
ret=$?

if [ $ret -ne 0 ]; then
    echo ""
    echo "The code is not formatted!"
    echo "Check the above output that shows the wrong (-) and correct (+) formattings."
    echo "You can automatically format your code using the ./scripts/format-code.sh script."
else
    echo "Code is properly formatted."
fi

exit $ret
