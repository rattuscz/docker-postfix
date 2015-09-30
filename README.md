docker-postfix
==============
run postfix with smtp authentication (sasldb) in a docker container.

## Requirement
+ Docker 1.0

## Installation
1. Build image

	```bash
	$ sudo docker pull rattus/postfix
	```

## Usage
1. Create postfix container with smtp authentication

	```bash
	$ sudo docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			--name postfix -d rattus/postfix
	# Set multiple user credentials: -e smtp_user=user1:pwd1,user2:pwd2,...,userN:pwdN
	```
## Note
+ Login credential should be set to (`username@mail.example.com`, `password`) in Smtp Client
+ You can assign the port of MTA on the host machine to one other than 25 ([postfix how-to](http://www.postfix.org/MULTI_INSTANCE_README.html))

## Reference
+ [Postfix SASL Howto](http://www.postfix.org/SASL_README.html)

### Credits
	- Credit to: Minghou Ye
	- Original work can be found at: https://github.com/catatnight/docker-postfix


### License
The original author relased the code with a MIT License, this code uses same MIT License.

