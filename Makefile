VERSION = 0.14.1
NAME = drakmenustyle
SUBDIRS = po 
localedir = $(DESTDIR)/usr/share/locale
RPM=$(HOME)/rpm
mcc_dir = $(DESTDIR)/usr/share/mcc

override CFLAGS += -DPACKAGE=\"$(NAME)\" -DLOCALEDIR=\"$(localedir)\"

all: 
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

clean:
	$(MAKE) -C po $@
	rm -f *~ core .#*[0-9] core.* *.bak
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

install: all
	$(MAKE) -C po $@
	install -d $(DESTDIR)/usr/{bin/,share/icons}
	install -m755 $(NAME) $(DESTDIR)/usr/bin/$(NAME)
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

dis: clean
	rm -rf $(NAME)-$(VERSION) ../$(NAME)-$(VERSION).tar*
	svn export -q -rBASE . $(NAME)-$(VERSION)
	find $(NAME)-$(VERSION) -name '*.pl' -o -name drakmenustyle | xargs perl -pi -e 's/\s*use\s+(diagnostics|vars|strict).*//g'
	tar cjf ../$(NAME)-$(VERSION).tar.bz2 $(NAME)-$(VERSION)
	rm -rf $(NAME)-$(VERSION)

changelog:
	svn2cl --authors ../common/username.xml --accum
	rm -f ChangeLog.bak


log: changelog
