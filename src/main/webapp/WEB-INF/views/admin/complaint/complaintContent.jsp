<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>complaintContent.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>상세보기</h2>
  <h4>${vo.title}</h4>
  <hr/>
  <div>
    글쓴이 : ${vo.mid}
  </div>
  <hr/>
  <div>
    ${vo.content}
  </div>
  <hr/>
  <div><a href="javascript:history.back()" class="btn btn-success">돌아가기</a></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>