source common.sh

echo Disable MySQL 8 Client Version
dnf module disable mysql -y &>>$log_file
status_check

echo Copy MySQL Repo Files
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo Install MySQL Client Server
dnf install mysql-community-server -y &>>$log_file
status_check

echo Start MySQL Client Server
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
status_check

echo Setup root Password for MySQL Client Server
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
status_check