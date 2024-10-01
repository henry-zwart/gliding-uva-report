all: example.pdf template/thumbnail.png

example.pdf: lib.typ template/main.typ
	typst compile template/main.typ example.pdf --root .

template/thumbnail.png: lib.typ template/main.typ
	typst compile template/main.typ {n}.png --root . && \
		mv 1.png template/thumbnail.png && \
		rm *.png
	

.PHONY: clean
clean:
	rm example.pdf
	rm template/*.png