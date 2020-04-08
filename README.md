# letsencrypt
Renovar certificado do Let's Encrypt.
Este arquivo checa diariamente a data da ultima execusão da renovação do seu certificado,caso a data prevista de atualização 
seja igual a data atual, será executado o procedimento de atualização do certificado, e no final do procedimento é enviado um 
e-mail que apresenta o status atual do Apache - "Caso utilize outro altere este processo", logo após mostra os certificados
atualizados e sua data de vencimento, reinicia o serviço do Apache, grava o status e grava a data de execusao deste procedimento
na ultima linha para que seja validado diariamente. 
Caso o resultado da validação não seja igual, enviará um e-mail informando que a atualização é desnecessária no momento, apresenta 
a data que será feita a atualização e a data atual, a mesma só é feita no dia do vencimento, caso quera modificar este paramentro
altere a quantidade de dias da checagem, ou seja, de 90 para 80.

Pre requisitos:
Instale o mailx
Provavelmente seu S.O já terá esta aplicação instalado, caso não tenha instale.
ex:
yum install mailx - Centos
apt-get install mailx - Ubunto
Insira permissão no arquivo renewcert.sh com chmod 775 renewcert.sh
abra o com o vi ou vim e edite as variais de acordo com sua instalação.

Qualquer duvida atila.lofresi@gmail.com espero q de tudo certo!
