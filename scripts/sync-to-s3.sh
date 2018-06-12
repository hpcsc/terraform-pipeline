#!/bin/sh

SOURCE_DIR=$1
DESTINATION_DIR=$2

aws s3 cp --recursive --exclude '.terraform/*' ${SOURCE_DIR} s3://terraform-pipeline-artifacts/${DESTINATION_DIR}
