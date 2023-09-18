source common.sh

echo Installation of NodeJS Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
stat_check

echo Install NodeJS
dnf install nodejs -y &>>$log_file
stat_check

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo Add Application User
useradd expense &>>$log_file
stat_check

echo Clean App Files
rm -rf /app &>>$log_file
mkdir /app &>>$log_file
stat_check

echo Download App Files
curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app
stat_check

echo Extract App Files
unzip /tmp/backend.zip &>>$log_file
stat_check

echo Download Dependencies for App
npm install &>>$log_file
stat_check

echo Start Backend Service Application
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
stat_check

echo Install MySQL Client Application
dnf install mysql -y &>>$log_file
stat_check

echo Load Schema to MySQL
mysql -h mysql.mydevops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check