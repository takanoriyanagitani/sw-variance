#!/bin/sh

numcpus=8
jobs=$((${numcpus} - 1))

swift \
	build \
	--configuration release \
	--jobs ${jobs}
