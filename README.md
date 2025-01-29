# Repository for Personl Utilities

## 1. Airflow docker compose file

this allows you to install dockerised airflow with postgress

download
> curl -LfO https://github.com/bdllhdrss3/utilities/blob/main/airflow


## Auto Configuration files to setup dockerised airflow with postgress on windows and linux 


### linux
 
``` curl -LfO https://github.com/bdllhdrss3/utilities/blob/main/airflow-init.sh ```

### windows 

``` curl -LfO  https://github.com/bdllhdrss3/utilities/blob/main/airflow.bat ```


download these files into the desired directory (where you wish to place your dags)


then run 

``` source airflow-init.sh ```


and on windows


 ``` airflow-init.bat  ```



> ![Screenshot (5)](https://github.com/user-attachments/assets/ed3545a0-7be9-43d4-830e-5ee83a9979b3)








After running the files/executabes successfully  proceed to  ``` localhost:8080 ```
