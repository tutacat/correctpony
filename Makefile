include config.mk

SRCDIR = src
OBJDIR = obj

_OBJ = correctpony wlist
OBJ = $(addprefix $(OBJDIR)/,$(addsuffix .o,$(_OBJ)))

all : $(OBJDIR) $(OBJ) correctpony

$(OBJDIR) :
	@mkdir $(OBJDIR)

$(OBJDIR)/%.o : $(SRCDIR)/%.c
	@echo CC -c $<
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

correctpony : $(OBJ) $(OBJDIR)/correctpony.o
	@$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

install : all
	@echo installing executable files to ${DESTDIR}${PREFIX}${BIN}
	mkdir -p ${DESTDIR}${PREFIX}${BIN}
	install -m 755 correctpony{,-security} ${DESTDIR}${PREFIX}$(BIN}
	@echo installing wordlists to ${DESTDIR}${PREFIX}${DATA}/correctpony
	mkdir -p ${DESTDIR}${PREFIX}${DATA}/correctpony
	install -m 644 wordlists/* ${DESTDIR}${PREFIX}${DATA}/correctpony
	cat wordlists/* | sort | uniq > ${DESTDIR}${PREFIX}${DATA}/correctpony/everything
	@echo installing bash-completion script
	mkdir -p ${DESTDIR}${PREFIX}${DATA}/bash-completion/completions
	install -m 644 bash-completion ${DESTDIR}${PREFIX}${DATA}/bash-completion/completions/correctpony
	@echo installing license files script
	mkdir -p ${DESTDIR}${PREFIX}${DATA}/licenses/correctpony
	install -m 644 COPYING ${DESTDIR}${PREFIX}${DATA}/licenses/correctpony

uninstall :
	rm -rf ${DESTDIR}${PREFIX}${DATA}/correctpony
	unlink ${DESTDIR}${PREFIX}${BIN}/correctpony
	unlink ${DESTDIR}${PREFIX}${BIN}/correctpony-security
	unlink ${DESTDIR}${PREFIX}${DATA}/bash-completion/completions/correctpony

clean :
	@echo cleaning
	@rm -rf $(OBJDIR)

.PHONY: clean install

