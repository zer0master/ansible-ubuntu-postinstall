# just can't escape it, can we?
#

#DRYRUN?=""
VAULT_PASSWD_FILE := ~/.ssh/.vp
INSTALLED_ROLES := $(shell grep name requirements.yml | cut -f3 -d\ )

ifdef TAGS
TAGOPT := --tags "$(TAGS)"
endif

.PHONY: \
	help \
	post-install


post-install: install-role-deps add-deployer
	ansible-playbook $(TAGOPT) \
		-vv \
		--inventory hosts.yml \
		--vault-password-file ${VAULT_PASSWD_FILE} \
		site.yml

install-role-deps:
	ansible-galaxy role install -vv --role-file requirements.yml --roles-path roles/

# uses a separate "bootstrap" vault file with the failsafe user; probably could be combined with original with
# sensible naming
add-deployer:
	ansible-playbook $(TAGOPT) \
		-vv \
		--inventory hosts-interim.yml \
		--vault-password-file ${VAULT_PASSWD_FILE} \
		add-deployer.yml

remove-installed-roles:
	ansible-galaxy role remove --roles-path roles/ ${INSTALLED_ROLES}

# show available targets
help:
	@awk '/^[-a-z]+:/' Makefile | cut -f1 -d\  | sort
	@echo "\nInstalled roles: ${INSTALLED_ROLES}"
