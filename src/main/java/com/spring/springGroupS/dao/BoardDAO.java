package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.BoardVO;

public interface BoardDAO {

	List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	int getTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	int setBoardInput(@Param("vo") BoardVO vo);

	BoardVO getBoardContent(@Param("idx") int idx);

	void setReadNumPlus(@Param("idx") int idx);

	void setGoodReadNumPlus(@Param("idx") int idx);

	BoardVO getPreNextSearch(@Param("idx") int idx, @Param("str") String str);

	int setBoardUpdate(@Param("vo") BoardVO vo);

}
