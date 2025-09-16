<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>boardUpdate.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">게시판 글 수정하기</h2>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>글쓴이</th>
        <td><input type="text" name="nickName" id="nickName" value="${sNickName}" readonly class="form-control"/></td>
      </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" id="title" value="${vo.title}" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea rows="6" name="content" id="CKEDITOR" required class="form-control">${vo.content}</textarea>
          <script>
            CKEDITOR.replace("content", {
            	height:480,
            	filebrowserUploadUrl:"${ctp}/imageUpload",
            	uploadUrl:"${ctp}/imageUpload"
            });
          </script>
        </td>
      </tr>
      <tr>
        <th>공개여부</th>
        <td>
          <input type="radio" name="openSw" id="openSw1" ${vo.openSw=='OK' ? 'checked' : ''} value="OK" /> 공개 &nbsp;
          <input type="radio" name="openSw" id="openSw2" ${vo.openSw=='NO' ? 'checked' : ''} value="NO" /> 비공개
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="글수정하기" class="btn btn-success me-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
          <input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>