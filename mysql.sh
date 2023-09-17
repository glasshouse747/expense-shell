source common.sh

echo Disable MySQL 8 Client Version
dnf module disable mysql -y >>$log_file

echo Copy MySQL Repo Files
cp mysql.repo /etc/yum.repos.d/mysql.repo >>$log_file

echo Install MySQL Client Server
dnf install mysql-community-server -y >>$log_file

echo Start MySQL Client Server
systemctl enable mysqld >>$log_file
systemctl start mysqld >>$log_file

echo Setup root Password for MySQL Client Server
mysql_secure_installation --set-root-pass ExpenseApp@1 >>$log_file