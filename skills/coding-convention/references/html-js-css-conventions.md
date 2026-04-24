Tài liệu được xây dựng dựa vào Google HTML/CSS Style Guide, GitHub CSS Styleguide , Google JavaScript Style Guide
Quy định chung

Resource file: image, media, css, js
Đặt tên là một danh từ, dùng kebab-case
Dùng gạch dưới ( _ ) cho các thuộc tính bổ sung
/* KHÔNG nên dùng */        
	close-button-hover-big.png
/* Nên dùng */
	close-button_hover_big.png
Sử dụng 1 tab (4 space) khoảng trắng thụt vào trong quy cách căn lề mỗi dòng
        
	<ul>
          <li>Fantastic</li>
          <li>Great</li>
       </ul>

        .example {
            color: blue;
        }         
Chỉ dùng kebab-case cho: tên thẻ, thuộc tính, giá trị thuộc tính (ngoại trừ text/CDATA) của phần tử HTML, và tên, thuộc tính, giá trị thuộc tính của CSS selector (ngoại trừ chuỗi ký tự)
        
	<!-- Không nên dùng -->
        <A HREF="/">Home</A>

        <!-- Nên dùng -->
        <a href="/" parent-name="menu-list"></a>

        /* Không nên dùng */
        color: #E5E5E5;

        /* Nên dùng */
        color: #e5e5e5;
