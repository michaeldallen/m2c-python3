LOG   = 2>&1 | tee -a log.$(shell date +%Y.%m.%d_%H.%M.%S).$@
DATE  = date | sed -n '/\(.*\)/ { h ; 's/./-/g' p ; x ; p ; x ; p }'

SHELL := /bin/bash

ARCH := $(shell dpkg --print-architecture)

# TODO: experimenting with overlay (vs. overlay2) for jenkins-in-docker-in-docker debugging - should move off overlay
# https://github.com/docker/for-linux/issues/711

.PHONY: make.vars make.targets make.clean make.default

make.default : make.vars make.targets

make.vars :
	@echo "available variables"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk '/^# makefile/,/^[^#]/ { if ($$1 !~ "^[#.]") {print $$$$1} }' \
	| sed -e 's/ := / !:= /' -e 's/ = / ! = /' \
	| column -t -s'!' \
	| sed 's/  \([:=]\)/\1/' \
	| sed 's/^/    /' \
	| sort

make.targets :
	@echo "available Make targets:"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| egrep -v '^make.default$$' \
	| sed 's/^/    make    /' \
	| sort \
	| sed 's/make    maven.release$$/make -n maven.release/'


make.clean : 
	@find * -name '*~' -print -delete
	@rm -fv log.*

make.clean.all : 
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| egrep '\.clean$$' \
	| sort \
	| xargs --max-lines=1 $(MAKE) 

IAM := m2c-python3-${ARCH}

docker.build :
	docker build --tag ${IAM} python3 


docker.run.bash : 
	docker \
		run \
		-it \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		${IAM} \
		/bin/bash




#EOF
