SRCDIR :=	.

FPC :=		fpc
FPFLAGS :=	-Sd -Flmongo-c-driver-master

SRC :=		$(wildcard $(SRCDIR)/*.pas)
OBJ :=		$(SRC:.pas=.o)
UNITS :=	$(SRC:.pas=.ppu)

all:;

test:;		$(FPC) $(FPFLAGS) Test.dpr

RM :=		@$(RM) -v

mostlyclean:;	$(RM) $(OBJ) link.res

clean:		mostlyclean
		$(RM) $(NAME) $(UNITS)

.PHONY:		all test
