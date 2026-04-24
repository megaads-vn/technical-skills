Git Flow guidelines


master/main → Nhánh sản phẩm chính (phiên bản ổn định, đã được kiểm thử đầy đủ, sẵn sàng phát hành)
hotfix/* → Nhánh sửa lỗi khẩn cấp trực tiếp trên main
release/* → Nhánh chuẩn bị phát hành, giúp kiểm soát các tính năng nào được đưa vào bản build dành cho khách hàng
develop → Nhánh phát triển chính (tổng hợp các tính năng đã hoàn thành, dùng để testing nội bộ)
feature/* → Nhánh cho từng tính năng riêng biệt
Commit Message conventions
Feature:
Mô tả: Commit này liên quan đến việc thêm một tính năng mới vào hệ thống.
Ví dụ: Feature: Add user authentication system
Fix:
Mô tả: Commit này được sử dụng khi sửa lỗi hoặc khắc phục sự cố.
Ví dụ: Fix: Resolve issue with form validation
Optimize:
Mô tả: Commit này liên quan đến việc tối ưu hóa mã nguồn hoặc hiệu suất hệ thống.
Ví dụ: Optimize: Improve image loading performance
Config:
Mô tả: Commit này liên quan đến việc thay đổi cấu hình hoặc thiết lập của dự án.
Ví dụ: Config: Update webpack configuration
UI:
Mô tả: Commit này liên quan đến thay đổi giao diện người dùng (UI) của hệ thống.
Ví dụ: UI: Update button styles on homepage
Doc:
Mô tả: Commit này dùng để chỉnh sửa tài liệu hoặc cập nhật hướng dẫn sử dụng.
Ví dụ: Doc: Update README with setup instructions
Chú ý:
Review lại từng dòng code, từng file code trước khi commit và chỉ commit những file cần thiết
Không commit các loại key, dữ liệu cần bảo mật
Không commit những config liên quan tới production, thay vì thế hãy commit Config.example, .env.example …

