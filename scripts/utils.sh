#!/bin/sh

log_info(){
    TMS=$(date +"%m-%d-%Y %H:%M:%S")
    MESSAGE=$(eval echo $1)
    echo "${TMS} - INFO - ${MESSAGE}"
}

log_error(){
    TMS=$(date +"%m-%d-%Y %H:%M:%S")
    MESSAGE=$(eval echo $1)
    echo "${TMS} - ERROR - ${MESSAGE}"
}

check_status(){
    STATUS_VALUE=$1
    PASS_VALUE=${2}
    ERROR_VALUE=${3}
    if [[ "${STATUS_VALUE}" == "0" ]]; then
        log_info "$PASS_VALUE"
    else
        log_error "$ERROR_VALUE"
        log_error "Exiting..."
        exit -1
    fi
}

intialize_git(){
    log_info "Intializing git Repoistory in `pwd`"
    git init .
    check_status $? "Initialized Git Repoistory Successfully" "Failed to Intialized Git Repository"
}

create_sbt_folder_structure(){
    log_info "Creating folder structure for sbt project"
    mkdir -p src/{main,test}/{java,resources,scala}
    mkdir project jenkins configs scripts
    check_status $? "Folder structure created successfully" "Failed to create folder structure"
}

create_maven_folder_structure(){
    log_info "Creating folder structure for maven project"
    mkdir -p src/{main,test}/{java,resources,scala}
    mkdir jenkins configs scripts
    check_status $? "Folder structure created successfully" "Failed to create folder structure"
}

create_git_ignore_file(){
    log_info "Creating .gitignore file"
echo "# List of files and directories that need to be ignored from the git repository
.idea
target
project/target
outputs
.env
.env-DEV
.env-SIT
.env-PROD
" > .gitignore
    check_status $? ".gitignore file created successfully" "Failed to create .gitignore file"
}

create_build_sbt_file(){
    ARTIFACT_NAME=$(eval echo 'name := \"${1}\"')
    ARTIFACT_VERSION=$(eval echo 'version := \"${2}\"')
    SCALA_VERSION=$(eval echo 'scalaVersion := \"${3}\"')
    ORGANIZATION=$(eval echo 'organization := \"$4\"')
    log_info "Creating build.sbt file"
echo "${ARTIFACT_NAME}
${ARTIFACT_VERSION}
${SCALA_VERSION}
${ORGANIZATION}
" > build.sbt
    check_status $? "Created build.sbt file successfully" "Failed to create build.sbt file"
}

create_sbt_build_properites_file(){
    log_info "Creating build.properties file"
    echo "sbt.version=$1" > project/build.properties
    check_status $? "Created build.properties file successfully" "Failed to create build.properties file"
}