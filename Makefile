EXAMPLES=$(wildcard *_examples.md)
SESSIONS=$(EXAMPLES:.md=.sh)
.SUFFIXES: .md .sh

all: sessions

sessions: $(SESSIONS)

.md.sh:
	cat $< | sed -n '/^```/,/^```/ p' | sed -z 's|\\\n *||g' | sed '/^```/ d' | sed '1s/^/#doitlive speed: 500\n/'  > $@

clean:
	rm -f $(SESSIONS)
