export BASH_SILENCE_DEPRECATION_WARNING=1

alias c='clear'

alias g='git status'
alias ga='git add '
alias gc='git commit -m'
alias gac='git add . ; git commit -m'
alias gpom='git push origin master'
alias gpo='git push origin'
alias gc-b='git checkout -b'
alias gsu='git submodule update --remote'
alias gl='git log'


alias n='nodemon'
alias ns='npm start'
alias ni='npm i --save-dev'
alias nid='npm i'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrbp='npm run build; git add . ; git commit -m "fresh build"; git push origin master'

alias na='npm audit'
alias naf='npm audit fix'

alias a='atom .'

alias ab='atom ~/.bash_profile'

alias py='python'
alias python='python3'
alias pip='pip3'

alias mongod='mongod --dbpath=/Users/tylergoodman/data/db'

alias ^='cd ../'

alias ls='ls -la'

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[38;5;214m\]\@\[\e[m\] \[\e[38;5;82m\]\w\[\e[m\] \[\e[38;5;45m\]\`parse_git_branch\`\[\e[m\] \[\e[37m\]$\[\e[m\] "
