# Set mingw64 path
set -x PATH /mingw64/bin $PATH

# Environment
set -x EDITOR vim
set -x VISUAL emacs
set -x PAGER less
set -x CCL_DEFAULT_DIRECTORY ~/install/ccl
set -x OPENMCL_KERNEL wx86cl64

# Common Lisp Package Management
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux ASDF_OUTPUT_TRANSLATIONS "/:/home/asuttles/.cache/common-lisp/"
set -Ux QUICKLISP_HOME $HOME/quicklisp

# Startup Message
function fish_greeting
    set -l color_quote (set_color cyan)
    echo "" $color_quote
    random choice "Every keystroke brings greatness." \
	"This is your launch pad. Go!" \
	"Ctrl+Alt+Conquer." \
	"Warnings are just suggestions." \
	"Commit often. Panic never." \
	"May your bugs be shallow and your commits deep." \
	"Ship it before it ships you." \
	"Enter terminal: destiny awaits."
    echo "" $color_reset
    echo (date)
    echo ""
end

# Prompt
function fish_prompt

    # Save the last command’s exit status
    set -l last_status $status

    # Set colors
    set -l color_cwd (set_color cyan)
    set -l color_reset (set_color normal)
    set -l color_error (set_color red)
    set -l color_prompt (set_color cyan)
    set -l color_git (set_color yellow)

    # Show git status
    if test -d .git
       set stage_files (git diff --name-only | wc -l)
       if test $stage_files -gt 0
       	  echo -n -s $color_git "! " $color_reset
       else
          echo -n -s $color_git "✓ " $color_reset
       end
    end

    # Show the current working directory
    echo -n -s $color_cwd (prompt_pwd) $color_reset ' '

    # Show [exit-code] in color
    if test $last_status != 0
        echo -n -s $color_error '[' $last_status ']' $color_reset
    end

    # End with your custom symbol
    echo -n -s $color_prompt ' > ' $color_reset
end

# Aliases
alias ll='ls -lh'
alias gs='git status'
alias ccl "exec $CCL_DEFAULT_DIRECTORY/$OPENMCL_KERNEL"
