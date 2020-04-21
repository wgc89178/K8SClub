



工作目录：/apps/wordpress，内有必要的文件。



### 第一步：创建自定义网络

```
~# docker network create -d bridge --subnet 10.0.10.0/24 appsnet
```





### 第二步：运行db容器

```
~# docker run --name db -d --net appsnet -v /apps/wordpress/db/data/:/var/lib/mysql/ --env-file /apps/wordpress/db/env.list mysql:5.7
```

 

env-file内容

```
MYSQL_DATABASE=wpdb
MYSQL_USER=wpuser
MYSQL_PASSWORD=wppass@magedu.Com
MYSQL_RANDOM_ROOT_PASSWORD=1
```



### 第三步：运行apache+php+wordpress容器



```
~# docker run --name wp -p 8080:80 --net appsnet -d --env-file /apps/wordpress/wp/env.list --link db wordpress:5-php7.2
```

为了便于调试，这里将其暴露于8080端口。



env-file内容：

```
WORDPRESS_DB_HOST=db
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=wppass@magedu.Com
WORDPRESS_DB_NAME=wpdb
```



### 第四步：运行Nginx代理容器

```
~# docker run --name nginx -d --net appsnet --link wp -p 80:80 -v /apps/wordpress/nginx/default.conf:/etc/nginx/conf.d/default.conf:ro nginx:alpine
```



Nginx配置文件示例：

```
server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        #root   /usr/share/nginx/html;
        index  index.php index.html index.htm;
        proxy_pass http://wp/;

        #Proxy Settings
        proxy_redirect     off;
        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
```
