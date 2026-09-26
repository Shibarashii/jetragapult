# Ported from oh-my-zsh (plugins/git, plugins/archlinux) by generating from /usr/share/oh-my-zsh.
# Simple aliases are abbreviations, so they expand to the full command as you type.
status is-interactive; or return

# ---- git ----
abbr -a grt 'cd "$(git rev-parse --show-toplevel || echo .)"'
abbr -a ggpur 'ggu'
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gapa 'git add --patch'
abbr -a gau 'git add --update'
abbr -a gav 'git add --verbose'
abbr -a gwip 'git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
abbr -a gam 'git am'
abbr -a gama 'git am --abort'
abbr -a gamc 'git am --continue'
abbr -a gamscp 'git am --show-current-patch'
abbr -a gams 'git am --skip'
abbr -a gap 'git apply'
abbr -a gapt 'git apply --3way'
abbr -a gbs 'git bisect'
abbr -a gbsb 'git bisect bad'
abbr -a gbsg 'git bisect good'
abbr -a gbsn 'git bisect new'
abbr -a gbso 'git bisect old'
abbr -a gbsr 'git bisect reset'
abbr -a gbss 'git bisect start'
abbr -a gbl 'git blame -w'
abbr -a gb 'git branch'
abbr -a gba 'git branch --all'
abbr -a gbd 'git branch --delete'
abbr -a gbD 'git branch --delete --force'
abbr -a gbgd 'LANG=C git branch --no-color -vv | grep ": gone\\]" | cut -c 3- | awk \'{print $1}\' | xargs git branch -d'
abbr -a gbgD 'LANG=C git branch --no-color -vv | grep ": gone\\]" | cut -c 3- | awk \'{print $1}\' | xargs git branch -D'
abbr -a gbm 'git branch --move'
abbr -a gbnm 'git branch --no-merged'
abbr -a gbr 'git branch --remote'
abbr -a ggsup 'git branch --set-upstream-to=origin/$(git_current_branch)'
abbr -a gbg 'LANG=C git branch -vv | grep ": gone\\]"'
abbr -a gco 'git checkout'
abbr -a gcor 'git checkout --recurse-submodules'
abbr -a gcb 'git checkout -b'
abbr -a gcB 'git checkout -B'
abbr -a gcd 'git checkout $(git_develop_branch)'
abbr -a gcm 'git checkout $(git_main_branch)'
abbr -a gcp 'git cherry-pick'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gclean 'git clean --interactive -d'
abbr -a gcl 'git clone --recurse-submodules'
abbr -a gclf 'git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
abbr -a gcam 'git commit --all --message'
abbr -a gcas 'git commit --all --signoff'
abbr -a gcasm 'git commit --all --signoff --message'
abbr -a gcs 'git commit --gpg-sign'
abbr -a gcss 'git commit --gpg-sign --signoff'
abbr -a gcssm 'git commit --gpg-sign --signoff --message'
abbr -a gcmsg 'git commit --message'
abbr -a gcsm 'git commit --signoff --message'
abbr -a gc 'git commit --verbose'
abbr -a gca 'git commit --verbose --all'
abbr -a gca! 'git commit --verbose --all --amend'
abbr -a gcan! 'git commit --verbose --all --no-edit --amend'
abbr -a gcans! 'git commit --verbose --all --signoff --no-edit --amend'
abbr -a gcann! 'git commit --verbose --all --date=now --no-edit --amend'
abbr -a gc! 'git commit --verbose --amend'
abbr -a gcn 'git commit --verbose --no-edit'
abbr -a gcn! 'git commit --verbose --no-edit --amend'
abbr -a gcf 'git config --list'
abbr -a gcfu 'git commit --fixup'
abbr -a gdct 'git describe --tags $(git rev-list --tags --max-count=1)'
abbr -a gd 'git diff'
abbr -a gdca 'git diff --cached'
abbr -a gdcw 'git diff --cached --word-diff'
abbr -a gds 'git diff --staged'
abbr -a gdw 'git diff --word-diff'
abbr -a gdup 'git diff @{upstream}'
abbr -a gdt 'git diff-tree --no-commit-id --name-only -r'
abbr -a gf 'git fetch'
abbr -a gfo 'git fetch origin'
abbr -a gg 'git gui citool'
abbr -a gga 'git gui citool --amend'
abbr -a ghh 'git help'
abbr -a glgg 'git log --graph'
abbr -a glgga 'git log --graph --decorate --all'
abbr -a glgm 'git log --graph --max-count=10'
abbr -a glods 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
abbr -a glod 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
abbr -a glola 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
abbr -a glols 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
abbr -a glol 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
abbr -a glo 'git log --oneline --decorate'
abbr -a glog 'git log --oneline --decorate --graph'
abbr -a gloga 'git log --oneline --decorate --graph --all'
abbr -a glp '_git_log_prettily'
abbr -a glg 'git log --stat'
abbr -a glgp 'git log --stat --patch'
abbr -a gignored 'git ls-files -v | grep "^[[:lower:]]"'
abbr -a gfg 'git ls-files | grep'
abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmc 'git merge --continue'
abbr -a gms 'git merge --squash'
abbr -a gmff 'git merge --ff-only'
abbr -a gmom 'git merge origin/$(git_main_branch)'
abbr -a gmum 'git merge upstream/$(git_main_branch)'
abbr -a gmtl 'git mergetool --no-prompt'
abbr -a gmtlvim 'git mergetool --no-prompt --tool=vimdiff'
abbr -a gl 'git pull'
abbr -a gpr 'git pull --rebase'
abbr -a gprv 'git pull --rebase -v'
abbr -a gpra 'git pull --rebase --autostash'
abbr -a gprav 'git pull --rebase --autostash -v'
abbr -a gprom 'git pull --rebase origin $(git_main_branch)'
abbr -a gpromi 'git pull --rebase=interactive origin $(git_main_branch)'
abbr -a gprum 'git pull --rebase upstream $(git_main_branch)'
abbr -a gprumi 'git pull --rebase=interactive upstream $(git_main_branch)'
abbr -a ggpull 'git pull origin "$(git_current_branch)"'
abbr -a gluc 'git pull upstream $(git_current_branch)'
abbr -a glum 'git pull upstream $(git_main_branch)'
abbr -a gp 'git push'
abbr -a gpd 'git push --dry-run'
abbr -a gpf! 'git push --force'
abbr -a gpsup 'git push --set-upstream origin $(git_current_branch)'
abbr -a gpv 'git push --verbose'
abbr -a gpoat 'git push origin --all && git push origin --tags'
abbr -a gpod 'git push origin --delete'
abbr -a ggpush 'git push origin "$(git_current_branch)"'
abbr -a gpu 'git push upstream'
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase --interactive'
abbr -a grbo 'git rebase --onto'
abbr -a grbs 'git rebase --skip'
abbr -a grbd 'git rebase $(git_develop_branch)'
abbr -a grbm 'git rebase $(git_main_branch)'
abbr -a grbom 'git rebase origin/$(git_main_branch)'
abbr -a grbum 'git rebase upstream/$(git_main_branch)'
abbr -a grf 'git reflog'
abbr -a gr 'git remote'
abbr -a grv 'git remote --verbose'
abbr -a gra 'git remote add'
abbr -a grrm 'git remote remove'
abbr -a grmv 'git remote rename'
abbr -a grset 'git remote set-url'
abbr -a grup 'git remote update'
abbr -a grh 'git reset'
abbr -a gru 'git reset --'
abbr -a grhh 'git reset --hard'
abbr -a grhk 'git reset --keep'
abbr -a grhs 'git reset --soft'
abbr -a gpristine 'git reset --hard && git clean --force -dfx'
abbr -a gwipe 'git reset --hard && git clean --force -df'
abbr -a groh 'git reset origin/$(git_current_branch) --hard'
abbr -a grs 'git restore'
abbr -a grss 'git restore --source'
abbr -a grst 'git restore --staged'
abbr -a gunwip 'git rev-list --max-count=1 --format="%s" HEAD | grep -q "\\--wip--" && git reset HEAD~1'
abbr -a grev 'git revert'
abbr -a greva 'git revert --abort'
abbr -a grevc 'git revert --continue'
abbr -a grm 'git rm'
abbr -a grmc 'git rm --cached'
abbr -a gcount 'git shortlog --summary --numbered'
abbr -a gsh 'git show'
abbr -a gsps 'git show --pretty=short --show-signature'
abbr -a gstall 'git stash --all'
abbr -a gstaa 'git stash apply'
abbr -a gstc 'git stash clear'
abbr -a gstd 'git stash drop'
abbr -a gstl 'git stash list'
abbr -a gstp 'git stash pop'
abbr -a gsts 'git stash show --patch'
abbr -a gst 'git status'
abbr -a gss 'git status --short'
abbr -a gsb 'git status --short --branch'
abbr -a gsi 'git submodule init'
abbr -a gsu 'git submodule update'
abbr -a gsd 'git svn dcommit'
abbr -a git-svn-dcommit-push 'git svn dcommit && git push github $(git_main_branch):svntrunk'
abbr -a gsr 'git svn rebase'
abbr -a gsw 'git switch'
abbr -a gswc 'git switch --create'
abbr -a gswd 'git switch $(git_develop_branch)'
abbr -a gswm 'git switch $(git_main_branch)'
abbr -a gta 'git tag --annotate'
abbr -a gts 'git tag --sign'
abbr -a gtv 'git tag | sort -V'
abbr -a gignore 'git update-index --assume-unchanged'
abbr -a gunignore 'git update-index --no-assume-unchanged'
abbr -a gwch 'git log --patch --abbrev-commit --pretty=medium --raw'
abbr -a gwt 'git worktree'
abbr -a gwta 'git worktree add'
abbr -a gwtls 'git worktree list'
abbr -a gwtmv 'git worktree move'
abbr -a gwtrm 'git worktree remove'
abbr -a gstu 'gsta --include-untracked'
# git >= 2.30 variants (guarded by is-at-least in zsh)
abbr -a gfa 'git fetch --all --tags --prune --jobs=10'
abbr -a gpf 'git push --force-with-lease --force-if-includes'
abbr -a gpsupf 'git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'

