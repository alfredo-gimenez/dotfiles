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

# setup ====================================================

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

function setup-scrubjay-virtualenv {
    begin_section "ScrubJay development environment setup"
    export PATH=$HOME/anaconda2/bin:$PATH
    source activate scrubjay
    end_section
}

# workon ====================================================

function workon-scrubjay {
    setup-bigfoot
    setup-scrubjay-virtualenv
    setup-spark
}

function workon {
    if [ "$#" -ne 1 ]; then
        echo "Usage: workon <project>"
        return 1
    fi

    if [ "$1" == "scrubjay" ]; then
        workon-scrubjay
    else
        echo "Project $1 not found!"
        return 1
    fi

    return 0
}
