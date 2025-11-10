# Dự án Ứng dụng Hỗ trợ Sức khỏe Tinh thần (Mental Health Support App)

Đây là kho lưu trữ (repository) cho dự án nghiên cứu khoa học, phát triển một ứng dụng di động nhằm hỗ trợ người dùng Việt Nam nhận diện, theo dõi và cải thiện các vấn đề sức khỏe tinh thần .

Ứng dụng tập trung vào bốn vấn đề phổ biến nhất hiện nay: **Stress mãn tính, rối loạn lo âu, trầm cảm nhẹ, và rối loạn giấc ngủ** .

![Mô tả animation](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHV6czNkajEyNnN1cGgzcTR4aDl6bmRibjhqYXBxeW1xenVtZ2l5bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jXtdnZlhK7Fbfo4Ioc/giphy.gif)

## 🏷️ Quy Tắc Đặt Tên Nhánh Trong Dự Án Này:
| Loại thay đổi | Khi nào dùng | Ví dụ cụ thể |
|----------------|--------------|---------------|
| **feat/** (Feature) | Khi việc setup đó **trực tiếp tạo ra một tính năng mới** cho app. | `feat(firebase): add Firebase Authentication` → vì thêm tính năng đăng nhập. |
| **chore/** (Chore) | Khi setup **chỉ phục vụ môi trường, build, hay cấu hình kỹ thuật**, không làm thay đổi hành vi app. | `chore(firebase): configure Firebase SDK` → chỉ setup SDK, chưa tạo feature nào. |
| **fix/** (Bugfix) | Khi **sửa lỗi trong cấu hình hoặc môi trường** khiến app không chạy. | `fix(firebase): correct wrong project ID in config` |
| **refactor/** (Refactoring) | Khi **tái cấu trúc code setup** (chẳng hạn chia nhỏ file config). | `refactor(firebase): split config into separate env files` |
| **style/** (Style) | Nếu chỉ **sửa format** (ví dụ: re-indent file `.firebaserc`). | `style(firebase): format config file` |
| **test/** (Test) | Nếu **thêm/sửa test** để kiểm tra việc kết nối hoặc logic liên quan. | `test(firebase): add integration test for Firestore service` |

## 📈 Bối cảnh & Thị trường

* **Thị trường quốc tế:** Đã có các ứng dụng lớn như Calm, Headspace .
* **Nguồn cảm hứng:** Ứng dụng **Rootd**, tập trung vào hỗ trợ chứng hoảng sợ và lo âu .
* **Thị trường Việt Nam:** Các ứng dụng hỗ trợ bằng Tiếng Việt hiện còn rất ít và chất lượng chưa cao, cho thấy nhu cầu lớn từ người dùng .

## 🔬 Nền tảng Khoa học

Phương pháp luận của ứng dụng được xây dựng dựa trên các liệu pháp đã được khoa học chứng minh hiệu quả :

* **CBT (Cognitive Behavioral Therapy):** Liệu pháp nhận thức – hành vi .
* **MBSR (Mindfulness-Based Stress Reduction):** Giảm stress dựa trên chánh niệm .
* **CBT-I (Cognitive Behavioral Therapy for Insomnia):** Can thiệp nhận thức – hành vi cho mất ngủ .

Luồng hoạt động cốt lõi của ứng dụng tuân theo 5 bước: **Đánh giá -> Cá nhân hóa -> Theo dõi -> Tự trợ giúp -> Hỗ trợ chuyên gia** .

