<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>boardContent.jsp</title>
  <script>
    'use strict';
  
    // 좋아요 처리(중복 불허)
    function goodCheck() {
    	$.ajax({
    		url  : 'boardGoodCheck',
    		type : 'post',
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != 0) location.reload();
    			else alert("이미 좋아요를 클릭하셨습니다.");
    		},
    		error : function() { alert("전송오류!!"); }
    	});
    }
  
    // 좋아요(따봉) 처리(중복 허용)
    function goodCheckPlus() {
    	$.ajax({
    		url  : 'BoardGoodCheckPlusMinus.bo',
    		type : 'post',
    		data : {
    			idx : ${vo.idx},
    			gooCnt : 1
    		},
    		success:function(res) {
    			if(res != '0') location.reload();
    		},
    		error : function() { alert("전송오류!!"); }
    	});
    }
  
    // 싫어요 처리(중복 허용)
    function goodCheckMinus() {
    	$.ajax({
    		url  : 'BoardGoodCheckPlusMinus.bo',
    		type : 'post',
    		data : {
    			idx : ${vo.idx},
    			gooCnt : -1
    		},
    		success:function(res) {
    			if(res != '0') location.reload();
    		},
    		error : function() { alert("전송오류!!"); }
    	});
    }
    
    // 게시글 삭제처리
    function deleteCheck() {
    	let ans = confirm("현재 게시글을 삭제하시겠습니까?");
    	if(ans) location.href = "boardDelete?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
    }
    
    // 원본글에 댓글 저장하기(부모댓글)
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert('댓글을 입력하세요');
    		return false;
    	}
    	// replySw는 원본글의 댓글에서 전송하는것을 알림
    	let query = {
    			replySw   : 1,
    			board2Idx : ${vo.idx},
    			mid       : '${sMid}',
    			nickName  : '${sNickName}',
    			hostIp    : '${pageContext.request.remoteAddr}',
    			content   : content
    	}
    	
    	$.ajax({
    		url  : 'boardReplyInput',
    		type : 'post',
    		data : query,
    		success:function(res) {
    			if(res != 0) {
    				alert('댓글이 입력되었습니다.');
    				location.reload();
    			}
    			else alert("댓글 입력 실패~~");
    		},
    		error : function() { alert("전송오류!!"); }
    	});
    }
    
    // 댓글 삭제처리
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "boardReplyDelete",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != 0) {
    				alert('댓글이 삭제되었습니다.');
    				location.reload();
    			}
    			else alert("댓글 삭제 실패~~");
    		},
    		error : function() { alert("전송오류!!"); }
    	});
    }
    
    // 댓글 수정창 모두 닫기(처음 폼이 로드될때)
    $(function() {
    	$(".replyInnerContent").hide();
    	$(".replyCloseBtnCheck").hide();
    });
    
		// 댓글 수정버튼(√) 클릭시 해당 댓글의 수정창 보여주기
		function replyUpdate(idx) {
			$(".replyInnerContent").hide();
			$("#demo"+idx).show();
		}
		
		// 댓글 수정창에서 '댓글수정'버튼 클릭시에 수행
		function replyUpdateOk(idx) {
			let content = $("#replyUpdateContent"+idx).val();
			let query = {
					idx     : idx,
					content : content
			}
			
			$.ajax({
	    		url  : "BoardReplyUpdateOk.bo",
	    		type : "post",
	    		data : query,
	    		success:function(res) {
	    			if(res != '0') {
	    				alert('댓글이 수정되었습니다.');
	    				location.reload();
	    			}
	    			else alert("댓글 수정 실패~~");
	    		},
	    		error : function() { alert("전송오류!!"); }
	    	});
		}
		
		// 대댓글 입력버튼 클릭시 입력박스 보여주기
		function replyShow(idx) {
			$(".replyBoxContent").hide();
			$("#replyShowBtn"+idx).hide();
			$("#replyCloseBtn"+idx).show();
			$("#replyDemo"+idx).show();
		}
		
		// 대댓글 닫기버튼 클릭시 댓글박스 닫기
		function replyClose(idx) {
			$("#replyShowBtn"+idx).show();
			$("#replyCloseBtn"+idx).hide();
			$("#replyDemo"+idx).hide();
		}
		
		// 대댓글(부모댓글의 답변글)의 입력처리
		function replyInputOk(idx, re_step, re_order) {
			let content = $("#replyInputContent"+idx).val();
			if(content.trim() == "") {
				alert("답변글을 입력하세요");
				$("replyInputContent"+idx).focus();
				return false;
			}
			
			let query = {
					board2Idx : ${vo.idx},
					ref       : ${vo.idx},
					re_step   : re_step,
					re_order  : re_order,
					mid       : '${sMid}',
					nickName  : '${sNickName}',
					hostIp    : '${pageContext.request.remoteAddr}',
					content   : content
			}
			$.ajax({
				url   : '${ctp}/board/boardReplyInputOk',
				type  : 'post',
				data  : query,
				success: (res) => {
					if(res != 0) {
						alert("답변글이 입력되었습니다.");
						location.reload();
					}
					else alert("답변글 입력 실패~~");
				},
				error : () => alert("전송오류")
			});
		}
  </script>
  <style>
    th {
      background-color: #eee !important;
      text-align: center;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-3">글 내 용 보 기</h2>
  <table class="table table-bordered m-0 p-0">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate,0,19)}</td>
    </tr>
    <tr>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${vo.title}
        (<a href="javascript:goodCheck()" class="text-decoration-none" title="좋아요">좋아요 :
            <c:if test="${!fn:contains(sContentIdx, 'boardGood'+=vo.idx)}">♥</c:if>
            <c:if test="${fn:contains(sContentIdx, 'boardGood'+=vo.idx)}"><font color='red'>♥</font></c:if>
         </a> : ${vo.good})
        /
        <a href="javascript:goodCheckPlus()" class="text-decoration-none" title="좋아요">👍</a>
        <a href="javascript:goodCheckMinus()" class="text-decoration-none" title="싫어요">👎</a>
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:230px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
  </table>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td class="text-start">${pageVO.boardFlag}||||
        <c:if test="${boardFlag == 'search'}"><input type="button" value="돌아가기" onclick="location.href='boardSearchList?search=${search}&searchString=${searchString}';" class="btn btn-success" /></c:if>
        <c:if test="${boardFlag != 'search'}"><input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-success" /></c:if>
      </td>
      <td class="text-end">
        <c:if test="${sMid == vo.mid || sAdmin == 'adminOK'}">
          <c:if test="${sMid == vo.mid}">
	        	<input type="button" value="수정" onclick="location.href='boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning" />
	        </c:if>
	        <input type="button" value="삭제" onclick="deleteCheck()" class="btn btn-danger" />
        </c:if>
      </td>
    </tr>
  </table>
  <hr/>
  <!-- 이전글/다음글 -->
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td class="m-0 p-0">
        <c:if test="${!empty nextVO.title}">
	        👆 <a href="boardContent?idx=${nextVO.idx}&pag=${pag}&pageSize=${pageSize}" class="text-decoration-none">다음글 : ${nextVO.title}</a>
        </c:if>
      </td>
    </tr>
    <tr>
      <td class="m-0 p-0">
        <c:if test="${!empty preVO.title}">
        	👇 <a href="boardContent?idx=${preVO.idx}&pag=${pag}&pageSize=${pageSize}" class="text-decoration-none">이전글 : ${preVO.title}</a>
        </c:if>
      </td>
    </tr>
  </table>
  <br/>
  
  <!-- 댓글 처리(리스트/입력) 시작 -->
  <!-- 댓글 리스트 -->
  <table class="table table-hover text-center">
    <tr>
      <th class="text-start"> &nbsp;&nbsp; 작성자</th>
      <th class="text-start ps-3"> 댓글내용</th>
      <th>댓글일자</th>
      <th>댓글IP</th>
      <th>답글</th>
    </tr>
    <c:forEach var="replyVO" items="${replyVos}" varStatus="st">
      <tr>
        <td class="text-start">
          <c:if test="${replyVO.re_step > 1}">
            <c:forEach var="i" begin="1" end="${replyVO.re_step}"> &nbsp;&nbsp;</c:forEach> └▶
          </c:if>
          ${replyVO.nickName}
          <c:if test="${sMid == replyVO.mid}">
          	(
          	<a href="javascript:replyUpdate(${replyVO.idx})" title="댓글수정" class="text-decoration-none">√</a>,
          	<a href="javascript:replyDelete(${replyVO.idx})" title="댓글삭제" class="text-decoration-none">x</a>
          	)
          </c:if>
        </td>
        <td class="text-start">${fn:replace(replyVO.content, newLine, "<br/>")}</td>
        <td>${fn:substring(replyVO.WDate,0,16)}</td>
        <td>${replyVO.hostIp}</td>
        <td>
          <a href="javascript:replyShow(${replyVO.idx})"  id="replyShowBtn${replyVO.idx}"  class="badge bg-success text-decoration-none">답글</a>
          <a href="javascript:replyClose(${replyVO.idx})" id="replyCloseBtn${replyVO.idx}" class="badge bg-warning text-decoration-none replyCloseBtnCheck">닫기</a>
        </td>
      </tr>
      <tr id="replyDemo${replyVO.idx}" class="replyBoxContent" style="display:none">
        <td colspan="5" class="text-center ps-5 pe-4 pt-1 pb-1">
          <form>
            <div class="input-group">
              <textarea rows="2" name="replyInputContent" id="replyInputContent${replyVO.idx}" class="form-control"></textarea>
              <input type="button" value="댓글입력" onclick="replyInputOk(${replyVO.idx},${replyVO.re_step},${replyVO.re_order})" class="btn btn-success btn-sm"/>
            </div>
          </form>
        </td>
      </tr>
      <tr id="demo${replyVO.idx}" class="replyInnerContent">
        <td colspan="5" class="text-center ps-5 pe-4 pt-1 pb-1">
          <form>
            <div class="input-group">
              <textarea rows="2" name="replyUpdateContent" id="replyUpdateContent${replyVO.idx}" class="form-control">${replyVO.content}</textarea>
              <input type="button" value="댓글수정" onclick="replyUpdateOk(${replyVO.idx})" class="btn btn-success btn-sm"/>
            </div>
          </form>
        </td>
      </tr>
    </c:forEach>
  </table>
  <!-- 댓글 입력폼 -->
  <form name="replyForm">
    <table class="table table-center">
      <tr>
        <td style="width:85%" class="text-start">
          글내용 :
          <textarea rows="4" name="content" id="content" class="form-control"></textarea>
        </td>
        <td style="width:15%">
          <br/>
          <p>작성자 :<br/> ${sNickName}</p>
          <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
        </td>
      </tr>
    </table>
  </form>
  <!-- 댓글 처리(리스트/입력) 끝 -->
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>