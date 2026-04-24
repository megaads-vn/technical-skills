
Table
Mặc định dùng engine type = InnoDB
Mặc định dùng encoding = UTF-8 Unicode(utf8mb4)
Mặc định dùng Collation = utf8mb4_general_ci
Đặt tên:
Đặt tên là 1 danh từ số ít
Chỉ dùng snake_case
Không viết tắt chỉ vì danh từ quá dài
Đặt tên cho bảng dữ liệu quan hệ theo định dạng: table1_n_table2

		 product_n_warehouse
Column

Đặt tên:
Đặt tên là 1 danh từ số ít
Chỉ dùng snake_case
Không viết tắt chỉ vì danh từ quá dài
Các cột ngày tháng đặt data type = DATETIME
Các cột Boolean đặt data type = TINYINT(1)
Các cột Trạng thái đặt data type = ENUM (ACTIVE=>1, BLOCK=>2, PENDING=>0)
Hạn chế dùng data type = TEXT nếu không cần thiết, dùng varchar(20), xác định rõ length
Các column bắt buộc:
id
created_at / create_time
updated_at / update_time
