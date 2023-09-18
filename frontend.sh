source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y &>>$log_file
status

echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status

echo Removing Old Content from Nginx Html Folder
rm -rf /usr/share/nginx/html/* &>>$log_file
status

cd /usr/share/nginx/html &>>$log_file

download_and_extract

echo Starting Nginx Service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status