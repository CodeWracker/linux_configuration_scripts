#!/bin/bash

# Atualiza o dnf e os pacotes do sistema
sudo dnf update -y

# Função para selecionar/desmarcar opções
choice () {
	local choice=$1
	if [[ ${opts[choice]} ]] # toggle
	then
		opts[choice]=
	else
		opts[choice]=+
	fi
}
verify_option_all (){
    if [[ ${opts[1]} ]]
    then
        choice 1
    fi
}

# Loop para exibir o menu e ler as opções do usuário
while :
do
    clear
    options=("Pronto" "Seleciona Tudo ${opts[1]}" "Instalar Onedriver ${opts[2]}" "Instalar Steam ${opts[3]}" "Instalar VSCode ${opts[4]}" "Configurar alias: cls -> clear ${opts[5]}")
    printf 'escolha o que deve ser feito:%s\n'
    for i in {0..5}
    do
    	echo "${i}) ${options[i]}"
	done
    read -p "Selcionado: " opt
	case $opt in
		0)
			break
			;;
		1)
			# Seleciona/desmarca todas as opções
			for i in {2..5}
			do
				opts[i]=+
			done
			choice 1
			;;
		2)
			verify_option_all
			choice 2
			;;
		3)
			verify_option_all
			choice 3
			;;
		4)
			verify_option_all
			choice 4
			;;
		5)
			verify_option_all
			choice 5
			;;
		*) printf '%s\n' 'Opção inválida';;
	esac
    
done

# Exibe as opções selecionadas pelo usuário
printf '%s\n' 'Opções selecionadas:'
for opt in "${!opts[@]}"
do
    if [[ ${opts[opt]} ]]
    then
        # Remove o "+" da string
        option=$(echo "${options[opt]}" | sed 's/ +//g')
        printf '%s\n' "$option"
    fi
done


# Verifica as opções selecionadas e as executa

# Instala o Onedriver
if [[ ${opts[2]} ]]
then
	sudo dnf copr enable jstaf/onedriver -y
	sudo dnf install onedriver -y
	clear
fi

# Instala o Steam
if [[ ${opts[3]} ]]
then
	sudo dnf config-manager --add-repo=https://negativo17.org/repos/fedora-steam.repo -y
	sudo dnf install steam -y
	clear
fi

# Instala o VSCode
if [[ ${opts[4]} ]]
then
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc -y
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' -y
	sudo dnf install code -y
	clear
fi

# Cria um alias para o comando clear
if [[ ${opts[5]} ]]
then
	echo "alias cls='clear'" >> ~/.bashrc
	source ~/.bashrc
	echo "alias cls='clear'" >> ~/.zshrc
	source ~/.zshrc
	clear
fi

# instruções para mais configurações

# Onedriver
if [[ ${opts[2]} ]]
then
	printf "Abra o app do onedriver e escolha a pasta que quer sincronizar e faça o login %s\n"
fi

# Steam
if [[ ${opts[3]} ]]
then
	printf "Abra a steam e selecione o proton nas configurações do steam play %s\n"
fi

# VSCode
#if [[ ${opts[4]} ]]
#then
#
#fi

# lias para o comando clear
if [[ ${opts[5]} ]]
then
	printf "Para o alias cls surtir efeito reinicie o terminal %s\n"
fi
