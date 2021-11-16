#!/bin/bash

export GPG_TTY=$(tty)
export SOPS_PGP_FP='206A5498EF91D30FCACAA3720C7510957FC32454'

$(echo $0 | sed 's/\/decrypt_tfvars.sh//')/hcl2json <(sops -d $1)
