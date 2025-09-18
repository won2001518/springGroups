<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>complaintList.jsp</title>
  <script>
    'use strict';
    
    // 신고내역 모달로 확인
    //function modalCheck(mid, title, content, nickName) {
    function modalCheck(mid, title, nickName) {
    	$("#myModal #modalMid").text(mid);
    	$("#myModal #modalTitle").text(title);
    	//$("#myModal #modalContent").html(content);
    	$("#myModal #modalNickName").text(nickName);
    }
    
    // 신고내역 처리(해제/감추기/삭제)
    function complaintProcess(idx, part, partIdx, complaintSw) {
    	let ans = '';
    	if(complaintSw == 'S') {
    		ans = confirm("현 게시물의 신고를 해제 하시겠습니까?");
    		if(!ans) return false;
    	}
    	else if(complaintSw == 'H') {
    		ans = confirm("현 게시물을 감출까요?");
    		if(!ans) return false;
    	}
    	else if(complaintSw == 'D') {
    		ans = confirm("현 게시물을 삭제할까요?");
    		if(!ans) return false;
    	}
    	
    	let query = {
    			idx        : idx,
    			part       : part,
    			partIdx    : partIdx,
    			complaintSw: complaintSw
    	}
    	
    	$.ajax({
    		url  : 'complaintProcess',
    		type : 'post',
    		data : query,
    		success:function(res) {
    			if(res != 0) {
    				alert("처리 완료되었습니다.");
    				location.reload();
    			}
    			else alert("처리 실패~~");
    		},
    		error : function() { alert("전송오류!!"); }
    	});
    }
  </script>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css">
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">신 고 리 스 트</h2>
  <table class="table table-hover text-center">
    <tr class="table-secondary">
      <th>번호</th>
      <th>분류</th>
      <th>글제목</th>
      <th>글쓴이</th>
      <th>신고자</th>
      <th>신고내역</th>
      <th>신고날짜</th>
      <th>진행상황</th>
    </tr>
    <c:set var="curScrStartNo" value="${fn:length(vos)}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td>${vo.part}</td>
        <td>
          <c:set var="content" value="${fn:replace(fn:replace(vo.content, CRLF, '<br/>'),LF, '<br/>')}"/>
          <%-- <a href="#" onclick="modalCheck('${vo.mid}','${vo.title}','${content}','${vo.nickName}')" data-bs-toggle='modal' data-bs-target='#myModal'>${vo.title}</a> --%>
          <a href="#" onclick="modalCheck('${vo.mid}','${vo.title}','${vo.nickName}')" data-bs-toggle='modal' data-bs-target='#myModal'>${vo.title}</a>
        </td>
        <td>
          <a href="complaintContent?partIdx=${vo.partIdx}">${vo.nickName}</a>
        </td>
        <td>${vo.cpMid}</td>
        <td>${vo.cpContent}</td>
        <td>${vo.cpDate}</td>
        <td>
          <c:if test="${vo.progress == '신고접수'}">
            <a href="javascript:complaintProcess('${vo.idx}','${vo.part}','${vo.partIdx}','S')" class="badge bg-primary">신고해제</a><br/>
            <a href="javascript:complaintProcess('${vo.idx}','${vo.part}','${vo.partIdx}','H')" class="badge bg-warning">감추기</a><br/>
            <a href="javascript:complaintProcess('${vo.idx}','${vo.part}','${vo.partIdx}','D')" class="badge bg-danger">삭제</a>
          </c:if>
          <c:if test="${vo.progress != '신고접수'}">${vo.progress}</c:if>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
</div>

<!-- 모달에 회원 상세정보 출력하기 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          작성자 아이디 : <span id="modalMid"></span><hr/>
          글제목 : <span id="modalTitle"></span><br/>
          글내용 : <span id="modalContent"></span><hr/>
          작성자 닉네임 : <span id="modalNickName"></span><br/>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>