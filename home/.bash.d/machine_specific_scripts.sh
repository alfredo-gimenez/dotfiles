#!/bin/bash

CURRENT_SECTION="INVALID"

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

function setup-bigfoot {
    begin_section "Development environment setup"
    export SPACK_HOME=$HOME/src/spack/
    export MODULEPATH=$SPACK_HOME/share/spack/modules/chaos_5_x86_64_ib:/$MODULEPATH
    spack load git
    spack load vim
    export PATH=$HOME/anaconda2/bin:$PATH
    source activate scrubjay
    end_section

    begin_section "Spark setup"
    export SPARK_HOME=/usr/global/tools/lcmon/spark_1_5_1/
    . $SPARK_HOME/conf/spark-env.sh
    end_section 
}

function setup-env {
    if [ "$HOSTNAME" == "bigfoot21" ]; then
        setup-bigfoot
    fi
}

