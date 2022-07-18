#!/usr/bin/bash
CWD=`pwd`
#<<<-----colors----->>>#
S0="\033[1;30m" B0="\033[1;40m"
S1="\033[1;31m" B1="\033[1;41m"
S2="\033[1;32m" B2="\033[1;42m"
S3="\033[1;33m" B3="\033[1;43m"
S4="\033[1;34m" B4="\033[1;44m"
S5="\033[1;35m" B5="\033[1;45m"
S6="\033[1;36m" B6="\033[1;46m"
S7="\033[1;37m" B7="\033[1;47m"
R0="\033[00m"   R1="\033[1;00m"
#<---x--->#
internetChek() {
  ping -c 1 google.com &>/dev/null
  if [[ $? == '0' ]]; then
    :
  else
    printf "${S2}[${S1}!${S2}]${S4} Check your internet connection!${R0}\n"
    exit
  fi
}
requirements() {
  nvim=neovim;node=nodejs;git=git;zip=gip;unzip=unzip
  pkges=(nvim node git zip unzip)
  for i in ${pkges[*]}; do
    if ! hash $i>/dev/null 2>&1;then
      internetChek
      apt install ${!i} -y >/dev/null 2>&1 | printf "\r${S2}[${S1}!${S2}]${S4}Package${S1}:${S2} ${!i}${S1} :: ${S4}Not found! ${S3} Installing....${R0}"
    fi
  done
  printf "\n"
}
requirements
if [ ! -f $CWD/assets/nvim-config.zip ]; then
  printf "${S2}[${S1}!${S2}]${S1} Resources not found!${S4} Downloading....${R0}\n"
  internetChek || wget -q "downloadlinkhereinnextcommit"
fi
printf "${S2}\tEnter the index number in which you can see nvim manual or nvim auto${R0}\n"
cd $CWD/assets>/dev/null 2>&1
unzip nvim-config.zip
cd nvim-config>/dev/null 2>&1
bash setup install style=1
bash coc.install
echo -e "
${S2}[${S4}+${S2}]${S2} Setup completed just run ${S7}'${S4}vi${S7}'

${S2}[${S4}+${S2}]${S4} After opening vi wait if it install its assets then press ${S7}'${S2}:${S7}' then write a command ${S7}'${S2}CocInstall coc-sh${S7}'

${S2}<<<${S5}----${S2}shortcut keys and usage${S5}----${S2}>>>${R0}

KEYS                FUNCTION
====°               ========°
i             ------    input mode
ESC ctrl s    ------    Save your data
ESC ctrl q    ------    Exit
ESC v         ------    Enable selection mode
ESC ctrl c    ------    Copy the selected things
ESC ctrl v    ------    Paste the copies things
ALT u         ------    Undo
ESC :FloatermNew -----  Ope floating terminal
ctrl d        ------    Exit floating terminal
"