# ---- pacman / AUR helpers ----
abbr -a pacupg 'sudo pacman -Syu'
abbr -a pacin 'sudo pacman -S'
abbr -a paclean 'sudo pacman -Sc'
abbr -a pacins 'sudo pacman -U'
abbr -a paclr 'sudo pacman -Scc'
abbr -a pacre 'sudo pacman -R'
abbr -a pacrem 'sudo pacman -Rns'
abbr -a pacrep 'pacman -Si'
abbr -a pacreps 'pacman -Ss'
abbr -a pacloc 'pacman -Qi'
abbr -a paclocs 'pacman -Qs'
abbr -a pacinsd 'sudo pacman -S --asdeps'
abbr -a pacmir 'sudo pacman -Syy'
abbr -a paclsorphans 'sudo pacman -Qdt'
abbr -a pacrmorphans 'sudo pacman -Rs $(pacman -Qtdq)'
abbr -a pacfileupg 'sudo pacman -Fy'
abbr -a pacfiles 'pacman -F'
abbr -a pacls 'pacman -Ql'
abbr -a pacown 'pacman -Qo'
abbr -a pacupd 'sudo pacman -Sy'
abbr -a pacmanallkeys 'sudo pacman-key --refresh-keys'
if type -q aura
    abbr -a auin 'sudo aura -S'
    abbr -a aurin 'sudo aura -A'
    abbr -a auclean 'sudo aura -Sc'
    abbr -a auclr 'sudo aura -Scc'
    abbr -a auins 'sudo aura -U'
    abbr -a auinsd 'sudo aura -S --asdeps'
    abbr -a aurinsd 'sudo aura -A --asdeps'
    abbr -a auloc 'aura -Qi'
    abbr -a aulocs 'aura -Qs'
    abbr -a aulst 'aura -Qe'
    abbr -a aumir 'sudo aura -Syy'
    abbr -a aurph 'sudo aura -Oj'
    abbr -a aure 'sudo aura -R'
    abbr -a aurem 'sudo aura -Rns'
    abbr -a aurep 'aura -Si'
    abbr -a aurrep 'aura -Ai'
    abbr -a aureps 'aura -As --both'
    abbr -a auras 'aura -As --both'
    abbr -a auupd 'sudo aura -Sy'
    abbr -a auupg 'sudo sh -c "aura -Syu              && aura -Au"'
    abbr -a ausu 'sudo sh -c "aura -Syu --no-confirm && aura -Au --no-confirm"'
    abbr -a auown 'aura -Qqo'
    abbr -a auls 'aura -Qql'
