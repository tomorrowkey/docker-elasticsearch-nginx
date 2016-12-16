docker-elasticsearch-nginx
=====

# Contain components
- nginx v1.10.0
- fluentd 2.3.3
- elasticsearch 5.1.1
- kibana 5.1.1

# Usage

## Build

```sh
docker build . -t elasticsearch-nginx
```

## Run
```sh
docker run --rm -p 9200:9200 -p 5601:5601 -p 80:80 -t elasticsearch-nginx
```

### Access to Nginx

Access logs will be transfered to elasticsearch.

```sh
$ curl http://localhost:80
<html>
<head>
<title>top page</title>
</head>
<body>
<h1>Hello!</h1>

<ul>
<li><a href="admin/index.html">admin</li>
</ul>
</body>
```

### Access to Kibana

Open http://localhost:5601 in browser.

### Access elasticsearch API

```sh
$ curl localhost:9200
{
  "name" : "KLsyeFC",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "zGpR46-CQrqvgL535R4Ydg",
  "version" : {
    "number" : "5.1.1",
    "build_hash" : "5395e21",
    "build_date" : "2016-12-06T12:36:15.409Z",
    "build_snapshot" : false,
    "lucene_version" : "6.3.0"
  },
  "tagline" : "You Know, for Search"
}
```

# License

```
The MIT License (MIT)

Copyright (c) 2016 Tomoki Yamashita

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
