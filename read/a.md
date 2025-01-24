## 1. backup docker image
```html
docker pull tanluongdoan/docs-astrojs:v5-2025-01-24
```
```html
docker images
```
- tạo file backup
```html
docker save -o docs-astrojs-v5-2025-01-24.tar tanluongdoan/docs-astrojs:v5-2025-01-24
```
- Giả sử file backup của bạn tên là backup.tar. Chạy lệnh sau để load image từ file:
```html 
docker load < backup.tar
```
