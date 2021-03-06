<%--
  Created by IntelliJ IDEA.
  Auth: razoriii
  Date: 26.02.14
  Time: 2:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.addHeader("Access-Control-Allow-Origin", "*");
    response.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
%>
<link rel="stylesheet" type="text/css" href="../styles/style.css"/>
<html>
<head>
    <title>TEST</title>
</head>
<script src="../js/utils/jquery.js"></script>
<script type="text/javascript">
    function sendRequest(login, password, action, expected_result) {
        var jsonObj = JSON.stringify({
            action: action,
            login: login,
            password: password
        });
//        alert(jsonObj);
        $.ajax({
            type: 'POST',
            async: false,
            url: $('#server').val(),
            data: jsonObj,
            success: function (data) {
                var test_ans = $('#test_ans');
                var data_text = ' | ' + action + ' | ' + login + ' | ' + password + ' | Result: ' + data.result +
                                ' Expected: ' + expected_result + ' | ' + data.sid + '</div>';
                if (data.result == expected_result) {
                    test_ans.html(test_ans.html() + '<div class="test_div">OK!' + data_text);
                } else {
                    test_ans.html(test_ans.html() + '<div class="test_div">FAIL!' + data_text);
                }
            }
//            contentType: 'application/json',
//            mimeType: 'application/json',
//            dataType: 'json'
        });
    }

    function buttonClicked() {
        document.title = 'Running';

        sendRequest('test', '123', 'register', 'badPassword');
        sendRequest('test', '123123', 'login', 'invalidCredentials');
        sendRequest('', '123123', 'register', 'badLogin');
        sendRequest('', '', 'register', 'badLogin');
        sendRequest('test', '', 'register', 'badPassword');
        sendRequest('test$%', '123123', 'register', 'badLogin');
        sendRequest('testacc', '123123', 'login', 'invalidCredentials');
        sendRequest('testacc', '123123', 'register', 'ok');
        sendRequest('testacc', '123123', 'register', 'loginExists');
        sendRequest('testacc', '0000000', 'login', 'invalidCredentials');
        sendRequest('testacc', '123123', 'login', 'ok');

        document.title = 'Done';
    }
</script>
<body>
<div class="test_div">
    <label for="server">Сервер:</label>
    <input id="server" value="doaction.jsp" /><br/>
    <button class="button green" id="btn_tests" onclick="buttonClicked();">Начать тестирование</button>
    <button class="button red" onclick="$('#test_ans').text('');">Очистить</button>
</div>
<div id="test_ans" class="test_div">

</div>
</body>
</html>
