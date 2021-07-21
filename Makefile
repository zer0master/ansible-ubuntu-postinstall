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


post-install:
	ansible-playbook $(TAGOPT) \
		-vv \
		--inventory hosts.yml \
		--vault-password-file ${VAULT_PASSWD_FILE} \
		site.yml

# show available targets
help:
	@awk '/^[-a-z]+:/' Makefile | cut -f1 -d\  | sort
