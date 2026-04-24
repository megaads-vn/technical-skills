PHP Coding Conventions
Folder
Ưu tiên đặt tên theo định dạng chuẩn của Framework
Chỉ dùng kebab-case hoặc UpperCamelCase
Đặt tên là một danh từ
Không viết tắt chỉ vì danh từ đó quá dài
/* Ví dụ */
    app/Services
    app/CustomerServices
    app/order-services
    app/categories
    app/utils
Resource file: image, media, css, js
Tên file viết thường: kebab-case
Đặt tên là một danh từ
Dùng gạch dưới ( _ ) cho các thuộc tính bổ sung
/* KHÔNG nên dùng */        
	Close-button.png
	close-button-hover.png
	close-button-hover-big.png
/* Nên dùng */
	close-button_hover_big.png
	close-button_small.png

Class
Ưu tiên đặt tên file Controller và Controller class theo định dạng chuẩn của Framework
Tên PHP Class và tên file viết theo định dạng UpperCamelCase
Đặt tên file và class giống nhau
Đặt tên class là một danh từ
/* Controller name */
	OrderController.php
/* Class name */
	class OrderController
Khoảng trắng (space)
1 tab = 4 space
Sử dụng 1 space ở:
Giữa các tham số trong phần khai báo hàm
Giữa danh sách tham số và dấu móc nhọn khai báo phạm vi hàm
Ở bất kỳ nơi nào có thể có sự phân tách: sau các ký tự :, =>, >, <, = , {
Function
Khai báo function
Ưu tiên đặt tên theo định dạng chuẩn của Framework
Đặt tên hàm là 1 động từ
Đặt tên định dạng lowerCamelCase
Tất cả tham số đặt trên cùng 1 dòng
Sử dụng 1 space giữa các tham số
Chú thích hàm và các tham số
/**
* Exporting user info to excel file
* @param array $headers Excel headers
* @param array|stdClass|Model $users Users to export
* @return DOMDocument DOM document object
*/
private function exportData($headers, $users) 
{
	/*...*/
}
Viết Chú thích cho function
/*
* Get the profile from a user
* @param {Integer} $id ID of user
* @param {Integer} $columns User profile properties
* @return {Object} User profile
*/
private function getUser($id, $columns) 
{
	//...
}
Sử dụng dấu đơn( ‘ ) cho String
/* KHÔNG nên dùng */
$str = "hello world";
$element = arr["hi"];

$name = ‘Liem’;
//$msg = "hello world $name";
$msg = ‘hello world’ . $name;

/* Nên dùng */
$str = 'hello world';
$element = arr['hi'];

Khai báo biến $item / $element để việc truy xuất phần tử trong mảng
/* KHÔNG nên dùng */
foreach ($users as $user) {
	/*...*/	
}
/* Nên dùng */
foreach ($users as $item) {
	/*...*/
}
Xứ lý theo nguyên tắc 1 đầu vào 1 đầu ra
/* KHÔNG nên dùng */
private function getUser($id, $columns) 
{
if ($id > 0) {
		return $userService->get($id, $columns);
} else {
		return new User();
   }
}

/* Nên dùng */
private function getUser($id, $columns) 
{
   $retval = null;
	  if ($id > 0) {
		$retval = $userService->get($id, $columns);
   }else{
		$retval = new User();
   }
   return $retval;
}
Câu điều kiện
xuống dòng ở mỗi mệnh đề nếu có từ 3 mệnh đề trở lên
sử dụng 1 space giữa các mệnh đề điều kiện và giữa từ khóa điều kiện (if, switch-case) với cụm mệnh đề
if (isset($this->users) && 
    count($this->users) > 0 &&
	   $isValid == TRUE) {
	/*...*/          
}

Truy xuất mảng có 3 phần từ trở lên thì xuống dòng ở mỗi phần tử
$params = array(
'idx' => 1, 
'rows' => 1, 
'cols' => 1
);

Truy xuất đối tướng có 3 phương thức trở lên thì xuống dòng ở mỗi phương thức
$user = new User();
$user->setName('Nguyen')->setAge(20)->setAddress('Hanoi');

Khuyến nghị sử dụng tối đa 30 dòng code trong 1 function
Khuyến nghị sử dụng tối đa 200 dòng code trong 1 Class