Bỏ qua giao thức trong các đường dẫn http, https
        
	<!-- Không nên dùng -->
        <script src="http://www.google.com/js/gweb/analytics/autotrack.js"></script>;

        <!-- Nên dùng -->
        <script src="//www.google.com/js/gweb/analytics/autotrack.js"></script>;

        /* Không nên dùng */
        .example {
          background: url(http://www.google.com/images/example);
        }

        /* Nên dùng */
        //TODO: doan nay anh Ha sẽ hoan thanh
        .example {
          background: url(//www.google.com/images/example);
        }     
Dùng comment để giải thích mã nguồn khi: mã nguồn phức tạp, nhiều thuật toán và đánh dấu công việc TODO
Quy định về viết mã HTML

Viết đầy đủ thẻ đóng và mở
Xuống dòng mới cho mọi block, list, hoặc table, và thụt vào cho mọi thẻ con của nó
        
	<ul>
          <li>Moe</li>
          <li>Larry</li>
          <li>Curly</li>
        </ul>

        <table>
          <thead>
            <tr>
              <th scope="col">Income<th> 
              <th scope="col">Taxes<th> 
          <tbody>
            <tr>
              <td>$ 5.00</td> 
              <td>$ 4.50</td> 
        </table>
Sử dụng dấu " để trích dẫn giá trị của thuộc tính
        
	<!-- KHÔNG nên dùng -->
        <a class='maia-button maia-button-secondary'>Sign in</a>

        <!-- Nên dùng -->
        <a class="maia-button maia-button-secondary">Sign in</a>


Các thuộc tính được sắp xếp lần lượt id, class, style, và các thuộc tính khác. 
        
	<!-- KHÔNG nên dùng -->
        <a style='color:red;' class='maia-button maia-button-secondary' id='my_id' >Sign in</a>

        <!-- Nên dùng -->
        
	<a id="my-id" class="maia-button maia-button-secondary" style="color:red;" is-abc="">Sign in</a>

Các attribute được Enter xuống dòng nếu có từ 2 attribute trở lên. Khi một thẻ HTML có nội dung thì Enter xuống dòng.
        <!-- KHÔNG nên dùng -->
        <a style=”color:red;” class=”maia-button maia-button-secondary” id=”my_id” >Sign in</a>

        <!-- Nên dùng -->
        <a id=”my-id” 
            class="maia-button maia-button-secondary" 
            style=”color:red;” >
          Sign in
        </a>

Các giá trị trong một thuộc tính phải dùng 1 space để phân biệt các cặp giá trị, biến và chuỗi.
        <!-- KHÔNG nên dùng -->
        <a style=”color:red;width:100px” data-out=”user.id+’,’+user.name” ></a>
        <!-- Nên dùng -->
        <a style=”color:red; width:100px” 
            data-out=”user.id + ’,’ + user.name”>
          Sign in
        </a>


Quy định viết mã CSS
Đặt 1 khoảng trắng sau dấu : trong khai báo thuộc tính
Đặt 1 khoảng trắng trước dấu { trong quy cách mã nguồn
Sử dụng mã hex cho màu sắc #000 hoặc sử dụng rgba ( dùng 3 ký tự giá trị màu khi có thể )
Luôn dùng dấu chấm hết câu lệnh ;
        // Đây là ví dụ tốt!
        .styleguide-format {
           border: 1px solid #0f0;
           color: #000;
           background: rgba(0,0,0,0.5);
        }
Sử dụng thuộc tính rút gọn khi có thể
         /* Không nên dùng */

         border-top-style: none;
         font-family: palatino, georgia, serif;
         font-size: 100%;
         line-height: 1.6;
         padding-bottom: 2em;
         padding-left: 1em;
         padding-right: 1em;
         padding-top: 0;

         /* Nên dùng */

         border-top: 0;
         font: 100%/1.6 palatino, georgia, serif;
         padding: 0 1em 2em;

Chỉ sử dụng ID với phần tử xuất hiện duy nhất trong trang và chắc chắn là nên dùng, còn nếu không chắc chắn thì sử dụng class
Các phần tử có thể dùng ids: header, footer, modal
Các phần tử không nên dùng ids: navigation, list v.v.
Chia tách các khai báo và selectors bằng một dòng mới
        /* Không nên dùng */
        
        a:focus, a:active {
          position: relative; top: 1px;
        }

        /* Nên dùng */

        h1,
        h2,
        h3 {
          font-weight: normal;
          line-height: 1.2;
        }
Dùng dấu trích dẫn ' cho các thuộc tính hoặc giá trị thuộc tính của selectors
Không dùng trích dẫn cho giá trị của URI (url())
        /* Không nên dùng */
        @import url("//www.google.com/css/maia.css");

        html {
          font-family: "open sans", arial, sans-serif;
        }
        /* Nên dùng */
        @import url(//www.google.com/css/maia.css);

        html {
          font-family: 'open sans', arial, sans-serif;
        }
Quy cách đặt tên lớp
Đặt tên lớp là một Danh từ
Dùng - để phân tách từ trong tên lớp, tạo một tên lớp hoặc tên của sub-module
Dùng -- cho modifier
Dùng tiền tố is- cho các lớp thay đổi trạng thái mà được dùng để tương tác giữa JS và HTML
Dùng tiền tố js- cho các lớp chỉ nằm trong file JS
        /* Lớp Component/Module */
        .button-group { }

        /* Modifier ( biến đổi .button bằng cách thêm hoặc ghi đè các giá trị thuộc tính vào lớp component/module) */
        .button--primary { }

        /* Lớp layout */
        .l-header { }

        /* Lớp trạng thái */
        .is-state-type

        /* Lớp nằm trong file js */
        .js-action-name

Quy định viết code Javascript

Tên biến đặt kiểu lowerCamel
Dùng CONSTANT_VALUE cho biến kiểu constant
Luôn dùng dấu chấm phảy ; để kết thúc câu lệnh
Luôn khai báo var / let trước một biến khi không xác định được biến đó từ đâu
Các giá trị được coi là false trong boolean
null
undefined
'' the empty string
0 the number
Khai báo hàm
Ưu tiên đặt tên theo định dạng chuẩn của Framework
Đặt tên hàm là 1 động từ
Đặt tên định dạng lowerCamelCase
Tất cả tham số đặt trên cùng 1 dòng
Sử dụng 1 space giữa các tham số
Chú thích hàm và các tham số
Sử dụng 1 space ở:
Giữa các tham số trong phần khai báo hàm
Giữa danh sách tham số và dấu móc nhọn khai báo phạm vi hàm
Ở bất kỳ nơi nào có thể có sự phân tách  hoặc các phép toán: sau các ký tự :, =>, >, <, = , {
function getClassName(code, classId) {
    if (code == "1000") {
    }
};

Comment cho class và method
/**
 * The class makes something fun and easy.
 * @param {string} arg1 An argument that makes this more interesting.
 * @param {Array.<number>} arg2 List of numbers to be processed.
 * @constructor
 * @extends {goog.Disposable}
 * @return {int} Return class id
 */
var MyClass = function(arg1, arg2) {
    // ...
};
Áp dụng nguyên tắc 1 đầu vào và 1 đầu ra duy nhất khi viết hàm xử lý
function getUser(code, columns) {
    var retval = null;
    if (id > 0) {
        retval = user[code];
    } else {
        retval = new User();
    }
    return retval;

Sử dụng tối đa 30 dòng code trong 1 function
Những tiêu chuẩn
UX: 
Thân thiện với người dùng: rõ rảng, giảm thiểu thao tác: clicks, move
Thân thiện với SEO
Check box label
Search on Enter pressing
Only one H1 tag
Meta tags: title, description, keyword
Image Fitting
Empty list message
Focus into text-box , Focus an input after opening form
Cursor: pointer...
Single language
