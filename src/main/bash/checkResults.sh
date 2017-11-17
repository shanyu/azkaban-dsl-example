#!/usr/bin/env bash
# Script to check the results of the word count jobs
# -----------------------------------------------------------------------------
#
# Copyright 2015 LinkedIn Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#
# -----------------------------------------------------------------------------
HDFS_OUTPUT_PATH=$1
KEYWORD=$2

echo "The HDFS output path is located at: ${HDFS_OUTPUT_PATH}"
echo "The keyword to look for is: ${KEYWORD}"

hadoop fs -copyToLocal ${HDFS_OUTPUT_PATH}/word-count-apache-hive ./hive-files
hadoop fs -copyToLocal ${HDFS_OUTPUT_PATH}/word-count-spark ./spark-files
hadoop fs -copyToLocal ${HDFS_OUTPUT_PATH}/word-count-apache-pig ./pig-files
echo "Hive files: `ls -l ./hive-files`"
echo "Java files: `ls -l ./spark-files`"
echo "Pig files: `ls -l ./pig-files`"

HIVE_COUNTS=`cat ./hive-files/* | grep ${KEYWORD}`
SPARK_COUNTS=`cat ./spark-files/* | grep ${KEYWORD} | sed 's/,/\t/'`
#Remove parenthesis
SPARK_COUNTS=${SPARK_COUNTS/\(/}
SPARK_COUNTS=${SPARK_COUNTS/\)/}
PIG_COUNTS=`cat ./pig-files/*  | grep ${KEYWORD}`

echo :$HIVE_COUNTS:
echo :$SPARK_COUNTS:
echo :$PIG_COUNTS:

if [ "$HIVE_COUNTS" != "$SPARK_COUNTS" ]; then
  echo hive and spark not equal!
  exit 1
fi

if [ "$HIVE_COUNTS" != "$PIG_COUNTS" ]; then
  echo hive and pig not equal!
  exit 1
fi
