## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex.secondtask"></a> [yandex.secondtask](#provider\_yandex.secondtask) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.secondtask](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.secondtask](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR block for the subnet | `string` | n/a | yes |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | n/a | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the VPC network | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | n/a | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone for the subnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
| <a name="output_subnet_info"></a> [subnet\_info](#output\_subnet\_info) | n/a |
