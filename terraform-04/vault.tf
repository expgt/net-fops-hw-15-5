# provider "vault" {
#   address         = "http://127.0.0.1:8200"
#   skip_tls_verify = true
#   token           = "education"
# }

# resource "vault_generic_secret" "new_secret" {
#   path = "secret/new_secret"

#   data_json = jsonencode({
#     new_test = "congrats!!!"
#   })
# }

# data "vault_generic_secret" "check_new_secret" {
#   path = "secret/new_secret"

#   depends_on = [vault_generic_secret.new_secret]
# }

# output "new_vault_secret_value" {
#   value       = nonsensitive(data.vault_generic_secret.check_new_secret.data)
# }

# output "new_vault_secret_specific_key" {
#   value       = nonsensitive(data.vault_generic_secret.check_new_secret.data["new_test"])
# }

# # data "vault_generic_secret" "vault_example" {
# #   path = "secret/example"
# # }

# # output "vault_example" {
# #   value       = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
# # }