#!/bin/sh

set -e

IGNORE=${*}
IGNOREFILE="${PWD}/.svnignore.$(date "+%s")"

if [ -z "${IGNORE}" ]; then
    svn st | awk '/^?/  {print $2 }' | grep -ve "$(basename "${IGNOREFILE}")" > "${IGNOREFILE}"
else
    for format in ${IGNORE}; do
        echo "${format}" >> "${IGNOREFILE}"
    done
fi 
svn propget svn:ignore >> "${IGNOREFILE}" 2>/dev/null || :
svn propset svn:ignore -F "${IGNOREFILE}" .
rm -f "${IGNOREFILE}"
