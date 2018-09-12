 [
    {
      "name": "magento2",
      "image": "${data.aws_ecr_repository.magento2.repository_url}",
      "mountPoints": [
        {
          "containerPath": "/var/www/html/pub/media",
          "sourceVolume": "media",
          "readOnly": null
        }
      ],
      "essential": true,
      "environment": [
        {
          "name": "ENVIRONMENT",
          "value": "${terraform.workspace}"
        },
        {
          "name": "MAGE_MODE",
          "value": "production"
        },
        {
          "name": "CACHE_PREFIX",
          "value": "1_"
        },
        {
          "name": "MYSQL_HOST",
          "value": "${aws_route53_record.db.fqdn}"
        },
        {
          "name": "MYSQL_DATABASE",
          "value": "${var.env_mysql_database}"
        },
        {
          "name": "MYSQL_USER",
          "value": "${var.env_mysql_user}"
        },
        {
          "name": "MYSQL_PASSWORD",
          "value": "${lookup(var.rds_password, terraform.workspace)}"
        },
        {
          "name": "REDIS_CACHE_HOST",
          "value": "${aws_route53_record.redis_cache.fqdn}"
        },
        {
          "name": "REDIS_SESSION_HOST",
          "value": "${aws_route53_record.redis_session.fqdn}"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${terraform.workspace}-app",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "magento2"
        }
      },
      "cpu": 0,
      "memoryReservation": 768
    },
    {
      "name": "nginx",
      "volumesFrom": [
        {
          "readOnly": true,
          "sourceContainer": "magento2"
        }
      ],
      "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80,
          "protocol": "tcp"
        }
      ],
      "essential": true,
      "environment": [],
      "links": [
        "magento2:phpfpm"
      ],
      "image": "${data.aws_ecr_repository.nginx.repository_url}",
      "command": [],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${terraform.workspace}-app",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "nginx"
        }
      },
      "cpu": 0,
      "memoryReservation": 512
    }
  ]