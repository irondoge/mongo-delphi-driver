## make variables
MAKE :=		@$(MAKE) --no-print-directory
TRASH :=	/dev/null
## paths
OUTDIR :=	.
SRCDIR :=	sources
TESTDIR :=	sources
DEPDIR :=	mongo-c-driver-master
## compilation options
FPC :=		fpc
FPFLAGS :=	-Tlinux -Sd
## link options
LDFLAGS :=
LDLIBS :=	-Fl$(DEPDIR)
## lib options
SRC :=		$(wildcard $(SRCDIR)/*.pas)
OBJ :=		$(patsubst $(SRCDIR)/%.pas,$(OUTDIR)/%.o,$(SRC))
UNITS :=	$(OBJ:.o=.ppu)
## test binary options
TESTNAME :=	test
TESTSRC :=	$(wildcard $(TESTDIR)/*.dpr)
TESTOBJ :=	$(patsubst $(TESTDIR)/%.dpr,$(OUTDIR)/%.o,$(TESTSRC))
## dependencies options
ZIP :=		mongo-c-driver.zip
DEPFLAGS :=	ALL_CFLAGS="-D_POSIX_C_SOURCE=200112L"
DEPNAMES :=	mongoc bson
DEPNAMES :=	$(foreach var,$(DEPNAMES),$(DEPDIR)/lib$(var).a)

## build rules
all:		deps $(UNITS)

deps:		$(DEPDIR) $(DEPNAMES)
$(DEPDIR):	$(ZIP)
		@printf "=== unzipping $< files... ===\n"
		@unzip $< &> $(TRASH)
$(DEPDIR)/%.a:	$(DEPDIR)/src/env_posix.c
		$(MAKE) -C $(DEPDIR) $(DEPFLAGS) $*.a
$(DEPDIR)/src/env_posix.c: $(DEPDIR)/src/env.c
		cp $< $@

$(OUTDIR)/%.ppu: $(SRCDIR)/%.pas
		$(FPC) -o$(OUTDIR)/ $(FPFLAGS) $<
		@printf "=== $* BUILD COMPLETE ===\n"

$(TESTNAME):	$(TESTSRC) | all
		$(FPC) -o$(OUTDIR)/$@ $(FPFLAGS) $^ $(LDFLAGS) $(LDLIBS)
		@printf "=== $(OUTDIR)/$@ BUILD COMPLETE ===\n\n"

## run rules
check:		$(TESTNAME)
		@./$<

## clean rules
RM :=		@$(RM) -v
SHIT :=		link.res

mostlyclean:;	$(RM) $(OBJ) $(UNITS) $(TESTOBJ) $(SHIT)

clean:		mostlyclean
		$(RM) test
		$(MAKE) -C $(DEPDIR) clean clobber

distclean:	clean
		$(RM) -rvf $(DEPDIR)

re:		mostlyclean all

## misc rules
.PHONY:		all deps re \
		mostlyclean clean distclean \
		check

get-%:;		$($*)
