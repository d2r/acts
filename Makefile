VERSION = $(shell $(shell pwd)/acts --version | cut -d' ' -f3)

package: dist/acts_$(VERSION)_all.deb

clean:
	rm -rf dist

check:
	@ shellcheck -s sh -f gcc acts

dist/acts_$(VERSION)_all.deb: dist
	@ fpm \
		-s dir \
		-n acts \
		-t deb \
		-p dist/ \
		--version "$(VERSION)" \
		--maintainer "Alex Jurkiewicz <alex@jurkiewi.cz>" \
		--license "public-domain" \
		--category "utils" \
		--architecture "all" \
		--url "https://github.com/alexjurkiewicz/acts" \
		-d "bsdutils" \
		-d "coreutils >= 8.21" \
		--exclude .git \
		--deb-priority "extra" \
		--config-files "/etc/acts.conf" \
		--deb-no-default-config-files \
		"acts=/usr/bin/acts" \
		"acts.conf.sample=/etc/acts.conf" \
		"README.md=/usr/share/docs/acts/README.md" \
		"contrib/=/usr/share/doc/acts/contrib/"

dist:
	@ mkdir dist

.PHONY: \
	package \
	check \
	clean
