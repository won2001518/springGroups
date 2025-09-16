package com.spring.springGroupS.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.PageVO;

@Service
public class Pagination {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;

	public PageVO pagination(PageVO pageVO) {
		int pag = pageVO.getPag() == 0 ? 1 : pageVO.getPag();
		int pageSize = pageVO.getPageSize() == 0 ? 10 : pageVO.getPageSize();
		
		int totRecCnt = 0;
		if(pageVO.getSection().equals("board")) {
			if(pageVO.getSearch() == null) totRecCnt = boardService.getTotRecCnt("","");
			else totRecCnt = boardService.getTotRecCnt(pageVO.getSearch(), pageVO.getSearchString());
		}
		else if(pageVO.getSection().equals("member")) {
			totRecCnt = memberService.getTotRecCnt();
		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
	
		//System.out.println("pageVO : " + pageVO);
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotPage(totPage);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);

		pageVO.setSearch(pageVO.getSearch());
		pageVO.setSearchString(pageVO.getSearchString());
		
		pageVO.setPart(pageVO.getPart());
		
		return pageVO;
	}
}
