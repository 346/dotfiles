# .bashrcとか.vimとかがないとno rule~て表示される
DOT_FILES = .zshrc .vimrc .vim .bash_profile .bashrc .bashrc.osx .bashrc.linux .xvimrc .gitignore .gitconfig .gemrc .railsrc .bundle

all: install

install: bash git gem rails bundler

ruby:gem rails bundler

zsh: $(foreach f, $(filter .zsh%, $(DOT_FILES)), link-dot-file-$(f))

bash: $(foreach f, $(filter .bash%, $(DOT_FILES)), link-dot-file-$(f))

xcode: $(foreach f, $(filter .xvim%, $(DOT_FILES)), link-dot-file-$(f))

git: $(foreach f, $(filter .git%, $(DOT_FILES)), link-dot-file-$(f))

gem: $(foreach f, $(filter .gem%, $(DOT_FILES)), link-dot-file-$(f))

bundler: $(foreach f, $(filter .bundle%, $(DOT_FILES)), link-dot-file-$(f))

rails: $(foreach f, $(filter .rails%, $(DOT_FILES)), link-dot-file-$(f))
	
.PHONY: clean
	
clean: $(foreach f, $(DOT_FILES), unlink-dot-file-$(f))
	
link-dot-file-%: %
	@echo "Create Symlink $< => $(HOME)/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<
	
unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<