end
if type -q pacaur
    abbr -a pacclean 'pacaur -Sc'
    abbr -a pacclr 'pacaur -Scc'
    abbr -a paupg 'pacaur -Syu'
    abbr -a pasu 'pacaur -Syu --noconfirm'
    abbr -a pain 'pacaur -S'
    abbr -a pains 'pacaur -U'
    abbr -a pare 'pacaur -R'
    abbr -a parem 'pacaur -Rns'
    abbr -a parep 'pacaur -Si'
    abbr -a pareps 'pacaur -Ss'
    abbr -a paloc 'pacaur -Qi'
    abbr -a palocs 'pacaur -Qs'
    abbr -a palst 'pacaur -Qe'
    abbr -a paorph 'pacaur -Qtd'
    abbr -a painsd 'pacaur -S --asdeps'
    abbr -a pamir 'pacaur -Syy'
    abbr -a paupd 'pacaur -Sy'
end
if type -q trizen
    abbr -a trconf 'trizen -C'
    abbr -a trupg 'trizen -Syua'
    abbr -a trsu 'trizen -Syua --noconfirm'
    abbr -a trin 'trizen -S'
    abbr -a trclean 'trizen -Sc'
    abbr -a trclr 'trizen -Scc'
    abbr -a trins 'trizen -U'
    abbr -a trre 'trizen -R'
    abbr -a trrem 'trizen -Rns'
    abbr -a trrep 'trizen -Si'
    abbr -a trreps 'trizen -Ss'
    abbr -a trloc 'trizen -Qi'
    abbr -a trlocs 'trizen -Qs'
    abbr -a trlst 'trizen -Qe'
    abbr -a trorph 'trizen -Qtd'
    abbr -a trinsd 'trizen -S --asdeps'
    abbr -a trmir 'trizen -Syy'
    abbr -a trupd 'trizen -Sy'
