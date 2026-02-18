# netology-terraform-dz5
"Использование Terraform в команде"

Task1

По заданию первому, обнаружена ошибка во внешнем модуле (форк которым поделился Евгений =), добавлентег версии.
Ошибка обнаружена после запуска tflint
Так же обнаружена ошибка "не обнаружена версия провайдера" data "template_file" "cloudinit", и еще одна ошибка что определены заявлены переменные, но они не используются - и были закомментированы для дальнейшего удаления.

А вот checkov  хочет уже использовать не тег а хеш коммита. Добавил комментарий (https://stackoverflow.com/questions/79326416/how-to-do-a-point-in-time-recovery-with-rds-terraform-using-conditionals)   вида #checkov:skip=CKV_TF_1: Ensure Terraform module sources use a commit hash

Task2

