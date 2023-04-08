if [[ -f "/usr/local/bin/oink.sh" ]]; then
	oink.sh -t "_/ $USER ~VERSION~ \_" -f 5lineoblique
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# custom theme loaded
ZSH_THEME="custom"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

#     ___     // ( )    __  ___  ___      ___     //  ___
#   //   ) ) // / /      / /   //   ) ) //   ) ) // ((   ) )
#  //       // / /      / /   //   / / //   / / //   \ \
# ((____   // / /      / /   ((___/ / ((___/ / // //   ) )
#

alias YQ="yq -P e . -"
alias jqsecrets="jq -rc '.data | to_entries | map(. | { (.key) : .value | @base64d }) | .[]'"
source <(kubectl completion zsh)

#  __  ___  ___      __      _   __     ( )   __      ___     //
#   / /   //___) ) //  ) ) // ) )  ) ) / / //   ) ) //   ) ) //
#  / /   //       //      // / /  / / / / //   / / //   / / //
# / /   ((____   //      // / /  / / / / //   / / ((___( ( //
#

# VI in terminal
bindkey -v

#     ___      ___       __      ___     / __     ( )  __      ___   /
#   ((   ) ) //   ) ) //   ) ) //   ) ) //   ) ) / / //  ) ) //   ) /
#    \ \    //   / / //   / / ((___/ / //   / / / / //      //   / /
# //   ) ) ((___/ / //   / /   //__   ((___/ / / / //      ((___/ /
#

# gdrive and itunes
alias songbirdgi="docker run -it --env-file "${HOME}"/proj/cboin1996/songbird/.env \
	-v "${HOME}"/proj/cboin1996/songbird/app/data/dump:/app/data/dump \
	-v "${HOME}"/proj/cboin1996/songbird/app/data/local_chromium:/root/.local/share/pyppeteer/local-chromium \
	-v "${HOME}"/proj/cboin1996/songbird/app/data/gdrive:/app/data/gdrive \
	-v /path/to/itunesautoadd:/app/data/itunesauto \
	-v /path/to/ituneslib:/app/data/ituneslib \
	-p 8080:8080 \
	--hostname songbird \
	cboin/songbird:latest"

# gdrive
alias songbirdg="docker run -it --env-file "${HOME}"/proj/cboin1996/songbird/.env \
	-v "${HOME}"/proj/cboin1996/songbird/app/data/dump:/app/data/dump \
	-v "${HOME}"/proj/cboin1996/songbird/app/data/local_chromium:/root/.local/share/pyppeteer/local-chromium \
	-v "${HOME}"/proj/cboin1996/songbird/app/data/gdrive:/app/data/gdrive \
	-p 8080:8080 \
	--hostname songbird \
	cboin/songbird:latest"

# itunes
alias songbirdi="docker run -it --env-file "${HOME}"/proj/cboin1996/songbird/.env \
        -v "${HOME}"/proj/cboin1996/songbird/app/data/dump:/app/data/dump \
        -v "${HOME}"/proj/cboin1996/songbird/app/data/local_chromium:/root/.local/share/pyppeteer/local-chromium \
        -v "${HOME}"/Music/iTunes/iTunes\ Media/Automatically\ Add\ to\ Music.localized:/app/data/itunesauto \
        -v "${HOME}"/Music/Itunes/Itunes\ Media/Music:/app/data/ituneslib \
        cboin/songbird:latest"

#     ___                   ___
#   //   ) ) //  / /  / / ((   ) )
#  //   / / //  / /  / /   \ \
# ((___( ( ((__( (__/ / //   ) )
#

# Isenguard stuff
alias awswho="printenv | grep 'AWS_PROFILE' | sed 's/AWS_PROFILE=//'"
alias awswhere="printenv | grep 'AWS_DEFAULT_REGION' | sed 's/AWS_DEFAULT_REGION=//'"

# AWS autocomplete (must be at EOF)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
