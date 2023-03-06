#!/bin/bash

echo 'Todos com 777 à /public e ao diretório de seu respectivo grupo, aos demais dir dos demais grupos: ---'

echo 'Criando diretórios'
mkdir /public
mkdir /adm
mkdir /ven
mkdir /sec

echo 'Criação grupos admin, vendas e security'
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Criação dos 9 usuários"
_msg="
carlos, maria e joao: ADM
debora, sebastiana e roberto: VEN
josefina, amanda e rogerio: SEC"
echo "$_msg"
i=0
for i in {1..9}
do
	echo "Adicionar usuário: "
	read user
	echo "Adicionar senha ao usuário: "
	read password
	useradd -m -d /home/${user} -p $(openssl passwd -1 ${password}) -s /bin/bash ${user}
	chown -R root /home/${user}  #root owning user's home
	echo "Usuário ${user} criado com sucesso!"
done

echo "Atribuição aos grupos de forma manual"
usermod -G GRP_ADM carlos
usermod -G GRP_ADM maria
usermod -G GRP_ADM joao
usermod -G GRP_VEN debora
usermod -G GRP_VEN sebastiana
usermod -G GRP_VEN roberto
usermod -G GRP_SEC josefina
usermod -G GRP_SEC amanda
usermod -G GRP_SEC rogerio
#melhorar script

echo "Permissionamento"
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec
chown root:$whoami /public
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /public
