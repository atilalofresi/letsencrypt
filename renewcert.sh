##################################################################################
## Renovar Certificados do Letsencrypt 						                              ##
## Dependendo da instalação e distribuição altere os valores definidos abaixo 	##
## Para adicionar mais e-mails em cópia, insira no EMAIL2 semparado por , ex: 	##
## email1@dominio.com,email2@dominio.com 				     	                          ##
## Os arquivos de logs serão enviados para /var/log 				                    ##
## Programe o Cron para executar diariamente	* 7 * * * /local/renewcert.sh     ##
##################################################################################

BOT_FOLDER=/opt/eff.org/certbot/venv/bin
BOT_ARQ=ARQRENEWCERT-$(date +'%d-%m-%y').log
ARQLOG_CERTBOT=RENEW-CERTBOT$(date +'%d-%m-%y').log
EMAIL1=email1@seudominio.com.br
EMAIL2=email2@seudominio.com.br
DATA1=$(date +'%d-%m-%y')
DATA2=$(date +%d-%m-%y --date="$(tail -n 1 /var/log/ARQRENEWCERT*.log) +90 days")  
#alterar para DATA2=


if [[ $DATA1 = $DATA2 ]];

then
  	
	echo "-----Inicio do processo ($(date +'%d-%m-%y----%T'))" >> $BOT_FOLDER/$BOT_ARQ
		/etc/init.d/httpd status  >> $BOT_FOLDER/$BOT_ARQ
				$BOT_FOLDER/certbot renew > $BOT_FOLDER/$ARQLOG_CERTBOT 
				cat $BOT_FOLDER/$ARQLOG_CERTBOT | grep /etc/letsencrypt/live/ >> $BOT_FOLDER/$BOT_ARQ
		/etc/init.d/httpd reload  >> $BOT_FOLDER/$BOT_ARQ
		/etc/init.d/httpd status  >> $BOT_FOLDER/$BOT_ARQ
			
	echo "-----Fim do processo ($(date +'%d-%m-%y----%T'))" >> $BOT_FOLDER/$BOT_ARQ
	echo "$(date +'%y-%m-%d')" >> $BOT_FOLDER/$BOT_ARQ

	mail -s "Notificaçao de renovação do certificado" $EMAIL1 \ -c $EMAIL2 < $BOT_FOLDER/$BOT_ARQ

	#ALTERANDO LOGS PARA VAR/LOGS
	mv $BOT_FOLDER/$ARQLOG_CERTBOT /var/log
	mv $BOT_FOLDER/$BOT_ARQ /var/log
else
        echo "Não existe atualizações para serem feita, data prevista: $DATA2 data atual: $DATA1" | mail -s "Check de Certificado - (RENOVAÇÃO DESNECESSÁRIA)" $EMAIL1 \ -c $EMAIL2

fi



