source common.sh
component=backend

type npm &>>$log_file
if [ $? -ne 0 ]; then
  echo Installation of NodeJS Repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  status_check

  echo Install NodeJS
  dnf install nodejs -y &>>$log_file
  status_check
fi

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status_check

echo Add Application User
id expense &>>$log_file
if [ $? -ne 0 ]; then
  useradd expense &>>$log_file
fi
status_check

echo Clean App Files
rm -rf /app &>>$log_file
mkdir /app &>>$log_file
status_check

echo Download App Files
curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app
status_check

echo Extract App Files
unzip /tmp/backend.zip &>>$log_file
status_check

echo Download Dependencies for App
npm install &>>$log_file
status_check

echo Start Backend Service Application
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
status_check

echo Install MySQL Client Application
dnf install mysql -y &>>$log_file
status_check

echo Load Schema to MySQL
mysql_root_password=$1
mysql -h mysql.mydevops75.online -uroot -p$mysql_root_password < /app/schema/backend.sql &>>$log_file
status_check