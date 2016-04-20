# Hey Emacs, this is a -*- makefile -*-

APP := ciap-ip
CONFIGDIR = config
ARCH = _msp430

KCONFDIR := kconf
QCONFFRONTEND ?= $(KCONFDIR)/kconfig/qconf
MCONFFRONTEND ?= $(KCONFDIR)/kconfig/mconf
#QCONFFRONTEND ?= $(KCONFDIR)/kconfig/scripts/kconfig/qconf
#MCONFFRONTEND ?= $(KCONFDIR)/kconfig/scripts/kconfig/mconf
TRANSFORM=$(KCONFDIR)/common/scripts/transform.pl


.PHONY: xconfig menuconfig transform

# This phony target allows the user to change the configuration without
# the need for any of the dependencies to have changed

xconfig: $(APP).temp.fm
	$(QCONFFRONTEND) $(APP).temp.fm $(APP).config
	
menuconfig: $(APP).temp.fm
	$(MCONFFRONTEND) $(APP).temp.fm $(APP).config
	
# generates a variant of OS and application from the configuration
FMDIR := $(KCONFDIR)/common/family/
FAMILYMODELS ?= $(FMDIR)ipstack.cmp.pl:$(FMDIR)ipstack_ciao.cmp.pl

transform: $(APP).config
	$(TRANSFORM) -f $(APP).config -i src/ -o $(CONFIGDIR) -a $(ARCH) -m "$(FAMILYMODELS)" $(TRANSFORMFLAGS)
	@awk -f $(KCONFDIR)/common/scripts/conf2h.awk $(APP).config > $(CONFIGDIR)/kconfig.h

$(APP).temp.fm:
	@echo source $(KCONFDIR)/common/features/ipstack.fm        >$@


.PHONY: $(APP).temp.fm

.INTERMEDIATE: $(APP).temp.fm
