#!/bin/sh

docdir=./doc.d
port=4289

python3 \
	-m http.server \
	--bind 0.0.0.0 \
	--directory "${docdir}" \
	${port}
