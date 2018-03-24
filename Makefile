EXAMPLES=$(wildcard *_examples.md)
SESSIONS=$(EXAMPLES:.md=.sh)
.SUFFIXES: .md .sh

sessions: $(SESSIONS)

.md.sh:
	cat $< | sed -n '/^```/,/^```/ p' | sed '/^```/ d' > $@
