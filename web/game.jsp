<%--
  Created by IntelliJ IDEA.
  User: razoriii
  Date: 28.02.14
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>JEE7 WebSocket Example</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="/websocket/favicon.ico">
    <style>
        #container {
            border: 1px #999999 solid;
            padding: 10px;
        }
        p.client {
            border-bottom: 1px aquamarine solid;
        }
        p.server {
            border-bottom: 1px crimson solid;
        }
        input {
            padding: 5px;
            width: 250px;
        }
        button {
            padding: 5px;
        }
    </style>
    <script>
        var chatClient = new WebSocket("ws://localhost:8080/game");

        chatClient.onmessage = function(evt) {
            var p = document.createElement("p");
            p.setAttribute("class", "server");
            p.innerHTML = "Server: " + evt.data;
            var container = document.getElementById("container");
            container.appendChild(p);
        }
        function send() {
            var input = document.getElementById("message");
            var p = document.createElement("p");
            p.setAttribute("class", "client");
            p.innerHTML = "Me: " + input.value;
            var container = document.getElementById("container");
            container.appendChild(p);
            chatClient.send(input.value);
            input.value = "";
        }
    </script>
</head>
<body>
<h1>JEE7 WebSocket Example</h1>
<div id="container">

</div>
<input type="text" id="message" name="message" />
<button type="button" id="send" onclick="send()">Send</button>
</body>
</html>