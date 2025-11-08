# Dự án Ứng dụng Hỗ trợ Sức khỏe Tinh thần (Mental Health Support App)

Đây là kho lưu trữ (repository) cho dự án nghiên cứu khoa học, phát triển một ứng dụng di động nhằm hỗ trợ người dùng Việt Nam nhận diện, theo dõi và cải thiện các vấn đề sức khỏe tinh thần .

Ứng dụng tập trung vào bốn vấn đề phổ biến nhất hiện nay: **Stress mãn tính, rối loạn lo âu, trầm cảm nhẹ, và rối loạn giấc ngủ** .

![Mô tả animation](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHV6czNkajEyNnN1cGgzcTR4aDl6bmRibjhqYXBxeW1xenVtZ2l5bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jXtdnZlhK7Fbfo4Ioc/giphy.gif)

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

## 🎯 Tính năng Chính (Dự kiến)

Dưới đây là các module chức năng dự kiến của ứng dụng .

### Module 1: Bắt Đầu (Đánh giá & Cá nhân hóa) 

Mục tiêu là giúp người dùng tự đánh giá tình trạng ban đầu và cá nhân hóa lộ trình chăm sóc .

* **A1: Bài kiểm tra đầu vào:** Bộ câu hỏi khoa học (GAD, PHQ-9, ISI, thang stress) .
* **A2: Phân tích kết quả:** Gán mức độ (nhẹ – trung bình – nặng) cho từng triệu chứng .
* **A3: Đề xuất kế hoạch hành động:** Gợi ý lộ trình chăm sóc (lối sống, kỹ năng) .
* **A4: Giao diện cá nhân hóa:** Trang tổng quan hiển thị "hành trình sức khỏe tinh thần" .

### Module 2: Xây dựng Lối sống Khoa học 

Tập trung vào 4 trụ cột: giấc ngủ, dinh dưỡng, vận động, và sức bền tâm lý .

* **B1: Theo dõi Giấc ngủ:** Nhật ký giấc ngủ, checklist vệ sinh giấc ngủ .
* **B2: Theo dõi Dinh dưỡng:** Nhật ký món ăn, gợi ý công thức "chống viêm" .
* **B3: Theo dõi Vận động:** Ghi lại số bước, thời gian tập, mục tiêu hàng tuần .
* **B4: Xây dựng Sức bền Tâm lý:** Nhật ký biết ơn .

### Module 3: Luyện tập Kỹ năng (Tự trợ giúp) 

Cung cấp công cụ "tự trợ giúp có hướng dẫn" để ứng phó với căng thẳng, lo âu .

* **C1: Chánh niệm & Thiền:** Bộ sưu tập audio thiền có hướng dẫn (3-10 phút), body scan .
* **C2: Bài tập Hít thở:** Công cụ tương tác (ví dụ: thở hộp 4-4-4-4) .
* **C3: Nhật ký Nhận thức (CBT Diary):** Ghi lại tình huống – suy nghĩ – cảm xúc – phản biện .

### Module 4: Kết nối (Phát triển sau) 

Kết nối người dùng với kiến thức, cộng đồng, và chuyên gia .

* **D1: Góc Kiến thức:** Bài viết ngắn, video, infographic về tâm lý .
* **D2: Danh bạ Chuyên gia:** (Cung cấp danh bạ chuyên gia) .
* **D3: Đánh giá Khi nào cần giúp đỡ:** (Cung cấp bộ đánh giá chuyên sâu) .

## 🤖 Tích hợp Trí tuệ Nhân tạo (AI)

AI là một phần cốt lõi của dự án, được dự kiến tích hợp để:

* **Thu thập thông tin & Đánh giá:** AI chatbot trò chuyện (A1) và tự động đánh giá xu hướng (A2) .
* **Cá nhân hóa:** AI Recommendation System (A3) và giao diện người dùng thích ứng (A4) .
* **Phân tích Dữ liệu:** Phân tích chất lượng giấc ngủ (B1) , AI Vision nhận diện món ăn (B2) , và phát hiện mô thức suy nghĩ tiêu cực (C3) .
* **Hỗ trợ:** AI được huấn luyện dữ liệu chuyên gia để trò chuyện trực tiếp (D2) .

## 💻 Công nghệ (Giai đoạn 1)

Các công nghệ dự kiến sử dụng cho giai đoạn 1 :

* **Ứng dụng (Mobile App):** Flutter 
* **Back-end:** (Chưa xác định) 
* **Database:** PostgreSQL 

## 🗺️ Lộ trình Phát triển

* **Giai đoạn 1:** Xây dựng các chức năng cơ bản (không tích hợp AI) và nắm vững công nghệ .
* **Giai đoạn 2:** Review, tái cấu trúc để bám sát phương pháp khoa học và triển khai thử nghiệm lấy feedback .
* **Giai đoạn 3:** Tích hợp và triển khai AI vào ứng dụng .
* **Giai đoạn 4:** Tích hợp API của các thiết bị đeo (wearable devices) .
