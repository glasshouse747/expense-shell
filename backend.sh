source common.sh

echo Installation of NodeJS Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
status

echo Install NodeJS
dnf install nodejs -y &>>$log_file
status

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status

echo Add Application User
useradd expense &>>$log_file
status

echo Clean App Files
rm -rf /app &>>$log_file
mkdir /app &>>$log_file
status

echo Download App Files
curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app
status

echo Extract App Files
unzip /tmp/backend.zip &>>$log_file
status

echo Download Dependencies for App
npm install &>>$log_file
status

echo Start Backend Service Application
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
status

echo Install MySQL Client Application
dnf install mysql -y &>>$log_file
status

echo Load Schema to MySQL
mysql -h mysql.mydevops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
status