# Executable name
NAME = MegaNijman

# Where to find libraries and source directories
LFLAGS = -L/usr/local/lib -lsfml-graphics -lsfml-window -lsfml-audio -lsfml-system -lsfml-network
IFLAGS = -I/usr/local/include
SRCDIR = Src Src/App

# Compiler and file extension
CC  = g++
EXT = cpp

# Lists of .cpp/.c, .o and .d files
SRCLIST = $(foreach DIR, $(SRCDIR), $(patsubst $(DIR)/%.$(EXT), %.$(EXT), $(wildcard $(DIR)/*.$(EXT))))
OBJLIST = $(patsubst %.$(EXT), %.o, $(SRCLIST))
DEPLIST = $(patsubst %.$(EXT), Temp/%.d, $(SRCLIST))

# Enable Release or Debug mode
ifeq "$(MODE)" "RELEASE"
        CFLAGS = $(IFLAGS)
        VAR = RELEASE
        EXEC = Release/$(NAME)
else
        CFLAGS = -Wall -g $(IFLAGS)
        VAR = DEBUG
        EXEC = Debug/$(NAME)
endif

# Replace file names with correct path
vpath %.$(EXT) $(SRCDIR)
vpath %.h $(SRCDIR)
vpath %.o Temp/

all : folders $(EXEC)

# Link
$(EXEC) : $(OBJLIST)
		@echo "Building  : $(EXEC)"
		@$(CC) -o $(EXEC) $(patsubst %.o, Temp/%.o, $(OBJLIST)) $(LFLAGS)

# Include dependencies
-include $(DEPLIST)

# Compile and generate dependencies
%.o : %.$(EXT)
		@echo "Compiling : $<"
		@$(CC) -c $< $(CFLAGS) -D$(VAR)
		@$(CC) $(CFLAGS) -MM -MT $@ $< -MF $(patsubst %.o, %.d, $@)
		@mv $@ Temp
		@mv $(patsubst %.o, %.d, $@) Temp

.PHONY : clean zip documentation

# Create folders
folders :
		@mkdir -p Debug
		@mkdir -p Release
		@mkdir -p Temp

# Clean Temp directory
clean :
		@rm -rf Temp
		@rm -rf Doc
		@rm -rf Debug
		@rm -rf Release
		@echo "Cleaned project"
		
# Zip project (with current date)
zip :
		@echo "Zipping : $${PWD##*/}_`date "+%m-%d_%H:%M"`.zip"
		@zip -r $${PWD##*/}_`date "+%m-%d_%H:%M"`.zip ../$${PWD##*/}
		@echo "Storing zipped file in parent folder"
		@mv $${PWD##*/}_`date "+%m-%d_%H:%M"`.zip ../

# Generate documentation
documentation :
	@echo "Generating documentation"
	@doxygen Doxyfile
