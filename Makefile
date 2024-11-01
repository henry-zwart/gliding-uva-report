all: example.pdf template/thumbnail.png

example.pdf: lib.typ template/main.typ
	typst compile template/main.typ example.pdf --root .

template/thumbnail.png: lib.typ template/main.typ
	typst compile template/main.typ template/thumbnail.png --pages 1 --root . 

.PHONY: clean
clean:
	rm example.pdf
	rm template/*.png