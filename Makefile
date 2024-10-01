example.pdf: lib.typ template/example.typ
	typst compile template/example.typ example.pdf --root .

.PHONY: clean
clean:
	rm example.pdf