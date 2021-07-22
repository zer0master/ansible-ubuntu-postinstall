# just can't escape it, can we?
#

#DRYRUN?=""
VAULT_PASSWD_FILE := ~/.ssh/.vp

ifdef TAGS
TAGOPT := --tags "$(TAGS)"
endif

.PHONY: \
	help \
	post-install


post-install: add-deployer
	ansible-playbook $(TAGOPT) \
		-vv \
		--inventory hosts.yml \
		--vault-password-file ${VAULT_PASSWD_FILE} \
		site.yml

# uses a separate "bootstrap" vault file with the failsafe user; probably could be combined with original with
# sensible naming
add-deployer:
	ansible-playbook $(TAGOPT) \
		-vv \
		--inventory hosts-interim.yml \
		--vault-password-file ${VAULT_PASSWD_FILE} \
		add-deployer.yml

# show available targets
help:
	@awk '/^[-a-z]+:/' Makefile | cut -f1 -d\  | sort
