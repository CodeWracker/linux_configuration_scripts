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
    options=("Pronto" "Seleciona Tudo ${opts[1]}" "Instalar Onedriver ${opts[2]}" "Instalar Steam ${opts[3]}" "Instalar VSCode ${opts[4]}" "Configurar alias: cls -> clear ${opts[5]}" "Instalar python 3.9 ${opts[6]}" "Instalar Microsoft Edge ${opts[7]}" "Instalar o PIP ${opts[8]}" "Instalar unrar e unzip ${opts[9]}" "Instalar wine ${opts[10]}" "Instalar discord ${opts[11]}" "Instalar spotify ${opts[12]}" "Instalar GCC/G++ ${opts[13]}" "Instalar o nodeJS ${opts[14]}" "Instalar o git ${opts[15]}", "Instalar qBitTorrent ${opts[16]}", "Instalar Docker ${opts[17]}", "Configurar discos externos ${opts[18]}")
    programas=( "Onedriver" "Steam" "VSCode" "Alias" "Python 3.9" "Microsoft Edge" "PIP" "unrar e unzip" "wine" "discord" "spotify" "GCC/G++" "nodeJS" "git" "qBitTorrent" "Docker" "Discos Externos")
    printf 'escolha o que deve ser feito:%s\n'
    for i in {0..${#options[@]}}
    do
        echo "${i}) ${options[i]}"
    done
    read -p "Selcionado: " opt
    
    if [ $opt -lt ${#options[@]} ] && [ $opt -ge 1 ]; then
        if [ $opt -eq 1 ]; then
            # Seleciona/desmarca todas as opções
            for i in {2..${#options[@]}}
            do
                opts[i]=+
            done
            choice 1
        else
            verify_option_all
            choice $opt
        fi
    else
        printf '%s\n' 'Opção inválida'
    fi
    if [ $opt -eq 0 ]; then
        break
    fi
    
    
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


# Instala o python 3.9
if [[ ${opts[6]} ]]
then
    sudo dnf install python39 -y
    clear
fi

# Instala o Microsoft Edge
if [[ ${opts[7]} ]]
then
    # Adiciona o repositório do Microsoft Edge
    sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge -y
    
    # Instala o Microsoft Edge
    sudo dnf install microsoft-edge-dev -y
    clear
fi

# Instala o PIP
if [[ ${opts[8]} ]]
then
    sudo dnf install python3-pip -y
    clear
fi

# Instala o unrar e unzip
if [[ ${opts[9]} ]]
then
    sudo dnf install unrar unzip -y
    clear
fi

# Instala o wine
if [[ ${opts[10]} ]]
then
    sudo dnf install wine -y
    clear
fi

# Instala o discord
if [[ ${opts[11]} ]]
then
    # Baixar o pacote do Discord
    curl -o discord.rpm -L https://discordapp.com/api/download?platform=linux&format=rpm
    
    # Instalar o pacote do Discord
    sudo dnf install discord.rpm -y
    
    # Remover o pacote baixado
    rm discord.rpm
    clear
fi

# Instala o spotify
if [[ ${opts[12]} ]]
then
    # Adicionando o repositório do Spotify
    sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
    
    # Instalando o Spotify
    sudo dnf install spotify-client -y
    clear
fi

# Instala o gcc/g++
if [[ ${opts[13]} ]]
then
    sudo dnf install gcc-c++ -y
    clear
fi

# Instala o nodejs
if [[ ${opts[14]} ]]
then
    sudo dnf module install nodejs:$(dnf module list nodejs | awk '/^\*/ {print $2}') -y
    clear
fi

# Instala o git
if [[ ${opts[15]} ]]
then
    sudo dnf install git -y
    clear
fi

# Instala o qbittorrent
if [[ ${opts[16]} ]]
then
    sudo dnf install qbittorrent -y
    clear
fi


# Instala o Docker
if [[ ${opts[17]} ]]
then
    # Adiciona o repositório do Docker
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
    sudo dnf -y install dnf-plugins-core
    
    # Instala o Docker Engine
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    
fi


# -------------------------------------------------------------------------------------------------
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

#VSCode
if [[ ${opts[4]} ]]
then
    printf "Abra o VSCode e logue na sua conta %s\n"
fi

# lias para o comando clear
if [[ ${opts[5]} ]]
then
    printf "Para o alias cls surtir efeito reinicie o terminal %s\n"
fi

# python 3.9
if [[ ${opts[6]} ]]
then
    printf "Para ver a versão do python 3.9 digite: python3.9 --version %s\n"
    python3.9 --version
fi

# Microsoft Edge
if [[ ${opts[7]} ]]
then
    printf "Abra o Microsoft Edge e faça o login %s\n"
fi

# PIP
if [[ ${opts[8]} ]]
then
    printf "Para ver a versão do pip digite: pip --version %s\n"
    pip --version
fi

# unrar e unzip
if [[ ${opts[9]} ]]
then
    printf "Para descompactar um arquivo rar digite: unrar e <nome do arquivo> %s\n"
    printf "Para descompactar um arquivo zip digite: unzip <nome do arquivo> %s\n"
fi

# wine
if [[ ${opts[10]} ]]
then
    printf "Para instalar um programa no wine digite: wine <nome do programa> %s\n"
fi

# discord
if [[ ${opts[11]} ]]
then
    printf "Abra o discord e faça o login %s\n"
fi

# spotify
if [[ ${opts[12]} ]]
then
    printf "Abra o spotify e faça o login %s\n"
fi

# gcc/g++
if [[ ${opts[13]} ]]
then
    printf "Para compilar um arquivo c++ digite: g++ <nome do arquivo> -o <nome do executavel> %s\n"
    printf "Para ver a versão do gcc/g++ digite: g++ --version %s\n"
    g++ --version
fi

# nodejs
if [[ ${opts[14]} ]]
then
    printf "Para ver a versão do nodejs digite: node --version %s\n"
    node --version
    printf "Para ver a versão do npm digite: npm --version %s\n"
    npm --version
fi

# git
if [[ ${opts[15]} ]]
then
    printf "Para ver a versão do git digite: git --version %s\n"
    git --version
fi


# qbittorrent
if [[ ${opts[16]} ]]
then
    printf "Para abrir o qbittorrent digite: qbittorrent %s\n"
    printf "Para ver a versão do qbittorrent digite: qbittorrent --version %s\n"
    qbittorrent --version
fi

# Docker
if [[ ${opts[17]} ]]
then
    printf "Para ver a versão do docker digite: docker --version %s\n"
    docker --version
    printf "Para ver a versão do docker-compose digite: docker-compose --version %s\n"
    docker-compose --version
    printf "Para iniciar o docker digite: sudo systemctl start docker %s\n"
fi

# discos
if [[ ${opts[18]}]]
then

    config_disks = 1
    while [ $config_disks -eq 1 ]

        printf "Para listar os discos não montados digite: sudo fdisk -l %s\n"

        ## tutorial para dar um nome ao disco (cria uma pasta com esse nome e monta nela)
        printf "Qual disco você quer dar um nome? %s\n"
        read -r disco

        printf "Qual nome você quer dar para o disco? %s\n"
        read -r nome

        sudo mkdir /mnt/$nome
        sudo mount /dev/$disco /mnt/$nome

        printf "Para desmontar o disco digite: sudo umount /dev/$disco %s\n"

        printf "Deseja dar um nome para outro disco? %s\n"
        printf "1 - Sim %s\n"
        printf "2 - Não %s\n"
        read -r config_disks

    done

fi

# -------------------------------------------------------------------------------------------------

# lista de programas instalados
printf "Programas instalados: %s\n"

# loop para mostrar os programas instalados
for i in "${!opts[@]}"
do
    if [[ ${opts[$i]} ]]
    then
        # existem 2 opções a menos no array de programas
        printf "%s %s\n" "${programas[$i-2]}"
    fi
done

# -------------------------------------------------------------------------------------------------
# Fim do script