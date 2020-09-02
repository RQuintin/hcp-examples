eks: tf
	terraform apply

tf:
	terraform init

hcp:
	terraform apply -var 'setup_hcp=true'

k8s-secrets:
	kubectl create secret generic hcp-consul --from-file='caCert=./secrets/ca.pem' --from-file='gossipEncryptionKey=./secrets/gossipEncryption'
	kubectl create secret generic hcp-consul-bootstrap-token --from-file='token=./secrets/token'
	kubectl create secret generic consul-client-acl-token --from-file='token=./secrets/token'

consul: k8s-secrets
	helm install consul hashicorp/consul -f values.yml

clean:
	helm del consul || true
	kubectl delete jobs consul-server-acl-init consul-server-acl-init-cleanup || true
	kubectl delete secret hcp-consul hcp-consul-bootstrap-token consul-client-acl-token
