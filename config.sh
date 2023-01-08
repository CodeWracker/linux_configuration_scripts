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
    options=("Seleciona Tudo ${opts[1]}" "Instalar Onedriver ${opts[2]}" "Instalar Steam ${opts[3]}" "Sair")
    printf 'escolha o que deve ser feito:%s\n'
    select opt in "${options[@]}"
    do
        case $REPLY in
            1)
                # Seleciona/desmarca todas as opções
                for i in {2..3}
                do
                    opts[i]=+
                done
                choice 1
                break
                ;;
            2)
            	verify_option_all
                choice 2
                break
                ;;
            3)
            	verify_option_all
                choice 3
                break
                ;;
            4)
                break 2
                ;;
            *) printf '%s\n' 'Opção inválida';;
        esac
    done
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


