
PACKAGE := $(shell grep "^Name: " DESCRIPTION | cut -f2 -d" ")
VERSION := $(shell grep "^Version: " DESCRIPTION | cut -f2 -d" ")

RELEASE_DIR     := $(PACKAGE)-$(VERSION)
SHEET_FILE      := 'dia-shapes/sheets/dia-simplemusic.sheet'

DIA:= dia

DIFF_FILES  := $(shell find dia-shapes  -depth  -type f -name '*.diff')
PDF_FILES   := $(shell find share/doc  -depth  -type f -name '*.pdf')
DIA_FILES   := $(shell find dia-shapes  -depth  -type f -name '*.dia')
SHAPE_FILES := $(DIA_FILES:.dia=.shape)
PNG_FILES   := $(DIA_FILES:.dia=.png)

.PHONY: help shapes clean install uninstall run deb dist

help:
	@echo 
	@echo "Targets:"
	@echo 
	@echo "   shapes    - Create/compile the shapes."
	@echo '   clean     - Delete the shape/png files created with "make shapes" (also *.deb and *.tar.gz files).'
	@echo 
	@echo "   install   - Install the $(PACKAGE) package in DIA (it uses first: make shapes)."
	@echo "   uninstall - Uninstall the $(PACKAGE) package of DIA."
	@echo "   run       - Run DIA."
	@echo 
	@echo "   deb       - Creates a *.deb release file (it uses first: make shapes)."
	@echo "   dist      - Creates a *.tar.gz release file (it uses first: make shapes)."
	@echo


%.shape: %.dia
	@echo ""
	@echo "Creating shape: "$@
	$(DIA) --export="$@" "$<"
	$(eval CADENA=$(shell grep "Patch:" $(basename $@).conf | cut -f2 -d":"))
	sed '5i\  $(CADENA)' '$@' > tmp.tmp
	mv tmp.tmp '$@'


$(SHEET_FILE): $(SHAPE_FILES) $(PNG_FILES)
	./dia-shapes/sheets/make_sheet.sh $(SHEET_FILE) "dia-shapes/shapes" DESCRIPTION




shapes: $(SHAPE_FILES)  $(PNG_FILES) $(SHEET_FILE)
	@echo ""
	@echo "All shapes were created..........[OK]"


install: 
	cd dist; ./makedist.sh "${RELEASE_DIR}" 
	@echo "Installing package locally ..."
	cp -v -r -f dist/$(RELEASE_DIR)/shapes/  ~/.dia/
	cp -v -r -f dist/$(RELEASE_DIR)/sheets/  ~/.dia/
	rm -r -f dist/$(RELEASE_DIR)

uninstall:
	rm -r -f ~/.dia/shapes/$(PACKAGE)
	rm -r -f ~/.dia/sheets/dia-simplemusic.sheet

run:
	$(DIA) 

deb:
	cd deb; ./makedeb.sh 
	@echo ""
	@echo "====================================================================="
	@echo "Tasks:"
	@echo "1) Upload to https://site"
	@echo '   the *.deb file located in "deb/" and post :'
	@echo 	
	@echo '2) Execute: '
	@echo '            git tag -a ${VERSION} -m "release-${VERSION}"'
	@echo 	
	@echo "   to mark the current version no repository."
	@echo "====================================================================="
	@echo

dist: 
	cd dist; ./makedist.sh 
	@echo ""
	@echo "====================================================================="
	@echo "Tasks:"
	@echo "1) Upload to https://site"
	@echo '   the *.tar.gz file located in "dist/" and post :'
	@echo 	
	@echo '2) Execute: '
	@echo '            git tag -a ${VERSION} -m "release-${VERSION}"'
	@echo 	
	@echo "   to mark the current version no repository."
	@echo "====================================================================="
	@echo


clean:
	$(RM) -r deb/*.deb
	$(RM) -r dist/*.tar.gz
	$(RM) -r dia-shapes/sheets/*.sheet 
	$(RM) -r dia-shapes/shapes/dia-simplemusic/*.shape
	$(RM) -r dia-shapes/shapes/dia-simplemusic/*.png

gitcola:
	git-cola
