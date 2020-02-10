PROG_NAME=8kl
PROG_ORIG=100
DATA_ORIG=1800

LDFLAGS=/N/Y/E

CPM = cpm

FILES = README.md COPYING Makefile mk.bat \
	8kl.doc structures\
	8klisp.mac 8klisp.def \
	inout.mac subr.mac garbage.mac prim.mac fsubr.mac systab.mac \
	factor.l nqueen.l snapshot.l too.l

OBJS =	8klisp.rel \
	inout.rel \
	subr.rel \
	garbage.rel \
	prim.rel \
	fsubr.rel \
	systab.rel

COMMA := ,
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

NAMES = $(subst $(SPACE),$(COMMA),$(OBJS:.rel=))

all: $(PROG_NAME).com

$(PROG_NAME).com: $(OBJS)
	$(CPM) bin/l80 /P:$(PROG_ORIG),/D:$(DATA_ORIG),$(NAMES),$(PROG_NAME)$(LDFLAGS)

$(OBJS): %.rel : %.mac
	$(CPM) bin/m80 =$<

8klisp.rel:		8klisp.mac 8klisp.def
inout.rel:		inout.mac 8klisp.def
subr.rel:		subr.mac 8klisp.def
garbage.rel:	garbage.mac 8klisp.def
prim.rel:		prim.mac 8klisp.def
fsubr.rel:		fsubr.mac 8klisp.def
systab.rel:		systab.mac 8klisp.def

clean:
	rm -f $(PROG_NAME).com *.rel *.prn *.sym *~

tar:
	tar -zcf $(PROG_NAME).tgz $(FILES)

files:
	@echo $(FILES)

difflist:
	@for f in $(FILES); do git diff --quiet $$f >/dev/null || echo $$f; done

run: $(PROG_NAME).com
	$(CPM) $(PROG_NAME)
