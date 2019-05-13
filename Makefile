# Requires circleci CLI installation
# - macos: brew install circleci

ORB_VER ?= 0.0.4

.phony: publish publish-dev validate

publish: src/orb.yml validate
	circleci orb publish src/orb.yml styra/cli@$(ORB_VER)

publish-dev: src/orb.yml validate
	circleci orb publish src/orb.yml styra/cli@dev:$(ORB_VER)

validate: src/orb.yml
	circleci orb validate src/orb.yml