end
if type -q yay
    abbr -a yaconf 'yay -Pg'
    abbr -a yaclean 'yay -Sc'
    abbr -a yaclr 'yay -Scc'
    abbr -a yaupg 'yay -Syu'
    abbr -a yasu 'yay -Syu --noconfirm'
    abbr -a yain 'yay -S'
    abbr -a yains 'yay -U'
    abbr -a yare 'yay -R'
    abbr -a yarem 'yay -Rns'
    abbr -a yarep 'yay -Si'
    abbr -a yareps 'yay -Ss'
    abbr -a yaloc 'yay -Qi'
    abbr -a yalocs 'yay -Qs'
    abbr -a yalst 'yay -Qe'
    abbr -a yaorph 'yay -Qtd'
    abbr -a yainsd 'yay -S --asdeps'
    abbr -a yamir 'yay -Syy'
    abbr -a yaupd 'yay -Sy'
end

# ---- helper functions (fish ports of the oh-my-zsh ones) ----
function git_current_branch
    set -l ref (command git symbolic-ref --quiet HEAD 2>/dev/null)
    set -l ret $status
    if test $ret -ne 0
        test $ret -eq 128; and return
        set ref (command git rev-parse --short HEAD 2>/dev/null); or return
    end
    string replace -r '^refs/heads/' '' -- $ref
end

function git_develop_branch
    command git rev-parse --git-dir &>/dev/null; or return
    for b in dev devel develop development
        if command git show-ref -q --verify refs/heads/$b
            echo $b
            return 0
        end
    end
    echo develop
    return 1
end

function git_main_branch
    command git rev-parse --git-dir &>/dev/null; or return
    for base in refs/heads refs/remotes/origin refs/remotes/upstream
        for b in main trunk mainline default stable master
            if command git show-ref -q --verify $base/$b
                echo $b
                return 0
            end
        end
    end
    for remote in origin upstream
        set -l ref (command git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null)
        if string match -q "$remote/*" -- $ref
            string replace "$remote/" '' -- $ref
            return 0
        end
    end
    echo master
    return 1
end

