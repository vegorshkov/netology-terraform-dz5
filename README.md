# netology-terraform-dz5
"Использование Terraform в команде"

Задание 1

По заданию первому, обнаружена ошибка во внешнем модуле, добавлентег версии.

Ошибка обнаружена после запуска tflint

Так же обнаружена ошибка "не обнаружена версия провайдера" data "template_file" "cloudinit", и еще одна ошибка что определены заявлены переменные, но они не используются - и были закомментированы для дальнейшего удаления.

Найдена ошибка отсутствия тега.

При проверке checkov  хочет уже использовать не тег а хеш коммита. Добавил комментарий (https://stackoverflow.com/questions/79326416/how-to-do-a-point-in-time-recovery-with-rds-terraform-using-conditionals)   вида #checkov:skip=CKV_TF_1: Ensure Terraform module sources use a commit hash

Chechov запуск
![alt text](task1/checkov-02.png)

Tflint запуск
![alt text](task1/tflint-02.png)



Задание 2
Создание S3 бакета
![alt text](image-1.png)
![alt text](image.png)

  добавление роли storage editor для сервисного аккаунта
  ![alt text](image-2.png)

Создание bucket 
  ![alt text](image-3.png)

инициализация переноса tfstate

![alt text](image-4.png)

Миграция
![alt text](image-6.png)
![alt text](image-5.png)

Результат
![alt text](image-7.png)

![alt text](image-8.png)

Выполняем terraform validate   и   terraform plan
![alt text](image-9.png)

Открываю  terraform console
![alt text](image-10.png)

Запуск:
![alt text](image-11.png)

Исправляю ошибки:
![alt text](image-12.png)

init
![alt text](image-14.png)

![alt text](image-15.png)

apply

![alt text](image-16.png)

error

![alt text](image-17.png)

Ура создано.
![alt text](image-18.png)

Созданы:

VPC сеть

3 subnet

2 VM

S3 bucket

service account

static access key


Фиксируем результат:
![alt text](image-19.png)

