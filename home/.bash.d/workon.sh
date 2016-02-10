#!/bin/bash

CURRENT_SECTION="INVALID"

# begin/end section ========================================

function begin_section {
    CURRENT_SECTION=$1
    echo "Executing $CURRENT_SECTION..."
}

function end_section {
    if [ $? -eq 0 ]; then
        echo "$CURRENT_SECTION SUCCESS"
    else
        echo "$CURRENT_SECTION FAILURE"
    fi

    echo

    CURRENT_SECTION="INVALID"
}

# command-exists ===========================================

function command-exists {
    command -v "$1" >/dev/null 2>&1
}

# use/load abstraction ======================================

function choose {
    if command-exists use; then
        use $@
    elif command-exists module; then
        module load $@
    else
        echo "No way to choose!"
        return 1
    fi
}

function spoose {
    if command-exists use; then
        spack use $@
    elif command-exists module; then
        spack load $@
    else
        echo "No way to spoose!"
        return 1
    fi
}

# setup ====================================================

function setup-general {
    spoose git
    spoose vim
    spoose cmake
}

function setup-spark {
    begin_section "Spark setup"
    export SPARK_HOME=/usr/global/tools/lcmon/spark_1_5_1/
    . $SPARK_HOME/conf/spark-env.sh
    end_section 
}

function setup-bigfoot {
    begin_section "Bigfoot development environment setup"
    export SPACK_HOME=$HOME/src/spack/
    export MODULEPATH=$SPACK_HOME/share/spack/modules/chaos_5_x86_64_ib:/$MODULEPATH
    spack load git
    spack load vim
    spack load cmake
    end_section
}

function setup-scrubjay-env {
    begin_section "ScrubJay development environment setup"
    export PATH=$HOME/anaconda2/bin:$PATH
    source activate scrubjay
    end_section
}

function setup-caliper-env {
    begin_section "Caliper development environment setup"
    if command-exists use; then
        use gcc-4.9.2p
    elif command-exists module; then
        module load gnu/4.9.2
    fi
    end_section
}

# workon ====================================================

function hostname-stripped {
    ${HOSTNAME//[[:digit:]]/}
}

function workon-scrubjay {
    setup-scrubjay-env
    setup-spark
}

function workon-caliper {
    setup-caliper-env
}

function workon {
    # Machine-specific setup
    MACHINE=${HOSTNAME//[[:digit:]]/}
    if [ "$MACHINE" == "cab" ]; then
        setup-general
    elif [ "$MACHINE" == "bigfoot" ]; then
        setup-bigfoot
    fi

    # Check if a project was specified
    if [ "$#" -ne 1 ]; then
        return 0
    fi

    # Project-specific setup
    if [ "$1" == "scrubjay" ]; then
        workon-scrubjay
    elif [ "$1" == "caliper" ]; then
        workon-caliper
    else
        echo "Project $1 not found!"
        return 1
    fi

    return 0
}
