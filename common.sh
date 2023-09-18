log_file=/tmp/expense.log

download_and_extract(){

  echo Download $component Code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
 if [ $? -eq 0 ]; then
   echo SUCCESS
 else
   echo FAILED
 fi

  echo Extracting Frontend Code
  unzip /tmp/$component.zip &>>$log_file
 if [ $? -eq 0 ]; then
   echo SUCCESS
 else
   echo FAILED
 fi

}