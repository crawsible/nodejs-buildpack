#!/usr/bin/env bash
source `dirname $0`/../../lib/environment.sh

export http_proxy='http://some.insecure.proxy:3128'
export https_proxy='http://some.secure.proxy:3128'

handle_proxy_vars
