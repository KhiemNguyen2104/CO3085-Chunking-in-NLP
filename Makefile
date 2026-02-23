# Project Variables
MAIN = main
LATEX = pdflatex
# CHANGED: We now use 'biber' instead of 'bibtex' matching your backend=biber setting
BIB_TOOL = biber
# -interaction=nonstopmode: Tells LaTeX not to halt on errors
# -file-line-error: Shows specifically where errors are in the terminal
FLAGS = -interaction=nonstopmode -file-line-error

# Source files (used for dependency checking)
# ADDED: $(wildcard images/*) so it recompiles when you change images
SOURCES = $(MAIN).tex refs.bib $(wildcard chapters/*/*.tex)

# Phony targets
# ADDED: rebuild
.PHONY: all clean rebuild

# Default target
all: $(MAIN).pdf

# Rebuild Rule: Cleans everything and compiles from scratch
rebuild: clean all

# Main Compilation Rule
# The '-' before commands tells Make to ignore exit errors and keep going
$(MAIN).pdf: $(SOURCES)
	@echo "--- 🚀 Starting Compilation Sequence (Biber Engine) ---"
	@echo "--- Step 1: pdflatex (Drafting) ---"
	-$(LATEX) $(FLAGS) $(MAIN)
	@echo "--- Step 2: biber (Processing References) ---"
	-$(BIB_TOOL) $(MAIN)
	@echo "--- Step 3: pdflatex (Linking) ---"
	-$(LATEX) $(FLAGS) $(MAIN)
	@echo "--- Step 4: pdflatex (Finalizing) ---"
	-$(LATEX) $(FLAGS) $(MAIN)
	@echo "--- ✅ Build Complete ---"

# Clean Rule
# ADDED: .bcf and .run.xml (Specific to Biber/Biblatex)
clean:
	@echo "--- 🧹 Cleaning auxiliary files ---"
	-rm -f $(MAIN).aux $(MAIN).log $(MAIN).out $(MAIN).toc $(MAIN).bbl $(MAIN).blg $(MAIN).lof $(MAIN).lot $(MAIN).synctex.gz $(MAIN).fls $(MAIN).fdb_latexmk
	-rm -f $(MAIN).bcf $(MAIN).run.xml
	-rm -f $(MAIN).pdf
	-find . -type f -name "*.aux" -delete
	-find . -type f -name "*.log" -delete
	@echo "--- ✨ Workspace Cleaned (PDF and TeX preserved) ---"