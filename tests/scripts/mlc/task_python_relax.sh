#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -euxo pipefail

case "$1" in
    cpu)
        export TVM_TEST_TARGETS=llvm
        export TVM_TEST_MARKER="not gpu"
        ;;
    gpu)
        export TVM_TEST_TARGETS=cuda
        export TVM_TEST_MARKER=gpu
        ;;
    *) echo "Expected cpu or gpu" >&2; exit 2 ;;
esac

source ./tests/scripts/test_task_install_dist_wheels.sh
export TVM_BIND_THREADS=0
export TVM_NUM_THREADS=2
./tests/scripts/task_python_unittest.sh tests/python/relax
