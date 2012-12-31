# .bashrcとか.vimとかがないとno rule~て表示される
DOT_FILES = .zshrc .vimrc .vim .bashrc

all: install

install: bash vim

zsh: $(foreach f, $(filter .zsh%, $(DOT_FILES)), link-dot-file-$(f))

bash: $(foreach f, $(filter .bash%, $(DOT_FILES)), link-dot-file-$(f))

vim: $(foreach f, $(filter .vim%, $(DOT_FILES)), link-dot-file-$(f))
	
.PHONY: clean
	
clean: $(foreach f, $(DOT_FILES), unlink-dot-file-$(f))
	
link-dot-file-%: %
	@echo "Create Symlink $< => $(HOME)/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<
	
unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<
