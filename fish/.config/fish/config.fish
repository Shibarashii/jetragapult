source /usr/share/cachyos-fish-config/cachyos-config.fish

abbr -a tl 'tmuxp load'
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

# overwrite greeting
# potentially disabling fastfetchk
#function fish_greeting
#    # smth smth
#end