function grename -d "rename a branch locally and on origin"
    if test (count $argv) -ne 2
        echo "Usage: grename old_branch new_branch"
        return 1
    end
    git branch -m $argv[1] $argv[2]
    if git push origin :$argv[1]
        git push --set-upstream origin $argv[2]
    end
end

function gbda -d "delete branches merged into main/develop"
    git branch --no-color --merged | command grep -vE "^([+*]|\s*("(git_main_branch)"|"(git_develop_branch)")\s*\$)" | command xargs git branch --delete 2>/dev/null
end

function ggu
    set -l b
    test (count $argv) -ne 1; and set b (git_current_branch)
    git pull --rebase origin (test -n "$b"; and echo $b; or echo $argv[1])
end
abbr -a ggpur ggu

function ggl
    if test (count $argv) -gt 1
        git pull origin "$argv"
    else
        set -l b $argv[1]
        test (count $argv) -eq 0; and set b (git_current_branch)
        git pull origin $b
    end
end

function ggp
    if test (count $argv) -gt 1
        git push origin "$argv"
    else
        set -l b $argv[1]
        test (count $argv) -eq 0; and set b (git_current_branch)
        git push origin $b
    end
end

function ggf
    set -l b $argv[1]
    test (count $argv) -ne 1; and set b (git_current_branch)
    git push --force origin $b
end

function ggfl
    set -l b $argv[1]
    test (count $argv) -ne 1; and set b (git_current_branch)
    git push --force-with-lease origin $b
end

function ggpnp
    if test (count $argv) -eq 0
        ggl; and ggp
    else
        ggl $argv; and ggp $argv
    end
end

function gdv;       git diff -w $argv | view -; end
function gdnolock;  git diff $argv ":(exclude)package-lock.json" ":(exclude)*.lock"; end
function gtl;       git tag --sort=-v:refname -n --list "$argv[1]*"; end
function gk;        command gitk --all --branches $argv &; disown; end
function gke;       command gitk --all (git log --walk-reflogs --pretty=%h) $argv &; disown; end

function gunwipall -d 'undo all recent --wip-- commits'
    set -l c (git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)
    if test "$c" != (git rev-parse HEAD)
        git reset $c
    end
end

function work_in_progress
    command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--"; and echo "WIP!!"
end

function gccd -d "git clone --recurse-submodules and cd into it"
    command git clone --recurse-submodules $argv; or return
    set -l repo (string match -rv '^-' -- $argv)[-1]
    cd (string replace -r '\.git/*$' '' -- (path basename $repo))
end

function paclist -d "installed explicit packages with descriptions"
    pacman -Qqe | xargs -I{} -P0 --no-run-if-empty pacman -Qs --color=auto "^{}\$"
end

function pacdisowned -d "files not owned by any package"
    set -l tmp (mktemp --directory)
    pacman -Qlq | sort -u >$tmp/db
    find /etc /usr ! -name lost+found \( -type d -printf '%p/\n' -o -print \) | sort >$tmp/fs
    comm -23 $tmp/fs $tmp/db
    rm -rf $tmp
end

function pacmansignkeys
    for key in $argv
        sudo pacman-key --recv-keys $key
        sudo pacman-key --lsign-key $key
        printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg --no-permission-warning --command-fd 0 --edit-key $key
    end
end

function upgrade -d "refresh keyring if needed, then full system upgrade"
    sudo pacman -Sy
    echo ":: Checking Arch Linux PGP Keyring..."
    set -l inst (LANG= pacman -Qi archlinux-keyring | string match -r 'Version\s*:\s*(\S+)')[2]
    set -l cur (LANG= pacman -Si archlinux-keyring | string match -r 'Version\s*:\s*(\S+)')[2]
    if test "$inst" != "$cur"
        echo " Arch Linux PGP Keyring is out of date. Updating before full system upgrade."
        sudo pacman -S --needed --noconfirm archlinux-keyring
    else
        echo " Arch Linux PGP Keyring is up to date. Proceeding with full system upgrade."
    end
    if type -q yay
        yay -Su
    else if type -q trizen
        trizen -Su
    else if type -q pacaur
        pacaur -Su
    else if type -q aura
        sudo aura -Su
    else
        sudo pacman -Su
    end
end
