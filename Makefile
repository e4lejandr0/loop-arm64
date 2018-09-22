BINARIES=loop
AS=as
LD=ld

BINDIR=bin
OBJDIR=obj

all:    ${BINARIES}

loop: loop.s
	mkdir -p ${OBJDIR} ${BINDIR}
	${AS} -g -o ${OBJDIR}/loop.o  loop.s
	${LD} -o ${BINDIR}/loop ${OBJDIR}/loop.o

.PHONY: clean
clean:    
	rm -rf ${BINDIR} ${OBJDIR}

.PHONY: run
run: all
	@${BINDIR}/loop
.PHONY: debug
debug: all
	gdb ${BINDIR}/loop



