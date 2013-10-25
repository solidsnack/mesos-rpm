# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

BASE_DIR	 =$(shell pwd)
BUILD_DIR	 =$(BASE_DIR)/build-spaces/$(BNAME)

.PHONY: build

rpm: check-env clone-mesos pull-mesos
	./make-support/bootstrap-bspace.sh --build=$(BUILD_DIR) --branch=$(BRANCH) --tag=$(TAG) --commit=$(COMMIT)
	@cd $(BUILD_DIR); \
		./bootstrap

clone-mesos:
	@if [ ! -d "repo" ]; then mkdir repo; fi
	@cd repo; \
		if [ ! -d "mesos" ]; then \
			git clone git@github.com:Guavus/mesos.git; \
		fi

show-mesos-tags: pull-mesos
	@echo "Mesos Tag List:"
	@cd repo/mesos; \
		git tag --list

pull-mesos:
	@echo "Pulling Mesos:"
	@cd repo/mesos; \
		git pull --all; \
		git fetch --tags;


check-env:
ifndef BASE_NAME
	$(error BASE_NAME is undefined! Please specify a Build Base Name aka BASE_NAME. Suggestions:)
		$(MAKE) show-mesos-tags
endif
		@echo "BUILD NAME:$(BNAME)"
	
