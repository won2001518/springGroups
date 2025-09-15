<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>userInput.jsp</title>
  <style>
    th {
      background-color: #eee !important;
      text-align: center;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center m-3">User 등록하기</h2>
  <form method="post">
  <table class="table table-bordered">
    <tr>
      <th>아이디</th>
      <td><input type="text" name="mid" id="mid" class="form-control" autofocus required /></td>
    </tr>
    <tr>
      <th>성명</th>
      <td><input type="text" name="name" id="name" class="form-control" required /></td>
    </tr>
    <tr>
      <th>나이</th>
      <td><input type="number" name="age" id="age" value="20" class="form-control" /></td>
    </tr>
    <tr>
      <th>주소</th>
      <td><input type="text" name="address" id="address" class="form-control" /></td>
    </tr>
    <tr>
      <td colspan="2" class="text-center">
        <input type="submit" value="회원가입" class="btn btn-success" />
        <input type="reset" value="다시입력" class="btn btn-warning" />
        <input type="button" value="돌아가기" onclick="location.href='${ctp}/user2/userList';" class="btn btn-primary" />
      </td>
    </tr>
  </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>