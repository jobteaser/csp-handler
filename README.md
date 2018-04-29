# Content Security Policy Handler

This stateless service handle the Content Security Policy violation report and log it.

## Abstract

![](https://github.com/jobteaser/csp-handler/raw/master/schema.png)

This service handle all **CSP Report** and log it on `STDOUT`. With this way you can easly use your prefered `Log Collector` to collect the logs produce by the service and insert them in your Log Storage.


At Jobteaser we use the **ElasticStack**. All the service log is collected by **FileBeat** and we use **Kibana** to visualize our Content Security Policy violations.

## State

This service is an experimentation we make at Jobteaser to improve the content securty policy violation tracking.

## HTTP API

### Check service helth [GET]

Request:
```
GET /ping
```

Response:
```
HTTP/1.1 200 OK
  Content-Type: text/plain
  Cache-Control: no-store
  Pragma: no-cache

  pong
```

### Create Report [POST]

Request:
```
POST /report
{
  "document-uri": "https://example.com/foo/bar",
  "referrer": "https://www.google.com/",
  "violated-directive": "default-src: self",
  "original-policy": "default-src self; report-uti /report",
  "blocked-uri": "http://foobar.com"
}
```

Response:
```
HTTP/1.1 200 OK
  Content-Type: text/plain
  Cache-Control: no-store
  Pragma: no-cache


```

```
HTTP/1.1 500 INTERNAL SERVER ERROR
  Content-Type: text/plain
  Cache-Control: no-store
  Pragme: no-cache


```

## Deploy

### Kubernetes

```sh
helm install jobteaser/csp-handler
```

### Docker

```sh
docker run -p 3000:3000 jobteaser/csp-handler:0.1.0 /csp-handler serve
```
