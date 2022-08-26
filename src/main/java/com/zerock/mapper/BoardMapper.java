package com.zerock.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;

import com.zerock.domain.BoardVO;
import com.zerock.domain.CommentVO;
import com.zerock.domain.Criteria;
import com.zerock.domain.MemberVO;

public interface BoardMapper {
	//board
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	//post password check
	public int passwdChk(@Param("bno") Long bno,@Param("passwd") String passwd);
	//member
	//member insert
	public void minsert(MemberVO member);
	
	public int idChek(MemberVO member);
	
	public String loginCheck(MemberVO member);
	//comment
	public int cdel(Long cno);
	
	public List<CommentVO> cSelect(Long bno);
	
	public void cInsert(CommentVO comment);
	
	public MemberVO viewMember(String idinfo);
	
	public int cbdel(Long bno);
	//paging
	public int getTotalCount(Criteria cri);
}
