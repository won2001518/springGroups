package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchString);

	int getTotRecCnt(String search, String searchString);

	int setBoardInput(BoardVO vo);

	BoardVO getBoardContent(int idx);

	void imgCheck(String content);

	void setReadNumPlus(int idx);

	void setGoodReadNumPlus(int idx);

	BoardVO getPreNextSearch(int idx, String str);

	void imgBackup(String content);

	int setBoardUpdate(BoardVO vo);

	void imgDelete(String content);

}
