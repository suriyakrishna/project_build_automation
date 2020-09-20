#!/bin/bash

while getopts ":s:o:a:v:b:p:" opt; do
  case $opt in
    s) SCALA_VERSION="$OPTARG"
    ;;
    o) ORGANIZATION="$OPTARG"
    ;;
    a) ARTIFACT_NAME="$OPTARG"
    ;;
    v) ARTIFACT_VERSION="$OPTARG"
    ;;
    b) SBT_VERSION="$OPTARG"
    ;;
    p) PROJECT_DIR="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

SCRIPT_NAME=$(basename $0)
SCRIPT_PATH=$(dirname $(readlink -f $0))

# bash generate_sbt_project.sh -s 2.11.11 -o com.kishan -a pocsbt -v 0.1.1 -b 1.3.4 -p sparkScalaTest    
if [[ -z ${SCALA_VERSION} || -z ${ORGANIZATION} || -z ${ARTIFACT_NAME} || -z ${ARTIFACT_VERSION} || -z ${SBT_VERSION} || -z ${PROJECT_DIR} ]]; then
    echo "Failed to Start ${SCRIPT_NAME}"
    echo "USAGE: ${SCRIPT_NAME} 
    -s SCALA_VERSION eg: 2.11.11
    -o ORGANIZATION_NAME eg: com.github.suriyakrishna
    -a ARTIFACT_NAME eg: sparkScalaTest
    -v ARTIFACT_VERSION eg: 0.0.1
    -b SBT_VERSION eg 1.3.4
    -p PROJECT_DIRECTORY eg /home/hadoop/sparkScalaTest
    "
    exit -1
fi

# Souring Script Functions
. ${SCRIPT_PATH}/utils.sh

# CHECK IF PROJECT DIRECTORY EXISTS
if [[ -d ${PROJECT_DIR} ]]; then
    log_error "Project directory exists already. Try with new path"
    log_error "Exiting..."
    exit -1
else 
    log_info "Project directory doesn\'t exists. Creating..."
    mkdir -p ${PROJECT_DIR}
fi

# Create Sbt Project
cd $PROJECT_DIR
intialize_git
create_sbt_folder_structure
create_git_ignore_file
create_build_sbt_file $ARTIFACT_NAME $ARTIFACT_VERSION $SCALA_VERSION $ORGANIZATION
create_sbt_build_properites_file $SBT_VERSION
log_info "SBT Project initialized successfully in ${PROJECT_DIR}"
