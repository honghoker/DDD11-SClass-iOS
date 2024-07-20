GENERATE = mise exec -- tuist generate
FETCH = mise exec -- tuist fetch
BUILD = mise exec -- tuist build
CACHE = mise exec -- tuist cache DDDAttendance
CLEAN = mise exec -- tuist clean
INSTALL = mise exec -- tuist install

CURRENT_DATE = $(shell run scripts/current_date.swift)

# Define your targets and dependencies

.PHONY: generate
generate:
	 TUIST_ROOT_DIR=${PWD} $(GENERATE)

.PHONY: build
build: $(CLEAN) $(FETCH) $(FETCH) TUIST_ROOT_DIR=${PWD} $(GENERATE)

.PHONY: clean
clean:
	$(CLEAN)
	rm -rf **/**/*.xcodeproj
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace


.PHONY: fetch
install:
	$(INSTALL)

.PHONY: cache

cache:
	 $(CACHE)

.PHONY: module
module:
	@bash -c ' \
	read -p "Enter template: " template; \
	read -p "Enter layer: " layer; \
	read -p "Enter name: " name; \
	read -p "Enter author: " author; \
	mise exec -- tuist scaffold $$template --layer $$layer --name $$name --author $$author'

