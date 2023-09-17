curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>/tmp/backend.log
cp backend.service /etc/systemd/system/backend.service >>/tmp/backend.log

dnf install nodejs -y >>/tmp/backend.log

useradd expense >>/tmp/backend.log
rm -rf /app >>/tmp/backend.log
mkdir /app >>/tmp/backend.log

curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>/tmp/backend.log
cd /app >>/tmp/backend.log
unzip /tmp/backend.zip >>/tmp/backend.log

npm install >>/tmp/backend.log

systemctl daemon-reload >>/tmp/backend.log
systemctl enable backend >>/tmp/backend.log
systemctl start backend >>/tmp/backend.log

dnf install mysql -y >>/tmp/backend.log
mysql -h mysql.mydevops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>/tmp/backend.log