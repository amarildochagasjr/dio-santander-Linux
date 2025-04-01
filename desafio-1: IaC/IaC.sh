#!/bin/bash

echo "---------- Criando diretórios ----------"

read -p "Digite 'c' para criar diretório ou 's' para sair: " var

while [[ "$var" != "s" && "$var" != "c" ]]
do
  read -p "Comando inválido! Digite 'c' para criar diretório ou 's' para sair: " var
done

while [ "$var" != "s" ]
do
  read -p "Digite um nome para o diretório: " directory
  while [ -d "/$directory" ]
    do
       echo "O diretório '/$directory' já existe, tente novamente."
       read -p "Digite um nome para o diretório: " directory
    done

  sudo mkdir "/$directory"
  echo "Diretório '/$directory' criado com sucesso na raiz!"

  echo "=-=-= Editando permissões do diretório =-=-="
  echo "rwx = 7 // rw = 6 // rx = 5 // r = 4"
  echo "wx = 3  //  w = 2 //  x = 1 // none = 0"
  read -p "Digite o valor da permissão para o proprietário: " perm_owner
  read -p "Digite o valor da permissão para os integrantes: " perm_members
  read -p "digite o valor da permissão para outros usuários: " perm_others

  echo "Permissões definidas com sucesso !"

  sudo chmod "$perm_owner""$perm_members""$perm_others" "/$directory"

  read -p "Digite 'c' para criar outro diretório ou 's' para sair: " var

  while [[ "$var" != "s" && "$var" != "c" ]]
  do
    read -p "Comando inválido! Digite 'c' para criar diretório ou 's' para sair: " var
  done
done

echo "---------- Criando Grupos ------------"

read -p "Digite 'c' para criar grupo ou 's' para sair: " var

while [[ "$var" != "s" && "$var" != "c" ]]
do
  read -p "Comando inválido! Digite 'c' para criar grupo ou 's' para sair: " var
done

while [ "$var" != "s" ]
do
  read -p "Digite um nome para o grupo: " group
  while getent group "$group" > /dev/null 2>&1
  do
    echo "O grupo '/$group' já existe, tente novamente."
    read -p "Digite um nome para o grupo: " group
  done

  sudo groupadd "$group"
  echo "Grupo '$group' criado com sucesso!"
  read -p "Digite 'c' para criar outro grupo ou 's' para sair: " var

  while [[ "$var" != "s" && "$var" != "c" ]]
  do
    read -p "Comando inválido! Digite 'c' para criar grupo ou 's' para sair: " var
  done
done

echo "---------- Criando Usuários ------------"

read -p "Digite 'c' para criar usuário ou 's' para sair: " var

while [[ "$var" != "c" && "$var" != "s" ]]
do
  read -p "Comando inválido! Digite 'c' para criar usuário ou 's' para sair: " var
done

while [ "$var" != "s" ]
do
  read -p "Digite o nome completo do usuário: " fullname
  read -p "Digite um username: " username

  while id "$username" &>/dev/null
  do
    echo "O usuário '$username' já existe, tente novamente."
    read -p "Digite um username: " username
  done

  sudo useradd "$username" -c "$fullname" -m -s /bin/bash -p "$(openssl passwd -6 Senha123)"
  sudo passwd -e "$username"
  echo "Usuário '$username' criado com sucesso!"

  read -p "Deseja adicionar '$username' em algum grupo? (y/n): " var_group

  while [[ "$var_group" != "y" && "$var_group" != "n" ]]
  do
    read -p "Comando inválido! Deseja adicionar '$username' em algum grupo? (y/n): " var_group
  done

  while [ "$var_group" == "y" ]
  do
    read -p "Digite o nome do grupo para o usuário: " group_name

    while ! getent group "$group_name" > /dev/null 2>&1
    do
      read -p "Nome de grupo inválido! Digite o nome de um grupo existente: " group_name
    done

    sudo usermod -aG "$group_name" "$username"
    echo "Usuário '$username' adicionado ao grupo '$group_name' com sucesso!"

    read -p "Deseja adicionar '$username' em outro grupo? (y/n): " var_group

    while [[ "$var_group" != "y" && "$var_group" != "n" ]]
    do
      read -p "Comando inválido! Deseja adicionar '$username' em outro grupo? (y/n): " var_group
    done
  done

  read -p "Digite 'c' para criar outro usuário ou 's' para sair: " var

  while [[ "$var" != "s" && "$var" != "c" ]]
  do
    read -p "Comando inválido! Digite 'c' para criar outro usuário ou 's' para sair: " var
  done
done

echo "---------- Cadastro Finalizado ----------"

