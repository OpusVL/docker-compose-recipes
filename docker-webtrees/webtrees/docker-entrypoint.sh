#!/bin/bash
set -euo pipefail

if ! [ -e index.php ]; then
	echo >&2 "Webtrees not found in $PWD - copying now..."
	if [ "$(ls -A)" ]; then
		echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
		( set -x; ls -A; sleep 10 )
	fi
	tar cf - --one-file-system -C /usr/src/webtrees-${WEBTREES_VERSION} . | tar xf -
	echo >&2 "Complete! Webtrees has been successfully copied to $PWD"
fi

exec "$@"
