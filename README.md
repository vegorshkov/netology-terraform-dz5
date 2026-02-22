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

Реконфигурация подготовка:
![alt text](image-20.png)

Запрашиваем ключи:
![alt text](image-21.png)

Подготовка:
![alt text](image-22.png)

Ищем некорректные данные (из-за 403)
![alt text](image-23.png)
![alt text](image-24.png)

(Terraform S3 backend приоритетно использует:
1.Переменные окружения AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
2.Потом backend-config
3.Потом shared credentials

У меня в окружении экспортирована ДРУГАЯ пара ключей.
Поэтому backend вообще не использует backend.hcl ключи.
Именно поэтому подпись не совпадает.)

Ключи прошли, вижу lock
![alt text](image-25.png)

Есть блок ID:        81053737-f137-674d-b89d-100a0d8f3fc4
Попробуем снять блокировку:

terraform force-unlock 81053737-f137-674d-b89d-100a0d8f3fc4

![alt text](image-26.png)
![alt text](image-27.png)

Использую локальный ключь (он выше по приоритету, для отключения режима блокировки) и выполнения миграции терраформ стейта на s3 bucket:

terraform init -migrate-state -backend-config=backend.hcl -lock=false

![alt text](image-28.png)
![alt text](image-29.png)
![alt text](image-30.png)  стейт читает с S3

План прошел:
![alt text](image-31.png)

![alt text](image-32.png)


Задание 3 "Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит."
Выполняю создание branch ветки.
![alt text](image-33.png)


Проверка на ошибки с помощью checkov
![alt text](image-34.png)
![alt text](image-35.png)
![alt text](image-36.png)

Аналил и исправление:

1)  file backend.hcl уже находитсяв .gitignore
![alt text](image-37.png)
но думаю вытащить в локальную переменную.
![alt text](image-40.png)


2)  chekov рекомендует заменить tag на hash commit
```
git log -1 --format=%h

db43ab3

меняю

```
Проверка:
![alt text](image-38.png)
![alt text](image-39.png)

FIXED:  
![alt text](image-41.png)


Проверка на ошибки с помощью tflint:
![alt text](image-43.png)

FIED:
![alt text](image-44.png)

COMMIT:
Мы уже находимся в ветке хотфикс: https://github.com/vegorshkov/netology-terraform-dz5/tree/terraform-hotfix
![alt text](image-45.png)
![alt text](image-46.png)
Запушил изменения в ветку:
![alt text](image-47.png)

Выполняем сравнение веток и создаем PR:
![alt text](image-48.png)





Остается:

Задание 4
Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console.
type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты: "192.168.0.1" и "1920.1680.0.1";
type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты: ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].
Дополнительные задания (со звёздочкой*)
Настоятельно рекомендуем выполнять все задания со звёздочкой. Их выполнение поможет глубже разобраться в материале.
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию.

Задание 5*
Напишите переменные с валидацией:
type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;
type=object — проверка, что одно из значений равно true, а второе false, т. е. не допускается false false и true true:
variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = <проверка>
    }
}

Задание 6*
Настройте любую известную вам CI/CD-систему. Если вы ещё не знакомы с CI/CD-системами, настоятельно рекомендуем вернуться к этому заданию после изучения Jenkins/Teamcity/Gitlab.
Скачайте с её помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
Уничтожьте инфраструктуру тем же способом.

Задание 7*
Настройте отдельный terraform root модуль, который будет создавать инфраструктуру для remote state:
S3 bucket для tfstate с версионированием
Сервисный аккаунт с необходимыми правами (storage.editor)
Static access key для сервисного аккаунта
Output должен содержать:
Имя bucket
Access key ID и Secret key (sensitive)
Пример конфигурации backend для использования
После создания инфраструктуры используйте outputs для настройки backend в основном проекте.
Примечание: Так как используется use_lockfile = true, создавать YDB/DynamoDB больше не требуется. Блокировки реализованы встроенным механизмом Terraform и хранятся в том же S3 bucket.




