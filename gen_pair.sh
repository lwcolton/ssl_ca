set -e
set -u

domain_name=$1

openssl genrsa -out intermediate/private/$domain_name.key.pem 2048
chmod 400 intermediate/private/$domain_name.key.pem

openssl req -config intermediate/openssl.cnf \
    -key intermediate/private/$domain_name.key.pem \
    -new -sha256 -out intermediate/csr/$domain_name.csr.pem

openssl ca -config intermediate/openssl.cnf \
    -extensions server_cert -days 375 -notext -md sha256 \
    -in intermediate/csr/$domain_name.csr.pem \
    -out intermediate/certs/$domain_name.cert.pem
chmod 444 intermediate/certs/$domain_name.cert.pem
