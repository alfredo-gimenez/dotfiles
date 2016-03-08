#!/bin/bash

# MACHINE=${HOSTNAME//[[:digit:]]/}

# utility functions ========================================

function dbg-cmd {
    echo "\$ $@"
    $@
    return $?
}

function cmd-exists {
    command -v "$1" >/dev/null 2>&1
}

# bash tab completion ======================================

function workon-completion {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "scrubjay caliper" -- ${cur}) )
}

# use/load abstraction ======================================

function spoose {
    if cmd-exists use; then
        dbg-cmd spack use $@
    elif cmd-exists module; then
        dbg-cmd spack load $@
    else
        echo "No way to spoose!"
        return 1
    fi
}

# setup ====================================================

function setup-basic-tools {
    spoose git
    spoose vim
    spoose cmake
}

function setup-spack {
    if [ "$#" -ne 1 ]; then
        echo "Usage $0 <spack directory>"
        return 1
    fi

    dbg-cmd export SPACK_HOME=$1
    dbg-cmd . $SPACK_HOME/share/spack/setup-env.sh

    # sometimes we need to do modulepath manually
    # dbg-cmd export MODULEPATH=$SPACK_HOME/share/spack/modules/chaos_5_x86_64_ib:/$MODULEPATH
}

function setup-spark {
    if [ "$#" -ne 1 ]; then
        echo "Usage $0 <spark directory>"
        return 1
    fi

    dbg-cmd export SPARK_HOME=$1
    dbg-cmd . $SPARK_HOME/conf/spark-env.sh
}

function setup-anaconda {
    if [ "$#" -ne 1 ]; then
        echo "Usage $0 <anaconda directory>"
        return 1
    fi

    dbg-cmd export ANACONDA_HOME=$1
    dbg-cmd pathadd $ANACONDA_HOME/bin
}

# workon ====================================================

function workon-scrubjay {
    setup-spark /usr/global/tools/lcmon/spark_1_6_0/
    dbg-cmd source activate scrubjay
}

function workon-caliper {
    if cmd-exists use; then
        dbg-cmd use gcc-4.9.2p
    elif cmd-exists module; then
        dbg-cmd module load gnu/4.9.2
    fi
}

function workon {
    # General setup
    setup-spack $HOME/src/spack
    setup-basic-tools

    # Check if a project was specified
    if [ "$#" -ne 1 ]; then
        return 0
    fi

    # Project-specific setup
    PROJECT=$1
    if [ "$PROJECT" == "scrubjay" ]; then
        workon-scrubjay
    elif [ "$PROJECT" == "caliper" ]; then
        workon-caliper
    else
        echo "Project $PROJECT not found!"
        return 1
    fi

    return 0
}

# Use bash completion
complete -F workon-completion workon
