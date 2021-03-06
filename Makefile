#VERSION:=	$(shell date '+%Y%m%d')
VERSION :=	0.3.1
ZIP_NAME ?=	csr-spi-ftdi-$(VERSION)
ZIP_FILES +=	spilpt-win32-api1.4/spilpt.dll spilpt-win32-api1.3/spilpt.dll \
	spilpt-wine-api1.4/spilpt.dll.so spilpt-wine-api1.3/spilpt.dll.so \
	README.md hardware/csr-spi-ftdi.sch hardware/csr-spi-ftdi.svg \
	hardware/components.lib misc

all: win32 wine

win32::
	make -f Makefile.mingw all

wine::
	make -f Makefile.wine all

zip: all
	rm -rf $(ZIP_NAME).zip $(ZIP_NAME)
	mkdir -p $(ZIP_NAME)
	for p in $(ZIP_FILES); do \
		mkdir -p $(ZIP_NAME)/`dirname $$p`; \
		cp -Rp $$p $(ZIP_NAME)/`dirname $$p`; \
	done
	zip -9r $(ZIP_NAME).zip $(ZIP_NAME)

clean:
	make -f Makefile.mingw clean
	make -f Makefile.wine clean
	rm -rf $(ZIP_NAME) $(ZIP_NAME).zip
